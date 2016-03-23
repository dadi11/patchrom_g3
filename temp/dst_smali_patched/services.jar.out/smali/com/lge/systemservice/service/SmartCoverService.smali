.class public final Lcom/lge/systemservice/service/SmartCoverService;
.super Lcom/lge/systemservice/core/ISmartCoverManager$Stub;
.source "SmartCoverService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;,
        Lcom/lge/systemservice/service/SmartCoverService$AppsportID;
    }
.end annotation


# static fields
.field private static final APPSPORT_ID_PATH:Ljava/lang/String; = "/sys/class/switch/appsport_id/state"

.field private static final APPSPORT_STATE_PATH:Ljava/lang/String; = "/sys/class/switch/appsport/state"

.field private static final APPSPORT_UEVENT_STATE:Ljava/lang/String; = "DEVPATH=/devices/virtual/switch/appsport"

.field private static final FOLDER_STATE_PATH:Ljava/lang/String; = "/sys/class/switch/folderstatus/state"

.field private static final FOLDER_UEVENT_MATCH:Ljava/lang/String; = "DEVPATH=/devices/virtual/switch/folderstatus"

.field private static final MSG_ACCESSORY_COVER_STATE_CHANGED:I = 0x1

.field private static final MSG_ACCESSORY_COVER_TYPE_CHANGED:I = 0x2

.field private static final MSG_ACCESSORY_FOLDER_STATE_CHANGED:I = 0x4

.field private static final MSG_ACCESSORY_PEN_STATE_CHANGED:I = 0xb

.field private static final MSG_ACCESSORY_SUBCOVER_STATE_CHANGED:I = 0x15

.field private static final MSG_ACCESSORY_SUBCOVER_TYPE_CHANGED:I = 0x16

.field private static final PEN_STATE_PATH:Ljava/lang/String; = "/sys/class/switch/pen_state/state"

.field private static final PEN_UEVENT_MATCH:Ljava/lang/String; = "DEVPATH=/devices/virtual/switch/pen_state"

.field private static final SMARTCOVER_STATE_PATH:Ljava/lang/String; = "/sys/class/switch/smartcover/state"

.field private static final SMARTCOVER_UEVENT_MATCH:Ljava/lang/String; = "DEVPATH=/devices/virtual/switch/smartcover"

.field private static final SUBCOVER_STATE_PATH:Ljava/lang/String; = "/sys/class/switch/backcover/state"

.field private static final SUBCOVER_TYPE_PATH:Ljava/lang/String; = "/sys/class/switch/backcover/state"

.field private static final SUBCOVER_UEVENT_MATCH:Ljava/lang/String; = "DEVPATH=/devices/virtual/switch/backcover"

.field private static final TAG:Ljava/lang/String;

.field private static final TOUCH_FILTERING_PATH:Ljava/lang/String; = "/sys/devices/virtual/input/lge_touch/quick_cover_status"


# instance fields
.field private callbackDeathRecipient:Landroid/os/IBinder$DeathRecipient;

.field private mAppsportDocked:Z

.field private final mAppsportEventObserver:Landroid/os/UEventObserver;

.field private final mContext:Landroid/content/Context;

.field private mCoverCallbacks:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lge/systemservice/core/ISmartCoverCallback;",
            ">;"
        }
    .end annotation
.end field

.field private mCurAppsportID:Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

.field private mDesiredCoverType:I

.field private mFolderCallbacks:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lge/systemservice/core/ISmartCoverCallback;",
            ">;"
        }
    .end annotation
.end field

.field private final mFolderEventObserver:Landroid/os/UEventObserver;

.field private mFolderState:I

.field private final mHandler:Landroid/os/Handler;

.field mHelperBoost:Lcom/lge/loader/LGContextHelper;

.field mLGPowerManagerLoader:Lcom/lge/loader/power/ILGPowerManagerLoader;

.field private final mLockFolder:Ljava/lang/Object;

.field private final mLockPen:Ljava/lang/Object;

.field private final mLockSmartCover:Ljava/lang/Object;

.field private final mLockSubCover:Ljava/lang/Object;

.field private mPenCallbacks:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lge/systemservice/core/ISmartCoverCallback;",
            ">;"
        }
    .end annotation
.end field

.field private mPenEnabled:Z

.field private final mPenEventObserver:Landroid/os/UEventObserver;

.field private mPenEventState:I

.field private mServiceEnabled:Z

.field private mSettingsObserver:Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;

.field private mSmartCoverEnabled:Z

.field private final mSmartCoverEventObserver:Landroid/os/UEventObserver;

.field private mSmartCoverState:I

.field private mSmartCoverType:I

.field private mSubCoverCallbacks:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lge/systemservice/core/ISmartCoverCallback;",
            ">;"
        }
    .end annotation
.end field

.field private mSubCoverEnabled:Z

.field private final mSubCoverEventObserver:Landroid/os/UEventObserver;

.field private mSubCoverState:I

.field private mSubCoverType:I

