.class final enum Lcom/android/server/am/ActivityManagerService$AdjState;
.super Ljava/lang/Enum;
.source "ActivityManagerService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/am/ActivityManagerService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "AdjState"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/android/server/am/ActivityManagerService$AdjState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/android/server/am/ActivityManagerService$AdjState;

.field public static final enum EXCEPTIONAL_LTECALL:Lcom/android/server/am/ActivityManagerService$AdjState;

.field public static final enum NONE:Lcom/android/server/am/ActivityManagerService$AdjState;

.field public static final enum SYSTEM:Lcom/android/server/am/ActivityManagerService$AdjState;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 431
    new-instance v0, Lcom/android/server/am/ActivityManagerService$AdjState;

    const-string v1, "NONE"

    invoke-direct {v0, v1, v2}, Lcom/android/server/am/ActivityManagerService$AdjState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/android/server/am/ActivityManagerService$AdjState;->NONE:Lcom/android/server/am/ActivityManagerService$AdjState;

    .line 432
    new-instance v0, Lcom/android/server/am/ActivityManagerService$AdjState;

    const-string v1, "SYSTEM"

    invoke-direct {v0, v1, v3}, Lcom/android/server/am/ActivityManagerService$AdjState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/android/server/am/ActivityManagerService$AdjState;->SYSTEM:Lcom/android/server/am/ActivityManagerService$AdjState;

    .line 433
    new-instance v0, Lcom/android/server/am/ActivityManagerService$AdjState;

    const-string v1, "EXCEPTIONAL_LTECALL"

    invoke-direct {v0, v1, v4}, Lcom/android/server/am/ActivityManagerService$AdjState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/android/server/am/ActivityManagerService$AdjState;->EXCEPTIONAL_LTECALL:Lcom/android/server/am/ActivityManagerService$AdjState;

    .line 430
    const/4 v0, 0x3

    new-array v0, v0, [Lcom/android/server/am/ActivityManagerService$AdjState;

    sget-object v1, Lcom/android/server/am/ActivityManagerService$AdjState;->NONE:Lcom/android/server/am/ActivityManagerService$AdjState;

    aput-object v1, v0, v2

    sget-object v1, Lcom/android/server/am/ActivityManagerService$AdjState;->SYSTEM:Lcom/android/server/am/ActivityManagerService$AdjState;

    aput-object v1, v0, v3

    sget-object v1, Lcom/android/server/am/ActivityManagerService$AdjState;->EXCEPTIONAL_LTECALL:Lcom/android/server/am/ActivityManagerService$AdjState;

    aput-object v1, v0, v4

    sput-object v0, Lcom/android/server/am/ActivityManagerService$AdjState;->$VALUES:[Lcom/android/server/am/ActivityManagerService$AdjState;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 430
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/android/server/am/ActivityManagerService$AdjState;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 430
    const-class v0, Lcom/android/server/am/ActivityManagerService$AdjState;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/android/server/am/ActivityManagerService$AdjState;

    return-object v0
.end method

.method public static values()[Lcom/android/server/am/ActivityManagerService$AdjState;
    .locals 1

    .prologue
    .line 430
    sget-object v0, Lcom/android/server/am/ActivityManagerService$AdjState;->$VALUES:[Lcom/android/server/am/ActivityManagerService$AdjState;

    invoke-virtual {v0}, [Lcom/android/server/am/ActivityManagerService$AdjState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/android/server/am/ActivityManagerService$AdjState;

    return-object v0
.end method