.class public Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$Factory;
.super Ljava/lang/Object;
.source "ILGSelectActionPopupWindow.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/webview/chromium/ILGSelectActionPopupWindow;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Factory"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static create(Landroid/content/Context;Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;)Lcom/lge/webview/chromium/ILGSelectActionPopupWindow;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "client"    # Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    .prologue
    new-instance v0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;

    invoke-direct {v0, p0, p1}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;-><init>(Landroid/content/Context;Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;)V

    return-object v0
.end method
