.class public final Lcom/lge/R$styleable;
.super Ljava/lang/Object;
.source "R.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/R;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "styleable"
.end annotation


# static fields
.field public static final Theme:[I

.field public static Theme_windowNavigationBarBackground:I

.field public static Theme_windowStatusBarBackground:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 1041
    const/4 v0, 0x2

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/lge/R$styleable;->Theme:[I

    .line 1055
    const/4 v0, 0x1

    sput v0, Lcom/lge/R$styleable;->Theme_windowNavigationBarBackground:I

    .line 1067
    const/4 v0, 0x0

    sput v0, Lcom/lge/R$styleable;->Theme_windowStatusBarBackground:I

    return-void

    .line 1041
    nop

    :array_0
    .array-data 4
        0x2010000
        0x2010001
    .end array-data
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 1028
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method