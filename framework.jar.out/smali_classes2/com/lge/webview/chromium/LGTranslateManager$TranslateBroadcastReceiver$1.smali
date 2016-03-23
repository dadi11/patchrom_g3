.class Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver$1;
.super Ljava/lang/Object;
.source "LGTranslateManager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;->onReceive(Landroid/content/Context;Landroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;


# direct methods
.method constructor <init>(Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;)V
    .locals 0

    .prologue
    .line 136
    iput-object p1, p0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver$1;->this$1:Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 139
    iget-object v0, p0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver$1;->this$1:Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;

    iget-object v0, v0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;->this$0:Lcom/lge/webview/chromium/LGTranslateManager;

    # getter for: Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateMode:Z
    invoke-static {v0}, Lcom/lge/webview/chromium/LGTranslateManager;->access$100(Lcom/lge/webview/chromium/LGTranslateManager;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 140
    iget-object v0, p0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver$1;->this$1:Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;

    iget-object v0, v0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;->this$0:Lcom/lge/webview/chromium/LGTranslateManager;

    invoke-virtual {v0}, Lcom/lge/webview/chromium/LGTranslateManager;->translateSelection()V

    .line 142
    :cond_0
    return-void
.end method
