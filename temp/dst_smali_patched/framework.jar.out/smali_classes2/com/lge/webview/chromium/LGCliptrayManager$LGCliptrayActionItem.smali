.class Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayActionItem;
.super Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
.source "LGCliptrayManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/webview/chromium/LGCliptrayManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "LGCliptrayActionItem"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/webview/chromium/LGCliptrayManager;


# direct methods
.method private constructor <init>(Lcom/lge/webview/chromium/LGCliptrayManager;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayActionItem;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    invoke-direct {p0}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/webview/chromium/LGCliptrayManager;Lcom/lge/webview/chromium/LGCliptrayManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/webview/chromium/LGCliptrayManager;
    .param p2, "x1"    # Lcom/lge/webview/chromium/LGCliptrayManager$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayActionItem;-><init>(Lcom/lge/webview/chromium/LGCliptrayManager;)V

    return-void
.end method


# virtual methods
.method public isVisible(Landroid/content/Context;ZZ)Z
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "isEditableText"    # Z
    .param p3, "isFloatingMode"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayActionItem;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    # getter for: Lcom/lge/webview/chromium/LGCliptrayManager;->mClient:Lcom/lge/webview/chromium/ILGCliptrayManager$LGCliptrayClient;
    invoke-static {v0}, Lcom/lge/webview/chromium/LGCliptrayManager;->access$400(Lcom/lge/webview/chromium/LGCliptrayManager;)Lcom/lge/webview/chromium/ILGCliptrayManager$LGCliptrayClient;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayActionItem;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    # getter for: Lcom/lge/webview/chromium/LGCliptrayManager;->mClient:Lcom/lge/webview/chromium/ILGCliptrayManager$LGCliptrayClient;
    invoke-static {v0}, Lcom/lge/webview/chromium/LGCliptrayManager;->access$400(Lcom/lge/webview/chromium/LGCliptrayManager;)Lcom/lge/webview/chromium/ILGCliptrayManager$LGCliptrayClient;

    move-result-object v0

    invoke-interface {v0}, Lcom/lge/webview/chromium/ILGCliptrayManager$LGCliptrayClient;->isCliptrayEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p2, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public onSelected()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/webview/chromium/LGCliptrayManager$LGCliptrayActionItem;->this$0:Lcom/lge/webview/chromium/LGCliptrayManager;

    invoke-virtual {v0}, Lcom/lge/webview/chromium/LGCliptrayManager;->showCliptray()V

    const/4 v0, 0x0

    return v0
.end method
