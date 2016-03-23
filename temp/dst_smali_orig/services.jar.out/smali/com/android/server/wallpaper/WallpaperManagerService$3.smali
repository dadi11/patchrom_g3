.class Lcom/android/server/wallpaper/WallpaperManagerService$3;
.super Landroid/os/Handler;
.source "WallpaperManagerService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/wallpaper/WallpaperManagerService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/wallpaper/WallpaperManagerService;


# direct methods
.method constructor <init>(Lcom/android/server/wallpaper/WallpaperManagerService;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/android/server/wallpaper/WallpaperManagerService$3;->this$0:Lcom/android/server/wallpaper/WallpaperManagerService;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 19
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->what:I

    move/from16 v16, v0

    .local v16, "usrId":I
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/server/wallpaper/WallpaperManagerService$3;->this$0:Lcom/android/server/wallpaper/WallpaperManagerService;

    iget-object v2, v2, Lcom/android/server/wallpaper/WallpaperManagerService;->mWallpaperMap:Landroid/util/SparseArray;

    move/from16 v0, v16

    invoke-virtual {v2, v0}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/android/server/wallpaper/WallpaperManagerService$WallpaperData;

    .local v6, "wallpaper":Lcom/android/server/wallpaper/WallpaperManagerService$WallpaperData;
    if-nez v6, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v2, v6, Lcom/android/server/wallpaper/WallpaperManagerService$WallpaperData;->wallpaperFile:Ljava/io/File;

    if-eqz v2, :cond_0

    iget-object v2, v6, Lcom/android/server/wallpaper/WallpaperManagerService$WallpaperData;->wallpaperFile:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v11

    .local v11, "path":Ljava/lang/String;
    invoke-static {v11}, Lcom/lge/lgdrm/DrmManager;->isDRM(Ljava/lang/String;)I

    move-result v9

    .local v9, "drmType":I
    const/16 v2, 0x10

    if-lt v9, v2, :cond_0

    const/16 v2, 0x3000

    if-gt v9, v2, :cond_0

    const/4 v2, 0x0

    :try_start_0
    invoke-static {v11, v2}, Lcom/lge/lgdrm/DrmManager;->createContentSession(Ljava/lang/String;Landroid/content/Context;)Lcom/lge/lgdrm/DrmContentSession;

    move-result-object v13

    .local v13, "session":Lcom/lge/lgdrm/DrmContentSession;
    if-eqz v13, :cond_0

    const/4 v2, 0x3

    invoke-virtual {v13, v2}, Lcom/lge/lgdrm/DrmContentSession;->isActionSupported(I)Z

    move-result v2

    if-nez v2, :cond_2

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/server/wallpaper/WallpaperManagerService$3;->this$0:Lcom/android/server/wallpaper/WallpaperManagerService;

    # invokes: Lcom/android/server/wallpaper/WallpaperManagerService;->notifyCallbacksLocked(Lcom/android/server/wallpaper/WallpaperManagerService$WallpaperData;)V
    invoke-static {v2, v6}, Lcom/android/server/wallpaper/WallpaperManagerService;->access$100(Lcom/android/server/wallpaper/WallpaperManagerService;Lcom/android/server/wallpaper/WallpaperManagerService$WallpaperData;)V

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/server/wallpaper/WallpaperManagerService$3;->this$0:Lcom/android/server/wallpaper/WallpaperManagerService;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/server/wallpaper/WallpaperManagerService$3;->this$0:Lcom/android/server/wallpaper/WallpaperManagerService;

    iget-object v3, v3, Lcom/android/server/wallpaper/WallpaperManagerService;->mImageWallpaper:Landroid/content/ComponentName;

    const/4 v4, 0x1

    const/4 v5, 0x0

    const/4 v7, 0x0

    invoke-virtual/range {v2 .. v7}, Lcom/android/server/wallpaper/WallpaperManagerService;->bindWallpaperComponentLocked(Landroid/content/ComponentName;ZZLcom/android/server/wallpaper/WallpaperManagerService$WallpaperData;Landroid/os/IRemoteCallback;)Z

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/server/wallpaper/WallpaperManagerService$3;->this$0:Lcom/android/server/wallpaper/WallpaperManagerService;

    # invokes: Lcom/android/server/wallpaper/WallpaperManagerService;->saveSettingsLocked(Lcom/android/server/wallpaper/WallpaperManagerService$WallpaperData;)V
    invoke-static {v2, v6}, Lcom/android/server/wallpaper/WallpaperManagerService;->access$200(Lcom/android/server/wallpaper/WallpaperManagerService;Lcom/android/server/wallpaper/WallpaperManagerService$WallpaperData;)V

    goto :goto_0

    .end local v13    # "session":Lcom/lge/lgdrm/DrmContentSession;
    :catch_0
    move-exception v2

    goto :goto_0

    .restart local v13    # "session":Lcom/lge/lgdrm/DrmContentSession;
    :cond_2
    const/16 v17, 0x0

    .local v17, "validFor":Ljava/lang/String;
    invoke-virtual {v13}, Lcom/lge/lgdrm/DrmContentSession;->getDrmTime()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    invoke-virtual {v13, v2, v3, v4, v5}, Lcom/lge/lgdrm/DrmContentSession;->consumeRight(JJ)I

    const/4 v2, 0x1

    invoke-virtual {v13, v2}, Lcom/lge/lgdrm/DrmContentSession;->getSelectedRight(Z)Lcom/lge/lgdrm/DrmRight;

    move-result-object v12

    .local v12, "right":Lcom/lge/lgdrm/DrmRight;
    if-eqz v12, :cond_3

    invoke-virtual {v12}, Lcom/lge/lgdrm/DrmRight;->isUnlimited()Z

    move-result v2

    if-nez v2, :cond_3

    const/4 v2, 0x1

    invoke-virtual {v12, v2}, Lcom/lge/lgdrm/DrmRight;->getSummaryInfo(I)Ljava/lang/String;

    move-result-object v17

    :cond_3
    if-eqz v17, :cond_0

    const-string v2, " "

    move-object/from16 v0, v17

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v10

    .local v10, "list":[Ljava/lang/String;
    const/4 v8, 0x0

    .local v8, "count":I
    const-wide/16 v14, 0x0

    .local v14, "sum":J
    const/16 v18, 0x0

    .local v18, "value":I
    :goto_1
    if-eqz v10, :cond_8

    array-length v2, v10

    if-ge v8, v2, :cond_8

    aget-object v2, v10, v8

    const-string v3, "day"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    const v2, 0x15180

    mul-int v2, v2, v18

    int-to-long v2, v2

    add-long/2addr v14, v2

    :goto_2
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    :cond_4
    aget-object v2, v10, v8

    const-string v3, "hour"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    move/from16 v0, v18

    mul-int/lit16 v2, v0, 0xe10

    int-to-long v2, v2

    add-long/2addr v14, v2

    goto :goto_2

    :cond_5
    aget-object v2, v10, v8

    const-string v3, "min"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    mul-int/lit8 v2, v18, 0x3c

    int-to-long v2, v2

    add-long/2addr v14, v2

    goto :goto_2

    :cond_6
    aget-object v2, v10, v8

    const-string v3, "sec"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_7

    add-int/lit8 v2, v18, 0x3

    int-to-long v2, v2

    add-long/2addr v14, v2

    goto :goto_2

    :cond_7
    aget-object v2, v10, v8

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v18

    goto :goto_2

    :cond_8
    const-wide/16 v2, 0x0

    cmp-long v2, v14, v2

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/server/wallpaper/WallpaperManagerService$3;->this$0:Lcom/android/server/wallpaper/WallpaperManagerService;

    # getter for: Lcom/android/server/wallpaper/WallpaperManagerService;->mDrmHandler:Landroid/os/Handler;
    invoke-static {v3}, Lcom/android/server/wallpaper/WallpaperManagerService;->access$300(Lcom/android/server/wallpaper/WallpaperManagerService;)Landroid/os/Handler;

    move-result-object v3

    const-wide/16 v4, 0x3e8

    mul-long/2addr v4, v14

    move/from16 v0, v16

    invoke-virtual {v3, v0, v4, v5}, Landroid/os/Handler;->sendEmptyMessageDelayed(IJ)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    if-ne v2, v3, :cond_0

    goto/16 :goto_0
.end method
