.class abstract Lcom/lge/systemservice/core/LGContext$LGServiceManagerFetcher;
.super Ljava/lang/Object;
.source "LGContext.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/systemservice/core/LGContext;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x40a
    name = "LGServiceManagerFetcher"
.end annotation


# instance fields
.field private mCachedInstance:Ljava/lang/Object;

.field private final mFeatureName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/systemservice/core/LGContext$LGServiceManagerFetcher;->mFeatureName:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "featureName"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/systemservice/core/LGContext$LGServiceManagerFetcher;->mFeatureName:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public abstract createServiceManager(Landroid/content/Context;)Ljava/lang/Object;
.end method

.method public declared-synchronized getService(Landroid/content/Context;)Ljava/lang/Object;
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/lge/systemservice/core/LGContext$LGServiceManagerFetcher;->mCachedInstance:Ljava/lang/Object;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/lge/systemservice/core/LGContext$LGServiceManagerFetcher;->mFeatureName:Ljava/lang/String;

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/systemservice/core/LGContext$LGServiceManagerFetcher;->mFeatureName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    invoke-virtual {p0, p1}, Lcom/lge/systemservice/core/LGContext$LGServiceManagerFetcher;->createServiceManager(Landroid/content/Context;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/systemservice/core/LGContext$LGServiceManagerFetcher;->mCachedInstance:Ljava/lang/Object;

    :cond_1
    iget-object v0, p0, Lcom/lge/systemservice/core/LGContext$LGServiceManagerFetcher;->mCachedInstance:Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
