.class final Landroid/content/ContentResolver$CursorWrapperInnerForDebug;
.super Landroid/database/CrossProcessCursorWrapper;
.source "ContentResolver.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/content/ContentResolver;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "CursorWrapperInnerForDebug"
.end annotation


# static fields
.field public static final TAG:Ljava/lang/String; = "CursorWrapperInnerForDebug"


# instance fields
.field private final mCloseGuard:Ldalvik/system/CloseGuard;

.field private mColumnUseFlag:[I

.field private final mContentProvider:Landroid/content/IContentProvider;

.field private mContext:Landroid/content/Context;

.field private mDurationMillis:J

.field private mProjection:[Ljava/lang/String;

.field private mProviderReleased:Z

.field private mSelection:Ljava/lang/String;

.field private mSelectionArgs:[Ljava/lang/String;

.field private mSortOrder:Ljava/lang/String;

.field private mUri:Landroid/net/Uri;

.field final synthetic this$0:Landroid/content/ContentResolver;


# direct methods
.method constructor <init>(Landroid/content/ContentResolver;Landroid/database/Cursor;Landroid/content/IContentProvider;Landroid/content/Context;JLandroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p2, "cursor"    # Landroid/database/Cursor;
    .param p3, "icp"    # Landroid/content/IContentProvider;
    .param p4, "mContext"    # Landroid/content/Context;
    .param p5, "durationMillis"    # J
    .param p7, "uri"    # Landroid/net/Uri;
    .param p8, "projection"    # [Ljava/lang/String;
    .param p9, "selection"    # Ljava/lang/String;
    .param p10, "selectionArgs"    # [Ljava/lang/String;
    .param p11, "sortOrder"    # Ljava/lang/String;

    .prologue
    .line 2512
    iput-object p1, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->this$0:Landroid/content/ContentResolver;

    .line 2513
    invoke-direct {p0, p2}, Landroid/database/CrossProcessCursorWrapper;-><init>(Landroid/database/Cursor;)V

    .line 2500
    invoke-static {}, Ldalvik/system/CloseGuard;->get()Ldalvik/system/CloseGuard;

    move-result-object v0

    iput-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mCloseGuard:Ldalvik/system/CloseGuard;

    .line 2514
    iput-object p3, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mContentProvider:Landroid/content/IContentProvider;

    .line 2515
    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mCloseGuard:Ldalvik/system/CloseGuard;

    const-string v1, "close"

    invoke-virtual {v0, v1}, Ldalvik/system/CloseGuard;->open(Ljava/lang/String;)V

    .line 2516
    iput-object p4, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mContext:Landroid/content/Context;

    .line 2517
    iput-wide p5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mDurationMillis:J

    .line 2518
    iput-object p7, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mUri:Landroid/net/Uri;

    .line 2519
    iput-object p8, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mProjection:[Ljava/lang/String;

    .line 2520
    iput-object p9, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mSelection:Ljava/lang/String;

    .line 2521
    iput-object p10, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mSelectionArgs:[Ljava/lang/String;

    .line 2522
    iput-object p11, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mSortOrder:Ljava/lang/String;

    .line 2523
    invoke-interface {p2}, Landroid/database/Cursor;->getColumnCount()I

    move-result v0

    if-lez v0, :cond_0

    .line 2524
    invoke-interface {p2}, Landroid/database/Cursor;->getColumnCount()I

    move-result v0

    new-array v0, v0, [I

    iput-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mColumnUseFlag:[I

    .line 2526
    :cond_0
    return-void
.end method

.method private checkColumnUse()V
    .locals 10

    .prologue
    .line 2571
    invoke-direct {p0}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->getUnusedColumnCount()I

    move-result v4

    .line 2572
    .local v4, "unusedColumnCount":I
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mColumnUseFlag:[I

    array-length v3, v5

    .line 2573
    .local v3, "totalColumnCount":I
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mColumnUseFlag:[I

    if-eqz v5, :cond_a

    if-lez v4, :cond_a

    invoke-virtual {p0}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->getCount()I

    move-result v5

    if-lez v5, :cond_a

    .line 2574
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    .line 2575
    .local v2, "packagename":Ljava/lang/String;
    const-string v5, "CursorWrapperInnerForDebug"

    const-string v6, "======================================================================================="

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2576
    const-string v5, "CursorWrapperInnerForDebug"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[Check PackageName : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]    [QueryTime : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-wide v8, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mDurationMillis:J

    invoke-static {v8, v9}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string/jumbo v7, "ms]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "    [Row Count : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {p0}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->getCount()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2577
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    .line 2578
    .local v1, "mQueryInfo":Ljava/lang/StringBuffer;
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mUri:Landroid/net/Uri;

    if-eqz v5, :cond_0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[URI : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mUri:Landroid/net/Uri;

    invoke-virtual {v6}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " ]  "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 2579
    :cond_0
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mProjection:[Ljava/lang/String;

    if-eqz v5, :cond_5

    .line 2580
    const-string v5, "[PROJECTION : "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 2581
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mProjection:[Ljava/lang/String;

    array-length v5, v5

    if-ge v0, v5, :cond_2

    .line 2582
    if-eqz v0, :cond_1

    .line 2583
    const-string v5, ", "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 2585
    :cond_1
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mProjection:[Ljava/lang/String;

    aget-object v5, v5, v0

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 2581
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 2587
    :cond_2
    const-string v5, " ]  "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 2591
    .end local v0    # "i":I
    :goto_1
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mSelection:Ljava/lang/String;

    if-eqz v5, :cond_3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[SELECTION : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mSelection:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " ]  "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 2592
    :cond_3
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mSelectionArgs:[Ljava/lang/String;

    if-eqz v5, :cond_7

    .line 2593
    const-string v5, "[SELECTION_ARGS : "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 2594
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_2
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mSelectionArgs:[Ljava/lang/String;

    array-length v5, v5

    if-ge v0, v5, :cond_6

    .line 2595
    if-eqz v0, :cond_4

    .line 2596
    const-string v5, ", "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 2598
    :cond_4
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mSelectionArgs:[Ljava/lang/String;

    aget-object v5, v5, v0

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 2594
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 2589
    .end local v0    # "i":I
    :cond_5
    const-string v5, "[PROJECTION : * ]  "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_1

    .line 2600
    .restart local v0    # "i":I
    :cond_6
    const-string v5, " ]  "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 2602
    .end local v0    # "i":I
    :cond_7
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mSortOrder:Ljava/lang/String;

    if-eqz v5, :cond_8

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[SORTORDER : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mSortOrder:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " ]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 2604
    :cond_8
    const-string v5, "CursorWrapperInnerForDebug"

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2606
    if-ne v4, v3, :cond_b

    .line 2607
    const-string v5, "CursorWrapperInnerForDebug"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "    No Column is used. ColumnCount : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2616
    :cond_9
    const-string v5, "CursorWrapperInnerForDebug"

    const-string v6, "======================================================================================="

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2618
    .end local v1    # "mQueryInfo":Ljava/lang/StringBuffer;
    .end local v2    # "packagename":Ljava/lang/String;
    :cond_a
    return-void

    .line 2609
    .restart local v1    # "mQueryInfo":Ljava/lang/StringBuffer;
    .restart local v2    # "packagename":Ljava/lang/String;
    :cond_b
    const-string v5, "CursorWrapperInnerForDebug"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "    Total Columns : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ", Unused Columns : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2610
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_3
    if-ge v0, v3, :cond_9

    .line 2611
    iget-object v5, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mColumnUseFlag:[I

    aget v5, v5, v0

    if-nez v5, :cond_c

    .line 2612
    const-string v5, "CursorWrapperInnerForDebug"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "        Column Name : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {p0, v0}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->getColumnName(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ", Column Index : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " - Field is never used."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2610
    :cond_c
    add-int/lit8 v0, v0, 0x1

    goto :goto_3
.end method

.method private getUnusedColumnCount()I
    .locals 3

    .prologue
    .line 2560
    const/4 v0, 0x0

    .line 2561
    .local v0, "count":I
    iget-object v2, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mColumnUseFlag:[I

    if-eqz v2, :cond_1

    .line 2562
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget-object v2, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mColumnUseFlag:[I

    array-length v2, v2

    if-ge v1, v2, :cond_1

    .line 2563
    iget-object v2, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mColumnUseFlag:[I

    aget v2, v2, v1

    if-nez v2, :cond_0

    .line 2564
    add-int/lit8 v0, v0, 0x1

    .line 2562
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 2568
    .end local v1    # "i":I
    :cond_1
    return v0
.end method

.method private updateColumnUseFlag(I)V
    .locals 2
    .param p1, "columnIndex"    # I

    .prologue
    .line 2620
    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mColumnUseFlag:[I

    if-eqz v0, :cond_0

    if-ltz p1, :cond_0

    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mColumnUseFlag:[I

    array-length v0, v0

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mColumnUseFlag:[I

    aget v0, v0, p1

    if-nez v0, :cond_0

    .line 2621
    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mColumnUseFlag:[I

    const/4 v1, 0x1

    aput v1, v0, p1

    .line 2622
    :cond_0
    return-void
.end method


# virtual methods
.method public close()V
    .locals 2

    .prologue
    .line 2530
    invoke-virtual {p0}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->isClosed()Z

    move-result v0

    if-nez v0, :cond_0

    .line 2531
    invoke-direct {p0}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->checkColumnUse()V

    .line 2533
    :cond_0
    invoke-super {p0}, Landroid/database/CrossProcessCursorWrapper;->close()V

    .line 2534
    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->this$0:Landroid/content/ContentResolver;

    iget-object v1, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mContentProvider:Landroid/content/IContentProvider;

    invoke-virtual {v0, v1}, Landroid/content/ContentResolver;->releaseProvider(Landroid/content/IContentProvider;)Z

    .line 2535
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mProviderReleased:Z

    .line 2537
    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mCloseGuard:Ldalvik/system/CloseGuard;

    if-eqz v0, :cond_1

    .line 2538
    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mCloseGuard:Ldalvik/system/CloseGuard;

    invoke-virtual {v0}, Ldalvik/system/CloseGuard;->close()V

    .line 2540
    :cond_1
    return-void
.end method

.method protected finalize()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    .line 2545
    :try_start_0
    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mCloseGuard:Ldalvik/system/CloseGuard;

    if-eqz v0, :cond_0

    .line 2546
    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mCloseGuard:Ldalvik/system/CloseGuard;

    invoke-virtual {v0}, Ldalvik/system/CloseGuard;->warnIfOpen()V

    .line 2549
    :cond_0
    iget-boolean v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mProviderReleased:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mContentProvider:Landroid/content/IContentProvider;

    if-eqz v0, :cond_1

    .line 2552
    const-string v0, "CursorWrapperInnerForDebug"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Cursor finalized without prior close() in "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 2553
    iget-object v0, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->this$0:Landroid/content/ContentResolver;

    iget-object v1, p0, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->mContentProvider:Landroid/content/IContentProvider;

    invoke-virtual {v0, v1}, Landroid/content/ContentResolver;->releaseProvider(Landroid/content/IContentProvider;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2556
    :cond_1
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 2558
    return-void

    .line 2556
    :catchall_0
    move-exception v0

    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    throw v0
.end method

.method public getBlob(I)[B
    .locals 1
    .param p1, "columnIndex"    # I

    .prologue
    .line 2625
    invoke-direct {p0, p1}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->updateColumnUseFlag(I)V

    .line 2626
    invoke-super {p0, p1}, Landroid/database/CrossProcessCursorWrapper;->getBlob(I)[B

    move-result-object v0

    return-object v0
.end method

.method public getDouble(I)D
    .locals 2
    .param p1, "columnIndex"    # I

    .prologue
    .line 2659
    invoke-direct {p0, p1}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->updateColumnUseFlag(I)V

    .line 2660
    invoke-super {p0, p1}, Landroid/database/CrossProcessCursorWrapper;->getDouble(I)D

    move-result-wide v0

    return-wide v0
.end method

.method public getFloat(I)F
    .locals 1
    .param p1, "columnIndex"    # I

    .prologue
    .line 2653
    invoke-direct {p0, p1}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->updateColumnUseFlag(I)V

    .line 2654
    invoke-super {p0, p1}, Landroid/database/CrossProcessCursorWrapper;->getFloat(I)F

    move-result v0

    return v0
.end method

.method public getInt(I)I
    .locals 1
    .param p1, "columnIndex"    # I

    .prologue
    .line 2641
    invoke-direct {p0, p1}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->updateColumnUseFlag(I)V

    .line 2642
    invoke-super {p0, p1}, Landroid/database/CrossProcessCursorWrapper;->getInt(I)I

    move-result v0

    return v0
.end method

.method public getLong(I)J
    .locals 2
    .param p1, "columnIndex"    # I

    .prologue
    .line 2647
    invoke-direct {p0, p1}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->updateColumnUseFlag(I)V

    .line 2648
    invoke-super {p0, p1}, Landroid/database/CrossProcessCursorWrapper;->getLong(I)J

    move-result-wide v0

    return-wide v0
.end method

.method public getShort(I)S
    .locals 1
    .param p1, "columnIndex"    # I

    .prologue
    .line 2635
    invoke-direct {p0, p1}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->updateColumnUseFlag(I)V

    .line 2636
    invoke-super {p0, p1}, Landroid/database/CrossProcessCursorWrapper;->getShort(I)S

    move-result v0

    return v0
.end method

.method public getString(I)Ljava/lang/String;
    .locals 1
    .param p1, "columnIndex"    # I

    .prologue
    .line 2630
    invoke-direct {p0, p1}, Landroid/content/ContentResolver$CursorWrapperInnerForDebug;->updateColumnUseFlag(I)V

    .line 2631
    invoke-super {p0, p1}, Landroid/database/CrossProcessCursorWrapper;->getString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
