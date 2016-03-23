.class public Lcom/lge/webview/chromium/LGTranslateManager;
.super Ljava/lang/Object;
.source "LGTranslateManager.java"

# interfaces
.implements Lcom/lge/webview/chromium/ILGTranslateManager;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/webview/chromium/LGTranslateManager$1;,
        Lcom/lge/webview/chromium/LGTranslateManager$TranslateActionItem;,
        Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;
    }
.end annotation


# static fields
.field private static final DEBUG:Z = true

.field private static final EMAIL:Ljava/lang/String; = "com.lge.email"

.field private static final LOG_TAG:Ljava/lang/String; = "LGTranslateManager"

.field private static final TRANSLATE_EXIT:Ljava/lang/String; = "com.lge.texttranslate.EXIT"

.field private static final TRANSLATE_ROTATE_DELAY:I = 0x5dc

.field private static final TRANSLATOR:Ljava/lang/String; = "com.lge.texttranslate"

.field private static volatile sTranslateManager:Lcom/lge/webview/chromium/LGTranslateManager;


# instance fields
.field private mClient:Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;

.field private mContext:Landroid/content/Context;

.field private mSelectActionItem:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

.field private mTranslateMode:Z

.field private mTranslateReceiver:Landroid/content/BroadcastReceiver;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 27
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/webview/chromium/LGTranslateManager;->sTranslateManager:Lcom/lge/webview/chromium/LGTranslateManager;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    iput-object v1, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateReceiver:Landroid/content/BroadcastReceiver;

    .line 31
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateMode:Z

    .line 32
    iput-object v1, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mSelectActionItem:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    .line 41
    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "c"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    iput-object v1, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateReceiver:Landroid/content/BroadcastReceiver;

    .line 31
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateMode:Z

    .line 32
    iput-object v1, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mSelectActionItem:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    .line 44
    iput-object p1, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mContext:Landroid/content/Context;

    .line 45
    new-instance v0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;

    invoke-direct {v0, p0, v1}, Lcom/lge/webview/chromium/LGTranslateManager$TranslateBroadcastReceiver;-><init>(Lcom/lge/webview/chromium/LGTranslateManager;Lcom/lge/webview/chromium/LGTranslateManager$1;)V

    iput-object v0, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateReceiver:Landroid/content/BroadcastReceiver;

    .line 46
    return-void
.end method

