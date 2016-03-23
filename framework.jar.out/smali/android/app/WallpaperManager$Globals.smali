.class Landroid/app/WallpaperManager$Globals;
.super Landroid/app/IWallpaperManagerCallback$Stub;
.source "WallpaperManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/app/WallpaperManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "Globals"
.end annotation


# static fields
.field private static final MSG_CLEAR_WALLPAPER:I = 0x1


# instance fields
.field private mDefaultWallpaper:Landroid/graphics/Bitmap;

.field private mService:Landroid/app/IWallpaperManager;

.field private mWallpaper:Landroid/graphics/Bitmap;


# direct methods
.method constructor <init>(Landroid/os/Looper;)V
    .locals 2
    .param p1, "looper"    # Landroid/os/Looper;

    .prologue
    .line 261
    invoke-direct {p0}, Landroid/app/IWallpaperManagerCallback$Stub;-><init>()V

    .line 262
    const-string/jumbo v1, "wallpaper"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .line 263
    .local v0, "b":Landroid/os/IBinder;
    invoke-static {v0}, Landroid/app/IWallpaperManager$Stub;->asInterface(Landroid/os/IBinder;)Landroid/app/IWallpaperManager;

    move-result-object v1

    iput-object v1, p0, Landroid/app/WallpaperManager$Globals;->mService:Landroid/app/IWallpaperManager;

    .line 264
    return-void
.end method

.method static synthetic access$500(Landroid/app/WallpaperManager$Globals;)Landroid/app/IWallpaperManager;
    .locals 1
    .param p0, "x0"    # Landroid/app/WallpaperManager$Globals;

    .prologue
    .line 254
    iget-object v0, p0, Landroid/app/WallpaperManager$Globals;->mService:Landroid/app/IWallpaperManager;

    return-object v0
.end method

