.class Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;
.super Landroid/media/MediaScanner$MyMediaScannerClient;
.source "MediaScannerEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/media/MediaScannerEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "MyMediaScannerClientEx"
.end annotation


# instance fields
.field private mIsHifi:Z

.field private mProtectedType:I

.field private mlatitude:F

.field private mlongitude:F

.field private mparseLatLonSuccess:Z

.field final synthetic this$0:Lcom/lge/media/MediaScannerEx;


# direct methods
.method private constructor <init>(Lcom/lge/media/MediaScannerEx;)V
    .locals 0

    .prologue
    .line 326
    iput-object p1, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    invoke-direct {p0, p1}, Landroid/media/MediaScanner$MyMediaScannerClient;-><init>(Landroid/media/MediaScanner;)V

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/media/MediaScannerEx;Lcom/lge/media/MediaScannerEx$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/media/MediaScannerEx;
    .param p2, "x1"    # Lcom/lge/media/MediaScannerEx$1;

    .prologue
    .line 326
    invoke-direct {p0, p1}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;-><init>(Lcom/lge/media/MediaScannerEx;)V

    return-void
.end method

.method private convertRationalLatLonToFloat(Ljava/lang/String;Z)Z
    .locals 7
    .param p1, "rationalString"    # Ljava/lang/String;
    .param p2, "isLat"    # Z

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 709
    const/4 v1, 0x0

    .line 710
    .local v1, "ref":I
    const/4 v2, 0x0

    .line 711
    .local v2, "result":F
    const/4 v0, 0x0

    .line 713
    .local v0, "length":I
    if-nez p1, :cond_1

    .line 741
    :cond_0
    :goto_0
    return v3

    .line 717
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 719
    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    const/16 v6, 0x2b

    if-ne v5, v6, :cond_2

    .line 720
    const/4 v1, 0x1

    .line 728
    :goto_1
    invoke-virtual {p1, v4, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v2

    .line 729
    const-string v3, "MediaScannerEx"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[MediaScanner] convertRational LatLonToFloat float = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v3, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 731
    if-ne p2, v4, :cond_3

    .line 732
    const-string v3, "MediaScannerEx"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[MediaScanner] convertRational LatLonToFloat isLat = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v3, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 733
    int-to-float v3, v1

    mul-float/2addr v3, v2

    iput v3, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mlatitude:F

    .line 739
    :goto_2
    const-string v3, "MediaScannerEx"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[MediaScanner] convertRational LatLonToFloat succeed, "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v3, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v3, v4

    .line 741
    goto :goto_0

    .line 721
    :cond_2
    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    const/16 v6, 0x2d

    if-ne v5, v6, :cond_0

    .line 722
    const/4 v1, -0x1

    goto :goto_1

    .line 735
    :cond_3
    const-string v3, "MediaScannerEx"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[MediaScanner] convertRational LatLonToFloat isLon = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v3, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 736
    int-to-float v3, v1

    mul-float/2addr v3, v2

    iput v3, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mlongitude:F

    goto :goto_2
.end method

.method private splitLatLon(Ljava/lang/String;Z)Ljava/lang/String;
    .locals 6
    .param p1, "rationalString"    # Ljava/lang/String;
    .param p2, "isLat"    # Z

    .prologue
    const/4 v2, 0x0

    .line 677
    const/4 v0, 0x0

    .line 679
    .local v0, "length":I
    if-nez p1, :cond_0

    move-object v1, v2

    .line 704
    :goto_0
    return-object v1

    .line 683
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 684
    const/4 v1, 0x0

    .line 685
    .local v1, "result":Ljava/lang/String;
    const-string v3, "MediaScannerEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[MediaScanner] convertRational LatLonToString rationalString = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 687
    const/16 v3, 0x12

    if-lt v0, v3, :cond_1

    move-object v1, v2

    .line 688
    goto :goto_0

    .line 691
    :cond_1
    div-int/lit8 v3, v0, 0x2

    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x2b

    if-eq v3, v4, :cond_2

    div-int/lit8 v3, v0, 0x2

    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x2d

    if-ne v3, v4, :cond_3

    .line 697
    :cond_2
    const/4 v2, 0x1

    if-ne p2, v2, :cond_4

    .line 698
    const/4 v2, 0x0

    div-int/lit8 v3, v0, 0x2

    invoke-virtual {p1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_3
    move-object v1, v2

    .line 694
    goto :goto_0

    .line 701
    :cond_4
    div-int/lit8 v2, v0, 0x2

    invoke-virtual {p1, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    goto :goto_0
.end method


# virtual methods
.method public beginFile(Ljava/lang/String;Ljava/lang/String;JJZZ)Landroid/media/MediaScanner$FileEntry;
    .locals 3
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "mimeType"    # Ljava/lang/String;
    .param p3, "lastModified"    # J
    .param p5, "fileSize"    # J
    .param p7, "isDirectory"    # Z
    .param p8, "noMedia"    # Z

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 354
    iput v1, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mProtectedType:I

    .line 357
    iput-boolean v1, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mparseLatLonSuccess:Z

    .line 358
    iput v2, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mlatitude:F

    .line 359
    iput v2, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mlongitude:F

    .line 361
    iput-boolean v1, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mIsHifi:Z

    .line 362
    invoke-super/range {p0 .. p8}, Landroid/media/MediaScanner$MyMediaScannerClient;->beginFile(Ljava/lang/String;Ljava/lang/String;JJZZ)Landroid/media/MediaScanner$FileEntry;

    move-result-object v0

    .line 363
    .local v0, "entry":Landroid/media/MediaScanner$FileEntry;
    return-object v0
.end method

.method public doScanFile(Ljava/lang/String;Ljava/lang/String;JJZZZ)Landroid/net/Uri;
    .locals 1
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "mimeType"    # Ljava/lang/String;
    .param p3, "lastModified"    # J
    .param p5, "fileSize"    # J
    .param p7, "isDirectory"    # Z
    .param p8, "scanAlways"    # Z
    .param p9, "noMedia"    # Z

    .prologue
    .line 346
    invoke-super/range {p0 .. p9}, Landroid/media/MediaScanner$MyMediaScannerClient;->doScanFile(Ljava/lang/String;Ljava/lang/String;JJZZZ)Landroid/net/Uri;

    move-result-object v0

    .line 347
    .local v0, "result":Landroid/net/Uri;
    return-object v0
.end method

.method protected endFile(Landroid/media/MediaScanner$FileEntry;ZZZZZ)Landroid/net/Uri;
    .locals 24
    .param p1, "entry"    # Landroid/media/MediaScanner$FileEntry;
    .param p2, "ringtones"    # Z
    .param p3, "notifications"    # Z
    .param p4, "alarms"    # Z
    .param p5, "music"    # Z
    .param p6, "podcasts"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    .line 496
    const/16 v21, 0x0

    .line 497
    .local v21, "timerAlert":Z
    const/4 v15, 0x0

    .line 500
    .local v15, "needToSetSettings2":Z
    sget-boolean v2, Lcom/lge/config/ConfigBuildFlags;->CAPP_DRM:Z

    if-eqz v2, :cond_0

    .line 501
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mMimeType:Ljava/lang/String;

    invoke-static {v2}, Landroid/media/MediaFile;->getFileTypeForMimeType(Ljava/lang/String;)I

    move-result v10

    .line 502
    .local v10, "fileType":I
    move-object/from16 v0, p0

    iget v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mFileType:I

    invoke-static {v2}, Landroid/media/MediaFile;->isAudioFileType(I)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 503
    const/16 v2, 0x515

    if-lt v10, v2, :cond_0

    const/16 v2, 0x51a

    if-gt v10, v2, :cond_0

    .line 510
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mContext:Landroid/content/Context;
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$100(Lcom/lge/media/MediaScannerEx;)Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$bool;->config_chameleon_supported:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v20

    .line 511
    .local v20, "sprintSupported":Z
    if-eqz v20, :cond_0

    .line 512
    const/16 p2, 0x1

    .line 521
    .end local v10    # "fileType":I
    .end local v20    # "sprintSupported":Z
    :cond_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v2, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v12

    .line 522
    .local v12, "lowpath":Ljava/lang/String;
    const-string v2, "/my_sounds/"

    invoke-virtual {v12, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-lez v2, :cond_12

    const-string v2, "3GP"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    const-string v7, "."

    invoke-virtual {v6, v7}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v6

    add-int/lit8 v6, v6, 0x1

    invoke-virtual {v3, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "AMR"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    const-string v7, "."

    invoke-virtual {v6, v7}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v6

    add-int/lit8 v6, v6, 0x1

    invoke-virtual {v3, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_12

    :cond_1
    const/16 v23, 0x1

    .line 526
    .local v23, "voicerecording":Z
    :goto_0
    if-eqz v23, :cond_2

    .line 527
    const/16 p5, 0x0

    .line 531
    :cond_2
    const/4 v4, 0x0

    .line 533
    .local v4, "result":Landroid/net/Uri;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mWasEmptyPriorToScan:Z
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$200(Lcom/lge/media/MediaScannerEx;)Z

    move-result v2

    if-eqz v2, :cond_8

    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mNoMedia:Z

    if-nez v2, :cond_8

    .line 534
    const-string v2, "MediaScannerEx"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[MediaScanner] endFile() mPath = "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " ,entry.mRowId = "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p1

    iget-wide v6, v0, Landroid/media/MediaScanner$FileEntry;->mRowId:J

    invoke-virtual {v3, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " ,alarms = "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, p4

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " ,mDefaultTimerAlertSet = "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mDefaultTimerAlertSet:Z
    invoke-static {v6}, Lcom/lge/media/MediaScannerEx;->access$300(Lcom/lge/media/MediaScannerEx;)Z

    move-result v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 535
    move-object/from16 v0, p1

    iget-wide v0, v0, Landroid/media/MediaScanner$FileEntry;->mRowId:J

    move-wide/from16 v18, v0

    .line 536
    .local v18, "rowId":J
    move-object/from16 v0, p0

    iget v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mFileType:I

    invoke-static {v2}, Landroid/media/MediaFile;->isAudioFileType(I)Z

    move-result v2

    if-eqz v2, :cond_8

    const-wide/16 v2, 0x0

    cmp-long v2, v18, v2

    if-nez v2, :cond_8

    .line 537
    if-eqz p4, :cond_8

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mDefaultTimerAlertSet:Z
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$300(Lcom/lge/media/MediaScannerEx;)Z

    move-result v2

    if-nez v2, :cond_8

    .line 538
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mDefaultTimerAlertFilename:Ljava/lang/String;
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$400(Lcom/lge/media/MediaScannerEx;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mDefaultTimerAlertFilename:Ljava/lang/String;
    invoke-static {v3}, Lcom/lge/media/MediaScannerEx;->access$400(Lcom/lge/media/MediaScannerEx;)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->doesPathHaveFilename(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 540
    :cond_3
    invoke-virtual/range {p0 .. p0}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->toValues()Landroid/content/ContentValues;

    move-result-object v5

    .line 541
    .local v5, "values":Landroid/content/ContentValues;
    const-string v2, "title"

    invoke-virtual {v5, v2}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v22

    .line 542
    .local v22, "title":Ljava/lang/String;
    if-eqz v22, :cond_4

    invoke-virtual/range {v22 .. v22}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 543
    :cond_4
    const-string v2, "_data"

    invoke-virtual {v5, v2}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/media/MediaFile;->getFileTitle(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v22

    .line 544
    const-string v2, "title"

    move-object/from16 v0, v22

    invoke-virtual {v5, v2, v0}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 546
    :cond_5
    const-string v2, "is_ringtone"

    invoke-static/range {p2 .. p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v5, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 547
    const-string v2, "is_notification"

    invoke-static/range {p3 .. p3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v5, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 548
    const-string v2, "is_alarm"

    invoke-static/range {p4 .. p4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v5, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 549
    const-string v2, "is_music"

    invoke-static/range {p5 .. p5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v5, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 550
    const-string v2, "is_podcast"

    invoke-static/range {p6 .. p6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v5, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 551
    const/16 v21, 0x1

    .line 552
    const/4 v15, 0x1

    .line 553
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mMediaInserter:Landroid/media/MediaInserter;
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$500(Lcom/lge/media/MediaScannerEx;)Landroid/media/MediaInserter;

    move-result-object v11

    .line 554
    .local v11, "inserter":Landroid/media/MediaInserter;
    if-eqz v11, :cond_6

    if-eqz v15, :cond_8

    .line 555
    :cond_6
    if-eqz v11, :cond_7

    .line 556
    invoke-virtual {v11}, Landroid/media/MediaInserter;->flushAll()V

    .line 558
    :cond_7
    const-string v2, "MediaScannerEx"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[MediaScanner] endFile() mAudioUri = "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mAudioUri:Landroid/net/Uri;
    invoke-static {v6}, Lcom/lge/media/MediaScannerEx;->access$600(Lcom/lge/media/MediaScannerEx;)Landroid/net/Uri;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 559
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mMediaProvider:Landroid/content/IContentProvider;
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$900(Lcom/lge/media/MediaScannerEx;)Landroid/content/IContentProvider;

    move-result-object v2

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mPackageName:Ljava/lang/String;
    invoke-static {v3}, Lcom/lge/media/MediaScannerEx;->access$700(Lcom/lge/media/MediaScannerEx;)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mAudioUri:Landroid/net/Uri;
    invoke-static {v6}, Lcom/lge/media/MediaScannerEx;->access$800(Lcom/lge/media/MediaScannerEx;)Landroid/net/Uri;

    move-result-object v6

    invoke-interface {v2, v3, v6, v5}, Landroid/content/IContentProvider;->insert(Ljava/lang/String;Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v4

    .line 567
    .end local v5    # "values":Landroid/content/ContentValues;
    .end local v11    # "inserter":Landroid/media/MediaInserter;
    .end local v18    # "rowId":J
    .end local v22    # "title":Ljava/lang/String;
    :cond_8
    if-nez v4, :cond_d

    .line 568
    invoke-super/range {p0 .. p6}, Landroid/media/MediaScanner$MyMediaScannerClient;->endFile(Landroid/media/MediaScanner$FileEntry;ZZZZZ)Landroid/net/Uri;

    move-result-object v4

    .line 569
    if-eqz v4, :cond_d

    .line 570
    const/16 v16, 0x0

    .line 571
    .local v16, "needToupdate":Z
    const/4 v14, 0x0

    .line 572
    .local v14, "mediaType":I
    new-instance v5, Landroid/content/ContentValues;

    invoke-direct {v5}, Landroid/content/ContentValues;-><init>()V

    .line 573
    .restart local v5    # "values":Landroid/content/ContentValues;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    invoke-static {v2}, Landroid/media/MediaScanner;->isNoMediaPath(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_c

    .line 574
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mMimeType:Ljava/lang/String;

    invoke-static {v2}, Landroid/media/MediaFile;->getFileTypeForMimeType(Ljava/lang/String;)I

    move-result v10

    .line 576
    .restart local v10    # "fileType":I
    if-nez v10, :cond_9

    .line 577
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    invoke-static {v2}, Landroid/media/MediaFile;->getFileType(Ljava/lang/String;)Landroid/media/MediaFile$MediaFileType;

    move-result-object v13

    .line 578
    .local v13, "mediaFileType":Landroid/media/MediaFile$MediaFileType;
    if-eqz v13, :cond_9

    .line 579
    iget v10, v13, Landroid/media/MediaFile$MediaFileType;->fileType:I

    .line 580
    const/16 v16, 0x1

    .line 586
    .end local v13    # "mediaFileType":Landroid/media/MediaFile$MediaFileType;
    :cond_9
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    invoke-virtual {v2}, Lcom/lge/media/MediaScannerEx;->isDrmEnabled()Z

    move-result v2

    if-eqz v2, :cond_a

    invoke-static {v10}, Landroid/media/MediaFile;->isDrmFileType(I)Z

    move-result v2

    if-eqz v2, :cond_a

    .line 587
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->getFileTypeFromDrm(Ljava/lang/String;)I

    move-result v10

    .line 588
    const/16 v16, 0x1

    .line 591
    :cond_a
    invoke-static {v10}, Landroid/media/MediaFile;->isAudioFileType(I)Z

    move-result v2

    if-eqz v2, :cond_13

    .line 592
    const/4 v14, 0x2

    .line 600
    :cond_b
    :goto_1
    const-string v2, "media_type"

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v5, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 602
    .end local v10    # "fileType":I
    :cond_c
    if-eqz v16, :cond_d

    .line 603
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mMediaProvider:Landroid/content/IContentProvider;
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$1100(Lcom/lge/media/MediaScannerEx;)Landroid/content/IContentProvider;

    move-result-object v2

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mPackageName:Ljava/lang/String;
    invoke-static {v3}, Lcom/lge/media/MediaScannerEx;->access$1000(Lcom/lge/media/MediaScannerEx;)Ljava/lang/String;

    move-result-object v3

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-interface/range {v2 .. v7}, Landroid/content/IContentProvider;->update(Ljava/lang/String;Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    .line 608
    .end local v5    # "values":Landroid/content/ContentValues;
    .end local v14    # "mediaType":I
    .end local v16    # "needToupdate":Z
    :cond_d
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mWasEmptyPriorToScan:Z
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$1200(Lcom/lge/media/MediaScannerEx;)Z

    move-result v2

    if-eqz v2, :cond_f

    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mNoMedia:Z

    if-nez v2, :cond_f

    .line 610
    if-eqz p3, :cond_16

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mDefaultNotificationSet2:Z
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$1300(Lcom/lge/media/MediaScannerEx;)Z

    move-result v2

    if-nez v2, :cond_16

    .line 611
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mDefaultNotificationFilename:Ljava/lang/String;
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$1400(Lcom/lge/media/MediaScannerEx;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_e

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mDefaultNotificationFilename:Ljava/lang/String;
    invoke-static {v3}, Lcom/lge/media/MediaScannerEx;->access$1500(Lcom/lge/media/MediaScannerEx;)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->doesPathHaveFilename(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_f

    .line 613
    :cond_e
    const/4 v15, 0x1

    .line 623
    :cond_f
    :goto_2
    if-eqz v15, :cond_10

    .line 624
    if-eqz p3, :cond_18

    .line 626
    const-string v2, "notification_sound_sim2"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mAudioUri:Landroid/net/Uri;
    invoke-static {v3}, Lcom/lge/media/MediaScannerEx;->access$1900(Lcom/lge/media/MediaScannerEx;)Landroid/net/Uri;

    move-result-object v3

    invoke-static {v4}, Landroid/content/ContentUris;->parseId(Landroid/net/Uri;)J

    move-result-wide v6

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3, v6, v7}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->setSettingIfNotSet(Ljava/lang/String;Landroid/net/Uri;J)V

    .line 627
    const-string v2, "MediaScannerEx"

    const-string v3, "[MediaScanner] Set a default 2nd sim noti sound"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 630
    const-string v2, "notification_sound_sim3"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mAudioUri:Landroid/net/Uri;
    invoke-static {v3}, Lcom/lge/media/MediaScannerEx;->access$2000(Lcom/lge/media/MediaScannerEx;)Landroid/net/Uri;

    move-result-object v3

    invoke-static {v4}, Landroid/content/ContentUris;->parseId(Landroid/net/Uri;)J

    move-result-wide v6

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3, v6, v7}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->setSettingIfNotSet(Ljava/lang/String;Landroid/net/Uri;J)V

    .line 632
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    const/4 v3, 0x1

    # setter for: Lcom/lge/media/MediaScannerEx;->mDefaultNotificationSet2:Z
    invoke-static {v2, v3}, Lcom/lge/media/MediaScannerEx;->access$1302(Lcom/lge/media/MediaScannerEx;Z)Z

    .line 656
    :cond_10
    :goto_3
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mContext:Landroid/content/Context;
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$2500(Lcom/lge/media/MediaScannerEx;)Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$bool;->config_chameleon_supported:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v9

    .line 657
    .local v9, "chameleonSupported":Z
    const-string v2, "ro.config.ringtone"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17

    .line 658
    .local v17, "roRingtone":Ljava/lang/String;
    const-string v8, "default_ringer.mp3"

    .line 659
    .local v8, "carrierRingtone":Ljava/lang/String;
    if-eqz v4, :cond_11

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mContext:Landroid/content/Context;
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$2600(Lcom/lge/media/MediaScannerEx;)Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "ringtone"

    invoke-static {v2, v3}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_11

    .line 660
    if-eqz v9, :cond_11

    move-object/from16 v0, v17

    invoke-virtual {v0, v8}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_11

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mContext:Landroid/content/Context;
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$2700(Lcom/lge/media/MediaScannerEx;)Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "ringtone"

    invoke-static {v2, v3}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "content://media/internal/audio/media/99999"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_11

    .line 662
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v8}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->doesPathHaveFilename(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_11

    .line 663
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mContext:Landroid/content/Context;
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$2800(Lcom/lge/media/MediaScannerEx;)Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "ringtone"

    invoke-virtual {v4}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v2, v3, v6}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 669
    :cond_11
    return-object v4

    .line 522
    .end local v4    # "result":Landroid/net/Uri;
    .end local v8    # "carrierRingtone":Ljava/lang/String;
    .end local v9    # "chameleonSupported":Z
    .end local v17    # "roRingtone":Ljava/lang/String;
    .end local v23    # "voicerecording":Z
    :cond_12
    const/16 v23, 0x0

    goto/16 :goto_0

    .line 593
    .restart local v4    # "result":Landroid/net/Uri;
    .restart local v5    # "values":Landroid/content/ContentValues;
    .restart local v10    # "fileType":I
    .restart local v14    # "mediaType":I
    .restart local v16    # "needToupdate":Z
    .restart local v23    # "voicerecording":Z
    :cond_13
    invoke-static {v10}, Landroid/media/MediaFile;->isVideoFileType(I)Z

    move-result v2

    if-eqz v2, :cond_14

    .line 594
    const/4 v14, 0x3

    goto/16 :goto_1

    .line 595
    :cond_14
    invoke-static {v10}, Landroid/media/MediaFile;->isImageFileType(I)Z

    move-result v2

    if-eqz v2, :cond_15

    .line 596
    const/4 v14, 0x1

    goto/16 :goto_1

    .line 597
    :cond_15
    invoke-static {v10}, Landroid/media/MediaFile;->isPlayListFileType(I)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 598
    const/4 v14, 0x4

    goto/16 :goto_1

    .line 615
    .end local v5    # "values":Landroid/content/ContentValues;
    .end local v10    # "fileType":I
    .end local v14    # "mediaType":I
    .end local v16    # "needToupdate":Z
    :cond_16
    if-eqz p2, :cond_f

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mDefaultRingtoneSet2:Z
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$1600(Lcom/lge/media/MediaScannerEx;)Z

    move-result v2

    if-nez v2, :cond_f

    .line 616
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mDefaultRingtoneFilename:Ljava/lang/String;
    invoke-static {v2}, Lcom/lge/media/MediaScannerEx;->access$1700(Lcom/lge/media/MediaScannerEx;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_17

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mDefaultRingtoneFilename:Ljava/lang/String;
    invoke-static {v3}, Lcom/lge/media/MediaScannerEx;->access$1800(Lcom/lge/media/MediaScannerEx;)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->doesPathHaveFilename(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_f

    .line 618
    :cond_17
    const/4 v15, 0x1

    goto/16 :goto_2

    .line 633
    :cond_18
    if-eqz p2, :cond_19

    .line 635
    const-string v2, "ringtone_sim2"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mAudioUri:Landroid/net/Uri;
    invoke-static {v3}, Lcom/lge/media/MediaScannerEx;->access$2100(Lcom/lge/media/MediaScannerEx;)Landroid/net/Uri;

    move-result-object v3

    invoke-static {v4}, Landroid/content/ContentUris;->parseId(Landroid/net/Uri;)J

    move-result-wide v6

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3, v6, v7}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->setSettingIfNotSet(Ljava/lang/String;Landroid/net/Uri;J)V

    .line 636
    const-string v2, "MediaScannerEx"

    const-string v3, "[MediaScanner] Set a default 2nd sim ringtone"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 637
    const-string v2, "ringtone_videocall"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mAudioUri:Landroid/net/Uri;
    invoke-static {v3}, Lcom/lge/media/MediaScannerEx;->access$2200(Lcom/lge/media/MediaScannerEx;)Landroid/net/Uri;

    move-result-object v3

    invoke-static {v4}, Landroid/content/ContentUris;->parseId(Landroid/net/Uri;)J

    move-result-wide v6

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3, v6, v7}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->setSettingIfNotSet(Ljava/lang/String;Landroid/net/Uri;J)V

    .line 638
    const-string v2, "MediaScannerEx"

    const-string v3, "[MediaScanner] Set a default video call ringtone for KT"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 641
    const-string v2, "ringtone_sim3"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mAudioUri:Landroid/net/Uri;
    invoke-static {v3}, Lcom/lge/media/MediaScannerEx;->access$2300(Lcom/lge/media/MediaScannerEx;)Landroid/net/Uri;

    move-result-object v3

    invoke-static {v4}, Landroid/content/ContentUris;->parseId(Landroid/net/Uri;)J

    move-result-wide v6

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3, v6, v7}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->setSettingIfNotSet(Ljava/lang/String;Landroid/net/Uri;J)V

    .line 643
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    const/4 v3, 0x1

    # setter for: Lcom/lge/media/MediaScannerEx;->mDefaultRingtoneSet2:Z
    invoke-static {v2, v3}, Lcom/lge/media/MediaScannerEx;->access$1602(Lcom/lge/media/MediaScannerEx;Z)Z

    goto/16 :goto_3

    .line 644
    :cond_19
    if-eqz p4, :cond_10

    .line 646
    const-string v2, "MediaScannerEx"

    const-string v3, "[MediaScanner] Set a timerAlert"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 647
    if-eqz v21, :cond_10

    .line 648
    const-string v2, "timer_alert"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    # getter for: Lcom/lge/media/MediaScannerEx;->mAudioUri:Landroid/net/Uri;
    invoke-static {v3}, Lcom/lge/media/MediaScannerEx;->access$2400(Lcom/lge/media/MediaScannerEx;)Landroid/net/Uri;

    move-result-object v3

    invoke-static {v4}, Landroid/content/ContentUris;->parseId(Landroid/net/Uri;)J

    move-result-wide v6

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3, v6, v7}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->setSettingIfNotSet(Ljava/lang/String;Landroid/net/Uri;J)V

    .line 649
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    const/4 v3, 0x1

    # setter for: Lcom/lge/media/MediaScannerEx;->mDefaultTimerAlertSet:Z
    invoke-static {v2, v3}, Lcom/lge/media/MediaScannerEx;->access$302(Lcom/lge/media/MediaScannerEx;Z)Z

    goto/16 :goto_3
.end method

.method protected getFileTypeFromDrm(Ljava/lang/String;)I
    .locals 4
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    .line 747
    iget-object v2, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    invoke-virtual {v2}, Lcom/lge/media/MediaScannerEx;->isDrmEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    .line 748
    const/4 v1, 0x0

    .line 766
    :cond_0
    :goto_0
    return v1

    .line 751
    :cond_1
    const/4 v1, 0x0

    .line 754
    .local v1, "resultFileType":I
    sget-boolean v2, Lcom/lge/config/ConfigBuildFlags;->CAPP_DRM:Z

    if-eqz v2, :cond_3

    .line 755
    invoke-static {p1}, Lcom/lge/lgdrm/DrmFwExt$MediaFile;->getFileTypeFromDrm(Ljava/lang/String;)Lcom/lge/lgdrm/DrmFwExt$MediaFile$MediaFileType;

    move-result-object v0

    .line 756
    .local v0, "mediaFileType":Lcom/lge/lgdrm/DrmFwExt$MediaFile$MediaFileType;
    if-eqz v0, :cond_2

    .line 757
    iget v1, v0, Lcom/lge/lgdrm/DrmFwExt$MediaFile$MediaFileType;->fileType:I

    goto :goto_0

    .line 759
    :cond_2
    const-string v2, "drm.service.enabled"

    const-string v3, "false"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "false"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 765
    .end local v0    # "mediaFileType":Lcom/lge/lgdrm/DrmFwExt$MediaFile$MediaFileType;
    :cond_3
    invoke-super {p0, p1}, Landroid/media/MediaScanner$MyMediaScannerClient;->getFileTypeFromDrm(Ljava/lang/String;)I

    move-result v1

    .line 766
    goto :goto_0
.end method

.method public handleStringTag(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 368
    invoke-super {p0, p1, p2}, Landroid/media/MediaScanner$MyMediaScannerClient;->handleStringTag(Ljava/lang/String;Ljava/lang/String;)V

    .line 371
    const-string v2, "location"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 372
    invoke-direct {p0, p2, v0}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->splitLatLon(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2, v0}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->convertRationalLatLonToFloat(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-direct {p0, p2, v1}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->splitLatLon(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2, v1}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->convertRationalLatLonToFloat(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 374
    iput-boolean v0, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mparseLatLonSuccess:Z

    .line 382
    :cond_0
    :goto_0
    return-void

    .line 378
    :cond_1
    const-string v2, "ishifi"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 379
    invoke-virtual {p0, p2, v1, v1}, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->parseSubstring(Ljava/lang/String;II)I

    move-result v2

    if-ne v2, v0, :cond_2

    :goto_1
    iput-boolean v0, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mIsHifi:Z

    goto :goto_0

    :cond_2
    move v0, v1

    goto :goto_1
.end method

.method public scanFile(Ljava/lang/String;JJZZ)V
    .locals 0
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "lastModified"    # J
    .param p4, "fileSize"    # J
    .param p6, "isDirectory"    # Z
    .param p7, "noMedia"    # Z

    .prologue
    .line 340
    invoke-super/range {p0 .. p7}, Landroid/media/MediaScanner$MyMediaScannerClient;->scanFile(Ljava/lang/String;JJZZ)V

    .line 341
    return-void
.end method

.method public setMimeType(Ljava/lang/String;)V
    .locals 3
    .param p1, "mimeType"    # Ljava/lang/String;

    .prologue
    .line 387
    sget-boolean v2, Lcom/lge/config/ConfigBuildFlags;->CAPP_DRM:Z

    if-eqz v2, :cond_4

    .line 388
    iget-object v2, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mMimeType:Ljava/lang/String;

    invoke-static {v2}, Landroid/media/MediaFile;->getFileTypeForMimeType(Ljava/lang/String;)I

    move-result v1

    .line 390
    .local v1, "fileType":I
    const/16 v2, 0x515

    if-lt v1, v2, :cond_0

    const/16 v2, 0x51a

    if-le v1, v2, :cond_1

    .line 391
    :cond_0
    invoke-super {p0, p1}, Landroid/media/MediaScanner$MyMediaScannerClient;->setMimeType(Ljava/lang/String;)V

    .line 403
    .end local v1    # "fileType":I
    :goto_0
    return-void

    .line 393
    .restart local v1    # "fileType":I
    :cond_1
    iget-object v2, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    invoke-static {v2}, Lcom/lge/lgdrm/DrmManager;->isDRM(Ljava/lang/String;)I

    move-result v0

    .line 394
    .local v0, "drmType":I
    const/16 v2, 0x501

    if-eq v0, v2, :cond_2

    const/16 v2, 0x1800

    if-ne v0, v2, :cond_3

    .line 395
    :cond_2
    iput-object p1, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mMimeType:Ljava/lang/String;

    .line 397
    :cond_3
    invoke-static {p1}, Landroid/media/MediaFile;->getFileTypeForMimeType(Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mFileType:I

    goto :goto_0

    .line 401
    .end local v0    # "drmType":I
    .end local v1    # "fileType":I
    :cond_4
    invoke-super {p0, p1}, Landroid/media/MediaScanner$MyMediaScannerClient;->setMimeType(Ljava/lang/String;)V

    goto :goto_0
.end method

.method protected toValues()Landroid/content/ContentValues;
    .locals 11

    .prologue
    const/16 v10, 0xc

    const/4 v9, 0x0

    const/4 v8, 0x1

    .line 407
    invoke-super {p0}, Landroid/media/MediaScanner$MyMediaScannerClient;->toValues()Landroid/content/ContentValues;

    move-result-object v4

    .line 410
    .local v4, "map":Landroid/content/ContentValues;
    iget v6, p0, Landroid/media/MediaScanner$MyMediaScannerClient;->mFileType:I

    if-eqz v6, :cond_2

    .line 411
    iget-boolean v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mIsDrm:Z

    if-nez v6, :cond_0

    iget v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mProtectedType:I

    if-ne v6, v8, :cond_a

    .line 412
    :cond_0
    iput v8, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mProtectedType:I

    .line 421
    :cond_1
    :goto_0
    iget v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mProtectedType:I

    if-eq v6, v8, :cond_2

    iget v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mFileType:I

    invoke-static {v6}, Landroid/media/MediaFileEx;->isDMBFileType(I)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 422
    const/4 v6, 0x2

    iput v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mProtectedType:I

    .line 427
    :cond_2
    const-string v6, "protected_type"

    iget v7, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mProtectedType:I

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 429
    iget v6, p0, Landroid/media/MediaScanner$MyMediaScannerClient;->mFileType:I

    invoke-static {v6}, Landroid/media/MediaFile;->isVideoFileType(I)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 431
    iget-boolean v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mparseLatLonSuccess:Z

    if-eqz v6, :cond_3

    .line 432
    const-string v6, "latitude"

    iget v7, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mlatitude:F

    invoke-static {v7}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Float;)V

    .line 433
    const-string v6, "longitude"

    iget v7, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mlongitude:F

    invoke-static {v7}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Float;)V

    .line 438
    :cond_3
    iget-boolean v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mIsHifi:Z

    if-eqz v6, :cond_b

    .line 439
    const-string v6, "is_hifi"

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 446
    :goto_1
    iget-object v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    invoke-static {v6}, Lcom/lge/lgdrm/DrmManager;->isDRM(Ljava/lang/String;)I

    move-result v6

    const/16 v7, 0x91

    if-ne v6, v7, :cond_c

    .line 447
    const-string v6, "is_lock"

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 454
    :goto_2
    sget-boolean v6, Lcom/lge/config/ConfigBuildFlags;->CAPP_CAMERA_BURSTSHOT:Z

    if-eqz v6, :cond_8

    .line 455
    iget v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mFileType:I

    invoke-static {v6}, Landroid/media/MediaFile;->isImageFileType(I)Z

    move-result v6

    if-nez v6, :cond_4

    iget v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mFileType:I

    invoke-static {v6}, Landroid/media/MediaFile;->isVideoFileType(I)Z

    move-result v6

    if-eqz v6, :cond_8

    .line 456
    :cond_4
    iget-object v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    invoke-virtual {v6}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v1

    .line 457
    .local v1, "burst_value":Ljava/lang/String;
    const/16 v6, 0x2f

    invoke-virtual {v1, v6}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v3

    .line 458
    .local v3, "lastSlash":I
    add-int/lit8 v6, v3, 0x1

    invoke-virtual {v1, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    .line 459
    if-ltz v3, :cond_8

    .line 460
    const-string v6, "_Burst"

    invoke-virtual {v1, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_7

    .line 461
    const-string v6, "_Burst"

    invoke-virtual {v1, v6}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v1, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    const-string v7, "."

    invoke-virtual {v6, v7}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    .line 462
    .local v0, "burst_check":I
    const-string v6, ".jpg"

    invoke-virtual {v1, v6}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_5

    const/16 v6, 0x8

    if-eq v0, v6, :cond_6

    :cond_5
    const-string v6, ".jpg.dm"

    invoke-virtual {v1, v6}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_7

    if-ne v0, v10, :cond_7

    .line 464
    :cond_6
    const-string v6, "_Burst"

    invoke-virtual {v1, v6}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v1, v9, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 467
    .end local v0    # "burst_check":I
    :cond_7
    const-string v6, "burst_id"

    invoke-virtual {v4, v6, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 474
    .end local v1    # "burst_value":Ljava/lang/String;
    .end local v3    # "lastSlash":I
    :cond_8
    sget-boolean v6, Lcom/lge/config/ConfigBuildFlags;->CAPP_DRM:Z

    if-eqz v6, :cond_9

    .line 475
    iget-object v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mMimeType:Ljava/lang/String;

    invoke-static {v6}, Landroid/media/MediaFile;->getFileTypeForMimeType(Ljava/lang/String;)I

    move-result v2

    .line 476
    .local v2, "fileType":I
    const/16 v6, 0x515

    if-ne v2, v6, :cond_9

    .line 477
    invoke-static {v10}, Lcom/lge/lgdrm/DrmManager;->isSupportedAgent(I)Z

    move-result v6

    if-eqz v6, :cond_9

    iget-object v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    invoke-static {v6}, Lcom/lge/lgdrm/DrmManager;->isDRM(Ljava/lang/String;)I

    move-result v6

    const/16 v7, 0x31

    if-ne v6, v7, :cond_9

    .line 479
    iget-object v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    invoke-static {v6}, Lcom/lge/lgdrm/DrmFwExt$MediaFile;->getFileTypeFromDrm(Ljava/lang/String;)Lcom/lge/lgdrm/DrmFwExt$MediaFile$MediaFileType;

    move-result-object v5

    .line 480
    .local v5, "mediaFileType":Lcom/lge/lgdrm/DrmFwExt$MediaFile$MediaFileType;
    if-eqz v5, :cond_9

    .line 482
    const-string v6, "mime_type"

    iget-object v7, v5, Lcom/lge/lgdrm/DrmFwExt$MediaFile$MediaFileType;->mimeType:Ljava/lang/String;

    invoke-virtual {v4, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 489
    .end local v2    # "fileType":I
    .end local v5    # "mediaFileType":Lcom/lge/lgdrm/DrmFwExt$MediaFile$MediaFileType;
    :cond_9
    return-object v4

    .line 414
    :cond_a
    iget-object v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mPath:Ljava/lang/String;

    invoke-static {v6}, Landroid/media/MediaFile;->getFileType(Ljava/lang/String;)Landroid/media/MediaFile$MediaFileType;

    move-result-object v5

    .line 415
    .local v5, "mediaFileType":Landroid/media/MediaFile$MediaFileType;
    if-eqz v5, :cond_1

    .line 416
    iget-object v6, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->this$0:Lcom/lge/media/MediaScannerEx;

    invoke-virtual {v6}, Lcom/lge/media/MediaScannerEx;->isDrmEnabled()Z

    move-result v6

    if-eqz v6, :cond_1

    iget v6, v5, Landroid/media/MediaFile$MediaFileType;->fileType:I

    invoke-static {v6}, Landroid/media/MediaFile;->isDrmFileType(I)Z

    move-result v6

    if-eqz v6, :cond_1

    .line 417
    iput v8, p0, Lcom/lge/media/MediaScannerEx$MyMediaScannerClientEx;->mProtectedType:I

    goto/16 :goto_0

    .line 441
    .end local v5    # "mediaFileType":Landroid/media/MediaFile$MediaFileType;
    :cond_b
    const-string v6, "is_hifi"

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    goto/16 :goto_1

    .line 450
    :cond_c
    const-string v6, "is_lock"

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    goto/16 :goto_2
.end method
