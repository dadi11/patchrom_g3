.class Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;
.super Ljava/lang/Object;
.source "HttpConnectionResult.java"


# static fields
.field public static RESULT_CODE_CANNOT_CONNECT_URL:I

.field public static RESULT_CODE_INVALID_URL:I

.field public static RESULT_CODE_NEED_VERIFIER:I

.field public static RESULT_CODE_NONE:I

.field public static RESULT_CODE_NORMAL:I

.field public static RESULT_CODE_SOME_ERROR:I

.field public static RESULT_CODE_UNSUPPORTED_ENCODING:I


# instance fields
.field public cookies:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public responsePage:Ljava/lang/String;

.field public resultCode:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->RESULT_CODE_NONE:I

    const/4 v0, 0x1

    sput v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->RESULT_CODE_NORMAL:I

    const/4 v0, 0x2

    sput v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->RESULT_CODE_UNSUPPORTED_ENCODING:I

    const/4 v0, 0x3

    sput v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->RESULT_CODE_INVALID_URL:I

    const/4 v0, 0x4

    sput v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->RESULT_CODE_CANNOT_CONNECT_URL:I

    const/4 v0, 0x5

    sput v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->RESULT_CODE_NEED_VERIFIER:I

    const/16 v0, 0x66

    sput v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->RESULT_CODE_SOME_ERROR:I

    return-void
.end method

.method constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->RESULT_CODE_NONE:I

    iput v0, p0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->resultCode:I

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->responsePage:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->cookies:Ljava/util/List;

    return-void
.end method
