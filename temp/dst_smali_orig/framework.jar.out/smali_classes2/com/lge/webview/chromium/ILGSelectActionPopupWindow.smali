.class public interface abstract Lcom/lge/webview/chromium/ILGSelectActionPopupWindow;
.super Ljava/lang/Object;
.source "ILGSelectActionPopupWindow.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$Factory;,
        Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;,
        Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
    }
.end annotation


# virtual methods
.method public abstract addSelectActionItem(ILcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;)V
.end method

.method public abstract hide()V
.end method

.method public abstract isShowing()Z
.end method

.method public abstract show(Landroid/view/View;)V
.end method

.method public abstract updateStatus()V
.end method
