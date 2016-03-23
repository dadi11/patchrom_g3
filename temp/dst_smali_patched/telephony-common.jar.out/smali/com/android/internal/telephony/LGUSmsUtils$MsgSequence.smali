.class public Lcom/android/internal/telephony/LGUSmsUtils$MsgSequence;
.super Ljava/lang/Object;
.source "LGUSmsUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/LGUSmsUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "MsgSequence"
.end annotation


# instance fields
.field public mEos:I

.field public mPdu:[B

.field final synthetic this$0:Lcom/android/internal/telephony/LGUSmsUtils;


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/LGUSmsUtils;I[B)V
    .locals 1
    .param p2, "eos"    # I
    .param p3, "pdu"    # [B

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/LGUSmsUtils$MsgSequence;->this$0:Lcom/android/internal/telephony/LGUSmsUtils;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, Lcom/android/internal/telephony/LGUSmsUtils$MsgSequence;->mEos:I

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/internal/telephony/LGUSmsUtils$MsgSequence;->mPdu:[B

    iput p2, p0, Lcom/android/internal/telephony/LGUSmsUtils$MsgSequence;->mEos:I

    iput-object p3, p0, Lcom/android/internal/telephony/LGUSmsUtils$MsgSequence;->mPdu:[B

    return-void
.end method
