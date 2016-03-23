.class public interface abstract Lcom/lge/webview/chromium/ILGTranslateManager;
.super Ljava/lang/Object;
.source "ILGTranslateManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/webview/chromium/ILGTranslateManager$Factory;,
        Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;
    }
.end annotation


# virtual methods
.method public abstract getActionItem()Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
.end method

.method public abstract getTranslateMode()Z
.end method

.method public abstract setTranslateMode(Z)V
.end method

.method public abstract translateSelection()V
.end method
