.class public abstract Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
.super Ljava/lang/Object;
.source "ILGSelectActionPopupWindow.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/webview/chromium/ILGSelectActionPopupWindow;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "LGSelectActionItem"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public isEnabled()Z
    .locals 1

    .prologue
    .line 21
    const/4 v0, 0x1

    return v0
.end method

.method public isVisible(Landroid/content/Context;ZZ)Z
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "isEditableText"    # Z
    .param p3, "isFloatingMode"    # Z

    .prologue
    .line 20
    const/4 v0, 0x1

    return v0
.end method

.method public abstract onSelected()Z
.end method
