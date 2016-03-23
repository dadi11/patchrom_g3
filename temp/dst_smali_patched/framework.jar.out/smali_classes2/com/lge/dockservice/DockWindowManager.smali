.class public Lcom/lge/dockservice/DockWindowManager;
.super Ljava/lang/Object;
.source "DockWindowManager.java"


# static fields
.field static final POSITION_CENTER:I = -0x2

.field static final POSITION_CURRENT:I = -0x1

.field private static final TAG:Ljava/lang/String; = "DockWindowManager"

.field private static isServiceAvailable:Z

.field private static isServiceAvailableConfirmed:Z

.field private static sDefault:Lcom/lge/dockservice/DockWindowManager;


# instance fields
.field private mBaseDockWindow:Lcom/lge/dockservice/BaseDockWindow;

.field private final mContext:Landroid/content/Context;

.field private final mDockAreaBerth:I

.field private final mDockWindows:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lge/dockservice/DockableWindow;",
            ">;"
        }
    .end annotation
.end field

.field private mService:Lcom/lge/dockservice/IDockWindowService;

.field private mServiceConnection:Landroid/content/ServiceConnection;

.field private pendingDockVisible:Z

.field private pendingDockX:I

.field private pendingDockY:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    sput-object v0, Lcom/lge/dockservice/DockWindowManager;->sDefault:Lcom/lge/dockservice/DockWindowManager;

    sput-boolean v1, Lcom/lge/dockservice/DockWindowManager;->isServiceAvailable:Z

    sput-boolean v1, Lcom/lge/dockservice/DockWindowManager;->isServiceAvailableConfirmed:Z

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;Lcom/lge/dockservice/BaseDockWindow;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "basedockwindow"    # Lcom/lge/dockservice/BaseDockWindow;

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mDockWindows:Ljava/util/List;

    iput v2, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockX:I

    iput v2, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockY:I

    iput-boolean v2, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockVisible:Z

    new-instance v1, Lcom/lge/dockservice/DockWindowManager$1;

    invoke-direct {v1, p0}, Lcom/lge/dockservice/DockWindowManager$1;-><init>(Lcom/lge/dockservice/DockWindowManager;)V

    iput-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mServiceConnection:Landroid/content/ServiceConnection;

    iput-object v3, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    iput-object v3, p0, Lcom/lge/dockservice/DockWindowManager;->mBaseDockWindow:Lcom/lge/dockservice/BaseDockWindow;

    const-string v1, "DockWindowManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "create DockWindowManager "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    iput-object p1, p0, Lcom/lge/dockservice/DockWindowManager;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/lge/dockservice/DockWindowManager;->mBaseDockWindow:Lcom/lge/dockservice/BaseDockWindow;

    invoke-static {p1}, Lcom/lge/dockservice/Res;->getResources(Landroid/content/Context;)Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f06000c

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelOffset(I)I

    move-result v1

    iput v1, p0, Lcom/lge/dockservice/DockWindowManager;->mDockAreaBerth:I

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .local v0, "i":Landroid/content/Intent;
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.lge.app.floating.res"

    const-class v3, Lcom/lge/dockservice/DockWindowService;

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowManager;->mServiceConnection:Landroid/content/ServiceConnection;

    const/4 v3, 0x1

    invoke-virtual {v1, v0, v2, v3}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    const-string v1, "DockWindowManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Request bind dock service : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowManager;->mServiceConnection:Landroid/content/ServiceConnection;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", service = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method static synthetic access$002(Lcom/lge/dockservice/DockWindowManager;Lcom/lge/dockservice/IDockWindowService;)Lcom/lge/dockservice/IDockWindowService;
    .locals 0
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowManager;
    .param p1, "x1"    # Lcom/lge/dockservice/IDockWindowService;

    .prologue
    iput-object p1, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    return-object p1
.end method

