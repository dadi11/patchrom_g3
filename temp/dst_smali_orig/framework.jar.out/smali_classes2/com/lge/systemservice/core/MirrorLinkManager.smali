.class public Lcom/lge/systemservice/core/MirrorLinkManager;
.super Ljava/lang/Object;
.source "MirrorLinkManager.java"


# static fields
.field public static final FEATURE_NAME:Ljava/lang/String; = "com.lge.software.mirrorlink"

.field public static final SERVICE_NAME:Ljava/lang/String; = "mirrorlinkservice"

.field private static final TAG:Ljava/lang/String; = "MirrorLinkManager"


# instance fields
.field private mService:Lcom/lge/systemservice/core/IMirrorLinkManager;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    return-void
.end method

.method private final getService()Lcom/lge/systemservice/core/IMirrorLinkManager;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    if-nez v0, :cond_0

    const-string v0, "mirrorlinkservice"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/systemservice/core/IMirrorLinkManager$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/systemservice/core/IMirrorLinkManager;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    :cond_0
    iget-object v0, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    return-object v0
.end method


# virtual methods
.method public tzReadPCR([BI)I
    .locals 4
    .param p1, "pcrvalue"    # [B
    .param p2, "index"    # I

    .prologue
    const/4 v1, 0x0

    .local v1, "ret":I
    const-string v2, "MirrorLinkManager"

    const-string v3, "[START] tzReadPCR"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/MirrorLinkManager;->getService()Lcom/lge/systemservice/core/IMirrorLinkManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    iget-object v2, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    invoke-interface {v2, p1, p2}, Lcom/lge/systemservice/core/IMirrorLinkManager;->tzReadPCR([BI)I
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
    const-string v2, "MirrorLinkManager"

    const-string v3, "getService is null"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public tzTPMExtend([BI)I
    .locals 4
    .param p1, "pcrvalue"    # [B
    .param p2, "index"    # I

    .prologue
    const/4 v1, 0x0

    .local v1, "ret":I
    const-string v2, "MirrorLinkManager"

    const-string v3, "[START] tzTPMExtend"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/MirrorLinkManager;->getService()Lcom/lge/systemservice/core/IMirrorLinkManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    iget-object v2, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    invoke-interface {v2, p1, p2}, Lcom/lge/systemservice/core/IMirrorLinkManager;->tzTPMExtend([BI)I
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
    const-string v2, "MirrorLinkManager"

    const-string v3, "getService is null"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public tzTPMQuote([BI[B[B)I
    .locals 4
    .param p1, "externalData"    # [B
    .param p2, "index"    # I
    .param p3, "quoteSignature"    # [B
    .param p4, "tzQuoteInfo"    # [B

    .prologue
    const/4 v1, 0x0

    .local v1, "ret":I
    const-string v2, "MirrorLinkManager"

    const-string v3, "[START] tzTPMQuote"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/systemservice/core/MirrorLinkManager;->getService()Lcom/lge/systemservice/core/IMirrorLinkManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    iget-object v2, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/systemservice/core/MirrorLinkManager;->mService:Lcom/lge/systemservice/core/IMirrorLinkManager;

    invoke-interface {v2, p1, p2, p3, p4}, Lcom/lge/systemservice/core/IMirrorLinkManager;->tzTPMQuote([BI[B[B)I
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
    const-string v2, "MirrorLinkManager"

    const-string v3, "getService is null"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public tzWritePCR([BI)I
    .locals 2
    .param p1, "pcrvalue"    # [B
    .param p2, "index"    # I

    .prologue
    const-string v0, "MirrorLinkManager"

    const-string v1, "[START] tzWritePCR"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return v0
.end method
