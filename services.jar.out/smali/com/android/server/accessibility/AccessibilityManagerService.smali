.class public Lcom/android/server/accessibility/AccessibilityManagerService;
.super Landroid/view/accessibility/IAccessibilityManager$Stub;
.source "AccessibilityManagerService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityContentObserver;,
        Lcom/android/server/accessibility/AccessibilityManagerService$UserState;,
        Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;,
        Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;,
        Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;,
        Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;,
        Lcom/android/server/accessibility/AccessibilityManagerService$Service;,
        Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;,
        Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;
    }
.end annotation


# static fields
.field private static final COMPONENT_NAME_SEPARATOR:C = ':'

.field private static final DEBUG:Z = false

.field private static final FUNCTION_DUMP:Ljava/lang/String; = "dump"

.field private static final FUNCTION_REGISTER_UI_TEST_AUTOMATION_SERVICE:Ljava/lang/String; = "registerUiTestAutomationService"

.field private static final GET_WINDOW_TOKEN:Ljava/lang/String; = "getWindowToken"

.field private static final LOG_TAG:Ljava/lang/String; = "AccessibilityManagerService"

.field private static final MAX_POOL_SIZE:I = 0xa

.field private static final OWN_PROCESS_ID:I

.field private static final TEMPORARY_ENABLE_ACCESSIBILITY_UNTIL_KEYGUARD_REMOVED:Ljava/lang/String; = "temporaryEnableAccessibilityStateUntilKeyguardRemoved"

.field private static final WAIT_FOR_USER_STATE_FULLY_INITIALIZED_MILLIS:I = 0xbb8

.field private static final WAIT_WINDOWS_TIMEOUT_MILLIS:I = 0x1388

.field private static final WINDOW_ID_UNKNOWN:I = -0x1

.field private static final sFakeAccessibilityServiceComponentName:Landroid/content/ComponentName;

.field private static sIdCounter:I

.field private static sNextWindowId:I


# instance fields
.field private final mContext:Landroid/content/Context;

.field private mCurrentUserId:I

.field private mEnableTouchExplorationDialog:Landroid/app/AlertDialog;

.field private final mEnabledServicesForFeedbackTempList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/accessibilityservice/AccessibilityServiceInfo;",
            ">;"
        }
    .end annotation
.end field

.field private final mGlobalClients:Landroid/os/RemoteCallbackList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/RemoteCallbackList",
            "<",
            "Landroid/view/accessibility/IAccessibilityManagerClient;",
            ">;"
        }
    .end annotation
.end field

.field private final mGlobalInteractionConnections:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray",
            "<",
            "Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;",
            ">;"
        }
    .end annotation
.end field

.field private final mGlobalWindowTokens:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray",
            "<",
            "Landroid/os/IBinder;",
            ">;"
        }
    .end annotation
.end field

.field private mHasInputFilter:Z

.field private mInitialized:Z

.field private mInputFilter:Lcom/android/server/accessibility/AccessibilityInputFilter;

.field private mInteractionBridge:Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;

.field private final mLock:Ljava/lang/Object;

.field private final mLockPatternUtils:Lcom/android/internal/widget/LockPatternUtils;

.field private final mMainHandler:Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;

.field private final mPackageManager:Landroid/content/pm/PackageManager;

.field private final mPendingEventPool:Landroid/util/Pools$Pool;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/Pools$Pool",
            "<",
            "Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;",
            ">;"
        }
    .end annotation
.end field

.field private final mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

.field private final mStringColonSplitter:Landroid/text/TextUtils$SimpleStringSplitter;

.field private final mTempAccessibilityServiceInfoList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/accessibilityservice/AccessibilityServiceInfo;",
            ">;"
        }
    .end annotation
.end field

.field private final mTempComponentNameSet:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set",
            "<",
            "Landroid/content/ComponentName;",
            ">;"
        }
    .end annotation
.end field

.field private final mTempPoint:Landroid/graphics/Point;

.field private final mTempRect:Landroid/graphics/Rect;

.field private final mTempRegion:Landroid/graphics/Region;

.field private final mUserManager:Landroid/os/UserManager;

.field private final mUserStates:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray",
            "<",
            "Lcom/android/server/accessibility/AccessibilityManagerService$UserState;",
            ">;"
        }
    .end annotation
.end field

.field private final mWindowManagerService:Landroid/view/WindowManagerInternal;

.field private mWindowsForAccessibilityCallback:Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 140
    new-instance v0, Landroid/content/ComponentName;

    const-string v1, "foo.bar"

    const-string v2, "FakeService"

    invoke-direct {v0, v1, v2}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Lcom/android/server/accessibility/AccessibilityManagerService;->sFakeAccessibilityServiceComponentName:Landroid/content/ComponentName;

    .line 147
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    sput v0, Lcom/android/server/accessibility/AccessibilityManagerService;->OWN_PROCESS_ID:I

    .line 153
    const/4 v0, 0x0

    sput v0, Lcom/android/server/accessibility/AccessibilityManagerService;->sIdCounter:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 227
    invoke-direct {p0}, Landroid/view/accessibility/IAccessibilityManager$Stub;-><init>()V

    .line 159
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    .line 161
    new-instance v0, Landroid/util/Pools$SimplePool;

    const/16 v1, 0xa

    invoke-direct {v0, v1}, Landroid/util/Pools$SimplePool;-><init>(I)V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mPendingEventPool:Landroid/util/Pools$Pool;

    .line 164
    new-instance v0, Landroid/text/TextUtils$SimpleStringSplitter;

    const/16 v1, 0x3a

    invoke-direct {v0, v1}, Landroid/text/TextUtils$SimpleStringSplitter;-><init>(C)V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mStringColonSplitter:Landroid/text/TextUtils$SimpleStringSplitter;

    .line 167
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mEnabledServicesForFeedbackTempList:Ljava/util/List;

    .line 170
    new-instance v0, Landroid/graphics/Region;

    invoke-direct {v0}, Landroid/graphics/Region;-><init>()V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempRegion:Landroid/graphics/Region;

    .line 172
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempRect:Landroid/graphics/Rect;

    .line 174
    new-instance v0, Landroid/graphics/Point;

    invoke-direct {v0}, Landroid/graphics/Point;-><init>()V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempPoint:Landroid/graphics/Point;

    .line 192
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    .line 194
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempAccessibilityServiceInfoList:Ljava/util/List;

    .line 197
    new-instance v0, Landroid/os/RemoteCallbackList;

    invoke-direct {v0}, Landroid/os/RemoteCallbackList;-><init>()V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalClients:Landroid/os/RemoteCallbackList;

    .line 200
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalInteractionConnections:Landroid/util/SparseArray;

    .line 203
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalWindowTokens:Landroid/util/SparseArray;

    .line 205
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mUserStates:Landroid/util/SparseArray;

    .line 211
    const/4 v0, 0x0

    iput v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mCurrentUserId:I

    .line 228
    iput-object p1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    .line 229
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mPackageManager:Landroid/content/pm/PackageManager;

    .line 230
    const-class v0, Landroid/view/WindowManagerInternal;

    invoke-static {v0}, Lcom/android/server/LocalServices;->getService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManagerInternal;

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowManagerService:Landroid/view/WindowManagerInternal;

    .line 231
    const-string v0, "user"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/UserManager;

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mUserManager:Landroid/os/UserManager;

    .line 232
    new-instance v0, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-direct {v0, p0}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;)V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    .line 233
    new-instance v0, Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;

    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mMainHandler:Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;

    .line 234
    new-instance v0, Lcom/android/internal/widget/LockPatternUtils;

    invoke-direct {v0, p1}, Lcom/android/internal/widget/LockPatternUtils;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLockPatternUtils:Lcom/android/internal/widget/LockPatternUtils;

    .line 235
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->registerBroadcastReceivers()V

    .line 236
    new-instance v0, Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityContentObserver;

    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mMainHandler:Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;

    invoke-direct {v0, p0, v1}, Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityContentObserver;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;Landroid/os/Handler;)V

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityContentObserver;->register(Landroid/content/ContentResolver;)V

    .line 238
    return-void
.end method