.method private getCurrentWallpaperLocked(Landroid/content/Context;)Landroid/graphics/Bitmap;
    .locals 17
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 312
    move-object/from16 v0, p0

    iget-object v14, v0, Landroid/app/WallpaperManager$Globals;->mService:Landroid/app/IWallpaperManager;

    if-nez v14, :cond_1

    .line 313
    # getter for: Landroid/app/WallpaperManager;->TAG:Ljava/lang/String;
    invoke-static {}, Landroid/app/WallpaperManager;->access$000()Ljava/lang/String;

    move-result-object v14

    const-string v15, "WallpaperService not running"

    invoke-static {v14, v15}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 314
    const/4 v14, 0x0

    .line 400
    :cond_0
    :goto_0
    return-object v14

    .line 318
    :cond_1
    :try_start_0
    new-instance v10, Landroid/os/Bundle;

    invoke-direct {v10}, Landroid/os/Bundle;-><init>()V

    .line 319
    .local v10, "params":Landroid/os/Bundle;
    move-object/from16 v0, p0

    iget-object v14, v0, Landroid/app/WallpaperManager$Globals;->mService:Landroid/app/IWallpaperManager;

    move-object/from16 v0, p0

    invoke-interface {v14, v0, v10}, Landroid/app/IWallpaperManager;->getWallpaper(Landroid/app/IWallpaperManagerCallback;Landroid/os/Bundle;)Landroid/os/ParcelFileDescriptor;

    move-result-object v4

    .line 320
    .local v4, "fd":Landroid/os/ParcelFileDescriptor;
    if-eqz v4, :cond_8

    .line 321
    const-string/jumbo v14, "width"

    const/4 v15, 0x0

    invoke-virtual {v10, v14, v15}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v13

    .line 322
    .local v13, "width":I
    const-string v14, "height"

    const/4 v15, 0x0

    invoke-virtual {v10, v14, v15}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v5

    .line 323
    .local v5, "height":I
    const-string v14, "isGIF"

    const/4 v15, 0x0

    invoke-virtual {v10, v14, v15}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v8

    .line 325
    .local v8, "isGIF":Z
    sget-boolean v14, Lcom/lge/config/ConfigBuildFlags;->CAPP_DRM:Z

    if-eqz v14, :cond_9

    .line 326
    const-string v14, "drmKey"

    invoke-virtual {v10, v14}, Landroid/os/Bundle;->getByteArray(Ljava/lang/String;)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_5

    move-result-object v2

    .line 327
    .local v2, "decInfo":[B
    if-eqz v2, :cond_9

    .line 328
    const/4 v7, 0x0

    .line 330
    .local v7, "is":Ljava/io/InputStream;
    :try_start_1
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v14

    invoke-static {v14, v2}, Lcom/lge/lgdrm/DrmContentSession;->openDrmStream(Ljava/io/FileDescriptor;[B)Lcom/lge/lgdrm/DrmStream;
    :try_end_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v7

    .line 331
    if-nez v7, :cond_2

    .line 332
    const/4 v14, 0x0

    .line 361
    :try_start_2
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->close()V

    .line 362
    if-eqz v7, :cond_0

    .line 363
    invoke-virtual {v7}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_5

    goto :goto_0

    .line 365
    :catch_0
    move-exception v15

    goto :goto_0

    .line 335
    :cond_2
    const/4 v11, 0x0

    .line 336
    .local v11, "sampleSize":I
    :try_start_3
    invoke-virtual {v7}, Ljava/io/InputStream;->available()I

    move-result v12

    .line 341
    .local v12, "size":I
    const v14, 0x4b000

    if-lt v12, v14, :cond_4

    .line 342
    const/4 v6, 0x0

    .line 343
    .local v6, "i":I
    const/4 v6, 0x2

    :goto_1
    div-int v14, v12, v6

    const v15, 0x4b000

    if-le v14, v15, :cond_3

    .line 345
    mul-int/lit8 v6, v6, 0x2

    goto :goto_1

    .line 347
    :cond_3
    move v11, v6

    .line 350
    .end local v6    # "i":I
    :cond_4
    new-instance v9, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v9}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 351
    .local v9, "options":Landroid/graphics/BitmapFactory$Options;
    if-eqz v11, :cond_5

    .line 352
    iput v11, v9, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 354
    :cond_5
    const/4 v14, 0x0

    invoke-static {v7, v14, v9}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 355
    .local v1, "bm":Landroid/graphics/Bitmap;
    move-object/from16 v0, p1

    invoke-static {v0, v1, v13, v5}, Landroid/app/WallpaperManager;->generateBitmap(Landroid/content/Context;Landroid/graphics/Bitmap;II)Landroid/graphics/Bitmap;
    :try_end_3
    .catch Ljava/lang/OutOfMemoryError; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result-object v14

    .line 361
    :try_start_4
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->close()V

    .line 362
    if-eqz v7, :cond_0

    .line 363
    invoke-virtual {v7}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Landroid/os/RemoteException; {:try_start_4 .. :try_end_4} :catch_5

    goto :goto_0

    .line 365
    :catch_1
    move-exception v15

    goto :goto_0

    .line 356
    .end local v1    # "bm":Landroid/graphics/Bitmap;
    .end local v9    # "options":Landroid/graphics/BitmapFactory$Options;
    .end local v11    # "sampleSize":I
    .end local v12    # "size":I
    :catch_2
    move-exception v3

    .line 357
    .local v3, "e":Ljava/lang/OutOfMemoryError;
    :try_start_5
    # getter for: Landroid/app/WallpaperManager;->TAG:Ljava/lang/String;
    invoke-static {}, Landroid/app/WallpaperManager;->access$000()Ljava/lang/String;

    move-result-object v14

    const-string v15, "Can\'t decode file"

    invoke-static {v14, v15, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 361
    :try_start_6
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->close()V

    .line 362
    if-eqz v7, :cond_6

    .line 363
    invoke-virtual {v7}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_c
    .catch Landroid/os/RemoteException; {:try_start_6 .. :try_end_6} :catch_5

    .line 368
    .end local v3    # "e":Ljava/lang/OutOfMemoryError;
    :cond_6
    :goto_2
    const/4 v14, 0x0

    goto/16 :goto_0

    .line 358
    :catch_3
    move-exception v14

    .line 361
    :try_start_7
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->close()V

    .line 362
    if-eqz v7, :cond_6

    .line 363
    invoke-virtual {v7}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_4
    .catch Landroid/os/RemoteException; {:try_start_7 .. :try_end_7} :catch_5

    goto :goto_2

    .line 365
    :catch_4
    move-exception v14

    goto :goto_2

    .line 360
    :catchall_0
    move-exception v14

    .line 361
    :try_start_8
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->close()V

    .line 362
    if-eqz v7, :cond_7

    .line 363
    invoke-virtual {v7}, Ljava/io/InputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_b
    .catch Landroid/os/RemoteException; {:try_start_8 .. :try_end_8} :catch_5

    .line 366
    :cond_7
    :goto_3
    :try_start_9
    throw v14
    :try_end_9
    .catch Landroid/os/RemoteException; {:try_start_9 .. :try_end_9} :catch_5

    .line 397
    .end local v2    # "decInfo":[B
    .end local v4    # "fd":Landroid/os/ParcelFileDescriptor;
    .end local v5    # "height":I
    .end local v7    # "is":Ljava/io/InputStream;
    .end local v8    # "isGIF":Z
    .end local v10    # "params":Landroid/os/Bundle;
    .end local v13    # "width":I
    :catch_5
    move-exception v14

    .line 400
    :cond_8
    :goto_4
    const/4 v14, 0x0

    goto/16 :goto_0

    .line 374
    .restart local v4    # "fd":Landroid/os/ParcelFileDescriptor;
    .restart local v5    # "height":I
    .restart local v8    # "isGIF":Z
    .restart local v10    # "params":Landroid/os/Bundle;
    .restart local v13    # "width":I
    :cond_9
    :try_start_a
    new-instance v9, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v9}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 376
    .restart local v9    # "options":Landroid/graphics/BitmapFactory$Options;
    if-eqz v8, :cond_b

    .line 377
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v14

    const/4 v15, 0x0

    invoke-static {v14, v15, v9}, Landroid/graphics/BitmapFactory;->decodeFileDescriptor(Ljava/io/FileDescriptor;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 379
    .restart local v1    # "bm":Landroid/graphics/Bitmap;
    if-eqz v1, :cond_a

    .line 380
    # getter for: Landroid/app/WallpaperManager;->TAG:Ljava/lang/String;
    invoke-static {}, Landroid/app/WallpaperManager;->access$000()Ljava/lang/String;

    move-result-object v14

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "bm   width="

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, ", height="

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 382
    :cond_a
    move-object/from16 v0, p1

    invoke-static {v0, v1, v13, v5}, Landroid/app/WallpaperManager;->generateBitmap(Landroid/content/Context;Landroid/graphics/Bitmap;II)Landroid/graphics/Bitmap;
    :try_end_a
    .catch Ljava/lang/OutOfMemoryError; {:try_start_a .. :try_end_a} :catch_8
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    move-result-object v14

    .line 391
    :try_start_b
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_6
    .catch Landroid/os/RemoteException; {:try_start_b .. :try_end_b} :catch_5

    goto/16 :goto_0

    .line 392
    :catch_6
    move-exception v15

    goto/16 :goto_0

    .line 384
    .end local v1    # "bm":Landroid/graphics/Bitmap;
    :cond_b
    :try_start_c
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v14

    const/4 v15, 0x0

    invoke-static {v14, v15, v9}, Landroid/graphics/BitmapFactory;->decodeFileDescriptor(Ljava/io/FileDescriptor;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;
    :try_end_c
    .catch Ljava/lang/OutOfMemoryError; {:try_start_c .. :try_end_c} :catch_8
    .catchall {:try_start_c .. :try_end_c} :catchall_1

    move-result-object v14

    .line 391
    :try_start_d
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_d
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_d} :catch_7
    .catch Landroid/os/RemoteException; {:try_start_d .. :try_end_d} :catch_5

    goto/16 :goto_0

    .line 392
    :catch_7
    move-exception v15

    goto/16 :goto_0

    .line 387
    .end local v9    # "options":Landroid/graphics/BitmapFactory$Options;
    :catch_8
    move-exception v3

    .line 388
    .restart local v3    # "e":Ljava/lang/OutOfMemoryError;
    :try_start_e
    # getter for: Landroid/app/WallpaperManager;->TAG:Ljava/lang/String;
    invoke-static {}, Landroid/app/WallpaperManager;->access$000()Ljava/lang/String;

    move-result-object v14

    const-string v15, "Can\'t decode file"

    invoke-static {v14, v15, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_1

    .line 391
    :try_start_f
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_f
    .catch Ljava/io/IOException; {:try_start_f .. :try_end_f} :catch_9
    .catch Landroid/os/RemoteException; {:try_start_f .. :try_end_f} :catch_5

    goto :goto_4

    .line 392
    :catch_9
    move-exception v14

    goto :goto_4

    .line 390
    .end local v3    # "e":Ljava/lang/OutOfMemoryError;
    :catchall_1
    move-exception v14

    .line 391
    :try_start_10
    invoke-virtual {v4}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_10
    .catch Ljava/io/IOException; {:try_start_10 .. :try_end_10} :catch_a
    .catch Landroid/os/RemoteException; {:try_start_10 .. :try_end_10} :catch_5

    .line 394
    :goto_5
    :try_start_11
    throw v14
    :try_end_11
    .catch Landroid/os/RemoteException; {:try_start_11 .. :try_end_11} :catch_5

    .line 392
    :catch_a
    move-exception v15

    goto :goto_5

    .line 365
    .restart local v2    # "decInfo":[B
    .restart local v7    # "is":Ljava/io/InputStream;
    :catch_b
    move-exception v15

    goto :goto_3

    .restart local v3    # "e":Ljava/lang/OutOfMemoryError;
    :catch_c
    move-exception v14

    goto/16 :goto_2
.end method

.method private getDefaultWallpaperLocked(Landroid/content/Context;)Landroid/graphics/Bitmap;
    .locals 7
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v5, 0x0

    .line 406
    const/4 v2, 0x0

    .line 407
    .local v2, "is":Ljava/io/InputStream;
    :try_start_0
    const-string/jumbo v4, "ro.lge.device_color"

    invoke-static {v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 408
    .local v0, "deviceColor":Ljava/lang/String;
    const-string v4, "BL"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 409
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    sget v6, Lcom/lge/internal/R$drawable;->default_wallpaper_kddi_blue:I

    invoke-virtual {v4, v6}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    .line 435
    :goto_0
    if-eqz v2, :cond_8

    .line 437
    :try_start_1
    new-instance v3, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v3}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 438
    .local v3, "options":Landroid/graphics/BitmapFactory$Options;
    const/4 v4, 0x0

    invoke-static {v2, v4, v3}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;
    :try_end_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v4

    .line 443
    :try_start_2
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 453
    .end local v0    # "deviceColor":Ljava/lang/String;
    .end local v3    # "options":Landroid/graphics/BitmapFactory$Options;
    :goto_1
    return-object v4

    .line 411
    .restart local v0    # "deviceColor":Ljava/lang/String;
    :cond_0
    :try_start_3
    const-string v4, "PK"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 412
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    sget v6, Lcom/lge/internal/R$drawable;->default_wallpaper_kddi_pink:I

    invoke-virtual {v4, v6}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v2

    goto :goto_0

    .line 414
    :cond_1
    const-string v4, "WH"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 415
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    sget v6, Lcom/lge/internal/R$drawable;->default_wallpaper_kddi_white:I

    invoke-virtual {v4, v6}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v2

    goto :goto_0

    .line 417
    :cond_2
    const-string v4, "BK"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 418
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    sget v6, Lcom/lge/internal/R$drawable;->default_wallpaper_kddi_black:I

    invoke-virtual {v4, v6}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v2

    goto :goto_0

    .line 420
    :cond_3
    const-string v4, "PG"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 421
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    sget v6, Lcom/lge/internal/R$drawable;->default_wallpaper_kddi_pinkgold:I

    invoke-virtual {v4, v6}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v2

    goto :goto_0

    .line 423
    :cond_4
    const-string v4, "AQ"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 424
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    sget v6, Lcom/lge/internal/R$drawable;->default_wallpaper_kddi_aqua:I

    invoke-virtual {v4, v6}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v2

    goto :goto_0

    .line 427
    :cond_5
    # getter for: Landroid/app/WallpaperManager;->LRA_OPERATOR:Z
    invoke-static {}, Landroid/app/WallpaperManager;->access$100()Z

    move-result v4

    if-eqz v4, :cond_6

    .line 428
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    # invokes: Landroid/app/WallpaperManager;->getLraCustomWallpaper()I
    invoke-static {}, Landroid/app/WallpaperManager;->access$200()I

    move-result v6

    invoke-virtual {v4, v6}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v2

    goto/16 :goto_0

    .line 429
    :cond_6
    # getter for: Landroid/app/WallpaperManager;->ACG_OPERATOR:Z
    invoke-static {}, Landroid/app/WallpaperManager;->access$300()Z

    move-result v4

    if-eqz v4, :cond_7

    .line 430
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    # invokes: Landroid/app/WallpaperManager;->getAcgCustomWallpaper()I
    invoke-static {}, Landroid/app/WallpaperManager;->access$400()I

    move-result v6

    invoke-virtual {v4, v6}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v2

    goto/16 :goto_0

    .line 433
    :cond_7
    invoke-static {p1}, Landroid/app/WallpaperManager;->openDefaultWallpaper(Landroid/content/Context;)Ljava/io/InputStream;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    move-result-object v2

    goto/16 :goto_0

    .line 439
    :catch_0
    move-exception v1

    .line 440
    .local v1, "e":Ljava/lang/OutOfMemoryError;
    :try_start_4
    # getter for: Landroid/app/WallpaperManager;->TAG:Ljava/lang/String;
    invoke-static {}, Landroid/app/WallpaperManager;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v6, "Can\'t decode stream"

    invoke-static {v4, v6, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 443
    :try_start_5
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1

    .end local v0    # "deviceColor":Ljava/lang/String;
    .end local v1    # "e":Ljava/lang/OutOfMemoryError;
    :cond_8
    :goto_2
    move-object v4, v5

    .line 453
    goto/16 :goto_1

    .line 442
    .restart local v0    # "deviceColor":Ljava/lang/String;
    :catchall_0
    move-exception v4

    .line 443
    :try_start_6
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_4
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    .line 446
    :goto_3
    :try_start_7
    throw v4
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_1

    .line 449
    .end local v0    # "deviceColor":Ljava/lang/String;
    :catch_1
    move-exception v4

    goto :goto_2

    .line 444
    .restart local v0    # "deviceColor":Ljava/lang/String;
    .restart local v3    # "options":Landroid/graphics/BitmapFactory$Options;
    :catch_2
    move-exception v5

    goto/16 :goto_1

    .end local v3    # "options":Landroid/graphics/BitmapFactory$Options;
    .restart local v1    # "e":Ljava/lang/OutOfMemoryError;
    :catch_3
    move-exception v4

    goto :goto_2

    .end local v1    # "e":Ljava/lang/OutOfMemoryError;
    :catch_4
    move-exception v6

    goto :goto_3
.end method


# virtual methods
.method public forgetLoadedWallpaper()V
    .locals 1

    .prologue
    .line 305
    monitor-enter p0

    .line 306
    const/4 v0, 0x0

    :try_start_0
    iput-object v0, p0, Landroid/app/WallpaperManager$Globals;->mWallpaper:Landroid/graphics/Bitmap;

    .line 307
    const/4 v0, 0x0

    iput-object v0, p0, Landroid/app/WallpaperManager$Globals;->mDefaultWallpaper:Landroid/graphics/Bitmap;

    .line 308
    monitor-exit p0

    .line 309
    return-void

    .line 308
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public onWallpaperChanged()V
    .locals 1

    .prologue
    .line 272
    monitor-enter p0

    .line 273
    const/4 v0, 0x0

    :try_start_0
    iput-object v0, p0, Landroid/app/WallpaperManager$Globals;->mWallpaper:Landroid/graphics/Bitmap;

    .line 274
    const/4 v0, 0x0

    iput-object v0, p0, Landroid/app/WallpaperManager$Globals;->mDefaultWallpaper:Landroid/graphics/Bitmap;

    .line 275
    monitor-exit p0

    .line 276
    return-void

    .line 275
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public peekWallpaperBitmap(Landroid/content/Context;Z)Landroid/graphics/Bitmap;
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "returnDefault"    # Z

    .prologue
    .line 279
    monitor-enter p0

    .line 280
    :try_start_0
    iget-object v1, p0, Landroid/app/WallpaperManager$Globals;->mWallpaper:Landroid/graphics/Bitmap;

    if-eqz v1, :cond_0

    .line 281
    iget-object v1, p0, Landroid/app/WallpaperManager$Globals;->mWallpaper:Landroid/graphics/Bitmap;

    monitor-exit p0

    .line 300
    :goto_0
    return-object v1

    .line 283
    :cond_0
    iget-object v1, p0, Landroid/app/WallpaperManager$Globals;->mDefaultWallpaper:Landroid/graphics/Bitmap;

    if-eqz v1, :cond_1

    .line 284
    iget-object v1, p0, Landroid/app/WallpaperManager$Globals;->mDefaultWallpaper:Landroid/graphics/Bitmap;

    monitor-exit p0

    goto :goto_0

    .line 301
    :catchall_0
    move-exception v1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 286
    :cond_1
    const/4 v1, 0x0

    :try_start_1
    iput-object v1, p0, Landroid/app/WallpaperManager$Globals;->mWallpaper:Landroid/graphics/Bitmap;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 288
    :try_start_2
    invoke-direct {p0, p1}, Landroid/app/WallpaperManager$Globals;->getCurrentWallpaperLocked(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v1

    iput-object v1, p0, Landroid/app/WallpaperManager$Globals;->mWallpaper:Landroid/graphics/Bitmap;
    :try_end_2
    .catch Ljava/lang/OutOfMemoryError; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 292
    :goto_1
    if-eqz p2, :cond_3

    .line 293
    :try_start_3
    iget-object v1, p0, Landroid/app/WallpaperManager$Globals;->mWallpaper:Landroid/graphics/Bitmap;

    if-nez v1, :cond_2

    .line 294
    invoke-direct {p0, p1}, Landroid/app/WallpaperManager$Globals;->getDefaultWallpaperLocked(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v1

    iput-object v1, p0, Landroid/app/WallpaperManager$Globals;->mDefaultWallpaper:Landroid/graphics/Bitmap;

    .line 295
    iget-object v1, p0, Landroid/app/WallpaperManager$Globals;->mDefaultWallpaper:Landroid/graphics/Bitmap;

    monitor-exit p0

    goto :goto_0

    .line 289
    :catch_0
    move-exception v0

    .line 290
    .local v0, "e":Ljava/lang/OutOfMemoryError;
    # getter for: Landroid/app/WallpaperManager;->TAG:Ljava/lang/String;
    invoke-static {}, Landroid/app/WallpaperManager;->access$000()Ljava/lang/String;

    move-result-object v1

    const-string v2, "No memory load current wallpaper"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 297
    .end local v0    # "e":Ljava/lang/OutOfMemoryError;
    :cond_2
    const/4 v1, 0x0

    iput-object v1, p0, Landroid/app/WallpaperManager$Globals;->mDefaultWallpaper:Landroid/graphics/Bitmap;

    .line 300
    :cond_3
    iget-object v1, p0, Landroid/app/WallpaperManager$Globals;->mWallpaper:Landroid/graphics/Bitmap;

    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0
.end method
