.class Lcom/lge/dockservice/DockWindowService$ClientWatcherThread;
.super Ljava/lang/Thread;
.source "DockWindowService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/dockservice/DockWindowService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ClientWatcherThread"
.end annotation


# instance fields
.field private stopWatching:Z

.field final synthetic this$0:Lcom/lge/dockservice/DockWindowService;


# direct methods
.method private constructor <init>(Lcom/lge/dockservice/DockWindowService;)V
    .locals 1

    .prologue
    .line 91
    iput-object p1, p0, Lcom/lge/dockservice/DockWindowService$ClientWatcherThread;->this$0:Lcom/lge/dockservice/DockWindowService;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 92
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/dockservice/DockWindowService$ClientWatcherThread;->stopWatching:Z

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/dockservice/DockWindowService;Lcom/lge/dockservice/DockWindowService$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/dockservice/DockWindowService;
    .param p2, "x1"    # Lcom/lge/dockservice/DockWindowService$1;

    .prologue
    .line 91
    invoke-direct {p0, p1}, Lcom/lge/dockservice/DockWindowService$ClientWatcherThread;-><init>(Lcom/lge/dockservice/DockWindowService;)V

    return-void
.end method


# virtual methods
.method public declared-synchronized requestStop()V
    .locals 1

    .prologue
    .line 185
    monitor-enter p0

    const/4 v0, 0x1

    :try_start_0
    iput-boolean v0, p0, Lcom/lge/dockservice/DockWindowService$ClientWatcherThread;->stopWatching:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 186
    monitor-exit p0

    return-void

    .line 185
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public run()V
    .locals 23

    .prologue
    .line 96
    :cond_0
    :goto_0
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/lge/dockservice/DockWindowService$ClientWatcherThread;->stopWatching:Z

    move/from16 v20, v0

    if-nez v20, :cond_d

    .line 98
    new-instance v12, Ljava/util/ArrayList;

    invoke-direct {v12}, Ljava/util/ArrayList;-><init>()V

    .line 99
    .local v12, "runningAppList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$ClientWatcherThread;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v20, v0

    const-string v21, "activity"

    invoke-virtual/range {v20 .. v21}, Lcom/lge/dockservice/DockWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/ActivityManager;

    .line 101
    .local v2, "am":Landroid/app/ActivityManager;
    if-eqz v2, :cond_0

    .line 105
    invoke-virtual {v2}, Landroid/app/ActivityManager;->getRunningAppProcesses()Ljava/util/List;

    move-result-object v11

    .line 107
    .local v11, "processes":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningAppProcessInfo;>;"
    const/16 v20, 0x64

    move/from16 v0, v20

    invoke-virtual {v2, v0}, Landroid/app/ActivityManager;->getRunningTasks(I)Ljava/util/List;

    move-result-object v18

    .line 109
    .local v18, "tasks":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningTaskInfo;>;"
    if-eqz v11, :cond_1

    if-nez v18, :cond_2

    .line 110
    :cond_1
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v20

    const-string v21, "Cannot get  RunningAppProcessInfo or RunningTaskInfo."

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 114
    :cond_2
    invoke-interface {v11}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    .local v5, "i$":Ljava/util/Iterator;
    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v20

    if-eqz v20, :cond_3

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Landroid/app/ActivityManager$RunningAppProcessInfo;

    .line 115
    .local v10, "pid":Landroid/app/ActivityManager$RunningAppProcessInfo;
    iget-object v0, v10, Landroid/app/ActivityManager$RunningAppProcessInfo;->processName:Ljava/lang/String;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    invoke-interface {v12, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 119
    .end local v10    # "pid":Landroid/app/ActivityManager$RunningAppProcessInfo;
    :cond_3
    invoke-interface/range {v18 .. v18}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_2
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v20

    if-eqz v20, :cond_5

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v17

    check-cast v17, Landroid/app/ActivityManager$RunningTaskInfo;

    .line 120
    .local v17, "taskInfo":Landroid/app/ActivityManager$RunningTaskInfo;
    move-object/from16 v0, v17

    iget-object v0, v0, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    move-object/from16 v20, v0

    if-eqz v20, :cond_4

    .line 122
    move-object/from16 v0, v17

    iget-object v0, v0, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    move-object/from16 v20, v0

    invoke-virtual/range {v20 .. v20}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v20

    move-object/from16 v0, v20

    invoke-interface {v12, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 124
    move-object/from16 v0, v17

    iget-object v0, v0, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    move-object/from16 v20, v0

    invoke-virtual/range {v20 .. v20}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v20

    move-object/from16 v0, v20

    invoke-interface {v12, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 127
    :cond_4
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v20

    const-string v21, "Exception : taskInfo.topActivity == null"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .line 132
    .end local v17    # "taskInfo":Landroid/app/ActivityManager$RunningTaskInfo;
    :cond_5
    new-instance v9, Ljava/util/ArrayList;

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    .line 135
    .local v9, "orphanList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$ClientWatcherThread;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/dockservice/DockWindowService;->mDockViewList:Ljava/util/Map;
    invoke-static/range {v20 .. v20}, Lcom/lge/dockservice/DockWindowService;->access$100(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Map;

    move-result-object v19

    .line 137
    .local v19, "tempDockViewList":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/lge/dockservice/DockWindowService$DockView;>;"
    invoke-interface/range {v19 .. v19}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v20

    invoke-interface/range {v20 .. v20}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    .end local v5    # "i$":Ljava/util/Iterator;
    :cond_6
    :goto_3
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v20

    if-eqz v20, :cond_9

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 138
    .local v3, "clientName":Ljava/lang/String;
    const/4 v7, 0x1

    .line 139
    .local v7, "i_am_orphan":Z
    invoke-interface {v12}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    .local v6, "i$":Ljava/util/Iterator;
    :cond_7
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v20

    if-eqz v20, :cond_8

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    .line 140
    .local v15, "taskActivityName":Ljava/lang/String;
    invoke-virtual {v3, v15}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v20

    if-eqz v20, :cond_7

    .line 141
    const/4 v7, 0x0

    .line 145
    .end local v15    # "taskActivityName":Ljava/lang/String;
    :cond_8
    if-eqz v7, :cond_6

    .line 146
    invoke-virtual {v9, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 149
    .end local v3    # "clientName":Ljava/lang/String;
    .end local v6    # "i$":Ljava/util/Iterator;
    .end local v7    # "i_am_orphan":Z
    :cond_9
    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    move-result v20

    if-eqz v20, :cond_c

    .line 152
    invoke-virtual {v9}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_a
    :goto_4
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v20

    if-eqz v20, :cond_c

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .line 153
    .local v8, "orphanClientName":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/dockservice/DockWindowService$ClientWatcherThread;->this$0:Lcom/lge/dockservice/DockWindowService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/dockservice/DockWindowService;->mDockViewList:Ljava/util/Map;
    invoke-static/range {v20 .. v20}, Lcom/lge/dockservice/DockWindowService;->access$100(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Map;

    move-result-object v20

    move-object/from16 v0, v20

    invoke-interface {v0, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Lcom/lge/dockservice/DockWindowService$DockView;

    .line 154
    .local v14, "targetView":Lcom/lge/dockservice/DockWindowService$DockView;
    if-eqz v14, :cond_a

    .line 155
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v20

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "ClientWatcher found that "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, " is lost in running process list.. "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "remove it from dock view list accordingly."

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 159
    const/16 v16, 0x0

    .line 161
    .local v16, "taskCount":I
    const/16 v20, 0x64

    move/from16 v0, v20

    invoke-virtual {v2, v0}, Landroid/app/ActivityManager;->getRunningTasks(I)Ljava/util/List;

    move-result-object v13

    .line 162
    .local v13, "runningTasks":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningTaskInfo;>;"
    if-eqz v13, :cond_b

    .line 163
    invoke-interface {v13}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    .restart local v6    # "i$":Ljava/util/Iterator;
    :goto_5
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v20

    if-eqz v20, :cond_b

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v17

    check-cast v17, Landroid/app/ActivityManager$RunningTaskInfo;

    .line 164
    .restart local v17    # "taskInfo":Landroid/app/ActivityManager$RunningTaskInfo;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v20

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "#"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, ": taskInfo.baseActivity = "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v17

    iget-object v0, v0, Landroid/app/ActivityManager$RunningTaskInfo;->baseActivity:Landroid/content/ComponentName;

    move-object/from16 v22, v0

    invoke-virtual/range {v22 .. v22}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "/"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v17

    iget-object v0, v0, Landroid/app/ActivityManager$RunningTaskInfo;->baseActivity:Landroid/content/ComponentName;

    move-object/from16 v22, v0

    invoke-virtual/range {v22 .. v22}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 166
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v20

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "#"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, ": taskInfo.topActivity = "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v17

    iget-object v0, v0, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    move-object/from16 v22, v0

    invoke-virtual/range {v22 .. v22}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "/"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v17

    iget-object v0, v0, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    move-object/from16 v22, v0

    invoke-virtual/range {v22 .. v22}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 168
    add-int/lit8 v16, v16, 0x1

    .line 169
    goto/16 :goto_5

    .line 171
    .end local v6    # "i$":Ljava/util/Iterator;
    .end local v17    # "taskInfo":Landroid/app/ActivityManager$RunningTaskInfo;
    :cond_b
    invoke-virtual {v14}, Lcom/lge/dockservice/DockWindowService$DockView;->killdock()V

    goto/16 :goto_4

    .line 177
    .end local v8    # "orphanClientName":Ljava/lang/String;
    .end local v13    # "runningTasks":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningTaskInfo;>;"
    .end local v14    # "targetView":Lcom/lge/dockservice/DockWindowService$DockView;
    .end local v16    # "taskCount":I
    :cond_c
    const-wide/16 v20, 0x5dc

    :try_start_0
    invoke-static/range {v20 .. v21}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 178
    :catch_0
    move-exception v4

    .line 179
    .local v4, "e":Ljava/lang/InterruptedException;
    invoke-virtual {v4}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto/16 :goto_0

    .line 182
    .end local v2    # "am":Landroid/app/ActivityManager;
    .end local v4    # "e":Ljava/lang/InterruptedException;
    .end local v9    # "orphanList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v11    # "processes":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningAppProcessInfo;>;"
    .end local v12    # "runningAppList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .end local v18    # "tasks":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningTaskInfo;>;"
    .end local v19    # "tempDockViewList":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/lge/dockservice/DockWindowService$DockView;>;"
    :cond_d
    return-void
.end method
