.class public Lcom/lge/webview/chromium/ILGScrapManager$Factory;
.super Ljava/lang/Object;
.source "ILGScrapManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/webview/chromium/ILGScrapManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Factory"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static create(Landroid/content/Context;Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;)Lcom/lge/webview/chromium/ILGScrapManager;
    .locals 1
    .param p0, "c"    # Landroid/content/Context;
    .param p1, "client"    # Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;

    .prologue
    .line 27
    new-instance v0, Lcom/lge/webview/chromium/LGScrapManager;

    invoke-direct {v0, p0, p1}, Lcom/lge/webview/chromium/LGScrapManager;-><init>(Landroid/content/Context;Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;)V

    return-object v0
.end method
