.class public final Lcom/lge/internal/R$anim;
.super Ljava/lang/Object;
.source "R.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/internal/R;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "anim"
.end annotation


# static fields
.field public static bubble_popup_arrow_fade_in:I

.field public static bubble_popup_arrow_fade_out:I

.field public static unlock_button_animation:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/high16 v0, 0x40000

    sput v0, Lcom/lge/internal/R$anim;->bubble_popup_arrow_fade_in:I

    const v0, 0x40001

    sput v0, Lcom/lge/internal/R$anim;->bubble_popup_arrow_fade_out:I

    const v0, 0x4000b

    sput v0, Lcom/lge/internal/R$anim;->unlock_button_animation:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
