.class Lcom/lge/webview/chromium/LGSelectActionPopupWindow$2;
.super Ljava/lang/Object;
.source "LGSelectActionPopupWindow.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->initSelectActionItem(ILcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;)Landroid/widget/TextView;
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
    .line 150
    iput-object p1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow$2;->this$0:Lcom/lge/webview/chromium/LGSelectActionPopupWindow;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 3
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v2, 0x0

    .line 152
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 174
    :goto_0
    :pswitch_0
    const/4 v1, 0x1

    return v1

    .line 154
    :pswitch_1
    const v1, -0x3c2d29

    invoke-virtual {p1, v1}, Landroid/view/View;->setBackgroundColor(I)V

    goto :goto_0

    .line 157
    :pswitch_2
    invoke-virtual {p1, v2}, Landroid/view/View;->playSoundEffect(I)V

    .line 158
    invoke-virtual {p1, v2}, Landroid/view/View;->setBackgroundColor(I)V

    .line 159
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow$2;->this$0:Lcom/lge/webview/chromium/LGSelectActionPopupWindow;

    # getter for: Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mActionItems:Ljava/util/Hashtable;
    invoke-static {v1}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->access$000(Lcom/lge/webview/chromium/LGSelectActionPopupWindow;)Ljava/util/Hashtable;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 160
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow$2;->this$0:Lcom/lge/webview/chromium/LGSelectActionPopupWindow;

    # getter for: Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mActionItems:Ljava/util/Hashtable;
    invoke-static {v1}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->access$000(Lcom/lge/webview/chromium/LGSelectActionPopupWindow;)Ljava/util/Hashtable;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    .line 161
    .local v0, "item":Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
    if-eqz v0, :cond_0

    .line 162
    invoke-virtual {v0}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;->onSelected()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 163
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow$2;->this$0:Lcom/lge/webview/chromium/LGSelectActionPopupWindow;

    invoke-virtual {v1}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->hide()V

    .line 164
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow$2;->this$0:Lcom/lge/webview/chromium/LGSelectActionPopupWindow;

    # getter for: Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;
    invoke-static {v1}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->access$100(Lcom/lge/webview/chromium/LGSelectActionPopupWindow;)Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;->onSelectActionPopupDestroy()V

    .line 168
    .end local v0    # "item":Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
    :cond_0
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow$2;->this$0:Lcom/lge/webview/chromium/LGSelectActionPopupWindow;

    invoke-virtual {v1}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->updateStatus()V

    goto :goto_0

    .line 171
    :pswitch_3
    invoke-virtual {p1, v2}, Landroid/view/View;->setBackgroundColor(I)V

    goto :goto_0

    .line 152
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method
