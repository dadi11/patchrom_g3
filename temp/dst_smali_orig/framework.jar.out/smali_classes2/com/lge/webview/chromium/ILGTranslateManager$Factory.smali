.class public Lcom/lge/webview/chromium/ILGTranslateManager$Factory;
.super Ljava/lang/Object;
.source "ILGTranslateManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/webview/chromium/ILGTranslateManager;
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

.method public static destroy()V
    .locals 0

    .prologue
    invoke-static {}, Lcom/lge/webview/chromium/LGTranslateManager;->destroy()V

    return-void
.end method

.method public static getInstance(Landroid/content/Context;Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;)Lcom/lge/webview/chromium/ILGTranslateManager;
    .locals 1
    .param p0, "c"    # Landroid/content/Context;
    .param p1, "client"    # Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;

    .prologue
    invoke-static {p0, p1}, Lcom/lge/webview/chromium/LGTranslateManager;->getInstance(Landroid/content/Context;Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;)Lcom/lge/webview/chromium/ILGTranslateManager;

    move-result-object v0

    return-object v0
.end method