.method static synthetic access$000(Lcom/android/server/accessibility/AccessibilityManagerService;)Ljava/lang/Object;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$100(Lcom/android/server/accessibility/AccessibilityManagerService;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mCurrentUserId:I

    return v0
.end method

.method static synthetic access$1600(Lcom/android/server/accessibility/AccessibilityManagerService;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$1700(Lcom/android/server/accessibility/AccessibilityManagerService;II)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # I
    .param p2, "x2"    # I

    .prologue
    .line 120
    invoke-direct {p0, p1, p2}, Lcom/android/server/accessibility/AccessibilityManagerService;->removeAccessibilityInteractionConnectionLocked(II)V

    return-void
.end method

.method static synthetic access$1800(Lcom/android/server/accessibility/AccessibilityManagerService;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-boolean v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mHasInputFilter:Z

    return v0
.end method

.method static synthetic access$1900(Lcom/android/server/accessibility/AccessibilityManagerService;)Lcom/android/server/accessibility/AccessibilityInputFilter;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInputFilter:Lcom/android/server/accessibility/AccessibilityInputFilter;

    return-object v0
.end method

.method static synthetic access$200(Lcom/android/server/accessibility/AccessibilityManagerService;)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$2000(Lcom/android/server/accessibility/AccessibilityManagerService;)Landroid/os/RemoteCallbackList;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalClients:Landroid/os/RemoteCallbackList;

    return-object v0
.end method

.method static synthetic access$2100(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->updateInputFilter(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    return-void
.end method

.method static synthetic access$2200(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$Service;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->showEnableTouchExplorationDialog(Lcom/android/server/accessibility/AccessibilityManagerService$Service;)V

    return-void
.end method

.method static synthetic access$2300(Lcom/android/server/accessibility/AccessibilityManagerService;)Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getInteractionBridgeLocked()Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$2600(Lcom/android/server/accessibility/AccessibilityManagerService;)Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mMainHandler:Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;

    return-object v0
.end method

.method static synthetic access$2808()I
    .locals 2

    .prologue
    .line 120
    sget v0, Lcom/android/server/accessibility/AccessibilityManagerService;->sIdCounter:I

    add-int/lit8 v1, v0, 0x1

    sput v1, Lcom/android/server/accessibility/AccessibilityManagerService;->sIdCounter:I

    return v0
.end method

.method static synthetic access$2900()Landroid/content/ComponentName;
    .locals 1

    .prologue
    .line 120
    sget-object v0, Lcom/android/server/accessibility/AccessibilityManagerService;->sFakeAccessibilityServiceComponentName:Landroid/content/ComponentName;

    return-object v0
.end method

.method static synthetic access$3000(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$Service;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .param p2, "x2"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1, p2}, Lcom/android/server/accessibility/AccessibilityManagerService;->removeServiceLocked(Lcom/android/server/accessibility/AccessibilityManagerService$Service;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    return-void
.end method

.method static synthetic access$3100(Lcom/android/server/accessibility/AccessibilityManagerService;)Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    return-object v0
.end method

.method static synthetic access$3200(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$Service;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .param p2, "x2"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1, p2}, Lcom/android/server/accessibility/AccessibilityManagerService;->addServiceLocked(Lcom/android/server/accessibility/AccessibilityManagerService$Service;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    return-void
.end method

.method static synthetic access$3300(Lcom/android/server/accessibility/AccessibilityManagerService;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->ensureWindowsAvailableTimed()V

    return-void
.end method

.method static synthetic access$3400(Lcom/android/server/accessibility/AccessibilityManagerService;)Landroid/graphics/Region;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempRegion:Landroid/graphics/Region;

    return-object v0
.end method

.method static synthetic access$3500(Lcom/android/server/accessibility/AccessibilityManagerService;I)Landroid/view/MagnificationSpec;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # I

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCompatibleMagnificationSpecLocked(I)Landroid/view/MagnificationSpec;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$3600(Lcom/android/server/accessibility/AccessibilityManagerService;)Landroid/view/WindowManagerInternal;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowManagerService:Landroid/view/WindowManagerInternal;

    return-object v0
.end method

.method static synthetic access$3700(Lcom/android/server/accessibility/AccessibilityManagerService;)Landroid/util/SparseArray;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalInteractionConnections:Landroid/util/SparseArray;

    return-object v0
.end method

.method static synthetic access$400(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readConfigurationForUserStateLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$4200(Lcom/android/server/accessibility/AccessibilityManagerService;Landroid/view/KeyEvent;II)Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Landroid/view/KeyEvent;
    .param p2, "x2"    # I
    .param p3, "x3"    # I

    .prologue
    .line 120
    invoke-direct {p0, p1, p2, p3}, Lcom/android/server/accessibility/AccessibilityManagerService;->obtainPendingEventLocked(Landroid/view/KeyEvent;II)Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$4300(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->recyclePendingEventLocked(Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;)V

    return-void
.end method

.method static synthetic access$4400(Lcom/android/server/accessibility/AccessibilityManagerService;Landroid/os/IBinder;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Landroid/os/IBinder;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->findWindowIdLocked(Landroid/os/IBinder;)I

    move-result v0

    return v0
.end method

.method static synthetic access$4500(Lcom/android/server/accessibility/AccessibilityManagerService;)Landroid/graphics/Rect;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempRect:Landroid/graphics/Rect;

    return-object v0
.end method

.method static synthetic access$4600(Lcom/android/server/accessibility/AccessibilityManagerService;)Landroid/graphics/Point;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempPoint:Landroid/graphics/Point;

    return-object v0
.end method

.method static synthetic access$4700(Lcom/android/server/accessibility/AccessibilityManagerService;)Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowsForAccessibilityCallback:Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;

    return-object v0
.end method

.method static synthetic access$4800(Lcom/android/server/accessibility/AccessibilityManagerService;)Landroid/os/UserManager;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;

    .prologue
    .line 120
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mUserManager:Landroid/os/UserManager;

    return-object v0
.end method

.method static synthetic access$4900()I
    .locals 1

    .prologue
    .line 120
    sget v0, Lcom/android/server/accessibility/AccessibilityManagerService;->OWN_PROCESS_ID:I

    return v0
.end method

.method static synthetic access$500(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->onUserStateChangedLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    return-void
.end method

.method static synthetic access$5000(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->unbindAllServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    return-void
.end method

.method static synthetic access$5100(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readAccessibilityEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$5200(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readTouchExplorationEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$5300(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readDisplayMagnificationEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$5400(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readEnabledAccessibilityServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$5500(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readTouchExplorationGrantedAccessibilityServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$5600(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readEnhancedWebAccessibilityEnabledChangedLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$5700(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readDisplayColorAdjustmentSettingsLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$5800(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->updateDisplayColorAdjustmentSettingsLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    return-void
.end method

.method static synthetic access$5900(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readHighTextContrastEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$600(Lcom/android/server/accessibility/AccessibilityManagerService;I)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # I

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->getUserStateLocked(I)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$700(Lcom/android/server/accessibility/AccessibilityManagerService;Ljava/lang/String;Ljava/util/Set;I)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # Ljava/util/Set;
    .param p3, "x3"    # I

    .prologue
    .line 120
    invoke-direct {p0, p1, p2, p3}, Lcom/android/server/accessibility/AccessibilityManagerService;->persistComponentNamesToSettingLocked(Ljava/lang/String;Ljava/util/Set;I)V

    return-void
.end method

.method static synthetic access$800(Lcom/android/server/accessibility/AccessibilityManagerService;I)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # I

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->switchUser(I)V

    return-void
.end method

.method static synthetic access$900(Lcom/android/server/accessibility/AccessibilityManagerService;I)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/accessibility/AccessibilityManagerService;
    .param p1, "x1"    # I

    .prologue
    .line 120
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->removeUser(I)V

    return-void
.end method

.method private addServiceLocked(Lcom/android/server/accessibility/AccessibilityManagerService$Service;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 2
    .param p1, "service"    # Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .param p2, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1044
    :try_start_0
    invoke-virtual {p1}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->linkToOwnDeathLocked()V

    .line 1045
    iget-object v0, p2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 1046
    iget-object v0, p2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mComponentNameToServiceMap:Ljava/util/Map;

    iget-object v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mComponentName:Landroid/content/ComponentName;

    invoke-interface {v0, v1, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1050
    :goto_0
    return-void

    .line 1047
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private canDispatchEventToServiceLocked(Lcom/android/server/accessibility/AccessibilityManagerService$Service;Landroid/view/accessibility/AccessibilityEvent;I)Z
    .locals 7
    .param p1, "service"    # Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .param p2, "event"    # Landroid/view/accessibility/AccessibilityEvent;
    .param p3, "handledFeedbackTypes"    # I

    .prologue
    const/4 v4, 0x0

    .line 1079
    invoke-virtual {p1}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->canReceiveEventsLocked()Z

    move-result v5

    if-nez v5, :cond_1

    .line 1106
    :cond_0
    :goto_0
    return v4

    .line 1083
    :cond_1
    invoke-virtual {p2}, Landroid/view/accessibility/AccessibilityEvent;->getWindowId()I

    move-result v5

    const/4 v6, -0x1

    if-eq v5, v6, :cond_2

    invoke-virtual {p2}, Landroid/view/accessibility/AccessibilityEvent;->isImportantForAccessibility()Z

    move-result v5

    if-nez v5, :cond_2

    iget v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mFetchFlags:I

    and-int/lit8 v5, v5, 0x8

    if-eqz v5, :cond_0

    .line 1089
    :cond_2
    invoke-virtual {p2}, Landroid/view/accessibility/AccessibilityEvent;->getEventType()I

    move-result v0

    .line 1090
    .local v0, "eventType":I
    iget v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mEventTypes:I

    and-int/2addr v5, v0

    if-ne v5, v0, :cond_0

    .line 1094
    iget-object v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mPackageNames:Ljava/util/Set;

    .line 1095
    .local v3, "packageNames":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    invoke-virtual {p2}, Landroid/view/accessibility/AccessibilityEvent;->getPackageName()Ljava/lang/CharSequence;

    move-result-object v5

    if-eqz v5, :cond_5

    invoke-virtual {p2}, Landroid/view/accessibility/AccessibilityEvent;->getPackageName()Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1098
    .local v2, "packageName":Ljava/lang/String;
    :goto_1
    invoke-interface {v3}, Ljava/util/Set;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_3

    invoke-interface {v3, v2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 1099
    :cond_3
    iget v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mFeedbackType:I

    .line 1100
    .local v1, "feedbackType":I
    and-int v5, p3, v1

    if-ne v5, v1, :cond_4

    const/16 v5, 0x10

    if-ne v1, v5, :cond_0

    .line 1102
    :cond_4
    const/4 v4, 0x1

    goto :goto_0

    .line 1095
    .end local v1    # "feedbackType":I
    .end local v2    # "packageName":Ljava/lang/String;
    :cond_5
    const/4 v2, 0x0

    goto :goto_1
.end method

.method private canRequestAndRequestsEnhancedWebAccessibilityLocked(Lcom/android/server/accessibility/AccessibilityManagerService$Service;)Z
    .locals 2
    .param p1, "service"    # Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .prologue
    const/4 v0, 0x0

    .line 1595
    invoke-virtual {p1}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->canReceiveEventsLocked()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-boolean v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mRequestEnhancedWebAccessibility:Z

    if-nez v1, :cond_1

    .line 1602
    :cond_0
    :goto_0
    return v0

    .line 1598
    :cond_1
    iget-boolean v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mIsAutomation:Z

    if-nez v1, :cond_2

    iget-object v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mAccessibilityServiceInfo:Landroid/accessibilityservice/AccessibilityServiceInfo;

    invoke-virtual {v1}, Landroid/accessibilityservice/AccessibilityServiceInfo;->getCapabilities()I

    move-result v1

    and-int/lit8 v1, v1, 0x4

    if-eqz v1, :cond_0

    .line 1600
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private canRequestAndRequestsTouchExplorationLocked(Lcom/android/server/accessibility/AccessibilityManagerService$Service;)Z
    .locals 5
    .param p1, "service"    # Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 1543
    invoke-virtual {p1}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->canReceiveEventsLocked()Z

    move-result v3

    if-eqz v3, :cond_0

    iget-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mRequestTouchExplorationMode:Z

    if-nez v3, :cond_2

    :cond_0
    move v1, v2

    .line 1573
    :cond_1
    :goto_0
    return v1

    .line 1547
    :cond_2
    iget-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mIsAutomation:Z

    if-nez v3, :cond_1

    .line 1550
    iget-object v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mResolveInfo:Landroid/content/pm/ResolveInfo;

    iget-object v3, v3, Landroid/content/pm/ResolveInfo;->serviceInfo:Landroid/content/pm/ServiceInfo;

    iget-object v3, v3, Landroid/content/pm/ServiceInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget v3, v3, Landroid/content/pm/ApplicationInfo;->targetSdkVersion:I

    const/16 v4, 0x11

    if-gt v3, v4, :cond_5

    .line 1555
    iget v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mUserId:I

    invoke-direct {p0, v3}, Lcom/android/server/accessibility/AccessibilityManagerService;->getUserStateLocked(I)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v0

    .line 1556
    .local v0, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    iget-object v3, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mTouchExplorationGrantedServices:Ljava/util/Set;

    iget-object v4, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mComponentName:Landroid/content/ComponentName;

    invoke-interface {v3, v4}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 1558
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mEnableTouchExplorationDialog:Landroid/app/AlertDialog;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mEnableTouchExplorationDialog:Landroid/app/AlertDialog;

    invoke-virtual {v1}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v1

    if-nez v1, :cond_4

    .line 1560
    :cond_3
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mMainHandler:Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;

    const/4 v3, 0x7

    invoke-virtual {v1, v3, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    .end local v0    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :cond_4
    move v1, v2

    .line 1573
    goto :goto_0

    .line 1568
    :cond_5
    iget-object v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mAccessibilityServiceInfo:Landroid/accessibilityservice/AccessibilityServiceInfo;

    invoke-virtual {v3}, Landroid/accessibilityservice/AccessibilityServiceInfo;->getCapabilities()I

    move-result v3

    and-int/lit8 v3, v3, 0x2

    if-eqz v3, :cond_4

    goto :goto_0
.end method

.method private ensureWindowsAvailableTimed()V
    .locals 12

    .prologue
    .line 1854
    iget-object v8, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v8

    .line 1855
    :try_start_0
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    iget-object v7, v7, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->mWindows:Ljava/util/List;

    if-eqz v7, :cond_0

    .line 1856
    monitor-exit v8

    .line 1884
    :goto_0
    return-void

    .line 1860
    :cond_0
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowsForAccessibilityCallback:Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;

    if-nez v7, :cond_1

    .line 1861
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v6

    .line 1862
    .local v6, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    invoke-direct {p0, v6}, Lcom/android/server/accessibility/AccessibilityManagerService;->onUserStateChangedLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1865
    .end local v6    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :cond_1
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowsForAccessibilityCallback:Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;

    if-nez v7, :cond_2

    .line 1866
    monitor-exit v8

    goto :goto_0

    .line 1883
    :catchall_0
    move-exception v7

    monitor-exit v8
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v7

    .line 1870
    :cond_2
    :try_start_1
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v4

    .line 1871
    .local v4, "startMillis":J
    :goto_1
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    iget-object v7, v7, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->mWindows:Ljava/util/List;

    if-nez v7, :cond_4

    .line 1872
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v10

    sub-long v0, v10, v4

    .line 1873
    .local v0, "elapsedMillis":J
    const-wide/16 v10, 0x1388

    sub-long v2, v10, v0

    .line 1874
    .local v2, "remainMillis":J
    const-wide/16 v10, 0x0

    cmp-long v7, v2, v10

    if-gtz v7, :cond_3

    .line 1875
    monitor-exit v8
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 1878
    :cond_3
    :try_start_2
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    invoke-virtual {v7, v2, v3}, Ljava/lang/Object;->wait(J)V
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    .line 1879
    :catch_0
    move-exception v7

    goto :goto_1

    .line 1883
    .end local v0    # "elapsedMillis":J
    .end local v2    # "remainMillis":J
    :cond_4
    :try_start_3
    monitor-exit v8
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0
.end method

.method private findWindowIdLocked(Landroid/os/IBinder;)I
    .locals 4
    .param p1, "token"    # Landroid/os/IBinder;

    .prologue
    .line 1841
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v3, p1}, Landroid/util/SparseArray;->indexOfValue(Ljava/lang/Object;)I

    move-result v0

    .line 1842
    .local v0, "globalIndex":I
    if-ltz v0, :cond_0

    .line 1843
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v3, v0}, Landroid/util/SparseArray;->keyAt(I)I

    move-result v3

    .line 1850
    :goto_0
    return v3

    .line 1845
    :cond_0
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v2

    .line 1846
    .local v2, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    iget-object v3, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v3, p1}, Landroid/util/SparseArray;->indexOfValue(Ljava/lang/Object;)I

    move-result v1

    .line 1847
    .local v1, "userIndex":I
    if-ltz v1, :cond_1

    .line 1848
    iget-object v3, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v3, v1}, Landroid/util/SparseArray;->keyAt(I)I

    move-result v3

    goto :goto_0

    .line 1850
    :cond_1
    const/4 v3, -0x1

    goto :goto_0
.end method

.method private getCompatibleMagnificationSpecLocked(I)Landroid/view/MagnificationSpec;
    .locals 2
    .param p1, "windowId"    # I

    .prologue
    .line 1614
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/IBinder;

    .line 1615
    .local v0, "windowToken":Landroid/os/IBinder;
    if-nez v0, :cond_0

    .line 1616
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v1

    iget-object v1, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "windowToken":Landroid/os/IBinder;
    check-cast v0, Landroid/os/IBinder;

    .line 1618
    .restart local v0    # "windowToken":Landroid/os/IBinder;
    :cond_0
    if-eqz v0, :cond_1

    .line 1619
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowManagerService:Landroid/view/WindowManagerInternal;

    invoke-virtual {v1, v0}, Landroid/view/WindowManagerInternal;->getCompatibleMagnificationSpecForWindow(Landroid/os/IBinder;)Landroid/view/MagnificationSpec;

    move-result-object v1

    .line 1622
    :goto_0
    return-object v1

    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    .locals 1

    .prologue
    .line 219
    iget v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mCurrentUserId:I

    invoke-direct {p0, v0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getUserStateLocked(I)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v0

    return-object v0
.end method

.method private getInteractionBridgeLocked()Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;
    .locals 1

    .prologue
    .line 863
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInteractionBridge:Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;

    if-nez v0, :cond_0

    .line 864
    new-instance v0, Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;

    invoke-direct {v0, p0}, Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;)V

    iput-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInteractionBridge:Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;

    .line 866
    :cond_0
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInteractionBridge:Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;

    return-object v0
.end method

.method private getUserStateLocked(I)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    .locals 2
    .param p1, "userId"    # I

    .prologue
    .line 241
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mUserStates:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .line 242
    .local v0, "state":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    if-nez v0, :cond_0

    .line 243
    new-instance v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .end local v0    # "state":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    invoke-direct {v0, p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;I)V

    .line 244
    .restart local v0    # "state":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mUserStates:Landroid/util/SparseArray;

    invoke-virtual {v1, p1, v0}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 246
    :cond_0
    return-object v0
.end method

.method private hasRunningServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 1
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1610
    iget-object v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBindingServices:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private manageServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 11
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    const/4 v10, 0x0

    .line 1170
    iget-object v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mComponentNameToServiceMap:Ljava/util/Map;

    .line 1172
    .local v1, "componentNameToServiceMap":Ljava/util/Map;, "Ljava/util/Map<Landroid/content/ComponentName;Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    iget-boolean v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsAccessibilityEnabled:Z

    .line 1174
    .local v5, "isEnabled":Z
    const/4 v3, 0x0

    .local v3, "i":I
    iget-object v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInstalledServices:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v2

    .local v2, "count":I
    :goto_0
    if-ge v3, v2, :cond_7

    .line 1175
    iget-object v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInstalledServices:Ljava/util/List;

    invoke-interface {v7, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/accessibilityservice/AccessibilityServiceInfo;

    .line 1176
    .local v4, "installedService":Landroid/accessibilityservice/AccessibilityServiceInfo;
    invoke-virtual {v4}, Landroid/accessibilityservice/AccessibilityServiceInfo;->getId()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Landroid/content/ComponentName;->unflattenFromString(Ljava/lang/String;)Landroid/content/ComponentName;

    move-result-object v0

    .line 1178
    .local v0, "componentName":Landroid/content/ComponentName;
    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 1180
    .local v6, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    if-eqz v5, :cond_5

    .line 1182
    iget-object v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBindingServices:Ljava/util/Set;

    invoke-interface {v7, v0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    .line 1174
    :cond_0
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 1185
    :cond_1
    iget-object v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mEnabledServices:Ljava/util/Set;

    invoke-interface {v7, v0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 1186
    if-nez v6, :cond_3

    .line 1187
    new-instance v6, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .end local v6    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    iget v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-direct {v6, p0, v7, v0, v4}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;ILandroid/content/ComponentName;Landroid/accessibilityservice/AccessibilityServiceInfo;)V

    .line 1191
    .restart local v6    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_2
    invoke-virtual {v6}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->bindLocked()Z

    goto :goto_1

    .line 1188
    :cond_3
    iget-object v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v7, v6}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    goto :goto_1

    .line 1193
    :cond_4
    if-eqz v6, :cond_0

    .line 1194
    invoke-virtual {v6}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->unbindLocked()Z

    goto :goto_1

    .line 1198
    :cond_5
    if-eqz v6, :cond_6

    .line 1199
    invoke-virtual {v6}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->unbindLocked()Z

    goto :goto_1

    .line 1201
    :cond_6
    iget-object v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBindingServices:Ljava/util/Set;

    invoke-interface {v7, v0}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    goto :goto_1

    .line 1208
    .end local v0    # "componentName":Landroid/content/ComponentName;
    .end local v4    # "installedService":Landroid/accessibilityservice/AccessibilityServiceInfo;
    .end local v6    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_7
    if-eqz v5, :cond_8

    iget-object v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v7}, Ljava/util/concurrent/CopyOnWriteArrayList;->isEmpty()Z

    move-result v7

    if-eqz v7, :cond_8

    iget-object v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBindingServices:Ljava/util/Set;

    invoke-interface {v7}, Ljava/util/Set;->isEmpty()Z

    move-result v7

    if-eqz v7, :cond_8

    .line 1210
    iput-boolean v10, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsAccessibilityEnabled:Z

    .line 1211
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v7}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    const-string v8, "accessibility_enabled"

    iget v9, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-static {v7, v8, v10, v9}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    .line 1214
    :cond_8
    return-void
.end method

.method private notifyAccessibilityServicesDelayedLocked(Landroid/view/accessibility/AccessibilityEvent;Z)V
    .locals 6
    .param p1, "event"    # Landroid/view/accessibility/AccessibilityEvent;
    .param p2, "isDefault"    # Z

    .prologue
    .line 1023
    :try_start_0
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v3

    .line 1024
    .local v3, "state":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    const/4 v1, 0x0

    .local v1, "i":I
    iget-object v4, v3, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v4}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v0

    .local v0, "count":I
    :goto_0
    if-ge v1, v0, :cond_1

    .line 1025
    iget-object v4, v3, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v4, v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 1027
    .local v2, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    iget-boolean v4, v2, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mIsDefault:Z

    if-ne v4, p2, :cond_0

    .line 1028
    iget v4, v3, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mHandledFeedbackTypes:I

    invoke-direct {p0, v2, p1, v4}, Lcom/android/server/accessibility/AccessibilityManagerService;->canDispatchEventToServiceLocked(Lcom/android/server/accessibility/AccessibilityManagerService$Service;Landroid/view/accessibility/AccessibilityEvent;I)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1030
    iget v4, v3, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mHandledFeedbackTypes:I

    iget v5, v2, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mFeedbackType:I

    or-int/2addr v4, v5

    iput v4, v3, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mHandledFeedbackTypes:I

    .line 1031
    invoke-virtual {v2, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->notifyAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V
    :try_end_0
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1024
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1035
    .end local v0    # "count":I
    .end local v1    # "i":I
    .end local v2    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .end local v3    # "state":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :catch_0
    move-exception v4

    .line 1040
    :cond_1
    return-void
.end method

.method private notifyClearAccessibilityCacheLocked()V
    .locals 4

    .prologue
    .line 916
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v2

    .line 917
    .local v2, "state":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    iget-object v3, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v3

    add-int/lit8 v0, v3, -0x1

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_0

    .line 918
    iget-object v3, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v3, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 919
    .local v1, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-virtual {v1}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->notifyClearAccessibilityNodeInfoCache()V

    .line 917
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 921
    .end local v1    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_0
    return-void
.end method

.method private notifyGestureLocked(IZ)Z
    .locals 4
    .param p1, "gestureId"    # I
    .param p2, "isDefault"    # Z

    .prologue
    .line 879
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v2

    .line 880
    .local v2, "state":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    iget-object v3, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v3

    add-int/lit8 v0, v3, -0x1

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_1

    .line 881
    iget-object v3, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v3, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 882
    .local v1, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    iget-boolean v3, v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mRequestTouchExplorationMode:Z

    if-eqz v3, :cond_0

    iget-boolean v3, v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mIsDefault:Z

    if-ne v3, p2, :cond_0

    .line 883
    invoke-virtual {v1, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->notifyGesture(I)V

    .line 884
    const/4 v3, 0x1

    .line 887
    .end local v1    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :goto_1
    return v3

    .line 880
    .restart local v1    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 887
    .end local v1    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_1
    const/4 v3, 0x0

    goto :goto_1
.end method

.method private notifyKeyEventLocked(Landroid/view/KeyEvent;IZ)Z
    .locals 4
    .param p1, "event"    # Landroid/view/KeyEvent;
    .param p2, "policyFlags"    # I
    .param p3, "isDefault"    # Z

    .prologue
    .line 897
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v2

    .line 898
    .local v2, "state":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    iget-object v3, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v3

    add-int/lit8 v0, v3, -0x1

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_2

    .line 899
    iget-object v3, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v3, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 902
    .local v1, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    iget-boolean v3, v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mRequestFilterKeyEvents:Z

    if-eqz v3, :cond_0

    iget-object v3, v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mAccessibilityServiceInfo:Landroid/accessibilityservice/AccessibilityServiceInfo;

    invoke-virtual {v3}, Landroid/accessibilityservice/AccessibilityServiceInfo;->getCapabilities()I

    move-result v3

    and-int/lit8 v3, v3, 0x8

    if-nez v3, :cond_1

    .line 898
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 907
    :cond_1
    iget-boolean v3, v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mIsDefault:Z

    if-ne v3, p3, :cond_0

    .line 908
    invoke-virtual {v1, p1, p2}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->notifyKeyEvent(Landroid/view/KeyEvent;I)V

    .line 909
    const/4 v3, 0x1

    .line 912
    .end local v1    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :goto_1
    return v3

    :cond_2
    const/4 v3, 0x0

    goto :goto_1
.end method

.method private obtainPendingEventLocked(Landroid/view/KeyEvent;II)Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;
    .locals 2
    .param p1, "event"    # Landroid/view/KeyEvent;
    .param p2, "policyFlags"    # I
    .param p3, "sequence"    # I

    .prologue
    .line 1825
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mPendingEventPool:Landroid/util/Pools$Pool;

    invoke-interface {v1}, Landroid/util/Pools$Pool;->acquire()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;

    .line 1826
    .local v0, "pendingEvent":Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;
    if-nez v0, :cond_0

    .line 1827
    new-instance v0, Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;

    .end local v0    # "pendingEvent":Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;
    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService$1;)V

    .line 1829
    .restart local v0    # "pendingEvent":Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;
    :cond_0
    iput-object p1, v0, Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;->event:Landroid/view/KeyEvent;

    .line 1830
    iput p2, v0, Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;->policyFlags:I

    .line 1831
    iput p3, v0, Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;->sequence:I

    .line 1832
    return-object v0
.end method

.method private onUserStateChangedLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 1
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1324
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInitialized:Z

    .line 1325
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->updateLegacyCapabilitiesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1326
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->updateServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1327
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->updateWindowsForAccessibilityCallbackLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1328
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->updateAccessibilityFocusBehaviorLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1329
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->updateFilterKeyEventsLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1330
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->updateTouchExplorationLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1331
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->updateEnhancedWebAccessibilityLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1332
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->updateDisplayColorAdjustmentSettingsLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1333
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->scheduleUpdateInputFilter(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1334
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->scheduleUpdateClientsIfNeededLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1335
    return-void
.end method

.method private persistComponentNamesToSettingLocked(Ljava/lang/String;Ljava/util/Set;I)V
    .locals 5
    .param p1, "settingName"    # Ljava/lang/String;
    .param p3, "userId"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Set",
            "<",
            "Landroid/content/ComponentName;",
            ">;I)V"
        }
    .end annotation

    .prologue
    .line 1158
    .local p2, "componentNames":Ljava/util/Set;, "Ljava/util/Set<Landroid/content/ComponentName;>;"
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 1159
    .local v0, "builder":Ljava/lang/StringBuilder;
    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/ComponentName;

    .line 1160
    .local v1, "componentName":Landroid/content/ComponentName;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    if-lez v3, :cond_0

    .line 1161
    const/16 v3, 0x3a

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1163
    :cond_0
    invoke-virtual {v1}, Landroid/content/ComponentName;->flattenToShortString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 1165
    .end local v1    # "componentName":Landroid/content/ComponentName;
    :cond_1
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, p1, v4, p3}, Landroid/provider/Settings$Secure;->putStringForUser(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;I)Z

    .line 1167
    return-void
.end method

.method private readAccessibilityEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 6
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 1455
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "accessibility_enabled"

    iget v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-static {v3, v4, v2, v5}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v3

    if-ne v3, v1, :cond_0

    move v0, v1

    .line 1458
    .local v0, "accessibilityEnabled":Z
    :goto_0
    iget-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsAccessibilityEnabled:Z

    if-eq v0, v3, :cond_1

    .line 1459
    iput-boolean v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsAccessibilityEnabled:Z

    .line 1462
    :goto_1
    return v1

    .end local v0    # "accessibilityEnabled":Z
    :cond_0
    move v0, v2

    .line 1455
    goto :goto_0

    .restart local v0    # "accessibilityEnabled":Z
    :cond_1
    move v1, v2

    .line 1462
    goto :goto_1
.end method

.method private readComponentNamesFromSettingLocked(Ljava/lang/String;ILjava/util/Set;)V
    .locals 5
    .param p1, "settingName"    # Ljava/lang/String;
    .param p2, "userId"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "I",
            "Ljava/util/Set",
            "<",
            "Landroid/content/ComponentName;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 1130
    .local p3, "outComponentNames":Ljava/util/Set;, "Ljava/util/Set<Landroid/content/ComponentName;>;"
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    invoke-static {v4, p1, p2}, Landroid/provider/Settings$Secure;->getStringForUser(Landroid/content/ContentResolver;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    .line 1132
    .local v1, "settingValue":Ljava/lang/String;
    invoke-interface {p3}, Ljava/util/Set;->clear()V

    .line 1133
    if-eqz v1, :cond_1

    .line 1134
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mStringColonSplitter:Landroid/text/TextUtils$SimpleStringSplitter;

    .line 1135
    .local v2, "splitter":Landroid/text/TextUtils$SimpleStringSplitter;
    invoke-virtual {v2, v1}, Landroid/text/TextUtils$SimpleStringSplitter;->setString(Ljava/lang/String;)V

    .line 1136
    :cond_0
    :goto_0
    invoke-virtual {v2}, Landroid/text/TextUtils$SimpleStringSplitter;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1137
    invoke-virtual {v2}, Landroid/text/TextUtils$SimpleStringSplitter;->next()Ljava/lang/String;

    move-result-object v3

    .line 1138
    .local v3, "str":Ljava/lang/String;
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-lez v4, :cond_0

    .line 1141
    invoke-static {v3}, Landroid/content/ComponentName;->unflattenFromString(Ljava/lang/String;)Landroid/content/ComponentName;

    move-result-object v0

    .line 1142
    .local v0, "enabledService":Landroid/content/ComponentName;
    if-eqz v0, :cond_0

    .line 1143
    invoke-interface {p3, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 1147
    .end local v0    # "enabledService":Landroid/content/ComponentName;
    .end local v2    # "splitter":Landroid/text/TextUtils$SimpleStringSplitter;
    .end local v3    # "str":Ljava/lang/String;
    :cond_1
    return-void
.end method

.method private readConfigurationForUserStateLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 2
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1442
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readAccessibilityEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v0

    .line 1443
    .local v0, "somthingChanged":Z
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readInstalledAccessibilityServiceLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v1

    or-int/2addr v0, v1

    .line 1444
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readEnabledAccessibilityServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v1

    or-int/2addr v0, v1

    .line 1445
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readTouchExplorationGrantedAccessibilityServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v1

    or-int/2addr v0, v1

    .line 1446
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readTouchExplorationEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v1

    or-int/2addr v0, v1

    .line 1447
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readHighTextContrastEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v1

    or-int/2addr v0, v1

    .line 1448
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readEnhancedWebAccessibilityEnabledChangedLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v1

    or-int/2addr v0, v1

    .line 1449
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readDisplayMagnificationEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v1

    or-int/2addr v0, v1

    .line 1450
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->readDisplayColorAdjustmentSettingsLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    move-result v1

    or-int/2addr v0, v1

    .line 1451
    return v0
.end method

.method private readDisplayColorAdjustmentSettingsLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 3
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1500
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    iget v2, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-static {v1, v2}, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->hasAdjustments(Landroid/content/Context;I)Z

    move-result v0

    .line 1502
    .local v0, "displayAdjustmentsEnabled":Z
    iget-boolean v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mHasDisplayColorAdjustment:Z

    if-eq v0, v1, :cond_0

    .line 1503
    iput-boolean v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mHasDisplayColorAdjustment:Z

    .line 1504
    const/4 v0, 0x1

    .line 1508
    .end local v0    # "displayAdjustmentsEnabled":Z
    :cond_0
    return v0
.end method

.method private readDisplayMagnificationEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 6
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 1477
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "accessibility_display_magnification_enabled"

    iget v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-static {v3, v4, v2, v5}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v3

    if-ne v3, v1, :cond_0

    move v0, v1

    .line 1481
    .local v0, "displayMagnificationEnabled":Z
    :goto_0
    iget-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsDisplayMagnificationEnabled:Z

    if-eq v0, v3, :cond_1

    .line 1482
    iput-boolean v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsDisplayMagnificationEnabled:Z

    .line 1485
    :goto_1
    return v1

    .end local v0    # "displayMagnificationEnabled":Z
    :cond_0
    move v0, v2

    .line 1477
    goto :goto_0

    .restart local v0    # "displayMagnificationEnabled":Z
    :cond_1
    move v1, v2

    .line 1485
    goto :goto_1
.end method

.method private readEnabledAccessibilityServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 3
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 984
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 985
    const-string v0, "enabled_accessibility_services"

    iget v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    invoke-direct {p0, v0, v1, v2}, Lcom/android/server/accessibility/AccessibilityManagerService;->readComponentNamesFromSettingLocked(Ljava/lang/String;ILjava/util/Set;)V

    .line 987
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    iget-object v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mEnabledServices:Ljava/util/Set;

    invoke-interface {v0, v1}, Ljava/util/Set;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 988
    iget-object v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mEnabledServices:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 989
    iget-object v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mEnabledServices:Ljava/util/Set;

    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    invoke-interface {v0, v1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    .line 990
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 991
    const/4 v0, 0x1

    .line 994
    :goto_0
    return v0

    .line 993
    :cond_0
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 994
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private readEnhancedWebAccessibilityEnabledChangedLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 6
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 1489
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "accessibility_script_injection"

    iget v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-static {v3, v4, v2, v5}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v3

    if-ne v3, v1, :cond_0

    move v0, v1

    .line 1492
    .local v0, "enhancedWeAccessibilityEnabled":Z
    :goto_0
    iget-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsEnhancedWebAccessibilityEnabled:Z

    if-eq v0, v3, :cond_1

    .line 1493
    iput-boolean v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsEnhancedWebAccessibilityEnabled:Z

    .line 1496
    :goto_1
    return v1

    .end local v0    # "enhancedWeAccessibilityEnabled":Z
    :cond_0
    move v0, v2

    .line 1489
    goto :goto_0

    .restart local v0    # "enhancedWeAccessibilityEnabled":Z
    :cond_1
    move v1, v2

    .line 1496
    goto :goto_1
.end method

.method private readHighTextContrastEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 6
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 1512
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "high_text_contrast_enabled"

    iget v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-static {v3, v4, v2, v5}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v3

    if-ne v3, v1, :cond_0

    move v0, v1

    .line 1516
    .local v0, "highTextContrastEnabled":Z
    :goto_0
    iget-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsTextHighContrastEnabled:Z

    if-eq v0, v3, :cond_1

    .line 1517
    iput-boolean v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsTextHighContrastEnabled:Z

    .line 1520
    :goto_1
    return v1

    .end local v0    # "highTextContrastEnabled":Z
    :cond_0
    move v0, v2

    .line 1512
    goto :goto_0

    .restart local v0    # "highTextContrastEnabled":Z
    :cond_1
    move v1, v2

    .line 1520
    goto :goto_1
.end method

.method private readInstalledAccessibilityServiceLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 12
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 945
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempAccessibilityServiceInfoList:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->clear()V

    .line 947
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mPackageManager:Landroid/content/pm/PackageManager;

    new-instance v8, Landroid/content/Intent;

    const-string v9, "android.accessibilityservice.AccessibilityService"

    invoke-direct {v8, v9}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/16 v9, 0x84

    iget v10, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mCurrentUserId:I

    invoke-virtual {v7, v8, v9, v10}, Landroid/content/pm/PackageManager;->queryIntentServicesAsUser(Landroid/content/Intent;II)Ljava/util/List;

    move-result-object v3

    .line 952
    .local v3, "installedServices":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    const/4 v2, 0x0

    .local v2, "i":I
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v1

    .local v1, "count":I
    :goto_0
    if-ge v2, v1, :cond_1

    .line 953
    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/content/pm/ResolveInfo;

    .line 954
    .local v4, "resolveInfo":Landroid/content/pm/ResolveInfo;
    iget-object v5, v4, Landroid/content/pm/ResolveInfo;->serviceInfo:Landroid/content/pm/ServiceInfo;

    .line 955
    .local v5, "serviceInfo":Landroid/content/pm/ServiceInfo;
    const-string v7, "android.permission.BIND_ACCESSIBILITY_SERVICE"

    iget-object v8, v5, Landroid/content/pm/ServiceInfo;->permission:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_0

    .line 957
    const-string v7, "AccessibilityManagerService"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Skipping accessibilty service "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    new-instance v9, Landroid/content/ComponentName;

    iget-object v10, v5, Landroid/content/pm/ServiceInfo;->packageName:Ljava/lang/String;

    iget-object v11, v5, Landroid/content/pm/ServiceInfo;->name:Ljava/lang/String;

    invoke-direct {v9, v10, v11}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v9}, Landroid/content/ComponentName;->flattenToShortString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ": it does not require the permission "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "android.permission.BIND_ACCESSIBILITY_SERVICE"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 952
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 965
    :cond_0
    :try_start_0
    new-instance v0, Landroid/accessibilityservice/AccessibilityServiceInfo;

    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-direct {v0, v4, v7}, Landroid/accessibilityservice/AccessibilityServiceInfo;-><init>(Landroid/content/pm/ResolveInfo;Landroid/content/Context;)V

    .line 966
    .local v0, "accessibilityServiceInfo":Landroid/accessibilityservice/AccessibilityServiceInfo;
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempAccessibilityServiceInfoList:Ljava/util/List;

    invoke-interface {v7, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_1

    .line 967
    .end local v0    # "accessibilityServiceInfo":Landroid/accessibilityservice/AccessibilityServiceInfo;
    :catch_0
    move-exception v6

    .line 968
    .local v6, "xppe":Ljava/lang/Exception;
    :goto_2
    const-string v7, "AccessibilityManagerService"

    const-string v8, "Error while initializing AccessibilityServiceInfo"

    invoke-static {v7, v8, v6}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 972
    .end local v4    # "resolveInfo":Landroid/content/pm/ResolveInfo;
    .end local v5    # "serviceInfo":Landroid/content/pm/ServiceInfo;
    .end local v6    # "xppe":Ljava/lang/Exception;
    :cond_1
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempAccessibilityServiceInfoList:Ljava/util/List;

    iget-object v8, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInstalledServices:Ljava/util/List;

    invoke-interface {v7, v8}, Ljava/util/List;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_2

    .line 973
    iget-object v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInstalledServices:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->clear()V

    .line 974
    iget-object v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInstalledServices:Ljava/util/List;

    iget-object v8, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempAccessibilityServiceInfoList:Ljava/util/List;

    invoke-interface {v7, v8}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 975
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempAccessibilityServiceInfoList:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->clear()V

    .line 976
    const/4 v7, 0x1

    .line 980
    :goto_3
    return v7

    .line 979
    :cond_2
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempAccessibilityServiceInfoList:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->clear()V

    .line 980
    const/4 v7, 0x0

    goto :goto_3

    .line 967
    .restart local v4    # "resolveInfo":Landroid/content/pm/ResolveInfo;
    .restart local v5    # "serviceInfo":Landroid/content/pm/ServiceInfo;
    :catch_1
    move-exception v6

    goto :goto_2
.end method

.method private readTouchExplorationEnabledSettingLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 6
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 1466
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "touch_exploration_enabled"

    iget v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-static {v3, v4, v2, v5}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v3

    if-ne v3, v1, :cond_0

    move v0, v1

    .line 1469
    .local v0, "touchExplorationEnabled":Z
    :goto_0
    iget-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsTouchExplorationEnabled:Z

    if-eq v0, v3, :cond_1

    .line 1470
    iput-boolean v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsTouchExplorationEnabled:Z

    .line 1473
    :goto_1
    return v1

    .end local v0    # "touchExplorationEnabled":Z
    :cond_0
    move v0, v2

    .line 1466
    goto :goto_0

    .restart local v0    # "touchExplorationEnabled":Z
    :cond_1
    move v1, v2

    .line 1473
    goto :goto_1
.end method

.method private readTouchExplorationGrantedAccessibilityServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z
    .locals 3
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 999
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 1000
    const-string v0, "touch_exploration_granted_accessibility_services"

    iget v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    invoke-direct {p0, v0, v1, v2}, Lcom/android/server/accessibility/AccessibilityManagerService;->readComponentNamesFromSettingLocked(Ljava/lang/String;ILjava/util/Set;)V

    .line 1003
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    iget-object v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mTouchExplorationGrantedServices:Ljava/util/Set;

    invoke-interface {v0, v1}, Ljava/util/Set;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1004
    iget-object v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mTouchExplorationGrantedServices:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 1005
    iget-object v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mTouchExplorationGrantedServices:Ljava/util/Set;

    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    invoke-interface {v0, v1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    .line 1006
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 1007
    const/4 v0, 0x1

    .line 1010
    :goto_0
    return v0

    .line 1009
    :cond_0
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mTempComponentNameSet:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 1010
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private recyclePendingEventLocked(Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;)V
    .locals 1
    .param p1, "pendingEvent"    # Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;

    .prologue
    .line 1836
    invoke-virtual {p1}, Lcom/android/server/accessibility/AccessibilityManagerService$PendingEvent;->clear()V

    .line 1837
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mPendingEventPool:Landroid/util/Pools$Pool;

    invoke-interface {v0, p1}, Landroid/util/Pools$Pool;->release(Ljava/lang/Object;)Z

    .line 1838
    return-void
.end method

.method private registerBroadcastReceivers()V
    .locals 7

    .prologue
    const/4 v4, 0x0

    .line 250
    new-instance v6, Lcom/android/server/accessibility/AccessibilityManagerService$1;

    invoke-direct {v6, p0}, Lcom/android/server/accessibility/AccessibilityManagerService$1;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;)V

    .line 347
    .local v6, "monitor":Lcom/android/internal/content/PackageMonitor;
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    sget-object v1, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    const/4 v2, 0x1

    invoke-virtual {v6, v0, v4, v1, v2}, Lcom/android/internal/content/PackageMonitor;->register(Landroid/content/Context;Landroid/os/Looper;Landroid/os/UserHandle;Z)V

    .line 350
    new-instance v3, Landroid/content/IntentFilter;

    invoke-direct {v3}, Landroid/content/IntentFilter;-><init>()V

    .line 351
    .local v3, "intentFilter":Landroid/content/IntentFilter;
    const-string v0, "android.intent.action.USER_SWITCHED"

    invoke-virtual {v3, v0}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 352
    const-string v0, "android.intent.action.USER_REMOVED"

    invoke-virtual {v3, v0}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 353
    const-string v0, "android.intent.action.USER_PRESENT"

    invoke-virtual {v3, v0}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 355
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    new-instance v1, Lcom/android/server/accessibility/AccessibilityManagerService$2;

    invoke-direct {v1, p0}, Lcom/android/server/accessibility/AccessibilityManagerService$2;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;)V

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    move-object v5, v4

    invoke-virtual/range {v0 .. v5}, Landroid/content/Context;->registerReceiverAsUser(Landroid/content/BroadcastReceiver;Landroid/os/UserHandle;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;

    .line 374
    return-void
.end method

.method private removeAccessibilityInteractionConnectionInternalLocked(Landroid/os/IBinder;Landroid/util/SparseArray;Landroid/util/SparseArray;)I
    .locals 5
    .param p1, "windowToken"    # Landroid/os/IBinder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/os/IBinder;",
            "Landroid/util/SparseArray",
            "<",
            "Landroid/os/IBinder;",
            ">;",
            "Landroid/util/SparseArray",
            "<",
            "Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;",
            ">;)I"
        }
    .end annotation

    .prologue
    .line 600
    .local p2, "windowTokens":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Landroid/os/IBinder;>;"
    .local p3, "interactionConnections":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;>;"
    invoke-virtual {p2}, Landroid/util/SparseArray;->size()I

    move-result v0

    .line 601
    .local v0, "count":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_1

    .line 602
    invoke-virtual {p2, v1}, Landroid/util/SparseArray;->valueAt(I)Ljava/lang/Object;

    move-result-object v4

    if-ne v4, p1, :cond_0

    .line 603
    invoke-virtual {p2, v1}, Landroid/util/SparseArray;->keyAt(I)I

    move-result v2

    .line 604
    .local v2, "windowId":I
    invoke-virtual {p2, v1}, Landroid/util/SparseArray;->removeAt(I)V

    .line 605
    invoke-virtual {p3, v2}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;

    .line 606
    .local v3, "wrapper":Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;
    invoke-virtual {v3}, Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;->unlinkToDeath()V

    .line 607
    invoke-virtual {p3, v2}, Landroid/util/SparseArray;->remove(I)V

    .line 611
    .end local v2    # "windowId":I
    .end local v3    # "wrapper":Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;
    :goto_1
    return v2

    .line 601
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 611
    :cond_1
    const/4 v2, -0x1

    goto :goto_1
.end method

.method private removeAccessibilityInteractionConnectionLocked(II)V
    .locals 2
    .param p1, "windowId"    # I
    .param p2, "userId"    # I

    .prologue
    .line 931
    const/4 v1, -0x1

    if-ne p2, v1, :cond_0

    .line 932
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->remove(I)V

    .line 933
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalInteractionConnections:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->remove(I)V

    .line 942
    :goto_0
    return-void

    .line 935
    :cond_0
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v0

    .line 936
    .local v0, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    iget-object v1, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->remove(I)V

    .line 937
    iget-object v1, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInteractionConnections:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->remove(I)V

    goto :goto_0
.end method

.method private removeServiceLocked(Lcom/android/server/accessibility/AccessibilityManagerService$Service;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 2
    .param p1, "service"    # Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .param p2, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1058
    iget-object v0, p2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 1059
    iget-object v0, p2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mComponentNameToServiceMap:Ljava/util/Map;

    iget-object v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mComponentName:Landroid/content/ComponentName;

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 1060
    invoke-virtual {p1}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->unlinkToOwnDeathLocked()V

    .line 1061
    return-void
.end method

.method private removeUser(I)V
    .locals 2
    .param p1, "userId"    # I

    .prologue
    .line 857
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v1

    .line 858
    :try_start_0
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mUserStates:Landroid/util/SparseArray;

    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->remove(I)V

    .line 859
    monitor-exit v1

    .line 860
    return-void

    .line 859
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private scheduleUpdateClientsIfNeededLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 4
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1217
    invoke-virtual {p1}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->getClientState()I

    move-result v0

    .line 1218
    .local v0, "clientState":I
    iget v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mLastSentClientState:I

    if-eq v1, v0, :cond_1

    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalClients:Landroid/os/RemoteCallbackList;

    invoke-virtual {v1}, Landroid/os/RemoteCallbackList;->getRegisteredCallbackCount()I

    move-result v1

    if-gtz v1, :cond_0

    iget-object v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mClients:Landroid/os/RemoteCallbackList;

    invoke-virtual {v1}, Landroid/os/RemoteCallbackList;->getRegisteredCallbackCount()I

    move-result v1

    if-lez v1, :cond_1

    .line 1221
    :cond_0
    iput v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mLastSentClientState:I

    .line 1222
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mMainHandler:Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;

    const/4 v2, 0x2

    iget v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-virtual {v1, v2, v0, v3}, Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;->obtainMessage(III)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    .line 1225
    :cond_1
    return-void
.end method

.method private scheduleUpdateInputFilter(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 2
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1228
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mMainHandler:Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;

    const/4 v1, 0x6

    invoke-virtual {v0, v1, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    .line 1229
    return-void
.end method

.method private showEnableTouchExplorationDialog(Lcom/android/server/accessibility/AccessibilityManagerService$Service;)V
    .locals 8
    .param p1, "service"    # Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .prologue
    .line 1272
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v3

    .line 1273
    :try_start_0
    iget-object v2, p1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mResolveInfo:Landroid/content/pm/ResolveInfo;

    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    invoke-virtual {v2, v4}, Landroid/content/pm/ResolveInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1276
    .local v0, "label":Ljava/lang/String;
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v1

    .line 1277
    .local v1, "state":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    iget-boolean v2, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsTouchExplorationEnabled:Z

    if-eqz v2, :cond_0

    .line 1278
    monitor-exit v3

    .line 1320
    :goto_0
    return-void

    .line 1280
    :cond_0
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mEnableTouchExplorationDialog:Landroid/app/AlertDialog;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mEnableTouchExplorationDialog:Landroid/app/AlertDialog;

    invoke-virtual {v2}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1282
    monitor-exit v3

    goto :goto_0

    .line 1319
    .end local v0    # "label":Ljava/lang/String;
    .end local v1    # "state":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .line 1284
    .restart local v0    # "label":Ljava/lang/String;
    .restart local v1    # "state":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :cond_1
    :try_start_1
    new-instance v2, Landroid/app/AlertDialog$Builder;

    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-direct {v2, v4}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v4, 0x1010355

    invoke-virtual {v2, v4}, Landroid/app/AlertDialog$Builder;->setIconAttribute(I)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    const v4, 0x104000a

    new-instance v5, Lcom/android/server/accessibility/AccessibilityManagerService$4;

    invoke-direct {v5, p0, v1, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$4;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;Lcom/android/server/accessibility/AccessibilityManagerService$UserState;Lcom/android/server/accessibility/AccessibilityManagerService$Service;)V

    invoke-virtual {v2, v4, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    const/high16 v4, 0x1040000

    new-instance v5, Lcom/android/server/accessibility/AccessibilityManagerService$3;

    invoke-direct {v5, p0}, Lcom/android/server/accessibility/AccessibilityManagerService$3;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;)V

    invoke-virtual {v2, v4, v5}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    const v4, 0x1040442

    invoke-virtual {v2, v4}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    const v5, 0x1040443

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object v0, v6, v7

    invoke-virtual {v4, v5, v6}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v2

    iput-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mEnableTouchExplorationDialog:Landroid/app/AlertDialog;

    .line 1313
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mEnableTouchExplorationDialog:Landroid/app/AlertDialog;

    invoke-virtual {v2}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    const/16 v4, 0x7d3

    invoke-virtual {v2, v4}, Landroid/view/Window;->setType(I)V

    .line 1315
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mEnableTouchExplorationDialog:Landroid/app/AlertDialog;

    invoke-virtual {v2}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    iget v4, v2, Landroid/view/WindowManager$LayoutParams;->privateFlags:I

    or-int/lit8 v4, v4, 0x10

    iput v4, v2, Landroid/view/WindowManager$LayoutParams;->privateFlags:I

    .line 1317
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mEnableTouchExplorationDialog:Landroid/app/AlertDialog;

    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Landroid/app/AlertDialog;->setCanceledOnTouchOutside(Z)V

    .line 1318
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mEnableTouchExplorationDialog:Landroid/app/AlertDialog;

    invoke-virtual {v2}, Landroid/app/AlertDialog;->show()V

    .line 1319
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0
.end method

.method private switchUser(I)V
    .locals 10
    .param p1, "userId"    # I

    .prologue
    const/4 v0, 0x1

    const/4 v4, 0x0

    .line 814
    iget-object v5, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v5

    .line 815
    :try_start_0
    iget v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mCurrentUserId:I

    if-ne v6, p1, :cond_0

    iget-boolean v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInitialized:Z

    if-eqz v6, :cond_0

    .line 816
    monitor-exit v5

    .line 854
    :goto_0
    return-void

    .line 820
    :cond_0
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v1

    .line 821
    .local v1, "oldUserState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    invoke-virtual {v1}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->onSwitchToAnotherUser()V

    .line 824
    iget-object v6, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mClients:Landroid/os/RemoteCallbackList;

    invoke-virtual {v6}, Landroid/os/RemoteCallbackList;->getRegisteredCallbackCount()I

    move-result v6

    if-lez v6, :cond_1

    .line 825
    iget-object v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mMainHandler:Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;

    const/4 v7, 0x3

    iget v8, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    const/4 v9, 0x0

    invoke-virtual {v6, v7, v8, v9}, Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;->obtainMessage(III)Landroid/os/Message;

    move-result-object v6

    invoke-virtual {v6}, Landroid/os/Message;->sendToTarget()V

    .line 830
    :cond_1
    iget-object v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    const-string v7, "user"

    invoke-virtual {v6, v7}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/os/UserManager;

    .line 831
    .local v2, "userManager":Landroid/os/UserManager;
    invoke-virtual {v2}, Landroid/os/UserManager;->getUsers()Ljava/util/List;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v6

    if-le v6, v0, :cond_4

    .line 834
    .local v0, "announceNewUser":Z
    :goto_1
    iput p1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mCurrentUserId:I

    .line 836
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v3

    .line 837
    .local v3, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v3}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v4

    if-eqz v4, :cond_2

    .line 839
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v3}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v4

    invoke-virtual {v4}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->binderDied()V

    .line 842
    :cond_2
    invoke-direct {p0, v3}, Lcom/android/server/accessibility/AccessibilityManagerService;->readConfigurationForUserStateLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Z

    .line 846
    invoke-direct {p0, v3}, Lcom/android/server/accessibility/AccessibilityManagerService;->onUserStateChangedLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 848
    if-eqz v0, :cond_3

    .line 850
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mMainHandler:Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;

    const/4 v6, 0x5

    const-wide/16 v8, 0xbb8

    invoke-virtual {v4, v6, v8, v9}, Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;->sendEmptyMessageDelayed(IJ)Z

    .line 853
    :cond_3
    monitor-exit v5

    goto :goto_0

    .end local v0    # "announceNewUser":Z
    .end local v1    # "oldUserState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    .end local v2    # "userManager":Landroid/os/UserManager;
    .end local v3    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :catchall_0
    move-exception v4

    monitor-exit v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v4

    .restart local v1    # "oldUserState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    .restart local v2    # "userManager":Landroid/os/UserManager;
    :cond_4
    move v0, v4

    .line 831
    goto :goto_1
.end method

.method private unbindAllServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 5
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1110
    iget-object v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 1111
    .local v3, "services":Ljava/util/List;, "Ljava/util/List<Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    const/4 v1, 0x0

    .local v1, "i":I
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v0

    .local v0, "count":I
    :goto_0
    if-ge v1, v0, :cond_1

    .line 1112
    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 1113
    .local v2, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-virtual {v2}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->unbindLocked()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1114
    add-int/lit8 v1, v1, -0x1

    .line 1115
    add-int/lit8 v0, v0, -0x1

    .line 1111
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1118
    .end local v2    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_1
    return-void
.end method

.method private updateAccessibilityFocusBehaviorLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 5
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1347
    iget-object v2, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 1348
    .local v2, "boundServices":Ljava/util/List;, "Ljava/util/List<Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v1

    .line 1349
    .local v1, "boundServiceCount":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    if-ge v3, v1, :cond_1

    .line 1350
    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 1351
    .local v0, "boundService":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-virtual {v0}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->canRetrieveInteractiveWindowsLocked()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1352
    const/4 v4, 0x0

    iput-boolean v4, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mAccessibilityFocusOnlyInActiveWindow:Z

    .line 1357
    .end local v0    # "boundService":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :goto_1
    return-void

    .line 1349
    .restart local v0    # "boundService":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 1356
    .end local v0    # "boundService":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_1
    const/4 v4, 0x1

    iput-boolean v4, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mAccessibilityFocusOnlyInActiveWindow:Z

    goto :goto_1
.end method

.method private updateDisplayColorAdjustmentSettingsLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 2
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1606
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    iget v1, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-static {v0, v1}, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->applyAdjustments(Landroid/content/Context;I)V

    .line 1607
    return-void
.end method

.method private updateEnhancedWebAccessibilityLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 8
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1577
    const/4 v0, 0x0

    .line 1578
    .local v0, "enabled":Z
    iget-object v4, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v4}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v3

    .line 1579
    .local v3, "serviceCount":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v3, :cond_0

    .line 1580
    iget-object v4, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v4, v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 1581
    .local v2, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-direct {p0, v2}, Lcom/android/server/accessibility/AccessibilityManagerService;->canRequestAndRequestsEnhancedWebAccessibilityLocked(Lcom/android/server/accessibility/AccessibilityManagerService$Service;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 1582
    const/4 v0, 0x1

    .line 1586
    .end local v2    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_0
    iget-boolean v4, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsEnhancedWebAccessibilityEnabled:Z

    if-eq v0, v4, :cond_1

    .line 1587
    iput-boolean v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsEnhancedWebAccessibilityEnabled:Z

    .line 1588
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    const-string v6, "accessibility_script_injection"

    if-eqz v0, :cond_3

    const/4 v4, 0x1

    :goto_1
    iget v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-static {v5, v6, v4, v7}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    .line 1592
    :cond_1
    return-void

    .line 1579
    .restart local v2    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1588
    .end local v2    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_3
    const/4 v4, 0x0

    goto :goto_1
.end method

.method private updateFilterKeyEventsLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 4
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1419
    iget-object v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v2

    .line 1420
    .local v2, "serviceCount":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_1

    .line 1421
    iget-object v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v3, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 1422
    .local v1, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    iget-boolean v3, v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mRequestFilterKeyEvents:Z

    if-eqz v3, :cond_0

    iget-object v3, v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mAccessibilityServiceInfo:Landroid/accessibilityservice/AccessibilityServiceInfo;

    invoke-virtual {v3}, Landroid/accessibilityservice/AccessibilityServiceInfo;->getCapabilities()I

    move-result v3

    and-int/lit8 v3, v3, 0x8

    if-eqz v3, :cond_0

    .line 1426
    const/4 v3, 0x1

    iput-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsFilterKeyEventsEnabled:Z

    .line 1431
    .end local v1    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :goto_1
    return-void

    .line 1420
    .restart local v1    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1430
    .end local v1    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_1
    const/4 v3, 0x0

    iput-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsFilterKeyEventsEnabled:Z

    goto :goto_1
.end method

.method private updateInputFilter(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 6
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1232
    const/4 v2, 0x0

    .line 1233
    .local v2, "setInputFilter":Z
    const/4 v1, 0x0

    .line 1234
    .local v1, "inputFilter":Lcom/android/server/accessibility/AccessibilityInputFilter;
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v4

    .line 1235
    const/4 v0, 0x0

    .line 1236
    .local v0, "flags":I
    :try_start_0
    iget-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsDisplayMagnificationEnabled:Z

    if-eqz v3, :cond_0

    .line 1237
    or-int/lit8 v0, v0, 0x1

    .line 1240
    :cond_0
    iget-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsAccessibilityEnabled:Z

    if-eqz v3, :cond_1

    iget-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsTouchExplorationEnabled:Z

    if-eqz v3, :cond_1

    .line 1241
    or-int/lit8 v0, v0, 0x2

    .line 1243
    :cond_1
    iget-boolean v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsFilterKeyEventsEnabled:Z

    if-eqz v3, :cond_2

    .line 1244
    or-int/lit8 v0, v0, 0x4

    .line 1246
    :cond_2
    if-eqz v0, :cond_7

    .line 1247
    iget-boolean v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mHasInputFilter:Z

    if-nez v3, :cond_4

    .line 1248
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mHasInputFilter:Z

    .line 1249
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInputFilter:Lcom/android/server/accessibility/AccessibilityInputFilter;

    if-nez v3, :cond_3

    .line 1250
    new-instance v3, Lcom/android/server/accessibility/AccessibilityInputFilter;

    iget-object v5, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-direct {v3, v5, p0}, Lcom/android/server/accessibility/AccessibilityInputFilter;-><init>(Landroid/content/Context;Lcom/android/server/accessibility/AccessibilityManagerService;)V

    iput-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInputFilter:Lcom/android/server/accessibility/AccessibilityInputFilter;

    .line 1253
    :cond_3
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInputFilter:Lcom/android/server/accessibility/AccessibilityInputFilter;

    .line 1254
    const/4 v2, 0x1

    .line 1256
    :cond_4
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInputFilter:Lcom/android/server/accessibility/AccessibilityInputFilter;

    invoke-virtual {v3, v0}, Lcom/android/server/accessibility/AccessibilityInputFilter;->setEnabledFeatures(I)V

    .line 1265
    :cond_5
    :goto_0
    monitor-exit v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1266
    if-eqz v2, :cond_6

    .line 1267
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowManagerService:Landroid/view/WindowManagerInternal;

    invoke-virtual {v3, v1}, Landroid/view/WindowManagerInternal;->setInputFilter(Landroid/view/IInputFilter;)V

    .line 1269
    :cond_6
    return-void

    .line 1258
    :cond_7
    :try_start_1
    iget-boolean v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mHasInputFilter:Z

    if-eqz v3, :cond_5

    .line 1259
    const/4 v3, 0x0

    iput-boolean v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mHasInputFilter:Z

    .line 1260
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInputFilter:Lcom/android/server/accessibility/AccessibilityInputFilter;

    invoke-virtual {v3}, Lcom/android/server/accessibility/AccessibilityInputFilter;->disableFeatures()V

    .line 1261
    const/4 v1, 0x0

    .line 1262
    const/4 v2, 0x1

    goto :goto_0

    .line 1265
    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v3
.end method

.method private updateLegacyCapabilitiesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 7
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1400
    iget-object v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInstalledServices:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v2

    .line 1401
    .local v2, "installedServiceCount":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v2, :cond_1

    .line 1402
    iget-object v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInstalledServices:Ljava/util/List;

    invoke-interface {v5, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/accessibilityservice/AccessibilityServiceInfo;

    .line 1403
    .local v4, "serviceInfo":Landroid/accessibilityservice/AccessibilityServiceInfo;
    invoke-virtual {v4}, Landroid/accessibilityservice/AccessibilityServiceInfo;->getResolveInfo()Landroid/content/pm/ResolveInfo;

    move-result-object v3

    .line 1404
    .local v3, "resolveInfo":Landroid/content/pm/ResolveInfo;
    invoke-virtual {v4}, Landroid/accessibilityservice/AccessibilityServiceInfo;->getCapabilities()I

    move-result v5

    and-int/lit8 v5, v5, 0x2

    if-nez v5, :cond_0

    iget-object v5, v3, Landroid/content/pm/ResolveInfo;->serviceInfo:Landroid/content/pm/ServiceInfo;

    iget-object v5, v5, Landroid/content/pm/ServiceInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget v5, v5, Landroid/content/pm/ApplicationInfo;->targetSdkVersion:I

    const/16 v6, 0x11

    if-gt v5, v6, :cond_0

    .line 1408
    new-instance v0, Landroid/content/ComponentName;

    iget-object v5, v3, Landroid/content/pm/ResolveInfo;->serviceInfo:Landroid/content/pm/ServiceInfo;

    iget-object v5, v5, Landroid/content/pm/ServiceInfo;->packageName:Ljava/lang/String;

    iget-object v6, v3, Landroid/content/pm/ResolveInfo;->serviceInfo:Landroid/content/pm/ServiceInfo;

    iget-object v6, v6, Landroid/content/pm/ServiceInfo;->name:Ljava/lang/String;

    invoke-direct {v0, v5, v6}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 1410
    .local v0, "componentName":Landroid/content/ComponentName;
    iget-object v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mTouchExplorationGrantedServices:Ljava/util/Set;

    invoke-interface {v5, v0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 1411
    invoke-virtual {v4}, Landroid/accessibilityservice/AccessibilityServiceInfo;->getCapabilities()I

    move-result v5

    or-int/lit8 v5, v5, 0x2

    invoke-virtual {v4, v5}, Landroid/accessibilityservice/AccessibilityServiceInfo;->setCapabilities(I)V

    .line 1401
    .end local v0    # "componentName":Landroid/content/ComponentName;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1416
    .end local v3    # "resolveInfo":Landroid/content/pm/ResolveInfo;
    .end local v4    # "serviceInfo":Landroid/accessibilityservice/AccessibilityServiceInfo;
    :cond_1
    return-void
.end method

.method private updateServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 1
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1434
    iget-boolean v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsAccessibilityEnabled:Z

    if-eqz v0, :cond_0

    .line 1435
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->manageServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 1439
    :goto_0
    return-void

    .line 1437
    :cond_0
    invoke-direct {p0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService;->unbindAllServicesLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    goto :goto_0
.end method

.method private updateTouchExplorationLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 8
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    .line 1524
    const/4 v0, 0x0

    .line 1525
    .local v0, "enabled":Z
    iget-object v4, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v4}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v3

    .line 1526
    .local v3, "serviceCount":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v3, :cond_0

    .line 1527
    iget-object v4, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v4, v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 1528
    .local v2, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-direct {p0, v2}, Lcom/android/server/accessibility/AccessibilityManagerService;->canRequestAndRequestsTouchExplorationLocked(Lcom/android/server/accessibility/AccessibilityManagerService$Service;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 1529
    const/4 v0, 0x1

    .line 1533
    .end local v2    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_0
    iget-boolean v4, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsTouchExplorationEnabled:Z

    if-eq v0, v4, :cond_1

    .line 1534
    iput-boolean v0, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsTouchExplorationEnabled:Z

    .line 1535
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    const-string v6, "touch_exploration_enabled"

    if-eqz v0, :cond_3

    const/4 v4, 0x1

    :goto_1
    iget v7, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-static {v5, v6, v4, v7}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    .line 1539
    :cond_1
    return-void

    .line 1526
    .restart local v2    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1535
    .end local v2    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_3
    const/4 v4, 0x0

    goto :goto_1
.end method

.method private updateWindowsForAccessibilityCallbackLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V
    .locals 7
    .param p1, "userState"    # Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .prologue
    const/4 v6, 0x0

    .line 1360
    iget-boolean v5, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsAccessibilityEnabled:Z

    if-eqz v5, :cond_3

    .line 1366
    const/4 v1, 0x0

    .line 1368
    .local v1, "boundServiceCanRetrieveInteractiveWindows":Z
    iget-object v3, p1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 1369
    .local v3, "boundServices":Ljava/util/List;, "Ljava/util/List<Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v2

    .line 1370
    .local v2, "boundServiceCount":I
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    if-ge v4, v2, :cond_0

    .line 1371
    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 1372
    .local v0, "boundService":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-virtual {v0}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->canRetrieveInteractiveWindowsLocked()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 1373
    const/4 v1, 0x1

    .line 1378
    .end local v0    # "boundService":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :cond_0
    if-eqz v1, :cond_3

    .line 1379
    iget-object v5, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowsForAccessibilityCallback:Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;

    if-nez v5, :cond_1

    .line 1380
    new-instance v5, Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;

    invoke-direct {v5, p0}, Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;)V

    iput-object v5, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowsForAccessibilityCallback:Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;

    .line 1381
    iget-object v5, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowManagerService:Landroid/view/WindowManagerInternal;

    iget-object v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowsForAccessibilityCallback:Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;

    invoke-virtual {v5, v6}, Landroid/view/WindowManagerInternal;->setWindowsForAccessibilityCallback(Landroid/view/WindowManagerInternal$WindowsForAccessibilityCallback;)V

    .line 1394
    .end local v1    # "boundServiceCanRetrieveInteractiveWindows":Z
    .end local v2    # "boundServiceCount":I
    .end local v3    # "boundServices":Ljava/util/List;, "Ljava/util/List<Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    .end local v4    # "i":I
    :cond_1
    :goto_1
    return-void

    .line 1370
    .restart local v0    # "boundService":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .restart local v1    # "boundServiceCanRetrieveInteractiveWindows":Z
    .restart local v2    # "boundServiceCount":I
    .restart local v3    # "boundServices":Ljava/util/List;, "Ljava/util/List<Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    .restart local v4    # "i":I
    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 1388
    .end local v0    # "boundService":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .end local v1    # "boundServiceCanRetrieveInteractiveWindows":Z
    .end local v2    # "boundServiceCount":I
    .end local v3    # "boundServices":Ljava/util/List;, "Ljava/util/List<Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    .end local v4    # "i":I
    :cond_3
    iget-object v5, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowsForAccessibilityCallback:Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;

    if-eqz v5, :cond_1

    .line 1389
    iput-object v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowsForAccessibilityCallback:Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;

    .line 1390
    iget-object v5, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowManagerService:Landroid/view/WindowManagerInternal;

    invoke-virtual {v5, v6}, Landroid/view/WindowManagerInternal;->setWindowsForAccessibilityCallback(Landroid/view/WindowManagerInternal$WindowsForAccessibilityCallback;)V

    .line 1392
    iget-object v5, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v5}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->clearWindowsLocked()V

    goto :goto_1
.end method


# virtual methods
.method accessibilityFocusOnlyInActiveWindow()Z
    .locals 2

    .prologue
    .line 792
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v1

    .line 793
    :try_start_0
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowsForAccessibilityCallback:Lcom/android/server/accessibility/AccessibilityManagerService$WindowsForAccessibilityCallback;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    monitor-exit v1

    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 794
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public addAccessibilityInteractionConnection(Landroid/view/IWindow;Landroid/view/accessibility/IAccessibilityInteractionConnection;I)I
    .locals 7
    .param p1, "windowToken"    # Landroid/view/IWindow;
    .param p2, "connection"    # Landroid/view/accessibility/IAccessibilityInteractionConnection;
    .param p3, "userId"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    .line 524
    iget-object v5, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v5

    .line 528
    :try_start_0
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v4, p3}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->resolveCallingUserIdEnforcingPermissionsLocked(I)I

    move-result v0

    .line 530
    .local v0, "resolvedUserId":I
    sget v2, Lcom/android/server/accessibility/AccessibilityManagerService;->sNextWindowId:I

    add-int/lit8 v4, v2, 0x1

    sput v4, Lcom/android/server/accessibility/AccessibilityManagerService;->sNextWindowId:I

    .line 534
    .local v2, "windowId":I
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v4, p3}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->isCallerInteractingAcrossUsers(I)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 535
    new-instance v3, Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;

    const/4 v4, -0x1

    invoke-direct {v3, p0, v2, p2, v4}, Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;ILandroid/view/accessibility/IAccessibilityInteractionConnection;I)V

    .line 537
    .local v3, "wrapper":Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;
    invoke-virtual {v3}, Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;->linkToDeath()V

    .line 538
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalInteractionConnections:Landroid/util/SparseArray;

    invoke-virtual {v4, v2, v3}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 539
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalWindowTokens:Landroid/util/SparseArray;

    invoke-interface {p1}, Landroid/view/IWindow;->asBinder()Landroid/os/IBinder;

    move-result-object v6

    invoke-virtual {v4, v2, v6}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 557
    :goto_0
    monitor-exit v5

    return v2

    .line 545
    .end local v3    # "wrapper":Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;
    :cond_0
    new-instance v3, Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;

    invoke-direct {v3, p0, v2, p2, v0}, Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;-><init>(Lcom/android/server/accessibility/AccessibilityManagerService;ILandroid/view/accessibility/IAccessibilityInteractionConnection;I)V

    .line 547
    .restart local v3    # "wrapper":Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;
    invoke-virtual {v3}, Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;->linkToDeath()V

    .line 548
    invoke-direct {p0, v0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getUserStateLocked(I)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v1

    .line 549
    .local v1, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    iget-object v4, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInteractionConnections:Landroid/util/SparseArray;

    invoke-virtual {v4, v2, v3}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 550
    iget-object v4, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mWindowTokens:Landroid/util/SparseArray;

    invoke-interface {p1}, Landroid/view/IWindow;->asBinder()Landroid/os/IBinder;

    move-result-object v6

    invoke-virtual {v4, v2, v6}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    goto :goto_0

    .line 558
    .end local v0    # "resolvedUserId":I
    .end local v1    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    .end local v2    # "windowId":I
    .end local v3    # "wrapper":Lcom/android/server/accessibility/AccessibilityManagerService$AccessibilityConnectionWrapper;
    :catchall_0
    move-exception v4

    monitor-exit v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v4
.end method

.method public addClient(Landroid/view/accessibility/IAccessibilityManagerClient;I)I
    .locals 4
    .param p1, "client"    # Landroid/view/accessibility/IAccessibilityManagerClient;
    .param p2, "userId"    # I

    .prologue
    .line 378
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v3

    .line 382
    :try_start_0
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v2, p2}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->resolveCallingUserIdEnforcingPermissionsLocked(I)I

    move-result v0

    .line 387
    .local v0, "resolvedUserId":I
    invoke-direct {p0, v0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getUserStateLocked(I)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v1

    .line 388
    .local v1, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v2, p2}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->isCallerInteractingAcrossUsers(I)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 389
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalClients:Landroid/os/RemoteCallbackList;

    invoke-virtual {v2, p1}, Landroid/os/RemoteCallbackList;->register(Landroid/os/IInterface;)Z

    .line 393
    invoke-virtual {v1}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->getClientState()I

    move-result v2

    monitor-exit v3

    .line 403
    :goto_0
    return v2

    .line 395
    :cond_0
    iget-object v2, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mClients:Landroid/os/RemoteCallbackList;

    invoke-virtual {v2, p1}, Landroid/os/RemoteCallbackList;->register(Landroid/os/IInterface;)Z

    .line 403
    iget v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mCurrentUserId:I

    if-ne v0, v2, :cond_1

    invoke-virtual {v1}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->getClientState()I

    move-result v2

    :goto_1
    monitor-exit v3

    goto :goto_0

    .line 405
    .end local v0    # "resolvedUserId":I
    .end local v1    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .line 403
    .restart local v0    # "resolvedUserId":I
    .restart local v1    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :cond_1
    const/4 v2, 0x0

    goto :goto_1
.end method

.method public dump(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V
    .locals 12
    .param p1, "fd"    # Ljava/io/FileDescriptor;
    .param p2, "pw"    # Ljava/io/PrintWriter;
    .param p3, "args"    # [Ljava/lang/String;

    .prologue
    .line 1627
    iget-object v8, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    const-string v9, "android.permission.DUMP"

    const-string v10, "dump"

    # invokes: Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->enforceCallingPermission(Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v8, v9, v10}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->access$1100(Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;Ljava/lang/String;Ljava/lang/String;)V

    .line 1628
    iget-object v9, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v9

    .line 1629
    :try_start_0
    const-string v8, "ACCESSIBILITY MANAGER (dumpsys accessibility)"

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1630
    invoke-virtual {p2}, Ljava/io/PrintWriter;->println()V

    .line 1631
    iget-object v8, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mUserStates:Landroid/util/SparseArray;

    invoke-virtual {v8}, Landroid/util/SparseArray;->size()I

    move-result v4

    .line 1632
    .local v4, "userCount":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v4, :cond_4

    .line 1633
    iget-object v8, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mUserStates:Landroid/util/SparseArray;

    invoke-virtual {v8, v0}, Landroid/util/SparseArray;->valueAt(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .line 1634
    .local v5, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "User state[attributes:{id="

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget v10, v5, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1635
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, ", currentUser="

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget v8, v5, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUserId:I

    iget v11, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mCurrentUserId:I

    if-ne v8, v11, :cond_2

    const/4 v8, 0x1

    :goto_1
    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1636
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, ", accessibilityEnabled="

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-boolean v10, v5, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsAccessibilityEnabled:Z

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1637
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, ", touchExplorationEnabled="

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-boolean v10, v5, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsTouchExplorationEnabled:Z

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1638
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, ", displayMagnificationEnabled="

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-boolean v10, v5, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsDisplayMagnificationEnabled:Z

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1640
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v5}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v8

    if-eqz v8, :cond_0

    .line 1641
    const-string v8, ", "

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1642
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v5}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v8

    invoke-virtual {v8, p1, p2, p3}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->dump(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V

    .line 1643
    invoke-virtual {p2}, Ljava/io/PrintWriter;->println()V

    .line 1645
    :cond_0
    const-string v8, "}"

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1646
    invoke-virtual {p2}, Ljava/io/PrintWriter;->println()V

    .line 1647
    const-string v8, "           services:{"

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1648
    iget-object v8, v5, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v8}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v3

    .line 1649
    .local v3, "serviceCount":I
    const/4 v1, 0x0

    .local v1, "j":I
    :goto_2
    if-ge v1, v3, :cond_3

    .line 1650
    if-lez v1, :cond_1

    .line 1651
    const-string v8, ", "

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1652
    invoke-virtual {p2}, Ljava/io/PrintWriter;->println()V

    .line 1653
    const-string v8, "                     "

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1655
    :cond_1
    iget-object v8, v5, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v8, v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 1656
    .local v2, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-virtual {v2, p1, p2, p3}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->dump(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V

    .line 1649
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 1635
    .end local v1    # "j":I
    .end local v2    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .end local v3    # "serviceCount":I
    :cond_2
    const/4 v8, 0x0

    goto/16 :goto_1

    .line 1658
    .restart local v1    # "j":I
    .restart local v3    # "serviceCount":I
    :cond_3
    const-string v8, "}]"

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1659
    invoke-virtual {p2}, Ljava/io/PrintWriter;->println()V

    .line 1632
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_0

    .line 1661
    .end local v1    # "j":I
    .end local v3    # "serviceCount":I
    .end local v5    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :cond_4
    iget-object v8, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    iget-object v8, v8, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->mWindows:Ljava/util/List;

    if-eqz v8, :cond_6

    .line 1662
    iget-object v8, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    iget-object v8, v8, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->mWindows:Ljava/util/List;

    invoke-interface {v8}, Ljava/util/List;->size()I

    move-result v7

    .line 1663
    .local v7, "windowCount":I
    const/4 v1, 0x0

    .restart local v1    # "j":I
    :goto_3
    if-ge v1, v7, :cond_6

    .line 1664
    if-lez v1, :cond_5

    .line 1665
    const/16 v8, 0x2c

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(C)Ljava/io/PrintWriter;

    .line 1666
    invoke-virtual {p2}, Ljava/io/PrintWriter;->println()V

    .line 1668
    :cond_5
    const-string v8, "Window["

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1669
    iget-object v8, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    iget-object v8, v8, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->mWindows:Ljava/util/List;

    invoke-interface {v8, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/view/accessibility/AccessibilityWindowInfo;

    .line 1670
    .local v6, "window":Landroid/view/accessibility/AccessibilityWindowInfo;
    invoke-virtual {v6}, Landroid/view/accessibility/AccessibilityWindowInfo;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(Ljava/lang/CharSequence;)Ljava/io/PrintWriter;

    .line 1671
    const/16 v8, 0x5d

    invoke-virtual {p2, v8}, Ljava/io/PrintWriter;->append(C)Ljava/io/PrintWriter;

    .line 1663
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 1674
    .end local v1    # "j":I
    .end local v6    # "window":Landroid/view/accessibility/AccessibilityWindowInfo;
    .end local v7    # "windowCount":I
    :cond_6
    monitor-exit v9

    .line 1675
    return-void

    .line 1674
    .end local v0    # "i":I
    .end local v4    # "userCount":I
    :catchall_0
    move-exception v8

    monitor-exit v9
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v8
.end method

.method getAccessibilityFocusClickPointInScreen(Landroid/graphics/Point;)Z
    .locals 1
    .param p1, "outPoint"    # Landroid/graphics/Point;

    .prologue
    .line 764
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getInteractionBridgeLocked()Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$InteractionBridge;->getAccessibilityFocusClickPointInScreenNotLocked(Landroid/graphics/Point;)Z

    move-result v0

    return v0
.end method

.method getActiveWindowBounds(Landroid/graphics/Rect;)Z
    .locals 4
    .param p1, "outBounds"    # Landroid/graphics/Rect;

    .prologue
    .line 777
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v3

    .line 778
    :try_start_0
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    iget v1, v2, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->mActiveWindowId:I

    .line 779
    .local v1, "windowId":I
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v2, v1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/IBinder;

    .line 780
    .local v0, "token":Landroid/os/IBinder;
    if-nez v0, :cond_0

    .line 781
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v2

    iget-object v2, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v2, v1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "token":Landroid/os/IBinder;
    check-cast v0, Landroid/os/IBinder;

    .line 783
    .restart local v0    # "token":Landroid/os/IBinder;
    :cond_0
    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 784
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowManagerService:Landroid/view/WindowManagerInternal;

    invoke-virtual {v2, v0, p1}, Landroid/view/WindowManagerInternal;->getWindowFrame(Landroid/os/IBinder;Landroid/graphics/Rect;)V

    .line 785
    invoke-virtual {p1}, Landroid/graphics/Rect;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    .line 786
    const/4 v2, 0x1

    .line 788
    :goto_0
    return v2

    .line 783
    .end local v0    # "token":Landroid/os/IBinder;
    .end local v1    # "windowId":I
    :catchall_0
    move-exception v2

    :try_start_1
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v2

    .line 788
    .restart local v0    # "token":Landroid/os/IBinder;
    .restart local v1    # "windowId":I
    :cond_1
    const/4 v2, 0x0

    goto :goto_0
.end method

.method getActiveWindowId()I
    .locals 1

    .prologue
    .line 798
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v0}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->getActiveWindowId()I

    move-result v0

    return v0
.end method

.method public getEnabledAccessibilityServiceList(II)Ljava/util/List;
    .locals 11
    .param p1, "feedbackType"    # I
    .param p2, "userId"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(II)",
            "Ljava/util/List",
            "<",
            "Landroid/accessibilityservice/AccessibilityServiceInfo;",
            ">;"
        }
    .end annotation

    .prologue
    .line 461
    const/4 v3, 0x0

    .line 462
    .local v3, "result":Ljava/util/List;, "Ljava/util/List<Landroid/accessibilityservice/AccessibilityServiceInfo;>;"
    iget-object v9, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v9

    .line 466
    :try_start_0
    iget-object v8, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v8, p2}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->resolveCallingUserIdEnforcingPermissionsLocked(I)I

    move-result v2

    .line 472
    .local v2, "resolvedUserId":I
    invoke-direct {p0, v2}, Lcom/android/server/accessibility/AccessibilityManagerService;->getUserStateLocked(I)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v7

    .line 473
    .local v7, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v7}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v8

    if-eqz v8, :cond_0

    .line 474
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v8

    monitor-exit v9

    .line 492
    :goto_0
    return-object v8

    .line 477
    :cond_0
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mEnabledServicesForFeedbackTempList:Ljava/util/List;

    .line 478
    invoke-interface {v3}, Ljava/util/List;->clear()V

    .line 479
    iget-object v6, v7, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 480
    .local v6, "services":Ljava/util/List;, "Ljava/util/List<Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    :cond_1
    if-eqz p1, :cond_3

    .line 481
    const/4 v8, 0x1

    invoke-static {p1}, Ljava/lang/Integer;->numberOfTrailingZeros(I)I

    move-result v10

    shl-int v0, v8, v10

    .line 482
    .local v0, "feedbackTypeBit":I
    xor-int/lit8 v8, v0, -0x1

    and-int/2addr p1, v8

    .line 483
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v5

    .line 484
    .local v5, "serviceCount":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    if-ge v1, v5, :cond_1

    .line 485
    invoke-interface {v6, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 486
    .local v4, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    iget v8, v4, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mFeedbackType:I

    and-int/2addr v8, v0

    if-eqz v8, :cond_2

    .line 487
    iget-object v8, v4, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mAccessibilityServiceInfo:Landroid/accessibilityservice/AccessibilityServiceInfo;

    invoke-interface {v3, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 484
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 491
    .end local v0    # "feedbackTypeBit":I
    .end local v1    # "i":I
    .end local v4    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .end local v5    # "serviceCount":I
    :cond_3
    monitor-exit v9

    move-object v8, v3

    .line 492
    goto :goto_0

    .line 491
    .end local v2    # "resolvedUserId":I
    .end local v6    # "services":Ljava/util/List;, "Ljava/util/List<Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    .end local v7    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :catchall_0
    move-exception v8

    monitor-exit v9
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v8
.end method

.method public getInstalledAccessibilityServiceList(I)Ljava/util/List;
    .locals 5
    .param p1, "userId"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Ljava/util/List",
            "<",
            "Landroid/accessibilityservice/AccessibilityServiceInfo;",
            ">;"
        }
    .end annotation

    .prologue
    .line 439
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v4

    .line 443
    :try_start_0
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v3, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->resolveCallingUserIdEnforcingPermissionsLocked(I)I

    move-result v1

    .line 447
    .local v1, "resolvedUserId":I
    invoke-direct {p0, v1}, Lcom/android/server/accessibility/AccessibilityManagerService;->getUserStateLocked(I)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v2

    .line 448
    .local v2, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v2}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 449
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 450
    .local v0, "installedServices":Ljava/util/List;, "Ljava/util/List<Landroid/accessibilityservice/AccessibilityServiceInfo;>;"
    iget-object v3, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInstalledServices:Ljava/util/List;

    invoke-interface {v0, v3}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 451
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v2}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v3

    iget-object v3, v3, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mAccessibilityServiceInfo:Landroid/accessibilityservice/AccessibilityServiceInfo;

    invoke-interface {v0, v3}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 452
    monitor-exit v4

    .line 454
    .end local v0    # "installedServices":Ljava/util/List;, "Ljava/util/List<Landroid/accessibilityservice/AccessibilityServiceInfo;>;"
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInstalledServices:Ljava/util/List;

    monitor-exit v4

    goto :goto_0

    .line 455
    .end local v1    # "resolvedUserId":I
    .end local v2    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :catchall_0
    move-exception v3

    monitor-exit v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v3
.end method

.method public getWindowToken(I)Landroid/os/IBinder;
    .locals 5
    .param p1, "windowId"    # I

    .prologue
    const/4 v1, 0x0

    .line 710
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    const-string v3, "android.permission.RETRIEVE_WINDOW_TOKEN"

    const-string v4, "getWindowToken"

    # invokes: Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->enforceCallingPermission(Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v4}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->access$1100(Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;Ljava/lang/String;Ljava/lang/String;)V

    .line 713
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v3

    .line 717
    :try_start_0
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-static {}, Landroid/os/UserHandle;->getCallingUserId()I

    move-result v4

    invoke-virtual {v2, v4}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->resolveCallingUserIdEnforcingPermissionsLocked(I)I

    move-result v0

    .line 720
    .local v0, "resolvedUserId":I
    iget v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mCurrentUserId:I

    if-eq v0, v2, :cond_0

    .line 721
    monitor-exit v3

    .line 730
    :goto_0
    return-object v1

    .line 723
    :cond_0
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    # invokes: Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->findWindowById(I)Landroid/view/accessibility/AccessibilityWindowInfo;
    invoke-static {v2, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->access$1500(Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;I)Landroid/view/accessibility/AccessibilityWindowInfo;

    move-result-object v2

    if-nez v2, :cond_1

    .line 724
    monitor-exit v3

    goto :goto_0

    .line 731
    .end local v0    # "resolvedUserId":I
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .line 726
    .restart local v0    # "resolvedUserId":I
    :cond_1
    :try_start_1
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v2, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/os/IBinder;

    .line 727
    .local v1, "token":Landroid/os/IBinder;
    if-eqz v1, :cond_2

    .line 728
    monitor-exit v3

    goto :goto_0

    .line 730
    :cond_2
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v2

    iget-object v2, v2, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mWindowTokens:Landroid/util/SparseArray;

    invoke-virtual {v2, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/os/IBinder;

    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object v1, v2

    goto :goto_0
.end method

.method public interrupt(I)V
    .locals 9
    .param p1, "userId"    # I

    .prologue
    .line 498
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v7

    .line 502
    :try_start_0
    iget-object v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v6, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->resolveCallingUserIdEnforcingPermissionsLocked(I)I

    move-result v3

    .line 505
    .local v3, "resolvedUserId":I
    iget v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mCurrentUserId:I

    if-eq v3, v6, :cond_1

    .line 506
    monitor-exit v7

    .line 519
    :cond_0
    return-void

    .line 508
    :cond_1
    invoke-direct {p0, v3}, Lcom/android/server/accessibility/AccessibilityManagerService;->getUserStateLocked(I)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v6

    iget-object v5, v6, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBoundServices:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 509
    .local v5, "services":Ljava/util/concurrent/CopyOnWriteArrayList;, "Ljava/util/concurrent/CopyOnWriteArrayList<Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    monitor-exit v7
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 510
    const/4 v1, 0x0

    .local v1, "i":I
    invoke-virtual {v5}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v0

    .local v0, "count":I
    :goto_0
    if-ge v1, v0, :cond_0

    .line 511
    invoke-virtual {v5, v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    .line 513
    .local v4, "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    :try_start_1
    iget-object v6, v4, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mServiceInterface:Landroid/accessibilityservice/IAccessibilityServiceClient;

    invoke-interface {v6}, Landroid/accessibilityservice/IAccessibilityServiceClient;->onInterrupt()V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0

    .line 510
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 509
    .end local v0    # "count":I
    .end local v1    # "i":I
    .end local v3    # "resolvedUserId":I
    .end local v4    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .end local v5    # "services":Ljava/util/concurrent/CopyOnWriteArrayList;, "Ljava/util/concurrent/CopyOnWriteArrayList<Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    :catchall_0
    move-exception v6

    :try_start_2
    monitor-exit v7
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v6

    .line 514
    .restart local v0    # "count":I
    .restart local v1    # "i":I
    .restart local v3    # "resolvedUserId":I
    .restart local v4    # "service":Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    .restart local v5    # "services":Ljava/util/concurrent/CopyOnWriteArrayList;, "Ljava/util/concurrent/CopyOnWriteArrayList<Lcom/android/server/accessibility/AccessibilityManagerService$Service;>;"
    :catch_0
    move-exception v2

    .line 515
    .local v2, "re":Landroid/os/RemoteException;
    const-string v6, "AccessibilityManagerService"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Error during sending interrupt request to "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, v4, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mService:Landroid/os/IBinder;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v2}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1
.end method

.method notifyKeyEvent(Landroid/view/KeyEvent;I)Z
    .locals 4
    .param p1, "event"    # Landroid/view/KeyEvent;
    .param p2, "policyFlags"    # I

    .prologue
    .line 745
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v3

    .line 746
    :try_start_0
    invoke-static {p1}, Landroid/view/KeyEvent;->obtain(Landroid/view/KeyEvent;)Landroid/view/KeyEvent;

    move-result-object v1

    .line 747
    .local v1, "localClone":Landroid/view/KeyEvent;
    const/4 v2, 0x0

    invoke-direct {p0, v1, p2, v2}, Lcom/android/server/accessibility/AccessibilityManagerService;->notifyKeyEventLocked(Landroid/view/KeyEvent;IZ)Z

    move-result v0

    .line 748
    .local v0, "handled":Z
    if-nez v0, :cond_0

    .line 749
    const/4 v2, 0x1

    invoke-direct {p0, v1, p2, v2}, Lcom/android/server/accessibility/AccessibilityManagerService;->notifyKeyEventLocked(Landroid/view/KeyEvent;IZ)Z

    move-result v0

    .line 751
    :cond_0
    monitor-exit v3

    return v0

    .line 752
    .end local v0    # "handled":Z
    .end local v1    # "localClone":Landroid/view/KeyEvent;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2
.end method

.method onGesture(I)Z
    .locals 3
    .param p1, "gestureId"    # I

    .prologue
    .line 735
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v2

    .line 736
    const/4 v1, 0x0

    :try_start_0
    invoke-direct {p0, p1, v1}, Lcom/android/server/accessibility/AccessibilityManagerService;->notifyGestureLocked(IZ)Z

    move-result v0

    .line 737
    .local v0, "handled":Z
    if-nez v0, :cond_0

    .line 738
    const/4 v1, 0x1

    invoke-direct {p0, p1, v1}, Lcom/android/server/accessibility/AccessibilityManagerService;->notifyGestureLocked(IZ)Z

    move-result v0

    .line 740
    :cond_0
    monitor-exit v2

    return v0

    .line 741
    .end local v0    # "handled":Z
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method onMagnificationStateChanged()V
    .locals 0

    .prologue
    .line 810
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->notifyClearAccessibilityCacheLocked()V

    .line 811
    return-void
.end method

.method onTouchInteractionEnd()V
    .locals 1

    .prologue
    .line 806
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v0}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->onTouchInteractionEnd()V

    .line 807
    return-void
.end method

.method onTouchInteractionStart()V
    .locals 1

    .prologue
    .line 802
    iget-object v0, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v0}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->onTouchInteractionStart()V

    .line 803
    return-void
.end method

.method public registerUiTestAutomationService(Landroid/os/IBinder;Landroid/accessibilityservice/IAccessibilityServiceClient;Landroid/accessibilityservice/AccessibilityServiceInfo;)V
    .locals 6
    .param p1, "owner"    # Landroid/os/IBinder;
    .param p2, "serviceClient"    # Landroid/accessibilityservice/IAccessibilityServiceClient;
    .param p3, "accessibilityServiceInfo"    # Landroid/accessibilityservice/AccessibilityServiceInfo;

    .prologue
    .line 618
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    const-string v3, "android.permission.RETRIEVE_WINDOW_CONTENT"

    const-string v4, "registerUiTestAutomationService"

    # invokes: Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->enforceCallingPermission(Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v4}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->access$1100(Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;Ljava/lang/String;Ljava/lang/String;)V

    .line 621
    sget-object v2, Lcom/android/server/accessibility/AccessibilityManagerService;->sFakeAccessibilityServiceComponentName:Landroid/content/ComponentName;

    invoke-virtual {p3, v2}, Landroid/accessibilityservice/AccessibilityServiceInfo;->setComponentName(Landroid/content/ComponentName;)V

    .line 623
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v3

    .line 624
    :try_start_0
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v1

    .line 626
    .local v1, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v1}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 627
    new-instance v2, Ljava/lang/IllegalStateException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "UiAutomationService "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "already registered!"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 654
    .end local v1    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .line 632
    .restart local v1    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :cond_0
    :try_start_1
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationSerivceOnwerDeathRecipient:Landroid/os/IBinder$DeathRecipient;
    invoke-static {v1}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$1200(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Landroid/os/IBinder$DeathRecipient;

    move-result-object v2

    const/4 v4, 0x0

    invoke-interface {p1, v2, v4}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 639
    :try_start_2
    # setter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationServiceOwner:Landroid/os/IBinder;
    invoke-static {v1, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$1302(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;Landroid/os/IBinder;)Landroid/os/IBinder;

    .line 640
    # setter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationServiceClient:Landroid/accessibilityservice/IAccessibilityServiceClient;
    invoke-static {v1, p2}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$1402(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;Landroid/accessibilityservice/IAccessibilityServiceClient;)Landroid/accessibilityservice/IAccessibilityServiceClient;

    .line 643
    const/4 v2, 0x1

    iput-boolean v2, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsAccessibilityEnabled:Z

    .line 644
    const/4 v2, 0x0

    iput-boolean v2, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsTouchExplorationEnabled:Z

    .line 645
    const/4 v2, 0x0

    iput-boolean v2, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsEnhancedWebAccessibilityEnabled:Z

    .line 646
    const/4 v2, 0x0

    iput-boolean v2, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsDisplayMagnificationEnabled:Z

    .line 647
    iget-object v2, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInstalledServices:Ljava/util/List;

    invoke-interface {v2, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 648
    iget-object v2, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mEnabledServices:Ljava/util/Set;

    invoke-interface {v2}, Ljava/util/Set;->clear()V

    .line 649
    iget-object v2, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mEnabledServices:Ljava/util/Set;

    sget-object v4, Lcom/android/server/accessibility/AccessibilityManagerService;->sFakeAccessibilityServiceComponentName:Landroid/content/ComponentName;

    invoke-interface {v2, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 650
    iget-object v2, v1, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mTouchExplorationGrantedServices:Ljava/util/Set;

    sget-object v4, Lcom/android/server/accessibility/AccessibilityManagerService;->sFakeAccessibilityServiceComponentName:Landroid/content/ComponentName;

    invoke-interface {v2, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 653
    invoke-direct {p0, v1}, Lcom/android/server/accessibility/AccessibilityManagerService;->onUserStateChangedLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 654
    monitor-exit v3

    .line 655
    :goto_0
    return-void

    .line 633
    :catch_0
    move-exception v0

    .line 634
    .local v0, "re":Landroid/os/RemoteException;
    const-string v2, "AccessibilityManagerService"

    const-string v4, "Couldn\'t register for the death of a UiTestAutomationService!"

    invoke-static {v2, v4, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 636
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0
.end method

.method public removeAccessibilityInteractionConnection(Landroid/view/IWindow;)V
    .locals 9
    .param p1, "window"    # Landroid/view/IWindow;

    .prologue
    .line 563
    iget-object v7, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v7

    .line 567
    :try_start_0
    iget-object v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-static {}, Landroid/os/UserHandle;->getCallingUserId()I

    move-result v8

    invoke-virtual {v6, v8}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->resolveCallingUserIdEnforcingPermissionsLocked(I)I

    .line 569
    invoke-interface {p1}, Landroid/view/IWindow;->asBinder()Landroid/os/IBinder;

    move-result-object v3

    .line 570
    .local v3, "token":Landroid/os/IBinder;
    iget-object v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalWindowTokens:Landroid/util/SparseArray;

    iget-object v8, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mGlobalInteractionConnections:Landroid/util/SparseArray;

    invoke-direct {p0, v3, v6, v8}, Lcom/android/server/accessibility/AccessibilityManagerService;->removeAccessibilityInteractionConnectionInternalLocked(Landroid/os/IBinder;Landroid/util/SparseArray;Landroid/util/SparseArray;)I

    move-result v1

    .line 572
    .local v1, "removedWindowId":I
    if-ltz v1, :cond_0

    .line 577
    monitor-exit v7

    .line 595
    :goto_0
    return-void

    .line 579
    :cond_0
    iget-object v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mUserStates:Landroid/util/SparseArray;

    invoke-virtual {v6}, Landroid/util/SparseArray;->size()I

    move-result v4

    .line 580
    .local v4, "userCount":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    if-ge v0, v4, :cond_2

    .line 581
    iget-object v6, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mUserStates:Landroid/util/SparseArray;

    invoke-virtual {v6, v0}, Landroid/util/SparseArray;->valueAt(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    .line 582
    .local v5, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    iget-object v6, v5, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mWindowTokens:Landroid/util/SparseArray;

    iget-object v8, v5, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mInteractionConnections:Landroid/util/SparseArray;

    invoke-direct {p0, v3, v6, v8}, Lcom/android/server/accessibility/AccessibilityManagerService;->removeAccessibilityInteractionConnectionInternalLocked(Landroid/os/IBinder;Landroid/util/SparseArray;Landroid/util/SparseArray;)I

    move-result v2

    .line 585
    .local v2, "removedWindowIdForUser":I
    if-ltz v2, :cond_1

    .line 591
    monitor-exit v7

    goto :goto_0

    .line 594
    .end local v0    # "i":I
    .end local v1    # "removedWindowId":I
    .end local v2    # "removedWindowIdForUser":I
    .end local v3    # "token":Landroid/os/IBinder;
    .end local v4    # "userCount":I
    .end local v5    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :catchall_0
    move-exception v6

    monitor-exit v7
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v6

    .line 580
    .restart local v0    # "i":I
    .restart local v1    # "removedWindowId":I
    .restart local v2    # "removedWindowIdForUser":I
    .restart local v3    # "token":Landroid/os/IBinder;
    .restart local v4    # "userCount":I
    .restart local v5    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 594
    .end local v2    # "removedWindowIdForUser":I
    .end local v5    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :cond_2
    :try_start_1
    monitor-exit v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0
.end method

.method public sendAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;I)Z
    .locals 9
    .param p1, "event"    # Landroid/view/accessibility/AccessibilityEvent;
    .param p2, "userId"    # I

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 410
    iget-object v3, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v3

    .line 414
    :try_start_0
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v4, p2}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->resolveCallingUserIdEnforcingPermissionsLocked(I)I

    move-result v0

    .line 417
    .local v0, "resolvedUserId":I
    iget v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mCurrentUserId:I

    if-eq v0, v4, :cond_1

    .line 418
    monitor-exit v3

    .line 434
    :cond_0
    :goto_0
    return v1

    .line 420
    :cond_1
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    # invokes: Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->canDispatchAccessibilityEventLocked(Landroid/view/accessibility/AccessibilityEvent;)Z
    invoke-static {v4, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->access$1000(Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;Landroid/view/accessibility/AccessibilityEvent;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 421
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->getWindowId()I

    move-result v5

    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->getSourceNodeId()J

    move-result-wide v6

    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->getEventType()I

    move-result v8

    invoke-virtual {v4, v5, v6, v7, v8}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->updateActiveAndAccessibilityFocusedWindowLocked(IJI)V

    .line 423
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    invoke-virtual {v4, p1}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->updateEventSourceLocked(Landroid/view/accessibility/AccessibilityEvent;)V

    .line 424
    const/4 v4, 0x0

    invoke-direct {p0, p1, v4}, Lcom/android/server/accessibility/AccessibilityManagerService;->notifyAccessibilityServicesDelayedLocked(Landroid/view/accessibility/AccessibilityEvent;Z)V

    .line 425
    const/4 v4, 0x1

    invoke-direct {p0, p1, v4}, Lcom/android/server/accessibility/AccessibilityManagerService;->notifyAccessibilityServicesDelayedLocked(Landroid/view/accessibility/AccessibilityEvent;Z)V

    .line 427
    :cond_2
    iget-boolean v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mHasInputFilter:Z

    if-eqz v4, :cond_3

    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mInputFilter:Lcom/android/server/accessibility/AccessibilityInputFilter;

    if-eqz v4, :cond_3

    .line 428
    iget-object v4, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mMainHandler:Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;

    const/4 v5, 0x1

    invoke-static {p1}, Landroid/view/accessibility/AccessibilityEvent;->obtain(Landroid/view/accessibility/AccessibilityEvent;)Landroid/view/accessibility/AccessibilityEvent;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Lcom/android/server/accessibility/AccessibilityManagerService$MainHandler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v4

    invoke-virtual {v4}, Landroid/os/Message;->sendToTarget()V

    .line 431
    :cond_3
    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->recycle()V

    .line 432
    invoke-direct {p0, v0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getUserStateLocked(I)Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v4

    const/4 v5, 0x0

    iput v5, v4, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mHandledFeedbackTypes:I

    .line 433
    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 434
    sget v3, Lcom/android/server/accessibility/AccessibilityManagerService;->OWN_PROCESS_ID:I

    invoke-static {}, Landroid/os/Binder;->getCallingPid()I

    move-result v4

    if-ne v3, v4, :cond_0

    move v1, v2

    goto :goto_0

    .line 433
    .end local v0    # "resolvedUserId":I
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public temporaryEnableAccessibilityStateUntilKeyguardRemoved(Landroid/content/ComponentName;Z)V
    .locals 4
    .param p1, "service"    # Landroid/content/ComponentName;
    .param p2, "touchExplorationEnabled"    # Z

    .prologue
    .line 678
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mSecurityPolicy:Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;

    const-string v2, "android.permission.TEMPORARY_ENABLE_ACCESSIBILITY"

    const-string v3, "temporaryEnableAccessibilityStateUntilKeyguardRemoved"

    # invokes: Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->enforceCallingPermission(Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v1, v2, v3}, Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;->access$1100(Lcom/android/server/accessibility/AccessibilityManagerService$SecurityPolicy;Ljava/lang/String;Ljava/lang/String;)V

    .line 681
    iget-object v1, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mWindowManagerService:Landroid/view/WindowManagerInternal;

    invoke-virtual {v1}, Landroid/view/WindowManagerInternal;->isKeyguardLocked()Z

    move-result v1

    if-nez v1, :cond_0

    .line 706
    :goto_0
    return-void

    .line 684
    :cond_0
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v2

    .line 686
    :try_start_0
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v0

    .line 689
    .local v0, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v0}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 690
    monitor-exit v2

    goto :goto_0

    .line 705
    .end local v0    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 693
    .restart local v0    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :cond_1
    const/4 v1, 0x1

    :try_start_1
    iput-boolean v1, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsAccessibilityEnabled:Z

    .line 694
    iput-boolean p2, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsTouchExplorationEnabled:Z

    .line 695
    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsEnhancedWebAccessibilityEnabled:Z

    .line 696
    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mIsDisplayMagnificationEnabled:Z

    .line 697
    iget-object v1, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mEnabledServices:Ljava/util/Set;

    invoke-interface {v1}, Ljava/util/Set;->clear()V

    .line 698
    iget-object v1, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mEnabledServices:Ljava/util/Set;

    invoke-interface {v1, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 699
    iget-object v1, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mBindingServices:Ljava/util/Set;

    invoke-interface {v1}, Ljava/util/Set;->clear()V

    .line 700
    iget-object v1, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mTouchExplorationGrantedServices:Ljava/util/Set;

    invoke-interface {v1}, Ljava/util/Set;->clear()V

    .line 701
    iget-object v1, v0, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mTouchExplorationGrantedServices:Ljava/util/Set;

    invoke-interface {v1, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 704
    invoke-direct {p0, v0}, Lcom/android/server/accessibility/AccessibilityManagerService;->onUserStateChangedLocked(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)V

    .line 705
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0
.end method

.method public unregisterUiTestAutomationService(Landroid/accessibilityservice/IAccessibilityServiceClient;)V
    .locals 5
    .param p1, "serviceClient"    # Landroid/accessibilityservice/IAccessibilityServiceClient;

    .prologue
    .line 659
    iget-object v2, p0, Lcom/android/server/accessibility/AccessibilityManagerService;->mLock:Ljava/lang/Object;

    monitor-enter v2

    .line 660
    :try_start_0
    invoke-direct {p0}, Lcom/android/server/accessibility/AccessibilityManagerService;->getCurrentUserStateLocked()Lcom/android/server/accessibility/AccessibilityManagerService$UserState;

    move-result-object v0

    .line 662
    .local v0, "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v0}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v1

    if-eqz v1, :cond_0

    if-eqz p1, :cond_0

    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v0}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v1

    iget-object v1, v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mServiceInterface:Landroid/accessibilityservice/IAccessibilityServiceClient;

    if-eqz v1, :cond_0

    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v0}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v1

    iget-object v1, v1, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->mServiceInterface:Landroid/accessibilityservice/IAccessibilityServiceClient;

    invoke-interface {v1}, Landroid/accessibilityservice/IAccessibilityServiceClient;->asBinder()Landroid/os/IBinder;

    move-result-object v1

    invoke-interface {p1}, Landroid/accessibilityservice/IAccessibilityServiceClient;->asBinder()Landroid/os/IBinder;

    move-result-object v3

    if-ne v1, v3, :cond_0

    .line 667
    # getter for: Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->mUiAutomationService:Lcom/android/server/accessibility/AccessibilityManagerService$Service;
    invoke-static {v0}, Lcom/android/server/accessibility/AccessibilityManagerService$UserState;->access$300(Lcom/android/server/accessibility/AccessibilityManagerService$UserState;)Lcom/android/server/accessibility/AccessibilityManagerService$Service;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/server/accessibility/AccessibilityManagerService$Service;->binderDied()V

    .line 672
    monitor-exit v2

    .line 673
    return-void

    .line 669
    :cond_0
    new-instance v1, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "UiAutomationService "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " not registered!"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 672
    .end local v0    # "userState":Lcom/android/server/accessibility/AccessibilityManagerService$UserState;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method
