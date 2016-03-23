.class public Landroid/media/MediaHTTPConnectionEx;
.super Landroid/media/MediaHTTPConnection;
.source "MediaHTTPConnectionEx.java"

# interfaces
.implements Landroid/media/IMediaHTTPConnectionEx;


# static fields
.field private static final HTTP_REQ_RANGE_NOT_SATISFIABLE:I = 0x1a0

.field private static final TAG:Ljava/lang/String; = "MediaHTTPConnectionEx"


# instance fields
.field private endByte:J

.field private endTime:J

.field private mConnectTimeout:I

.field private mContentSize:J

.field private mContentType:Ljava/lang/String;

.field private mIsDisconnectAtPause:Z

.field private mIsHttpByteRangeSeek:Z

.field private mIsHttpDlnaPlayback:Z

.field private mIsHttpTimeSeek:Z

.field private mRangeRequested:Z

.field private mReadTimeout:I

.field private mResCode:I

.field private mResHeader:Ljava/lang/String;

.field private mResHeaderFields:Ljava/lang/StringBuilder;

.field private mServerSupportRangeRequest:Z

.field private mSetRangeLastbytePos:Z

.field private mTimeSeekValue:J

.field private rangeRequestLastByte:J

.field private startByte:J

.field private startTime:J

.field private totalByte:J

.field private totalTime:J


# direct methods
.method public constructor <init>()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    const/4 v1, 0x0

    const-wide/16 v2, -0x1

    .line 68
    invoke-direct {p0}, Landroid/media/MediaHTTPConnection;-><init>()V

    .line 37
    iput-boolean v1, p0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpTimeSeek:Z

    .line 38
    iput-boolean v1, p0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpByteRangeSeek:Z

    .line 39
    iput-boolean v1, p0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpDlnaPlayback:Z

    .line 40
    iput-boolean v4, p0, Landroid/media/MediaHTTPConnectionEx;->mIsDisconnectAtPause:Z

    .line 41
    iput-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->mTimeSeekValue:J

    .line 42
    iput-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->mContentSize:J

    .line 43
    iput-object v5, p0, Landroid/media/MediaHTTPConnectionEx;->mResHeader:Ljava/lang/String;

    .line 44
    iput-boolean v1, p0, Landroid/media/MediaHTTPConnectionEx;->mRangeRequested:Z

    .line 45
    iput-boolean v1, p0, Landroid/media/MediaHTTPConnectionEx;->mSetRangeLastbytePos:Z

    .line 46
    const-string v0, "application/octet-stream"

    iput-object v0, p0, Landroid/media/MediaHTTPConnectionEx;->mContentType:Ljava/lang/String;

    .line 47
    const/4 v0, -0x1

    iput v0, p0, Landroid/media/MediaHTTPConnectionEx;->mResCode:I

    .line 48
    iput v1, p0, Landroid/media/MediaHTTPConnectionEx;->mConnectTimeout:I

    .line 49
    iput v1, p0, Landroid/media/MediaHTTPConnectionEx;->mReadTimeout:I

    .line 50
    iput-object v5, p0, Landroid/media/MediaHTTPConnectionEx;->mResHeaderFields:Ljava/lang/StringBuilder;

    .line 53
    iput-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 54
    iput-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    .line 55
    iput-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    .line 56
    iput-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    .line 57
    iput-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    .line 58
    iput-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    .line 59
    iput-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->rangeRequestLastByte:J

    .line 62
    iput-boolean v4, p0, Landroid/media/MediaHTTPConnectionEx;->mServerSupportRangeRequest:Z

    .line 69
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iput-object v0, p0, Landroid/media/MediaHTTPConnectionEx;->mResHeaderFields:Ljava/lang/StringBuilder;

    .line 70
    const-string v0, "MediaHTTPConnectionEx"

    const-string v1, "MediaHTTPConnectionEx contructor"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 71
    return-void
.end method

.method private parseByteRangeHeader(Ljava/lang/String;)Z
    .locals 1
    .param p1, "header"    # Ljava/lang/String;

    .prologue
    .line 835
    const/4 v0, 0x1

    return v0
.end method

.method private parseContentFeaturesHeader(Ljava/lang/String;)Z
    .locals 1
    .param p1, "header"    # Ljava/lang/String;

    .prologue
    .line 831
    const/4 v0, 0x1

    return v0
.end method

