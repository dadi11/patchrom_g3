.class Lcom/android/server/am/ActivityManagerService$MainHandler$1;
.super Ljava/lang/Thread;
.source "ActivityManagerService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/android/server/am/ActivityManagerService$MainHandler;->handleMessage(Landroid/os/Message;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

.field final synthetic val$memInfos:Ljava/util/ArrayList;


# direct methods
.method constructor <init>(Lcom/android/server/am/ActivityManagerService$MainHandler;Ljava/util/ArrayList;)V
    .locals 0

    .prologue
    .line 1668
    iput-object p1, p0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iput-object p2, p0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->val$memInfos:Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 40

    .prologue
    .line 1670
    new-instance v25, Landroid/util/SparseArray;

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->val$memInfos:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    move-object/from16 v0, v25

    invoke-direct {v0, v5}, Landroid/util/SparseArray;-><init>(I)V

    .line 1672
    .local v25, "infoMap":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Lcom/android/server/am/ProcessMemInfo;>;"
    const/16 v24, 0x0

    .local v24, "i":I
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->val$memInfos:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v19

    .local v19, "N":I
    :goto_0
    move/from16 v0, v24

    move/from16 v1, v19

    if-ge v0, v1, :cond_0

    .line 1673
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->val$memInfos:Ljava/util/ArrayList;

    move/from16 v0, v24

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/android/server/am/ProcessMemInfo;

    .line 1674
    .local v4, "mi":Lcom/android/server/am/ProcessMemInfo;
    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->pid:I

    move-object/from16 v0, v25

    invoke-virtual {v0, v5, v4}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 1672
    add-int/lit8 v24, v24, 0x1

    goto :goto_0

    .line 1676
    .end local v4    # "mi":Lcom/android/server/am/ProcessMemInfo;
    :cond_0
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    invoke-virtual {v5}, Lcom/android/server/am/ActivityManagerService;->updateCpuStatsNow()V

    .line 1677
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    iget-object v11, v5, Lcom/android/server/am/ActivityManagerService;->mProcessCpuTracker:Lcom/android/internal/os/ProcessCpuTracker;

    monitor-enter v11

    .line 1678
    :try_start_0
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService;->mProcessCpuTracker:Lcom/android/internal/os/ProcessCpuTracker;

    invoke-virtual {v5}, Lcom/android/internal/os/ProcessCpuTracker;->countStats()I

    move-result v19

    .line 1679
    const/16 v24, 0x0

    :goto_1
    move/from16 v0, v24

    move/from16 v1, v19

    if-ge v0, v1, :cond_2

    .line 1680
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService;->mProcessCpuTracker:Lcom/android/internal/os/ProcessCpuTracker;

    move/from16 v0, v24

    invoke-virtual {v5, v0}, Lcom/android/internal/os/ProcessCpuTracker;->getStats(I)Lcom/android/internal/os/ProcessCpuTracker$Stats;

    move-result-object v31

    .line 1681
    .local v31, "st":Lcom/android/internal/os/ProcessCpuTracker$Stats;
    move-object/from16 v0, v31

    iget-wide v12, v0, Lcom/android/internal/os/ProcessCpuTracker$Stats;->vsize:J

    const-wide/16 v14, 0x0

    cmp-long v5, v12, v14

    if-lez v5, :cond_1

    .line 1682
    move-object/from16 v0, v31

    iget v5, v0, Lcom/android/internal/os/ProcessCpuTracker$Stats;->pid:I

    const/4 v6, 0x0

    invoke-static {v5, v6}, Landroid/os/Debug;->getPss(I[J)J

    move-result-wide v34

    .line 1683
    .local v34, "pss":J
    const-wide/16 v12, 0x0

    cmp-long v5, v34, v12

    if-lez v5, :cond_1

    .line 1684
    move-object/from16 v0, v31

    iget v5, v0, Lcom/android/internal/os/ProcessCpuTracker$Stats;->pid:I

    move-object/from16 v0, v25

    invoke-virtual {v0, v5}, Landroid/util/SparseArray;->indexOfKey(I)I

    move-result v5

    if-gez v5, :cond_1

    .line 1685
    new-instance v4, Lcom/android/server/am/ProcessMemInfo;

    move-object/from16 v0, v31

    iget-object v5, v0, Lcom/android/internal/os/ProcessCpuTracker$Stats;->name:Ljava/lang/String;

    move-object/from16 v0, v31

    iget v6, v0, Lcom/android/internal/os/ProcessCpuTracker$Stats;->pid:I

    const/16 v7, -0x11

    const/4 v8, -0x1

    const-string v9, "native"

    const/4 v10, 0x0

    invoke-direct/range {v4 .. v10}, Lcom/android/server/am/ProcessMemInfo;-><init>(Ljava/lang/String;IIILjava/lang/String;Ljava/lang/String;)V

    .line 1687
    .restart local v4    # "mi":Lcom/android/server/am/ProcessMemInfo;
    move-wide/from16 v0, v34

    iput-wide v0, v4, Lcom/android/server/am/ProcessMemInfo;->pss:J

    .line 1688
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->val$memInfos:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1679
    .end local v4    # "mi":Lcom/android/server/am/ProcessMemInfo;
    .end local v34    # "pss":J
    :cond_1
    add-int/lit8 v24, v24, 0x1

    goto :goto_1

    .line 1693
    .end local v31    # "st":Lcom/android/internal/os/ProcessCpuTracker$Stats;
    :cond_2
    monitor-exit v11
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1695
    const-wide/16 v38, 0x0

    .line 1696
    .local v38, "totalPss":J
    const/16 v24, 0x0

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->val$memInfos:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v19

    :goto_2
    move/from16 v0, v24

    move/from16 v1, v19

    if-ge v0, v1, :cond_4

    .line 1697
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->val$memInfos:Ljava/util/ArrayList;

    move/from16 v0, v24

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/android/server/am/ProcessMemInfo;

    .line 1698
    .restart local v4    # "mi":Lcom/android/server/am/ProcessMemInfo;
    iget-wide v10, v4, Lcom/android/server/am/ProcessMemInfo;->pss:J

    const-wide/16 v12, 0x0

    cmp-long v5, v10, v12

    if-nez v5, :cond_3

    .line 1699
    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->pid:I

    const/4 v6, 0x0

    invoke-static {v5, v6}, Landroid/os/Debug;->getPss(I[J)J

    move-result-wide v10

    iput-wide v10, v4, Lcom/android/server/am/ProcessMemInfo;->pss:J

    .line 1701
    :cond_3
    iget-wide v10, v4, Lcom/android/server/am/ProcessMemInfo;->pss:J

    add-long v38, v38, v10

    .line 1696
    add-int/lit8 v24, v24, 0x1

    goto :goto_2

    .line 1693
    .end local v4    # "mi":Lcom/android/server/am/ProcessMemInfo;
    .end local v38    # "totalPss":J
    :catchall_0
    move-exception v5

    :try_start_1
    monitor-exit v11
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v5

    .line 1703
    .restart local v38    # "totalPss":J
    :cond_4
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->val$memInfos:Ljava/util/ArrayList;

    new-instance v6, Lcom/android/server/am/ActivityManagerService$MainHandler$1$1;

    move-object/from16 v0, p0

    invoke-direct {v6, v0}, Lcom/android/server/am/ActivityManagerService$MainHandler$1$1;-><init>(Lcom/android/server/am/ActivityManagerService$MainHandler$1;)V

    invoke-static {v5, v6}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 1715
    new-instance v37, Ljava/lang/StringBuilder;

    const/16 v5, 0x80

    move-object/from16 v0, v37

    invoke-direct {v0, v5}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 1716
    .local v37, "tag":Ljava/lang/StringBuilder;
    new-instance v36, Ljava/lang/StringBuilder;

    const/16 v5, 0x80

    move-object/from16 v0, v36

    invoke-direct {v0, v5}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 1717
    .local v36, "stack":Ljava/lang/StringBuilder;
    const-string v5, "Low on memory -- "

    move-object/from16 v0, v37

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1718
    const-string v5, "total"

    const/4 v6, 0x0

    move-object/from16 v0, v37

    move-wide/from16 v1, v38

    invoke-static {v0, v1, v2, v5, v6}, Lcom/android/server/am/ActivityManagerService;->appendMemBucket(Ljava/lang/StringBuilder;JLjava/lang/String;Z)V

    .line 1719
    const-string v5, "total"

    const/4 v6, 0x1

    move-object/from16 v0, v36

    move-wide/from16 v1, v38

    invoke-static {v0, v1, v2, v5, v6}, Lcom/android/server/am/ActivityManagerService;->appendMemBucket(Ljava/lang/StringBuilder;JLjava/lang/String;Z)V

    .line 1721
    new-instance v30, Ljava/lang/StringBuilder;

    const/16 v5, 0x400

    move-object/from16 v0, v30

    invoke-direct {v0, v5}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 1722
    .local v30, "logBuilder":Ljava/lang/StringBuilder;
    const-string v5, "Low on memory:\n"

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1724
    const/16 v22, 0x1

    .line 1725
    .local v22, "firstLine":Z
    const/high16 v29, -0x80000000

    .line 1726
    .local v29, "lastOomAdj":I
    const/16 v24, 0x0

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->val$memInfos:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v19

    :goto_3
    move/from16 v0, v24

    move/from16 v1, v19

    if-ge v0, v1, :cond_10

    .line 1727
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->val$memInfos:Ljava/util/ArrayList;

    move/from16 v0, v24

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/android/server/am/ProcessMemInfo;

    .line 1729
    .restart local v4    # "mi":Lcom/android/server/am/ProcessMemInfo;
    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    const/16 v6, -0x11

    if-eq v5, v6, :cond_e

    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    const/4 v6, 0x5

    if-lt v5, v6, :cond_5

    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    const/4 v6, 0x6

    if-eq v5, v6, :cond_5

    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    const/4 v6, 0x7

    if-ne v5, v6, :cond_e

    .line 1733
    :cond_5
    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    move/from16 v0, v29

    if-eq v0, v5, :cond_c

    .line 1734
    iget v0, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    move/from16 v29, v0

    .line 1735
    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    if-gtz v5, :cond_6

    .line 1736
    const-string v5, " / "

    move-object/from16 v0, v37

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1738
    :cond_6
    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    if-ltz v5, :cond_b

    .line 1739
    if-eqz v22, :cond_7

    .line 1740
    const-string v5, ":"

    move-object/from16 v0, v36

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1741
    const/16 v22, 0x0

    .line 1743
    :cond_7
    const-string v5, "\n\t at "

    move-object/from16 v0, v36

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1751
    :goto_4
    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    if-gtz v5, :cond_8

    .line 1752
    iget-wide v10, v4, Lcom/android/server/am/ProcessMemInfo;->pss:J

    iget-object v5, v4, Lcom/android/server/am/ProcessMemInfo;->name:Ljava/lang/String;

    const/4 v6, 0x0

    move-object/from16 v0, v37

    invoke-static {v0, v10, v11, v5, v6}, Lcom/android/server/am/ActivityManagerService;->appendMemBucket(Ljava/lang/StringBuilder;JLjava/lang/String;Z)V

    .line 1754
    :cond_8
    iget-wide v10, v4, Lcom/android/server/am/ProcessMemInfo;->pss:J

    iget-object v5, v4, Lcom/android/server/am/ProcessMemInfo;->name:Ljava/lang/String;

    const/4 v6, 0x1

    move-object/from16 v0, v36

    invoke-static {v0, v10, v11, v5, v6}, Lcom/android/server/am/ActivityManagerService;->appendMemBucket(Ljava/lang/StringBuilder;JLjava/lang/String;Z)V

    .line 1755
    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    if-ltz v5, :cond_e

    add-int/lit8 v5, v24, 0x1

    move/from16 v0, v19

    if-ge v5, v0, :cond_9

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->val$memInfos:Ljava/util/ArrayList;

    add-int/lit8 v6, v24, 0x1

    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/android/server/am/ProcessMemInfo;

    iget v5, v5, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    move/from16 v0, v29

    if-eq v5, v0, :cond_e

    .line 1757
    :cond_9
    const-string v5, "("

    move-object/from16 v0, v36

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1758
    const/16 v28, 0x0

    .local v28, "k":I
    :goto_5
    sget-object v5, Lcom/android/server/am/ActivityManagerService;->DUMP_MEM_OOM_ADJ:[I

    array-length v5, v5

    move/from16 v0, v28

    if-ge v0, v5, :cond_d

    .line 1759
    sget-object v5, Lcom/android/server/am/ActivityManagerService;->DUMP_MEM_OOM_ADJ:[I

    aget v5, v5, v28

    iget v6, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    if-ne v5, v6, :cond_a

    .line 1760
    sget-object v5, Lcom/android/server/am/ActivityManagerService;->DUMP_MEM_OOM_LABEL:[Ljava/lang/String;

    aget-object v5, v5, v28

    move-object/from16 v0, v36

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1761
    const-string v5, ":"

    move-object/from16 v0, v36

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1762
    sget-object v5, Lcom/android/server/am/ActivityManagerService;->DUMP_MEM_OOM_ADJ:[I

    aget v5, v5, v28

    move-object/from16 v0, v36

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 1758
    :cond_a
    add-int/lit8 v28, v28, 0x1

    goto :goto_5

    .line 1745
    .end local v28    # "k":I
    :cond_b
    const-string v5, "$"

    move-object/from16 v0, v36

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_4

    .line 1748
    :cond_c
    const-string v5, " "

    move-object/from16 v0, v37

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1749
    const-string v5, "$"

    move-object/from16 v0, v36

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_4

    .line 1765
    .restart local v28    # "k":I
    :cond_d
    const-string v5, ")"

    move-object/from16 v0, v36

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1769
    .end local v28    # "k":I
    :cond_e
    const-string v5, "  "

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1770
    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->oomAdj:I

    invoke-static {v5}, Lcom/android/server/am/ProcessList;->makeOomAdjString(I)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1771
    const/16 v5, 0x20

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1772
    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->procState:I

    invoke-static {v5}, Lcom/android/server/am/ProcessList;->makeProcStateString(I)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1773
    const/16 v5, 0x20

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1774
    iget-wide v10, v4, Lcom/android/server/am/ProcessMemInfo;->pss:J

    move-object/from16 v0, v30

    invoke-static {v0, v10, v11}, Lcom/android/server/am/ProcessList;->appendRamKb(Ljava/lang/StringBuilder;J)V

    .line 1775
    const-string v5, " kB: "

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1776
    iget-object v5, v4, Lcom/android/server/am/ProcessMemInfo;->name:Ljava/lang/String;

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1777
    const-string v5, " ("

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1778
    iget v5, v4, Lcom/android/server/am/ProcessMemInfo;->pid:I

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 1779
    const-string v5, ") "

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1780
    iget-object v5, v4, Lcom/android/server/am/ProcessMemInfo;->adjType:Ljava/lang/String;

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1781
    const/16 v5, 0xa

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1782
    iget-object v5, v4, Lcom/android/server/am/ProcessMemInfo;->adjReason:Ljava/lang/String;

    if-eqz v5, :cond_f

    .line 1783
    const-string v5, "                      "

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1784
    iget-object v5, v4, Lcom/android/server/am/ProcessMemInfo;->adjReason:Ljava/lang/String;

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1785
    const/16 v5, 0xa

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1726
    :cond_f
    add-int/lit8 v24, v24, 0x1

    goto/16 :goto_3

    .line 1789
    .end local v4    # "mi":Lcom/android/server/am/ProcessMemInfo;
    :cond_10
    const-string v5, "           "

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1790
    move-object/from16 v0, v30

    move-wide/from16 v1, v38

    invoke-static {v0, v1, v2}, Lcom/android/server/am/ProcessList;->appendRamKb(Ljava/lang/StringBuilder;J)V

    .line 1791
    const-string v5, " kB: TOTAL\n"

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1793
    const/16 v5, 0xc

    new-array v0, v5, [J

    move-object/from16 v26, v0

    .line 1794
    .local v26, "infos":[J
    invoke-static/range {v26 .. v26}, Landroid/os/Debug;->getMemInfo([J)V

    .line 1795
    const-string v5, "  MemInfo: "

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1796
    const/16 v5, 0xa

    aget-wide v10, v26, v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " kB slab, "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1797
    const/16 v5, 0x9

    aget-wide v10, v26, v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " kB shmem, "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1798
    const/4 v5, 0x2

    aget-wide v10, v26, v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " kB buffers, "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1799
    const/4 v5, 0x3

    aget-wide v10, v26, v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " kB cached, "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1800
    const/4 v5, 0x1

    aget-wide v10, v26, v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " kB free"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1802
    const-string v5, "1"

    const-string v6, "ro.debuggable"

    const-string v9, "0"

    invoke-static {v6, v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v27

    .line 1803
    .local v27, "isDebuggable":Z
    if-eqz v27, :cond_12

    const/4 v5, 0x4

    aget-wide v10, v26, v5

    const-wide/16 v12, 0x0

    cmp-long v5, v10, v12

    if-nez v5, :cond_11

    const/4 v5, 0x5

    aget-wide v10, v26, v5

    const-wide/16 v12, 0x0

    cmp-long v5, v10, v12

    if-eqz v5, :cond_12

    .line 1804
    :cond_11
    const-string v5, " ("

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const/4 v6, 0x4

    aget-wide v10, v26, v6

    invoke-virtual {v5, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " HighFree + "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1805
    const/4 v5, 0x5

    aget-wide v10, v26, v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " LowFree)"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1807
    :cond_12
    const-string v5, "\n"

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1808
    const/16 v5, 0xb

    aget-wide v10, v26, v5

    const-wide/16 v12, 0x0

    cmp-long v5, v10, v12

    if-eqz v5, :cond_13

    .line 1809
    const-string v5, "  ZRAM: "

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1810
    const/16 v5, 0xb

    aget-wide v10, v26, v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    .line 1811
    const-string v5, " kB RAM, "

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1812
    const/4 v5, 0x6

    aget-wide v10, v26, v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    .line 1813
    const-string v5, " kB swap total, "

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1814
    const/4 v5, 0x7

    aget-wide v10, v26, v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    .line 1815
    const-string v5, " kB swap free\n"

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1818
    :cond_13
    if-eqz v27, :cond_15

    .line 1820
    new-instance v23, Lcom/android/server/am/GraphicMemoryInfo;

    invoke-direct/range {v23 .. v23}, Lcom/android/server/am/GraphicMemoryInfo;-><init>()V

    .line 1821
    .local v23, "gmi":Lcom/android/server/am/GraphicMemoryInfo;
    if-nez v23, :cond_14

    .line 1822
    const-string v5, "GraphicMemoryInfo class isn\'t created"

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1824
    :cond_14
    invoke-virtual/range {v23 .. v23}, Lcom/android/server/am/GraphicMemoryInfo;->printGraphicMemory()Ljava/lang/StringBuffer;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v30

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1826
    .end local v23    # "gmi":Lcom/android/server/am/GraphicMemoryInfo;
    :cond_15
    const-string v5, "ActivityManager"

    invoke-virtual/range {v30 .. v30}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1828
    new-instance v21, Ljava/lang/StringBuilder;

    const/16 v5, 0x400

    move-object/from16 v0, v21

    invoke-direct {v0, v5}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 1839
    .local v21, "dropBuilder":Ljava/lang/StringBuilder;
    move-object/from16 v0, v21

    move-object/from16 v1, v36

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;)Ljava/lang/StringBuilder;

    .line 1840
    const/16 v5, 0xa

    move-object/from16 v0, v21

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1841
    const/16 v5, 0xa

    move-object/from16 v0, v21

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1842
    move-object/from16 v0, v21

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;)Ljava/lang/StringBuilder;

    .line 1843
    const/16 v5, 0xa

    move-object/from16 v0, v21

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1848
    new-instance v20, Ljava/io/StringWriter;

    invoke-direct/range {v20 .. v20}, Ljava/io/StringWriter;-><init>()V

    .line 1849
    .local v20, "catSw":Ljava/io/StringWriter;
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v13, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    monitor-enter v13

    .line 1850
    :try_start_2
    new-instance v7, Lcom/android/internal/util/FastPrintWriter;

    const/4 v5, 0x0

    const/16 v6, 0x100

    move-object/from16 v0, v20

    invoke-direct {v7, v0, v5, v6}, Lcom/android/internal/util/FastPrintWriter;-><init>(Ljava/io/Writer;ZI)V

    .line 1851
    .local v7, "catPw":Ljava/io/PrintWriter;
    const/4 v5, 0x0

    new-array v8, v5, [Ljava/lang/String;

    .line 1852
    .local v8, "emptyArgs":[Ljava/lang/String;
    invoke-virtual {v7}, Ljava/io/PrintWriter;->println()V

    .line 1853
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    const/4 v6, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-virtual/range {v5 .. v11}, Lcom/android/server/am/ActivityManagerService;->dumpProcessesLocked(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;IZLjava/lang/String;)V

    .line 1854
    invoke-virtual {v7}, Ljava/io/PrintWriter;->println()V

    .line 1855
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService;->mServices:Lcom/android/server/am/ActiveServices;

    const/4 v6, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-virtual/range {v5 .. v12}, Lcom/android/server/am/ActiveServices;->dumpServicesLocked(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;IZZLjava/lang/String;)V

    .line 1857
    invoke-virtual {v7}, Ljava/io/PrintWriter;->println()V

    .line 1858
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    const/4 v6, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-virtual/range {v5 .. v12}, Lcom/android/server/am/ActivityManagerService;->dumpActivitiesLocked(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;IZZLjava/lang/String;)V

    .line 1859
    invoke-virtual {v7}, Ljava/io/PrintWriter;->flush()V

    .line 1860
    monitor-exit v13
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1861
    invoke-virtual/range {v20 .. v20}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v21

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1862
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v9, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    const-string v10, "lowmem"

    const/4 v11, 0x0

    const-string v12, "system_server"

    const/4 v13, 0x0

    const/4 v14, 0x0

    invoke-virtual/range {v37 .. v37}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    const/16 v17, 0x0

    const/16 v18, 0x0

    invoke-virtual/range {v9 .. v18}, Lcom/android/server/am/ActivityManagerService;->addErrorToDropBox(Ljava/lang/String;Lcom/android/server/am/ProcessRecord;Ljava/lang/String;Lcom/android/server/am/ActivityRecord;Lcom/android/server/am/ActivityRecord;Ljava/lang/String;Ljava/lang/String;Ljava/io/File;Landroid/app/ApplicationErrorReport$CrashInfo;)V

    .line 1866
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v6, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    monitor-enter v6

    .line 1867
    :try_start_3
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v32

    .line 1868
    .local v32, "now":J
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    iget-wide v10, v5, Lcom/android/server/am/ActivityManagerService;->mLastMemUsageReportTime:J

    cmp-long v5, v10, v32

    if-gez v5, :cond_16

    .line 1869
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/am/ActivityManagerService$MainHandler$1;->this$1:Lcom/android/server/am/ActivityManagerService$MainHandler;

    iget-object v5, v5, Lcom/android/server/am/ActivityManagerService$MainHandler;->this$0:Lcom/android/server/am/ActivityManagerService;

    move-wide/from16 v0, v32

    iput-wide v0, v5, Lcom/android/server/am/ActivityManagerService;->mLastMemUsageReportTime:J

    .line 1871
    :cond_16
    monitor-exit v6
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 1872
    return-void

    .line 1860
    .end local v7    # "catPw":Ljava/io/PrintWriter;
    .end local v8    # "emptyArgs":[Ljava/lang/String;
    .end local v32    # "now":J
    :catchall_1
    move-exception v5

    :try_start_4
    monitor-exit v13
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    throw v5

    .line 1871
    .restart local v7    # "catPw":Ljava/io/PrintWriter;
    .restart local v8    # "emptyArgs":[Ljava/lang/String;
    :catchall_2
    move-exception v5

    :try_start_5
    monitor-exit v6
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    throw v5
.end method
