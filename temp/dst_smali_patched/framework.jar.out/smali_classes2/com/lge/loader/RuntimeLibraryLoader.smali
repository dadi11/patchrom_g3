.class public Lcom/lge/loader/RuntimeLibraryLoader;
.super Ljava/lang/Object;
.source "RuntimeLibraryLoader.java"


# static fields
.field public static CLIPTRAY_MANAGER:Ljava/lang/String;

.field private static FACTORY_MAP:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Landroid/util/Singleton",
            "<",
            "Lcom/lge/loader/InstanceCreator;",
            ">;>;"
        }
    .end annotation
.end field

.field public static MDM:Ljava/lang/String;

.field public static MDM_SPRINT:Ljava/lang/String;

.field public static SPLIT_WINDOW:Ljava/lang/String;

.field public static VOLUME_MANAGER:Ljava/lang/String;

.field public static ZDI_INTERACTION:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->FACTORY_MAP:Ljava/util/HashMap;

    const-string v0, "volume"

    sput-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->VOLUME_MANAGER:Ljava/lang/String;

    const-string v0, "cliptray"

    sput-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->CLIPTRAY_MANAGER:Ljava/lang/String;

    const-string v0, "mdm"

    sput-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->MDM:Ljava/lang/String;

    const-string v0, "mdm_sprint"

    sput-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->MDM_SPRINT:Ljava/lang/String;

    const-string v0, "splitwindow"

    sput-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->SPLIT_WINDOW:Ljava/lang/String;

    const-string v0, "zdi_interaction"

    sput-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->ZDI_INTERACTION:Ljava/lang/String;

    sget-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->CLIPTRAY_MANAGER:Ljava/lang/String;

    new-instance v1, Lcom/lge/loader/RuntimeLibraryLoader$1;

    invoke-direct {v1}, Lcom/lge/loader/RuntimeLibraryLoader$1;-><init>()V

    invoke-static {v0, v1}, Lcom/lge/loader/RuntimeLibraryLoader;->registerCreator(Ljava/lang/String;Landroid/util/Singleton;)V

    sget-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->VOLUME_MANAGER:Ljava/lang/String;

    new-instance v1, Lcom/lge/loader/RuntimeLibraryLoader$2;

    invoke-direct {v1}, Lcom/lge/loader/RuntimeLibraryLoader$2;-><init>()V

    invoke-static {v0, v1}, Lcom/lge/loader/RuntimeLibraryLoader;->registerCreator(Ljava/lang/String;Landroid/util/Singleton;)V

    sget-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->SPLIT_WINDOW:Ljava/lang/String;

    new-instance v1, Lcom/lge/loader/RuntimeLibraryLoader$3;

    invoke-direct {v1}, Lcom/lge/loader/RuntimeLibraryLoader$3;-><init>()V

    invoke-static {v0, v1}, Lcom/lge/loader/RuntimeLibraryLoader;->registerCreator(Ljava/lang/String;Landroid/util/Singleton;)V

    sget-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->ZDI_INTERACTION:Ljava/lang/String;

    new-instance v1, Lcom/lge/loader/RuntimeLibraryLoader$4;

    invoke-direct {v1}, Lcom/lge/loader/RuntimeLibraryLoader$4;-><init>()V

    invoke-static {v0, v1}, Lcom/lge/loader/RuntimeLibraryLoader;->registerCreator(Ljava/lang/String;Landroid/util/Singleton;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getCreator(Ljava/lang/String;)Lcom/lge/loader/InstanceCreator;
    .locals 1
    .param p0, "moduleName"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/lge/loader/RuntimeLibraryLoader;->getCreator(Ljava/lang/String;Ljava/lang/Object;)Lcom/lge/loader/InstanceCreator;

    move-result-object v0

    return-object v0
.end method

.method public static getCreator(Ljava/lang/String;Ljava/lang/Object;)Lcom/lge/loader/InstanceCreator;
    .locals 2
    .param p0, "moduleName"    # Ljava/lang/String;
    .param p1, "args"    # Ljava/lang/Object;

    .prologue
    sget-object v1, Lcom/lge/loader/RuntimeLibraryLoader;->FACTORY_MAP:Ljava/util/HashMap;

    invoke-virtual {v1, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/Singleton;

    .local v0, "singletonCreator":Landroid/util/Singleton;, "Landroid/util/Singleton<Lcom/lge/loader/InstanceCreator;>;"
    if-nez v0, :cond_0

    const/4 v1, 0x0

    :goto_0
    return-object v1

    :cond_0
    invoke-virtual {v0}, Landroid/util/Singleton;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/loader/InstanceCreator;

    goto :goto_0
.end method

.method private static registerCreator(Ljava/lang/String;Landroid/util/Singleton;)V
    .locals 1
    .param p0, "factoryName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Landroid/util/Singleton",
            "<",
            "Lcom/lge/loader/InstanceCreator;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "factory":Landroid/util/Singleton;, "Landroid/util/Singleton<Lcom/lge/loader/InstanceCreator;>;"
    sget-object v0, Lcom/lge/loader/RuntimeLibraryLoader;->FACTORY_MAP:Ljava/util/HashMap;

    invoke-virtual {v0, p0, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