.method private parseTimeSeekRangeHeader(Ljava/lang/String;)Z
    .locals 36
    .param p1, "header"    # Ljava/lang/String;

    .prologue
    .line 491
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] header:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 492
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 493
    if-nez p1, :cond_0

    .line 494
    const/16 v32, 0x0

    .line 827
    :goto_0
    return v32

    .line 496
    :cond_0
    const/16 v32, 0x3d

    move-object/from16 v0, p1

    move/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v10

    .line 497
    .local v10, "equal_position":I
    const/16 v32, -0x1

    move/from16 v0, v32

    if-ne v10, v0, :cond_1

    .line 498
    const/16 v32, 0x0

    goto :goto_0

    .line 500
    :cond_1
    const-string/jumbo v32, "npt"

    move-object/from16 v0, p1

    move-object/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v26

    .line 501
    .local v26, "npt_position":I
    const/16 v32, -0x1

    move/from16 v0, v26

    move/from16 v1, v32

    if-ne v0, v1, :cond_2

    .line 502
    const/16 v32, 0x0

    goto :goto_0

    .line 504
    :cond_2
    const/16 v32, 0x2f

    add-int/lit8 v33, v26, 0x1

    move-object/from16 v0, p1

    move/from16 v1, v32

    move/from16 v2, v33

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v29

    .line 505
    .local v29, "slash_position":I
    const/16 v32, -0x1

    move/from16 v0, v29

    move/from16 v1, v32

    if-ne v0, v1, :cond_3

    .line 506
    const/16 v32, 0x0

    goto :goto_0

    .line 510
    :cond_3
    add-int/lit8 v32, v10, 0x1

    move-object/from16 v0, p1

    move/from16 v1, v32

    move/from16 v2, v29

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v27

    .line 512
    .local v27, "npt_range_resp_spec":Ljava/lang/String;
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] npt_range_resp_spec:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move-object/from16 v1, v27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 514
    const/16 v32, 0x2d

    move-object/from16 v0, v27

    move/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v22

    .line 515
    .local v22, "minus_position":I
    const/16 v32, -0x1

    move/from16 v0, v22

    move/from16 v1, v32

    if-eq v0, v1, :cond_d

    .line 517
    const/16 v32, 0x0

    move-object/from16 v0, v27

    move/from16 v1, v32

    move/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v14

    .line 518
    .local v14, "first_npt_pos":Ljava/lang/String;
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] first_npt_pos:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 519
    const/16 v32, 0x3a

    move-object/from16 v0, v27

    move/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v7

    .line 520
    .local v7, "colon_position":I
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] colon_position:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 521
    const/16 v32, -0x1

    move/from16 v0, v32

    if-eq v7, v0, :cond_5

    .line 525
    const/16 v32, 0x0

    move-object/from16 v0, v27

    move/from16 v1, v32

    invoke-virtual {v0, v1, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v12

    .line 528
    .local v12, "first_npt_hh_pos":Ljava/lang/String;
    :try_start_0
    invoke-static {v12}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v16

    .line 533
    .local v16, "hourTime":I
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] hourTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 535
    const/16 v32, 0x3a

    add-int/lit8 v33, v7, 0x1

    move-object/from16 v0, v27

    move/from16 v1, v32

    move/from16 v2, v33

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v8

    .line 536
    .local v8, "colon_position1":I
    const/16 v32, -0x1

    move/from16 v0, v32

    if-eq v8, v0, :cond_4

    .line 537
    add-int/lit8 v32, v7, 0x1

    move-object/from16 v0, v27

    move/from16 v1, v32

    invoke-virtual {v0, v1, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v13

    .line 540
    .local v13, "first_npt_mm_pos":Ljava/lang/String;
    :try_start_1
    invoke-static {v13}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v23

    .line 545
    .local v23, "mmTime":I
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] mmTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 549
    add-int/lit8 v32, v8, 0x1

    move-object/from16 v0, v27

    move/from16 v1, v32

    move/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v15

    .line 552
    .local v15, "first_npt_sec_pos":Ljava/lang/String;
    :try_start_2
    invoke-static {v15}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    :try_end_2
    .catch Ljava/lang/NumberFormatException; {:try_start_2 .. :try_end_2} :catch_2

    move-result v28

    .line 557
    .local v28, "secTime":F
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] secTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move/from16 v1, v28

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 558
    move/from16 v0, v16

    mul-int/lit16 v0, v0, 0xe10

    move/from16 v32, v0

    mul-int/lit8 v33, v23, 0x3c

    add-int v32, v32, v33

    const v33, 0xf4240

    mul-int v32, v32, v33

    move/from16 v0, v32

    int-to-long v0, v0

    move-wide/from16 v32, v0

    const v34, 0x49742400    # 1000000.0f

    mul-float v34, v34, v28

    move/from16 v0, v34

    float-to-long v0, v0

    move-wide/from16 v34, v0

    add-long v32, v32, v34

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 559
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] startTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 584
    .end local v8    # "colon_position1":I
    .end local v12    # "first_npt_hh_pos":Ljava/lang/String;
    .end local v13    # "first_npt_mm_pos":Ljava/lang/String;
    .end local v15    # "first_npt_sec_pos":Ljava/lang/String;
    .end local v16    # "hourTime":I
    .end local v23    # "mmTime":I
    .end local v28    # "secTime":F
    :goto_1
    add-int/lit8 v32, v22, 0x1

    move-object/from16 v0, v27

    move/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v20

    .line 585
    .local v20, "last_npt_pos":Ljava/lang/String;
    const/16 v32, 0x3a

    add-int/lit8 v33, v22, 0x1

    move-object/from16 v0, v27

    move/from16 v1, v32

    move/from16 v2, v33

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v7

    .line 586
    const/16 v32, -0x1

    move/from16 v0, v32

    if-eq v7, v0, :cond_7

    .line 590
    add-int/lit8 v32, v22, 0x1

    move-object/from16 v0, v27

    move/from16 v1, v32

    invoke-virtual {v0, v1, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v18

    .line 593
    .local v18, "last_npt_hh_pos":Ljava/lang/String;
    :try_start_3
    invoke-static/range {v18 .. v18}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_3
    .catch Ljava/lang/NumberFormatException; {:try_start_3 .. :try_end_3} :catch_4

    move-result v16

    .line 598
    .restart local v16    # "hourTime":I
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] hourTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 599
    const/16 v32, 0x3a

    add-int/lit8 v33, v7, 0x1

    move-object/from16 v0, v27

    move/from16 v1, v32

    move/from16 v2, v33

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v8

    .line 600
    .restart local v8    # "colon_position1":I
    const/16 v32, -0x1

    move/from16 v0, v32

    if-eq v8, v0, :cond_6

    .line 601
    add-int/lit8 v32, v7, 0x1

    move-object/from16 v0, v27

    move/from16 v1, v32

    invoke-virtual {v0, v1, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v19

    .line 604
    .local v19, "last_npt_mm_pos":Ljava/lang/String;
    :try_start_4
    invoke-static/range {v19 .. v19}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_4
    .catch Ljava/lang/NumberFormatException; {:try_start_4 .. :try_end_4} :catch_5

    move-result v23

    .line 609
    .restart local v23    # "mmTime":I
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] mmTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 613
    add-int/lit8 v32, v8, 0x1

    move-object/from16 v0, v27

    move/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v21

    .line 616
    .local v21, "last_npt_sec_pos":Ljava/lang/String;
    :try_start_5
    invoke-static/range {v21 .. v21}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    :try_end_5
    .catch Ljava/lang/NumberFormatException; {:try_start_5 .. :try_end_5} :catch_6

    move-result v28

    .line 621
    .restart local v28    # "secTime":F
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] secTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move/from16 v1, v28

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 622
    move/from16 v0, v16

    mul-int/lit16 v0, v0, 0xe10

    move/from16 v32, v0

    mul-int/lit8 v33, v23, 0x3c

    add-int v32, v32, v33

    const v33, 0xf4240

    mul-int v32, v32, v33

    move/from16 v0, v32

    int-to-long v0, v0

    move-wide/from16 v32, v0

    const v34, 0x49742400    # 1000000.0f

    mul-float v34, v34, v28

    move/from16 v0, v34

    float-to-long v0, v0

    move-wide/from16 v34, v0

    add-long v32, v32, v34

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    .line 623
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] endTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 651
    .end local v8    # "colon_position1":I
    .end local v16    # "hourTime":I
    .end local v18    # "last_npt_hh_pos":Ljava/lang/String;
    .end local v19    # "last_npt_mm_pos":Ljava/lang/String;
    .end local v21    # "last_npt_sec_pos":Ljava/lang/String;
    .end local v23    # "mmTime":I
    .end local v28    # "secTime":F
    :goto_2
    const/16 v32, 0x20

    add-int/lit8 v33, v29, 0x1

    move-object/from16 v0, p1

    move/from16 v1, v32

    move/from16 v2, v33

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v30

    .line 652
    .local v30, "space_position":I
    const/16 v25, 0x0

    .line 653
    .local v25, "npt_instant_resp_spec":Ljava/lang/String;
    const/16 v32, -0x1

    move/from16 v0, v30

    move/from16 v1, v32

    if-ne v0, v1, :cond_9

    .line 654
    add-int/lit8 v32, v29, 0x1

    move-object/from16 v0, p1

    move/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v25

    .line 657
    :goto_3
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] npt_instant_resp_spec:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 659
    const/16 v32, 0x2a

    move-object/from16 v0, v25

    move/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v32

    const/16 v33, -0x1

    move/from16 v0, v32

    move/from16 v1, v33

    if-eq v0, v1, :cond_a

    .line 660
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    .line 734
    :goto_4
    const-string v32, "bytes"

    move-object/from16 v0, p1

    move-object/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v6

    .line 735
    .local v6, "bytes_position":I
    const/16 v32, -0x1

    move/from16 v0, v32

    if-ne v6, v0, :cond_e

    .line 736
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] startTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 737
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] endTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 738
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] totalTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 739
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] startByte:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 740
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] endByte:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 741
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] totalByte:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 742
    const/16 v32, 0x1

    goto/16 :goto_0

    .line 529
    .end local v6    # "bytes_position":I
    .end local v20    # "last_npt_pos":Ljava/lang/String;
    .end local v25    # "npt_instant_resp_spec":Ljava/lang/String;
    .end local v30    # "space_position":I
    .restart local v12    # "first_npt_hh_pos":Ljava/lang/String;
    :catch_0
    move-exception v9

    .line 530
    .local v9, "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 531
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 541
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .restart local v8    # "colon_position1":I
    .restart local v13    # "first_npt_mm_pos":Ljava/lang/String;
    .restart local v16    # "hourTime":I
    :catch_1
    move-exception v9

    .line 542
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 543
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 553
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .restart local v15    # "first_npt_sec_pos":Ljava/lang/String;
    .restart local v23    # "mmTime":I
    :catch_2
    move-exception v9

    .line 554
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 555
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 567
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .end local v13    # "first_npt_mm_pos":Ljava/lang/String;
    .end local v15    # "first_npt_sec_pos":Ljava/lang/String;
    .end local v23    # "mmTime":I
    :cond_4
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 568
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 575
    .end local v8    # "colon_position1":I
    .end local v12    # "first_npt_hh_pos":Ljava/lang/String;
    .end local v16    # "hourTime":I
    :cond_5
    :try_start_6
    invoke-static {v14}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    :try_end_6
    .catch Ljava/lang/NumberFormatException; {:try_start_6 .. :try_end_6} :catch_3

    move-result v31

    .line 580
    .local v31, "time":F
    const v32, 0x49742400    # 1000000.0f

    mul-float v32, v32, v31

    move/from16 v0, v32

    float-to-long v0, v0

    move-wide/from16 v32, v0

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 581
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] startTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .line 576
    .end local v31    # "time":F
    :catch_3
    move-exception v9

    .line 577
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 578
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 594
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .restart local v18    # "last_npt_hh_pos":Ljava/lang/String;
    .restart local v20    # "last_npt_pos":Ljava/lang/String;
    :catch_4
    move-exception v9

    .line 595
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 596
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 605
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .restart local v8    # "colon_position1":I
    .restart local v16    # "hourTime":I
    .restart local v19    # "last_npt_mm_pos":Ljava/lang/String;
    :catch_5
    move-exception v9

    .line 606
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 607
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 617
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .restart local v21    # "last_npt_sec_pos":Ljava/lang/String;
    .restart local v23    # "mmTime":I
    :catch_6
    move-exception v9

    .line 618
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 619
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 631
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .end local v19    # "last_npt_mm_pos":Ljava/lang/String;
    .end local v21    # "last_npt_sec_pos":Ljava/lang/String;
    .end local v23    # "mmTime":I
    :cond_6
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 632
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 636
    .end local v8    # "colon_position1":I
    .end local v16    # "hourTime":I
    .end local v18    # "last_npt_hh_pos":Ljava/lang/String;
    :cond_7
    const/high16 v31, -0x40800000    # -1.0f

    .line 639
    .restart local v31    # "time":F
    :try_start_7
    invoke-static/range {v20 .. v20}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    :try_end_7
    .catch Ljava/lang/NumberFormatException; {:try_start_7 .. :try_end_7} :catch_7

    move-result v31

    .line 645
    :goto_5
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v32, v0

    const-wide/16 v34, 0x0

    cmp-long v32, v32, v34

    if-ltz v32, :cond_8

    .line 646
    const v32, 0x49742400    # 1000000.0f

    mul-float v32, v32, v31

    move/from16 v0, v32

    float-to-long v0, v0

    move-wide/from16 v32, v0

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    .line 647
    :cond_8
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] endTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_2

    .line 640
    :catch_7
    move-exception v9

    .line 642
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    goto :goto_5

    .line 656
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .end local v31    # "time":F
    .restart local v25    # "npt_instant_resp_spec":Ljava/lang/String;
    .restart local v30    # "space_position":I
    :cond_9
    add-int/lit8 v32, v29, 0x1

    move-object/from16 v0, p1

    move/from16 v1, v32

    move/from16 v2, v30

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v25

    goto/16 :goto_3

    .line 663
    :cond_a
    const/16 v32, 0x3a

    move-object/from16 v0, v25

    move/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v7

    .line 664
    const/16 v32, -0x1

    move/from16 v0, v32

    if-eq v7, v0, :cond_c

    .line 668
    const/16 v32, 0x0

    move-object/from16 v0, v25

    move/from16 v1, v32

    invoke-virtual {v0, v1, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v24

    .line 671
    .local v24, "npt_hh_pos":Ljava/lang/String;
    :try_start_8
    invoke-static/range {v24 .. v24}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_8
    .catch Ljava/lang/NumberFormatException; {:try_start_8 .. :try_end_8} :catch_8

    move-result v16

    .line 676
    .restart local v16    # "hourTime":I
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] hourTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 677
    const/16 v32, 0x3a

    add-int/lit8 v33, v7, 0x1

    move-object/from16 v0, v25

    move/from16 v1, v32

    move/from16 v2, v33

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v8

    .line 678
    .restart local v8    # "colon_position1":I
    const/16 v32, -0x1

    move/from16 v0, v32

    if-eq v8, v0, :cond_b

    .line 679
    add-int/lit8 v32, v7, 0x1

    move-object/from16 v0, v25

    move/from16 v1, v32

    invoke-virtual {v0, v1, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v19

    .line 682
    .restart local v19    # "last_npt_mm_pos":Ljava/lang/String;
    :try_start_9
    invoke-static/range {v19 .. v19}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_9
    .catch Ljava/lang/NumberFormatException; {:try_start_9 .. :try_end_9} :catch_9

    move-result v23

    .line 687
    .restart local v23    # "mmTime":I
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] mmTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 691
    add-int/lit8 v32, v8, 0x1

    move-object/from16 v0, v25

    move/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v21

    .line 694
    .restart local v21    # "last_npt_sec_pos":Ljava/lang/String;
    :try_start_a
    invoke-static/range {v21 .. v21}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    :try_end_a
    .catch Ljava/lang/NumberFormatException; {:try_start_a .. :try_end_a} :catch_a

    move-result v28

    .line 699
    .restart local v28    # "secTime":F
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] secTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    move/from16 v1, v28

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 700
    move/from16 v0, v16

    mul-int/lit16 v0, v0, 0xe10

    move/from16 v32, v0

    mul-int/lit8 v33, v23, 0x3c

    add-int v32, v32, v33

    const v33, 0xf4240

    mul-int v32, v32, v33

    move/from16 v0, v32

    int-to-long v0, v0

    move-wide/from16 v32, v0

    const v34, 0x49742400    # 1000000.0f

    mul-float v34, v34, v28

    move/from16 v0, v34

    float-to-long v0, v0

    move-wide/from16 v34, v0

    add-long v32, v32, v34

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    .line 701
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] endTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_4

    .line 672
    .end local v8    # "colon_position1":I
    .end local v16    # "hourTime":I
    .end local v19    # "last_npt_mm_pos":Ljava/lang/String;
    .end local v21    # "last_npt_sec_pos":Ljava/lang/String;
    .end local v23    # "mmTime":I
    .end local v28    # "secTime":F
    :catch_8
    move-exception v9

    .line 673
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 674
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 683
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .restart local v8    # "colon_position1":I
    .restart local v16    # "hourTime":I
    .restart local v19    # "last_npt_mm_pos":Ljava/lang/String;
    :catch_9
    move-exception v9

    .line 684
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 685
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 695
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .restart local v21    # "last_npt_sec_pos":Ljava/lang/String;
    .restart local v23    # "mmTime":I
    :catch_a
    move-exception v9

    .line 696
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 697
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 709
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .end local v19    # "last_npt_mm_pos":Ljava/lang/String;
    .end local v21    # "last_npt_sec_pos":Ljava/lang/String;
    .end local v23    # "mmTime":I
    :cond_b
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 710
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 717
    .end local v8    # "colon_position1":I
    .end local v16    # "hourTime":I
    .end local v24    # "npt_hh_pos":Ljava/lang/String;
    :cond_c
    :try_start_b
    invoke-static/range {v25 .. v25}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    :try_end_b
    .catch Ljava/lang/NumberFormatException; {:try_start_b .. :try_end_b} :catch_b

    move-result v31

    .line 722
    .restart local v31    # "time":F
    const v32, 0x49742400    # 1000000.0f

    mul-float v32, v32, v31

    move/from16 v0, v32

    float-to-long v0, v0

    move-wide/from16 v32, v0

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    .line 723
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] endTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_4

    .line 718
    .end local v31    # "time":F
    :catch_b
    move-exception v9

    .line 719
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    .line 720
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 730
    .end local v7    # "colon_position":I
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .end local v14    # "first_npt_pos":Ljava/lang/String;
    .end local v20    # "last_npt_pos":Ljava/lang/String;
    .end local v25    # "npt_instant_resp_spec":Ljava/lang/String;
    .end local v30    # "space_position":I
    :cond_d
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 745
    .restart local v6    # "bytes_position":I
    .restart local v7    # "colon_position":I
    .restart local v14    # "first_npt_pos":Ljava/lang/String;
    .restart local v20    # "last_npt_pos":Ljava/lang/String;
    .restart local v25    # "npt_instant_resp_spec":Ljava/lang/String;
    .restart local v30    # "space_position":I
    :cond_e
    const/16 v32, 0x3d

    add-int/lit8 v33, v6, 0x1

    move-object/from16 v0, p1

    move/from16 v1, v32

    move/from16 v2, v33

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v10

    .line 746
    const/16 v32, -0x1

    move/from16 v0, v32

    if-ne v10, v0, :cond_f

    .line 747
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 749
    :cond_f
    const/16 v32, 0x2f

    add-int/lit8 v33, v10, 0x1

    move-object/from16 v0, p1

    move/from16 v1, v32

    move/from16 v2, v33

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v29

    .line 750
    const/16 v32, -0x1

    move/from16 v0, v29

    move/from16 v1, v32

    if-ne v0, v1, :cond_10

    .line 751
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 755
    :cond_10
    add-int/lit8 v32, v10, 0x1

    move-object/from16 v0, p1

    move/from16 v1, v32

    move/from16 v2, v29

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    .line 756
    .local v5, "byte_range_resp_spec":Ljava/lang/String;
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] byte_range_resp_spec:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, v33

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 760
    const/16 v32, 0x2d

    move/from16 v0, v32

    invoke-virtual {v5, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v22

    .line 761
    const/16 v32, -0x1

    move/from16 v0, v22

    move/from16 v1, v32

    if-eq v0, v1, :cond_12

    .line 763
    const/16 v32, 0x0

    move/from16 v0, v32

    move/from16 v1, v22

    invoke-virtual {v5, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v11

    .line 766
    .local v11, "first_byte_pos":Ljava/lang/String;
    :try_start_c
    invoke-static {v11}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v32

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J
    :try_end_c
    .catch Ljava/lang/NumberFormatException; {:try_start_c .. :try_end_c} :catch_c

    .line 773
    add-int/lit8 v32, v22, 0x1

    move/from16 v0, v32

    invoke-virtual {v5, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v17

    .line 776
    .local v17, "last_byte_pos":Ljava/lang/String;
    :try_start_d
    invoke-static/range {v17 .. v17}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v32

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J
    :try_end_d
    .catch Ljava/lang/NumberFormatException; {:try_start_d .. :try_end_d} :catch_d

    .line 782
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v32, v0

    const-wide/16 v34, 0x0

    cmp-long v32, v32, v34

    if-ltz v32, :cond_11

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v32, v0

    const-wide/16 v34, 0x0

    cmp-long v32, v32, v34

    if-ltz v32, :cond_11

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v32, v0

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v34, v0

    cmp-long v32, v32, v34

    if-lez v32, :cond_12

    .line 784
    :cond_11
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    .line 785
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 767
    .end local v17    # "last_byte_pos":Ljava/lang/String;
    :catch_c
    move-exception v9

    .line 768
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    .line 769
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 777
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .restart local v17    # "last_byte_pos":Ljava/lang/String;
    :catch_d
    move-exception v9

    .line 778
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    .line 779
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 792
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    .end local v11    # "first_byte_pos":Ljava/lang/String;
    .end local v17    # "last_byte_pos":Ljava/lang/String;
    :cond_12
    add-int/lit8 v32, v29, 0x1

    move-object/from16 v0, p1

    move/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    .line 795
    .local v4, "byte_instant_resp_spec":Ljava/lang/String;
    const/16 v32, 0x2a

    move/from16 v0, v32

    invoke-virtual {v4, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v32

    const/16 v33, -0x1

    move/from16 v0, v32

    move/from16 v1, v33

    if-eq v0, v1, :cond_13

    .line 796
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    .line 797
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] startTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 798
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] endTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 799
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] totalTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 800
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] startByte:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 801
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] endByte:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 802
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] totalByte:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 803
    const/16 v32, 0x1

    goto/16 :goto_0

    .line 807
    :cond_13
    :try_start_e
    invoke-static {v4}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v32

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J
    :try_end_e
    .catch Ljava/lang/NumberFormatException; {:try_start_e .. :try_end_e} :catch_e

    .line 816
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v32, v0

    const-wide/16 v34, 0x0

    cmp-long v32, v32, v34

    if-ltz v32, :cond_14

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v32, v0

    const-wide/16 v34, 0x0

    cmp-long v32, v32, v34

    if-ltz v32, :cond_14

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v32, v0

    const-wide/16 v34, 0x0

    cmp-long v32, v32, v34

    if-ltz v32, :cond_14

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v32, v0

    const-wide/16 v34, 0x1

    sub-long v32, v32, v34

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v34, v0

    cmp-long v32, v32, v34

    if-gez v32, :cond_15

    .line 818
    :cond_14
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    .line 819
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 808
    :catch_e
    move-exception v9

    .line 809
    .restart local v9    # "e":Ljava/lang/NumberFormatException;
    const-wide/16 v32, -0x1

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v0, v32

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    .line 810
    const/16 v32, 0x0

    goto/16 :goto_0

    .line 821
    .end local v9    # "e":Ljava/lang/NumberFormatException;
    :cond_15
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] startTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 822
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] endTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 823
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] totalTime:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->totalTime:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 824
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] startByte:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 825
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] endByte:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->endByte:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 826
    const-string v32, "MediaHTTPConnectionEx"

    new-instance v33, Ljava/lang/StringBuilder;

    invoke-direct/range {v33 .. v33}, Ljava/lang/StringBuilder;-><init>()V

    const-string v34, "[parseTimeSeekRangeHeader] totalByte:"

    invoke-virtual/range {v33 .. v34}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v33

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v34, v0

    invoke-virtual/range {v33 .. v35}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v33

    invoke-virtual/range {v33 .. v33}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v33

    invoke-static/range {v32 .. v33}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 827
    const/16 v32, 0x1

    goto/16 :goto_0
