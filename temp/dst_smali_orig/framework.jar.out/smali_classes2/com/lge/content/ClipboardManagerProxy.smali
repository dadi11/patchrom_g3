.class public Lcom/lge/content/ClipboardManagerProxy;
.super Ljava/lang/Object;
.source "ClipboardManagerProxy.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "ClipboardManagerProxy"

.field private static sGetPrimaryClipAt:Ljava/lang/Object;

.field private static sGetPrimaryClipCount:Ljava/lang/Object;

.field private static sGetPrimaryClipDescriptionAt:Ljava/lang/Object;

.field private static sRemoveAllPrimaryClips:Ljava/lang/Object;

.field private static sRemovePrimaryClipAt:Ljava/lang/Object;


# instance fields
.field private mClipboardManager:Landroid/content/ClipboardManager;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    const-class v0, Landroid/content/ClipboardManager;

    const-string v1, "getPrimaryClipAt"

    new-array v2, v5, [Ljava/lang/Class;

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v3, v2, v4

    invoke-static {v0, v1, v2}, Lcom/lge/util/ProxyUtil;->loadMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    sput-object v0, Lcom/lge/content/ClipboardManagerProxy;->sGetPrimaryClipAt:Ljava/lang/Object;

    const-class v0, Landroid/content/ClipboardManager;

    const-string v1, "getPrimaryClipDescriptionAt"

    new-array v2, v5, [Ljava/lang/Class;

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v3, v2, v4

    invoke-static {v0, v1, v2}, Lcom/lge/util/ProxyUtil;->loadMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    sput-object v0, Lcom/lge/content/ClipboardManagerProxy;->sGetPrimaryClipDescriptionAt:Ljava/lang/Object;

    const-class v0, Landroid/content/ClipboardManager;

    const-string v1, "getPrimaryClipCount"

    new-array v2, v4, [Ljava/lang/Class;

    invoke-static {v0, v1, v2}, Lcom/lge/util/ProxyUtil;->loadMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    sput-object v0, Lcom/lge/content/ClipboardManagerProxy;->sGetPrimaryClipCount:Ljava/lang/Object;

    const-class v0, Landroid/content/ClipboardManager;

    const-string v1, "removePrimaryClipAt"

    new-array v2, v5, [Ljava/lang/Class;

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v3, v2, v4

    invoke-static {v0, v1, v2}, Lcom/lge/util/ProxyUtil;->loadMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    sput-object v0, Lcom/lge/content/ClipboardManagerProxy;->sRemovePrimaryClipAt:Ljava/lang/Object;

    const-class v0, Landroid/content/ClipboardManager;

    const-string v1, "removeAllPrimaryClips"

    new-array v2, v4, [Ljava/lang/Class;

    invoke-static {v0, v1, v2}, Lcom/lge/util/ProxyUtil;->loadMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    sput-object v0, Lcom/lge/content/ClipboardManagerProxy;->sRemoveAllPrimaryClips:Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>(Landroid/content/ClipboardManager;)V
    .locals 0
    .param p1, "clipboardManager"    # Landroid/content/ClipboardManager;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/content/ClipboardManagerProxy;->mClipboardManager:Landroid/content/ClipboardManager;

    return-void
.end method


# virtual methods
.method public getPrimaryClipAt(I)Landroid/content/ClipData;
    .locals 6
    .param p1, "index"    # I

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/content/ClipboardManagerProxy;->sGetPrimaryClipAt:Ljava/lang/Object;

    iget-object v2, p0, Lcom/lge/content/ClipboardManagerProxy;->mClipboardManager:Landroid/content/ClipboardManager;

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v1, v2, v3}, Lcom/lge/util/ProxyUtil;->invokeMethod(Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/ClipData;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "ClipboardManagerProxy"

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getPrimaryClipCount()I
    .locals 5

    .prologue
    const/4 v2, 0x0

    :try_start_0
    sget-object v1, Lcom/lge/content/ClipboardManagerProxy;->sGetPrimaryClipCount:Ljava/lang/Object;

    iget-object v3, p0, Lcom/lge/content/ClipboardManagerProxy;->mClipboardManager:Landroid/content/ClipboardManager;

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v1, v3, v4}, Lcom/lge/util/ProxyUtil;->invokeMethod(Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "ClipboardManagerProxy"

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v1, v2

    goto :goto_0
.end method

.method public getPrimaryClipDescriptionAt(I)Landroid/content/ClipDescription;
    .locals 6
    .param p1, "index"    # I

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/content/ClipboardManagerProxy;->sGetPrimaryClipDescriptionAt:Ljava/lang/Object;

    iget-object v2, p0, Lcom/lge/content/ClipboardManagerProxy;->mClipboardManager:Landroid/content/ClipboardManager;

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v1, v2, v3}, Lcom/lge/util/ProxyUtil;->invokeMethod(Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/ClipDescription;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "ClipboardManagerProxy"

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public removeAllPrimaryClips()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    :try_start_0
    sget-object v1, Lcom/lge/content/ClipboardManagerProxy;->sRemoveAllPrimaryClips:Ljava/lang/Object;

    iget-object v3, p0, Lcom/lge/content/ClipboardManagerProxy;->mClipboardManager:Landroid/content/ClipboardManager;

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v1, v3, v4}, Lcom/lge/util/ProxyUtil;->invokeMethod(Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "ClipboardManagerProxy"

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v1, v2

    goto :goto_0
.end method

.method public removePrimaryClipAt(I)Z
    .locals 7
    .param p1, "index"    # I

    .prologue
    const/4 v2, 0x0

    :try_start_0
    sget-object v1, Lcom/lge/content/ClipboardManagerProxy;->sRemovePrimaryClipAt:Ljava/lang/Object;

    iget-object v3, p0, Lcom/lge/content/ClipboardManagerProxy;->mClipboardManager:Landroid/content/ClipboardManager;

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v4, v5

    invoke-static {v1, v3, v4}, Lcom/lge/util/ProxyUtil;->invokeMethod(Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "ClipboardManagerProxy"

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v1, v2

    goto :goto_0
.end method
