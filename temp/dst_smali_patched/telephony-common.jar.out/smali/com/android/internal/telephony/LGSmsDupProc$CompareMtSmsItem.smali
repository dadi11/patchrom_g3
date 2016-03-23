.class Lcom/android/internal/telephony/LGSmsDupProc$CompareMtSmsItem;
.super Ljava/lang/Object;
.source "LGSmsDupProc.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/LGSmsDupProc;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "CompareMtSmsItem"
.end annotation


# instance fields
.field address:Ljava/lang/String;

.field body:Ljava/lang/String;

.field messageId:I

.field final synthetic this$0:Lcom/android/internal/telephony/LGSmsDupProc;

.field timeStamp:J


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/LGSmsDupProc;JLjava/lang/String;ILjava/lang/String;)V
    .locals 4
    .param p2, "timeStamp"    # J
    .param p4, "address"    # Ljava/lang/String;
    .param p5, "messageId"    # I
    .param p6, "body"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    iput-object p1, p0, Lcom/android/internal/telephony/LGSmsDupProc$CompareMtSmsItem;->this$0:Lcom/android/internal/telephony/LGSmsDupProc;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/android/internal/telephony/LGSmsDupProc$CompareMtSmsItem;->timeStamp:J

    iput-object v2, p0, Lcom/android/internal/telephony/LGSmsDupProc$CompareMtSmsItem;->address:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lcom/android/internal/telephony/LGSmsDupProc$CompareMtSmsItem;->messageId:I

    iput-object v2, p0, Lcom/android/internal/telephony/LGSmsDupProc$CompareMtSmsItem;->body:Ljava/lang/String;

    iput-wide p2, p0, Lcom/android/internal/telephony/LGSmsDupProc$CompareMtSmsItem;->timeStamp:J

    iput-object p4, p0, Lcom/android/internal/telephony/LGSmsDupProc$CompareMtSmsItem;->address:Ljava/lang/String;

    iput p5, p0, Lcom/android/internal/telephony/LGSmsDupProc$CompareMtSmsItem;->messageId:I

    iput-object p6, p0, Lcom/android/internal/telephony/LGSmsDupProc$CompareMtSmsItem;->body:Ljava/lang/String;

    return-void
.end method
