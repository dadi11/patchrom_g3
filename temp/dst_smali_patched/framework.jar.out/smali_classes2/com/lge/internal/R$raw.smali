.class public final Lcom/lge/internal/R$raw;
.super Ljava/lang/Object;
.source "R.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/internal/R;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "raw"
.end annotation


# static fields
.field public static circle_fade_fs:I

.field public static circle_fade_vs:I

.field public static simple_password_dictionary:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/high16 v0, 0x90000

    sput v0, Lcom/lge/internal/R$raw;->circle_fade_fs:I

    const v0, 0x90001

    sput v0, Lcom/lge/internal/R$raw;->circle_fade_vs:I

    const v0, 0x90002

    sput v0, Lcom/lge/internal/R$raw;->simple_password_dictionary:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
