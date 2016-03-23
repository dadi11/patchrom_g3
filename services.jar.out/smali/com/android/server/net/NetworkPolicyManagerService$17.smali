.class Lcom/android/server/net/NetworkPolicyManagerService$17;
.super Ljava/lang/Object;
.source "NetworkPolicyManagerService.java"

# interfaces
.implements Landroid/os/Handler$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/net/NetworkPolicyManagerService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/net/NetworkPolicyManagerService;


# direct methods
.method constructor <init>(Lcom/android/server/net/NetworkPolicyManagerService;)V
    .locals 0

    .prologue
    .line 2346
    iput-object p1, p0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)Z
    .locals 17
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 2349
    move-object/from16 v0, p1

    iget v14, v0, Landroid/os/Message;->what:I

    packed-switch v14, :pswitch_data_0

    .line 2442
    :pswitch_0
    const/4 v14, 0x0

    :goto_0
    return v14

    .line 2351
    :pswitch_1
    move-object/from16 v0, p1

    iget v12, v0, Landroid/os/Message;->arg1:I

    .line 2352
    .local v12, "uid":I
    move-object/from16 v0, p1

    iget v13, v0, Landroid/os/Message;->arg2:I

    .line 2353
    .local v13, "uidRules":I
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mListeners:Landroid/os/RemoteCallbackList;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$700(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/os/RemoteCallbackList;

    move-result-object v14

    invoke-virtual {v14}, Landroid/os/RemoteCallbackList;->beginBroadcast()I

    move-result v4

    .line 2354
    .local v4, "length":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    if-ge v2, v4, :cond_1

    .line 2355
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mListeners:Landroid/os/RemoteCallbackList;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$700(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/os/RemoteCallbackList;

    move-result-object v14

    invoke-virtual {v14, v2}, Landroid/os/RemoteCallbackList;->getBroadcastItem(I)Landroid/os/IInterface;

    move-result-object v5

    check-cast v5, Landroid/net/INetworkPolicyListener;

    .line 2356
    .local v5, "listener":Landroid/net/INetworkPolicyListener;
    if-eqz v5, :cond_0

    .line 2358
    :try_start_0
    invoke-interface {v5, v12, v13}, Landroid/net/INetworkPolicyListener;->onUidRulesChanged(II)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2354
    :cond_0
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 2363
    .end local v5    # "listener":Landroid/net/INetworkPolicyListener;
    :cond_1
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mListeners:Landroid/os/RemoteCallbackList;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$700(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/os/RemoteCallbackList;

    move-result-object v14

    invoke-virtual {v14}, Landroid/os/RemoteCallbackList;->finishBroadcast()V

    .line 2364
    const/4 v14, 0x1

    goto :goto_0

    .line 2367
    .end local v2    # "i":I
    .end local v4    # "length":I
    .end local v12    # "uid":I
    .end local v13    # "uidRules":I
    :pswitch_2
    move-object/from16 v0, p1

    iget-object v14, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v14, [Ljava/lang/String;

    move-object v8, v14

    check-cast v8, [Ljava/lang/String;

    .line 2368
    .local v8, "meteredIfaces":[Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mListeners:Landroid/os/RemoteCallbackList;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$700(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/os/RemoteCallbackList;

    move-result-object v14

    invoke-virtual {v14}, Landroid/os/RemoteCallbackList;->beginBroadcast()I

    move-result v4

    .line 2369
    .restart local v4    # "length":I
    const/4 v2, 0x0

    .restart local v2    # "i":I
    :goto_3
    if-ge v2, v4, :cond_3

    .line 2370
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mListeners:Landroid/os/RemoteCallbackList;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$700(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/os/RemoteCallbackList;

    move-result-object v14

    invoke-virtual {v14, v2}, Landroid/os/RemoteCallbackList;->getBroadcastItem(I)Landroid/os/IInterface;

    move-result-object v5

    check-cast v5, Landroid/net/INetworkPolicyListener;

    .line 2371
    .restart local v5    # "listener":Landroid/net/INetworkPolicyListener;
    if-eqz v5, :cond_2

    .line 2373
    :try_start_1
    invoke-interface {v5, v8}, Landroid/net/INetworkPolicyListener;->onMeteredIfacesChanged([Ljava/lang/String;)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    .line 2369
    :cond_2
    :goto_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    .line 2378
    .end local v5    # "listener":Landroid/net/INetworkPolicyListener;
    :cond_3
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mListeners:Landroid/os/RemoteCallbackList;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$700(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/os/RemoteCallbackList;

    move-result-object v14

    invoke-virtual {v14}, Landroid/os/RemoteCallbackList;->finishBroadcast()V

    .line 2379
    const/4 v14, 0x1

    goto :goto_0

    .line 2382
    .end local v2    # "i":I
    .end local v4    # "length":I
    .end local v8    # "meteredIfaces":[Ljava/lang/String;
    :pswitch_3
    move-object/from16 v0, p1

    iget-object v3, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    .line 2384
    .local v3, "iface":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    invoke-virtual {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->maybeRefreshTrustedTime()V

    .line 2385
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    iget-object v15, v14, Lcom/android/server/net/NetworkPolicyManagerService;->mRulesLock:Ljava/lang/Object;

    monitor-enter v15

    .line 2386
    :try_start_2
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mMeteredIfaces:Landroid/util/ArraySet;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$800(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/util/ArraySet;

    move-result-object v14

    invoke-virtual {v14, v3}, Landroid/util/ArraySet;->contains(Ljava/lang/Object;)Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result v14

    if-eqz v14, :cond_5

    .line 2390
    :try_start_3
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mNetworkStats:Landroid/net/INetworkStatsService;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$900(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/net/INetworkStatsService;

    move-result-object v14

    invoke-interface {v14}, Landroid/net/INetworkStatsService;->forceUpdate()V
    :try_end_3
    .catch Landroid/os/RemoteException; {:try_start_3 .. :try_end_3} :catch_4
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 2396
    :goto_5
    :try_start_4
    sget-object v14, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATAUSAGE_LIMIT_EXCEED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v14}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v14

    if-eqz v14, :cond_6

    .line 2397
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    const/16 v16, 0x1

    move/from16 v0, v16

    invoke-virtual {v14, v0}, Lcom/android/server/net/NetworkPolicyManagerService;->updateNetworkEnabledLocked(Z)Z

    move-result v14

    if-eqz v14, :cond_4

    .line 2398
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    invoke-virtual {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->updateNetworkRulesLocked()V

    .line 2405
    :cond_4
    :goto_6
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    invoke-virtual {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->updateNotificationsLocked()V

    .line 2407
    :cond_5
    monitor-exit v15

    .line 2408
    const/4 v14, 0x1

    goto/16 :goto_0

    .line 2401
    :cond_6
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    invoke-virtual {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->updateNetworkEnabledLocked()V

    goto :goto_6

    .line 2407
    :catchall_0
    move-exception v14

    monitor-exit v15
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v14

    .line 2411
    .end local v3    # "iface":Ljava/lang/String;
    :pswitch_4
    move-object/from16 v0, p1

    iget v14, v0, Landroid/os/Message;->arg1:I

    if-eqz v14, :cond_8

    const/4 v9, 0x1

    .line 2412
    .local v9, "restrictBackground":Z
    :goto_7
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mListeners:Landroid/os/RemoteCallbackList;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$700(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/os/RemoteCallbackList;

    move-result-object v14

    invoke-virtual {v14}, Landroid/os/RemoteCallbackList;->beginBroadcast()I

    move-result v4

    .line 2413
    .restart local v4    # "length":I
    const/4 v2, 0x0

    .restart local v2    # "i":I
    :goto_8
    if-ge v2, v4, :cond_9

    .line 2414
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mListeners:Landroid/os/RemoteCallbackList;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$700(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/os/RemoteCallbackList;

    move-result-object v14

    invoke-virtual {v14, v2}, Landroid/os/RemoteCallbackList;->getBroadcastItem(I)Landroid/os/IInterface;

    move-result-object v5

    check-cast v5, Landroid/net/INetworkPolicyListener;

    .line 2415
    .restart local v5    # "listener":Landroid/net/INetworkPolicyListener;
    if-eqz v5, :cond_7

    .line 2417
    :try_start_5
    invoke-interface {v5, v9}, Landroid/net/INetworkPolicyListener;->onRestrictBackgroundChanged(Z)V
    :try_end_5
    .catch Landroid/os/RemoteException; {:try_start_5 .. :try_end_5} :catch_2

    .line 2413
    :cond_7
    :goto_9
    add-int/lit8 v2, v2, 0x1

    goto :goto_8

    .line 2411
    .end local v2    # "i":I
    .end local v4    # "length":I
    .end local v5    # "listener":Landroid/net/INetworkPolicyListener;
    .end local v9    # "restrictBackground":Z
    :cond_8
    const/4 v9, 0x0

    goto :goto_7

    .line 2422
    .restart local v2    # "i":I
    .restart local v4    # "length":I
    .restart local v9    # "restrictBackground":Z
    :cond_9
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mListeners:Landroid/os/RemoteCallbackList;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$700(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/os/RemoteCallbackList;

    move-result-object v14

    invoke-virtual {v14}, Landroid/os/RemoteCallbackList;->finishBroadcast()V

    .line 2423
    const/4 v14, 0x1

    goto/16 :goto_0

    .line 2426
    .end local v2    # "i":I
    .end local v4    # "length":I
    .end local v9    # "restrictBackground":Z
    :pswitch_5
    move-object/from16 v0, p1

    iget-object v14, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v14, Ljava/lang/Long;

    invoke-virtual {v14}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    .line 2430
    .local v6, "lowestRule":J
    const-wide/16 v14, 0x3e8

    :try_start_6
    div-long v10, v6, v14

    .line 2431
    .local v10, "persistThreshold":J
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # getter for: Lcom/android/server/net/NetworkPolicyManagerService;->mNetworkStats:Landroid/net/INetworkStatsService;
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$900(Lcom/android/server/net/NetworkPolicyManagerService;)Landroid/net/INetworkStatsService;

    move-result-object v14

    invoke-interface {v14, v10, v11}, Landroid/net/INetworkStatsService;->advisePersistThreshold(J)V
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_6 .. :try_end_6} :catch_3

    .line 2435
    .end local v10    # "persistThreshold":J
    :goto_a
    const/4 v14, 0x1

    goto/16 :goto_0

    .line 2438
    .end local v6    # "lowestRule":J
    :pswitch_6
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/server/net/NetworkPolicyManagerService$17;->this$0:Lcom/android/server/net/NetworkPolicyManagerService;

    # invokes: Lcom/android/server/net/NetworkPolicyManagerService;->updateScreenOn()V
    invoke-static {v14}, Lcom/android/server/net/NetworkPolicyManagerService;->access$1000(Lcom/android/server/net/NetworkPolicyManagerService;)V

    .line 2439
    const/4 v14, 0x1

    goto/16 :goto_0

    .line 2359
    .restart local v2    # "i":I
    .restart local v4    # "length":I
    .restart local v5    # "listener":Landroid/net/INetworkPolicyListener;
    .restart local v12    # "uid":I
    .restart local v13    # "uidRules":I
    :catch_0
    move-exception v14

    goto/16 :goto_2

    .line 2374
    .end local v12    # "uid":I
    .end local v13    # "uidRules":I
    .restart local v8    # "meteredIfaces":[Ljava/lang/String;
    :catch_1
    move-exception v14

    goto/16 :goto_4

    .line 2418
    .end local v8    # "meteredIfaces":[Ljava/lang/String;
    .restart local v9    # "restrictBackground":Z
    :catch_2
    move-exception v14

    goto :goto_9

    .line 2432
    .end local v2    # "i":I
    .end local v4    # "length":I
    .end local v5    # "listener":Landroid/net/INetworkPolicyListener;
    .end local v9    # "restrictBackground":Z
    .restart local v6    # "lowestRule":J
    :catch_3
    move-exception v14

    goto :goto_a

    .line 2391
    .end local v6    # "lowestRule":J
    .restart local v3    # "iface":Ljava/lang/String;
    :catch_4
    move-exception v14

    goto/16 :goto_5

    .line 2349
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
    .end packed-switch
.end method
