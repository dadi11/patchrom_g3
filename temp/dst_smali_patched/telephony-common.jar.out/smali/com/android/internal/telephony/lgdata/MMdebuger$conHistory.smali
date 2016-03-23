.class Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;
.super Ljava/lang/Object;
.source "MMdebuger.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/lgdata/MMdebuger;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "conHistory"
.end annotation


# instance fields
.field APNID:I

.field cid:I

.field cmdtype:I

.field curDay:I

.field curHour:I

.field curMinute:I

.field curMonth:I

.field curSecond:I

.field curYear:I

.field currRadioTech:I

.field serialnum:I

.field final synthetic this$0:Lcom/android/internal/telephony/lgdata/MMdebuger;


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/lgdata/MMdebuger;IIIIII)V
    .locals 0
    .param p2, "a"    # I
    .param p3, "b"    # I
    .param p4, "c"    # I
    .param p5, "d"    # I
    .param p6, "e"    # I
    .param p7, "f"    # I

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->this$0:Lcom/android/internal/telephony/lgdata/MMdebuger;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p2, p0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curYear:I

    iput p3, p0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curMonth:I

    iput p4, p0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curDay:I

    iput p5, p0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curHour:I

    iput p6, p0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curMinute:I

    iput p7, p0, Lcom/android/internal/telephony/lgdata/MMdebuger$conHistory;->curSecond:I

    return-void
.end method
