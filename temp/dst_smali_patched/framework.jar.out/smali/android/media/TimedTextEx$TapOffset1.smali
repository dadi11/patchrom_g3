.class public final Landroid/media/TimedTextEx$TapOffset1;
.super Ljava/lang/Object;
.source "TimedTextEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/media/TimedTextEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "TapOffset1"
.end annotation


# instance fields
.field public final tapOffset:I


# direct methods
.method public constructor <init>(I)V
    .locals 0
    .param p1, "tapOffset"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Landroid/media/TimedTextEx$TapOffset1;->tapOffset:I

    return-void
.end method
