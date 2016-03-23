.class public Lcom/android/server/ePDGNotifier;
.super Ljava/lang/Object;
.source "ePDGNotifier.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/ePDGNotifier$1;,
        Lcom/android/server/ePDGNotifier$eRecord;
    }
.end annotation


# static fields
.field static final LOG_TAG:Ljava/lang/String; = "ePDGNotifier"


# instance fields
.field private mContext:Landroid/content/Context;

.field private final mRecords:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/server/ePDGNotifier$eRecord;",
            ">;"
        }
    .end annotation
.end field

.field protected mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

.field private final mRemoveList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/os/IBinder;",
            ">;"
        }
    .end annotation
.end field

.field private mePDGTracker:Lcom/android/server/ePDGTracker;

.field public myfeature:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/android/server/ePDGTracker;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "tracker"    # Lcom/android/server/ePDGTracker;

    .prologue
    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/server/ePDGNotifier;->mRemoveList:Ljava/util/ArrayList;

    .line 46
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    .line 54
    const/4 v0, 0x0

    iput v0, p0, Lcom/android/server/ePDGNotifier;->myfeature:I

    .line 72
    iput-object p1, p0, Lcom/android/server/ePDGNotifier;->mContext:Landroid/content/Context;

    .line 73
    iput-object p2, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    .line 74
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    move-result-object v0

    iget v0, v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    iput v0, p0, Lcom/android/server/ePDGNotifier;->myfeature:I

    .line 76
    const-string v0, "telephony.registry"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/ITelephonyRegistry$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephonyRegistry;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/ePDGNotifier;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    .line 80
    return-void
.end method

.method public static convertPDNState(I)I
    .locals 1
    .param p0, "state"    # I

    .prologue
    .line 583
    packed-switch p0, :pswitch_data_0

    .line 591
    :pswitch_0
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 585
    :pswitch_1
    const/4 v0, 0x1

    goto :goto_0

    .line 589
    :pswitch_2
    const/4 v0, 0x2

    goto :goto_0

    .line 583
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_2
    .end packed-switch
.end method

.method private handleRemoveListLocked()V
    .locals 3

    .prologue
    .line 203
    iget-object v2, p0, Lcom/android/server/ePDGNotifier;->mRemoveList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lez v2, :cond_1

    .line 204
    iget-object v2, p0, Lcom/android/server/ePDGNotifier;->mRemoveList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/IBinder;

    .line 205
    .local v0, "b":Landroid/os/IBinder;
    invoke-direct {p0, v0}, Lcom/android/server/ePDGNotifier;->remove(Landroid/os/IBinder;)V

    goto :goto_0

    .line 207
    .end local v0    # "b":Landroid/os/IBinder;
    :cond_0
    iget-object v2, p0, Lcom/android/server/ePDGNotifier;->mRemoveList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->clear()V

    .line 209
    .end local v1    # "i$":Ljava/util/Iterator;
    :cond_1
    return-void
.end method

.method private remove(Landroid/os/IBinder;)V
    .locals 4
    .param p1, "binder"    # Landroid/os/IBinder;

    .prologue
    .line 190
    iget-object v3, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    monitor-enter v3

    .line 191
    :try_start_0
    iget-object v2, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v1

    .line 192
    .local v1, "recordCount":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v1, :cond_1

    .line 193
    iget-object v2, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/ePDGNotifier$eRecord;

    iget-object v2, v2, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    if-ne v2, p1, :cond_0

    .line 194
    iget-object v2, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 195
    monitor-exit v3

    .line 199
    :goto_1
    return-void

    .line 192
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 198
    :cond_1
    monitor-exit v3

    goto :goto_1

    .end local v0    # "i":I
    .end local v1    # "recordCount":I
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2
.end method


