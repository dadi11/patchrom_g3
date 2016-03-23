.class public Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;
.super Ljava/lang/Object;
.source "SplitWindowCreatorHelper.java"


# static fields
.field private static SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

.field private static TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    const-string v0, "SplitWindowCreatorHelper"

    sput-object v0, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getPolicyService()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    .locals 3

    .prologue
    sget-object v1, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    if-nez v1, :cond_0

    sget-object v1, Lcom/lge/loader/RuntimeLibraryLoader;->SPLIT_WINDOW:Ljava/lang/String;

    invoke-static {v1}, Lcom/lge/loader/RuntimeLibraryLoader;->getCreator(Ljava/lang/String;)Lcom/lge/loader/InstanceCreator;

    move-result-object v0

    .local v0, "creator":Lcom/lge/loader/InstanceCreator;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/lge/loader/InstanceCreator;->getDefaultInstance()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/loader/splitwindow/ISplitWindow;

    sput-object v1, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    :cond_0
    sget-object v1, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    if-eqz v1, :cond_1

    sget-object v2, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    monitor-enter v2

    :try_start_0
    sget-object v1, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    invoke-interface {v1}, Lcom/lge/loader/splitwindow/ISplitWindow;->getPolicyService()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v1

    monitor-exit v2

    :goto_0
    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static launchService(Landroid/content/Context;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    sget-object v1, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    if-nez v1, :cond_0

    sget-object v1, Lcom/lge/loader/RuntimeLibraryLoader;->SPLIT_WINDOW:Ljava/lang/String;

    invoke-static {v1}, Lcom/lge/loader/RuntimeLibraryLoader;->getCreator(Ljava/lang/String;)Lcom/lge/loader/InstanceCreator;

    move-result-object v0

    .local v0, "creator":Lcom/lge/loader/InstanceCreator;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/lge/loader/InstanceCreator;->getDefaultInstance()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/loader/splitwindow/ISplitWindow;

    sput-object v1, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    .end local v0    # "creator":Lcom/lge/loader/InstanceCreator;
    :cond_0
    sget-object v1, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    invoke-interface {v1, p0}, Lcom/lge/loader/splitwindow/ISplitWindow;->launchService(Landroid/content/Context;)V

    :cond_1
    return-void
.end method

.method public static recoverService()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;
    .locals 4

    .prologue
    const/4 v3, 0x0

    sget-object v1, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->TAG:Ljava/lang/String;

    const-string v2, "recoverService"

    invoke-static {v1, v2}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v1, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/lge/loader/RuntimeLibraryLoader;->SPLIT_WINDOW:Ljava/lang/String;

    invoke-static {v1}, Lcom/lge/loader/RuntimeLibraryLoader;->getCreator(Ljava/lang/String;)Lcom/lge/loader/InstanceCreator;

    move-result-object v0

    .local v0, "creator":Lcom/lge/loader/InstanceCreator;
    if-eqz v0, :cond_0

    invoke-virtual {v0, v3}, Lcom/lge/loader/InstanceCreator;->setDefaultInstance(Ljava/lang/Object;)V

    sget-object v1, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->TAG:Ljava/lang/String;

    const-string v2, "Set default InstanceCreator as null to make NEW instance"

    invoke-static {v1, v2}, Landroid/util/Slog;->v(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    sput-object v3, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->SPLITWINDOW_INSTANCE:Lcom/lge/loader/splitwindow/ISplitWindow;

    :cond_1
    invoke-static {}, Lcom/lge/loader/splitwindow/SplitWindowCreatorHelper;->getPolicyService()Lcom/lge/loader/splitwindow/ISplitWindow$ISplitWindowPolicy;

    move-result-object v1

    return-object v1
.end method
