.class public interface abstract Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;
.super Ljava/lang/Object;
.source "ILGSelectActionPopupWindow.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/webview/chromium/ILGSelectActionPopupWindow;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "LGSelectActionPopupClient"
.end annotation


# virtual methods
.method public abstract getClientGlobalVisibleRect(Landroid/graphics/Rect;)Z
.end method

.method public abstract getClientLocationOnScreen([I)V
.end method

.method public abstract getClientSelectionRegion()Landroid/graphics/Rect;
.end method

.method public abstract isEditableText()Z
.end method

.method public abstract isFloatingMode()Z
.end method

.method public abstract onSelectActionPopupDestroy()V
.end method
