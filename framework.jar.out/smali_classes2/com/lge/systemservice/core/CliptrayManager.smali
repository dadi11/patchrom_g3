.class public Lcom/lge/systemservice/core/CliptrayManager;
.super Ljava/lang/Object;
.source "CliptrayManager.java"


# static fields
.field private static final CLIPTRAYMANAGER_LOG_TAG:Ljava/lang/String; = "Cliptray Manager"

.field private static final COPY_CLIPDATA:I = 0x4

.field private static final COPY_IMAGE_BITMAP:I = 0x3

.field private static final COPY_IMAGE_URI:I = 0x2

.field private static final COPY_SCREENCAPTURE:I = 0x5

.field private static final COPY_STYLED_TEXT:I = 0x0

.field private static final COPY_TEXT_ONLY:I = 0x1

.field public static final FEATURE_NAME:Ljava/lang/String; = "com.lge.software.cliptray"

.field private static final IME_CLIPTRAY_IMAGE:Ljava/lang/String; = "com.lge.cliptray.image"

.field public static final INPUT_TYPE_IMAGE_ONLY:I = 0x1

.field public static final INPUT_TYPE_TEXT_IMAGE:I = 0x2

.field public static final INPUT_TYPE_TEXT_ONLY:I = 0x0

.field private static final MAX_IMAGE_LIMIT_KB:I = 0x600

.field private static final MAX_IMAGE_LIMIT_NUM:I = 0x1e

.field public static final MIMETYPE_CLIPTRAY_IMAGE:Ljava/lang/String; = "vnd.android.cursor.item/vnd.com.lge.cliptray.image"

.field private static final MIN_REQUIRE_STORAGE:I = 0x100000


# instance fields
.field private mClipManager:Landroid/content/ClipboardManager;

.field private mConnected:Z

.field private mContext:Landroid/content/Context;

.field private mImageCount:I

.field private mImageSizeSum:I

.field private mService:Lcom/lge/systemservice/core/ICliptrayService;

.field private thumbnailHeight:I

