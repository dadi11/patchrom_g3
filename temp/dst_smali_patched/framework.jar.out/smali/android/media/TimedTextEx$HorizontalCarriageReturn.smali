.class public final Landroid/media/TimedTextEx$HorizontalCarriageReturn;
.super Ljava/lang/Object;
.source "TimedTextEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/media/TimedTextEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "HorizontalCarriageReturn"
.end annotation


# instance fields
.field public final hcr:I


# direct methods
.method public constructor <init>(I)V
    .locals 0
    .param p1, "hcr"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Landroid/media/TimedTextEx$HorizontalCarriageReturn;->hcr:I

    return-void
.end method
