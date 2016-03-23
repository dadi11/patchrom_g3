.class public Lcom/android/internal/telephony/dataconnection/ApnContext;
.super Ljava/lang/Object;
.source "ApnContext.java"


# static fields
.field protected static final DBG:Z


# instance fields
.field public final LOG_TAG:Ljava/lang/String;

.field private mApnSetting:Lcom/android/internal/telephony/dataconnection/ApnSetting;

.field private final mApnType:Ljava/lang/String;

.field private final mContext:Landroid/content/Context;

.field mDataEnabled:Ljava/util/concurrent/atomic/AtomicBoolean;

.field mDcAc:Lcom/android/internal/telephony/dataconnection/DcAsyncChannel;

.field private final mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

.field mDependencyMet:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private final mPriority:I

.field mReason:Ljava/lang/String;

.field mReconnectAlarmIntent:Landroid/app/PendingIntent;

.field private mRefCount:I

.field private final mRefCountLock:Ljava/lang/Object;

.field mRestartManager:Lcom/android/internal/telephony/RetryManager;

.field private mState:Lcom/android/internal/telephony/DctConstants$State;

.field private mWaitingApns:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/dataconnection/ApnSetting;",
            ">;"
        }
    .end annotation
.end field

.field private mWaitingApnsPermanentFailureCountDown:Ljava/util/concurrent/atomic/AtomicInteger;

