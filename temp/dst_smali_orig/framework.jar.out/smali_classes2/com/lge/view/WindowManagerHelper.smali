.class public Lcom/lge/view/WindowManagerHelper;
.super Ljava/lang/Object;
.source "WindowManagerHelper.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "WindowManagerHelper"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getLGSystemUiVisibility()I
    .locals 6

    .prologue
    const/4 v1, 0x0

    .local v1, "mSystemUiVisibilityLG":I
    const/4 v3, 0x0

    .local v3, "wm":Lcom/lge/view/IWindowManagerEx;
    :try_start_0
    const-string v4, "window"

    invoke-static {v4}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v4

    invoke-static {v4}, Lcom/lge/view/IWindowManagerEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/view/IWindowManagerEx;
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    :goto_0
    if-eqz v3, :cond_0

    :try_start_1
    invoke-interface {v3}, Lcom/lge/view/IWindowManagerEx;->getLGSystemUiVisibility()I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v1

    :cond_0
    :goto_1
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v4, "WindowManagerHelper"

    const-string v5, "IWindowManagerEx is null now."

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Ljava/lang/NullPointerException;
    :catch_1
    move-exception v2

    .local v2, "re":Landroid/os/RemoteException;
    const-string v4, "WindowManagerHelper"

    const-string v5, "Session or binder is not available now."

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public static getSystemBarShownState()I
    .locals 6

    .prologue
    const/4 v0, 0x0

    .local v0, "ShownState":I
    const/4 v3, 0x0

    .local v3, "wm":Lcom/lge/view/IWindowManagerEx;
    :try_start_0
    const-string v4, "window"

    invoke-static {v4}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v4

    invoke-static {v4}, Lcom/lge/view/IWindowManagerEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/view/IWindowManagerEx;
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    :goto_0
    if-eqz v3, :cond_0

    :try_start_1
    invoke-interface {v3}, Lcom/lge/view/IWindowManagerEx;->getSystemBarShownState()I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v0

    :cond_0
    :goto_1
    return v0

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/NullPointerException;
    const-string v4, "WindowManagerHelper"

    const-string v5, "IWindowManagerEx is null now."

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v1    # "e":Ljava/lang/NullPointerException;
    :catch_1
    move-exception v2

    .local v2, "re":Landroid/os/RemoteException;
    const-string v4, "WindowManagerHelper"

    const-string v5, "Session or binder is not available now."

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method