.field private final mTouchFilteringFile:Ljava/io/File;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-class v0, Lcom/lge/systemservice/service/SmartCoverService;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v5, 0x5

    const/4 v4, 0x0

    const/4 v3, 0x0

    invoke-direct {p0}, Lcom/lge/systemservice/core/ISmartCoverManager$Stub;-><init>()V

    new-instance v1, Ljava/io/File;

    const-string v2, "/sys/devices/virtual/input/lge_touch/quick_cover_status"

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mTouchFilteringFile:Ljava/io/File;

    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockSmartCover:Ljava/lang/Object;

    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockPen:Ljava/lang/Object;

    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockFolder:Ljava/lang/Object;

    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockSubCover:Ljava/lang/Object;

    iput v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverState:I

    const/4 v1, 0x1

    iput v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenEventState:I

    iput v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mFolderState:I

    iput v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverState:I

    new-instance v1, Ljava/util/LinkedList;

    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCoverCallbacks:Ljava/util/List;

    new-instance v1, Ljava/util/LinkedList;

    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenCallbacks:Ljava/util/List;

    new-instance v1, Ljava/util/LinkedList;

    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mFolderCallbacks:Ljava/util/List;

    new-instance v1, Ljava/util/LinkedList;

    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverCallbacks:Ljava/util/List;

    iput-boolean v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mServiceEnabled:Z

    iput-boolean v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverEnabled:Z

    iput-boolean v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenEnabled:Z

    iput-boolean v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverEnabled:Z

    iput v5, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverType:I

    iput v5, p0, Lcom/lge/systemservice/service/SmartCoverService;->mDesiredCoverType:I

    iput v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverType:I

    iput-boolean v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mAppsportDocked:Z

    iput-object v4, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCurAppsportID:Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    iput-object v4, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLGPowerManagerLoader:Lcom/lge/loader/power/ILGPowerManagerLoader;

    iput-object v4, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHelperBoost:Lcom/lge/loader/LGContextHelper;

    new-instance v1, Lcom/lge/systemservice/service/SmartCoverService$1;

    invoke-direct {v1, p0}, Lcom/lge/systemservice/service/SmartCoverService$1;-><init>(Lcom/lge/systemservice/service/SmartCoverService;)V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mAppsportEventObserver:Landroid/os/UEventObserver;

    new-instance v1, Lcom/lge/systemservice/service/SmartCoverService$2;

    invoke-direct {v1, p0}, Lcom/lge/systemservice/service/SmartCoverService$2;-><init>(Lcom/lge/systemservice/service/SmartCoverService;)V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverEventObserver:Landroid/os/UEventObserver;

    new-instance v1, Lcom/lge/systemservice/service/SmartCoverService$3;

    invoke-direct {v1, p0}, Lcom/lge/systemservice/service/SmartCoverService$3;-><init>(Lcom/lge/systemservice/service/SmartCoverService;)V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mFolderEventObserver:Landroid/os/UEventObserver;

    new-instance v1, Lcom/lge/systemservice/service/SmartCoverService$4;

    invoke-direct {v1, p0}, Lcom/lge/systemservice/service/SmartCoverService$4;-><init>(Lcom/lge/systemservice/service/SmartCoverService;)V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenEventObserver:Landroid/os/UEventObserver;

    new-instance v1, Lcom/lge/systemservice/service/SmartCoverService$5;

    invoke-direct {v1, p0}, Lcom/lge/systemservice/service/SmartCoverService$5;-><init>(Lcom/lge/systemservice/service/SmartCoverService;)V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverEventObserver:Landroid/os/UEventObserver;

    new-instance v1, Lcom/lge/systemservice/service/SmartCoverService$6;

    invoke-direct {v1, p0}, Lcom/lge/systemservice/service/SmartCoverService$6;-><init>(Lcom/lge/systemservice/service/SmartCoverService;)V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    new-instance v1, Lcom/lge/systemservice/service/SmartCoverService$7;

    invoke-direct {v1, p0}, Lcom/lge/systemservice/service/SmartCoverService$7;-><init>(Lcom/lge/systemservice/service/SmartCoverService;)V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->callbackDeathRecipient:Landroid/os/IBinder$DeathRecipient;

    iput-object p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mContext:Landroid/content/Context;

    new-instance v1, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;

    invoke-direct {v1, p0, v4}, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;-><init>(Lcom/lge/systemservice/service/SmartCoverService;Landroid/os/Handler;)V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSettingsObserver:Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSettingsObserver:Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;

    invoke-virtual {v1}, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->observe()V

    :try_start_0
    new-instance v1, Lcom/lge/loader/LGContextHelper;

    iget-object v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mContext:Landroid/content/Context;

    invoke-direct {v1, v2}, Lcom/lge/loader/LGContextHelper;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHelperBoost:Lcom/lge/loader/LGContextHelper;

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHelperBoost:Lcom/lge/loader/LGContextHelper;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHelperBoost:Lcom/lge/loader/LGContextHelper;

    const-string v2, "lgpowermanagerhelper"

    invoke-virtual {v1, v2}, Lcom/lge/loader/LGContextHelper;->getLGSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/loader/power/ILGPowerManagerLoader;

    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLGPowerManagerLoader:Lcom/lge/loader/power/ILGPowerManagerLoader;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    const-string v2, "can\'t get boost loader!"

    invoke-static {v1, v2}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/lge/systemservice/service/SmartCoverService;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/systemservice/service/SmartCoverService;->updateAppsportState(I)V

    return-void
.end method

