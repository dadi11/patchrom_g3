.class public Lcom/lge/zdi/recommender/ZdiRecommender;
.super Ljava/lang/Object;
.source "ZdiRecommender.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/zdi/recommender/ZdiRecommender$ZdiRecommenderListener;
    }
.end annotation


# static fields
.field private static final SERVICE_NAME:Ljava/lang/String; = "com.lge.zdi.ZdiIntelligentService"

.field public static final TAG:Ljava/lang/String; = "ZDiRecommender"


# instance fields
.field private final connection:Landroid/content/ServiceConnection;

.field private listener:Lcom/lge/zdi/recommender/ZdiRecommender$ZdiRecommenderListener;

.field private final mContext:Landroid/content/Context;

.field private recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/lge/zdi/recommender/ZdiRecommender$ZdiRecommenderListener;)V
    .locals 3
    .param p1, "ctx"    # Landroid/content/Context;
    .param p2, "l"    # Lcom/lge/zdi/recommender/ZdiRecommender$ZdiRecommenderListener;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/lge/zdi/recommender/ZdiRecommender$1;

    invoke-direct {v0, p0}, Lcom/lge/zdi/recommender/ZdiRecommender$1;-><init>(Lcom/lge/zdi/recommender/ZdiRecommender;)V

    iput-object v0, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->connection:Landroid/content/ServiceConnection;

    if-eqz p1, :cond_1

    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.zdi.ZdiIntelligentService"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->connection:Landroid/content/ServiceConnection;

    const/16 v2, 0x40

    invoke-virtual {p1, v0, v1, v2}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "ZDiRecommender"

    const-string v1, "Connect to com.lge.zdi.ZdiIntelligentService failed!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iput-object p1, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->mContext:Landroid/content/Context;

    :goto_0
    return-void

    :cond_1
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->mContext:Landroid/content/Context;

    goto :goto_0
.end method

.method static synthetic access$002(Lcom/lge/zdi/recommender/ZdiRecommender;Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;)Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;
    .locals 0
    .param p0, "x0"    # Lcom/lge/zdi/recommender/ZdiRecommender;
    .param p1, "x1"    # Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    .prologue
    iput-object p1, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    return-object p1
.end method

.method static synthetic access$100(Lcom/lge/zdi/recommender/ZdiRecommender;)Lcom/lge/zdi/recommender/ZdiRecommender$ZdiRecommenderListener;
    .locals 1
    .param p0, "x0"    # Lcom/lge/zdi/recommender/ZdiRecommender;

    .prologue
    iget-object v0, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->listener:Lcom/lge/zdi/recommender/ZdiRecommender$ZdiRecommenderListener;

    return-object v0
.end method


# virtual methods
.method public checkZdiRecommend()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    invoke-interface {v2}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;->checkZdiRecommend()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const-string v2, "ZDiRecommender"

    const-string v3, "checkZdiRecommend => ERROR! service not connected..."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public disconnect()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->mContext:Landroid/content/Context;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->connection:Landroid/content/ServiceConnection;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    :cond_0
    return-void
.end method

.method public getGlobalRecApp(I)Ljava/util/List;
    .locals 4
    .param p1, "count"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Ljava/util/List",
            "<",
            "Lcom/lge/zdi/recommender/common/RankedApp;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    invoke-interface {v2, p1}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;->getGlobalRecApp(I)Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const-string v2, "ZDiRecommender"

    const-string v3, "getGlobalRecApp => ERROR! service not connected..."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getGlobalRecPairApp(Ljava/lang/String;Ljava/lang/String;I)Ljava/util/List;
    .locals 4
    .param p1, "ignorepkg1"    # Ljava/lang/String;
    .param p2, "ignorepkg2"    # Ljava/lang/String;
    .param p3, "count"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "I)",
            "Ljava/util/List",
            "<",
            "Lcom/lge/zdi/recommender/common/RankedApp;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    invoke-interface {v2, p1, p2, p3}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;->getGlobalRecPairApp(Ljava/lang/String;Ljava/lang/String;I)Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const-string v2, "ZDiRecommender"

    const-string v3, "getGlobalRecPairApp => ERROR! service not connected..."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getIndividualRecApp(Ljava/lang/String;Ljava/lang/String;I)Ljava/util/List;
    .locals 4
    .param p1, "pkgName1"    # Ljava/lang/String;
    .param p2, "pkgName2"    # Ljava/lang/String;
    .param p3, "count"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "I)",
            "Ljava/util/List",
            "<",
            "Lcom/lge/zdi/recommender/common/RankedApp;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    invoke-interface {v2, p1, p2, p3}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;->getIndividualRecApp(Ljava/lang/String;Ljava/lang/String;I)Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const-string v2, "ZDiRecommender"

    const-string v3, "getIndividualRecApp => ERROR! service not connected..."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getRecAppList(Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;)V
    .locals 8
    .param p5, "ignorepkg1"    # Ljava/lang/String;
    .param p6, "ignorepkg2"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/lge/zdi/recommender/common/RankedApp;",
            ">;",
            "Ljava/util/List",
            "<",
            "Lcom/lge/zdi/recommender/common/RankedApp;",
            ">;",
            "Ljava/util/List",
            "<",
            "Lcom/lge/zdi/recommender/common/RankedApp;",
            ">;",
            "Ljava/util/List",
            "<",
            "Lcom/lge/zdi/recommender/common/RankedApp;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .local p1, "recentlist":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    .local p2, "globalpairlist":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    .local p3, "indilist":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    .local p4, "globallist":Ljava/util/List;, "Ljava/util/List<Lcom/lge/zdi/recommender/common/RankedApp;>;"
    iget-object v0, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    if-eqz v0, :cond_0

    :try_start_0
    iget-object v0, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    invoke-interface/range {v0 .. v6}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;->getRecAppList(Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v7

    .local v7, "e":Landroid/os/RemoteException;
    invoke-virtual {v7}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v7    # "e":Landroid/os/RemoteException;
    :cond_0
    const-string v0, "ZDiRecommender"

    const-string v1, "getRecAppList => ERROR! service not connected..."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getRecentPairApp(I)Ljava/util/List;
    .locals 4
    .param p1, "count"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Ljava/util/List",
            "<",
            "Lcom/lge/zdi/recommender/common/RankedApp;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    invoke-interface {v2, p1}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;->getRecentPairApp(I)Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const-string v2, "ZDiRecommender"

    const-string v3, "getRecentPairApp => ERROR! service not connected..."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getRecentlyUsedApp(I)Ljava/util/List;
    .locals 4
    .param p1, "count"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Ljava/util/List",
            "<",
            "Lcom/lge/zdi/recommender/common/RankedApp;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/zdi/recommender/ZdiRecommender;->recommendConnector:Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;

    invoke-interface {v2, p1}, Lcom/lge/zdi/recommender/binder/ZdiRecommendConnector;->getRecentlyUsedApp(I)Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const-string v2, "ZDiRecommender"

    const-string v3, "getRecentlyUsedApp => ERROR! service not connected..."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
