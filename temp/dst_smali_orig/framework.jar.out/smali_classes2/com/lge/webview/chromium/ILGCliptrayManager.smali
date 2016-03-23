.class public interface abstract Lcom/lge/webview/chromium/ILGCliptrayManager;
.super Ljava/lang/Object;
.source "ILGCliptrayManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/webview/chromium/ILGCliptrayManager$Factory;,
        Lcom/lge/webview/chromium/ILGCliptrayManager$LGCliptrayClient;
    }
.end annotation


# virtual methods
.method public abstract copyImageToCliptray(Landroid/net/Uri;)V
.end method

.method public abstract copyToCliptray(Landroid/content/ClipData;)V
.end method

.method public abstract copyToCliptray(Ljava/lang/CharSequence;)V
.end method

.method public abstract getActionItem()Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
.end method

.method public abstract hideCliptray()V
.end method

.method public abstract setCliptrayClient(Lcom/lge/webview/chromium/ILGCliptrayManager$LGCliptrayClient;)V
.end method

.method public abstract showCliptray()V
.end method
