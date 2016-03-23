.class public final Lcom/lge/R$integer;
.super Ljava/lang/Object;
.source "R.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/R;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "integer"
.end annotation


# static fields
.field public static config_emotionalLedType:I

.field public static config_max_property:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 331
    const v0, 0xb0005

    sput v0, Lcom/lge/R$integer;->config_emotionalLedType:I

    .line 338
    const v0, 0xb0010

    sput v0, Lcom/lge/R$integer;->config_max_property:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 323
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
