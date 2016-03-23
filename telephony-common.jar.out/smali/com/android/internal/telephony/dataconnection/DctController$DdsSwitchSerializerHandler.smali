.class Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;
.super Landroid/os/Handler;
.source "DctController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/dataconnection/DctController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "DdsSwitchSerializerHandler"
.end annotation


# static fields
.field static final TAG:Ljava/lang/String; = "DdsSwitchSerializer"


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/dataconnection/DctController;


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/dataconnection/DctController;Landroid/os/Looper;)V
    .locals 0
    .param p2, "looper"    # Landroid/os/Looper;

    .prologue
    .line 745
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    .line 746
    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 747
    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 14
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 769
    iget v1, p1, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_0

    .line 819
    :goto_0
    return-void

    .line 771
    :pswitch_0
    const-string v1, "DdsSwitchSerializer"

    const-string v2, "EVENT_START_DDS_SWITCH"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 774
    :try_start_0
    monitor-enter p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 775
    :goto_1
    :try_start_1
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->mIsDdsSwitchCompleted:Z
    invoke-static {v1}, Lcom/android/internal/telephony/dataconnection/DctController;->access$900(Lcom/android/internal/telephony/dataconnection/DctController;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 776
    const-string v1, "DdsSwitchSerializer"

    const-string v2, "DDS switch in progress, wait"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 777
    invoke-virtual {p0}, Ljava/lang/Object;->wait()V

    goto :goto_1

    .line 782
    :catchall_0
    move-exception v1

    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v1
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 783
    :catch_0
    move-exception v7

    .line 784
    .local v7, "e":Ljava/lang/Exception;
    const-string v1, "DdsSwitchSerializer"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Exception while serializing the DDS switch request , e="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 780
    .end local v7    # "e":Ljava/lang/Exception;
    :cond_0
    :try_start_3
    const-string v1, "DdsSwitchSerializer"

    const-string v2, "Locked!"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 781
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    const/4 v2, 0x0

    # setter for: Lcom/android/internal/telephony/dataconnection/DctController;->mIsDdsSwitchCompleted:Z
    invoke-static {v1, v2}, Lcom/android/internal/telephony/dataconnection/DctController;->access$902(Lcom/android/internal/telephony/dataconnection/DctController;Z)Z

    .line 782
    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 789
    iget-object v3, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v3, Landroid/net/NetworkRequest;

    .line 791
    .local v3, "n":Landroid/net/NetworkRequest;
    const-string v1, "DdsSwitchSerializer"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "start the DDS switch for req "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 792
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->mSubController:Lcom/android/internal/telephony/SubscriptionController;
    invoke-static {v1}, Lcom/android/internal/telephony/dataconnection/DctController;->access$1000(Lcom/android/internal/telephony/dataconnection/DctController;)Lcom/android/internal/telephony/SubscriptionController;

    move-result-object v1

    invoke-virtual {v1, v3}, Lcom/android/internal/telephony/SubscriptionController;->getSubIdFromNetworkRequest(Landroid/net/NetworkRequest;)J

    move-result-wide v12

    .line 794
    .local v12, "subId":J
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->mSubController:Lcom/android/internal/telephony/SubscriptionController;
    invoke-static {v1}, Lcom/android/internal/telephony/dataconnection/DctController;->access$1000(Lcom/android/internal/telephony/dataconnection/DctController;)Lcom/android/internal/telephony/SubscriptionController;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/SubscriptionController;->getCurrentDds()J

    move-result-wide v4

    cmp-long v1, v12, v4

    if-nez v1, :cond_1

    .line 795
    const-string v1, "DdsSwitchSerializer"

    const-string v2, "No change in DDS, respond back"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 796
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    const/4 v2, 0x1

    # setter for: Lcom/android/internal/telephony/dataconnection/DctController;->mIsDdsSwitchCompleted:Z
    invoke-static {v1, v2}, Lcom/android/internal/telephony/dataconnection/DctController;->access$902(Lcom/android/internal/telephony/dataconnection/DctController;Z)Z

    .line 797
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->mNotifyOnDemandDataSwitchInfo:Landroid/os/RegistrantList;
    invoke-static {v1}, Lcom/android/internal/telephony/dataconnection/DctController;->access$1100(Lcom/android/internal/telephony/dataconnection/DctController;)Landroid/os/RegistrantList;

    move-result-object v1

    new-instance v2, Landroid/os/AsyncResult;

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-direct {v2, v4, v3, v5}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    invoke-virtual {v1, v2}, Landroid/os/RegistrantList;->notifyRegistrants(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    .line 801
    :cond_1
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->mSubController:Lcom/android/internal/telephony/SubscriptionController;
    invoke-static {v1}, Lcom/android/internal/telephony/dataconnection/DctController;->access$1000(Lcom/android/internal/telephony/dataconnection/DctController;)Lcom/android/internal/telephony/SubscriptionController;

    move-result-object v1

    invoke-virtual {v1, v12, v13}, Lcom/android/internal/telephony/SubscriptionController;->getPhoneId(J)I

    move-result v9

    .line 802
    .local v9, "phoneId":I
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->mSubController:Lcom/android/internal/telephony/SubscriptionController;
    invoke-static {v1}, Lcom/android/internal/telephony/dataconnection/DctController;->access$1000(Lcom/android/internal/telephony/dataconnection/DctController;)Lcom/android/internal/telephony/SubscriptionController;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->mSubController:Lcom/android/internal/telephony/SubscriptionController;
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DctController;->access$1000(Lcom/android/internal/telephony/dataconnection/DctController;)Lcom/android/internal/telephony/SubscriptionController;

    move-result-object v2

    invoke-virtual {v2}, Lcom/android/internal/telephony/SubscriptionController;->getCurrentDds()J

    move-result-wide v4

    invoke-virtual {v1, v4, v5}, Lcom/android/internal/telephony/SubscriptionController;->getPhoneId(J)I

    move-result v10

    .line 804
    .local v10, "prefPhoneId":I
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->mPhones:[Lcom/android/internal/telephony/PhoneProxy;
    invoke-static {v1}, Lcom/android/internal/telephony/dataconnection/DctController;->access$1200(Lcom/android/internal/telephony/dataconnection/DctController;)[Lcom/android/internal/telephony/PhoneProxy;

    move-result-object v1

    aget-object v1, v1, v10

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneProxy;->getActivePhone()Lcom/android/internal/telephony/Phone;

    move-result-object v8

    .local v8, "phone":Lcom/android/internal/telephony/Phone;
    move-object v1, v8

    .line 805
    check-cast v1, Lcom/android/internal/telephony/PhoneBase;

    iget-object v6, v1, Lcom/android/internal/telephony/PhoneBase;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    .line 806
    .local v6, "dcTracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {v6, v1, v2}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setDataAllowed(ZLandroid/os/Message;)V

    .line 807
    invoke-interface {v8}, Lcom/android/internal/telephony/Phone;->getPhoneType()I

    move-result v1

    const/4 v2, 0x2

    if-ne v1, v2, :cond_2

    .line 809
    const-string v1, "Ondemand DDS switch"

    invoke-virtual {v6, v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->cleanUpAllConnections(Ljava/lang/String;)V

    .line 811
    :cond_2
    new-instance v0, Lcom/android/internal/telephony/dataconnection/DctController$SwitchInfo;

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, v9}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-direct/range {v0 .. v5}, Lcom/android/internal/telephony/dataconnection/DctController$SwitchInfo;-><init>(Lcom/android/internal/telephony/dataconnection/DctController;ILandroid/net/NetworkRequest;ZZ)V

    .line 812
    .local v0, "s":Lcom/android/internal/telephony/dataconnection/DctController$SwitchInfo;
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->mPhones:[Lcom/android/internal/telephony/PhoneProxy;
    invoke-static {v1}, Lcom/android/internal/telephony/dataconnection/DctController;->access$1200(Lcom/android/internal/telephony/dataconnection/DctController;)[Lcom/android/internal/telephony/PhoneProxy;

    move-result-object v1

    aget-object v1, v1, v10

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->sDctController:Lcom/android/internal/telephony/dataconnection/DctController;
    invoke-static {}, Lcom/android/internal/telephony/dataconnection/DctController;->access$1300()Lcom/android/internal/telephony/dataconnection/DctController;

    move-result-object v2

    const/4 v4, 0x1

    invoke-virtual {v1, v2, v4, v0}, Lcom/android/internal/telephony/PhoneProxy;->registerForAllDataDisconnected(Landroid/os/Handler;ILjava/lang/Object;)V

    goto/16 :goto_0

    .line 769
    nop

    :pswitch_data_0
    .packed-switch 0x9
        :pswitch_0
    .end packed-switch
.end method

.method public isLocked()Z
    .locals 5

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 760
    monitor-enter p0

    .line 761
    :try_start_0
    const-string v3, "DdsSwitchSerializer"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "isLocked = "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->mIsDdsSwitchCompleted:Z
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DctController;->access$900(Lcom/android/internal/telephony/dataconnection/DctController;)Z

    move-result v2

    if-nez v2, :cond_0

    move v2, v0

    :goto_0
    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 762
    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    # getter for: Lcom/android/internal/telephony/dataconnection/DctController;->mIsDdsSwitchCompleted:Z
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DctController;->access$900(Lcom/android/internal/telephony/dataconnection/DctController;)Z

    move-result v2

    if-nez v2, :cond_1

    :goto_1
    monitor-exit p0

    return v0

    :cond_0
    move v2, v1

    .line 761
    goto :goto_0

    :cond_1
    move v0, v1

    .line 762
    goto :goto_1

    .line 763
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public unLock()V
    .locals 2

    .prologue
    .line 750
    const-string v0, "DdsSwitchSerializer"

    const-string v1, "unLock the DdsSwitchSerializer"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 751
    monitor-enter p0

    .line 752
    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/DctController$DdsSwitchSerializerHandler;->this$0:Lcom/android/internal/telephony/dataconnection/DctController;

    const/4 v1, 0x1

    # setter for: Lcom/android/internal/telephony/dataconnection/DctController;->mIsDdsSwitchCompleted:Z
    invoke-static {v0, v1}, Lcom/android/internal/telephony/dataconnection/DctController;->access$902(Lcom/android/internal/telephony/dataconnection/DctController;Z)Z

    .line 753
    const-string v0, "DdsSwitchSerializer"

    const-string v1, "unLocked the DdsSwitchSerializer"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 754
    invoke-virtual {p0}, Ljava/lang/Object;->notifyAll()V

    .line 755
    monitor-exit p0

    .line 757
    return-void

    .line 755
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method