.field private thumbnailWidth:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v7, 0x0

    const/4 v4, 0x0

    .line 131
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 100
    iput-object v7, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    .line 103
    iput-boolean v4, p0, Lcom/lge/systemservice/core/CliptrayManager;->mConnected:Z

    .line 105
    iput v4, p0, Lcom/lge/systemservice/core/CliptrayManager;->mImageSizeSum:I

    .line 106
    iput v4, p0, Lcom/lge/systemservice/core/CliptrayManager;->mImageCount:I

    .line 132
    iput-object p1, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    .line 133
    iget-object v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    const-string v5, "clipboard"

    invoke-virtual {v3, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/ClipboardManager;

    iput-object v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->mClipManager:Landroid/content/ClipboardManager;

    .line 136
    new-instance v1, Landroid/graphics/Point;

    invoke-direct {v1}, Landroid/graphics/Point;-><init>()V

    .line 137
    .local v1, "size":Landroid/graphics/Point;
    iget-object v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    const-string/jumbo v5, "window"

    invoke-virtual {v3, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/WindowManager;

    .line 138
    .local v2, "wm":Landroid/view/WindowManager;
    invoke-interface {v2}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v3

    invoke-virtual {v3, v1}, Landroid/view/Display;->getRealSize(Landroid/graphics/Point;)V

    .line 140
    iget v3, v1, Landroid/graphics/Point;->x:I

    iget v5, v1, Landroid/graphics/Point;->y:I

    if-le v3, v5, :cond_1

    .line 141
    iget v3, v1, Landroid/graphics/Point;->x:I

    iput v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailWidth:I

    .line 142
    iget v3, v1, Landroid/graphics/Point;->y:I

    iput v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailHeight:I

    .line 148
    :goto_0
    const-string v3, "cliptray"

    invoke-static {v3}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v3

    invoke-static {v3}, Lcom/lge/systemservice/core/ICliptrayService$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v3

    iput-object v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    .line 149
    iget-object v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    if-eqz v3, :cond_0

    .line 151
    :try_start_0
    iget-object v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    invoke-interface {v3}, Lcom/lge/systemservice/core/ICliptrayService;->asBinder()Landroid/os/IBinder;

    move-result-object v3

    new-instance v5, Lcom/lge/systemservice/core/CliptrayManager$1;

    invoke-direct {v5, p0}, Lcom/lge/systemservice/core/CliptrayManager$1;-><init>(Lcom/lge/systemservice/core/CliptrayManager;)V

    const/4 v6, 0x0

    invoke-interface {v3, v5, v6}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 158
    :cond_0
    :goto_1
    const-string v3, "Cliptray Manager"

    const-string v5, "new CliptrayManager"

    invoke-static {v3, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 159
    iget-object v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    if-eqz v3, :cond_2

    const/4 v3, 0x1

    :goto_2
    iput-boolean v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->mConnected:Z

    .line 160
    return-void

    .line 144
    :cond_1
    iget v3, v1, Landroid/graphics/Point;->y:I

    iput v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailWidth:I

    .line 145
    iget v3, v1, Landroid/graphics/Point;->x:I

    iput v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailHeight:I

    goto :goto_0

    .line 155
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    iput-object v7, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    goto :goto_1

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_2
    move v3, v4

    .line 159
    goto :goto_2
.end method

.method static synthetic access$002(Lcom/lge/systemservice/core/CliptrayManager;Lcom/lge/systemservice/core/ICliptrayService;)Lcom/lge/systemservice/core/ICliptrayService;
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/core/CliptrayManager;
    .param p1, "x1"    # Lcom/lge/systemservice/core/ICliptrayService;

    .prologue
    .line 57
    iput-object p1, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    return-object p1
.end method

.method private adjustCopy(Ljava/lang/CharSequence;Landroid/content/ClipData;Landroid/text/Spannable;[Landroid/text/style/DynamicDrawableSpan;)Landroid/content/ClipData;
    .locals 11
    .param p1, "selectedText"    # Ljava/lang/CharSequence;
    .param p2, "clip"    # Landroid/content/ClipData;
    .param p3, "spannable"    # Landroid/text/Spannable;
    .param p4, "image"    # [Landroid/text/style/DynamicDrawableSpan;

    .prologue
    .line 556
    const/4 v4, 0x0

    .line 557
    .local v4, "startPos":I
    const/4 v0, 0x0

    .line 559
    .local v0, "endPos":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v7, p4

    if-ge v1, v7, :cond_3

    .line 560
    aget-object v7, p4, v1

    invoke-interface {p3, v7}, Landroid/text/Spannable;->getSpanStart(Ljava/lang/Object;)I

    move-result v0

    .line 562
    const/4 v7, 0x0

    invoke-static {v4, v0}, Ljava/lang/Math;->min(II)I

    move-result v8

    invoke-static {v7, v8}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 563
    const/4 v7, 0x0

    invoke-static {v4, v0}, Ljava/lang/Math;->max(II)I

    move-result v8

    invoke-static {v7, v8}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 565
    if-eq v4, v0, :cond_0

    .line 566
    invoke-interface {p1, v4, v0}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v6

    .line 568
    .local v6, "text":Ljava/lang/CharSequence;
    new-instance v3, Landroid/content/ClipData$Item;

    invoke-direct {v3, v6}, Landroid/content/ClipData$Item;-><init>(Ljava/lang/CharSequence;)V

    .line 570
    .local v3, "item":Landroid/content/ClipData$Item;
    if-nez p2, :cond_2

    .line 572
    new-instance p2, Landroid/content/ClipData;

    .end local p2    # "clip":Landroid/content/ClipData;
    const-string v7, "image"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/String;

    const/4 v9, 0x0

    const-string/jumbo v10, "vnd.android.cursor.item/vnd.com.lge.cliptray.image"

    aput-object v10, v8, v9

    invoke-direct {p2, v7, v8, v3}, Landroid/content/ClipData;-><init>(Ljava/lang/CharSequence;[Ljava/lang/String;Landroid/content/ClipData$Item;)V

    .line 578
    .end local v3    # "item":Landroid/content/ClipData$Item;
    .end local v6    # "text":Ljava/lang/CharSequence;
    .restart local p2    # "clip":Landroid/content/ClipData;
    :cond_0
    :goto_1
    aget-object v7, p4, v1

    invoke-interface {p3, v7}, Landroid/text/Spannable;->getSpanEnd(Ljava/lang/Object;)I

    move-result v4

    .line 581
    aget-object v7, p4, v1

    invoke-virtual {v7}, Landroid/text/style/DynamicDrawableSpan;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v5

    .line 582
    .local v5, "tempDrawable":Landroid/graphics/drawable/Drawable;
    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    const-class v8, Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {v7, v8}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    .line 584
    .local v2, "isSupportingBitmap":Z
    if-eqz v2, :cond_1

    .line 585
    invoke-direct {p0, p2, p4, v1}, Lcom/lge/systemservice/core/CliptrayManager;->saveImageToDB(Landroid/content/ClipData;[Landroid/text/style/DynamicDrawableSpan;I)Landroid/content/ClipData;

    move-result-object p2

    .line 559
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 575
    .end local v2    # "isSupportingBitmap":Z
    .end local v5    # "tempDrawable":Landroid/graphics/drawable/Drawable;
    .restart local v3    # "item":Landroid/content/ClipData$Item;
    .restart local v6    # "text":Ljava/lang/CharSequence;
    :cond_2
    invoke-virtual {p2, v3}, Landroid/content/ClipData;->addItem(Landroid/content/ClipData$Item;)V

    goto :goto_1

    .line 590
    .end local v3    # "item":Landroid/content/ClipData$Item;
    .end local v6    # "text":Ljava/lang/CharSequence;
    :cond_3
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v7

    if-eq v4, v7, :cond_4

    .line 591
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v7

    invoke-interface {p1, v4, v7}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v6

    .line 592
    .restart local v6    # "text":Ljava/lang/CharSequence;
    new-instance v3, Landroid/content/ClipData$Item;

    invoke-direct {v3, v6}, Landroid/content/ClipData$Item;-><init>(Ljava/lang/CharSequence;)V

    .line 594
    .restart local v3    # "item":Landroid/content/ClipData$Item;
    if-nez p2, :cond_5

    .line 595
    new-instance p2, Landroid/content/ClipData;

    .end local p2    # "clip":Landroid/content/ClipData;
    const-string v7, "text"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/String;

    const/4 v9, 0x0

    const-string v10, "text/plain"

    aput-object v10, v8, v9

    invoke-direct {p2, v7, v8, v3}, Landroid/content/ClipData;-><init>(Ljava/lang/CharSequence;[Ljava/lang/String;Landroid/content/ClipData$Item;)V

    .line 600
    .end local v3    # "item":Landroid/content/ClipData$Item;
    .end local v6    # "text":Ljava/lang/CharSequence;
    .restart local p2    # "clip":Landroid/content/ClipData;
    :cond_4
    :goto_2
    return-object p2

    .line 597
    .restart local v3    # "item":Landroid/content/ClipData$Item;
    .restart local v6    # "text":Ljava/lang/CharSequence;
    :cond_5
    invoke-virtual {p2, v3}, Landroid/content/ClipData;->addItem(Landroid/content/ClipData$Item;)V

    goto :goto_2
.end method

.method private calculateInSampleSize(II)I
    .locals 10
    .param p1, "width"    # I
    .param p2, "height"    # I

    .prologue
    .line 945
    const/4 v3, 0x1

    .line 946
    .local v3, "inSampleSize":I
    if-le p1, p2, :cond_2

    move v2, p1

    .line 947
    .local v2, "imgWidth":I
    :goto_0
    if-le p1, p2, :cond_3

    move v1, p2

    .line 949
    .local v1, "imgHeight":I
    :goto_1
    iget v5, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailHeight:I

    if-gt v1, v5, :cond_0

    iget v5, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailWidth:I

    if-le v2, v5, :cond_1

    .line 950
    :cond_0
    int-to-double v6, v1

    iget v5, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailHeight:I

    int-to-double v8, v5

    div-double/2addr v6, v8

    invoke-static {v6, v7}, Ljava/lang/Math;->floor(D)D

    move-result-wide v6

    double-to-int v0, v6

    .line 951
    .local v0, "heightRatio":I
    int-to-double v6, v2

    iget v5, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailWidth:I

    int-to-double v8, v5

    div-double/2addr v6, v8

    invoke-static {v6, v7}, Ljava/lang/Math;->floor(D)D

    move-result-wide v6

    double-to-int v4, v6

    .line 953
    .local v4, "widthRatio":I
    if-ge v0, v4, :cond_4

    move v3, v0

    .line 955
    .end local v0    # "heightRatio":I
    .end local v4    # "widthRatio":I
    :cond_1
    :goto_2
    const-string v5, "Cliptray Manager"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "calculateInSampleSize: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 956
    return v3

    .end local v1    # "imgHeight":I
    .end local v2    # "imgWidth":I
    :cond_2
    move v2, p2

    .line 946
    goto :goto_0

    .restart local v2    # "imgWidth":I
    :cond_3
    move v1, p1

    .line 947
    goto :goto_1

    .restart local v0    # "heightRatio":I
    .restart local v1    # "imgHeight":I
    .restart local v4    # "widthRatio":I
    :cond_4
    move v3, v4

    .line 953
    goto :goto_2
.end method

.method private checkImageLimitReached(Z)V
    .locals 2
    .param p1, "isLimitReached"    # Z

    .prologue
    .line 801
    if-eqz p1, :cond_0

    .line 803
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 804
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v0, :cond_0

    .line 805
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->showImageLimitReachedToast()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 811
    .end local v0    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :cond_0
    :goto_0
    return-void

    .line 807
    :catch_0
    move-exception v1

    .line 808
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method private closeOutputStream(Ljava/io/OutputStream;)V
    .locals 1
    .param p1, "out"    # Ljava/io/OutputStream;

    .prologue
    .line 1282
    :try_start_0
    invoke-virtual {p1}, Ljava/io/OutputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1286
    :goto_0
    return-void

    .line 1283
    :catch_0
    move-exception v0

    .line 1284
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method private copy(Ljava/lang/CharSequence;)V
    .locals 9
    .param p1, "selectedText"    # Ljava/lang/CharSequence;

    .prologue
    const/4 v8, 0x0

    .line 527
    const/4 v0, 0x0

    .line 529
    .local v0, "clip":Landroid/content/ClipData;
    instance-of v5, p1, Landroid/text/Spanned;

    if-eqz v5, :cond_1

    .line 531
    instance-of v5, p1, Landroid/text/Spannable;

    if-eqz v5, :cond_2

    move-object v4, p1

    .line 532
    check-cast v4, Landroid/text/Spannable;

    .line 539
    .local v4, "spannable":Landroid/text/Spannable;
    :goto_0
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v5

    const-class v6, Landroid/text/style/DynamicDrawableSpan;

    invoke-interface {v4, v8, v5, v6}, Landroid/text/Spannable;->getSpans(IILjava/lang/Class;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Landroid/text/style/DynamicDrawableSpan;

    .line 541
    .local v1, "image":[Landroid/text/style/DynamicDrawableSpan;
    iget-object v5, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.lge.app.richnote"

    invoke-virtual {v5, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    .line 543
    .local v2, "isMemo":Z
    array-length v5, v1

    if-lez v5, :cond_0

    if-nez v2, :cond_3

    .line 545
    :cond_0
    new-instance v3, Landroid/content/ClipData$Item;

    invoke-direct {v3, p1}, Landroid/content/ClipData$Item;-><init>(Ljava/lang/CharSequence;)V

    .line 546
    .local v3, "item":Landroid/content/ClipData$Item;
    new-instance v0, Landroid/content/ClipData;

    .end local v0    # "clip":Landroid/content/ClipData;
    const-string v5, "text"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/String;

    const-string v7, "text/plain"

    aput-object v7, v6, v8

    invoke-direct {v0, v5, v6, v3}, Landroid/content/ClipData;-><init>(Ljava/lang/CharSequence;[Ljava/lang/String;Landroid/content/ClipData$Item;)V

    .line 552
    .end local v1    # "image":[Landroid/text/style/DynamicDrawableSpan;
    .end local v2    # "isMemo":Z
    .end local v3    # "item":Landroid/content/ClipData$Item;
    .end local v4    # "spannable":Landroid/text/Spannable;
    .restart local v0    # "clip":Landroid/content/ClipData;
    :cond_1
    :goto_1
    invoke-direct {p0, v0}, Lcom/lge/systemservice/core/CliptrayManager;->saveClipDataToCliptray(Landroid/content/ClipData;)Z

    .line 553
    return-void

    .line 534
    :cond_2
    new-instance v4, Landroid/text/SpannableString;

    invoke-direct {v4, p1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    .line 535
    .restart local v4    # "spannable":Landroid/text/Spannable;
    move-object p1, v4

    goto :goto_0

    .line 548
    .restart local v1    # "image":[Landroid/text/style/DynamicDrawableSpan;
    .restart local v2    # "isMemo":Z
    :cond_3
    invoke-direct {p0, p1, v0, v4, v1}, Lcom/lge/systemservice/core/CliptrayManager;->adjustCopy(Ljava/lang/CharSequence;Landroid/content/ClipData;Landroid/text/Spannable;[Landroid/text/style/DynamicDrawableSpan;)Landroid/content/ClipData;

    move-result-object v0

    goto :goto_1
.end method

.method private copyClipData(Landroid/content/ClipData;)Z
    .locals 14
    .param p1, "clip"    # Landroid/content/ClipData;

    .prologue
    const/4 v10, 0x0

    .line 745
    const/4 v5, 0x0

    .line 746
    .local v5, "isLimitReached":Z
    invoke-virtual {p1}, Landroid/content/ClipData;->getDescription()Landroid/content/ClipDescription;

    move-result-object v11

    const-string/jumbo v12, "vnd.android.cursor.item/vnd.com.lge.cliptray.image"

    invoke-virtual {v11, v12}, Landroid/content/ClipDescription;->hasMimeType(Ljava/lang/String;)Z

    move-result v3

    .line 747
    .local v3, "hasImage":Z
    iput v10, p0, Lcom/lge/systemservice/core/CliptrayManager;->mImageSizeSum:I

    .line 748
    iput v10, p0, Lcom/lge/systemservice/core/CliptrayManager;->mImageCount:I

    .line 750
    const/4 v8, 0x0

    .line 752
    .local v8, "newclip":Landroid/content/ClipData;
    invoke-virtual {p1}, Landroid/content/ClipData;->getItemCount()I

    move-result v2

    .line 753
    .local v2, "count":I
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    if-ge v4, v2, :cond_7

    .line 754
    invoke-virtual {p1, v4}, Landroid/content/ClipData;->getItemAt(I)Landroid/content/ClipData$Item;

    move-result-object v7

    .line 755
    .local v7, "item":Landroid/content/ClipData$Item;
    invoke-virtual {v7}, Landroid/content/ClipData$Item;->getUri()Landroid/net/Uri;

    move-result-object v1

    .line 756
    .local v1, "clipUri":Landroid/net/Uri;
    const-string v11, "Cliptray Manager"

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "copy clipdata uri = "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v11, v12}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 758
    if-eqz v1, :cond_5

    .line 759
    iget v11, p0, Lcom/lge/systemservice/core/CliptrayManager;->mImageSizeSum:I

    const/16 v12, 0x600

    if-ge v11, v12, :cond_4

    iget v11, p0, Lcom/lge/systemservice/core/CliptrayManager;->mImageCount:I

    const/16 v12, 0x1e

    if-ge v11, v12, :cond_4

    .line 760
    if-eqz v3, :cond_1

    .line 762
    invoke-direct {p0, v1}, Lcom/lge/systemservice/core/CliptrayManager;->getSampledBitmapFromUri(Landroid/net/Uri;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 763
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    if-nez v0, :cond_0

    .line 764
    const-string v11, "Cliptray Manager"

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "image copy failed.. cannot decode from URI: "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v11, v12}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 797
    .end local v0    # "bitmap":Landroid/graphics/Bitmap;
    .end local v1    # "clipUri":Landroid/net/Uri;
    .end local v7    # "item":Landroid/content/ClipData$Item;
    :goto_1
    return v10

    .line 769
    .restart local v0    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v1    # "clipUri":Landroid/net/Uri;
    .restart local v7    # "item":Landroid/content/ClipData$Item;
    :cond_0
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->hasAlpha()Z

    move-result v6

    .line 771
    .local v6, "isPNG":Z
    invoke-direct {p0, v0, v6}, Lcom/lge/systemservice/core/CliptrayManager;->insertImage(Landroid/graphics/Bitmap;Z)Landroid/net/Uri;

    move-result-object v1

    .line 774
    .end local v0    # "bitmap":Landroid/graphics/Bitmap;
    .end local v6    # "isPNG":Z
    :cond_1
    new-instance v9, Landroid/content/ClipData$Item;

    invoke-direct {v9, v1}, Landroid/content/ClipData$Item;-><init>(Landroid/net/Uri;)V

    .line 776
    .local v9, "newitem":Landroid/content/ClipData$Item;
    if-nez v8, :cond_3

    .line 777
    new-instance v8, Landroid/content/ClipData;

    .end local v8    # "newclip":Landroid/content/ClipData;
    invoke-virtual {p1}, Landroid/content/ClipData;->getDescription()Landroid/content/ClipDescription;

    move-result-object v11

    invoke-direct {v8, v11, v9}, Landroid/content/ClipData;-><init>(Landroid/content/ClipDescription;Landroid/content/ClipData$Item;)V

    .line 753
    .end local v9    # "newitem":Landroid/content/ClipData$Item;
    .restart local v8    # "newclip":Landroid/content/ClipData;
    :cond_2
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 779
    .restart local v9    # "newitem":Landroid/content/ClipData$Item;
    :cond_3
    invoke-virtual {v8, v9}, Landroid/content/ClipData;->addItem(Landroid/content/ClipData$Item;)V

    goto :goto_2

    .line 782
    .end local v9    # "newitem":Landroid/content/ClipData$Item;
    :cond_4
    const/4 v5, 0x1

    goto :goto_2

    .line 786
    :cond_5
    iget-object v11, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    invoke-virtual {v7, v11}, Landroid/content/ClipData$Item;->coerceToStyledText(Landroid/content/Context;)Ljava/lang/CharSequence;

    move-result-object v11

    invoke-interface {v11}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/String;->isEmpty()Z

    move-result v11

    if-nez v11, :cond_2

    .line 788
    if-nez v8, :cond_6

    .line 789
    new-instance v8, Landroid/content/ClipData;

    .end local v8    # "newclip":Landroid/content/ClipData;
    invoke-virtual {p1}, Landroid/content/ClipData;->getDescription()Landroid/content/ClipDescription;

    move-result-object v11

    invoke-direct {v8, v11, v7}, Landroid/content/ClipData;-><init>(Landroid/content/ClipDescription;Landroid/content/ClipData$Item;)V

    .restart local v8    # "newclip":Landroid/content/ClipData;
    goto :goto_2

    .line 791
    :cond_6
    invoke-virtual {v8, v7}, Landroid/content/ClipData;->addItem(Landroid/content/ClipData$Item;)V

    goto :goto_2

    .line 796
    .end local v1    # "clipUri":Landroid/net/Uri;
    .end local v7    # "item":Landroid/content/ClipData$Item;
    :cond_7
    invoke-direct {p0, v5}, Lcom/lge/systemservice/core/CliptrayManager;->checkImageLimitReached(Z)V

    .line 797
    invoke-direct {p0, v8}, Lcom/lge/systemservice/core/CliptrayManager;->saveClipDataToCliptray(Landroid/content/ClipData;)Z

    move-result v10

    goto :goto_1
.end method

.method private copyImageBitmap(Landroid/graphics/Bitmap;)Z
    .locals 11
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;

    .prologue
    const/4 v6, 0x1

    const/4 v7, 0x0

    .line 722
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->hasAlpha()Z

    move-result v3

    .line 724
    .local v3, "hasAlpha":Z
    invoke-direct {p0, p1, v3}, Lcom/lge/systemservice/core/CliptrayManager;->insertImage(Landroid/graphics/Bitmap;Z)Landroid/net/Uri;

    move-result-object v4

    .line 726
    .local v4, "imgUri":Landroid/net/Uri;
    new-instance v5, Landroid/content/ClipData$Item;

    invoke-direct {v5, v4}, Landroid/content/ClipData$Item;-><init>(Landroid/net/Uri;)V

    .line 727
    .local v5, "item":Landroid/content/ClipData$Item;
    new-instance v0, Landroid/content/ClipData;

    const-string v8, "image"

    new-array v9, v6, [Ljava/lang/String;

    const-string/jumbo v10, "vnd.android.cursor.item/vnd.com.lge.cliptray.image"

    aput-object v10, v9, v7

    invoke-direct {v0, v8, v9, v5}, Landroid/content/ClipData;-><init>(Ljava/lang/CharSequence;[Ljava/lang/String;Landroid/content/ClipData$Item;)V

    .line 729
    .local v0, "clip":Landroid/content/ClipData;
    if-eqz v0, :cond_1

    .line 731
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v1

    .line 732
    .local v1, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v1, :cond_0

    .line 733
    invoke-interface {v1}, Lcom/lge/systemservice/core/ICliptrayService;->doCopyAnimation()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 738
    .end local v1    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :cond_0
    :goto_0
    iget-object v7, p0, Lcom/lge/systemservice/core/CliptrayManager;->mClipManager:Landroid/content/ClipboardManager;

    invoke-virtual {v7, v0}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    .line 741
    :goto_1
    return v6

    .line 734
    :catch_0
    move-exception v2

    .line 735
    .local v2, "e":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "e":Landroid/os/RemoteException;
    :cond_1
    move v6, v7

    .line 741
    goto :goto_1
.end method

.method private copyImageUri(Landroid/net/Uri;)Z
    .locals 12
    .param p1, "imgUri"    # Landroid/net/Uri;

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 690
    const-string v9, "Cliptray Manager"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "copy image uri = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 693
    invoke-direct {p0, p1}, Lcom/lge/systemservice/core/CliptrayManager;->getSampledBitmapFromUri(Landroid/net/Uri;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 694
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    if-nez v0, :cond_1

    .line 695
    const-string v8, "Cliptray Manager"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "image copy failed.. cannot decode from URI: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 718
    :cond_0
    :goto_0
    return v7

    .line 699
    :cond_1
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->hasAlpha()Z

    move-result v4

    .line 701
    .local v4, "isPNG":Z
    invoke-direct {p0, v0, v4}, Lcom/lge/systemservice/core/CliptrayManager;->insertImage(Landroid/graphics/Bitmap;Z)Landroid/net/Uri;

    move-result-object v6

    .line 703
    .local v6, "newUri":Landroid/net/Uri;
    new-instance v5, Landroid/content/ClipData$Item;

    invoke-direct {v5, v6}, Landroid/content/ClipData$Item;-><init>(Landroid/net/Uri;)V

    .line 704
    .local v5, "item":Landroid/content/ClipData$Item;
    new-instance v1, Landroid/content/ClipData;

    const-string v9, "image"

    new-array v10, v8, [Ljava/lang/String;

    const-string/jumbo v11, "vnd.android.cursor.item/vnd.com.lge.cliptray.image"

    aput-object v11, v10, v7

    invoke-direct {v1, v9, v10, v5}, Landroid/content/ClipData;-><init>(Ljava/lang/CharSequence;[Ljava/lang/String;Landroid/content/ClipData$Item;)V

    .line 706
    .local v1, "clip":Landroid/content/ClipData;
    if-eqz v1, :cond_0

    .line 708
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v2

    .line 709
    .local v2, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v2, :cond_2

    .line 710
    invoke-interface {v2}, Lcom/lge/systemservice/core/ICliptrayService;->doCopyAnimation()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 715
    .end local v2    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :cond_2
    :goto_1
    iget-object v7, p0, Lcom/lge/systemservice/core/CliptrayManager;->mClipManager:Landroid/content/ClipboardManager;

    invoke-virtual {v7, v1}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    move v7, v8

    .line 716
    goto :goto_0

    .line 711
    :catch_0
    move-exception v3

    .line 712
    .local v3, "e":Landroid/os/RemoteException;
    invoke-virtual {v3}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_1
.end method

.method private copyScreenCapture(Landroid/net/Uri;)Z
    .locals 12
    .param p1, "imgUri"    # Landroid/net/Uri;

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 831
    const-string v9, "Cliptray Manager"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "copy image uri = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 834
    invoke-direct {p0, p1}, Lcom/lge/systemservice/core/CliptrayManager;->getSampledBitmapFromUri(Landroid/net/Uri;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 835
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    if-nez v0, :cond_1

    .line 836
    const-string v8, "Cliptray Manager"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "image copy failed.. cannot decode from URI: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 868
    :cond_0
    :goto_0
    return v7

    .line 840
    :cond_1
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->hasAlpha()Z

    move-result v4

    .line 842
    .local v4, "isPNG":Z
    invoke-direct {p0, v0, v4}, Lcom/lge/systemservice/core/CliptrayManager;->insertImage(Landroid/graphics/Bitmap;Z)Landroid/net/Uri;

    move-result-object v6

    .line 844
    .local v6, "newUri":Landroid/net/Uri;
    new-instance v5, Landroid/content/ClipData$Item;

    invoke-direct {v5, v6}, Landroid/content/ClipData$Item;-><init>(Landroid/net/Uri;)V

    .line 845
    .local v5, "item":Landroid/content/ClipData$Item;
    new-instance v1, Landroid/content/ClipData;

    const-string v9, "image"

    new-array v10, v8, [Ljava/lang/String;

    const-string/jumbo v11, "vnd.android.cursor.item/vnd.com.lge.cliptray.image"

    aput-object v11, v10, v7

    invoke-direct {v1, v9, v10, v5}, Landroid/content/ClipData;-><init>(Ljava/lang/CharSequence;[Ljava/lang/String;Landroid/content/ClipData$Item;)V

    .line 847
    .local v1, "clip":Landroid/content/ClipData;
    if-eqz v1, :cond_0

    .line 848
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v2

    .line 849
    .local v2, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    invoke-virtual {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getVisibility()I

    move-result v7

    if-nez v7, :cond_3

    .line 851
    if-eqz v2, :cond_2

    .line 852
    :try_start_0
    invoke-interface {v2}, Lcom/lge/systemservice/core/ICliptrayService;->doCopyAnimation()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 865
    :cond_2
    :goto_1
    iget-object v7, p0, Lcom/lge/systemservice/core/CliptrayManager;->mClipManager:Landroid/content/ClipboardManager;

    invoke-virtual {v7, v1}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    move v7, v8

    .line 866
    goto :goto_0

    .line 853
    :catch_0
    move-exception v3

    .line 854
    .local v3, "e":Landroid/os/RemoteException;
    invoke-virtual {v3}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_1

    .line 858
    .end local v3    # "e":Landroid/os/RemoteException;
    :cond_3
    if-eqz v2, :cond_2

    .line 859
    :try_start_1
    invoke-interface {v2}, Lcom/lge/systemservice/core/ICliptrayService;->showCliptrayCopiedToast()V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    .line 860
    :catch_1
    move-exception v3

    .line 861
    .restart local v3    # "e":Landroid/os/RemoteException;
    invoke-virtual {v3}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_1
.end method

.method private copyTextOnly(Ljava/lang/String;)V
    .locals 8
    .param p1, "selectedText"    # Ljava/lang/String;

    .prologue
    .line 624
    const-string v4, "Cliptray Manager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "copy text = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 625
    const/4 v0, 0x0

    .line 626
    .local v0, "clip":Landroid/content/ClipData;
    new-instance v3, Landroid/content/ClipData$Item;

    invoke-direct {v3, p1}, Landroid/content/ClipData$Item;-><init>(Ljava/lang/CharSequence;)V

    .line 627
    .local v3, "item":Landroid/content/ClipData$Item;
    new-instance v0, Landroid/content/ClipData;

    .end local v0    # "clip":Landroid/content/ClipData;
    const-string v4, "text"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/String;

    const/4 v6, 0x0

    const-string v7, "text/plain"

    aput-object v7, v5, v6

    invoke-direct {v0, v4, v5, v3}, Landroid/content/ClipData;-><init>(Ljava/lang/CharSequence;[Ljava/lang/String;Landroid/content/ClipData$Item;)V

    .line 628
    .restart local v0    # "clip":Landroid/content/ClipData;
    if-eqz v0, :cond_1

    .line 630
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v1

    .line 631
    .local v1, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v1, :cond_0

    .line 632
    invoke-interface {v1}, Lcom/lge/systemservice/core/ICliptrayService;->doCopyAnimation()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 636
    .end local v1    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :cond_0
    :goto_0
    iget-object v4, p0, Lcom/lge/systemservice/core/CliptrayManager;->mClipManager:Landroid/content/ClipboardManager;

    invoke-virtual {v4, v0}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    .line 638
    :cond_1
    return-void

    .line 633
    :catch_0
    move-exception v2

    .line 634
    .local v2, "e":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method private doCopyToCliptray(ILjava/lang/Object;)V
    .locals 6
    .param p1, "type"    # I
    .param p2, "obj"    # Ljava/lang/Object;

    .prologue
    .line 1118
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 1119
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-nez v0, :cond_1

    .line 1167
    .end local p2    # "obj":Ljava/lang/Object;
    :cond_0
    :goto_0
    return-void

    .line 1122
    .restart local p2    # "obj":Ljava/lang/Object;
    :cond_1
    const-string v3, "Cliptray Manager"

    const-string v4, "doCopyToCliptray"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1124
    const-wide/32 v4, 0x100000

    invoke-direct {p0, v4, v5}, Lcom/lge/systemservice/core/CliptrayManager;->hasAvailableSpaceForImageCopy(J)Z

    move-result v3

    if-nez v3, :cond_2

    .line 1126
    :try_start_0
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->showCopyFailedToast()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1127
    :catch_0
    move-exception v2

    .line 1128
    .local v2, "e":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 1133
    .end local v2    # "e":Landroid/os/RemoteException;
    :cond_2
    const/4 v1, 0x1

    .line 1135
    .local v1, "copy":Z
    packed-switch p1, :pswitch_data_0

    .line 1155
    const/4 v1, 0x0

    .line 1159
    .end local p2    # "obj":Ljava/lang/Object;
    :goto_1
    if-nez v1, :cond_0

    .line 1161
    if-eqz v0, :cond_0

    .line 1162
    :try_start_1
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->showDecodeErrorToast()V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 1163
    :catch_1
    move-exception v2

    .line 1164
    .restart local v2    # "e":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 1137
    .end local v2    # "e":Landroid/os/RemoteException;
    .restart local p2    # "obj":Ljava/lang/Object;
    :pswitch_0
    check-cast p2, Ljava/lang/CharSequence;

    .end local p2    # "obj":Ljava/lang/Object;
    invoke-direct {p0, p2}, Lcom/lge/systemservice/core/CliptrayManager;->copy(Ljava/lang/CharSequence;)V

    goto :goto_1

    .line 1140
    .restart local p2    # "obj":Ljava/lang/Object;
    :pswitch_1
    check-cast p2, Ljava/lang/String;

    .end local p2    # "obj":Ljava/lang/Object;
    invoke-direct {p0, p2}, Lcom/lge/systemservice/core/CliptrayManager;->copyTextOnly(Ljava/lang/String;)V

    goto :goto_1

    .line 1143
    .restart local p2    # "obj":Ljava/lang/Object;
    :pswitch_2
    check-cast p2, Landroid/net/Uri;

    .end local p2    # "obj":Ljava/lang/Object;
    invoke-direct {p0, p2}, Lcom/lge/systemservice/core/CliptrayManager;->copyImageUri(Landroid/net/Uri;)Z

    move-result v1

    .line 1144
    goto :goto_1

    .line 1146
    .restart local p2    # "obj":Ljava/lang/Object;
    :pswitch_3
    check-cast p2, Landroid/graphics/Bitmap;

    .end local p2    # "obj":Ljava/lang/Object;
    invoke-direct {p0, p2}, Lcom/lge/systemservice/core/CliptrayManager;->copyImageBitmap(Landroid/graphics/Bitmap;)Z

    move-result v1

    .line 1147
    goto :goto_1

    .line 1149
    .restart local p2    # "obj":Ljava/lang/Object;
    :pswitch_4
    check-cast p2, Landroid/content/ClipData;

    .end local p2    # "obj":Ljava/lang/Object;
    invoke-direct {p0, p2}, Lcom/lge/systemservice/core/CliptrayManager;->copyClipData(Landroid/content/ClipData;)Z

    move-result v1

    .line 1150
    goto :goto_1

    .line 1152
    .restart local p2    # "obj":Ljava/lang/Object;
    :pswitch_5
    check-cast p2, Landroid/net/Uri;

    .end local p2    # "obj":Ljava/lang/Object;
    invoke-direct {p0, p2}, Lcom/lge/systemservice/core/CliptrayManager;->copyScreenCapture(Landroid/net/Uri;)Z

    move-result v1

    .line 1153
    goto :goto_1

    .line 1135
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method

.method private ensureFileExists(Ljava/lang/String;)Z
    .locals 9
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    const/4 v6, 0x1

    const/4 v7, 0x0

    .line 1027
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 1028
    .local v2, "file":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v8

    if-eqz v8, :cond_0

    .line 1052
    :goto_0
    return v6

    .line 1033
    :cond_0
    const/16 v8, 0x2f

    invoke-virtual {p1, v8, v6}, Ljava/lang/String;->indexOf(II)I

    move-result v5

    .line 1034
    .local v5, "secondSlash":I
    if-ge v5, v6, :cond_1

    move v6, v7

    .line 1035
    goto :goto_0

    .line 1037
    :cond_1
    invoke-virtual {p1, v7, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 1038
    .local v1, "directoryPath":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 1039
    .local v0, "directory":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v6

    if-nez v6, :cond_2

    move v6, v7

    .line 1040
    goto :goto_0

    .line 1043
    :cond_2
    invoke-virtual {v2}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v4

    .line 1044
    .local v4, "parentFile":Ljava/io/File;
    if-eqz v4, :cond_3

    .line 1045
    invoke-virtual {v4}, Ljava/io/File;->mkdirs()Z

    .line 1049
    :cond_3
    :try_start_0
    invoke-virtual {v2}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v6

    goto :goto_0

    .line 1050
    :catch_0
    move-exception v3

    .line 1051
    .local v3, "ioe":Ljava/io/IOException;
    const-string v6, "Cliptray Manager"

    const-string v8, "File creation failed"

    invoke-static {v6, v8, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move v6, v7

    .line 1052
    goto :goto_0
.end method

.method private generateFileName(Z)Ljava/lang/String;
    .locals 4
    .param p1, "isPNG"    # Z

    .prologue
    .line 1016
    if-eqz p1, :cond_0

    .line 1017
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".png"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1019
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".jpg"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private getBitmapFromUri(Landroid/net/Uri;)Landroid/graphics/Bitmap;
    .locals 6
    .param p1, "uri"    # Landroid/net/Uri;

    .prologue
    .line 875
    const/4 v0, 0x0

    .line 876
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    const-string v3, "Cliptray Manager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "testing cliptray : current Uri = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 879
    :try_start_0
    iget-object v3, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    invoke-virtual {v3, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v2

    .line 880
    .local v2, "is":Ljava/io/InputStream;
    invoke-static {v2}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 881
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 885
    .end local v2    # "is":Ljava/io/InputStream;
    :goto_0
    return-object v0

    .line 882
    :catch_0
    move-exception v1

    .line 883
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method private getDrawableFromUri(Landroid/net/Uri;)Landroid/graphics/drawable/Drawable;
    .locals 3
    .param p1, "uri"    # Landroid/net/Uri;

    .prologue
    .line 641
    invoke-virtual {p1}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 642
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    new-instance v1, Landroid/graphics/drawable/BitmapDrawable;

    iget-object v2, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V

    .line 643
    .local v1, "d":Landroid/graphics/drawable/BitmapDrawable;
    return-object v1
.end method

.method private getImageContentUri(Landroid/content/Context;Ljava/io/File;)Landroid/net/Uri;
    .locals 13
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "imageFile"    # Ljava/io/File;

    .prologue
    const/4 v12, 0x0

    .line 1289
    iget v0, p0, Lcom/lge/systemservice/core/CliptrayManager;->mImageSizeSum:I

    int-to-long v0, v0

    invoke-virtual {p2}, Ljava/io/File;->length()J

    move-result-wide v2

    const-wide/16 v4, 0x400

    div-long/2addr v2, v4

    add-long/2addr v0, v2

    long-to-int v0, v0

    iput v0, p0, Lcom/lge/systemservice/core/CliptrayManager;->mImageSizeSum:I

    .line 1290
    iget v0, p0, Lcom/lge/systemservice/core/CliptrayManager;->mImageCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/lge/systemservice/core/CliptrayManager;->mImageCount:I

    .line 1291
    invoke-virtual {p2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v9

    .line 1292
    .local v9, "filePath":Ljava/lang/String;
    const/4 v7, 0x0

    .line 1295
    .local v7, "cursor":Landroid/database/Cursor;
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "external"

    invoke-static {v1}, Landroid/provider/MediaStore$Files;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "_id"

    aput-object v4, v2, v3

    const-string v3, "_data=? "

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    aput-object v9, v4, v5

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v7

    .line 1300
    if-eqz v7, :cond_1

    invoke-interface {v7}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1301
    const-string v0, "_id"

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v10

    .line 1303
    .local v10, "id":I
    const-string v0, "external"

    invoke-static {v0}, Landroid/provider/MediaStore$Files;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v6

    .line 1304
    .local v6, "baseUri":Landroid/net/Uri;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v6, v0}, Landroid/net/Uri;->withAppendedPath(Landroid/net/Uri;Ljava/lang/String;)Landroid/net/Uri;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 1321
    if-eqz v7, :cond_0

    invoke-interface {v7}, Landroid/database/Cursor;->isClosed()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1322
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    .line 1325
    .end local v6    # "baseUri":Landroid/net/Uri;
    .end local v10    # "id":I
    :cond_0
    :goto_0
    return-object v0

    .line 1307
    :cond_1
    :try_start_1
    invoke-virtual {p2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1308
    new-instance v11, Landroid/content/ContentValues;

    invoke-direct {v11}, Landroid/content/ContentValues;-><init>()V

    .line 1309
    .local v11, "values":Landroid/content/ContentValues;
    const-string v0, "_data"

    invoke-virtual {v11, v0, v9}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1310
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "external"

    invoke-static {v1}, Landroid/provider/MediaStore$Files;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1, v11}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v0

    .line 1321
    if-eqz v7, :cond_0

    invoke-interface {v7}, Landroid/database/Cursor;->isClosed()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1322
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    goto :goto_0

    .line 1321
    .end local v11    # "values":Landroid/content/ContentValues;
    :cond_2
    if-eqz v7, :cond_3

    invoke-interface {v7}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_3

    .line 1322
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    :cond_3
    move-object v0, v12

    goto :goto_0

    .line 1317
    :catch_0
    move-exception v8

    .line 1318
    .local v8, "e":Ljava/lang/Exception;
    :try_start_2
    const-string v0, "Cliptray Manager"

    const-string v1, "CliptrayManager cannot get image uri!!"

    invoke-static {v0, v1, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1321
    if-eqz v7, :cond_4

    invoke-interface {v7}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_4

    .line 1322
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    :cond_4
    move-object v0, v12

    .line 1325
    goto :goto_0

    .line 1321
    .end local v8    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v0

    if-eqz v7, :cond_5

    invoke-interface {v7}, Landroid/database/Cursor;->isClosed()Z

    move-result v1

    if-nez v1, :cond_5

    .line 1322
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    :cond_5
    throw v0
.end method

.method private getNewFilePath(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p1, "filename"    # Ljava/lang/String;

    .prologue
    .line 1204
    const-string v0, ".cliptray"

    .line 1207
    .local v0, "foldername":Ljava/lang/String;
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v3

    const-string v4, "mounted"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 1208
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    .line 1210
    .local v2, "path":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "Android/data"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1211
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1214
    new-instance v1, Ljava/io/File;

    const-string v3, ".nomedia"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 1215
    .local v1, "nomedia":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_0

    .line 1216
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    .line 1219
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1220
    const-string v3, "Cliptray Manager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "image save path = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1222
    invoke-direct {p0, v2}, Lcom/lge/systemservice/core/CliptrayManager;->ensureFileExists(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 1223
    new-instance v3, Ljava/lang/IllegalStateException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Unable to create new file: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 1229
    .end local v1    # "nomedia":Ljava/io/File;
    .end local v2    # "path":Ljava/lang/String;
    :cond_1
    const-string v2, ""

    :cond_2
    return-object v2
.end method

.method private getOrientation(Landroid/net/Uri;)I
    .locals 10
    .param p1, "imgUri"    # Landroid/net/Uri;

    .prologue
    const/4 v2, 0x0

    .line 1170
    const/4 v8, -0x1

    .line 1171
    .local v8, "orientation":I
    const/4 v6, -0x1

    .line 1173
    .local v6, "columnIndex":I
    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "file:/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1174
    const-string v0, "Cliptray Manager"

    const-string v1, "file uri, return default orientation"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move v9, v8

    .line 1200
    .end local v8    # "orientation":I
    .local v9, "orientation":I
    :goto_0
    return v9

    .line 1178
    .end local v9    # "orientation":I
    .restart local v8    # "orientation":I
    :cond_0
    iget-object v0, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    move-object v1, p1

    move-object v3, v2

    move-object v4, v2

    move-object v5, v2

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v7

    .line 1180
    .local v7, "cursor":Landroid/database/Cursor;
    if-eqz v7, :cond_3

    .line 1181
    :try_start_0
    const-string v0, "orientation"

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v6

    .line 1182
    const-string v0, "Cliptray Manager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "content uri, orientation columnIndex = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1184
    if-gez v6, :cond_2

    .line 1185
    const-string v0, "Cliptray Manager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "orientation column not found, return "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1196
    if-eqz v7, :cond_1

    .line 1197
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    :cond_1
    move v9, v8

    .end local v8    # "orientation":I
    .restart local v9    # "orientation":I
    goto :goto_0

    .line 1189
    .end local v9    # "orientation":I
    .restart local v8    # "orientation":I
    :cond_2
    :try_start_1
    invoke-interface {v7}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1190
    invoke-interface {v7, v6}, Landroid/database/Cursor;->getInt(I)I

    move-result v8

    .line 1191
    const-string v0, "Cliptray Manager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "orientation column found, return "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1196
    :cond_3
    if-eqz v7, :cond_4

    .line 1197
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    :cond_4
    move v9, v8

    .line 1200
    .end local v8    # "orientation":I
    .restart local v9    # "orientation":I
    goto :goto_0

    .line 1196
    .end local v9    # "orientation":I
    .restart local v8    # "orientation":I
    :catchall_0
    move-exception v0

    if-eqz v7, :cond_5

    .line 1197
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    :cond_5
    throw v0
.end method

.method private getOutputUri(Ljava/lang/String;)Landroid/net/Uri;
    .locals 7
    .param p1, "filename"    # Ljava/lang/String;

    .prologue
    .line 1061
    const-string v0, ".cliptray"

    .line 1064
    .local v0, "foldername":Ljava/lang/String;
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v4

    const-string v5, "mounted"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 1065
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v4

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    .line 1067
    .local v3, "path":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "Android/data"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 1068
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 1069
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 1070
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 1071
    .local v1, "imageFile":Ljava/io/File;
    const-string v4, "Cliptray Manager"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "image save path = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1073
    invoke-direct {p0, v3}, Lcom/lge/systemservice/core/CliptrayManager;->ensureFileExists(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 1074
    new-instance v4, Ljava/lang/IllegalStateException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Unable to create new file: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 1077
    :cond_0
    new-instance v2, Ljava/io/File;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v5

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/.nomedia"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 1078
    .local v2, "nomediaFile":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v4

    if-nez v4, :cond_1

    .line 1079
    invoke-virtual {v2}, Ljava/io/File;->mkdir()Z

    .line 1082
    :cond_1
    invoke-static {v1}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v4

    .line 1085
    .end local v1    # "imageFile":Ljava/io/File;
    .end local v2    # "nomediaFile":Ljava/io/File;
    .end local v3    # "path":Ljava/lang/String;
    :goto_0
    return-object v4

    :cond_2
    const/4 v4, 0x0

    goto :goto_0
.end method

.method private getSampledBitmapFromUri(Landroid/net/Uri;)Landroid/graphics/Bitmap;
    .locals 12
    .param p1, "uri"    # Landroid/net/Uri;

    .prologue
    const/4 v6, 0x1

    const/4 v1, 0x0

    .line 893
    invoke-direct {p0, p1}, Lcom/lge/systemservice/core/CliptrayManager;->getOrientation(Landroid/net/Uri;)I

    move-result v11

    .line 894
    .local v11, "orientation":I
    const-string v2, "Cliptray Manager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "image is rotated by : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 897
    iget-object v2, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    .line 898
    .local v7, "cr":Landroid/content/ContentResolver;
    if-nez v7, :cond_1

    .line 899
    const-string v2, "Cliptray Manager"

    const-string v3, "getSampledBitmapFromUri: content resolver is null, cannot copy image"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v0, v1

    .line 941
    :cond_0
    :goto_0
    return-object v0

    .line 907
    :cond_1
    new-instance v10, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v10}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 908
    .local v10, "options":Landroid/graphics/BitmapFactory$Options;
    iput-boolean v6, v10, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 910
    :try_start_0
    invoke-virtual {v7, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v9

    .line 911
    .local v9, "is":Ljava/io/InputStream;
    const/4 v2, 0x0

    invoke-static {v9, v2, v10}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    .line 912
    invoke-virtual {v9}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 918
    .end local v9    # "is":Ljava/io/InputStream;
    :goto_1
    iget v2, v10, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    iget v3, v10, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    invoke-direct {p0, v2, v3}, Lcom/lge/systemservice/core/CliptrayManager;->calculateInSampleSize(II)I

    move-result v2

    iput v2, v10, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 921
    const/4 v2, 0x0

    :try_start_1
    iput-boolean v2, v10, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 922
    invoke-virtual {v7, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v9

    .line 923
    .restart local v9    # "is":Ljava/io/InputStream;
    const/4 v2, 0x0

    invoke-static {v9, v2, v10}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 924
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    invoke-virtual {v9}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 932
    if-eqz v0, :cond_0

    if-lez v11, :cond_0

    .line 933
    new-instance v5, Landroid/graphics/Matrix;

    invoke-direct {v5}, Landroid/graphics/Matrix;-><init>()V

    .line 934
    .local v5, "matrix":Landroid/graphics/Matrix;
    int-to-float v1, v11

    invoke-virtual {v5, v1}, Landroid/graphics/Matrix;->postRotate(F)Z

    .line 936
    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_2
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    const/4 v6, 0x1

    invoke-static/range {v0 .. v6}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;
    :try_end_2
    .catch Ljava/lang/OutOfMemoryError; {:try_start_2 .. :try_end_2} :catch_2

    move-result-object v0

    goto :goto_0

    .line 913
    .end local v0    # "bitmap":Landroid/graphics/Bitmap;
    .end local v5    # "matrix":Landroid/graphics/Matrix;
    .end local v9    # "is":Ljava/io/InputStream;
    :catch_0
    move-exception v8

    .line 914
    .local v8, "e":Ljava/lang/Exception;
    invoke-virtual {v8}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1

    .line 925
    .end local v8    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v8

    .line 926
    .restart local v8    # "e":Ljava/lang/Exception;
    invoke-virtual {v8}, Ljava/lang/Exception;->printStackTrace()V

    move-object v0, v1

    .line 927
    goto :goto_0

    .line 937
    .end local v8    # "e":Ljava/lang/Exception;
    .restart local v0    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v5    # "matrix":Landroid/graphics/Matrix;
    .restart local v9    # "is":Ljava/io/InputStream;
    :catch_2
    move-exception v8

    .line 938
    .local v8, "e":Ljava/lang/OutOfMemoryError;
    invoke-virtual {v8}, Ljava/lang/OutOfMemoryError;->printStackTrace()V

    goto :goto_0
.end method

.method private final getService()Lcom/lge/systemservice/core/ICliptrayService;
    .locals 4

    .prologue
    .line 163
    iget-object v1, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    if-nez v1, :cond_0

    .line 164
    const-string v1, "cliptray"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/systemservice/core/ICliptrayService$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    .line 165
    iget-object v1, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    if-eqz v1, :cond_0

    .line 167
    :try_start_0
    iget-object v1, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    invoke-interface {v1}, Lcom/lge/systemservice/core/ICliptrayService;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    new-instance v2, Lcom/lge/systemservice/core/CliptrayManager$2;

    invoke-direct {v2, p0}, Lcom/lge/systemservice/core/CliptrayManager$2;-><init>(Lcom/lge/systemservice/core/CliptrayManager;)V

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 174
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    return-object v1

    .line 171
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/systemservice/core/CliptrayManager;->mService:Lcom/lge/systemservice/core/ICliptrayService;

    goto :goto_0
.end method

.method private hasAvailableSpaceForImageCopy(J)Z
    .locals 13
    .param p1, "size"    # J

    .prologue
    const/4 v6, 0x0

    .line 1106
    :try_start_0
    new-instance v5, Landroid/os/StatFs;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v7

    invoke-virtual {v7}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v5, v7}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 1107
    .local v5, "ts":Landroid/os/StatFs;
    invoke-virtual {v5}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v7

    int-to-long v0, v7

    .line 1108
    .local v0, "available_blocks":J
    invoke-virtual {v5}, Landroid/os/StatFs;->getBlockSize()I

    move-result v7

    int-to-long v2, v7

    .line 1109
    .local v2, "block_size":J
    const-string v7, "Cliptray Manager"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Available = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    mul-long v10, v0, v2

    invoke-virtual {v8, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " / Request = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1110
    mul-long v8, v0, v2

    cmp-long v7, v8, p1

    if-lez v7, :cond_0

    const/4 v6, 0x1

    .line 1114
    .end local v0    # "available_blocks":J
    .end local v2    # "block_size":J
    .end local v5    # "ts":Landroid/os/StatFs;
    :cond_0
    :goto_0
    return v6

    .line 1111
    :catch_0
    move-exception v4

    .line 1112
    .local v4, "e":Ljava/lang/Exception;
    const-string v7, "Cliptray Manager"

    const-string v8, "Fail to access storage : "

    invoke-static {v7, v8, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method private insertImage(Landroid/graphics/Bitmap;Z)Landroid/net/Uri;
    .locals 3
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "isPNG"    # Z

    .prologue
    .line 1096
    invoke-direct {p0, p2}, Lcom/lge/systemservice/core/CliptrayManager;->generateFileName(Z)Ljava/lang/String;

    move-result-object v0

    .line 1097
    .local v0, "filename":Ljava/lang/String;
    invoke-direct {p0, v0}, Lcom/lge/systemservice/core/CliptrayManager;->getNewFilePath(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1098
    .local v1, "newFilePath":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    .line 1099
    invoke-direct {p0, p1, v1, p2}, Lcom/lge/systemservice/core/CliptrayManager;->saveBitmap(Landroid/graphics/Bitmap;Ljava/lang/String;Z)Landroid/net/Uri;

    move-result-object v2

    .line 1101
    :goto_0
    return-object v2

    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method private saveBitmap(Landroid/graphics/Bitmap;Ljava/lang/String;Z)Landroid/net/Uri;
    .locals 13
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "filepath"    # Ljava/lang/String;
    .param p3, "isPNG"    # Z

    .prologue
    .line 1235
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v9

    .line 1236
    .local v9, "width":I
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    .line 1237
    .local v4, "height":I
    iget v1, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailHeight:I

    .line 1238
    .local v1, "dstWidth":I
    iget v0, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailWidth:I

    .line 1240
    .local v0, "dstHeight":I
    iget v11, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailWidth:I

    if-gt v9, v11, :cond_0

    iget v11, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailHeight:I

    if-le v4, v11, :cond_1

    .line 1241
    :cond_0
    int-to-float v11, v4

    int-to-float v12, v0

    div-float v5, v11, v12

    .line 1242
    .local v5, "heightRatio":F
    int-to-float v11, v9

    int-to-float v12, v1

    div-float v10, v11, v12

    .line 1243
    .local v10, "widthRatio":F
    cmpl-float v11, v5, v10

    if-lez v11, :cond_3

    .line 1244
    int-to-float v11, v9

    div-float/2addr v11, v5

    invoke-static {v11}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 1249
    :goto_0
    const/4 v11, 0x1

    :try_start_0
    invoke-static {p1, v1, v0, v11}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;
    :try_end_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p1

    .line 1255
    .end local v5    # "heightRatio":F
    .end local v10    # "widthRatio":F
    :cond_1
    :goto_1
    const/4 v8, 0x0

    .line 1256
    .local v8, "success":Z
    const/4 v6, 0x0

    .line 1259
    .local v6, "outstream":Ljava/io/OutputStream;
    :try_start_1
    new-instance v7, Ljava/io/FileOutputStream;

    new-instance v11, Ljava/io/File;

    invoke-direct {v11, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v7, v11}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1260
    .end local v6    # "outstream":Ljava/io/OutputStream;
    .local v7, "outstream":Ljava/io/OutputStream;
    if-eqz p3, :cond_4

    .line 1261
    :try_start_2
    sget-object v11, Landroid/graphics/Bitmap$CompressFormat;->PNG:Landroid/graphics/Bitmap$CompressFormat;

    const/4 v12, 0x0

    invoke-virtual {p1, v11, v12, v7}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v8

    .line 1265
    :goto_2
    invoke-virtual {v7}, Ljava/io/OutputStream;->flush()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1269
    if-eqz v7, :cond_7

    .line 1270
    invoke-direct {p0, v7}, Lcom/lge/systemservice/core/CliptrayManager;->closeOutputStream(Ljava/io/OutputStream;)V

    move-object v6, v7

    .line 1274
    .end local v7    # "outstream":Ljava/io/OutputStream;
    .restart local v6    # "outstream":Ljava/io/OutputStream;
    :cond_2
    :goto_3
    if-eqz v8, :cond_6

    .line 1275
    iget-object v11, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    new-instance v12, Ljava/io/File;

    invoke-direct {v12, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, v11, v12}, Lcom/lge/systemservice/core/CliptrayManager;->getImageContentUri(Landroid/content/Context;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v11

    .line 1277
    :goto_4
    return-object v11

    .line 1246
    .end local v6    # "outstream":Ljava/io/OutputStream;
    .end local v8    # "success":Z
    .restart local v5    # "heightRatio":F
    .restart local v10    # "widthRatio":F
    :cond_3
    int-to-float v11, v4

    div-float/2addr v11, v10

    invoke-static {v11}, Ljava/lang/Math;->round(F)I

    move-result v0

    goto :goto_0

    .line 1250
    :catch_0
    move-exception v2

    .line 1251
    .local v2, "e":Ljava/lang/OutOfMemoryError;
    invoke-virtual {v2}, Ljava/lang/OutOfMemoryError;->printStackTrace()V

    goto :goto_1

    .line 1263
    .end local v2    # "e":Ljava/lang/OutOfMemoryError;
    .end local v5    # "heightRatio":F
    .end local v10    # "widthRatio":F
    .restart local v7    # "outstream":Ljava/io/OutputStream;
    .restart local v8    # "success":Z
    :cond_4
    :try_start_3
    sget-object v11, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v12, 0x50

    invoke-virtual {p1, v11, v12, v7}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    move-result v8

    goto :goto_2

    .line 1266
    .end local v7    # "outstream":Ljava/io/OutputStream;
    .restart local v6    # "outstream":Ljava/io/OutputStream;
    :catch_1
    move-exception v3

    .line 1267
    .local v3, "ex":Ljava/lang/Exception;
    :goto_5
    :try_start_4
    invoke-virtual {v3}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 1269
    if-eqz v6, :cond_2

    .line 1270
    invoke-direct {p0, v6}, Lcom/lge/systemservice/core/CliptrayManager;->closeOutputStream(Ljava/io/OutputStream;)V

    goto :goto_3

    .line 1269
    .end local v3    # "ex":Ljava/lang/Exception;
    :catchall_0
    move-exception v11

    :goto_6
    if-eqz v6, :cond_5

    .line 1270
    invoke-direct {p0, v6}, Lcom/lge/systemservice/core/CliptrayManager;->closeOutputStream(Ljava/io/OutputStream;)V

    :cond_5
    throw v11

    .line 1277
    :cond_6
    const/4 v11, 0x0

    goto :goto_4

    .line 1269
    .end local v6    # "outstream":Ljava/io/OutputStream;
    .restart local v7    # "outstream":Ljava/io/OutputStream;
    :catchall_1
    move-exception v11

    move-object v6, v7

    .end local v7    # "outstream":Ljava/io/OutputStream;
    .restart local v6    # "outstream":Ljava/io/OutputStream;
    goto :goto_6

    .line 1266
    .end local v6    # "outstream":Ljava/io/OutputStream;
    .restart local v7    # "outstream":Ljava/io/OutputStream;
    :catch_2
    move-exception v3

    move-object v6, v7

    .end local v7    # "outstream":Ljava/io/OutputStream;
    .restart local v6    # "outstream":Ljava/io/OutputStream;
    goto :goto_5

    .end local v6    # "outstream":Ljava/io/OutputStream;
    .restart local v7    # "outstream":Ljava/io/OutputStream;
    :cond_7
    move-object v6, v7

    .end local v7    # "outstream":Ljava/io/OutputStream;
    .restart local v6    # "outstream":Ljava/io/OutputStream;
    goto :goto_3
.end method

.method private saveBitmap(Landroid/graphics/Bitmap;Landroid/net/Uri;Z)V
    .locals 13
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "uri"    # Landroid/net/Uri;
    .param p3, "isPNG"    # Z

    .prologue
    .line 964
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v8

    .line 965
    .local v8, "width":I
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    .line 966
    .local v4, "height":I
    iget v1, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailWidth:I

    .line 967
    .local v1, "dstWidth":I
    iget v0, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailHeight:I

    .line 969
    .local v0, "dstHeight":I
    iget v10, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailWidth:I

    if-gt v8, v10, :cond_0

    iget v10, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailHeight:I

    if-le v4, v10, :cond_1

    .line 970
    :cond_0
    int-to-float v10, v4

    iget v11, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailHeight:I

    int-to-float v11, v11

    div-float v5, v10, v11

    .line 971
    .local v5, "heightRatio":F
    int-to-float v10, v8

    iget v11, p0, Lcom/lge/systemservice/core/CliptrayManager;->thumbnailWidth:I

    int-to-float v11, v11

    div-float v9, v10, v11

    .line 972
    .local v9, "widthRatio":F
    cmpl-float v10, v5, v9

    if-lez v10, :cond_4

    .line 973
    int-to-float v10, v8

    div-float/2addr v10, v5

    invoke-static {v10}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 978
    :goto_0
    const/4 v10, 0x1

    :try_start_0
    invoke-static {p1, v1, v0, v10}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;
    :try_end_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object p1

    .line 984
    .end local v5    # "heightRatio":F
    .end local v9    # "widthRatio":F
    :cond_1
    :goto_1
    const/4 v7, 0x0

    .line 985
    .local v7, "success":Z
    const/4 v6, 0x0

    .line 988
    .local v6, "outstream":Ljava/io/OutputStream;
    :try_start_1
    iget-object v10, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    invoke-virtual {v10}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v10

    invoke-virtual {v10, p2}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;

    move-result-object v6

    .line 989
    if-eqz p3, :cond_5

    .line 990
    sget-object v10, Landroid/graphics/Bitmap$CompressFormat;->PNG:Landroid/graphics/Bitmap$CompressFormat;

    const/4 v11, 0x0

    invoke-virtual {p1, v10, v11, v6}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v7

    .line 997
    :goto_2
    if-eqz v6, :cond_2

    .line 999
    :try_start_2
    invoke-virtual {v6}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .line 1007
    :cond_2
    :goto_3
    if-nez v7, :cond_3

    .line 1010
    :cond_3
    return-void

    .line 975
    .end local v6    # "outstream":Ljava/io/OutputStream;
    .end local v7    # "success":Z
    .restart local v5    # "heightRatio":F
    .restart local v9    # "widthRatio":F
    :cond_4
    int-to-float v10, v4

    div-float/2addr v10, v9

    invoke-static {v10}, Ljava/lang/Math;->round(F)I

    move-result v0

    goto :goto_0

    .line 979
    :catch_0
    move-exception v2

    .line 980
    .local v2, "e":Ljava/lang/OutOfMemoryError;
    invoke-virtual {v2}, Ljava/lang/OutOfMemoryError;->printStackTrace()V

    goto :goto_1

    .line 992
    .end local v2    # "e":Ljava/lang/OutOfMemoryError;
    .end local v5    # "heightRatio":F
    .end local v9    # "widthRatio":F
    .restart local v6    # "outstream":Ljava/io/OutputStream;
    .restart local v7    # "success":Z
    :cond_5
    :try_start_3
    sget-object v10, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v11, 0x50

    invoke-virtual {p1, v10, v11, v6}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z
    :try_end_3
    .catch Ljava/io/FileNotFoundException; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result v7

    goto :goto_2

    .line 1001
    :catch_1
    move-exception v3

    .line 1002
    .local v3, "ex":Ljava/io/IOException;
    const-string v10, "Cliptray Manager"

    const-string v11, "error closing outstream"

    invoke-static {v10, v11, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_3

    .line 994
    .end local v3    # "ex":Ljava/io/IOException;
    :catch_2
    move-exception v3

    .line 995
    .local v3, "ex":Ljava/io/FileNotFoundException;
    :try_start_4
    const-string v10, "Cliptray Manager"

    const-string v11, "error creating file"

    invoke-static {v10, v11, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 997
    if-eqz v6, :cond_2

    .line 999
    :try_start_5
    invoke-virtual {v6}, Ljava/io/OutputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    goto :goto_3

    .line 1001
    :catch_3
    move-exception v3

    .line 1002
    .local v3, "ex":Ljava/io/IOException;
    const-string v10, "Cliptray Manager"

    const-string v11, "error closing outstream"

    invoke-static {v10, v11, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_3

    .line 997
    .end local v3    # "ex":Ljava/io/IOException;
    :catchall_0
    move-exception v10

    if-eqz v6, :cond_6

    .line 999
    :try_start_6
    invoke-virtual {v6}, Ljava/io/OutputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_4

    .line 1003
    :cond_6
    :goto_4
    throw v10

    .line 1001
    :catch_4
    move-exception v3

    .line 1002
    .restart local v3    # "ex":Ljava/io/IOException;
    const-string v11, "Cliptray Manager"

    const-string v12, "error closing outstream"

    invoke-static {v11, v12, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_4
.end method

.method private saveClipDataToCliptray(Landroid/content/ClipData;)Z
    .locals 3
    .param p1, "clip"    # Landroid/content/ClipData;

    .prologue
    .line 814
    if-eqz p1, :cond_1

    .line 816
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 817
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v0, :cond_0

    .line 818
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->doCopyAnimation()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 824
    .end local v0    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :cond_0
    :goto_0
    iget-object v2, p0, Lcom/lge/systemservice/core/CliptrayManager;->mClipManager:Landroid/content/ClipboardManager;

    invoke-virtual {v2, p1}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    .line 825
    const/4 v2, 0x1

    .line 827
    :goto_1
    return v2

    .line 820
    :catch_0
    move-exception v1

    .line 821
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 827
    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_1
    const/4 v2, 0x0

    goto :goto_1
.end method

.method private saveImageToDB(Landroid/content/ClipData;[Landroid/text/style/DynamicDrawableSpan;I)Landroid/content/ClipData;
    .locals 9
    .param p1, "clip"    # Landroid/content/ClipData;
    .param p2, "image"    # [Landroid/text/style/DynamicDrawableSpan;
    .param p3, "i"    # I

    .prologue
    .line 604
    aget-object v5, p2, p3

    invoke-virtual {v5}, Landroid/text/style/DynamicDrawableSpan;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    check-cast v1, Landroid/graphics/drawable/BitmapDrawable;

    .line 605
    .local v1, "drawable":Landroid/graphics/drawable/BitmapDrawable;
    if-eqz v1, :cond_1

    .line 606
    invoke-virtual {v1}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object v0

    .line 607
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->hasAlpha()Z

    move-result v2

    .line 608
    .local v2, "hasAlpha":Z
    invoke-direct {p0, v0, v2}, Lcom/lge/systemservice/core/CliptrayManager;->insertImage(Landroid/graphics/Bitmap;Z)Landroid/net/Uri;

    move-result-object v3

    .line 609
    .local v3, "imgUri":Landroid/net/Uri;
    new-instance v4, Landroid/content/ClipData$Item;

    invoke-direct {v4, v3}, Landroid/content/ClipData$Item;-><init>(Landroid/net/Uri;)V

    .line 612
    .local v4, "item":Landroid/content/ClipData$Item;
    if-nez p1, :cond_0

    .line 613
    new-instance p1, Landroid/content/ClipData;

    .end local p1    # "clip":Landroid/content/ClipData;
    const-string v5, "mage"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/String;

    const/4 v7, 0x0

    const-string/jumbo v8, "vnd.android.cursor.item/vnd.com.lge.cliptray.image"

    aput-object v8, v6, v7

    invoke-direct {p1, v5, v6, v4}, Landroid/content/ClipData;-><init>(Ljava/lang/CharSequence;[Ljava/lang/String;Landroid/content/ClipData$Item;)V

    .line 620
    .end local v0    # "bitmap":Landroid/graphics/Bitmap;
    .end local v2    # "hasAlpha":Z
    .end local v3    # "imgUri":Landroid/net/Uri;
    .end local v4    # "item":Landroid/content/ClipData$Item;
    .restart local p1    # "clip":Landroid/content/ClipData;
    :goto_0
    return-object p1

    .line 615
    .restart local v0    # "bitmap":Landroid/graphics/Bitmap;
    .restart local v2    # "hasAlpha":Z
    .restart local v3    # "imgUri":Landroid/net/Uri;
    .restart local v4    # "item":Landroid/content/ClipData$Item;
    :cond_0
    invoke-virtual {p1, v4}, Landroid/content/ClipData;->addItem(Landroid/content/ClipData$Item;)V

    goto :goto_0

    .line 618
    .end local v0    # "bitmap":Landroid/graphics/Bitmap;
    .end local v2    # "hasAlpha":Z
    .end local v3    # "imgUri":Landroid/net/Uri;
    .end local v4    # "item":Landroid/content/ClipData$Item;
    :cond_1
    const-string v5, "Cliptray Manager"

    const-string v6, "failed to copy image!!"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method


# virtual methods
.method public cleanClipTrayItems()Z
    .locals 3

    .prologue
    .line 678
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v1

    .line 679
    .local v1, "service":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v1, :cond_0

    .line 680
    invoke-interface {v1}, Lcom/lge/systemservice/core/ICliptrayService;->cleanClipTrayItems()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 681
    const/4 v2, 0x1

    .line 686
    .end local v1    # "service":Lcom/lge/systemservice/core/ICliptrayService;
    :goto_0
    return v2

    .line 683
    :catch_0
    move-exception v0

    .line 684
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 686
    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public copyImageListToCliptray(Landroid/content/ClipData;[Landroid/net/Uri;[Ljava/lang/String;)V
    .locals 17
    .param p1, "clipHtml"    # Landroid/content/ClipData;
    .param p2, "savedUri"    # [Landroid/net/Uri;
    .param p3, "imageUrl"    # [Ljava/lang/String;

    .prologue
    .line 299
    move-object/from16 v0, p2

    array-length v13, v0

    if-nez v13, :cond_0

    .line 300
    const/4 v13, 0x4

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-direct {v0, v13, v1}, Lcom/lge/systemservice/core/CliptrayManager;->doCopyToCliptray(ILjava/lang/Object;)V

    .line 301
    const-string v13, "Cliptray Manager"

    const-string v14, "copyImageListToCliptray::no image, save html text"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 354
    :goto_0
    return-void

    .line 305
    :cond_0
    const-string/jumbo v4, "\ufffc"

    .line 306
    .local v4, "image":Ljava/lang/String;
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v6

    .line 308
    .local v6, "imgLength":I
    const/4 v13, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v13}, Landroid/content/ClipData;->getItemAt(I)Landroid/content/ClipData$Item;

    move-result-object v7

    .line 309
    .local v7, "itemHtml":Landroid/content/ClipData$Item;
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    invoke-virtual {v7, v13}, Landroid/content/ClipData$Item;->coerceToStyledText(Landroid/content/Context;)Ljava/lang/CharSequence;

    move-result-object v10

    .line 311
    .local v10, "styledText":Ljava/lang/CharSequence;
    new-instance v11, Ljava/util/ArrayList;

    invoke-direct {v11}, Ljava/util/ArrayList;-><init>()V

    .line 312
    .local v11, "subText":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/CharSequence;>;"
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .line 314
    .local v5, "imgIndex":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Integer;>;"
    new-instance v8, Landroid/content/ClipData;

    const-string v13, "html"

    const/4 v14, 0x2

    new-array v14, v14, [Ljava/lang/String;

    const/4 v15, 0x0

    const-string v16, "text/html"

    aput-object v16, v14, v15

    const/4 v15, 0x1

    const-string/jumbo v16, "vnd.android.cursor.item/vnd.com.lge.cliptray.image"

    aput-object v16, v14, v15

    invoke-direct {v8, v13, v14, v7}, Landroid/content/ClipData;-><init>(Ljava/lang/CharSequence;[Ljava/lang/String;Landroid/content/ClipData$Item;)V

    .line 316
    .local v8, "newClipData":Landroid/content/ClipData;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    move-object/from16 v0, p2

    array-length v13, v0

    if-ge v3, v13, :cond_6

    .line 317
    if-nez v3, :cond_1

    const/4 v9, 0x0

    .line 318
    .local v9, "prevIndex":I
    :goto_2
    invoke-interface {v10}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v13, v4, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v2

    .line 319
    .local v2, "currIndex":I
    if-gez v2, :cond_2

    .line 320
    if-nez v3, :cond_6

    .line 321
    const-string v13, "Cliptray Manager"

    const-string v14, "image data not found!!"

    invoke-static {v13, v14}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 317
    .end local v2    # "currIndex":I
    .end local v9    # "prevIndex":I
    :cond_1
    add-int/lit8 v13, v3, -0x1

    invoke-virtual {v5, v13}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/Integer;

    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v13

    add-int v9, v13, v6

    goto :goto_2

    .line 327
    .restart local v2    # "currIndex":I
    .restart local v9    # "prevIndex":I
    :cond_2
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-virtual {v5, v13}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 328
    if-le v9, v2, :cond_4

    .line 329
    const-string v13, "Cliptray Manager"

    const-string v14, "prev index is larger than current index!!"

    invoke-static {v13, v14}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 340
    :cond_3
    :goto_3
    new-instance v13, Landroid/content/ClipData$Item;

    aget-object v14, p2, v3

    invoke-direct {v13, v14}, Landroid/content/ClipData$Item;-><init>(Landroid/net/Uri;)V

    invoke-virtual {v8, v13}, Landroid/content/ClipData;->addItem(Landroid/content/ClipData$Item;)V

    .line 316
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 330
    :cond_4
    if-ge v9, v2, :cond_3

    .line 331
    invoke-interface {v10, v9, v2}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v12

    .line 333
    .local v12, "temp":Ljava/lang/CharSequence;
    if-eqz v12, :cond_5

    invoke-interface {v12}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v13, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_5

    .line 334
    invoke-interface {v12}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v13, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v13

    add-int/2addr v13, v6

    invoke-interface {v12}, Ljava/lang/CharSequence;->length()I

    move-result v14

    invoke-interface {v12, v13, v14}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v12

    .line 336
    :cond_5
    invoke-virtual {v11, v12}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 338
    new-instance v13, Landroid/content/ClipData$Item;

    invoke-direct {v13, v12}, Landroid/content/ClipData$Item;-><init>(Ljava/lang/CharSequence;)V

    invoke-virtual {v8, v13}, Landroid/content/ClipData;->addItem(Landroid/content/ClipData$Item;)V

    goto :goto_3

    .line 343
    .end local v2    # "currIndex":I
    .end local v9    # "prevIndex":I
    .end local v12    # "temp":Ljava/lang/CharSequence;
    :cond_6
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v13

    add-int/lit8 v13, v13, -0x1

    invoke-virtual {v5, v13}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/Integer;

    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v13

    invoke-interface {v10}, Ljava/lang/CharSequence;->length()I

    move-result v14

    if-ge v13, v14, :cond_8

    .line 344
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v13

    add-int/lit8 v13, v13, -0x1

    invoke-virtual {v5, v13}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/Integer;

    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v13

    invoke-interface {v10}, Ljava/lang/CharSequence;->length()I

    move-result v14

    invoke-interface {v10, v13, v14}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v12

    .line 346
    .restart local v12    # "temp":Ljava/lang/CharSequence;
    if-eqz v12, :cond_7

    invoke-interface {v12}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v13, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_7

    .line 347
    invoke-interface {v12}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v13, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v13

    add-int/2addr v13, v6

    invoke-interface {v12}, Ljava/lang/CharSequence;->length()I

    move-result v14

    invoke-interface {v12, v13, v14}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v12

    .line 349
    :cond_7
    invoke-virtual {v11, v12}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 350
    new-instance v13, Landroid/content/ClipData$Item;

    invoke-direct {v13, v12}, Landroid/content/ClipData$Item;-><init>(Ljava/lang/CharSequence;)V

    invoke-virtual {v8, v13}, Landroid/content/ClipData;->addItem(Landroid/content/ClipData$Item;)V

    .line 353
    .end local v12    # "temp":Ljava/lang/CharSequence;
    :cond_8
    const/4 v13, 0x4

    move-object/from16 v0, p0

    invoke-direct {v0, v13, v8}, Lcom/lge/systemservice/core/CliptrayManager;->doCopyToCliptray(ILjava/lang/Object;)V

    goto/16 :goto_0
.end method

.method public copyImageToCliptray(Landroid/graphics/Bitmap;)V
    .locals 1
    .param p1, "image"    # Landroid/graphics/Bitmap;

    .prologue
    .line 667
    const/4 v0, 0x3

    invoke-direct {p0, v0, p1}, Lcom/lge/systemservice/core/CliptrayManager;->doCopyToCliptray(ILjava/lang/Object;)V

    .line 668
    return-void
.end method

.method public copyImageToCliptray(Landroid/net/Uri;)V
    .locals 1
    .param p1, "imgUri"    # Landroid/net/Uri;

    .prologue
    .line 258
    const/4 v0, 0x2

    invoke-direct {p0, v0, p1}, Lcom/lge/systemservice/core/CliptrayManager;->doCopyToCliptray(ILjava/lang/Object;)V

    .line 259
    return-void
.end method

.method public copyScreenCaptureToCliptray(Landroid/net/Uri;)V
    .locals 1
    .param p1, "imgUri"    # Landroid/net/Uri;

    .prologue
    .line 285
    const/4 v0, 0x5

    invoke-direct {p0, v0, p1}, Lcom/lge/systemservice/core/CliptrayManager;->doCopyToCliptray(ILjava/lang/Object;)V

    .line 286
    return-void
.end method

.method public copyTextToCliptray(Ljava/lang/String;)V
    .locals 1
    .param p1, "selectedText"    # Ljava/lang/String;

    .prologue
    .line 655
    const/4 v0, 0x1

    invoke-direct {p0, v0, p1}, Lcom/lge/systemservice/core/CliptrayManager;->doCopyToCliptray(ILjava/lang/Object;)V

    .line 656
    return-void
.end method

.method public copyToCliptray(Landroid/content/ClipData;)V
    .locals 1
    .param p1, "clip"    # Landroid/content/ClipData;

    .prologue
    .line 272
    const/4 v0, 0x4

    invoke-direct {p0, v0, p1}, Lcom/lge/systemservice/core/CliptrayManager;->doCopyToCliptray(ILjava/lang/Object;)V

    .line 273
    return-void
.end method

.method public copyToCliptray(Ljava/lang/CharSequence;)V
    .locals 1
    .param p1, "selectedText"    # Ljava/lang/CharSequence;

    .prologue
    .line 246
    const/4 v0, 0x0

    invoke-direct {p0, v0, p1}, Lcom/lge/systemservice/core/CliptrayManager;->doCopyToCliptray(ILjava/lang/Object;)V

    .line 247
    return-void
.end method

.method public getVisibility()I
    .locals 3

    .prologue
    .line 364
    const/4 v2, -0x1

    .line 366
    .local v2, "visibility":I
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 367
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v0, :cond_0

    .line 368
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->getVisibility()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 373
    .end local v0    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :cond_0
    :goto_0
    return v2

    .line 370
    :catch_0
    move-exception v1

    .line 371
    .local v1, "e1":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public hideCliptray()V
    .locals 3

    .prologue
    .line 204
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 205
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    iget-object v2, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    if-eqz v2, :cond_0

    if-nez v0, :cond_1

    .line 215
    :cond_0
    :goto_0
    return-void

    .line 210
    :cond_1
    if-eqz v0, :cond_0

    .line 211
    :try_start_0
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->hideCliptraycue()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 212
    :catch_0
    move-exception v1

    .line 213
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public hideCliptrayIfNeeded()V
    .locals 3

    .prologue
    .line 225
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 226
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    iget-object v2, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    if-eqz v2, :cond_0

    if-nez v0, :cond_1

    .line 235
    :cond_0
    :goto_0
    return-void

    .line 231
    :cond_1
    :try_start_0
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->hideCliptrayIfNeeded()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 232
    :catch_0
    move-exception v1

    .line 233
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public hideCliptraycue()V
    .locals 2

    .prologue
    .line 419
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 420
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v0, :cond_0

    .line 421
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->hideCliptraycue()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 425
    .end local v0    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :cond_0
    :goto_0
    return-void

    .line 422
    :catch_0
    move-exception v1

    .line 423
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public isAvailable()Z
    .locals 3

    .prologue
    .line 515
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 516
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v0, :cond_0

    .line 518
    :try_start_0
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->isAvailable()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 523
    :goto_0
    return v2

    .line 519
    :catch_0
    move-exception v1

    .line 520
    .local v1, "e1":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    .line 523
    .end local v1    # "e1":Landroid/os/RemoteException;
    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public isCliptraycueShowing()Z
    .locals 3

    .prologue
    .line 436
    const/4 v2, 0x0

    .line 438
    .local v2, "isShowing":Z
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 439
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v0, :cond_0

    .line 440
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->isCliptraycueShowing()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 444
    .end local v0    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :cond_0
    :goto_0
    return v2

    .line 441
    :catch_0
    move-exception v1

    .line 442
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public isServiceConnected()Z
    .locals 3

    .prologue
    .line 502
    const-string v0, "Cliptray Manager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "isServiceConnected : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/systemservice/core/CliptrayManager;->mConnected:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 503
    iget-boolean v0, p0, Lcom/lge/systemservice/core/CliptrayManager;->mConnected:Z

    return v0
.end method

.method public setInputType(I)V
    .locals 5
    .param p1, "type"    # I

    .prologue
    .line 484
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 485
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v0, :cond_0

    .line 486
    invoke-interface {v0, p1}, Lcom/lge/systemservice/core/ICliptrayService;->setInputType(I)V

    .line 487
    :cond_0
    const-string v2, "Cliptray Manager"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "setInputType : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 491
    .end local v0    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :goto_0
    return-void

    .line 488
    :catch_0
    move-exception v1

    .line 489
    .local v1, "e1":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public setInputType(Ljava/lang/String;)V
    .locals 6
    .param p1, "options"    # Ljava/lang/String;

    .prologue
    .line 458
    const/4 v2, 0x0

    .line 459
    .local v2, "type":I
    if-eqz p1, :cond_0

    const-string v3, "com.lge.cliptray.image"

    invoke-virtual {p1, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 460
    const/4 v2, 0x2

    .line 462
    :cond_0
    const-string v3, "Cliptray Manager"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "setInputType : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 465
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 466
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v0, :cond_1

    .line 467
    invoke-interface {v0, v2}, Lcom/lge/systemservice/core/ICliptrayService;->setInputType(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 471
    .end local v0    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :cond_1
    :goto_0
    return-void

    .line 468
    :catch_0
    move-exception v1

    .line 469
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public showCliptray()V
    .locals 3

    .prologue
    .line 184
    iget-object v2, p0, Lcom/lge/systemservice/core/CliptrayManager;->mContext:Landroid/content/Context;

    if-nez v2, :cond_1

    .line 195
    :cond_0
    :goto_0
    return-void

    .line 189
    :cond_1
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 190
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v0, :cond_0

    .line 191
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->showCliptraycueClose()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 192
    .end local v0    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :catch_0
    move-exception v1

    .line 193
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public showCliptraycue()V
    .locals 2

    .prologue
    .line 386
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 387
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v0, :cond_0

    .line 388
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->showCliptraycue()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 392
    .end local v0    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :cond_0
    :goto_0
    return-void

    .line 389
    :catch_0
    move-exception v1

    .line 390
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method public showCliptraycueClose()V
    .locals 2

    .prologue
    .line 403
    :try_start_0
    invoke-direct {p0}, Lcom/lge/systemservice/core/CliptrayManager;->getService()Lcom/lge/systemservice/core/ICliptrayService;

    move-result-object v0

    .line 404
    .local v0, "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    if-eqz v0, :cond_0

    .line 405
    invoke-interface {v0}, Lcom/lge/systemservice/core/ICliptrayService;->showCliptraycueClose()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 409
    .end local v0    # "cliptrayservice":Lcom/lge/systemservice/core/ICliptrayService;
    :cond_0
    :goto_0
    return-void

    .line 406
    :catch_0
    move-exception v1

    .line 407
    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method
