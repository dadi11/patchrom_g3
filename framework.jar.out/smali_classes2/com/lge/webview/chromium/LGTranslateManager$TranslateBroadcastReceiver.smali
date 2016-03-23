.class Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;
.super Landroid/content/BroadcastReceiver;
.source "LGTranslateManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/webview/chromium/LGTranslateManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "TranslateBroadcastReceiver"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/webview/chromium/LGTranslateManager;


# direct methods
.method private constructor <init>(Lcom/lge/webview/chromium/LGTranslateManager;)V
    .locals 0

    .prologue
    .line 126
    iput-object p1, p0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;->this$0:Lcom/lge/webview/chromium/LGTranslateManager;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/webview/chromium/LGTranslateManager;Lcom/lge/webview/chromium/LGTranslateManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/webview/chromium/LGTranslateManager;
    .param p2, "x1"    # Lcom/lge/webview/chromium/LGTranslateManager$1;

    .prologue
    .line 126
    invoke-direct {p0, p1}, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;-><init>(Lcom/lge/webview/chromium/LGTranslateManager;)V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v5, 0x0

    .line 129
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    const-string v3, "com.lge.texttranslate.EXIT"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 130
    const-string v2, "orientation"

    invoke-virtual {p2, v2, v5}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v1

    .line 132
    .local v1, "mTranslateOrientaion":Z
    const-string v2, "LGTranslateManager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "orientation is : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 134
    if-eqz v1, :cond_1

    .line 135
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    .line 136
    .local v0, "mHandler":Landroid/os/Handler;
    new-instance v2, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver$1;

    invoke-direct {v2, p0}, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver$1;-><init>(Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;)V

    const-wide/16 v4, 0x5dc

    invoke-virtual {v0, v2, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 150
    .end local v0    # "mHandler":Landroid/os/Handler;
    .end local v1    # "mTranslateOrientaion":Z
    :cond_0
    :goto_0
    return-void

    .line 145
    .restart local v1    # "mTranslateOrientaion":Z
    :cond_1
    iget-object v2, p0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;->this$0:Lcom/lge/webview/chromium/LGTranslateManager;

    # setter for: Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateMode:Z
    invoke-static {v2, v5}, Lcom/lge/webview/chromium/LGTranslateManager;->access$102(Lcom/lge/webview/chromium/LGTranslateManager;Z)Z

    .line 146
    iget-object v2, p0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;->this$0:Lcom/lge/webview/chromium/LGTranslateManager;

    # getter for: Lcom/lge/webview/chromium/LGTranslateManager;->mClient:Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;
    invoke-static {v2}, Lcom/lge/webview/chromium/LGTranslateManager;->access$200(Lcom/lge/webview/chromium/LGTranslateManager;)Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;->selectionDone()V

    .line 147
    iget-object v2, p0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;->this$0:Lcom/lge/webview/chromium/LGTranslateManager;

    # invokes: Lcom/lge/webview/chromium/LGTranslateManager;->disableTranslateListener()V
    invoke-static {v2}, Lcom/lge/webview/chromium/LGTranslateManager;->access$300(Lcom/lge/webview/chromium/LGTranslateManager;)V

    goto :goto_0
.end method