.method static synthetic access$1000(Lcom/lge/systemservice/service/SmartCoverService;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/systemservice/service/SmartCoverService;->updateSubCoverType(I)V

    return-void
.end method

.method static synthetic access$1100(Lcom/lge/systemservice/service/SmartCoverService;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/systemservice/service/SmartCoverService;->updateSubCoverEvent(I)V

    return-void
.end method

.method static synthetic access$1200(Lcom/lge/systemservice/service/SmartCoverService;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockSmartCover:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$1300(Lcom/lge/systemservice/service/SmartCoverService;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverState:I

    return v0
.end method

.method static synthetic access$1302(Lcom/lge/systemservice/service/SmartCoverService;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverState:I

    return p1
.end method

.method static synthetic access$1400(Lcom/lge/systemservice/service/SmartCoverService;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCoverCallbacks:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$1500(Lcom/lge/systemservice/service/SmartCoverService;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$1600(Lcom/lge/systemservice/service/SmartCoverService;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->setTouchFilteringLocked()V

    return-void
.end method

.method static synthetic access$1700(Lcom/lge/systemservice/service/SmartCoverService;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockPen:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$1800(Lcom/lge/systemservice/service/SmartCoverService;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenEventState:I

    return v0
.end method

.method static synthetic access$1802(Lcom/lge/systemservice/service/SmartCoverService;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenEventState:I

    return p1
.end method

.method static synthetic access$1900(Lcom/lge/systemservice/service/SmartCoverService;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenCallbacks:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$2000(Lcom/lge/systemservice/service/SmartCoverService;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverType:I

    return v0
.end method

.method static synthetic access$2002(Lcom/lge/systemservice/service/SmartCoverService;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverType:I

    return p1
.end method

.method static synthetic access$2100(Lcom/lge/systemservice/service/SmartCoverService;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockFolder:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$2200(Lcom/lge/systemservice/service/SmartCoverService;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mFolderState:I

    return v0
.end method

.method static synthetic access$2202(Lcom/lge/systemservice/service/SmartCoverService;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mFolderState:I

    return p1
.end method

.method static synthetic access$2300(Lcom/lge/systemservice/service/SmartCoverService;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mFolderCallbacks:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$2400(Lcom/lge/systemservice/service/SmartCoverService;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockSubCover:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$2500(Lcom/lge/systemservice/service/SmartCoverService;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverState:I

    return v0
.end method

.method static synthetic access$2502(Lcom/lge/systemservice/service/SmartCoverService;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverState:I

    return p1
.end method

.method static synthetic access$2600(Lcom/lge/systemservice/service/SmartCoverService;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverCallbacks:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$2700(Lcom/lge/systemservice/service/SmartCoverService;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverType:I

    return v0
.end method

.method static synthetic access$2702(Lcom/lge/systemservice/service/SmartCoverService;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverType:I

    return p1
.end method

.method static synthetic access$2802(Lcom/lge/systemservice/service/SmartCoverService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverEnabled:Z

    return p1
.end method

.method static synthetic access$2900(Lcom/lge/systemservice/service/SmartCoverService;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverType(I)V

    return-void
.end method

.method static synthetic access$3000(Lcom/lge/systemservice/service/SmartCoverService;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverEvent()V

    return-void
.end method

.method static synthetic access$3102(Lcom/lge/systemservice/service/SmartCoverService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenEnabled:Z

    return p1
.end method

.method static synthetic access$3202(Lcom/lge/systemservice/service/SmartCoverService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverEnabled:Z

    return p1
.end method

.method static synthetic access$3300(Lcom/lge/systemservice/service/SmartCoverService;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    iget-boolean v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mServiceEnabled:Z

    return v0
.end method

.method static synthetic access$3302(Lcom/lge/systemservice/service/SmartCoverService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mServiceEnabled:Z

    return p1
.end method

.method static synthetic access$3400(Lcom/lge/systemservice/service/SmartCoverService;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->stopObserving()V

    return-void
.end method

.method static synthetic access$3500(Lcom/lge/systemservice/service/SmartCoverService;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->startService()V

    return-void
.end method

.method static synthetic access$700(Lcom/lge/systemservice/service/SmartCoverService;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverEvent(I)V

    return-void
.end method

.method static synthetic access$800(Lcom/lge/systemservice/service/SmartCoverService;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/systemservice/service/SmartCoverService;->updateFolderEvent(I)V

    return-void
.end method

.method static synthetic access$900(Lcom/lge/systemservice/service/SmartCoverService;I)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService;
    .param p1, "x1"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/systemservice/service/SmartCoverService;->updatePenEvent(I)V

    return-void
.end method

.method private getCurrentFolderState()I
    .locals 9

    .prologue
    new-instance v5, Ljava/io/File;

    const-string v7, "/sys/class/switch/folderstatus/state"

    invoke-direct {v5, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .local v5, "mFolderStateFile":Ljava/io/File;
    const/4 v6, 0x0

    .local v6, "state":I
    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v7

    if-eqz v7, :cond_1

    const/16 v7, 0xa

    new-array v0, v7, [B

    .local v0, "buf":[B
    const/4 v2, 0x0

    .local v2, "in":Ljava/io/FileInputStream;
    :try_start_0
    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, v5}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_8
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v2    # "in":Ljava/io/FileInputStream;
    .local v3, "in":Ljava/io/FileInputStream;
    const/4 v7, 0x0

    :try_start_1
    array-length v8, v0

    invoke-virtual {v3, v0, v7, v8}, Ljava/io/FileInputStream;->read([BII)I
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_7
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v4

    .local v4, "len":I
    if-lez v4, :cond_0

    :try_start_2
    new-instance v7, Ljava/lang/String;

    const/4 v8, 0x0

    invoke-direct {v7, v0, v8, v4}, Ljava/lang/String;-><init>([BII)V

    invoke-virtual {v7}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/NumberFormatException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_7
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result v6

    :cond_0
    :goto_0
    if-eqz v3, :cond_1

    :try_start_3
    invoke-virtual {v3}, Ljava/io/FileInputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3

    .end local v0    # "buf":[B
    .end local v3    # "in":Ljava/io/FileInputStream;
    .end local v4    # "len":I
    :cond_1
    :goto_1
    return v6

    .restart local v0    # "buf":[B
    .restart local v3    # "in":Ljava/io/FileInputStream;
    .restart local v4    # "len":I
    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/NumberFormatException;
    :try_start_4
    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_4
    .catch Ljava/io/FileNotFoundException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_7
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_0

    .end local v1    # "e":Ljava/lang/NumberFormatException;
    .end local v4    # "len":I
    :catch_1
    move-exception v1

    move-object v2, v3

    .end local v3    # "in":Ljava/io/FileInputStream;
    .local v1, "e":Ljava/io/FileNotFoundException;
    .restart local v2    # "in":Ljava/io/FileInputStream;
    :goto_2
    :try_start_5
    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    if-eqz v2, :cond_1

    :try_start_6
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_2

    goto :goto_1

    :catch_2
    move-exception v1

    .local v1, "e":Ljava/io/IOException;
    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .end local v1    # "e":Ljava/io/IOException;
    .end local v2    # "in":Ljava/io/FileInputStream;
    .restart local v3    # "in":Ljava/io/FileInputStream;
    .restart local v4    # "len":I
    :catch_3
    move-exception v1

    .restart local v1    # "e":Ljava/io/IOException;
    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .end local v1    # "e":Ljava/io/IOException;
    .end local v3    # "in":Ljava/io/FileInputStream;
    .end local v4    # "len":I
    .restart local v2    # "in":Ljava/io/FileInputStream;
    :catch_4
    move-exception v1

    .restart local v1    # "e":Ljava/io/IOException;
    :goto_3
    :try_start_7
    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    if-eqz v2, :cond_1

    :try_start_8
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_5

    goto :goto_1

    :catch_5
    move-exception v1

    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .end local v1    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v7

    :goto_4
    if-eqz v2, :cond_2

    :try_start_9
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_6

    :cond_2
    :goto_5
    throw v7

    :catch_6
    move-exception v1

    .restart local v1    # "e":Ljava/io/IOException;
    sget-object v8, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v8, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_5

    .end local v1    # "e":Ljava/io/IOException;
    .end local v2    # "in":Ljava/io/FileInputStream;
    .restart local v3    # "in":Ljava/io/FileInputStream;
    :catchall_1
    move-exception v7

    move-object v2, v3

    .end local v3    # "in":Ljava/io/FileInputStream;
    .restart local v2    # "in":Ljava/io/FileInputStream;
    goto :goto_4

    .end local v2    # "in":Ljava/io/FileInputStream;
    .restart local v3    # "in":Ljava/io/FileInputStream;
    :catch_7
    move-exception v1

    move-object v2, v3

    .end local v3    # "in":Ljava/io/FileInputStream;
    .restart local v2    # "in":Ljava/io/FileInputStream;
    goto :goto_3

    :catch_8
    move-exception v1

    goto :goto_2
.end method

.method private getCurrentValueWithFile(Ljava/lang/String;I)I
    .locals 9
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "defaultValue"    # I

    .prologue
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .local v5, "mFile":Ljava/io/File;
    move v6, p2

    .local v6, "state":I
    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v7

    if-eqz v7, :cond_1

    const/16 v7, 0xa

    new-array v0, v7, [B

    .local v0, "buf":[B
    const/4 v2, 0x0

    .local v2, "in":Ljava/io/FileInputStream;
    :try_start_0
    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, v5}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_8
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v2    # "in":Ljava/io/FileInputStream;
    .local v3, "in":Ljava/io/FileInputStream;
    const/4 v7, 0x0

    :try_start_1
    array-length v8, v0

    invoke-virtual {v3, v0, v7, v8}, Ljava/io/FileInputStream;->read([BII)I
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_7
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v4

    .local v4, "len":I
    if-lez v4, :cond_0

    :try_start_2
    new-instance v7, Ljava/lang/String;

    const/4 v8, 0x0

    invoke-direct {v7, v0, v8, v4}, Ljava/lang/String;-><init>([BII)V

    invoke-virtual {v7}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/NumberFormatException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_7
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result v6

    :cond_0
    :goto_0
    if-eqz v3, :cond_1

    :try_start_3
    invoke-virtual {v3}, Ljava/io/FileInputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3

    .end local v0    # "buf":[B
    .end local v3    # "in":Ljava/io/FileInputStream;
    .end local v4    # "len":I
    :cond_1
    :goto_1
    return v6

    .restart local v0    # "buf":[B
    .restart local v3    # "in":Ljava/io/FileInputStream;
    .restart local v4    # "len":I
    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/NumberFormatException;
    :try_start_4
    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_4
    .catch Ljava/io/FileNotFoundException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_7
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_0

    .end local v1    # "e":Ljava/lang/NumberFormatException;
    .end local v4    # "len":I
    :catch_1
    move-exception v1

    move-object v2, v3

    .end local v3    # "in":Ljava/io/FileInputStream;
    .local v1, "e":Ljava/io/FileNotFoundException;
    .restart local v2    # "in":Ljava/io/FileInputStream;
    :goto_2
    :try_start_5
    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    if-eqz v2, :cond_1

    :try_start_6
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_2

    goto :goto_1

    :catch_2
    move-exception v1

    .local v1, "e":Ljava/io/IOException;
    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .end local v1    # "e":Ljava/io/IOException;
    .end local v2    # "in":Ljava/io/FileInputStream;
    .restart local v3    # "in":Ljava/io/FileInputStream;
    .restart local v4    # "len":I
    :catch_3
    move-exception v1

    .restart local v1    # "e":Ljava/io/IOException;
    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .end local v1    # "e":Ljava/io/IOException;
    .end local v3    # "in":Ljava/io/FileInputStream;
    .end local v4    # "len":I
    .restart local v2    # "in":Ljava/io/FileInputStream;
    :catch_4
    move-exception v1

    .restart local v1    # "e":Ljava/io/IOException;
    :goto_3
    :try_start_7
    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    if-eqz v2, :cond_1

    :try_start_8
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_5

    goto :goto_1

    :catch_5
    move-exception v1

    sget-object v7, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v7, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .end local v1    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v7

    :goto_4
    if-eqz v2, :cond_2

    :try_start_9
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_6

    :cond_2
    :goto_5
    throw v7

    :catch_6
    move-exception v1

    .restart local v1    # "e":Ljava/io/IOException;
    sget-object v8, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v8, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_5

    .end local v1    # "e":Ljava/io/IOException;
    .end local v2    # "in":Ljava/io/FileInputStream;
    .restart local v3    # "in":Ljava/io/FileInputStream;
    :catchall_1
    move-exception v7

    move-object v2, v3

    .end local v3    # "in":Ljava/io/FileInputStream;
    .restart local v2    # "in":Ljava/io/FileInputStream;
    goto :goto_4

    .end local v2    # "in":Ljava/io/FileInputStream;
    .restart local v3    # "in":Ljava/io/FileInputStream;
    :catch_7
    move-exception v1

    move-object v2, v3

    .end local v3    # "in":Ljava/io/FileInputStream;
    .restart local v2    # "in":Ljava/io/FileInputStream;
    goto :goto_3

    :catch_8
    move-exception v1

    goto :goto_2
.end method

.method private final initAppsport()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mAppsportEventObserver:Landroid/os/UEventObserver;

    const-string v1, "DEVPATH=/devices/virtual/switch/appsport"

    invoke-virtual {v0, v1}, Landroid/os/UEventObserver;->startObserving(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->updateAppsportState()V

    return-void
.end method

.method private final initFolder()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mFolderEventObserver:Landroid/os/UEventObserver;

    const-string v1, "DEVPATH=/devices/virtual/switch/folderstatus"

    invoke-virtual {v0, v1}, Landroid/os/UEventObserver;->startObserving(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->updateFolderEvent()V

    return-void
.end method

.method private final initPen()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenEventObserver:Landroid/os/UEventObserver;

    const-string v1, "DEVPATH=/devices/virtual/switch/pen_state"

    invoke-virtual {v0, v1}, Landroid/os/UEventObserver;->startObserving(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->updatePenEvent()V

    return-void
.end method

.method private final initSmartCover()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverEventObserver:Landroid/os/UEventObserver;

    const-string v1, "DEVPATH=/devices/virtual/switch/smartcover"

    invoke-virtual {v0, v1}, Landroid/os/UEventObserver;->startObserving(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverEvent()V

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverType()V

    return-void
.end method

.method private final initSubCover()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverEventObserver:Landroid/os/UEventObserver;

    const-string v1, "DEVPATH=/devices/virtual/switch/backcover"

    invoke-virtual {v0, v1}, Landroid/os/UEventObserver;->startObserving(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->updateSubCoverEvent()V

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->updateSubCoverType()V

    return-void
.end method

.method private isServiceEnabled()Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    iget-boolean v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mServiceEnabled:Z

    if-nez v1, :cond_0

    :goto_0
    return v0

    :cond_0
    const-string v1, "ro.factorytest"

    invoke-static {v1, v0}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v1

    const/4 v2, 0x2

    if-ne v1, v2, :cond_1

    sget-object v1, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    const-string v2, "On FTM test, skipping accessory broadcast"

    invoke-static {v1, v2}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    const-string v1, "sys.allautotest.run"

    invoke-static {v1, v0}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_2

    sget-object v1, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    const-string v2, "On AAT test, skipping accessory broadcast"

    invoke-static {v1, v2}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_2
    const-string v1, "true"

    const-string v2, "gsm.lge.ota_is_running"

    const-string v3, "false"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "true"

    const-string v2, "gsm.lge.ota_ignoreKey"

    const-string v3, "false"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "1"

    const-string v2, "persist.radio.ota_download"

    const-string v3, "0"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    :cond_3
    sget-object v1, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    const-string v2, "On OTA, skipping accessory broadcast"

    invoke-static {v1, v2}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_4
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private notifyCurrentStateAtRegisterLocked(ILcom/lge/systemservice/core/ISmartCoverCallback;)V
    .locals 3
    .param p1, "eventType"    # I
    .param p2, "clbk"    # Lcom/lge/systemservice/core/ISmartCoverCallback;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->isServiceEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/4 v2, 0x1

    if-ne p1, v2, :cond_2

    iget-boolean v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverEnabled:Z

    if-eqz v2, :cond_0

    iget v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverType:I

    .local v1, "type":I
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverState:I

    .local v0, "state":I
    :goto_1
    invoke-interface {p2, v1}, Lcom/lge/systemservice/core/ISmartCoverCallback;->onTypeChanged(I)V

    invoke-interface {p2, v0}, Lcom/lge/systemservice/core/ISmartCoverCallback;->onStateChanged(I)V

    goto :goto_0

    .end local v0    # "state":I
    .end local v1    # "type":I
    :cond_2
    const/4 v2, 0x2

    if-ne p1, v2, :cond_3

    iget-boolean v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenEnabled:Z

    if-eqz v2, :cond_0

    const/4 v1, 0x0

    .restart local v1    # "type":I
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenEventState:I

    .restart local v0    # "state":I
    goto :goto_1

    .end local v0    # "state":I
    .end local v1    # "type":I
    :cond_3
    const/4 v2, 0x4

    if-ne p1, v2, :cond_4

    const/4 v1, 0x0

    .restart local v1    # "type":I
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mFolderState:I

    .restart local v0    # "state":I
    goto :goto_1

    .end local v0    # "state":I
    .end local v1    # "type":I
    :cond_4
    const/4 v2, 0x3

    if-ne p1, v2, :cond_0

    iget-boolean v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverEnabled:Z

    if-eqz v2, :cond_0

    iget v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverType:I

    .restart local v1    # "type":I
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverState:I

    .restart local v0    # "state":I
    goto :goto_1
.end method

.method private setTouchFilteringLocked()V
    .locals 6

    .prologue
    iget-object v4, p0, Lcom/lge/systemservice/service/SmartCoverService;->mTouchFilteringFile:Ljava/io/File;

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v4

    if-nez v4, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/16 v3, 0x30

    .local v3, "state":C
    iget v4, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverType:I

    const/4 v5, 0x5

    if-ne v4, v5, :cond_2

    const/16 v3, 0x30

    :goto_1
    const/4 v1, 0x0

    .local v1, "out":Ljava/io/OutputStream;
    :try_start_0
    new-instance v2, Ljava/io/FileOutputStream;

    iget-object v4, p0, Lcom/lge/systemservice/service/SmartCoverService;->mTouchFilteringFile:Ljava/io/File;

    invoke-direct {v2, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v1    # "out":Ljava/io/OutputStream;
    .local v2, "out":Ljava/io/OutputStream;
    :try_start_1
    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write(I)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    if-eqz v2, :cond_5

    :try_start_2
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    move-object v1, v2

    .end local v2    # "out":Ljava/io/OutputStream;
    .restart local v1    # "out":Ljava/io/OutputStream;
    goto :goto_0

    .end local v1    # "out":Ljava/io/OutputStream;
    :cond_2
    iget v4, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverState:I

    const/4 v5, 0x1

    if-ne v4, v5, :cond_3

    const/16 v3, 0x31

    goto :goto_1

    :cond_3
    const/16 v3, 0x30

    goto :goto_1

    .restart local v2    # "out":Ljava/io/OutputStream;
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/io/IOException;
    sget-object v4, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v4, v0}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    move-object v1, v2

    .end local v2    # "out":Ljava/io/OutputStream;
    .restart local v1    # "out":Ljava/io/OutputStream;
    goto :goto_0

    .end local v0    # "e":Ljava/io/IOException;
    :catch_1
    move-exception v0

    .restart local v0    # "e":Ljava/io/IOException;
    :goto_2
    :try_start_3
    sget-object v4, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v4, v0}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-eqz v1, :cond_0

    :try_start_4
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_0

    :catch_2
    move-exception v0

    sget-object v4, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v4, v0}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v0    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v4

    :goto_3
    if-eqz v1, :cond_4

    :try_start_5
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    :cond_4
    :goto_4
    throw v4

    :catch_3
    move-exception v0

    .restart local v0    # "e":Ljava/io/IOException;
    sget-object v5, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    invoke-static {v5, v0}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_4

    .end local v0    # "e":Ljava/io/IOException;
    .end local v1    # "out":Ljava/io/OutputStream;
    .restart local v2    # "out":Ljava/io/OutputStream;
    :catchall_1
    move-exception v4

    move-object v1, v2

    .end local v2    # "out":Ljava/io/OutputStream;
    .restart local v1    # "out":Ljava/io/OutputStream;
    goto :goto_3

    .end local v1    # "out":Ljava/io/OutputStream;
    .restart local v2    # "out":Ljava/io/OutputStream;
    :catch_4
    move-exception v0

    move-object v1, v2

    .end local v2    # "out":Ljava/io/OutputStream;
    .restart local v1    # "out":Ljava/io/OutputStream;
    goto :goto_2

    .end local v1    # "out":Ljava/io/OutputStream;
    .restart local v2    # "out":Ljava/io/OutputStream;
    :cond_5
    move-object v1, v2

    .end local v2    # "out":Ljava/io/OutputStream;
    .restart local v1    # "out":Ljava/io/OutputStream;
    goto :goto_0
.end method

.method private startService()V
    .locals 0

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->initSmartCover()V

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->initPen()V

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->initFolder()V

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->initSubCover()V

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->initAppsport()V

    return-void
.end method

.method private stopObserving()V
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockSmartCover:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverEventObserver:Landroid/os/UEventObserver;

    invoke-virtual {v0}, Landroid/os/UEventObserver;->stopObserving()V

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverEvent(I)V

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockPen:Ljava/lang/Object;

    monitor-enter v1

    :try_start_1
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenEventObserver:Landroid/os/UEventObserver;

    invoke-virtual {v0}, Landroid/os/UEventObserver;->stopObserving()V

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/lge/systemservice/service/SmartCoverService;->updatePenEvent(I)V

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockFolder:Ljava/lang/Object;

    monitor-enter v1

    :try_start_2
    new-instance v0, Ljava/io/File;

    const-string v2, "/sys/class/switch/folderstatus/state"

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mFolderEventObserver:Landroid/os/UEventObserver;

    invoke-virtual {v0}, Landroid/os/UEventObserver;->stopObserving()V

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/lge/systemservice/service/SmartCoverService;->updateFolderEvent(I)V

    :cond_0
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockSubCover:Ljava/lang/Object;

    monitor-enter v1

    :try_start_3
    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverEventObserver:Landroid/os/UEventObserver;

    invoke-virtual {v0}, Landroid/os/UEventObserver;->stopObserving()V

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/lge/systemservice/service/SmartCoverService;->updateSubCoverEvent(I)V

    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    iget-object v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mAppsportEventObserver:Landroid/os/UEventObserver;

    invoke-virtual {v0}, Landroid/os/UEventObserver;->stopObserving()V

    return-void

    :catchall_0
    move-exception v0

    :try_start_4
    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v0

    :catchall_1
    move-exception v0

    :try_start_5
    monitor-exit v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    throw v0

    :catchall_2
    move-exception v0

    :try_start_6
    monitor-exit v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    throw v0

    :catchall_3
    move-exception v0

    :try_start_7
    monitor-exit v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    throw v0
.end method

.method private updateAppsportState()V
    .locals 2

    .prologue
    const-string v0, "/sys/class/switch/appsport/state"

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/lge/systemservice/service/SmartCoverService;->getCurrentValueWithFile(Ljava/lang/String;I)I

    move-result v0

    invoke-direct {p0, v0}, Lcom/lge/systemservice/service/SmartCoverService;->updateAppsportState(I)V

    return-void
.end method

.method private updateAppsportState(I)V
    .locals 5
    .param p1, "newState"    # I

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->isServiceEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    if-lez p1, :cond_2

    const/4 v0, 0x1

    .local v0, "AppsportDocked":Z
    :goto_1
    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lcom/lge/systemservice/service/SmartCoverService;->readAppsportID()Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    move-result-object v1

    .local v1, "newAppsportID":Lcom/lge/systemservice/service/SmartCoverService$AppsportID;
    iput-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCurAppsportID:Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    sget-object v2, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "appsport: docked "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCurAppsportID:Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "newAppsportID":Lcom/lge/systemservice/service/SmartCoverService$AppsportID;
    :goto_2
    iget-boolean v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mAppsportDocked:Z

    if-eq v2, v0, :cond_0

    iput-boolean v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mAppsportDocked:Z

    invoke-virtual {p0}, Lcom/lge/systemservice/service/SmartCoverService;->sendAppsportIntent()V

    goto :goto_0

    .end local v0    # "AppsportDocked":Z
    :cond_2
    const/4 v0, 0x0

    .restart local v0    # "AppsportDocked":Z
    goto :goto_1

    :cond_3
    sget-object v2, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    const-string v3, "appsport: detached"

    invoke-static {v2, v3}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2
.end method

.method private updateFolderEvent()V
    .locals 1

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->getCurrentFolderState()I

    move-result v0

    invoke-direct {p0, v0}, Lcom/lge/systemservice/service/SmartCoverService;->updateFolderEvent(I)V

    return-void
.end method

.method private updateFolderEvent(I)V
    .locals 4
    .param p1, "newState"    # I

    .prologue
    const/4 v3, 0x4

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->isServiceEnabled()Z

    move-result v1

    if-nez v1, :cond_0

    :goto_0
    return-void

    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v3}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, p1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v1, v3, v2}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method

.method private updatePenEvent()V
    .locals 2

    .prologue
    const-string v0, "/sys/class/switch/pen_state/state"

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/lge/systemservice/service/SmartCoverService;->getCurrentValueWithFile(Ljava/lang/String;I)I

    move-result v0

    invoke-direct {p0, v0}, Lcom/lge/systemservice/service/SmartCoverService;->updatePenEvent(I)V

    return-void
.end method

.method private updatePenEvent(I)V
    .locals 4
    .param p1, "newState"    # I

    .prologue
    const/16 v3, 0xb

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->isServiceEnabled()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenEnabled:Z

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v3}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, p1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v1, v3, v2}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method

.method private updateSmartCoverEvent()V
    .locals 2

    .prologue
    const-string v0, "/sys/class/switch/smartcover/state"

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/lge/systemservice/service/SmartCoverService;->getCurrentValueWithFile(Ljava/lang/String;I)I

    move-result v0

    invoke-direct {p0, v0}, Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverEvent(I)V

    return-void
.end method

.method private updateSmartCoverEvent(I)V
    .locals 4
    .param p1, "newState"    # I

    .prologue
    const/4 v3, 0x1

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->isServiceEnabled()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverEnabled:Z

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v3}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, p1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v1, v3, v2}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method

.method private updateSmartCoverType()V
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mDesiredCoverType:I

    invoke-direct {p0, v0}, Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverType(I)V

    return-void
.end method

.method private updateSmartCoverType(I)V
    .locals 5
    .param p1, "newState"    # I

    .prologue
    const/4 v4, 0x2

    iput p1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mDesiredCoverType:I

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->isServiceEnabled()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverEnabled:Z

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v4}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    new-instance v2, Ljava/lang/Integer;

    iget v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mDesiredCoverType:I

    invoke-direct {v2, v3}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v1, v4, v2}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method

.method private updateSubCoverEvent()V
    .locals 2

    .prologue
    const-string v0, "/sys/class/switch/backcover/state"

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/lge/systemservice/service/SmartCoverService;->getCurrentValueWithFile(Ljava/lang/String;I)I

    move-result v0

    invoke-direct {p0, v0}, Lcom/lge/systemservice/service/SmartCoverService;->updateSubCoverEvent(I)V

    return-void
.end method

.method private updateSubCoverEvent(I)V
    .locals 4
    .param p1, "newState"    # I

    .prologue
    const/16 v3, 0x15

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->isServiceEnabled()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverEnabled:Z

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    if-nez p1, :cond_2

    const/4 p1, 0x0

    :goto_1
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v3}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, p1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v1, v3, v2}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0

    .end local v0    # "msg":Landroid/os/Message;
    :cond_2
    const/4 p1, 0x1

    goto :goto_1
.end method

.method private updateSubCoverType()V
    .locals 2

    .prologue
    const-string v0, "/sys/class/switch/backcover/state"

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/lge/systemservice/service/SmartCoverService;->getCurrentValueWithFile(Ljava/lang/String;I)I

    move-result v0

    invoke-direct {p0, v0}, Lcom/lge/systemservice/service/SmartCoverService;->updateSubCoverType(I)V

    return-void
.end method

.method private updateSubCoverType(I)V
    .locals 4
    .param p1, "newState"    # I

    .prologue
    const/16 v3, 0x16

    invoke-direct {p0}, Lcom/lge/systemservice/service/SmartCoverService;->isServiceEnabled()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverEnabled:Z

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v3}, Landroid/os/Handler;->removeMessages(I)V

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, p1}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {v1, v3, v2}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method


# virtual methods
.method public getCoverType()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverType:I

    return v0
.end method

.method public getSubCoverType()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverType:I

    return v0
.end method

.method readAppsportID()Lcom/lge/systemservice/service/SmartCoverService$AppsportID;
    .locals 4

    .prologue
    const-string v1, "/sys/class/switch/appsport_id/state"

    const/4 v2, 0x0

    invoke-direct {p0, v1, v2}, Lcom/lge/systemservice/service/SmartCoverService;->getCurrentValueWithFile(Ljava/lang/String;I)I

    move-result v0

    .local v0, "value":I
    sget-object v1, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "appsport: readAppsportID="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    invoke-direct {v1, p0, v0}, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;-><init>(Lcom/lge/systemservice/service/SmartCoverService;I)V

    return-object v1
.end method

.method public registerCallback(Lcom/lge/systemservice/core/ISmartCoverCallback;I)Z
    .locals 12
    .param p1, "clbk"    # Lcom/lge/systemservice/core/ISmartCoverCallback;
    .param p2, "eventType"    # I

    .prologue
    const/4 v11, 0x4

    const/4 v10, 0x3

    const/4 v9, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "PID="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {}, Landroid/os/Binder;->getCallingPid()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ", binder="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-interface {p1}, Lcom/lge/systemservice/core/ISmartCoverCallback;->asBinder()Landroid/os/IBinder;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "callbackInfo":Ljava/lang/String;
    sget-object v6, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "register callback: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-ne p2, v5, :cond_0

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCoverCallbacks:Ljava/util/List;

    .local v1, "callbacks":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    :goto_0
    monitor-enter v1

    :try_start_0
    invoke-interface {v1, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    sget-object v5, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "already added this callback, callback: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v1    # "callbacks":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    :goto_1
    return v4

    :cond_0
    if-ne p2, v9, :cond_1

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenCallbacks:Ljava/util/List;

    .restart local v1    # "callbacks":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    goto :goto_0

    .end local v1    # "callbacks":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    :cond_1
    if-ne p2, v11, :cond_2

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mFolderCallbacks:Ljava/util/List;

    .restart local v1    # "callbacks":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    goto :goto_0

    .end local v1    # "callbacks":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    :cond_2
    if-ne p2, v10, :cond_3

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverCallbacks:Ljava/util/List;

    .restart local v1    # "callbacks":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    goto :goto_0

    .end local v1    # "callbacks":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    :cond_3
    sget-object v5, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Callback is wrong, callback: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .restart local v1    # "callbacks":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    :cond_4
    :try_start_1
    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_5

    sget-object v5, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "can\'t add callback!, callback: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    monitor-exit v1

    goto :goto_1

    :catchall_0
    move-exception v4

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v4

    :cond_5
    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    invoke-interface {p1}, Lcom/lge/systemservice/core/ISmartCoverCallback;->asBinder()Landroid/os/IBinder;

    move-result-object v4

    iget-object v6, p0, Lcom/lge/systemservice/service/SmartCoverService;->callbackDeathRecipient:Landroid/os/IBinder$DeathRecipient;

    const/4 v7, 0x0

    invoke-interface {v4, v6, v7}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_3
    .catch Landroid/os/RemoteException; {:try_start_3 .. :try_end_3} :catch_0

    :goto_2
    if-ne p2, v5, :cond_6

    iget-object v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockSmartCover:Ljava/lang/Object;

    .local v3, "mLock":Ljava/lang/Object;
    :goto_3
    monitor-enter v3

    :try_start_4
    invoke-direct {p0, p2, p1}, Lcom/lge/systemservice/service/SmartCoverService;->notifyCurrentStateAtRegisterLocked(ILcom/lge/systemservice/core/ISmartCoverCallback;)V
    :try_end_4
    .catch Landroid/os/RemoteException; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    :goto_4
    :try_start_5
    monitor-exit v3
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    move v4, v5

    goto :goto_1

    .end local v3    # "mLock":Ljava/lang/Object;
    :catch_0
    move-exception v2

    .local v2, "e":Landroid/os/RemoteException;
    sget-object v4, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "callback: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6, v2}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_2

    .end local v2    # "e":Landroid/os/RemoteException;
    :cond_6
    if-ne p2, v9, :cond_7

    iget-object v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockPen:Ljava/lang/Object;

    .restart local v3    # "mLock":Ljava/lang/Object;
    goto :goto_3

    .end local v3    # "mLock":Ljava/lang/Object;
    :cond_7
    if-ne p2, v11, :cond_8

    iget-object v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockFolder:Ljava/lang/Object;

    .restart local v3    # "mLock":Ljava/lang/Object;
    goto :goto_3

    .end local v3    # "mLock":Ljava/lang/Object;
    :cond_8
    if-ne p2, v10, :cond_9

    iget-object v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockSubCover:Ljava/lang/Object;

    .restart local v3    # "mLock":Ljava/lang/Object;
    goto :goto_3

    .end local v3    # "mLock":Ljava/lang/Object;
    :cond_9
    move v4, v5

    goto/16 :goto_1

    .restart local v3    # "mLock":Ljava/lang/Object;
    :catch_1
    move-exception v2

    .restart local v2    # "e":Landroid/os/RemoteException;
    :try_start_6
    sget-object v4, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Catch RemoteException, callback:"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6, v2}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_4

    .end local v2    # "e":Landroid/os/RemoteException;
    :catchall_1
    move-exception v4

    monitor-exit v3
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    throw v4
.end method

.method sendAppsportIntent()V
    .locals 3

    .prologue
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "com.lge.appsport"

    const-string v2, "com.lge.appsport.AppsPortService"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "com.lge.appsport"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "Docked"

    iget-boolean v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mAppsportDocked:Z

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCurAppsportID:Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    if-eqz v1, :cond_0

    const-string v1, "ID"

    iget-object v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCurAppsportID:Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    # getter for: Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->ID:I
    invoke-static {v2}, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->access$200(Lcom/lge/systemservice/service/SmartCoverService$AppsportID;)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "Type"

    iget-object v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCurAppsportID:Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    # getter for: Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryType:I
    invoke-static {v2}, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->access$300(Lcom/lge/systemservice/service/SmartCoverService$AppsportID;)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "Color"

    iget-object v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCurAppsportID:Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    # getter for: Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryColor:I
    invoke-static {v2}, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->access$400(Lcom/lge/systemservice/service/SmartCoverService$AppsportID;)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "USB"

    iget-object v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCurAppsportID:Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    # getter for: Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableUSB:Z
    invoke-static {v2}, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->access$500(Lcom/lge/systemservice/service/SmartCoverService$AppsportID;)Z

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string v1, "GPIO"

    iget-object v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCurAppsportID:Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    # getter for: Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableGPIO:Z
    invoke-static {v2}, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->access$600(Lcom/lge/systemservice/service/SmartCoverService$AppsportID;)Z

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    :cond_0
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void
.end method

.method public unRegisterCallback(Lcom/lge/systemservice/core/ISmartCoverCallback;I)V
    .locals 7
    .param p1, "clbk"    # Lcom/lge/systemservice/core/ISmartCoverCallback;
    .param p2, "eventType"    # I

    .prologue
    const/4 v4, 0x1

    if-ne p2, v4, :cond_1

    iget-object v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mCoverCallbacks:Ljava/util/List;

    .local v2, "list":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    iget-object v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockSmartCover:Ljava/lang/Object;

    .local v3, "mLock":Ljava/lang/Object;
    :goto_0
    monitor-enter v3

    :try_start_0
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    :cond_0
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/ISmartCoverCallback;

    .local v0, "item":Lcom/lge/systemservice/core/ISmartCoverCallback;
    invoke-interface {p1}, Lcom/lge/systemservice/core/ISmartCoverCallback;->asBinder()Landroid/os/IBinder;

    move-result-object v4

    invoke-interface {v0}, Lcom/lge/systemservice/core/ISmartCoverCallback;->asBinder()Landroid/os/IBinder;

    move-result-object v5

    if-ne v4, v5, :cond_0

    sget-object v4, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "unregister SubCoverCallback: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-interface {p1}, Lcom/lge/systemservice/core/ISmartCoverCallback;->asBinder()Landroid/os/IBinder;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    goto :goto_1

    .end local v0    # "item":Lcom/lge/systemservice/core/ISmartCoverCallback;
    .end local v1    # "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    :catchall_0
    move-exception v4

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v4

    .end local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    .end local v3    # "mLock":Ljava/lang/Object;
    :cond_1
    const/4 v4, 0x2

    if-ne p2, v4, :cond_2

    iget-object v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mPenCallbacks:Ljava/util/List;

    .restart local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    iget-object v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockPen:Ljava/lang/Object;

    .restart local v3    # "mLock":Ljava/lang/Object;
    goto :goto_0

    .end local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    .end local v3    # "mLock":Ljava/lang/Object;
    :cond_2
    const/4 v4, 0x3

    if-ne p2, v4, :cond_3

    iget-object v2, p0, Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverCallbacks:Ljava/util/List;

    .restart local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    iget-object v3, p0, Lcom/lge/systemservice/service/SmartCoverService;->mLockSubCover:Ljava/lang/Object;

    .restart local v3    # "mLock":Ljava/lang/Object;
    goto :goto_0

    .end local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    .end local v3    # "mLock":Ljava/lang/Object;
    :cond_3
    sget-object v4, Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Callback is wrong, callback: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-interface {p1}, Lcom/lge/systemservice/core/ISmartCoverCallback;->asBinder()Landroid/os/IBinder;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_2
    return-void

    .restart local v1    # "iter":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    .restart local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/lge/systemservice/core/ISmartCoverCallback;>;"
    .restart local v3    # "mLock":Ljava/lang/Object;
    :cond_4
    :try_start_1
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2
.end method
