.class public final Landroid/media/TimedTextEx$ResumeCaptionLoading;
.super Ljava/lang/Object;
.source "TimedTextEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/media/TimedTextEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ResumeCaptionLoading"
.end annotation


# instance fields
.field public final resume:I


# direct methods
.method public constructor <init>(I)V
    .locals 0
    .param p1, "resume"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Landroid/media/TimedTextEx$ResumeCaptionLoading;->resume:I

    return-void
.end method