.method static synthetic access$100(Lcom/lge/webview/chromium/LGTranslateManager;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/webview/chromium/LGTranslateManager;

    .prologue
    .line 25
    iget-boolean v0, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateMode:Z

    return v0
.end method

.method static synthetic access$102(Lcom/lge/webview/chromium/LGTranslateManager;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/webview/chromium/LGTranslateManager;
    .param p1, "x1"    # Z

    .prologue
    .line 25
    iput-boolean p1, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateMode:Z

    return p1
.end method

.method static synthetic access$200(Lcom/lge/webview/chromium/LGTranslateManager;)Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;
    .locals 1
    .param p0, "x0"    # Lcom/lge/webview/chromium/LGTranslateManager;

    .prologue
    .line 25
    iget-object v0, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mClient:Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;

    return-object v0
.end method

.method static synthetic access$300(Lcom/lge/webview/chromium/LGTranslateManager;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/webview/chromium/LGTranslateManager;

    .prologue
    .line 25
    invoke-direct {p0}, Lcom/lge/webview/chromium/LGTranslateManager;->disableTranslateListener()V

    return-void
.end method

.method static synthetic access$500(Lcom/lge/webview/chromium/LGTranslateManager;Ljava/lang/String;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/webview/chromium/LGTranslateManager;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 25
    invoke-direct {p0, p1}, Lcom/lge/webview/chromium/LGTranslateManager;->isPackageAvailable(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static destroy()V
    .locals 1

    .prologue
    .line 82
    sget-object v0, Lcom/lge/webview/chromium/LGTranslateManager;->sTranslateManager:Lcom/lge/webview/chromium/LGTranslateManager;

    if-eqz v0, :cond_0

    .line 83
    sget-object v0, Lcom/lge/webview/chromium/LGTranslateManager;->sTranslateManager:Lcom/lge/webview/chromium/LGTranslateManager;

    invoke-direct {v0}, Lcom/lge/webview/chromium/LGTranslateManager;->disableTranslateListener()V

    .line 84
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/webview/chromium/LGTranslateManager;->sTranslateManager:Lcom/lge/webview/chromium/LGTranslateManager;

    .line 86
    :cond_0
    return-void
.end method

.method private declared-synchronized disableTranslateListener()V
    .locals 3

    .prologue
    .line 72
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 77
    :goto_0
    :try_start_1
    const-string v1, "LGTranslateManager"

    const-string v2, "sTranslateManager is unregistered"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 79
    monitor-exit p0

    return-void

    .line 73
    :catch_0
    move-exception v0

    .line 74
    .local v0, "e":Ljava/lang/IllegalArgumentException;
    :try_start_2
    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    .line 72
    .end local v0    # "e":Ljava/lang/IllegalArgumentException;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public static declared-synchronized getInstance(Landroid/content/Context;Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;)Lcom/lge/webview/chromium/ILGTranslateManager;
    .locals 2
    .param p0, "c"    # Landroid/content/Context;
    .param p1, "client"    # Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;

    .prologue
    .line 49
    const-class v1, Lcom/lge/webview/chromium/LGTranslateManager;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/lge/webview/chromium/LGTranslateManager;->sTranslateManager:Lcom/lge/webview/chromium/LGTranslateManager;

    if-nez v0, :cond_0

    .line 50
    new-instance v0, Lcom/lge/webview/chromium/LGTranslateManager;

    invoke-direct {v0, p0}, Lcom/lge/webview/chromium/LGTranslateManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/lge/webview/chromium/LGTranslateManager;->sTranslateManager:Lcom/lge/webview/chromium/LGTranslateManager;

    .line 52
    :cond_0
    sget-object v0, Lcom/lge/webview/chromium/LGTranslateManager;->sTranslateManager:Lcom/lge/webview/chromium/LGTranslateManager;

    invoke-direct {v0, p1}, Lcom/lge/webview/chromium/LGTranslateManager;->setClient(Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;)V

    .line 53
    sget-object v0, Lcom/lge/webview/chromium/LGTranslateManager;->sTranslateManager:Lcom/lge/webview/chromium/LGTranslateManager;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 49
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private getRegisteredPackage()Ljava/lang/String;
    .locals 1

    .prologue
    .line 61
    iget-object v0, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    return-object v0
.end method

.method private isPackageAvailable(Ljava/lang/String;)Z
    .locals 6
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 162
    :try_start_0
    iget-object v5, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    .line 163
    .local v2, "pm":Landroid/content/pm/PackageManager;
    invoke-virtual {v2, p1}, Landroid/content/pm/PackageManager;->getApplicationEnabledSetting(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 164
    .local v1, "mComponentState":I
    if-eq v1, v4, :cond_0

    if-nez v1, :cond_1

    :cond_0
    move v3, v4

    .line 172
    .end local v1    # "mComponentState":I
    .end local v2    # "pm":Landroid/content/pm/PackageManager;
    :cond_1
    :goto_0
    return v3

    .line 170
    :catch_0
    move-exception v0

    .line 172
    .local v0, "e":Ljava/lang/Exception;
    goto :goto_0
.end method

.method private setClient(Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;)V
    .locals 0
    .param p1, "client"    # Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;

    .prologue
    .line 57
    iput-object p1, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mClient:Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;

    .line 58
    return-void
.end method

.method private declared-synchronized setupTranslateListener()V
    .locals 3

    .prologue
    .line 65
    monitor-enter p0

    :try_start_0
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 66
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "com.lge.texttranslate.EXIT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 67
    iget-object v1, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 68
    monitor-exit p0

    return-void

    .line 65
    .end local v0    # "filter":Landroid/content/IntentFilter;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method private translate(Ljava/lang/String;)V
    .locals 5
    .param p1, "text"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x1

    .line 98
    invoke-direct {p0}, Lcom/lge/webview/chromium/LGTranslateManager;->setupTranslateListener()V

    .line 100
    new-instance v1, Landroid/content/Intent;

    const-string v2, "com.lge.texttranslate"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 101
    .local v1, "i":Landroid/content/Intent;
    const-string v2, "textString"

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 102
    const-string v2, "enable"

    const-string v3, "com.lge.texttranslate"

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 103
    const-string v2, "isWebView"

    invoke-virtual {v1, v2, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 104
    const/high16 v2, 0x14000000

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 106
    iput-boolean v4, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateMode:Z

    .line 109
    :try_start_0
    iget-object v2, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v2, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 114
    :goto_0
    return-void

    .line 110
    :catch_0
    move-exception v0

    .line 111
    .local v0, "e":Landroid/content/ActivityNotFoundException;
    invoke-direct {p0}, Lcom/lge/webview/chromium/LGTranslateManager;->disableTranslateListener()V

    .line 112
    invoke-virtual {v0}, Landroid/content/ActivityNotFoundException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public getActionItem()Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
    .locals 2

    .prologue
    .line 154
    iget-object v0, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mSelectActionItem:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    if-nez v0, :cond_0

    .line 155
    new-instance v0, Lcom/lge/webview/chromium/LGTranslateManager$TranslateActionItem;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/lge/webview/chromium/LGTranslateManager$TranslateActionItem;-><init>(Lcom/lge/webview/chromium/LGTranslateManager;Lcom/lge/webview/chromium/LGTranslateManager$1;)V

    iput-object v0, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mSelectActionItem:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    .line 157
    :cond_0
    iget-object v0, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mSelectActionItem:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    return-object v0
.end method

.method public getTranslateMode()Z
    .locals 1

    .prologue
    .line 117
    iget-boolean v0, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateMode:Z

    return v0
.end method

.method public setTranslateMode(Z)V
    .locals 1
    .param p1, "flag"    # Z

    .prologue
    .line 121
    iget-boolean v0, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateMode:Z

    if-eq v0, p1, :cond_0

    .line 122
    iput-boolean p1, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mTranslateMode:Z

    .line 124
    :cond_0
    return-void
.end method

.method public translateSelection()V
    .locals 3

    .prologue
    .line 89
    iget-object v1, p0, Lcom/lge/webview/chromium/LGTranslateManager;->mClient:Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;

    invoke-interface {v1}, Lcom/lge/webview/chromium/ILGTranslateManager$LGTranslateClient;->getSelection()Ljava/lang/String;

    move-result-object v0

    .line 90
    .local v0, "text":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 91
    const-string v1, "LGTranslateManager"

    const-string v2, "translateSelection(): There is no selected text"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 95
    :goto_0
    return-void

    .line 94
    :cond_0
    invoke-direct {p0, v0}, Lcom/lge/webview/chromium/LGTranslateManager;->translate(Ljava/lang/String;)V

    goto :goto_0
.end method
