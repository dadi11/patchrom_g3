.class Lcom/lge/webview/chromium/LGScrapManager$LGScrapActionItem;
.super Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
.source "LGScrapManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/webview/chromium/LGScrapManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "LGScrapActionItem"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/webview/chromium/LGScrapManager;


# direct methods
.method private constructor <init>(Lcom/lge/webview/chromium/LGScrapManager;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/webview/chromium/LGScrapManager$LGScrapActionItem;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    invoke-direct {p0}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/webview/chromium/LGScrapManager;Lcom/lge/webview/chromium/LGScrapManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/webview/chromium/LGScrapManager;
    .param p2, "x1"    # Lcom/lge/webview/chromium/LGScrapManager$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/webview/chromium/LGScrapManager$LGScrapActionItem;-><init>(Lcom/lge/webview/chromium/LGScrapManager;)V

    return-void
.end method


# virtual methods
.method public isVisible(Landroid/content/Context;ZZ)Z
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "isEditableText"    # Z
    .param p3, "isFloatingMode"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/webview/chromium/LGScrapManager$LGScrapActionItem;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    # getter for: Lcom/lge/webview/chromium/LGScrapManager;->mClient:Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;
    invoke-static {v0}, Lcom/lge/webview/chromium/LGScrapManager;->access$500(Lcom/lge/webview/chromium/LGScrapManager;)Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/webview/chromium/LGScrapManager$LGScrapActionItem;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    # getter for: Lcom/lge/webview/chromium/LGScrapManager;->mClient:Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;
    invoke-static {v0}, Lcom/lge/webview/chromium/LGScrapManager;->access$500(Lcom/lge/webview/chromium/LGScrapManager;)Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;

    move-result-object v0

    invoke-interface {v0}, Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;->isWebScrapEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    if-nez p3, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public onSelected()Z
    .locals 3

    .prologue
    iget-object v0, p0, Lcom/lge/webview/chromium/LGScrapManager$LGScrapActionItem;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    # invokes: Lcom/lge/webview/chromium/LGScrapManager;->isLowOnDisc()Z
    invoke-static {v0}, Lcom/lge/webview/chromium/LGScrapManager;->access$300(Lcom/lge/webview/chromium/LGScrapManager;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/lge/webview/chromium/LGScrapManager$LGScrapActionItem;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    invoke-virtual {v0}, Lcom/lge/webview/chromium/LGScrapManager;->scrapSelection()V

    :goto_0
    const/4 v0, 0x1

    return v0

    :cond_0
    iget-object v0, p0, Lcom/lge/webview/chromium/LGScrapManager$LGScrapActionItem;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    # getter for: Lcom/lge/webview/chromium/LGScrapManager;->mContext:Landroid/content/Context;
    invoke-static {v0}, Lcom/lge/webview/chromium/LGScrapManager;->access$400(Lcom/lge/webview/chromium/LGScrapManager;)Landroid/content/Context;

    move-result-object v0

    sget v1, Lcom/lge/internal/R$string;->sp_screenshot_failed_enough_space_internal_storage_NORMAL:I

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0
.end method
