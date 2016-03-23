.class public final Landroid/media/TimedTextEx$Reset;
.super Ljava/lang/Object;
.source "TimedTextEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/media/TimedTextEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Reset"
.end annotation


# instance fields
.field public final reset:I


# direct methods
.method public constructor <init>(I)V
    .locals 0
    .param p1, "reset"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Landroid/media/TimedTextEx$Reset;->reset:I

    return-void
.end method
