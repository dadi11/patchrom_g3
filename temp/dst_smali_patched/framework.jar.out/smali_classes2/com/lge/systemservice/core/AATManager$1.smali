.class Lcom/lge/systemservice/core/AATManager$1;
.super Ljava/lang/Object;
.source "AATManager.java"

# interfaces
.implements Landroid/os/IBinder$DeathRecipient;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/systemservice/core/AATManager;->getService()Lcom/lge/systemservice/core/IAATManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/systemservice/core/AATManager;


# direct methods
.method constructor <init>(Lcom/lge/systemservice/core/AATManager;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/core/AATManager$1;->this$0:Lcom/lge/systemservice/core/AATManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public binderDied()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/core/AATManager$1;->this$0:Lcom/lge/systemservice/core/AATManager;

    const/4 v1, 0x0

    # setter for: Lcom/lge/systemservice/core/AATManager;->mService:Lcom/lge/systemservice/core/IAATManager;
    invoke-static {v0, v1}, Lcom/lge/systemservice/core/AATManager;->access$002(Lcom/lge/systemservice/core/AATManager;Lcom/lge/systemservice/core/IAATManager;)Lcom/lge/systemservice/core/IAATManager;

    return-void
.end method
