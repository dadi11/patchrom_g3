.class Lcom/lge/dockservice/DockWindowService$4;
.super Ljava/lang/Object;
.source "DockWindowService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/dockservice/DockWindowService;->exitLowProfile(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/dockservice/DockWindowService;

.field final synthetic val$requester:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/lge/dockservice/DockWindowService;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 852
    iput-object p1, p0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    iput-object p2, p0, Lcom/lge/dockservice/DockWindowService$4;->val$requester:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 21

    .prologue
    .line 855
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v17

    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    const-string v19, "exit low profile for "

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v19, v0

    # getter for: Lcom/lge/dockservice/DockWindowService;->mDockViewList:Ljava/util/Map;
    invoke-static/range {v19 .. v19}, Lcom/lge/dockservice/DockWindowService;->access$100(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Map;

    move-result-object v19

    invoke-interface/range {v19 .. v19}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    invoke-static/range {v17 .. v18}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 856
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v17, v0

    # getter for: Lcom/lge/dockservice/DockWindowService;->mLowProfileRequests:Ljava/util/Set;
    invoke-static/range {v17 .. v17}, Lcom/lge/dockservice/DockWindowService;->access$1700(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Set;

    move-result-object v18

    monitor-enter v18

    .line 857
    :try_start_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v17, v0

    # getter for: Lcom/lge/dockservice/DockWindowService;->mLowProfileRequests:Ljava/util/Set;
    invoke-static/range {v17 .. v17}, Lcom/lge/dockservice/DockWindowService;->access$1700(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Set;

    move-result-object v17

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->val$requester:Ljava/lang/String;

    move-object/from16 v19, v0

    move-object/from16 v0, v17

    move-object/from16 v1, v19

    invoke-interface {v0, v1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 858
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    .line 861
    .local v6, "context":Landroid/content/Context;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v17, v0

    # getter for: Lcom/lge/dockservice/DockWindowService;->mLowProfileRequests:Ljava/util/Set;
    invoke-static/range {v17 .. v17}, Lcom/lge/dockservice/DockWindowService;->access$1700(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Set;

    move-result-object v17

    invoke-interface/range {v17 .. v17}, Ljava/util/Set;->isEmpty()Z

    move-result v17

    if-nez v17, :cond_7

    .line 862
    const-string v17, "activity"

    move-object/from16 v0, v17

    invoke-virtual {v6, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/ActivityManager;

    .line 863
    .local v3, "am":Landroid/app/ActivityManager;
    if-nez v3, :cond_0

    .line 864
    monitor-exit v18

    .line 915
    .end local v3    # "am":Landroid/app/ActivityManager;
    :goto_0
    return-void

    .line 866
    .restart local v3    # "am":Landroid/app/ActivityManager;
    :cond_0
    invoke-virtual {v3}, Landroid/app/ActivityManager;->getRunningAppProcesses()Ljava/util/List;

    move-result-object v14

    .line 867
    .local v14, "processes":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningAppProcessInfo;>;"
    if-nez v14, :cond_1

    .line 868
    monitor-exit v18

    goto :goto_0

    .line 914
    .end local v3    # "am":Landroid/app/ActivityManager;
    .end local v6    # "context":Landroid/content/Context;
    .end local v14    # "processes":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningAppProcessInfo;>;"
    :catchall_0
    move-exception v17

    monitor-exit v18
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v17

    .line 870
    .restart local v3    # "am":Landroid/app/ActivityManager;
    .restart local v6    # "context":Landroid/content/Context;
    .restart local v14    # "processes":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningAppProcessInfo;>;"
    :cond_1
    :try_start_1
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 871
    .local v2, "activePackages":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-interface {v14}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :cond_2
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v17

    if-eqz v17, :cond_3

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Landroid/app/ActivityManager$RunningAppProcessInfo;

    .line 872
    .local v10, "info":Landroid/app/ActivityManager$RunningAppProcessInfo;
    iget-object v4, v10, Landroid/app/ActivityManager$RunningAppProcessInfo;->pkgList:[Ljava/lang/String;

    .local v4, "arr$":[Ljava/lang/String;
    array-length v11, v4

    .local v11, "len$":I
    const/4 v9, 0x0

    .local v9, "i$":I
    :goto_1
    if-ge v9, v11, :cond_2

    aget-object v13, v4, v9

    .line 873
    .local v13, "pkg":Ljava/lang/String;
    invoke-interface {v2, v13}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 872
    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .line 877
    .end local v4    # "arr$":[Ljava/lang/String;
    .end local v9    # "i$":I
    .end local v10    # "info":Landroid/app/ActivityManager$RunningAppProcessInfo;
    .end local v11    # "len$":I
    .end local v13    # "pkg":Ljava/lang/String;
    :cond_3
    const-string v17, "phone"

    move-object/from16 v0, v17

    invoke-virtual {v6, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Landroid/telephony/TelephonyManager;

    .line 878
    .local v16, "tm":Landroid/telephony/TelephonyManager;
    invoke-virtual/range {v16 .. v16}, Landroid/telephony/TelephonyManager;->getCallState()I

    move-result v5

    .line 879
    .local v5, "callState":I
    if-eqz v5, :cond_4

    .line 880
    const-string v17, "phone"

    move-object/from16 v0, v17

    invoke-interface {v2, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 885
    :cond_4
    new-instance v15, Ljava/util/HashSet;

    invoke-direct {v15}, Ljava/util/HashSet;-><init>()V

    .line 886
    .local v15, "removeSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v17, v0

    # getter for: Lcom/lge/dockservice/DockWindowService;->mLowProfileRequests:Ljava/util/Set;
    invoke-static/range {v17 .. v17}, Lcom/lge/dockservice/DockWindowService;->access$1700(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Set;

    move-result-object v17

    move-object/from16 v0, v17

    invoke-interface {v15, v0}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    .line 888
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v17, v0

    # getter for: Lcom/lge/dockservice/DockWindowService;->mLowProfileRequests:Ljava/util/Set;
    invoke-static/range {v17 .. v17}, Lcom/lge/dockservice/DockWindowService;->access$1700(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Set;

    move-result-object v17

    invoke-interface/range {v17 .. v17}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v8

    .local v8, "i$":Ljava/util/Iterator;
    :cond_5
    :goto_2
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v17

    if-eqz v17, :cond_6

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    .line 889
    .local v12, "lpr":Ljava/lang/String;
    invoke-interface {v2, v12}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v17

    if-nez v17, :cond_5

    .line 890
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v17

    new-instance v19, Ljava/lang/StringBuilder;

    invoke-direct/range {v19 .. v19}, Ljava/lang/StringBuilder;-><init>()V

    const-string v20, "package "

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    const-string v20, " seems to died. removing it from mLowProfileRequests"

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    move-object/from16 v0, v17

    move-object/from16 v1, v19

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 891
    invoke-interface {v15, v12}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    goto :goto_2

    .line 894
    .end local v12    # "lpr":Ljava/lang/String;
    :cond_6
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v17, v0

    move-object/from16 v0, v17

    # setter for: Lcom/lge/dockservice/DockWindowService;->mLowProfileRequests:Ljava/util/Set;
    invoke-static {v0, v15}, Lcom/lge/dockservice/DockWindowService;->access$1702(Lcom/lge/dockservice/DockWindowService;Ljava/util/Set;)Ljava/util/Set;

    .line 897
    .end local v2    # "activePackages":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    .end local v3    # "am":Landroid/app/ActivityManager;
    .end local v5    # "callState":I
    .end local v8    # "i$":Ljava/util/Iterator;
    .end local v14    # "processes":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningAppProcessInfo;>;"
    .end local v15    # "removeSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    .end local v16    # "tm":Landroid/telephony/TelephonyManager;
    :cond_7
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v17, v0

    # getter for: Lcom/lge/dockservice/DockWindowService;->mLowProfileRequests:Ljava/util/Set;
    invoke-static/range {v17 .. v17}, Lcom/lge/dockservice/DockWindowService;->access$1700(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Set;

    move-result-object v17

    invoke-interface/range {v17 .. v17}, Ljava/util/Set;->isEmpty()Z

    move-result v17

    if-eqz v17, :cond_a

    .line 898
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v17, v0

    move-object/from16 v0, v17

    iget-boolean v0, v0, Lcom/lge/dockservice/DockWindowService;->mIsQuickCoverClosed:Z

    move/from16 v17, v0

    if-eqz v17, :cond_9

    .line 899
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v17

    const-string v19, "no low profile requester left.. But Quick cover closed. Do not apply Low Profile."

    move-object/from16 v0, v17

    move-object/from16 v1, v19

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 914
    :cond_8
    monitor-exit v18

    goto/16 :goto_0

    .line 902
    :cond_9
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v17

    const-string v19, "no low profile requester left.. exit low profile"

    move-object/from16 v0, v17

    move-object/from16 v1, v19

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 903
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v17, v0

    # getter for: Lcom/lge/dockservice/DockWindowService;->mDockViewList:Ljava/util/Map;
    invoke-static/range {v17 .. v17}, Lcom/lge/dockservice/DockWindowService;->access$100(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Map;

    move-result-object v17

    invoke-interface/range {v17 .. v17}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v17

    invoke-interface/range {v17 .. v17}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v8

    .restart local v8    # "i$":Ljava/util/Iterator;
    :goto_3
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v17

    if-eqz v17, :cond_8

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/lge/dockservice/DockWindowService$DockView;

    .line 904
    .local v7, "dv":Lcom/lge/dockservice/DockWindowService$DockView;
    const/16 v17, 0x0

    move/from16 v0, v17

    invoke-virtual {v7, v0}, Lcom/lge/dockservice/DockWindowService$DockView;->applyLowProfile(Z)V

    goto :goto_3

    .line 909
    .end local v7    # "dv":Lcom/lge/dockservice/DockWindowService$DockView;
    .end local v8    # "i$":Ljava/util/Iterator;
    :cond_a
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v17

    const-string/jumbo v19, "we have low profile requester yet.. re-enter low profile"

    move-object/from16 v0, v17

    move-object/from16 v1, v19

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 910
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$4;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v17, v0

    # getter for: Lcom/lge/dockservice/DockWindowService;->mDockViewList:Ljava/util/Map;
    invoke-static/range {v17 .. v17}, Lcom/lge/dockservice/DockWindowService;->access$100(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Map;

    move-result-object v17

    invoke-interface/range {v17 .. v17}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v17

    invoke-interface/range {v17 .. v17}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v8

    .restart local v8    # "i$":Ljava/util/Iterator;
    :goto_4
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v17

    if-eqz v17, :cond_8

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/lge/dockservice/DockWindowService$DockView;

    .line 911
    .restart local v7    # "dv":Lcom/lge/dockservice/DockWindowService$DockView;
    const/16 v17, 0x1

    move/from16 v0, v17

    invoke-virtual {v7, v0}, Lcom/lge/dockservice/DockWindowService$DockView;->applyLowProfile(Z)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_4
.end method
