.class public interface abstract Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;
.super Ljava/lang/Object;
.source "ILGScrapManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/webview/chromium/ILGScrapManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "LGScrapClient"
.end annotation


# virtual methods
.method public abstract getParagraphScreenShot()Landroid/graphics/Bitmap;
.end method

.method public abstract getTitle()Ljava/lang/String;
.end method

.method public abstract getUrl()Ljava/lang/String;
.end method

.method public abstract isWebScrapEnabled()Z
.end method
