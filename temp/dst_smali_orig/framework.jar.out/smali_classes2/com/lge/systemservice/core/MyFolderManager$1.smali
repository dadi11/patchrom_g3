.class Lcom/lge/systemservice/core/MyFolderManager$1;
.super Ljava/lang/Object;
.source "MyFolderManager.java"

# interfaces
.implements Landroid/os/IBinder$DeathRecipient;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/systemservice/core/MyFolderManager;->getService()Lcom/lge/systemservice/core/IMyFolderManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/systemservice/core/MyFolderManager;


# direct methods
.method constructor <init>(Lcom/lge/systemservice/core/MyFolderManager;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/core/MyFolderManager$1;->this$0:Lcom/lge/systemservice/core/MyFolderManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public binderDied()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/core/MyFolderManager$1;->this$0:Lcom/lge/systemservice/core/MyFolderManager;

    const/4 v1, 0x0

    # setter for: Lcom/lge/systemservice/core/MyFolderManager;->mService:Lcom/lge/systemservice/core/IMyFolderManager;
    invoke-static {v0, v1}, Lcom/lge/systemservice/core/MyFolderManager;->access$002(Lcom/lge/systemservice/core/MyFolderManager;Lcom/lge/systemservice/core/IMyFolderManager;)Lcom/lge/systemservice/core/IMyFolderManager;

    return-void
.end method