.field public final priority:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Landroid/net/NetworkConfig;Lcom/android/internal/telephony/dataconnection/DcTrackerBase;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "apnType"    # Ljava/lang/String;
    .param p3, "logTag"    # Ljava/lang/String;
    .param p4, "config"    # Landroid/net/NetworkConfig;
    .param p5, "tracker"    # Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    .prologue
    const/4 v1, 0x0

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 98
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 63
    iput-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApns:Ljava/util/ArrayList;

    .line 84
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRefCountLock:Ljava/lang/Object;

    .line 85
    iput v2, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRefCount:I

    .line 94
    iput-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    .line 99
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mContext:Landroid/content/Context;

    .line 100
    iput-object p2, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    .line 101
    sget-object v0, Lcom/android/internal/telephony/DctConstants$State;->IDLE:Lcom/android/internal/telephony/DctConstants$State;

    iput-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;

    .line 106
    iput v2, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mPriority:I

    .line 108
    const-string v0, "dataEnabled"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->setReason(Ljava/lang/String;)V

    .line 109
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDataEnabled:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 110
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-boolean v1, p4, Landroid/net/NetworkConfig;->dependencyMet:Z

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDependencyMet:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 111
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0, v2}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    iput-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApnsPermanentFailureCountDown:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 112
    iget v0, p4, Landroid/net/NetworkConfig;->priority:I

    iput v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->priority:I

    .line 115
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ABCABC_RETRY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 116
    new-instance v0, Lcom/android/internal/telephony/RetryManager;

    invoke-direct {v0}, Lcom/android/internal/telephony/RetryManager;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    .line 117
    invoke-virtual {p0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->initRestartManager()V

    .line 120
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 121
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 122
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    const-string v1, "default"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    const-string v1, "ims"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 123
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/RetryManager;->getRetryCount()I

    move-result v0

    invoke-direct {p0, v3, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->configureRetry(ZI)V

    .line 163
    :cond_1
    :goto_0
    iput-object p3, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->LOG_TAG:Ljava/lang/String;

    .line 164
    iput-object p5, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    .line 165
    return-void

    .line 126
    :cond_2
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_EMERGENCY_CALL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    const-string v1, "emergency"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 128
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v0

    const/4 v1, 0x5

    if-ne v0, v1, :cond_3

    .line 129
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "max_retries=0"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    goto :goto_0

    .line 132
    :cond_3
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "max_retries=4, 2000, 2000, 2000, 2000"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    goto :goto_0

    .line 136
    :cond_4
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/RetryManager;->getRetryCount()I

    move-result v0

    invoke-direct {p0, v2, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->configureRetry(ZI)V

    goto :goto_0

    .line 141
    :cond_5
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    const-string v1, "default"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 142
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/RetryManager;->getRetryCount()I

    move-result v0

    invoke-direct {p0, v3, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->configureRetry(ZI)V

    goto :goto_0

    .line 144
    :cond_6
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/RetryManager;->getRetryCount()I

    move-result v0

    invoke-direct {p0, v2, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->configureRetry(ZI)V

    goto :goto_0

    .line 147
    :cond_7
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_RETRY_CONFIG_KDDI:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_a

    .line 148
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    const-string v1, "default"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    const-string v1, "ims"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 149
    :cond_8
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/RetryManager;->getRetryCount()I

    move-result v0

    invoke-direct {p0, v3, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->configureRetry(ZI)V

    goto :goto_0

    .line 151
    :cond_9
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/RetryManager;->getRetryCount()I

    move-result v0

    invoke-direct {p0, v2, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->configureRetry(ZI)V

    goto/16 :goto_0

    .line 154
    :cond_a
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    const-string v1, "default"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 155
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "default_randomization=2000,5000,10000,20000,40000,80000:5000,160000:5000,320000:5000,640000:5000,1280000:5000,1800000:5000"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    goto/16 :goto_0

    .line 157
    :cond_b
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "max_retries=3, 5000, 5000, 5000"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    goto/16 :goto_0
.end method

.method private configureRetry(ZI)V
    .locals 5
    .param p1, "forDefault"    # Z
    .param p2, "retryCount"    # I

    .prologue
    const/16 v4, 0x7d0

    const/16 v3, 0x3e8

    const/16 v2, 0x14

    .line 431
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    if-nez v0, :cond_0

    .line 475
    :goto_0
    return-void

    .line 433
    :cond_0
    if-eqz p1, :cond_5

    .line 435
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_RETRY_CONFIG_KDDI:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 436
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "default_randomization=0,max_retries=infinite,5000,10000,20000,40000,80000:100,160000:100,320000:100,640000:100,1280000:100,1800000:100"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 439
    const-string v0, "configureRetry: Could not configure using KDDI_DATA_RETRY_CONFIG=default_randomization=0,max_retries=infinite,5000,10000,20000,40000,80000:100,160000:100,320000:100,640000:100,1280000:100,1800000:100"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 441
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, v2, v4, v3}, Lcom/android/internal/telephony/RetryManager;->configure(III)Z

    .line 443
    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, p2}, Lcom/android/internal/telephony/RetryManager;->setRetryCount(I)V

    goto :goto_0

    .line 448
    :cond_2
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 449
    const-string v0, "[LG_DATA] configureRetry : by DOMESTIC_DATA_RETRY_CONFIG"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 450
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "default_randomization=0,max_retries=infinite,5000,10000,20000,40000,80000:100,160000:100,320000:100,640000:100,1280000:100,1800000:100"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 452
    const-string v0, "configureRetry: Could not configure using [SKT/KT/LGU] DOMESTIC_DATA_RETRY_CONFIG=default_randomization=0,max_retries=infinite,5000,10000,20000,40000,80000:100,160000:100,320000:100,640000:100,1280000:100,1800000:100"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 453
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, v2, v4, v3}, Lcom/android/internal/telephony/RetryManager;->configure(III)Z

    .line 474
    :cond_3
    :goto_1
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, p2}, Lcom/android/internal/telephony/RetryManager;->setRetryCount(I)V

    goto :goto_0

    .line 457
    :cond_4
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "default_randomization=2000,5000,10000,20000,40000,80000:5000,160000:5000,320000:5000,640000:5000,1280000:5000,1800000:5000"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 459
    const-string v0, "configureRetry: Could not configure using DEFAULT_DATA_RETRY_CONFIG=default_randomization=2000,5000,10000,20000,40000,80000:5000,160000:5000,320000:5000,640000:5000,1280000:5000,1800000:5000"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 461
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, v2, v4, v3}, Lcom/android/internal/telephony/RetryManager;->configure(III)Z

    goto :goto_1

    .line 467
    :cond_5
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "max_retries=3, 5000, 5000, 5000"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 469
    const-string v0, "configureRetry: Could note configure using SECONDARY_DATA_RETRY_CONFIG=max_retries=3, 5000, 5000, 5000"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 471
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "max_retries=3, 333, 333, 333"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    goto :goto_1
.end method


# virtual methods
.method public configureRetryVzw(ZII)V
    .locals 5
    .param p1, "forDefault"    # Z
    .param p2, "retryCount"    # I
    .param p3, "nt"    # I

    .prologue
    const/16 v4, 0x14

    const/16 v3, 0x7d0

    const/16 v2, 0x3e8

    .line 371
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    if-nez v0, :cond_1

    .line 423
    :cond_0
    :goto_0
    return-void

    .line 374
    :cond_1
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_EMERGENCY_CALL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    const-string v1, "emergency"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 375
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "max_retries=8, 2000, 2000, 2000, 2000, 3000, 3000, 3000, 3000"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    .line 376
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, p2}, Lcom/android/internal/telephony/RetryManager;->setRetryCount(I)V

    .line 377
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "configureRetry[epdn]: mRestartManager="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 382
    :cond_2
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_RETRY_CONFIG_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 383
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[Set_Retry][apncontext] nt = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 384
    packed-switch p3, :pswitch_data_0

    .line 407
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "default_randomization=0,max_retries=infinite,5000,10000,20000:100,40000:100,80000:100,120000:100,180000:100,240000:100"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 408
    const-string v0, "[Set_Retry][apncontext] 1x & evdo"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 410
    const-string v0, "configureRetry: Could not configure using VZW_DATA_RETRY_CONFIG_NONE_LTE_AND_EHRPD=default_randomization=0,max_retries=infinite,5000,10000,20000:100,40000:100,80000:100,120000:100,180000:100,240000:100"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 412
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, v4, v3, v2}, Lcom/android/internal/telephony/RetryManager;->configure(III)Z

    .line 420
    :cond_3
    :goto_1
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, p2}, Lcom/android/internal/telephony/RetryManager;->setRetryCount(I)V

    goto :goto_0

    .line 387
    :pswitch_0
    const-string v0, "[Set_Retry][apncontext] EHRPD/LTE"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 388
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    const-string v1, "ims"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    const-string v1, "default"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 389
    :cond_4
    const-string v0, "[Set_Retry][apncontext] IMS/Internet APN in eHRPD/LTE"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 390
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "default_randomization=0,max_retries=infinite,5000,10000,10000:100,20000:100,20000:100,20000:100,20000:100,30000:100"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 392
    const-string v0, "configureRetry: Could not configure using VZW_DATA_RETRY_CONFIG_LTE_AND_EHRPD=default_randomization=0,max_retries=infinite,5000,10000,10000:100,20000:100,20000:100,20000:100,20000:100,30000:100"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 394
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, v4, v3, v2}, Lcom/android/internal/telephony/RetryManager;->configure(III)Z

    goto :goto_1

    .line 398
    :cond_5
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const-string v1, "default_randomization=0,max_retries=60,5000,5000,5000:100,10000:100,10000:100,20000:100,20000:100,30000:100,30000:100,30000:100,60000:100"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->configure(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 400
    const-string v0, "configureRetry: Could note configure using SECONDARY_DATA_RETRY_CONFIG=max_retries=3, 5000, 5000, 5000"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 402
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    const/4 v1, 0x5

    invoke-virtual {v0, v1, v3, v2}, Lcom/android/internal/telephony/RetryManager;->configure(III)Z

    goto :goto_1

    .line 384
    nop

    :pswitch_data_0
    .packed-switch 0xd
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public decRefCount()V
    .locals 4

    .prologue
    .line 343
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRefCountLock:Ljava/lang/Object;

    monitor-enter v1

    .line 344
    :try_start_0
    iget v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRefCount:I

    add-int/lit8 v2, v0, -0x1

    iput v2, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRefCount:I

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    .line 345
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v3, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnTypeToId(Ljava/lang/String;)I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setEnabled(IZ)V

    .line 347
    :cond_0
    monitor-exit v1

    .line 348
    return-void

    .line 347
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public decWaitingApnsPermFailCount()V
    .locals 1

    .prologue
    .line 211
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApnsPermanentFailureCountDown:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->decrementAndGet()I

    .line 212
    return-void
.end method

.method public dump(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V
    .locals 2
    .param p1, "fd"    # Ljava/io/FileDescriptor;
    .param p2, "pw"    # Ljava/io/PrintWriter;
    .param p3, "args"    # [Ljava/lang/String;

    .prologue
    .line 364
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ApnContext: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 365
    return-void
.end method

.method public declared-synchronized getApnSetting()Lcom/android/internal/telephony/dataconnection/ApnSetting;
    .locals 2

    .prologue
    .line 192
    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "getApnSetting: apnSetting="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnSetting:Lcom/android/internal/telephony/dataconnection/ApnSetting;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 193
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnSetting:Lcom/android/internal/telephony/dataconnection/ApnSetting;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 192
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public getApnType()Ljava/lang/String;
    .locals 1

    .prologue
    .line 168
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    return-object v0
.end method

.method public declared-synchronized getDcAc()Lcom/android/internal/telephony/dataconnection/DcAsyncChannel;
    .locals 1

    .prologue
    .line 172
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDcAc:Lcom/android/internal/telephony/dataconnection/DcAsyncChannel;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public getDependencyMet()Z
    .locals 1

    .prologue
    .line 308
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDependencyMet:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    return v0
.end method

.method public declared-synchronized getNextWaitingApn()Lcom/android/internal/telephony/dataconnection/ApnSetting;
    .locals 3

    .prologue
    .line 215
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApns:Ljava/util/ArrayList;

    .line 216
    .local v1, "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/dataconnection/ApnSetting;>;"
    const/4 v0, 0x0

    .line 218
    .local v0, "apn":Lcom/android/internal/telephony/dataconnection/ApnSetting;
    if-eqz v1, :cond_0

    .line 219
    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    .line 220
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "apn":Lcom/android/internal/telephony/dataconnection/ApnSetting;
    check-cast v0, Lcom/android/internal/telephony/dataconnection/ApnSetting;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 223
    .restart local v0    # "apn":Lcom/android/internal/telephony/dataconnection/ApnSetting;
    :cond_0
    monitor-exit p0

    return-object v0

    .line 215
    .end local v0    # "apn":Lcom/android/internal/telephony/dataconnection/ApnSetting;
    .end local v1    # "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/dataconnection/ApnSetting;>;"
    :catchall_0
    move-exception v2

    monitor-exit p0

    throw v2
.end method

.method public declared-synchronized getReason()Ljava/lang/String;
    .locals 1

    .prologue
    .line 268
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mReason:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getReconnectIntent()Landroid/app/PendingIntent;
    .locals 1

    .prologue
    .line 184
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mReconnectAlarmIntent:Landroid/app/PendingIntent;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getState()Lcom/android/internal/telephony/DctConstants$State;
    .locals 1

    .prologue
    .line 251
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getWaitingApns()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/dataconnection/ApnSetting;",
            ">;"
        }
    .end annotation

    .prologue
    .line 233
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApns:Ljava/util/ArrayList;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public getWaitingApnsPermFailCount()I
    .locals 1

    .prologue
    .line 207
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApnsPermanentFailureCountDown:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v0

    return v0
.end method

.method public incRefCount()V
    .locals 4

    .prologue
    .line 335
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRefCountLock:Ljava/lang/Object;

    monitor-enter v1

    .line 336
    :try_start_0
    iget v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRefCount:I

    add-int/lit8 v2, v0, 0x1

    iput v2, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRefCount:I

    if-nez v0, :cond_0

    .line 337
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v3, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnTypeToId(Ljava/lang/String;)I

    move-result v2

    const/4 v3, 0x1

    invoke-virtual {v0, v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setEnabled(IZ)V

    .line 339
    :cond_0
    monitor-exit v1

    .line 340
    return-void

    .line 339
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public initRestartManager()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 327
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    if-nez v0, :cond_1

    .line 332
    :cond_0
    :goto_0
    return-void

    .line 328
    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->setRetryCount(I)V

    .line 329
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-nez v0, :cond_0

    .line 330
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mRestartManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/RetryManager;->setRetryForever(Z)V

    goto :goto_0
.end method

.method public isConnectable()Z
    .locals 2

    .prologue
    .line 276
    invoke-virtual {p0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->isReady()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;

    sget-object v1, Lcom/android/internal/telephony/DctConstants$State;->IDLE:Lcom/android/internal/telephony/DctConstants$State;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;

    sget-object v1, Lcom/android/internal/telephony/DctConstants$State;->SCANNING:Lcom/android/internal/telephony/DctConstants$State;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;

    sget-object v1, Lcom/android/internal/telephony/DctConstants$State;->RETRYING:Lcom/android/internal/telephony/DctConstants$State;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;

    sget-object v1, Lcom/android/internal/telephony/DctConstants$State;->FAILED:Lcom/android/internal/telephony/DctConstants$State;

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isConnectedOrConnecting()Z
    .locals 2

    .prologue
    .line 283
    invoke-virtual {p0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->isReady()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;

    sget-object v1, Lcom/android/internal/telephony/DctConstants$State;->CONNECTED:Lcom/android/internal/telephony/DctConstants$State;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;

    sget-object v1, Lcom/android/internal/telephony/DctConstants$State;->CONNECTING:Lcom/android/internal/telephony/DctConstants$State;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;

    sget-object v1, Lcom/android/internal/telephony/DctConstants$State;->SCANNING:Lcom/android/internal/telephony/DctConstants$State;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;

    sget-object v1, Lcom/android/internal/telephony/DctConstants$State;->RETRYING:Lcom/android/internal/telephony/DctConstants$State;

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isDisconnected()Z
    .locals 2

    .prologue
    .line 255
    invoke-virtual {p0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getState()Lcom/android/internal/telephony/DctConstants$State;

    move-result-object v0

    .line 256
    .local v0, "currentState":Lcom/android/internal/telephony/DctConstants$State;
    sget-object v1, Lcom/android/internal/telephony/DctConstants$State;->IDLE:Lcom/android/internal/telephony/DctConstants$State;

    if-eq v0, v1, :cond_0

    sget-object v1, Lcom/android/internal/telephony/DctConstants$State;->FAILED:Lcom/android/internal/telephony/DctConstants$State;

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isEnabled()Z
    .locals 1

    .prologue
    .line 297
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDataEnabled:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    return v0
.end method

.method public isProvisioningApn()Z
    .locals 3

    .prologue
    .line 312
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x104002b

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 314
    .local v0, "provisioningApn":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnSetting:Lcom/android/internal/telephony/dataconnection/ApnSetting;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnSetting:Lcom/android/internal/telephony/dataconnection/ApnSetting;

    iget-object v1, v1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->apn:Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 316
    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnSetting:Lcom/android/internal/telephony/dataconnection/ApnSetting;

    iget-object v1, v1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->apn:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .line 318
    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isReady()Z
    .locals 1

    .prologue
    .line 272
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDataEnabled:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDependencyMet:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected log(Ljava/lang/String;)V
    .locals 3
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    .line 360
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->LOG_TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[ApnContext:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 361
    return-void
.end method

.method public declared-synchronized removeWaitingApn(Lcom/android/internal/telephony/dataconnection/ApnSetting;)V
    .locals 1
    .param p1, "apn"    # Lcom/android/internal/telephony/dataconnection/ApnSetting;

    .prologue
    .line 227
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApns:Ljava/util/ArrayList;

    if-eqz v0, :cond_0

    .line 228
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApns:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 230
    :cond_0
    monitor-exit p0

    return-void

    .line 227
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setApnSetting(Lcom/android/internal/telephony/dataconnection/ApnSetting;)V
    .locals 2
    .param p1, "apnSetting"    # Lcom/android/internal/telephony/dataconnection/ApnSetting;

    .prologue
    .line 197
    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "setApnSetting: apnSetting="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->log(Ljava/lang/String;)V

    .line 198
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnSetting:Lcom/android/internal/telephony/dataconnection/ApnSetting;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 199
    monitor-exit p0

    return-void

    .line 197
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setDataConnectionAc(Lcom/android/internal/telephony/dataconnection/DcAsyncChannel;)V
    .locals 1
    .param p1, "dcac"    # Lcom/android/internal/telephony/dataconnection/DcAsyncChannel;

    .prologue
    .line 180
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDcAc:Lcom/android/internal/telephony/dataconnection/DcAsyncChannel;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 181
    monitor-exit p0

    return-void

    .line 180
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public setDependencyMet(Z)V
    .locals 1
    .param p1, "met"    # Z

    .prologue
    .line 304
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDependencyMet:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 305
    return-void
.end method

.method public setEnabled(Z)V
    .locals 1
    .param p1, "enabled"    # Z

    .prologue
    .line 293
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDataEnabled:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 294
    return-void
.end method

.method public declared-synchronized setReason(Ljava/lang/String;)V
    .locals 1
    .param p1, "reason"    # Ljava/lang/String;

    .prologue
    .line 264
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mReason:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 265
    monitor-exit p0

    return-void

    .line 264
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setReconnectIntent(Landroid/app/PendingIntent;)V
    .locals 1
    .param p1, "intent"    # Landroid/app/PendingIntent;

    .prologue
    .line 188
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mReconnectAlarmIntent:Landroid/app/PendingIntent;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 189
    monitor-exit p0

    return-void

    .line 188
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setState(Lcom/android/internal/telephony/DctConstants$State;)V
    .locals 2
    .param p1, "s"    # Lcom/android/internal/telephony/DctConstants$State;

    .prologue
    .line 241
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;

    .line 243
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mState:Lcom/android/internal/telephony/DctConstants$State;

    sget-object v1, Lcom/android/internal/telephony/DctConstants$State;->FAILED:Lcom/android/internal/telephony/DctConstants$State;

    if-ne v0, v1, :cond_0

    .line 244
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApns:Ljava/util/ArrayList;

    if-eqz v0, :cond_0

    .line 245
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApns:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 248
    :cond_0
    monitor-exit p0

    return-void

    .line 241
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized setWaitingApns(Ljava/util/ArrayList;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/dataconnection/ApnSetting;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 202
    .local p1, "waitingApns":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/dataconnection/ApnSetting;>;"
    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApns:Ljava/util/ArrayList;

    .line 203
    iget-object v0, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApnsPermanentFailureCountDown:Ljava/util/concurrent/atomic/AtomicInteger;

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApns:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;->set(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 204
    monitor-exit p0

    return-void

    .line 202
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 353
    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "{mApnType="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mState="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getState()Lcom/android/internal/telephony/DctConstants$State;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mWaitingApns={"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApns:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "} mWaitingApnsPermanentFailureCountDown="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mWaitingApnsPermanentFailureCountDown:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mApnSetting={"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mApnSetting:Lcom/android/internal/telephony/dataconnection/ApnSetting;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "} mReason="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mReason:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mDataEnabled="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDataEnabled:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mDependencyMet="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/dataconnection/ApnContext;->mDependencyMet:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