.end method


# virtual methods
.method public connect(Ljava/lang/String;Ljava/lang/String;)Landroid/os/IBinder;
    .locals 2
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "headers"    # Ljava/lang/String;

    .prologue
    .line 81
    const-string v0, "MediaHTTPConnectionEx"

    const-string v1, "connect"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 82
    invoke-super {p0, p1, p2}, Landroid/media/MediaHTTPConnection;->connect(Ljava/lang/String;Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    return-object v0
.end method

.method public disconnect()V
    .locals 2

    .prologue
    .line 87
    const-string v0, "MediaHTTPConnectionEx"

    const-string v1, "disconnecting"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 88
    invoke-super {p0}, Landroid/media/MediaHTTPConnection;->disconnect()V

    .line 89
    const-string v0, "MediaHTTPConnectionEx"

    const-string v1, "disconnected"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 90
    return-void
.end method

.method public getCurrentOffset()J
    .locals 4

    .prologue
    .line 470
    const-string v0, "MediaHTTPConnectionEx"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[getCurrentOffset] startByte="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 472
    iget-wide v0, p0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    const-wide/16 v2, -0x1

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 473
    iget-wide v0, p0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    .line 475
    :goto_0
    return-wide v0

    :cond_0
    const-wide/16 v0, 0x0

    goto :goto_0
.end method

.method public getMIMEType()Ljava/lang/String;
    .locals 3

    .prologue
    .line 106
    const-string v0, "MediaHTTPConnectionEx"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[getMIMEType] mContentType:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Landroid/media/MediaHTTPConnectionEx;->mContentType:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 107
    invoke-super {p0}, Landroid/media/MediaHTTPConnection;->getMIMEType()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getRangeLastByte()J
    .locals 2

    .prologue
    .line 442
    iget-wide v0, p0, Landroid/media/MediaHTTPConnectionEx;->rangeRequestLastByte:J

    return-wide v0
.end method

.method public getResponseCode()I
    .locals 1

    .prologue
    .line 447
    iget v0, p0, Landroid/media/MediaHTTPConnectionEx;->mResCode:I

    return v0
.end method

.method public getResponseHeader()Ljava/lang/String;
    .locals 1

    .prologue
    .line 431
    iget-object v0, p0, Landroid/media/MediaHTTPConnectionEx;->mResHeader:Ljava/lang/String;

    return-object v0
.end method

.method public getResponseHeaderFields()Ljava/lang/String;
    .locals 1

    .prologue
    .line 462
    iget-object v0, p0, Landroid/media/MediaHTTPConnectionEx;->mResHeaderFields:Ljava/lang/StringBuilder;

    if-eqz v0, :cond_0

    .line 463
    iget-object v0, p0, Landroid/media/MediaHTTPConnectionEx;->mResHeaderFields:Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 465
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getUri()Ljava/lang/String;
    .locals 2

    .prologue
    .line 112
    const-string v0, "MediaHTTPConnectionEx"

    const-string v1, "getUri"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 113
    invoke-super {p0}, Landroid/media/MediaHTTPConnection;->getUri()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public isSupportRangeRequest()Z
    .locals 1

    .prologue
    .line 437
    iget-boolean v0, p0, Landroid/media/MediaHTTPConnectionEx;->mServerSupportRangeRequest:Z

    return v0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 1
    .param p1, "code"    # I
    .param p2, "data"    # Landroid/os/Parcel;
    .param p3, "reply"    # Landroid/os/Parcel;
    .param p4, "flags"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    .line 75
    invoke-super {p0, p1, p2, p3, p4}, Landroid/media/MediaHTTPConnection;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    invoke-static {p0, p1, p2, p3, p4}, Landroid/media/IMediaHTTPConnectionEx$Stub;->onTransact(Landroid/media/IMediaHTTPConnectionEx;ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result v0

    goto :goto_0
.end method

.method public readAt(JI)I
    .locals 5
    .param p1, "offset"    # J
    .param p3, "size"    # I

    .prologue
    const-wide/16 v2, -0x1

    .line 95
    iget-boolean v0, p0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpTimeSeek:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 96
    cmp-long v0, p1, v2

    if-nez v0, :cond_0

    .line 97
    const-wide/16 p1, 0x0

    .line 98
    iput-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->mCurrentOffset:J

    .line 101
    :cond_0
    invoke-super {p0, p1, p2, p3}, Landroid/media/MediaHTTPConnection;->readAt(JI)I

    move-result v0

    return v0
.end method

.method protected seekTo(J)V
    .locals 33
    .param p1, "offset"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 139
    const-string v25, "MediaHTTPConnectionEx"

    new-instance v26, Ljava/lang/StringBuilder;

    invoke-direct/range {v26 .. v26}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "[seekToEx] offset:"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    move-object/from16 v0, v26

    move-wide/from16 v1, p1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v26

    const-string v27, "/mCurrentOffset:"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->mCurrentOffset:J

    move-wide/from16 v28, v0

    move-object/from16 v0, v26

    move-wide/from16 v1, v28

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v26

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 145
    invoke-virtual/range {p0 .. p0}, Landroid/media/MediaHTTPConnectionEx;->teardownConnection()V

    .line 147
    const/16 v19, 0x0

    .line 149
    .local v19, "redirectCount":I
    :try_start_0
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mURL:Ljava/net/URL;

    move-object/from16 v24, v0

    .line 151
    .local v24, "url":Ljava/net/URL;
    const/16 v25, 0x0

    move/from16 v0, v25

    move-object/from16 v1, p0

    iput-boolean v0, v1, Landroid/media/MediaHTTPConnectionEx;->mRangeRequested:Z

    .line 153
    :cond_0
    :goto_0
    const/16 v25, -0x1

    move/from16 v0, v25

    move-object/from16 v1, p0

    iput v0, v1, Landroid/media/MediaHTTPConnectionEx;->mResCode:I

    .line 154
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mResHeaderFields:Ljava/lang/StringBuilder;

    move-object/from16 v25, v0

    const/16 v26, 0x0

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->setLength(I)V

    .line 155
    invoke-virtual/range {v24 .. v24}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v25

    check-cast v25, Ljava/net/HttpURLConnection;

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    .line 156
    move-object/from16 v0, p0

    iget v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnectTimeout:I

    move/from16 v25, v0

    if-ltz v25, :cond_1

    .line 157
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    move-object/from16 v0, p0

    iget v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnectTimeout:I

    move/from16 v26, v0

    invoke-virtual/range {v25 .. v26}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 159
    :cond_1
    move-object/from16 v0, p0

    iget v0, v0, Landroid/media/MediaHTTPConnectionEx;->mReadTimeout:I

    move/from16 v25, v0

    if-ltz v25, :cond_2

    .line 160
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    move-object/from16 v0, p0

    iget v0, v0, Landroid/media/MediaHTTPConnectionEx;->mReadTimeout:I

    move/from16 v26, v0

    invoke-virtual/range {v25 .. v26}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 163
    :cond_2
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mAllowCrossDomainRedirect:Z

    move/from16 v26, v0

    invoke-virtual/range {v25 .. v26}, Ljava/net/HttpURLConnection;->setInstanceFollowRedirects(Z)V

    .line 165
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mHeaders:Ljava/util/Map;

    move-object/from16 v25, v0

    if-eqz v25, :cond_6

    .line 166
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mHeaders:Ljava/util/Map;

    move-object/from16 v25, v0

    invoke-interface/range {v25 .. v25}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v25

    invoke-interface/range {v25 .. v25}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v11

    .local v11, "i$":Ljava/util/Iterator;
    :goto_1
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v25

    if-eqz v25, :cond_6

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/util/Map$Entry;

    .line 167
    .local v8, "entry":Ljava/util/Map$Entry;
    invoke-interface {v8}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v25

    check-cast v25, Ljava/lang/String;

    const-string v26, "Range"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v25

    if-eqz v25, :cond_5

    .line 168
    const-wide/16 v26, 0x0

    cmp-long v25, p1, v26

    if-nez v25, :cond_3

    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpTimeSeek:Z

    move/from16 v25, v0

    const/16 v26, 0x1

    move/from16 v0, v25

    move/from16 v1, v26

    if-eq v0, v1, :cond_3

    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpDlnaPlayback:Z

    move/from16 v25, v0

    if-eqz v25, :cond_4

    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpByteRangeSeek:Z

    move/from16 v25, v0

    if-nez v25, :cond_4

    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpTimeSeek:Z

    move/from16 v25, v0

    if-nez v25, :cond_4

    .line 170
    :cond_3
    const-string v25, "MediaHTTPConnectionEx"

    const-string v26, "[seekToEx] remove Range: bytes= 0-"

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 171
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mHeaders:Ljava/util/Map;

    move-object/from16 v26, v0

    invoke-interface {v8}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v25

    check-cast v25, Ljava/lang/String;

    move-object/from16 v0, v26

    move-object/from16 v1, v25

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 388
    .end local v8    # "entry":Ljava/util/Map$Entry;
    .end local v11    # "i$":Ljava/util/Iterator;
    .end local v24    # "url":Ljava/net/URL;
    :catch_0
    move-exception v7

    .line 389
    .local v7, "e":Ljava/io/IOException;
    const-wide/16 v26, -0x1

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    .line 390
    const/16 v25, 0x0

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/MediaHTTPConnectionEx;->mInputStream:Ljava/io/InputStream;

    .line 391
    const/16 v25, 0x0

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    .line 392
    const-wide/16 v26, -0x1

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->mCurrentOffset:J

    .line 394
    throw v7

    .line 175
    .end local v7    # "e":Ljava/io/IOException;
    .restart local v8    # "entry":Ljava/util/Map$Entry;
    .restart local v11    # "i$":Ljava/util/Iterator;
    .restart local v24    # "url":Ljava/net/URL;
    :cond_4
    const/16 v25, 0x1

    :try_start_1
    move/from16 v0, v25

    move-object/from16 v1, p0

    iput-boolean v0, v1, Landroid/media/MediaHTTPConnectionEx;->mRangeRequested:Z

    .line 176
    const-string v25, "MediaHTTPConnectionEx"

    const-string v26, "[seekToEx] include Range: bytes= 0-"

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 179
    :cond_5
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v27, v0

    invoke-interface {v8}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v25

    check-cast v25, Ljava/lang/String;

    invoke-interface {v8}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v26

    check-cast v26, Ljava/lang/String;

    move-object/from16 v0, v27

    move-object/from16 v1, v25

    move-object/from16 v2, v26

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 180
    const-string v26, "MediaHTTPConnectionEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "[seekToEx] HTTP header =>"

    move-object/from16 v0, v25

    move-object/from16 v1, v27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-interface {v8}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v25

    check-cast v25, Ljava/lang/String;

    move-object/from16 v0, v27

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v27, ":"

    move-object/from16 v0, v25

    move-object/from16 v1, v27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-interface {v8}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v25

    check-cast v25, Ljava/lang/String;

    move-object/from16 v0, v27

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    move-object/from16 v0, v26

    move-object/from16 v1, v25

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .line 184
    .end local v8    # "entry":Ljava/util/Map$Entry;
    .end local v11    # "i$":Ljava/util/Iterator;
    :cond_6
    const-wide/16 v26, 0x0

    cmp-long v25, p1, v26

    if-gtz v25, :cond_7

    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpTimeSeek:Z

    move/from16 v25, v0

    const/16 v26, 0x1

    move/from16 v0, v25

    move/from16 v1, v26

    if-ne v0, v1, :cond_8

    .line 185
    :cond_7
    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpTimeSeek:Z

    move/from16 v25, v0

    if-nez v25, :cond_a

    .line 186
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    move-wide/from16 v26, v0

    const-wide/16 v28, 0x0

    cmp-long v25, v26, v28

    if-lez v25, :cond_9

    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mSetRangeLastbytePos:Z

    move/from16 v25, v0

    if-eqz v25, :cond_9

    .line 187
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    const-string v26, "Range"

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "bytes="

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-wide/from16 v1, p1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "-"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    move-wide/from16 v28, v0

    const-wide/16 v30, 0x1

    sub-long v28, v28, v30

    invoke-virtual/range {v27 .. v29}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-virtual/range {v25 .. v27}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 188
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    move-wide/from16 v26, v0

    const-wide/16 v28, 0x1

    sub-long v26, v26, v28

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->rangeRequestLastByte:J

    .line 189
    const/16 v25, 0x1

    move/from16 v0, v25

    move-object/from16 v1, p0

    iput-boolean v0, v1, Landroid/media/MediaHTTPConnectionEx;->mSetRangeLastbytePos:Z

    .line 194
    :goto_2
    const/16 v25, 0x1

    move/from16 v0, v25

    move-object/from16 v1, p0

    iput-boolean v0, v1, Landroid/media/MediaHTTPConnectionEx;->mRangeRequested:Z

    .line 195
    const-string v25, "MediaHTTPConnectionEx"

    new-instance v26, Ljava/lang/StringBuilder;

    invoke-direct/range {v26 .. v26}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "Range: bytes="

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    move-object/from16 v0, v26

    move-wide/from16 v1, p1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v26

    const-string v27, "-"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v26

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 211
    :cond_8
    :goto_3
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    const-string v26, "Accept"

    const-string v27, "audio/mp4, video/mp4, video/3gpp2, video/3gpp, audio/amr, audio/aac, audio/aacPlus, audio/mpeg, audio/aiff, audio/flac, */*"

    invoke-virtual/range {v25 .. v27}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 214
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    invoke-virtual/range {v25 .. v25}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v20

    .line 215
    .local v20, "response":I
    move/from16 v0, v20

    move-object/from16 v1, p0

    iput v0, v1, Landroid/media/MediaHTTPConnectionEx;->mResCode:I

    .line 216
    const-string v25, "MediaHTTPConnectionEx"

    new-instance v26, Ljava/lang/StringBuilder;

    invoke-direct/range {v26 .. v26}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "[response code] STATUS CODE:"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    move-object/from16 v0, v26

    move/from16 v1, v20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v26

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 217
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    invoke-virtual/range {v25 .. v25}, Ljava/net/HttpURLConnection;->getHeaderFields()Ljava/util/Map;

    move-result-object v10

    .line 219
    .local v10, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    invoke-interface {v10}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v25

    invoke-interface/range {v25 .. v25}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v11

    .restart local v11    # "i$":Ljava/util/Iterator;
    :goto_4
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v25

    if-eqz v25, :cond_c

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/util/Map$Entry;

    .line 220
    .local v9, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    const-string v26, "MediaHTTPConnectionEx"

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "[response header] "

    move-object/from16 v0, v25

    move-object/from16 v1, v27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-interface {v9}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v25

    check-cast v25, Ljava/lang/String;

    move-object/from16 v0, v27

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v27, ": "

    move-object/from16 v0, v25

    move-object/from16 v1, v27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-interface {v9}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v27

    move-object/from16 v0, v25

    move-object/from16 v1, v27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    move-object/from16 v0, v26

    move-object/from16 v1, v25

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 221
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mResHeaderFields:Ljava/lang/StringBuilder;

    move-object/from16 v26, v0

    invoke-interface {v9}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v25

    check-cast v25, Ljava/lang/String;

    move-object/from16 v0, v26

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 222
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mResHeaderFields:Ljava/lang/StringBuilder;

    move-object/from16 v25, v0

    const-string v26, ": "

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 223
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mResHeaderFields:Ljava/lang/StringBuilder;

    move-object/from16 v25, v0

    invoke-interface {v9}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v26

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 224
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mResHeaderFields:Ljava/lang/StringBuilder;

    move-object/from16 v25, v0

    const-string v26, "\r\n"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto/16 :goto_4

    .line 192
    .end local v9    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .end local v10    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .end local v11    # "i$":Ljava/util/Iterator;
    .end local v20    # "response":I
    :cond_9
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    const-string v26, "Range"

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "bytes="

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-wide/from16 v1, p1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "-"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-virtual/range {v25 .. v27}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_2

    .line 198
    :cond_a
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->mTimeSeekValue:J

    move-wide/from16 v26, v0

    const-wide/16 v28, 0x0

    cmp-long v25, v26, v28

    if-gez v25, :cond_b

    .line 199
    const-string v25, "MediaHTTPConnectionEx"

    const-string v26, "[seekToEx] No mTimeSeekValue"

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_3

    .line 202
    :cond_b
    new-instance v6, Ljava/text/DecimalFormat;

    const-string v25, "#.###"

    move-object/from16 v0, v25

    invoke-direct {v6, v0}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;)V

    .line 203
    .local v6, "df":Ljava/text/DecimalFormat;
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->mTimeSeekValue:J

    move-wide/from16 v26, v0

    const-wide/32 v28, 0xf4240

    div-long v26, v26, v28

    move-wide/from16 v0, v26

    long-to-float v0, v0

    move/from16 v17, v0

    .line 204
    .local v17, "npt":F
    move/from16 v0, v17

    float-to-double v0, v0

    move-wide/from16 v26, v0

    move-wide/from16 v0, v26

    invoke-virtual {v6, v0, v1}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v25 .. v25}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v17

    .line 205
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    const-string v26, "TimeSeekRange.dlna.org"

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v28, "npt="

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "-"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-virtual/range {v25 .. v27}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 206
    const-string v25, "MediaHTTPConnectionEx"

    new-instance v26, Ljava/lang/StringBuilder;

    invoke-direct/range {v26 .. v26}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "[seekToEx] TimeSeekRange.dlna.org: npt="

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    move-object/from16 v0, v26

    move/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v26

    const-string v27, "-"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v26

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_3

    .line 228
    .end local v6    # "df":Ljava/text/DecimalFormat;
    .end local v17    # "npt":F
    .restart local v10    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .restart local v11    # "i$":Ljava/util/Iterator;
    .restart local v20    # "response":I
    :cond_c
    const/16 v25, 0x1a0

    move/from16 v0, v20

    move/from16 v1, v25

    if-ne v0, v1, :cond_e

    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mRangeRequested:Z

    move/from16 v25, v0

    if-eqz v25, :cond_e

    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mServerSupportRangeRequest:Z

    move/from16 v25, v0

    if-eqz v25, :cond_e

    .line 229
    const-string v25, "MediaHTTPConnectionEx"

    const-string v26, "We requested a content range, but server didn\'t support that. (responded with 416)"

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 230
    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mSetRangeLastbytePos:Z

    move/from16 v25, v0

    if-nez v25, :cond_d

    .line 231
    const/16 v25, 0x1

    move/from16 v0, v25

    move-object/from16 v1, p0

    iput-boolean v0, v1, Landroid/media/MediaHTTPConnectionEx;->mSetRangeLastbytePos:Z

    .line 236
    :goto_5
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mHeaders:Ljava/util/Map;

    move-object/from16 v25, v0

    const-string v26, "Range"

    invoke-interface/range {v25 .. v26}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 237
    const/16 v25, 0x0

    move/from16 v0, v25

    move-object/from16 v1, p0

    iput-boolean v0, v1, Landroid/media/MediaHTTPConnectionEx;->mRangeRequested:Z

    goto/16 :goto_0

    .line 233
    :cond_d
    const/16 v25, 0x0

    move/from16 v0, v25

    move-object/from16 v1, p0

    iput-boolean v0, v1, Landroid/media/MediaHTTPConnectionEx;->mServerSupportRangeRequest:Z

    .line 234
    const/16 v25, 0x0

    move/from16 v0, v25

    move-object/from16 v1, p0

    iput-boolean v0, v1, Landroid/media/MediaHTTPConnectionEx;->mSetRangeLastbytePos:Z

    goto :goto_5

    .line 239
    :cond_e
    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mSetRangeLastbytePos:Z

    move/from16 v25, v0

    if-eqz v25, :cond_f

    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mRangeRequested:Z

    move/from16 v25, v0

    if-nez v25, :cond_f

    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    invoke-virtual/range {v25 .. v25}, Ljava/net/HttpURLConnection;->getContentLength()I

    move-result v25

    if-lez v25, :cond_f

    .line 240
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mHeaders:Ljava/util/Map;

    move-object/from16 v25, v0

    const-string v26, "Range"

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "bytes="

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-wide/from16 v1, p1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "-"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v28, v0

    invoke-virtual/range {v28 .. v28}, Ljava/net/HttpURLConnection;->getContentLength()I

    move-result v28

    add-int/lit8 v28, v28, -0x1

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-interface/range {v25 .. v27}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 241
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    invoke-virtual/range {v25 .. v25}, Ljava/net/HttpURLConnection;->getContentLength()I

    move-result v25

    add-int/lit8 v25, v25, -0x1

    move/from16 v0, v25

    int-to-long v0, v0

    move-wide/from16 v26, v0

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->rangeRequestLastByte:J

    goto/16 :goto_0

    .line 245
    :cond_f
    const/16 v25, 0x12c

    move/from16 v0, v20

    move/from16 v1, v25

    if-eq v0, v1, :cond_13

    const/16 v25, 0x12d

    move/from16 v0, v20

    move/from16 v1, v25

    if-eq v0, v1, :cond_13

    const/16 v25, 0x12e

    move/from16 v0, v20

    move/from16 v1, v25

    if-eq v0, v1, :cond_13

    const/16 v25, 0x12f

    move/from16 v0, v20

    move/from16 v1, v25

    if-eq v0, v1, :cond_13

    const/16 v25, 0x133

    move/from16 v0, v20

    move/from16 v1, v25

    if-eq v0, v1, :cond_13

    .line 250
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    invoke-virtual/range {v25 .. v25}, Ljava/net/HttpURLConnection;->getResponseMessage()Ljava/lang/String;

    move-result-object v25

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/MediaHTTPConnectionEx;->mResHeader:Ljava/lang/String;

    .line 251
    const-string v25, "MediaHTTPConnectionEx"

    new-instance v26, Ljava/lang/StringBuilder;

    invoke-direct/range {v26 .. v26}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "[ResponseMessage]:"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mResHeader:Ljava/lang/String;

    move-object/from16 v27, v0

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v26

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 285
    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mAllowCrossDomainRedirect:Z

    move/from16 v25, v0

    if-eqz v25, :cond_10

    .line 287
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    invoke-virtual/range {v25 .. v25}, Ljava/net/HttpURLConnection;->getURL()Ljava/net/URL;

    move-result-object v25

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/MediaHTTPConnectionEx;->mURL:Ljava/net/URL;

    .line 291
    :cond_10
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mHeaders:Ljava/util/Map;

    move-object/from16 v25, v0

    if-eqz v25, :cond_19

    .line 292
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mHeaders:Ljava/util/Map;

    move-object/from16 v25, v0

    invoke-interface/range {v25 .. v25}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v25

    invoke-interface/range {v25 .. v25}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :cond_11
    :goto_6
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v25

    if-eqz v25, :cond_19

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/util/Map$Entry;

    .line 293
    .restart local v8    # "entry":Ljava/util/Map$Entry;
    invoke-interface {v8}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v25

    check-cast v25, Ljava/lang/String;

    const-string v26, "Range"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v25

    if-eqz v25, :cond_11

    .line 295
    invoke-interface {v8}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v18

    check-cast v18, Ljava/lang/String;

    .line 296
    .local v18, "rangeRequestLastPos":Ljava/lang/String;
    if-eqz v18, :cond_12

    const/16 v25, 0x2d

    move-object/from16 v0, v18

    move/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v25

    if-ltz v25, :cond_12

    .line 297
    const/16 v25, 0x2d

    move-object/from16 v0, v18

    move/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v12

    .line 298
    .local v12, "lastHyphenPos":I
    add-int/lit8 v25, v12, 0x1

    move-object/from16 v0, v18

    move/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v13

    .line 299
    .local v13, "lastPos":Ljava/lang/String;
    if-eqz v13, :cond_12

    invoke-virtual {v13}, Ljava/lang/String;->length()I
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    move-result v25

    if-eqz v25, :cond_12

    .line 302
    :try_start_2
    invoke-static {v13}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v26

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->rangeRequestLastByte:J
    :try_end_2
    .catch Ljava/lang/NumberFormatException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 307
    .end local v12    # "lastHyphenPos":I
    .end local v13    # "lastPos":Ljava/lang/String;
    :cond_12
    :goto_7
    :try_start_3
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mHeaders:Ljava/util/Map;

    move-object/from16 v26, v0

    invoke-interface {v8}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v25

    check-cast v25, Ljava/lang/String;

    move-object/from16 v0, v26

    move-object/from16 v1, v25

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_6

    .line 255
    .end local v8    # "entry":Ljava/util/Map$Entry;
    .end local v18    # "rangeRequestLastPos":Ljava/lang/String;
    :cond_13
    add-int/lit8 v19, v19, 0x1

    .line 256
    const/16 v25, 0x14

    move/from16 v0, v19

    move/from16 v1, v25

    if-le v0, v1, :cond_14

    .line 257
    new-instance v25, Ljava/net/NoRouteToHostException;

    new-instance v26, Ljava/lang/StringBuilder;

    invoke-direct/range {v26 .. v26}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "Too many redirects: "

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    move-object/from16 v0, v26

    move/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v26

    invoke-direct/range {v25 .. v26}, Ljava/net/NoRouteToHostException;-><init>(Ljava/lang/String;)V

    throw v25

    .line 260
    :cond_14
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    invoke-virtual/range {v25 .. v25}, Ljava/net/HttpURLConnection;->getRequestMethod()Ljava/lang/String;

    move-result-object v16

    .line 261
    .local v16, "method":Ljava/lang/String;
    const/16 v25, 0x133

    move/from16 v0, v20

    move/from16 v1, v25

    if-ne v0, v1, :cond_15

    const-string v25, "GET"

    move-object/from16 v0, v16

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v25

    if-nez v25, :cond_15

    const-string v25, "HEAD"

    move-object/from16 v0, v16

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v25

    if-nez v25, :cond_15

    .line 263
    new-instance v25, Ljava/net/NoRouteToHostException;

    const-string v26, "Invalid redirect"

    invoke-direct/range {v25 .. v26}, Ljava/net/NoRouteToHostException;-><init>(Ljava/lang/String;)V

    throw v25

    .line 265
    :cond_15
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    const-string v26, "Location"

    invoke-virtual/range {v25 .. v26}, Ljava/net/HttpURLConnection;->getHeaderField(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    .line 266
    .local v15, "location":Ljava/lang/String;
    if-nez v15, :cond_16

    .line 267
    new-instance v25, Ljava/net/NoRouteToHostException;

    const-string v26, "Invalid redirect"

    invoke-direct/range {v25 .. v26}, Ljava/net/NoRouteToHostException;-><init>(Ljava/lang/String;)V

    throw v25

    .line 269
    :cond_16
    new-instance v24, Ljava/net/URL;

    .end local v24    # "url":Ljava/net/URL;
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mURL:Ljava/net/URL;

    move-object/from16 v25, v0

    move-object/from16 v0, v24

    move-object/from16 v1, v25

    invoke-direct {v0, v1, v15}, Ljava/net/URL;-><init>(Ljava/net/URL;Ljava/lang/String;)V

    .line 270
    .restart local v24    # "url":Ljava/net/URL;
    invoke-virtual/range {v24 .. v24}, Ljava/net/URL;->getProtocol()Ljava/lang/String;

    move-result-object v25

    const-string v26, "https"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v25

    if-nez v25, :cond_17

    invoke-virtual/range {v24 .. v24}, Ljava/net/URL;->getProtocol()Ljava/lang/String;

    move-result-object v25

    const-string v26, "http"

    invoke-virtual/range {v25 .. v26}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v25

    if-nez v25, :cond_17

    .line 272
    new-instance v25, Ljava/net/NoRouteToHostException;

    const-string v26, "Unsupported protocol redirect"

    invoke-direct/range {v25 .. v26}, Ljava/net/NoRouteToHostException;-><init>(Ljava/lang/String;)V

    throw v25

    .line 274
    :cond_17
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mURL:Ljava/net/URL;

    move-object/from16 v25, v0

    invoke-virtual/range {v25 .. v25}, Ljava/net/URL;->getHost()Ljava/lang/String;

    move-result-object v25

    invoke-virtual/range {v24 .. v24}, Ljava/net/URL;->getHost()Ljava/lang/String;

    move-result-object v26

    invoke-virtual/range {v25 .. v26}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    .line 275
    .local v21, "sameHost":Z
    if-nez v21, :cond_18

    .line 276
    new-instance v25, Ljava/net/NoRouteToHostException;

    const-string v26, "Cross-domain redirects are disallowed"

    invoke-direct/range {v25 .. v26}, Ljava/net/NoRouteToHostException;-><init>(Ljava/lang/String;)V

    throw v25

    .line 279
    :cond_18
    const/16 v25, 0x133

    move/from16 v0, v20

    move/from16 v1, v25

    if-eq v0, v1, :cond_0

    .line 281
    move-object/from16 v0, v24

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/MediaHTTPConnectionEx;->mURL:Ljava/net/URL;

    goto/16 :goto_0

    .line 312
    .end local v15    # "location":Ljava/lang/String;
    .end local v16    # "method":Ljava/lang/String;
    .end local v21    # "sameHost":Z
    :cond_19
    const/16 v25, 0xce

    move/from16 v0, v20

    move/from16 v1, v25

    if-ne v0, v1, :cond_1b

    .line 314
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    const-string v26, "Content-Range"

    invoke-virtual/range {v25 .. v26}, Ljava/net/HttpURLConnection;->getHeaderField(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 316
    .local v5, "contentRange":Ljava/lang/String;
    const-wide/16 v26, -0x1

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    .line 317
    if-eqz v5, :cond_1a

    .line 319
    const/16 v25, 0x2f

    move/from16 v0, v25

    invoke-virtual {v5, v0}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v14

    .line 320
    .local v14, "lastSlashPos":I
    if-ltz v14, :cond_1a

    .line 321
    add-int/lit8 v25, v14, 0x1

    move/from16 v0, v25

    invoke-virtual {v5, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    move-result-object v23

    .line 324
    .local v23, "total":Ljava/lang/String;
    :try_start_4
    invoke-static/range {v23 .. v23}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v26

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J
    :try_end_4
    .catch Ljava/lang/NumberFormatException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    .line 335
    .end local v5    # "contentRange":Ljava/lang/String;
    .end local v14    # "lastSlashPos":I
    .end local v23    # "total":Ljava/lang/String;
    :cond_1a
    :goto_8
    :try_start_5
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    invoke-virtual/range {v25 .. v25}, Ljava/net/HttpURLConnection;->getContentType()Ljava/lang/String;

    move-result-object v25

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/MediaHTTPConnectionEx;->mContentType:Ljava/lang/String;

    .line 337
    const-wide/16 v26, 0x0

    cmp-long v25, p1, v26

    if-lez v25, :cond_1d

    const/16 v25, 0xce

    move/from16 v0, v20

    move/from16 v1, v25

    if-eq v0, v1, :cond_1d

    .line 339
    new-instance v25, Ljava/io/IOException;

    invoke-direct/range {v25 .. v25}, Ljava/io/IOException;-><init>()V

    throw v25

    .line 330
    :cond_1b
    const/16 v25, 0xc8

    move/from16 v0, v20

    move/from16 v1, v25

    if-eq v0, v1, :cond_1c

    .line 331
    new-instance v25, Ljava/io/IOException;

    invoke-direct/range {v25 .. v25}, Ljava/io/IOException;-><init>()V

    throw v25

    .line 333
    :cond_1c
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    invoke-virtual/range {v25 .. v25}, Ljava/net/HttpURLConnection;->getContentLength()I

    move-result v25

    move/from16 v0, v25

    int-to-long v0, v0

    move-wide/from16 v26, v0

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    goto :goto_8

    .line 343
    :cond_1d
    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mRangeRequested:Z

    move/from16 v25, v0

    if-eqz v25, :cond_1e

    const/16 v25, 0xc8

    move/from16 v0, v20

    move/from16 v1, v25

    if-ne v0, v1, :cond_1e

    .line 344
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    const-string v26, "Transfer-Encoding"

    invoke-virtual/range {v25 .. v26}, Ljava/net/HttpURLConnection;->getHeaderField(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 346
    .local v4, "TrensferEncoding":Ljava/lang/String;
    if-eqz v4, :cond_1e

    const-string v25, "chunked"

    move-object/from16 v0, v25

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v25

    if-eqz v25, :cond_1e

    .line 347
    const-string v25, "MediaHTTPConnectionEx"

    const-string v26, "We requested a content range. server response with 200 Transfer-Encoding: chunked field in response header"

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 348
    const/16 v25, 0x0

    move/from16 v0, v25

    move-object/from16 v1, p0

    iput-boolean v0, v1, Landroid/media/MediaHTTPConnectionEx;->mServerSupportRangeRequest:Z

    .line 352
    .end local v4    # "TrensferEncoding":Ljava/lang/String;
    :cond_1e
    new-instance v25, Ljava/io/BufferedInputStream;

    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v26

    invoke-direct/range {v25 .. v26}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    iput-object v0, v1, Landroid/media/MediaHTTPConnectionEx;->mInputStream:Ljava/io/InputStream;

    .line 354
    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpTimeSeek:Z

    move/from16 v25, v0

    if-nez v25, :cond_20

    .line 355
    move-wide/from16 v0, p1

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->mCurrentOffset:J

    .line 396
    :cond_1f
    :goto_9
    return-void

    .line 357
    :cond_20
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    const-string v26, "TimeSeekRange.dlna.org"

    invoke-virtual/range {v25 .. v26}, Ljava/net/HttpURLConnection;->getHeaderField(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v22

    .line 363
    .local v22, "timeSeekHeader":Ljava/lang/String;
    move-object/from16 v0, p0

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Landroid/media/MediaHTTPConnectionEx;->parseTimeSeekRangeHeader(Ljava/lang/String;)Z

    .line 368
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v26, v0

    const-wide/16 v28, 0x0

    cmp-long v25, v26, v28

    if-ltz v25, :cond_21

    .line 369
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v26, v0

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->mCurrentOffset:J

    .line 370
    const-string v25, "MediaHTTPConnectionEx"

    new-instance v26, Ljava/lang/StringBuilder;

    invoke-direct/range {v26 .. v26}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "[seektoEx] startByte:"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v28, v0

    move-object/from16 v0, v26

    move-wide/from16 v1, v28

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v26

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 376
    :goto_a
    move-object/from16 v0, p0

    iget-object v0, v0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    move-object/from16 v25, v0

    invoke-virtual/range {v25 .. v25}, Ljava/net/HttpURLConnection;->getContentLength()I

    move-result v25

    move/from16 v0, v25

    int-to-long v0, v0

    move-wide/from16 v26, v0

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    .line 377
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v26, v0

    const-wide/16 v28, 0x0

    cmp-long v25, v26, v28

    if-ltz v25, :cond_22

    .line 378
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v26, v0

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    .line 379
    const-string v25, "MediaHTTPConnectionEx"

    new-instance v26, Ljava/lang/StringBuilder;

    invoke-direct/range {v26 .. v26}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "[seektoEx] totalByte:"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->totalByte:J

    move-wide/from16 v28, v0

    move-object/from16 v0, v26

    move-wide/from16 v1, v28

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v26

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_9

    .line 373
    :cond_21
    move-wide/from16 v0, p1

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->mCurrentOffset:J

    .line 374
    const-string v25, "MediaHTTPConnectionEx"

    new-instance v26, Ljava/lang/StringBuilder;

    invoke-direct/range {v26 .. v26}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "[seektoEx] this.mCurrentOffset:"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->mCurrentOffset:J

    move-wide/from16 v28, v0

    move-object/from16 v0, v26

    move-wide/from16 v1, v28

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v26

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_a

    .line 382
    :cond_22
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v26, v0

    const-wide/16 v28, 0x0

    cmp-long v25, v26, v28

    if-ltz v25, :cond_1f

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    move-wide/from16 v26, v0

    const-wide/16 v28, 0x0

    cmp-long v25, v26, v28

    if-lez v25, :cond_1f

    .line 383
    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    move-wide/from16 v26, v0

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->startByte:J

    move-wide/from16 v28, v0

    add-long v26, v26, v28

    move-wide/from16 v0, v26

    move-object/from16 v2, p0

    iput-wide v0, v2, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    .line 384
    const-string v25, "MediaHTTPConnectionEx"

    new-instance v26, Ljava/lang/StringBuilder;

    invoke-direct/range {v26 .. v26}, Ljava/lang/StringBuilder;-><init>()V

    const-string v27, "[seektoEx] this.mTotalSize:"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v26

    move-object/from16 v0, p0

    iget-wide v0, v0, Landroid/media/MediaHTTPConnectionEx;->mTotalSize:J

    move-wide/from16 v28, v0

    move-object/from16 v0, v26

    move-wide/from16 v1, v28

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v26

    invoke-static/range {v25 .. v26}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_0

    goto/16 :goto_9

    .line 325
    .end local v22    # "timeSeekHeader":Ljava/lang/String;
    .restart local v5    # "contentRange":Ljava/lang/String;
    .restart local v14    # "lastSlashPos":I
    .restart local v23    # "total":Ljava/lang/String;
    :catch_1
    move-exception v25

    goto/16 :goto_8

    .line 303
    .end local v5    # "contentRange":Ljava/lang/String;
    .end local v14    # "lastSlashPos":I
    .end local v23    # "total":Ljava/lang/String;
    .restart local v8    # "entry":Ljava/util/Map$Entry;
    .restart local v12    # "lastHyphenPos":I
    .restart local v13    # "lastPos":Ljava/lang/String;
    .restart local v18    # "rangeRequestLastPos":Ljava/lang/String;
    :catch_2
    move-exception v25

    goto/16 :goto_7
.end method

.method public setContentSize(J)V
    .locals 1
    .param p1, "contentSize"    # J

    .prologue
    .line 481
    iput-wide p1, p0, Landroid/media/MediaHTTPConnectionEx;->mContentSize:J

    .line 482
    return-void
.end method

.method public setDLNAByteRangeSeekMode(Z)V
    .locals 3
    .param p1, "mode"    # Z

    .prologue
    .line 406
    iput-boolean p1, p0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpByteRangeSeek:Z

    .line 407
    const-string v0, "MediaHTTPConnectionEx"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "setDLNAByteRangeSeekMode mIsHttpByteRangeSeek="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 408
    return-void
.end method

.method public setDLNAPauseMode(Z)V
    .locals 3
    .param p1, "mode"    # Z

    .prologue
    .line 412
    iput-boolean p1, p0, Landroid/media/MediaHTTPConnectionEx;->mIsDisconnectAtPause:Z

    .line 413
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpDlnaPlayback:Z

    .line 414
    const-string v0, "MediaHTTPConnectionEx"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "setDLNAPauseMode mIsDisconnectAtPause="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 415
    return-void
.end method

.method public setDLNAPlayback(Z)V
    .locals 3
    .param p1, "mode"    # Z

    .prologue
    .line 419
    iput-boolean p1, p0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpDlnaPlayback:Z

    .line 420
    const-string v0, "MediaHTTPConnectionEx"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "setDLNAPlayback mIsHttpDlnaPlayback="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 421
    return-void
.end method

.method public setDLNATimeSeekMode(Z)V
    .locals 3
    .param p1, "mode"    # Z

    .prologue
    .line 400
    iput-boolean p1, p0, Landroid/media/MediaHTTPConnectionEx;->mIsHttpTimeSeek:Z

    .line 401
    const-string v0, "MediaHTTPConnectionEx"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "setDLNATimeSeekMode mIsHttpTimeSeek="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 402
    return-void
.end method

.method public setDLNATimeSeekValue(J)V
    .locals 5
    .param p1, "param"    # J

    .prologue
    .line 425
    iput-wide p1, p0, Landroid/media/MediaHTTPConnectionEx;->mTimeSeekValue:J

    .line 426
    const-string v0, "MediaHTTPConnectionEx"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "setDLNATimeSeekValue mTimeSeekValue="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->mTimeSeekValue:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 427
    return-void
.end method

.method public setTimeout(II)V
    .locals 0
    .param p1, "connectTimeoutms"    # I
    .param p2, "readTimeoutms"    # I

    .prologue
    .line 452
    if-ltz p1, :cond_0

    .line 453
    iput p1, p0, Landroid/media/MediaHTTPConnectionEx;->mConnectTimeout:I

    .line 455
    :cond_0
    if-ltz p2, :cond_1

    .line 456
    iput p2, p0, Landroid/media/MediaHTTPConnectionEx;->mReadTimeout:I

    .line 458
    :cond_1
    return-void
.end method

.method protected teardownConnection()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 119
    iget-object v2, p0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    if-eqz v2, :cond_0

    .line 120
    iput-object v4, p0, Landroid/media/MediaHTTPConnectionEx;->mInputStream:Ljava/io/InputStream;

    .line 121
    const-string v2, "MediaHTTPConnectionEx"

    const-string/jumbo v3, "this.mConnection.disconnect();"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 123
    :try_start_0
    iget-object v2, p0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 129
    :goto_0
    const-string v2, "MediaHTTPConnectionEx"

    const-string/jumbo v3, "this.mConnection.disconnected;"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 130
    iput-object v4, p0, Landroid/media/MediaHTTPConnectionEx;->mConnection:Ljava/net/HttpURLConnection;

    .line 132
    const-wide/16 v2, -0x1

    iput-wide v2, p0, Landroid/media/MediaHTTPConnectionEx;->mCurrentOffset:J

    .line 135
    :cond_0
    return-void

    .line 124
    :catch_0
    move-exception v1

    .line 125
    .local v1, "rethrown":Ljava/lang/RuntimeException;
    const-string v2, "MediaHTTPConnectionEx"

    invoke-virtual {v1}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 126
    .end local v1    # "rethrown":Ljava/lang/RuntimeException;
    :catch_1
    move-exception v0

    .line 127
    .local v0, "ignored":Ljava/lang/Exception;
    const-string v2, "MediaHTTPConnectionEx"

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
