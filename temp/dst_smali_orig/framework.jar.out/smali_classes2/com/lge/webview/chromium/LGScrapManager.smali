.class public Lcom/lge/webview/chromium/LGScrapManager;
.super Ljava/lang/Object;
.source "LGScrapManager.java"

# interfaces
.implements Lcom/lge/webview/chromium/ILGScrapManager;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/webview/chromium/LGScrapManager$LGScrapActionItem;,
        Lcom/lge/webview/chromium/LGScrapManager$ClearCopiedImage;
    }
.end annotation


# static fields
.field private static final DEFAULT_FULL_THRESHOLD_BYTES:I = 0x1e00000

.field private static final LOGTAG:Ljava/lang/String; = "LGScrapManager"

.field private static final NOTEBOOK_PACKAGE:Ljava/lang/String; = "com.lge.Notebook"

.field private static final NOTEBOOK_WEBSCRAP_ACTIVITY:Ljava/lang/String; = "com.lge.Notebook.RNote_WebScrapActivity"

.field private static final SCRAP_IMAGEPATH:Ljava/lang/String; = "scrapImagePath"

.field private static final SCRAP_TITLE:Ljava/lang/String; = "scrapTitle"

.field private static final SCRAP_URL:Ljava/lang/String; = "scrapURL"

.field private static mScrapRootDir:Ljava/io/File;


# instance fields
.field private mClient:Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;

.field private mContext:Landroid/content/Context;

.field private mSelectActionItem:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;)V
    .locals 2
    .param p1, "c"    # Landroid/content/Context;
    .param p2, "client"    # Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/webview/chromium/LGScrapManager;->mSelectActionItem:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    iput-object p1, p0, Lcom/lge/webview/chromium/LGScrapManager;->mContext:Landroid/content/Context;

    if-nez p2, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "LGScrapClient cannot be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iput-object p2, p0, Lcom/lge/webview/chromium/LGScrapManager;->mClient:Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;

    return-void
.end method

