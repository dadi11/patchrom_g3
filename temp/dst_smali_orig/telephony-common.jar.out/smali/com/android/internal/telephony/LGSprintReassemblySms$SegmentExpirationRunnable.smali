.class Lcom/android/internal/telephony/LGSprintReassemblySms$SegmentExpirationRunnable;
.super Ljava/lang/Object;
.source "LGSprintReassemblySms.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/LGSprintReassemblySms;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "SegmentExpirationRunnable"
.end annotation


# instance fields
.field private address:Ljava/lang/String;

.field private mFirstTime:J

.field final synthetic this$0:Lcom/android/internal/telephony/LGSprintReassemblySms;


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/LGSprintReassemblySms;Lcom/android/internal/telephony/SmsMessageBase;J)V
    .locals 3
    .param p2, "sms"    # Lcom/android/internal/telephony/SmsMessageBase;
    .param p3, "firstTime"    # J

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/LGSprintReassemblySms$SegmentExpirationRunnable;->this$0:Lcom/android/internal/telephony/LGSprintReassemblySms;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p2}, Lcom/android/internal/telephony/SmsMessageBase;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v0

    .local v0, "originatingAddress":Ljava/lang/String;
    if-eqz v0, :cond_0

    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    iput-object v1, p0, Lcom/android/internal/telephony/LGSprintReassemblySms$SegmentExpirationRunnable;->address:Ljava/lang/String;

    :cond_0
    iput-wide p3, p0, Lcom/android/internal/telephony/LGSprintReassemblySms$SegmentExpirationRunnable;->mFirstTime:J

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    const-wide/32 v2, 0x493e0

    :try_start_0
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "address ="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .local v1, "where":Ljava/lang/StringBuilder;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/LGSprintReassemblySms$SegmentExpirationRunnable;->address:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " AND "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "time ="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v2, p0, Lcom/android/internal/telephony/LGSprintReassemblySms$SegmentExpirationRunnable;->mFirstTime:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/android/internal/telephony/LGSprintReassemblySms$SegmentExpirationRunnable;->this$0:Lcom/android/internal/telephony/LGSprintReassemblySms;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    # invokes: Lcom/android/internal/telephony/LGSprintReassemblySms;->sendSavedPdusIndividually(Ljava/lang/String;)V
    invoke-static {v2, v3}, Lcom/android/internal/telephony/LGSprintReassemblySms;->access$000(Lcom/android/internal/telephony/LGSprintReassemblySms;Ljava/lang/String;)V

    return-void

    .end local v1    # "where":Ljava/lang/StringBuilder;
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/InterruptedException;
    const-string v2, "SegmentExpirationRunnable:run(), Thread Interrupted exception catch"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method