.method static synthetic access$100(Lcom/lge/dockservice/DockWindowManager;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowManager;

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/DockWindowManager;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$200(Lcom/lge/dockservice/DockWindowManager;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowManager;

    .prologue
    iget v0, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockX:I

    return v0
.end method

.method static synthetic access$202(Lcom/lge/dockservice/DockWindowManager;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowManager;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockX:I

    return p1
.end method

.method static synthetic access$300(Lcom/lge/dockservice/DockWindowManager;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowManager;

    .prologue
    iget v0, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockY:I

    return v0
.end method

.method static synthetic access$302(Lcom/lge/dockservice/DockWindowManager;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowManager;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockY:I

    return p1
.end method

.method static synthetic access$400(Lcom/lge/dockservice/DockWindowManager;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowManager;

    .prologue
    iget-boolean v0, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockVisible:Z

    return v0
.end method

.method static synthetic access$402(Lcom/lge/dockservice/DockWindowManager;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowManager;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockVisible:Z

    return p1
.end method

.method public static getDefault(Landroid/content/Context;Lcom/lge/dockservice/BaseDockWindow;)Lcom/lge/dockservice/DockWindowManager;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "mBaseDockWindow"    # Lcom/lge/dockservice/BaseDockWindow;

    .prologue
    new-instance v0, Lcom/lge/dockservice/DockWindowManager;

    invoke-direct {v0, p0, p1}, Lcom/lge/dockservice/DockWindowManager;-><init>(Landroid/content/Context;Lcom/lge/dockservice/BaseDockWindow;)V

    sput-object v0, Lcom/lge/dockservice/DockWindowManager;->sDefault:Lcom/lge/dockservice/DockWindowManager;

    sget-object v0, Lcom/lge/dockservice/DockWindowManager;->sDefault:Lcom/lge/dockservice/DockWindowManager;

    return-object v0
.end method

.method private getUndockArea()Landroid/graphics/Rect;
    .locals 6

    .prologue
    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .local v0, "dm":Landroid/util/DisplayMetrics;
    new-instance v1, Landroid/graphics/Rect;

    iget v2, p0, Lcom/lge/dockservice/DockWindowManager;->mDockAreaBerth:I

    const/4 v3, 0x0

    iget v4, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v5, p0, Lcom/lge/dockservice/DockWindowManager;->mDockAreaBerth:I

    sub-int/2addr v4, v5

    iget v5, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-direct {v1, v2, v3, v4, v5}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v1
.end method

.method static isServiceAvailable(Landroid/content/Context;)Z
    .locals 6
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v5, 0x0

    const/4 v2, 0x1

    sget-boolean v3, Lcom/lge/dockservice/DockWindowManager;->isServiceAvailableConfirmed:Z

    if-eqz v3, :cond_0

    sget-boolean v2, Lcom/lge/dockservice/DockWindowManager;->isServiceAvailable:Z

    :goto_0
    return v2

    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .local v1, "pm":Landroid/content/pm/PackageManager;
    :try_start_0
    new-instance v3, Landroid/content/ComponentName;

    const-class v4, Lcom/lge/dockservice/DockWindowService;

    invoke-direct {v3, p0, v4}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/4 v4, 0x0

    invoke-virtual {v1, v3, v4}, Landroid/content/pm/PackageManager;->getServiceInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ServiceInfo;

    move-result-object v3

    if-eqz v3, :cond_1

    const/4 v3, 0x1

    sput-boolean v3, Lcom/lge/dockservice/DockWindowManager;->isServiceAvailable:Z

    const/4 v3, 0x1

    sput-boolean v3, Lcom/lge/dockservice/DockWindowManager;->isServiceAvailableConfirmed:Z
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    const-string v3, "DockWindowManager"

    const-string v4, "DockWindowService is not added in the AndroidManifest.xml file."

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v3, "DockWindowManager"

    const-string v4, "Add <service android:name=\"com.lge.dockservice.DockWindowService\"></service> under <application/> tag"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :cond_1
    sput-boolean v5, Lcom/lge/dockservice/DockWindowManager;->isServiceAvailable:Z

    sput-boolean v2, Lcom/lge/dockservice/DockWindowManager;->isServiceAvailableConfirmed:Z

    sget-boolean v2, Lcom/lge/dockservice/DockWindowManager;->isServiceAvailable:Z

    goto :goto_0
.end method


# virtual methods
.method addDockableWindow(Lcom/lge/dockservice/DockableWindow;)V
    .locals 1
    .param p1, "window"    # Lcom/lge/dockservice/DockableWindow;

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/DockWindowManager;->mDockWindows:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/lge/dockservice/DockWindowManager;->mDockWindows:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public getClientRect(Ljava/lang/String;)Landroid/graphics/Rect;
    .locals 4
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    iget-object v3, p0, Lcom/lge/dockservice/DockWindowManager;->mDockWindows:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/dockservice/DockableWindow;>;"
    const/4 v0, 0x0

    .local v0, "clientRect":Landroid/graphics/Rect;
    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/dockservice/DockableWindow;

    .local v1, "dockableWindow":Lcom/lge/dockservice/DockableWindow;
    invoke-interface {v1}, Lcom/lge/dockservice/DockableWindow;->getClientPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v1}, Lcom/lge/dockservice/DockableWindow;->getClientRect()Landroid/graphics/Rect;

    move-result-object v0

    goto :goto_0

    .end local v1    # "dockableWindow":Lcom/lge/dockservice/DockableWindow;
    :cond_1
    return-object v0
.end method

.method public getDockDirection(Lcom/lge/dockservice/DockableWindow;)I
    .locals 4
    .param p1, "window"    # Lcom/lge/dockservice/DockableWindow;

    .prologue
    invoke-direct {p0}, Lcom/lge/dockservice/DockWindowManager;->getUndockArea()Landroid/graphics/Rect;

    move-result-object v1

    .local v1, "undockArea":Landroid/graphics/Rect;
    invoke-interface {p1}, Lcom/lge/dockservice/DockableWindow;->getClientRect()Landroid/graphics/Rect;

    move-result-object v0

    .local v0, "clientRect":Landroid/graphics/Rect;
    iget v2, v0, Landroid/graphics/Rect;->right:I

    iget v3, v1, Landroid/graphics/Rect;->left:I

    if-ge v2, v3, :cond_0

    const/4 v2, 0x2

    :goto_0
    return v2

    :cond_0
    iget v2, v0, Landroid/graphics/Rect;->left:I

    iget v3, v1, Landroid/graphics/Rect;->right:I

    if-le v2, v3, :cond_1

    const/4 v2, 0x3

    goto :goto_0

    :cond_1
    const/4 v2, -0x1

    goto :goto_0
.end method

.method getDockWindowPosition(Ljava/lang/String;)[I
    .locals 4
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    const-string v2, "DockWindowManager"

    const-string v3, "getDockWindowPosition"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    .local v0, "dockPosition":[I
    iget-object v2, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    if-eqz v2, :cond_0

    :try_start_0
    iget-object v2, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    invoke-interface {v2, p1}, Lcom/lge/dockservice/IDockWindowService;->getDockPosition(Ljava/lang/String;)[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v1

    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_0
    const-string v2, "DockWindowManager"

    const-string v3, "no service available"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public handleDockTouchEvent(Landroid/view/MotionEvent;Landroid/graphics/Bitmap;)V
    .locals 4
    .param p1, "event"    # Landroid/view/MotionEvent;
    .param p2, "dockIconBitmap"    # Landroid/graphics/Bitmap;

    .prologue
    const-string v1, "DockWindowManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sendDockTouchEvent : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    if-eqz v1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowManager;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowManager;->mBaseDockWindow:Lcom/lge/dockservice/BaseDockWindow;

    invoke-virtual {v3}, Lcom/lge/dockservice/BaseDockWindow;->asBinder()Landroid/os/IBinder;

    move-result-object v3

    invoke-interface {v1, v2, v3, p2, p1}, Lcom/lge/dockservice/IDockWindowService;->handleDockTouchEvent(Ljava/lang/String;Landroid/os/IBinder;Landroid/graphics/Bitmap;Landroid/view/MotionEvent;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "DockWindowManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RemoteException occured in sendDockTouchEvent : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Landroid/os/RemoteException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public initDock(Ljava/lang/String;IIZ)V
    .locals 8
    .param p1, "activityName"    # Ljava/lang/String;
    .param p2, "x"    # I
    .param p3, "y"    # I
    .param p4, "initToShow"    # Z

    .prologue
    const-string v0, "DockWindowManager"

    const-string v1, "init DockWindow"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    if-eqz v0, :cond_0

    :try_start_0
    iget-object v0, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowManager;->mBaseDockWindow:Lcom/lge/dockservice/BaseDockWindow;

    invoke-virtual {v2}, Lcom/lge/dockservice/BaseDockWindow;->asBinder()Landroid/os/IBinder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowManager;->mBaseDockWindow:Lcom/lge/dockservice/BaseDockWindow;

    invoke-virtual {v3}, Lcom/lge/dockservice/BaseDockWindow;->getDockIconBitmap()Landroid/graphics/Bitmap;

    move-result-object v3

    move v4, p2

    move v5, p3

    move v6, p4

    invoke-interface/range {v0 .. v6}, Lcom/lge/dockservice/IDockWindowService;->initDockWindow(Ljava/lang/String;Landroid/os/IBinder;Landroid/graphics/Bitmap;IIZ)V
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
    const-string v0, "DockWindowManager"

    const-string v1, "no service available"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "DockWindowManager"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "set pending dock x,y,visible to ( "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " , "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " , "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " ) "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iput p2, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockX:I

    iput p3, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockY:I

    iput-boolean p4, p0, Lcom/lge/dockservice/DockWindowManager;->pendingDockVisible:Z

    goto :goto_0
.end method

.method isDockServiceReady()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isInDockArea(Landroid/graphics/Rect;)I
    .locals 4
    .param p1, "clientRect"    # Landroid/graphics/Rect;

    .prologue
    invoke-direct {p0}, Lcom/lge/dockservice/DockWindowManager;->getUndockArea()Landroid/graphics/Rect;

    move-result-object v1

    .local v1, "undockArea":Landroid/graphics/Rect;
    const/4 v0, -0x1

    .local v0, "dockState":I
    iget v2, p1, Landroid/graphics/Rect;->right:I

    iget v3, v1, Landroid/graphics/Rect;->left:I

    if-ge v2, v3, :cond_0

    const-string v2, "DockWindowManager"

    const-string v3, "isInDockArea : true (DIRECTION_LEFT)"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x2

    :goto_0
    return v0

    :cond_0
    iget v2, p1, Landroid/graphics/Rect;->left:I

    iget v3, v1, Landroid/graphics/Rect;->right:I

    if-le v2, v3, :cond_1

    const-string v2, "DockWindowManager"

    const-string v3, "isInDockArea : true (DIRECTION_RIGHT)"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x3

    goto :goto_0

    :cond_1
    const-string v2, "DockWindowManager"

    const-string v3, "isInDockArea : false (DIRECTION_INVALID - means undock)"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, -0x1

    goto :goto_0
.end method

.method public isInDockArea(Lcom/lge/dockservice/DockableWindow;)Z
    .locals 3
    .param p1, "window"    # Lcom/lge/dockservice/DockableWindow;

    .prologue
    invoke-interface {p1}, Lcom/lge/dockservice/DockableWindow;->getClientRect()Landroid/graphics/Rect;

    move-result-object v0

    .local v0, "clientRect":Landroid/graphics/Rect;
    invoke-virtual {p0, v0}, Lcom/lge/dockservice/DockWindowManager;->isInDockArea(Landroid/graphics/Rect;)I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isInDockArea(Lcom/lge/dockservice/DockableWindow;II)Z
    .locals 6
    .param p1, "window"    # Lcom/lge/dockservice/DockableWindow;
    .param p2, "clientX"    # I
    .param p3, "clientY"    # I

    .prologue
    invoke-interface {p1}, Lcom/lge/dockservice/DockableWindow;->getClientRect()Landroid/graphics/Rect;

    move-result-object v1

    .local v1, "clientRect":Landroid/graphics/Rect;
    iget v4, v1, Landroid/graphics/Rect;->right:I

    iget v5, v1, Landroid/graphics/Rect;->left:I

    sub-int v2, v4, v5

    .local v2, "clientWidth":I
    iget v4, v1, Landroid/graphics/Rect;->bottom:I

    iget v5, v1, Landroid/graphics/Rect;->top:I

    sub-int v0, v4, v5

    .local v0, "clientHeight":I
    new-instance v3, Landroid/graphics/Rect;

    add-int v4, p2, v2

    add-int v5, p3, v0

    invoke-direct {v3, p2, p3, v4, v5}, Landroid/graphics/Rect;-><init>(IIII)V

    .local v3, "expectedClientRect":Landroid/graphics/Rect;
    invoke-virtual {p0, v3}, Lcom/lge/dockservice/DockWindowManager;->isInDockArea(Landroid/graphics/Rect;)I

    move-result v4

    const/4 v5, -0x1

    if-eq v4, v5, :cond_0

    const/4 v4, 0x1

    :goto_0
    return v4

    :cond_0
    const/4 v4, 0x0

    goto :goto_0
.end method

.method removeDockableWindow(Lcom/lge/dockservice/DockableWindow;)V
    .locals 1
    .param p1, "window"    # Lcom/lge/dockservice/DockableWindow;

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/DockWindowManager;->mDockWindows:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/dockservice/DockWindowManager;->mDockWindows:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public requestUndock(Ljava/lang/String;Z)V
    .locals 3
    .param p1, "packageName"    # Ljava/lang/String;
    .param p2, "startedAsFloating"    # Z

    .prologue
    const-string v1, "DockWindowManager"

    const-string v2, "requestUnDock"

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    if-eqz v1, :cond_1

    if-eqz p2, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    invoke-interface {v1, p1}, Lcom/lge/dockservice/IDockWindowService;->undockAtCenter(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    invoke-interface {v1, p1}, Lcom/lge/dockservice/IDockWindowService;->killdockIfExists(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_1
    const-string v1, "DockWindowManager"

    const-string v2, "no service available"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public terminateDock(Ljava/lang/String;)V
    .locals 4
    .param p1, "packageName"    # Ljava/lang/String;

    .prologue
    const-string v1, "DockWindowManager"

    const-string v2, "terminateDock"

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    if-eqz v1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    invoke-interface {v1, p1}, Lcom/lge/dockservice/IDockWindowService;->killdockIfExists(Ljava/lang/String;)V

    const-string v1, "DockWindowManager"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "unbindService "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowManager;->mServiceConnection:Landroid/content/ServiceConnection;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowManager;->mServiceConnection:Landroid/content/ServiceConnection;

    invoke-virtual {v1, v2}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    const-string v1, "DockWindowManager"

    const-string v2, "RemoteException occured in terminateDock"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/IllegalArgumentException;
    const-string v1, "DockWindowManager"

    const-string v2, "IllegalArgumentException occured in terminateDock"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Ljava/lang/IllegalArgumentException;
    :cond_0
    const-string v1, "DockWindowManager"

    const-string v2, "no service available"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method updateDockIconImage(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 3
    .param p1, "packageName"    # Ljava/lang/String;
    .param p2, "icon"    # Landroid/graphics/Bitmap;

    .prologue
    const-string v1, "DockWindowManager"

    const-string v2, "updateDockIconImage"

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    if-eqz v1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/lge/dockservice/DockWindowManager;->mService:Lcom/lge/dockservice/IDockWindowService;

    invoke-interface {v1, p1, p2}, Lcom/lge/dockservice/IDockWindowService;->updateIconImage(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_0
    const-string v1, "DockWindowManager"

    const-string v2, "no service available"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
