.class public final Landroid/media/TimedTextEx$DefineWindow;
.super Ljava/lang/Object;
.source "TimedTextEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/media/TimedTextEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DefineWindow"
.end annotation


# instance fields
.field public final anchorHorizontal:I

.field public final anchorPoint:I

.field public final anchorVertical:I

.field public final columnCount:I

.field public final columnLock:I

.field public final penStyleID:I

.field public final priority:I

.field public final relativePosition:I

.field public final rowCount:I

.field public final rowLock:I

.field public final visible:I

.field public final windowID:I

.field public final windowStyleID:I


# direct methods
.method public constructor <init>(IIIIIIIIIIIII)V
    .locals 4
    .param p1, "windowID"    # I
    .param p2, "priority"    # I
    .param p3, "anchorPoint"    # I
    .param p4, "relativePosition"    # I
    .param p5, "anchorVertical"    # I
    .param p6, "anchorHorizontal"    # I
    .param p7, "rowCount"    # I
    .param p8, "columnCount"    # I
    .param p9, "rowLock"    # I
    .param p10, "columnLock"    # I
    .param p11, "visible"    # I
    .param p12, "windowStyleID"    # I
    .param p13, "penStyleID"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v1, "TimedTextEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DefineWindow"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, p12

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " / "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, p13

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    iput p1, p0, Landroid/media/TimedTextEx$DefineWindow;->windowID:I

    iput p2, p0, Landroid/media/TimedTextEx$DefineWindow;->priority:I

    iput p3, p0, Landroid/media/TimedTextEx$DefineWindow;->anchorPoint:I

    iput p4, p0, Landroid/media/TimedTextEx$DefineWindow;->relativePosition:I

    iput p5, p0, Landroid/media/TimedTextEx$DefineWindow;->anchorVertical:I

    iput p6, p0, Landroid/media/TimedTextEx$DefineWindow;->anchorHorizontal:I

    iput p7, p0, Landroid/media/TimedTextEx$DefineWindow;->rowCount:I

    iput p8, p0, Landroid/media/TimedTextEx$DefineWindow;->columnCount:I

    iput p9, p0, Landroid/media/TimedTextEx$DefineWindow;->rowLock:I

    iput p10, p0, Landroid/media/TimedTextEx$DefineWindow;->columnLock:I

    iput p11, p0, Landroid/media/TimedTextEx$DefineWindow;->visible:I

    move/from16 v0, p12

    iput v0, p0, Landroid/media/TimedTextEx$DefineWindow;->windowStyleID:I

    move/from16 v0, p13

    iput v0, p0, Landroid/media/TimedTextEx$DefineWindow;->penStyleID:I

    return-void
.end method
