.class public final Landroid/media/TimedTextEx$ResumeTextDisplay;
.super Ljava/lang/Object;
.source "TimedTextEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/media/TimedTextEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ResumeTextDisplay"
.end annotation


# instance fields
.field public final resume:I


# direct methods
.method public constructor <init>(I)V
    .locals 0
    .param p1, "resume"    # I

    .prologue
    .line 467
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 468
    iput p1, p0, Landroid/media/TimedTextEx$ResumeTextDisplay;->resume:I

    .line 469
    return-void
.end method