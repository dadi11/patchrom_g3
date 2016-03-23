.class Lcom/lge/webview/chromium/LGScrapManager$1;
.super Ljava/lang/Object;
.source "LGScrapManager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/webview/chromium/LGScrapManager;->saveBitmapToFileCache(Landroid/graphics/Bitmap;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/webview/chromium/LGScrapManager;

.field final synthetic val$bitmap_copy:Landroid/graphics/Bitmap;

.field final synthetic val$fileCacheItem:Ljava/io/File;

.field final synthetic val$fileName_copy:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/lge/webview/chromium/LGScrapManager;Ljava/io/File;Landroid/graphics/Bitmap;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 141
    iput-object p1, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    iput-object p2, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileCacheItem:Ljava/io/File;

    iput-object p3, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$bitmap_copy:Landroid/graphics/Bitmap;

    iput-object p4, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileName_copy:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .prologue
    const/4 v7, 0x1

    .line 143
    const/4 v1, 0x0

    .line 144
    .local v1, "out":Ljava/io/OutputStream;
    const/4 v3, 0x1

    .line 146
    .local v3, "send":Z
    :try_start_0
    new-instance v2, Ljava/io/FileOutputStream;

    iget-object v4, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileCacheItem:Ljava/io/File;

    invoke-direct {v2, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 147
    .end local v1    # "out":Ljava/io/OutputStream;
    .local v2, "out":Ljava/io/OutputStream;
    :try_start_1
    iget-object v4, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$bitmap_copy:Landroid/graphics/Bitmap;

    sget-object v5, Landroid/graphics/Bitmap$CompressFormat;->PNG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v6, 0x64

    invoke-virtual {v4, v5, v6, v2}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 148
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    .line 153
    if-eqz v2, :cond_6

    .line 155
    :try_start_2
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 161
    if-ne v3, v7, :cond_0

    .line 162
    iget-object v4, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    iget-object v5, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileName_copy:Ljava/lang/String;

    # invokes: Lcom/lge/webview/chromium/LGScrapManager;->sendIntent(Ljava/lang/String;)V
    invoke-static {v4, v5}, Lcom/lge/webview/chromium/LGScrapManager;->access$100(Lcom/lge/webview/chromium/LGScrapManager;Ljava/lang/String;)V

    :cond_0
    :goto_0
    move-object v1, v2

    .line 167
    .end local v2    # "out":Ljava/io/OutputStream;
    .restart local v1    # "out":Ljava/io/OutputStream;
    :cond_1
    :goto_1
    return-void

    .line 156
    .end local v1    # "out":Ljava/io/OutputStream;
    .restart local v2    # "out":Ljava/io/OutputStream;
    :catch_0
    move-exception v0

    .line 158
    .local v0, "e":Ljava/lang/Exception;
    :try_start_3
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 159
    const/4 v3, 0x0

    .line 161
    if-ne v3, v7, :cond_0

    .line 162
    iget-object v4, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    iget-object v5, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileName_copy:Ljava/lang/String;

    # invokes: Lcom/lge/webview/chromium/LGScrapManager;->sendIntent(Ljava/lang/String;)V
    invoke-static {v4, v5}, Lcom/lge/webview/chromium/LGScrapManager;->access$100(Lcom/lge/webview/chromium/LGScrapManager;Ljava/lang/String;)V

    goto :goto_0

    .line 161
    .end local v0    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v4

    if-ne v3, v7, :cond_2

    .line 162
    iget-object v5, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    iget-object v6, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileName_copy:Ljava/lang/String;

    # invokes: Lcom/lge/webview/chromium/LGScrapManager;->sendIntent(Ljava/lang/String;)V
    invoke-static {v5, v6}, Lcom/lge/webview/chromium/LGScrapManager;->access$100(Lcom/lge/webview/chromium/LGScrapManager;Ljava/lang/String;)V

    :cond_2
    throw v4

    .line 149
    .end local v2    # "out":Ljava/io/OutputStream;
    .restart local v1    # "out":Ljava/io/OutputStream;
    :catch_1
    move-exception v0

    .line 150
    .restart local v0    # "e":Ljava/lang/Exception;
    :goto_2
    :try_start_4
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 151
    const/4 v3, 0x0

    .line 153
    if-eqz v1, :cond_1

    .line 155
    :try_start_5
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 161
    if-ne v3, v7, :cond_1

    .line 162
    iget-object v4, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    iget-object v5, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileName_copy:Ljava/lang/String;

    # invokes: Lcom/lge/webview/chromium/LGScrapManager;->sendIntent(Ljava/lang/String;)V
    invoke-static {v4, v5}, Lcom/lge/webview/chromium/LGScrapManager;->access$100(Lcom/lge/webview/chromium/LGScrapManager;Ljava/lang/String;)V

    goto :goto_1

    .line 156
    :catch_2
    move-exception v0

    .line 158
    :try_start_6
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 159
    const/4 v3, 0x0

    .line 161
    if-ne v3, v7, :cond_1

    .line 162
    iget-object v4, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    iget-object v5, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileName_copy:Ljava/lang/String;

    # invokes: Lcom/lge/webview/chromium/LGScrapManager;->sendIntent(Ljava/lang/String;)V
    invoke-static {v4, v5}, Lcom/lge/webview/chromium/LGScrapManager;->access$100(Lcom/lge/webview/chromium/LGScrapManager;Ljava/lang/String;)V

    goto :goto_1

    .line 161
    :catchall_1
    move-exception v4

    if-ne v3, v7, :cond_3

    .line 162
    iget-object v5, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    iget-object v6, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileName_copy:Ljava/lang/String;

    # invokes: Lcom/lge/webview/chromium/LGScrapManager;->sendIntent(Ljava/lang/String;)V
    invoke-static {v5, v6}, Lcom/lge/webview/chromium/LGScrapManager;->access$100(Lcom/lge/webview/chromium/LGScrapManager;Ljava/lang/String;)V

    :cond_3
    throw v4

    .line 153
    .end local v0    # "e":Ljava/lang/Exception;
    :catchall_2
    move-exception v4

    :goto_3
    if-eqz v1, :cond_4

    .line 155
    :try_start_7
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    .line 161
    if-ne v3, v7, :cond_4

    .line 162
    iget-object v5, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    iget-object v6, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileName_copy:Ljava/lang/String;

    # invokes: Lcom/lge/webview/chromium/LGScrapManager;->sendIntent(Ljava/lang/String;)V
    invoke-static {v5, v6}, Lcom/lge/webview/chromium/LGScrapManager;->access$100(Lcom/lge/webview/chromium/LGScrapManager;Ljava/lang/String;)V

    :cond_4
    :goto_4
    throw v4

    .line 156
    :catch_3
    move-exception v0

    .line 158
    .restart local v0    # "e":Ljava/lang/Exception;
    :try_start_8
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 159
    const/4 v3, 0x0

    .line 161
    if-ne v3, v7, :cond_4

    .line 162
    iget-object v5, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    iget-object v6, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileName_copy:Ljava/lang/String;

    # invokes: Lcom/lge/webview/chromium/LGScrapManager;->sendIntent(Ljava/lang/String;)V
    invoke-static {v5, v6}, Lcom/lge/webview/chromium/LGScrapManager;->access$100(Lcom/lge/webview/chromium/LGScrapManager;Ljava/lang/String;)V

    goto :goto_4

    .line 161
    .end local v0    # "e":Ljava/lang/Exception;
    :catchall_3
    move-exception v4

    if-ne v3, v7, :cond_5

    .line 162
    iget-object v5, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->this$0:Lcom/lge/webview/chromium/LGScrapManager;

    iget-object v6, p0, Lcom/lge/webview/chromium/LGScrapManager$1;->val$fileName_copy:Ljava/lang/String;

    # invokes: Lcom/lge/webview/chromium/LGScrapManager;->sendIntent(Ljava/lang/String;)V
    invoke-static {v5, v6}, Lcom/lge/webview/chromium/LGScrapManager;->access$100(Lcom/lge/webview/chromium/LGScrapManager;Ljava/lang/String;)V

    :cond_5
    throw v4

    .line 153
    .end local v1    # "out":Ljava/io/OutputStream;
    .restart local v2    # "out":Ljava/io/OutputStream;
    :catchall_4
    move-exception v4

    move-object v1, v2

    .end local v2    # "out":Ljava/io/OutputStream;
    .restart local v1    # "out":Ljava/io/OutputStream;
    goto :goto_3

    .line 149
    .end local v1    # "out":Ljava/io/OutputStream;
    .restart local v2    # "out":Ljava/io/OutputStream;
    :catch_4
    move-exception v0

    move-object v1, v2

    .end local v2    # "out":Ljava/io/OutputStream;
    .restart local v1    # "out":Ljava/io/OutputStream;
    goto :goto_2

    .end local v1    # "out":Ljava/io/OutputStream;
    .restart local v2    # "out":Ljava/io/OutputStream;
    :cond_6
    move-object v1, v2

    .end local v2    # "out":Ljava/io/OutputStream;
    .restart local v1    # "out":Ljava/io/OutputStream;
    goto :goto_1
.end method
