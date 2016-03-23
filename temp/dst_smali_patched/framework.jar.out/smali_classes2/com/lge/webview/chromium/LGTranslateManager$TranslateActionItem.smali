.class Lcom/lge/webview/chromium/LGTranslateManager$TranslateActionItem;
.super Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
.source "LGTranslateManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/webview/chromium/LGTranslateManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "TranslateActionItem"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/webview/chromium/LGTranslateManager;


# direct methods
.method private constructor <init>(Lcom/lge/webview/chromium/LGTranslateManager;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateActionItem;->this$0:Lcom/lge/webview/chromium/LGTranslateManager;

    invoke-direct {p0}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/webview/chromium/LGTranslateManager;Lcom/lge/webview/chromium/LGTranslateManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/webview/chromium/LGTranslateManager;
    .param p2, "x1"    # Lcom/lge/webview/chromium/LGTranslateManager$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/webview/chromium/LGTranslateManager$TranslateActionItem;-><init>(Lcom/lge/webview/chromium/LGTranslateManager;)V

    return-void
.end method


# virtual methods
.method public isVisible(Landroid/content/Context;ZZ)Z
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "isEditableText"    # Z
    .param p3, "isFloatingMode"    # Z

    .prologue
    const-string v0, "com.cardcam.QTranslator"

    .local v0, "QTRANSLATOR":Ljava/lang/String;
    iget-object v1, p0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateActionItem;->this$0:Lcom/lge/webview/chromium/LGTranslateManager;

    const-string v2, "com.lge.texttranslate"

    # invokes: Lcom/lge/webview/chromium/LGTranslateManager;->isPackageAvailable(Ljava/lang/String;)Z
    invoke-static {v1, v2}, Lcom/lge/webview/chromium/LGTranslateManager;->access$500(Lcom/lge/webview/chromium/LGTranslateManager;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateActionItem;->this$0:Lcom/lge/webview/chromium/LGTranslateManager;

    const-string v2, "com.cardcam.QTranslator"

    # invokes: Lcom/lge/webview/chromium/LGTranslateManager;->isPackageAvailable(Ljava/lang/String;)Z
    invoke-static {v1, v2}, Lcom/lge/webview/chromium/LGTranslateManager;->access$500(Lcom/lge/webview/chromium/LGTranslateManager;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    if-nez p2, :cond_0

    if-nez p3, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public onSelected()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateActionItem;->this$0:Lcom/lge/webview/chromium/LGTranslateManager;

    invoke-virtual {v0}, Lcom/lge/webview/chromium/LGTranslateManager;->translateSelection()V

    const/4 v0, 0x0

    return v0
.end method