.method static synthetic access$100(Lcom/lge/webview/chromium/LGScrapManager;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/webview/chromium/LGScrapManager;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/webview/chromium/LGScrapManager;->sendIntent(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$300(Lcom/lge/webview/chromium/LGScrapManager;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/webview/chromium/LGScrapManager;

    .prologue
    invoke-direct {p0}, Lcom/lge/webview/chromium/LGScrapManager;->isLowOnDisc()Z

    move-result v0

    return v0
.end method

.method static synthetic access$400(Lcom/lge/webview/chromium/LGScrapManager;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/lge/webview/chromium/LGScrapManager;

    .prologue
    iget-object v0, p0, Lcom/lge/webview/chromium/LGScrapManager;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$500(Lcom/lge/webview/chromium/LGScrapManager;)Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;
    .locals 1
    .param p0, "x0"    # Lcom/lge/webview/chromium/LGScrapManager;

    .prologue
    iget-object v0, p0, Lcom/lge/webview/chromium/LGScrapManager;->mClient:Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;

    return-object v0
.end method

.method private isLowOnDisc()Z
    .locals 8

    .prologue
    const-string v1, "/data"

    .local v1, "strDATA_PATH":Ljava/lang/String;
    new-instance v0, Landroid/os/StatFs;

    const-string v4, "/data"

    invoke-direct {v0, v4}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .local v0, "mDataFileStats":Landroid/os/StatFs;
    const-string v4, "/data"

    invoke-virtual {v0, v4}, Landroid/os/StatFs;->restat(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v4

    int-to-long v4, v4

    invoke-virtual {v0}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v6, v6

    mul-long v2, v4, v6

    .local v2, "mFreeMem":J
    const-wide/32 v4, 0x1e00000

    cmp-long v4, v2, v4

    if-gez v4, :cond_0

    const/4 v4, 0x1

    :goto_0
    return v4

    :cond_0
    const/4 v4, 0x0

    goto :goto_0
.end method

.method private makedir()V
    .locals 4

    .prologue
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v1

    const-string v2, "mounted"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    new-instance v1, Ljava/io/File;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    const-string v3, "WebScrap"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    sput-object v1, Lcom/lge/webview/chromium/LGScrapManager;->mScrapRootDir:Ljava/io/File;

    sget-object v1, Lcom/lge/webview/chromium/LGScrapManager;->mScrapRootDir:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    sget-object v1, Lcom/lge/webview/chromium/LGScrapManager;->mScrapRootDir:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->mkdir()Z

    :cond_0
    sget-object v1, Lcom/lge/webview/chromium/LGScrapManager;->mScrapRootDir:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->list()[Ljava/lang/String;

    move-result-object v0

    .local v0, "children":[Ljava/lang/String;
    if-eqz v0, :cond_1

    array-length v1, v0

    if-lez v1, :cond_1

    new-instance v1, Lcom/lge/webview/chromium/LGScrapManager$ClearCopiedImage;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lcom/lge/webview/chromium/LGScrapManager$ClearCopiedImage;-><init>(Lcom/lge/webview/chromium/LGScrapManager$1;)V

    sget-object v2, Lcom/lge/webview/chromium/LGScrapManager;->mScrapRootDir:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/lge/webview/chromium/LGScrapManager$ClearCopiedImage;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .end local v0    # "children":[Ljava/lang/String;
    :cond_1
    return-void
.end method

.method private saveBitmapToFileCache(Landroid/graphics/Bitmap;Ljava/lang/String;)V
    .locals 5
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "fileName"    # Ljava/lang/String;

    .prologue
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .local v1, "fileCacheItem":Ljava/io/File;
    if-nez v1, :cond_0

    :goto_0
    return-void

    :cond_0
    move-object v0, p1

    .local v0, "bitmap_copy":Landroid/graphics/Bitmap;
    move-object v2, p2

    .local v2, "fileName_copy":Ljava/lang/String;
    new-instance v3, Ljava/lang/Thread;

    new-instance v4, Lcom/lge/webview/chromium/LGScrapManager$1;

    invoke-direct {v4, p0, v1, v0, v2}, Lcom/lge/webview/chromium/LGScrapManager$1;-><init>(Lcom/lge/webview/chromium/LGScrapManager;Ljava/io/File;Landroid/graphics/Bitmap;Ljava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v3}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private sendIntent(Ljava/lang/String;)V
    .locals 6
    .param p1, "fileName"    # Ljava/lang/String;

    .prologue
    iget-object v4, p0, Lcom/lge/webview/chromium/LGScrapManager;->mClient:Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;

    invoke-interface {v4}, Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;->getTitle()Ljava/lang/String;

    move-result-object v2

    .local v2, "title":Ljava/lang/String;
    iget-object v4, p0, Lcom/lge/webview/chromium/LGScrapManager;->mClient:Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;

    invoke-interface {v4}, Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;->getUrl()Ljava/lang/String;

    move-result-object v3

    .local v3, "url":Ljava/lang/String;
    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1}, Landroid/content/Intent;-><init>()V

    .local v1, "i":Landroid/content/Intent;
    const-string v4, "android.intent.action.INSERT"

    invoke-virtual {v1, v4}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v4, "com.lge.Notebook"

    const-string v5, "com.lge.Notebook.RNote_WebScrapActivity"

    invoke-virtual {v1, v4, v5}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v4, "scrapTitle"

    invoke-virtual {v1, v4, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v4, "scrapURL"

    invoke-virtual {v1, v4, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v4, "scrapImagePath"

    invoke-virtual {v1, v4, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :try_start_0
    iget-object v4, p0, Lcom/lge/webview/chromium/LGScrapManager;->mContext:Landroid/content/Context;

    invoke-virtual {v4, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/content/ActivityNotFoundException;
    invoke-virtual {v0}, Landroid/content/ActivityNotFoundException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public getActionItem()Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/webview/chromium/LGScrapManager;->mSelectActionItem:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/webview/chromium/LGScrapManager$LGScrapActionItem;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/lge/webview/chromium/LGScrapManager$LGScrapActionItem;-><init>(Lcom/lge/webview/chromium/LGScrapManager;Lcom/lge/webview/chromium/LGScrapManager$1;)V

    iput-object v0, p0, Lcom/lge/webview/chromium/LGScrapManager;->mSelectActionItem:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    :cond_0
    iget-object v0, p0, Lcom/lge/webview/chromium/LGScrapManager;->mSelectActionItem:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    return-object v0
.end method

.method public declared-synchronized scrapSelection()V
    .locals 7

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v5, p0, Lcom/lge/webview/chromium/LGScrapManager;->mClient:Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;

    invoke-interface {v5}, Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;->getUrl()Ljava/lang/String;

    move-result-object v4

    .local v4, "url":Ljava/lang/String;
    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    .local v3, "uri":Landroid/net/Uri;
    invoke-virtual {v3}, Landroid/net/Uri;->getHost()Ljava/lang/String;

    move-result-object v1

    .local v1, "host":Ljava/lang/String;
    sget-object v5, Lcom/lge/webview/chromium/LGScrapManager;->mScrapRootDir:Ljava/io/File;

    if-nez v5, :cond_0

    invoke-direct {p0}, Lcom/lge/webview/chromium/LGScrapManager;->makedir()V

    :cond_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v6, Lcom/lge/webview/chromium/LGScrapManager;->mScrapRootDir:Ljava/io/File;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "/"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ".png"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "fileName":Ljava/lang/String;
    const/4 v2, 0x0

    .local v2, "image":Landroid/graphics/Bitmap;
    iget-object v5, p0, Lcom/lge/webview/chromium/LGScrapManager;->mClient:Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;

    invoke-interface {v5}, Lcom/lge/webview/chromium/ILGScrapManager$LGScrapClient;->getParagraphScreenShot()Landroid/graphics/Bitmap;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-direct {p0, v2, v0}, Lcom/lge/webview/chromium/LGScrapManager;->saveBitmapToFileCache(Landroid/graphics/Bitmap;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    monitor-exit p0

    return-void

    .end local v0    # "fileName":Ljava/lang/String;
    .end local v1    # "host":Ljava/lang/String;
    .end local v2    # "image":Landroid/graphics/Bitmap;
    .end local v3    # "uri":Landroid/net/Uri;
    .end local v4    # "url":Ljava/lang/String;
    :catchall_0
    move-exception v5

    monitor-exit p0

    throw v5
.end method