# virtual methods
.method public ePDGlisten(Landroid/net/IePDGStateListener;I)V
    .locals 13
    .param p1, "callback"    # Landroid/net/IePDGStateListener;
    .param p2, "events"    # I

    .prologue
    .line 86
    if-eqz p2, :cond_7

    .line 88
    iget-object v10, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    monitor-enter v10

    .line 90
    const/4 v6, 0x0

    .line 92
    .local v6, "r":Lcom/android/server/ePDGNotifier$eRecord;
    :try_start_0
    invoke-interface {p1}, Landroid/net/IePDGStateListener;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    .line 93
    .local v1, "b":Landroid/os/IBinder;
    iget-object v9, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    .line 94
    .local v0, "N":I
    const/4 v3, 0x0

    .local v3, "i":I
    move-object v7, v6

    .end local v6    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    .local v7, "r":Lcom/android/server/ePDGNotifier$eRecord;
    :goto_0
    if-ge v3, v0, :cond_6

    .line 95
    :try_start_1
    iget-object v9, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v9, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/android/server/ePDGNotifier$eRecord;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 96
    .end local v7    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    .restart local v6    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    :try_start_2
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    if-ne v1, v9, :cond_5

    .line 106
    :goto_1
    iget v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->events:I

    xor-int/2addr v9, p2

    and-int v8, p2, v9

    .line 107
    .local v8, "send":I
    iput p2, v6, Lcom/android/server/ePDGNotifier$eRecord;->events:I

    .line 109
    and-int/lit8 v9, p2, 0x1

    if-eqz v9, :cond_0

    .line 110
    const/4 v9, 0x2

    new-array v5, v9, [I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 112
    .local v5, "mystate":[I
    const/4 v9, 0x0

    const/4 v11, 0x0

    :try_start_3
    aput v11, v5, v9

    .line 113
    const/4 v9, 0x1

    iget-object v11, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v11, v11, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v12, 0x0

    aget v11, v11, v12

    aput v11, v5, v9

    .line 114
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    invoke-interface {v9, v5}, Landroid/net/IePDGStateListener;->onPDPStateChanged([I)V

    .line 115
    const/4 v9, 0x0

    const/4 v11, 0x1

    aput v11, v5, v9

    .line 116
    const/4 v9, 0x1

    iget-object v11, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v11, v11, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v12, 0x1

    aget v11, v11, v12

    aput v11, v5, v9

    .line 117
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    invoke-interface {v9, v5}, Landroid/net/IePDGStateListener;->onPDPStateChanged([I)V
    :try_end_3
    .catch Landroid/os/RemoteException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 134
    .end local v5    # "mystate":[I
    :cond_0
    :goto_2
    and-int/lit8 v9, p2, 0x4

    if-eqz v9, :cond_1

    .line 136
    :try_start_4
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    iget-object v11, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-boolean v11, v11, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    invoke-interface {v9, v11}, Landroid/net/IePDGStateListener;->onWiFiStatusChanged(Z)V
    :try_end_4
    .catch Landroid/os/RemoteException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 141
    :cond_1
    :goto_3
    and-int/lit8 v9, p2, 0x8

    if-eqz v9, :cond_2

    .line 142
    :try_start_5
    iget-object v9, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v9, v9, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    const/4 v11, 0x0

    aget v9, v9, v11
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    if-eqz v9, :cond_2

    .line 145
    :try_start_6
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    iget-object v11, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v11, v11, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    const/4 v12, 0x0

    aget v11, v11, v12

    invoke-interface {v9, v11}, Landroid/net/IePDGStateListener;->onErrorStatusChanged(I)V
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_6 .. :try_end_6} :catch_2
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 152
    :cond_2
    :goto_4
    and-int/lit8 v9, p2, 0x20

    if-eqz v9, :cond_3

    .line 153
    :try_start_7
    iget-object v9, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v9, v9, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    const/4 v11, 0x0

    aget v9, v9, v11
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    if-eqz v9, :cond_3

    .line 156
    :try_start_8
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    iget-object v11, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v11, v11, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    const/4 v12, 0x1

    aget v11, v11, v12

    invoke-interface {v9, v11}, Landroid/net/IePDGStateListener;->onCBSErrorStatusChanged(I)V
    :try_end_8
    .catch Landroid/os/RemoteException; {:try_start_8 .. :try_end_8} :catch_3
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 163
    :cond_3
    :goto_5
    and-int/lit8 v9, p2, 0x10

    if-eqz v9, :cond_4

    .line 165
    const/4 v9, 0x7

    :try_start_9
    new-array v4, v9, [Ljava/lang/String;

    .line 167
    .local v4, "myinfo":[Ljava/lang/String;
    const/4 v9, 0x0

    const/4 v11, 0x0

    aput-object v11, v4, v9

    .line 168
    const/4 v9, 0x1

    iget-object v11, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v11, v11, Lcom/android/server/ePDGTracker;->identity:Ljava/lang/String;

    aput-object v11, v4, v9

    .line 169
    const/4 v9, 0x2

    iget-object v11, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v11, v11, Lcom/android/server/ePDGTracker;->FQDNForEPDG:Ljava/lang/String;

    aput-object v11, v4, v9

    .line 170
    const/4 v9, 0x3

    iget-object v11, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v11, v11, Lcom/android/server/ePDGTracker;->ePDGAddrofThisnetwork:Ljava/lang/String;

    aput-object v11, v4, v9

    .line 171
    const/4 v9, 0x4

    const/4 v11, 0x0

    aput-object v11, v4, v9

    .line 172
    const/4 v9, 0x5

    const/4 v11, 0x0

    aput-object v11, v4, v9

    .line 173
    const/4 v9, 0x6

    const/4 v11, 0x0

    aput-object v11, v4, v9
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    .line 175
    :try_start_a
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    invoke-interface {v9, v4}, Landroid/net/IePDGStateListener;->onConnectionParamStatus([Ljava/lang/String;)V
    :try_end_a
    .catch Landroid/os/RemoteException; {:try_start_a .. :try_end_a} :catch_4
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    .line 180
    .end local v4    # "myinfo":[Ljava/lang/String;
    :cond_4
    :goto_6
    :try_start_b
    monitor-exit v10
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    .line 186
    .end local v0    # "N":I
    .end local v1    # "b":Landroid/os/IBinder;
    .end local v3    # "i":I
    .end local v6    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    .end local v8    # "send":I
    :goto_7
    return-void

    .line 94
    .restart local v0    # "N":I
    .restart local v1    # "b":Landroid/os/IBinder;
    .restart local v3    # "i":I
    .restart local v6    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    :cond_5
    add-int/lit8 v3, v3, 0x1

    move-object v7, v6

    .end local v6    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    .restart local v7    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    goto/16 :goto_0

    .line 100
    :cond_6
    :try_start_c
    new-instance v6, Lcom/android/server/ePDGNotifier$eRecord;

    const/4 v9, 0x0

    invoke-direct {v6, v9}, Lcom/android/server/ePDGNotifier$eRecord;-><init>(Lcom/android/server/ePDGNotifier$1;)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_1

    .line 101
    .end local v7    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    .restart local v6    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    :try_start_d
    iput-object v1, v6, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    .line 102
    iput-object p1, v6, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    .line 104
    iget-object v9, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v9, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_1

    .line 180
    .end local v0    # "N":I
    .end local v1    # "b":Landroid/os/IBinder;
    .end local v3    # "i":I
    :catchall_0
    move-exception v9

    :goto_8
    monitor-exit v10
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_0

    throw v9

    .line 129
    .restart local v0    # "N":I
    .restart local v1    # "b":Landroid/os/IBinder;
    .restart local v3    # "i":I
    .restart local v5    # "mystate":[I
    .restart local v8    # "send":I
    :catch_0
    move-exception v2

    .line 130
    .local v2, "ex":Landroid/os/RemoteException;
    :try_start_e
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    invoke-direct {p0, v9}, Lcom/android/server/ePDGNotifier;->remove(Landroid/os/IBinder;)V

    goto/16 :goto_2

    .line 137
    .end local v2    # "ex":Landroid/os/RemoteException;
    .end local v5    # "mystate":[I
    :catch_1
    move-exception v2

    .line 138
    .restart local v2    # "ex":Landroid/os/RemoteException;
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    invoke-direct {p0, v9}, Lcom/android/server/ePDGNotifier;->remove(Landroid/os/IBinder;)V

    goto/16 :goto_3

    .line 146
    .end local v2    # "ex":Landroid/os/RemoteException;
    :catch_2
    move-exception v2

    .line 147
    .restart local v2    # "ex":Landroid/os/RemoteException;
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    invoke-direct {p0, v9}, Lcom/android/server/ePDGNotifier;->remove(Landroid/os/IBinder;)V

    goto :goto_4

    .line 157
    .end local v2    # "ex":Landroid/os/RemoteException;
    :catch_3
    move-exception v2

    .line 158
    .restart local v2    # "ex":Landroid/os/RemoteException;
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    invoke-direct {p0, v9}, Lcom/android/server/ePDGNotifier;->remove(Landroid/os/IBinder;)V

    goto :goto_5

    .line 176
    .end local v2    # "ex":Landroid/os/RemoteException;
    .restart local v4    # "myinfo":[Ljava/lang/String;
    :catch_4
    move-exception v2

    .line 177
    .restart local v2    # "ex":Landroid/os/RemoteException;
    iget-object v9, v6, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    invoke-direct {p0, v9}, Lcom/android/server/ePDGNotifier;->remove(Landroid/os/IBinder;)V
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_0

    goto :goto_6

    .line 183
    .end local v0    # "N":I
    .end local v1    # "b":Landroid/os/IBinder;
    .end local v2    # "ex":Landroid/os/RemoteException;
    .end local v3    # "i":I
    .end local v4    # "myinfo":[Ljava/lang/String;
    .end local v6    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    .end local v8    # "send":I
    :cond_7
    invoke-interface {p1}, Landroid/net/IePDGStateListener;->asBinder()Landroid/os/IBinder;

    move-result-object v9

    invoke-direct {p0, v9}, Lcom/android/server/ePDGNotifier;->remove(Landroid/os/IBinder;)V

    goto :goto_7

    .line 180
    .restart local v0    # "N":I
    .restart local v1    # "b":Landroid/os/IBinder;
    .restart local v3    # "i":I
    .restart local v7    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    :catchall_1
    move-exception v9

    move-object v6, v7

    .end local v7    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    .restart local v6    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    goto :goto_8
.end method

.method public getTypebyid(I)Ljava/lang/String;
    .locals 1
    .param p1, "id"    # I

    .prologue
    .line 538
    if-nez p1, :cond_0

    .line 539
    const-string v0, "ims"

    .line 547
    :goto_0
    return-object v0

    .line 540
    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    .line 541
    const-string v0, "vzwapp"

    goto :goto_0

    .line 542
    :cond_1
    const/4 v0, 0x2

    if-ne p1, v0, :cond_2

    .line 543
    const-string v0, "CF"

    goto :goto_0

    .line 544
    :cond_2
    const/4 v0, 0x3

    if-ne p1, v0, :cond_3

    .line 545
    const-string v0, "Static"

    goto :goto_0

    .line 547
    :cond_3
    const-string v0, "unknown"

    goto :goto_0
.end method

.method public notifyADDRChange(I)V
    .locals 11
    .param p1, "id"    # I

    .prologue
    const/4 v1, 0x5

    const/4 v0, 0x1

    .line 441
    if-le p1, v1, :cond_0

    .line 533
    :goto_0
    return-void

    .line 451
    :cond_0
    const/4 v6, 0x0

    .line 453
    .local v6, "linkProperties":Landroid/net/LinkProperties;
    if-ne p1, v0, :cond_2

    .line 457
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v0, v0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v0, p1

    if-nez v0, :cond_1

    .line 458
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    invoke-virtual {v0, p1}, Lcom/android/server/ePDGTracker;->getePDGLinkProp(I)Landroid/net/LinkProperties;

    move-result-object v6

    .line 463
    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    iget-object v1, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v1, v1, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v2, 0x1

    aget v1, v1, v2

    invoke-static {v1}, Lcom/android/server/ePDGNotifier;->convertPDNState(I)I

    move-result v1

    const/4 v2, 0x1

    const-string v3, "ePDG_CH"

    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Lcom/android/server/ePDGTracker;->getAPNwithFid(I)Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v7, 0x1

    invoke-virtual {v5, v7}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x0

    const/16 v8, 0xd

    const/4 v9, 0x0

    invoke-interface/range {v0 .. v9}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyDataConnection(IZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/LinkProperties;Landroid/net/NetworkCapabilities;IZ)V

    .line 474
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    iget-object v1, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v1, v1, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v2, 0x1

    aget v1, v1, v2

    invoke-static {v1}, Lcom/android/server/ePDGNotifier;->convertPDNState(I)I

    move-result v1

    const/4 v2, 0x1

    const-string v3, "ePDG_CH"

    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Lcom/android/server/ePDGTracker;->getAPNwithFid(I)Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v7, 0x7

    invoke-virtual {v5, v7}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x0

    const/16 v8, 0xd

    const/4 v9, 0x0

    invoke-interface/range {v0 .. v9}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyDataConnection(IZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/LinkProperties;Landroid/net/NetworkCapabilities;IZ)V

    .line 485
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    iget-object v1, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v1, v1, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v2, 0x1

    aget v1, v1, v2

    invoke-static {v1}, Lcom/android/server/ePDGNotifier;->convertPDNState(I)I

    move-result v1

    const/4 v2, 0x1

    const-string v3, "ePDG_CH"

    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Lcom/android/server/ePDGTracker;->getAPNwithFid(I)Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v7, 0x6

    invoke-virtual {v5, v7}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x0

    const/16 v8, 0xd

    const/4 v9, 0x0

    invoke-interface/range {v0 .. v9}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyDataConnection(IZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/LinkProperties;Landroid/net/NetworkCapabilities;IZ)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 496
    :catch_0
    move-exception v0

    goto/16 :goto_0

    .line 503
    :cond_2
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v0, v0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v10, v0, p1

    .line 504
    .local v10, "currentstatus":I
    const/4 v8, 0x0

    .line 505
    .local v8, "currenttech":I
    if-ne v10, v1, :cond_4

    .line 507
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    invoke-virtual {v0, p1}, Lcom/android/server/ePDGTracker;->getePDGLinkProp(I)Landroid/net/LinkProperties;

    move-result-object v6

    .line 508
    const/16 v8, 0xd

    .line 517
    :cond_3
    :goto_1
    :try_start_1
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    invoke-static {v10}, Lcom/android/server/ePDGNotifier;->convertPDNState(I)I

    move-result v1

    const/4 v2, 0x1

    const-string v3, "ePDG_CH"

    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    invoke-virtual {v4, p1}, Lcom/android/server/ePDGTracker;->getAPNwithFid(I)Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    invoke-virtual {v5, p1}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x0

    const/4 v9, 0x0

    invoke-interface/range {v0 .. v9}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyDataConnection(IZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/LinkProperties;Landroid/net/NetworkCapabilities;IZ)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_1

    goto/16 :goto_0

    .line 527
    :catch_1
    move-exception v0

    goto/16 :goto_0

    .line 510
    :cond_4
    const/4 v0, 0x6

    if-ne v10, v0, :cond_3

    .line 512
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    invoke-virtual {v0, p1}, Lcom/android/server/ePDGTracker;->getePDGLinkProp(I)Landroid/net/LinkProperties;

    move-result-object v6

    .line 513
    const/16 v8, 0x12

    goto :goto_1
.end method

.method public notifyErrorStatus(I)V
    .locals 6
    .param p1, "mid"    # I

    .prologue
    .line 403
    if-nez p1, :cond_3

    .line 405
    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    monitor-enter v4

    .line 407
    :try_start_0
    iget-object v3, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/ePDGNotifier$eRecord;

    .line 408
    .local v2, "r":Lcom/android/server/ePDGNotifier$eRecord;
    iget v3, v2, Lcom/android/server/ePDGNotifier$eRecord;->events:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    and-int/lit8 v3, v3, 0x8

    if-eqz v3, :cond_0

    .line 410
    :try_start_1
    iget-object v3, v2, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    iget-object v5, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v5, v5, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    aget v5, v5, p1

    invoke-interface {v3, v5}, Landroid/net/IePDGStateListener;->onErrorStatusChanged(I)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 411
    :catch_0
    move-exception v0

    .line 412
    .local v0, "ex":Landroid/os/RemoteException;
    :try_start_2
    iget-object v3, p0, Lcom/android/server/ePDGNotifier;->mRemoveList:Ljava/util/ArrayList;

    iget-object v5, v2, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 417
    .end local v0    # "ex":Landroid/os/RemoteException;
    .end local v1    # "i$":Ljava/util/Iterator;
    .end local v2    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v3

    .line 416
    .restart local v1    # "i$":Ljava/util/Iterator;
    :cond_1
    :try_start_3
    invoke-direct {p0}, Lcom/android/server/ePDGNotifier;->handleRemoveListLocked()V

    .line 417
    monitor-exit v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 435
    .end local v1    # "i$":Ljava/util/Iterator;
    :cond_2
    :goto_1
    return-void

    .line 419
    :cond_3
    const/4 v3, 0x1

    if-ne p1, v3, :cond_2

    .line 421
    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    monitor-enter v4

    .line 423
    :try_start_4
    iget-object v3, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .restart local v1    # "i$":Ljava/util/Iterator;
    :cond_4
    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_5

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/ePDGNotifier$eRecord;

    .line 424
    .restart local v2    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    iget v3, v2, Lcom/android/server/ePDGNotifier$eRecord;->events:I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    and-int/lit8 v3, v3, 0x20

    if-eqz v3, :cond_4

    .line 426
    :try_start_5
    iget-object v3, v2, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    iget-object v5, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v5, v5, Lcom/android/server/ePDGTracker;->mLastfailreason:[I

    aget v5, v5, p1

    invoke-interface {v3, v5}, Landroid/net/IePDGStateListener;->onCBSErrorStatusChanged(I)V
    :try_end_5
    .catch Landroid/os/RemoteException; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    goto :goto_2

    .line 427
    :catch_1
    move-exception v0

    .line 428
    .restart local v0    # "ex":Landroid/os/RemoteException;
    :try_start_6
    iget-object v3, p0, Lcom/android/server/ePDGNotifier;->mRemoveList:Ljava/util/ArrayList;

    iget-object v5, v2, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 433
    .end local v0    # "ex":Landroid/os/RemoteException;
    .end local v1    # "i$":Ljava/util/Iterator;
    .end local v2    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    :catchall_1
    move-exception v3

    monitor-exit v4
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    throw v3

    .line 432
    .restart local v1    # "i$":Ljava/util/Iterator;
    :cond_5
    :try_start_7
    invoke-direct {p0}, Lcom/android/server/ePDGNotifier;->handleRemoveListLocked()V

    .line 433
    monitor-exit v4
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    goto :goto_1
.end method

.method public notifyPDPState(I)V
    .locals 14
    .param p1, "id"    # I

    .prologue
    const/4 v3, 0x1

    .line 231
    const/4 v0, 0x5

    if-le p1, v0, :cond_0

    .line 318
    :goto_0
    return-void

    .line 236
    :cond_0
    iget v0, p0, Lcom/android/server/ePDGNotifier;->myfeature:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_1

    .line 238
    invoke-virtual {p0, p1}, Lcom/android/server/ePDGNotifier;->notifyTMUSPDPState(I)V

    goto :goto_0

    .line 242
    :cond_1
    const-string v0, "ePDG"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "notifiy ststus : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    invoke-virtual {v2, p1}, Lcom/android/server/ePDGTracker;->getePDGstatuswithfid(I)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 248
    if-ne p1, v3, :cond_3

    .line 251
    const/4 v6, 0x0

    .line 253
    .local v6, "linkProperties":Landroid/net/LinkProperties;
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v0, v0, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v0, v0, p1

    if-nez v0, :cond_2

    .line 254
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    invoke-virtual {v0, p1}, Lcom/android/server/ePDGTracker;->getePDGLinkProp(I)Landroid/net/LinkProperties;

    move-result-object v6

    .line 260
    :cond_2
    :try_start_0
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    iget-object v1, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v1, v1, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v2, 0x1

    aget v1, v1, v2

    invoke-static {v1}, Lcom/android/server/ePDGNotifier;->convertPDNState(I)I

    move-result v1

    const/4 v2, 0x1

    const-string v3, "ePDG"

    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Lcom/android/server/ePDGTracker;->getAPNwithFid(I)Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v7, 0x1

    invoke-virtual {v5, v7}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x0

    const/16 v8, 0xd

    const/4 v9, 0x0

    invoke-interface/range {v0 .. v9}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyDataConnection(IZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/LinkProperties;Landroid/net/NetworkCapabilities;IZ)V

    .line 271
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    iget-object v1, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v1, v1, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v2, 0x1

    aget v1, v1, v2

    invoke-static {v1}, Lcom/android/server/ePDGNotifier;->convertPDNState(I)I

    move-result v1

    const/4 v2, 0x1

    const-string v3, "ePDG"

    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Lcom/android/server/ePDGTracker;->getAPNwithFid(I)Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v7, 0x7

    invoke-virtual {v5, v7}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x0

    const/16 v8, 0xd

    const/4 v9, 0x0

    invoke-interface/range {v0 .. v9}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyDataConnection(IZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/LinkProperties;Landroid/net/NetworkCapabilities;IZ)V

    .line 282
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    iget-object v1, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v1, v1, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    const/4 v2, 0x1

    aget v1, v1, v2

    invoke-static {v1}, Lcom/android/server/ePDGNotifier;->convertPDNState(I)I

    move-result v1

    const/4 v2, 0x1

    const-string v3, "ePDG"

    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Lcom/android/server/ePDGTracker;->getAPNwithFid(I)Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    const/4 v7, 0x6

    invoke-virtual {v5, v7}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x0

    const/16 v8, 0xd

    const/4 v9, 0x0

    invoke-interface/range {v0 .. v9}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyDataConnection(IZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/LinkProperties;Landroid/net/NetworkCapabilities;IZ)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1

    .line 301
    .end local v6    # "linkProperties":Landroid/net/LinkProperties;
    :cond_3
    :goto_1
    iget-object v1, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    monitor-enter v1

    .line 303
    const/4 v0, 0x2

    :try_start_1
    new-array v12, v0, [I

    .line 305
    .local v12, "mystate":[I
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v11

    .local v11, "i$":Ljava/util/Iterator;
    :cond_4
    :goto_2
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lcom/android/server/ePDGNotifier$eRecord;

    .line 306
    .local v13, "r":Lcom/android/server/ePDGNotifier$eRecord;
    iget v0, v13, Lcom/android/server/ePDGNotifier$eRecord;->events:I

    and-int/lit8 v0, v0, 0x1

    if-eqz v0, :cond_4

    .line 307
    const/4 v0, 0x0

    aput p1, v12, v0

    .line 308
    const/4 v0, 0x1

    iget-object v2, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    invoke-virtual {v2, p1}, Lcom/android/server/ePDGTracker;->getePDGstatuswithfid(I)I

    move-result v2

    aput v2, v12, v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 310
    :try_start_2
    iget-object v0, v13, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    invoke-interface {v0, v12}, Landroid/net/IePDGStateListener;->onPDPStateChanged([I)V
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_2

    .line 311
    :catch_0
    move-exception v10

    .line 312
    .local v10, "ex":Landroid/os/RemoteException;
    :try_start_3
    iget-object v0, p0, Lcom/android/server/ePDGNotifier;->mRemoveList:Ljava/util/ArrayList;

    iget-object v2, v13, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 317
    .end local v10    # "ex":Landroid/os/RemoteException;
    .end local v11    # "i$":Ljava/util/Iterator;
    .end local v12    # "mystate":[I
    .end local v13    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0

    .line 316
    .restart local v11    # "i$":Ljava/util/Iterator;
    .restart local v12    # "mystate":[I
    :cond_5
    :try_start_4
    invoke-direct {p0}, Lcom/android/server/ePDGNotifier;->handleRemoveListLocked()V

    .line 317
    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto/16 :goto_0

    .line 293
    .end local v11    # "i$":Ljava/util/Iterator;
    .end local v12    # "mystate":[I
    .restart local v6    # "linkProperties":Landroid/net/LinkProperties;
    :catch_1
    move-exception v0

    goto :goto_1
.end method

.method public notifyTMUSPDPState(I)V
    .locals 16
    .param p1, "id"    # I

    .prologue
    .line 325
    const/4 v7, 0x0

    .line 327
    .local v7, "linkProperties":Landroid/net/LinkProperties;
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v1, v1, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v11, v1, p1

    .line 328
    .local v11, "currentstatus":I
    const/4 v9, 0x0

    .line 329
    .local v9, "currenttech":I
    const/4 v1, 0x5

    if-ne v11, v1, :cond_2

    .line 331
    const/16 v9, 0xd

    .line 332
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    move/from16 v0, p1

    invoke-virtual {v1, v0}, Lcom/android/server/ePDGTracker;->getePDGLinkProp(I)Landroid/net/LinkProperties;

    move-result-object v7

    .line 341
    :cond_0
    :goto_0
    :try_start_0
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/server/ePDGNotifier;->mRegistry:Lcom/android/internal/telephony/ITelephonyRegistry;

    invoke-static {v11}, Lcom/android/server/ePDGNotifier;->convertPDNState(I)I

    move-result v2

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    invoke-virtual {v3}, Lcom/android/server/ePDGTracker;->getisMobileavail()Z

    move-result v3

    const-string v4, "ePDG"

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    move/from16 v0, p1

    invoke-virtual {v5, v0}, Lcom/android/server/ePDGTracker;->getAPNwithFid(I)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    move/from16 v0, p1

    invoke-virtual {v6, v0}, Lcom/android/server/ePDGTracker;->getapntypewithfid(I)Ljava/lang/String;

    move-result-object v6

    const/4 v8, 0x0

    const/4 v10, 0x0

    invoke-interface/range {v1 .. v10}, Lcom/android/internal/telephony/ITelephonyRegistry;->notifyDataConnection(IZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/LinkProperties;Landroid/net/NetworkCapabilities;IZ)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1

    .line 359
    :goto_1
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    monitor-enter v2

    .line 361
    const/4 v1, 0x2

    :try_start_1
    new-array v14, v1, [I

    .line 363
    .local v14, "mystate":[I
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v13

    .local v13, "i$":Ljava/util/Iterator;
    :cond_1
    :goto_2
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Lcom/android/server/ePDGNotifier$eRecord;

    .line 364
    .local v15, "r":Lcom/android/server/ePDGNotifier$eRecord;
    iget v1, v15, Lcom/android/server/ePDGNotifier$eRecord;->events:I

    and-int/lit8 v1, v1, 0x1

    if-eqz v1, :cond_1

    .line 365
    const/4 v1, 0x0

    aput p1, v14, v1

    .line 366
    const/4 v1, 0x1

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v3, v3, Lcom/android/server/ePDGTracker;->isFeatureStatus:[I

    aget v3, v3, p1

    aput v3, v14, v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 368
    :try_start_2
    iget-object v1, v15, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    invoke-interface {v1, v14}, Landroid/net/IePDGStateListener;->onPDPStateChanged([I)V
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_2

    .line 369
    :catch_0
    move-exception v12

    .line 370
    .local v12, "ex":Landroid/os/RemoteException;
    :try_start_3
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/server/ePDGNotifier;->mRemoveList:Ljava/util/ArrayList;

    iget-object v3, v15, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 377
    .end local v12    # "ex":Landroid/os/RemoteException;
    .end local v13    # "i$":Ljava/util/Iterator;
    .end local v14    # "mystate":[I
    .end local v15    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v1

    .line 334
    :cond_2
    const/4 v1, 0x6

    if-ne v11, v1, :cond_0

    .line 336
    const/16 v9, 0x12

    .line 337
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    move/from16 v0, p1

    invoke-virtual {v1, v0}, Lcom/android/server/ePDGTracker;->getePDGLinkProp(I)Landroid/net/LinkProperties;

    move-result-object v7

    goto :goto_0

    .line 374
    .restart local v13    # "i$":Ljava/util/Iterator;
    .restart local v14    # "mystate":[I
    :cond_3
    :try_start_4
    invoke-direct/range {p0 .. p0}, Lcom/android/server/ePDGNotifier;->handleRemoveListLocked()V

    .line 377
    monitor-exit v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 378
    return-void

    .line 354
    .end local v13    # "i$":Ljava/util/Iterator;
    .end local v14    # "mystate":[I
    :catch_1
    move-exception v1

    goto :goto_1
.end method

.method public notifyWIFIStatus()V
    .locals 6

    .prologue
    .line 384
    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    monitor-enter v4

    .line 386
    :try_start_0
    iget-object v3, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/ePDGNotifier$eRecord;

    .line 387
    .local v2, "r":Lcom/android/server/ePDGNotifier$eRecord;
    iget v3, v2, Lcom/android/server/ePDGNotifier$eRecord;->events:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    and-int/lit8 v3, v3, 0x4

    if-eqz v3, :cond_0

    .line 389
    :try_start_1
    iget-object v3, v2, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    iget-object v5, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-boolean v5, v5, Lcom/android/server/ePDGTracker;->mWifiConnected:Z

    invoke-interface {v3, v5}, Landroid/net/IePDGStateListener;->onWiFiStatusChanged(Z)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 390
    :catch_0
    move-exception v0

    .line 391
    .local v0, "ex":Landroid/os/RemoteException;
    :try_start_2
    iget-object v3, p0, Lcom/android/server/ePDGNotifier;->mRemoveList:Ljava/util/ArrayList;

    iget-object v5, v2, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 396
    .end local v0    # "ex":Landroid/os/RemoteException;
    .end local v1    # "i$":Ljava/util/Iterator;
    .end local v2    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v3

    .line 395
    .restart local v1    # "i$":Ljava/util/Iterator;
    :cond_1
    :try_start_3
    invoke-direct {p0}, Lcom/android/server/ePDGNotifier;->handleRemoveListLocked()V

    .line 396
    monitor-exit v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 397
    return-void
.end method

.method public notifyonConnectionParam(I)V
    .locals 7
    .param p1, "id"    # I

    .prologue
    .line 555
    iget-object v5, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    monitor-enter v5

    .line 557
    :try_start_0
    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mRecords:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/server/ePDGNotifier$eRecord;

    .line 558
    .local v3, "r":Lcom/android/server/ePDGNotifier$eRecord;
    iget v4, v3, Lcom/android/server/ePDGNotifier$eRecord;->events:I

    and-int/lit8 v4, v4, 0x10

    if-eqz v4, :cond_0

    .line 561
    const/4 v4, 0x7

    new-array v2, v4, [Ljava/lang/String;

    .line 563
    .local v2, "myinfo":[Ljava/lang/String;
    const/4 v4, 0x0

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGNotifier;->getTypebyid(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v2, v4

    .line 564
    const/4 v4, 0x1

    iget-object v6, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v6, v6, Lcom/android/server/ePDGTracker;->identity:Ljava/lang/String;

    aput-object v6, v2, v4

    .line 565
    const/4 v4, 0x2

    iget-object v6, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v6, v6, Lcom/android/server/ePDGTracker;->FQDNForEPDG:Ljava/lang/String;

    aput-object v6, v2, v4

    .line 566
    const/4 v4, 0x3

    iget-object v6, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v6, v6, Lcom/android/server/ePDGTracker;->ePDGAddrofThisnetwork:Ljava/lang/String;

    aput-object v6, v2, v4

    .line 567
    const/4 v4, 0x4

    iget-object v6, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v6, v6, Lcom/android/server/ePDGTracker;->iPsecAddr:[Ljava/lang/String;

    aget-object v6, v6, p1

    aput-object v6, v2, v4

    .line 568
    const/4 v4, 0x5

    iget-object v6, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v6, v6, Lcom/android/server/ePDGTracker;->iPsecIf:[Ljava/lang/String;

    aget-object v6, v6, p1

    aput-object v6, v2, v4

    .line 569
    const/4 v4, 0x6

    iget-object v6, p0, Lcom/android/server/ePDGNotifier;->mePDGTracker:Lcom/android/server/ePDGTracker;

    iget-object v6, v6, Lcom/android/server/ePDGTracker;->iPsecGW:[Ljava/lang/String;

    aget-object v6, v6, p1

    aput-object v6, v2, v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 571
    :try_start_1
    iget-object v4, v3, Lcom/android/server/ePDGNotifier$eRecord;->callback:Landroid/net/IePDGStateListener;

    invoke-interface {v4, v2}, Landroid/net/IePDGStateListener;->onConnectionParamStatus([Ljava/lang/String;)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 572
    :catch_0
    move-exception v0

    .line 573
    .local v0, "ex":Landroid/os/RemoteException;
    :try_start_2
    iget-object v4, p0, Lcom/android/server/ePDGNotifier;->mRemoveList:Ljava/util/ArrayList;

    iget-object v6, v3, Lcom/android/server/ePDGNotifier$eRecord;->binder:Landroid/os/IBinder;

    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 578
    .end local v0    # "ex":Landroid/os/RemoteException;
    .end local v1    # "i$":Ljava/util/Iterator;
    .end local v2    # "myinfo":[Ljava/lang/String;
    .end local v3    # "r":Lcom/android/server/ePDGNotifier$eRecord;
    :catchall_0
    move-exception v4

    monitor-exit v5
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v4

    .line 577
    .restart local v1    # "i$":Ljava/util/Iterator;
    :cond_1
    :try_start_3
    invoke-direct {p0}, Lcom/android/server/ePDGNotifier;->handleRemoveListLocked()V

    .line 578
    monitor-exit v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 579
    return-void
.end method
