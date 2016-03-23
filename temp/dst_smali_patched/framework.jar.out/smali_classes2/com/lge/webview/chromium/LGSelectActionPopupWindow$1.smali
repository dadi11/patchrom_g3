.class Lcom/lge/webview/chromium/LGSelectActionPopupWindow$1;
.super Ljava/lang/Object;
.source "LGSelectActionPopupWindow.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/webview/chromium/LGSelectActionPopupWindow;-><init>(Landroid/content/Context;Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/webview/chromium/LGSelectActionPopupWindow;


# direct methods
.method constructor <init>(Lcom/lge/webview/chromium/LGSelectActionPopupWindow;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow$1;->this$0:Lcom/lge/webview/chromium/LGSelectActionPopupWindow;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 2
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .prologue
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
