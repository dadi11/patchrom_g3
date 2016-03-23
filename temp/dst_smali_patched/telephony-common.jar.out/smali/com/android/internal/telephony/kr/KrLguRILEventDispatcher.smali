.class public final Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;
.super Landroid/os/Handler;
.source "KrLguRILEventDispatcher.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher$LockOrderIntentReceiver;
    }
.end annotation


# static fields
.field private static final ACTION_LG_NVITEM_RESET:Ljava/lang/String; = "android.intent.action.LG_NVITEM_RESET"

.field public static final CDMA_LOCK_ORDER:Ljava/lang/String; = "android.intent.action.CDMA_LOCK_ORDER"

.field public static final CDMA_MAINT_REQ:Ljava/lang/String; = "android.intent.action.CDMA_MAINT_REQ"

.field private static final CDMA_RIL_EVENT:Ljava/lang/String; = "android.intent.action.CDMA_RIL_EVENT"

.field static final CONGESTTION:I = 0x16

.field private static final EHRPD_LOCK_ORDER:Ljava/lang/String; = "android.intent.action.EHRPD_LOCK_ORDER"

.field static final EPS_SERVICES_AND_NON_EPS_SERVICES_NOT_ALLOWED:I = 0x8

.field static final EPS_SERVICES_NOT_ALLOWED:I = 0x7

.field static final EPS_SERVICES_NOT_ALLOWED_IN_THIS_PLMN:I = 0xe

.field static final ESM_FAILURE:I = 0x13

.field private static final EVENT_EMM_REJECT:I = 0x16

.field private static final EVENT_HDR_LOCK:I = 0x14

.field private static final EVENT_LGT_FACTORY_RESET:I = 0x13

.field private static final EVENT_LGT_OTA_SESSION_FAIL:I = 0x1

.field private static final EVENT_LGT_OTA_SESSION_SUCCESS:I = 0x2

.field private static final EVENT_LGT_ROAMING_UI_TEST_SET_DONE:I = 0xc

.field private static final EVENT_LGT_SID_CHANGED:I = 0x4

.field private static final EVENT_LGT_WPBX_CHANGED:I = 0x5

.field private static final EVENT_LOCK_STATE_CHANGED:I = 0x3

.field private static final EVENT_LTE_LOCK:I = 0x15

.field private static final EVENT_NET_ERR_DISP:I = 0xf

.field private static final EVENT_RIL_EVENT_DISPATCHER_BASE:I = 0x0

.field static final ILLEGAL_ME:I = 0x6

.field static final ILLEGAL_UE:I = 0x3

.field static final IMEI_NOT_ACCEPTED:I = 0x5

.field static final IMPLICITLY_DETACHED:I = 0xa

.field static final IMSI_NUKNOWN_IN_HSS:I = 0x2

.field static final INFORMATION_ELEMENTNON_EXISTANT_OR_NOT_IMPLEMENTED:I = 0x63

.field static final INVALID_MANDATORY_INFO:I = 0x60

.field public static final LGT_AUTH_LOCK:Ljava/lang/String; = "android.intent.action.LGT_AUTH_LOCK"

.field public static final LGT_HDR_NETWORK_ERROR:Ljava/lang/String; = "android.intent.action.LGT_HDR_NETWORK_ERROR"

.field public static final LGT_OTA_RES_NOTIF_FAIL:Ljava/lang/String; = "android.intent.action.LGT_OTA_RES_NOTIF_FAIL"

.field public static final LGT_OTA_RES_NOTIF_SAME:Ljava/lang/String; = "android.intent.action.LGT_OTA_RES_NOTIF_SAME"

.field public static final LGT_OTA_RES_NOTIF_UPDATE:Ljava/lang/String; = "android.intent.action.LGT_OTA_RES_NOTIF_UPDATE"

.field public static final LGT_SID_CHANGED:Ljava/lang/String; = "android.intent.action.LGT_SID_CHANGED"

.field public static final LGT_WPBX_MATCH:Ljava/lang/String; = "android.intent.action.LGT_WPBX_MATCH"

.field public static final LGT_WPBX_NOMATCH:Ljava/lang/String; = "android.intent.action.LGT_WPBX_NOMATCH"

.field private static final LOG_TAG:Ljava/lang/String; = "KrLguRILEventDispatcher"

.field static final LTE_AUTHENTICATION_REJECT:I = 0x54

.field static final MAC_FAILURE:I = 0x14

.field static final MESSAGE_TYPE_NONEXISTANT_OR_NOT_IMPLEMENTED:I = 0x61

.field static final MSC_TEMPORARILY_NOT_REACHABLE:I = 0x10

.field static final NETWORK_FAILURE:I = 0x11

.field static final NOT_AUTHORIZED_FOR_THIS_CSG:I = 0x19

.field static final NO_EPS_BEARER_CONTEXT_ACTIVATED:I = 0x28

.field static final NO_SUITABLE_CELLS_IN_TRACKING_AREA:I = 0xf

.field static final PLMN_NOT_ALLOWED:I = 0xb

.field static final PROTOCOL_ERROR_UNSPECIFIED:I = 0x6f

.field static final REJECTCAUSE_NOTIFICATION_ID:I = 0xc73b

.field static final ROAMING_NOT_ALLOWED_IN_THIS_TRACKING_AREA:I = 0xd

.field static final SEMANTICALLY_INCORRECT_MSG:I = 0x5f

.field static final TRACKING_AREA_NOT_ALLOWED:I = 0xc

.field static final UE_IDENTITY_CANNOT_BE_DERIVED_BY_THE_NERWORK:I = 0x9

.field private static mSimState:Lcom/android/internal/telephony/IccCardConstants$State;

.field private static rilEventDispatcher:Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;


# instance fields
.field private debugFilter:Z

.field private mBroadcastReceiver:Landroid/content/BroadcastReceiver;

.field private final mCm:Lcom/android/internal/telephony/CommandsInterface;

.field private final mContext:Landroid/content/Context;

.field private mIsLGTHDRNetworkError:Z

.field private mIsLGTUnauthenticated:Z

.field private mIsLGTUnregister:Z

.field private mIsLTEAuthError:Z

.field private mIsLTEEMMReject:Z

.field private mLockOrderPopup:Landroid/app/AlertDialog;

.field private mLockOrderReceiver:Landroid/content/BroadcastReceiver;

.field private mRejectNotification:Landroid/app/Notification;

.field private mRejectNum:I

.field private mSS:Landroid/telephony/ServiceState;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->rilEventDispatcher:Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    sget-object v0, Lcom/android/internal/telephony/IccCardConstants$State;->UNKNOWN:Lcom/android/internal/telephony/IccCardConstants$State;

    sput-object v0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mSimState:Lcom/android/internal/telephony/IccCardConstants$State;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;)V
    .locals 5
    .param p1, "ctx"    # Landroid/content/Context;
    .param p2, "commandsInterface"    # Lcom/android/internal/telephony/CommandsInterface;

    .prologue
    const/4 v4, 0x1

    const/4 v1, 0x0

    const/4 v3, 0x0

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    iput-boolean v4, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderReceiver:Landroid/content/BroadcastReceiver;

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderPopup:Landroid/app/AlertDialog;

    iput-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTUnregister:Z

    iput-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTUnauthenticated:Z

    iput-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTHDRNetworkError:Z

    iput-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLTEAuthError:Z

    iput-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLTEEMMReject:Z

    iput v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNum:I

    new-instance v1, Landroid/telephony/ServiceState;

    invoke-direct {v1}, Landroid/telephony/ServiceState;-><init>()V

    iput-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mSS:Landroid/telephony/ServiceState;

    new-instance v1, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher$1;

    invoke-direct {v1, p0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher$1;-><init>(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;)V

    iput-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    const-string v1, "created"

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    iput-object p1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const-string v1, "gsm.lge.lte_reject_cause"

    const-string v2, "0"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "set  : TelephonyProperties.PROPERTY_LTE_REJECT_CAUSE to 0"

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "android.intent.action.LGT_ROAMING_UI_TEST_LGT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.LGT_ROAMING_UI_TEST_KT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.LGT_ROAMING_UI_TEST_JCDMA"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.LGT_ROAMING_UI_TEST_DCN"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.LG_NVITEM_RESET"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1, p0, v4, v3}, Lcom/android/internal/telephony/CommandsInterface;->registerForOtaSessionFail(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v2, 0x2

    invoke-interface {v1, p0, v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->registerForOtaSessionSuccess(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v2, 0x3

    invoke-interface {v1, p0, v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->registerForLockStateChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v2, 0x4

    invoke-interface {v1, p0, v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->registerForCdmaSidChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v2, 0x5

    invoke-interface {v1, p0, v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->registerForWpbxStateChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v2, 0xf

    invoke-interface {v1, p0, v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->registerForNetworkErrorDisp(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v2, 0x14

    invoke-interface {v1, p0, v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->registerForHdrLock(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v2, 0x15

    invoke-interface {v1, p0, v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->registerForLteLock(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v2, 0x16

    invoke-interface {v1, p0, v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->registerForLteEmmReject(Landroid/os/Handler;ILjava/lang/Object;)V

    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->registerIntentReceivers()V

    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;I)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;
    .param p1, "x1"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->handleLGTRoamingUITest(I)V

    return-void
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->handleNVItemReset()V

    return-void
.end method

.method static synthetic access$1002(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;Landroid/app/AlertDialog;)Landroid/app/AlertDialog;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;
    .param p1, "x1"    # Landroid/app/AlertDialog;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderPopup:Landroid/app/AlertDialog;

    return-object p1
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    .prologue
    iget-boolean v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTUnregister:Z

    return v0
.end method

.method static synthetic access$202(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTUnregister:Z

    return p1
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    .prologue
    iget-boolean v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTUnauthenticated:Z

    return v0
.end method

.method static synthetic access$302(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTUnauthenticated:Z

    return p1
.end method

.method static synthetic access$400(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    .prologue
    iget-boolean v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTHDRNetworkError:Z

    return v0
.end method

.method static synthetic access$402(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTHDRNetworkError:Z

    return p1
.end method

.method static synthetic access$500(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    .prologue
    iget-boolean v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLTEAuthError:Z

    return v0
.end method

.method static synthetic access$502(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLTEAuthError:Z

    return p1
.end method

.method static synthetic access$600(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    .prologue
    iget-boolean v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLTEEMMReject:Z

    return v0
.end method

.method static synthetic access$602(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLTEEMMReject:Z

    return p1
.end method

.method static synthetic access$700(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    .prologue
    iget v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNum:I

    return v0
.end method

.method static synthetic access$702(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;I)I
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNum:I

    return p1
.end method

.method static synthetic access$800(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->setPopUp()V

    return-void
.end method

.method private static checkMissingPhoneAndSendIntentWhenReboot(Landroid/content/Context;)V
    .locals 5
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v4, 0x5

    const-string v2, "persist.radio.missing_phone"

    const-string v3, "0"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .local v1, "isMissingPhone":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isMissingPhone = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    const-string v2, "1"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    new-instance v0, Landroid/content/Intent;

    const-string v2, "com.lge.intent.action.LTE_MISSING_PHONE"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intentMissingPhone":Landroid/content/Intent;
    const-string v2, "rejectCode"

    invoke-virtual {v0, v2, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {p0, v0, v2}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    invoke-static {p0, v4}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->startEmergencyDialerActivity(Landroid/content/Context;I)V

    const-string v2, "send intent LTE_MISSING_PHONE in phone process start"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    .end local v0    # "intentMissingPhone":Landroid/content/Intent;
    :cond_0
    return-void
.end method

.method public static getRILEventDispatcher(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;)Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;
    .locals 2
    .param p0, "ctx"    # Landroid/content/Context;
    .param p1, "commandsInterface"    # Lcom/android/internal/telephony/CommandsInterface;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "getRILEventDispatcher : rilEventDispatcher="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->rilEventDispatcher:Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ctx="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " commandsInterface="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_1
    sget-object v0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->rilEventDispatcher:Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    if-nez v0, :cond_2

    new-instance v0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    invoke-direct {v0, p0, p1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;)V

    sput-object v0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->rilEventDispatcher:Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    :cond_2
    sget-object v0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->rilEventDispatcher:Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    goto :goto_0
.end method

.method private handleHdrLock(Landroid/os/AsyncResult;)V
    .locals 4
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const-string v2, "eHRPD Lock Order Received!"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    iget-object v2, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v2, :cond_1

    const-string v2, "Err! eHRPD Lock order"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v2, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, [I

    move-object v1, v2

    check-cast v1, [I

    .local v1, "ints":[I
    const/4 v2, 0x0

    aget v2, v1, v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_0

    const-string v2, "send intent EHRPD_LOCK_ORDER!"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.intent.action.EHRPD_LOCK_ORDER"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0
.end method

.method private handleLGTNetworkError(Landroid/os/AsyncResult;)V
    .locals 3
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    iget-object v1, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v1, :cond_1

    iget-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_NET_ERR_DISP Err"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v1, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v1, [I

    check-cast v1, [I

    const/4 v2, 0x0

    aget v1, v1, v2

    const/4 v2, 0x1

    if-ne v1, v2, :cond_2

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.LGT_HDR_NETWORK_ERROR"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    iget-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v1, :cond_0

    const-string v1, "intent LGT_HDR_NETWORK_ERROR send "

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_2
    iget-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v1, :cond_0

    const-string v1, "DO NOT send intent LGT_HDR_NETWORK_ERROR"

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private handleLGTRoamingUITest(I)V
    .locals 3
    .param p1, "Value"    # I

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const v1, 0x20030

    const/16 v2, 0xc

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-interface {v0, v1, p1, v2}, Lcom/android/internal/telephony/CommandsInterface;->setModemIntegerItem(IILandroid/os/Message;)V

    return-void
.end method

.method private handleLgtOtaSessionFail()V
    .locals 3

    .prologue
    const-string v1, "LGT OTA SESSION FAIL"

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.LGT_OTA_RES_NOTIF_FAIL"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    return-void
.end method

.method private handleLgtOtaSessionSuccess(Landroid/os/AsyncResult;)V
    .locals 5
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const/4 v4, 0x0

    iget-boolean v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v2, :cond_0

    const-string v2, "LGT OTA SESSION SUCCESS"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_0
    iget-object v2, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v2, :cond_2

    const-string v2, "Err! CDMA Lock order"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_1
    :goto_0
    return-void

    :cond_2
    iget-object v2, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, [I

    move-object v1, v2

    check-cast v1, [I

    .local v1, "ints":[I
    aget v2, v1, v4

    const/4 v3, 0x1

    if-ne v2, v3, :cond_3

    const-string v2, "send intent LGT_OTA_RES_NOTIF_UPDATE!"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.intent.action.LGT_OTA_RES_NOTIF_UPDATE"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    sget-object v3, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v2, v0, v3}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto :goto_0

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_3
    aget v2, v1, v4

    if-nez v2, :cond_1

    const-string v2, "send intent LGT_OTA_RES_NOTIF_SAME!"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.intent.action.LGT_OTA_RES_NOTIF_SAME"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v0    # "intent":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    sget-object v3, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v2, v0, v3}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto :goto_0
.end method

.method private handleLgtSidChanged(Landroid/os/AsyncResult;)V
    .locals 5
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const/4 v4, 0x0

    iget-boolean v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v2, :cond_0

    const-string v2, "LGT ROAMING SID Changed!"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_0
    iget-object v2, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v2, :cond_1

    const-string v2, "Err! LGT SID Changed"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_1
    iget-object v2, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, [I

    move-object v1, v2

    check-cast v1, [I

    .local v1, "ints":[I
    iget-boolean v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v2, :cond_2

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "send SID info : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    aget v3, v1, v4

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_2
    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.intent.action.LGT_SID_CHANGED"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v2, "sid"

    aget v3, v1, v4

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0
.end method

.method private handleLgtWpbxChanged(Landroid/os/AsyncResult;)V
    .locals 5
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const/4 v4, 0x0

    iget-boolean v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v2, :cond_0

    const-string v2, "LGT WPBX Match Changed!"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_0
    iget-object v2, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v2, :cond_2

    const-string v2, "Err! LGT WPBX Match"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_1
    :goto_0
    return-void

    :cond_2
    iget-object v2, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, [I

    move-object v1, v2

    check-cast v1, [I

    .local v1, "ints":[I
    aget v2, v1, v4

    const/4 v3, 0x1

    if-ne v2, v3, :cond_3

    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.intent.action.LGT_WPBX_MATCH"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_3
    aget v2, v1, v4

    if-nez v2, :cond_1

    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.intent.action.LGT_WPBX_NOMATCH"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v0    # "intent":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0
.end method

.method private handleLockStateChanged(Landroid/os/AsyncResult;)V
    .locals 5
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x1

    iget-boolean v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v2, :cond_0

    const-string v2, "CDMA Lock Order Received!"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_0
    iget-object v2, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v2, :cond_2

    const-string v2, "Err! CDMA Lock order"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_1
    :goto_0
    return-void

    :cond_2
    iget-object v2, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, [I

    move-object v1, v2

    check-cast v1, [I

    .local v1, "ints":[I
    aget v2, v1, v4

    if-ne v2, v3, :cond_3

    aget v2, v1, v3

    if-ne v2, v3, :cond_3

    const-string v2, "send intent CDMA_LOCK_ORDER!"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.intent.action.CDMA_LOCK_ORDER"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_3
    aget v2, v1, v4

    if-ne v2, v3, :cond_4

    const-string v2, "send intent CDMA_MAINT_REQ!"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.intent.action.CDMA_MAINT_REQ"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v0    # "intent":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_4
    aget v2, v1, v3

    if-ne v2, v3, :cond_1

    const-string v2, "send intent LGT_AUTH_LOCK!"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.intent.action.LGT_AUTH_LOCK"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v0    # "intent":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0
.end method

.method private handleLteEmmReject(Landroid/os/AsyncResult;)V
    .locals 9
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const/4 v8, 0x6

    const/4 v7, 0x5

    const/4 v6, 0x1

    const/4 v5, 0x0

    const-string v3, "LTE EMM REJECT Received!"

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    iget-object v3, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v3, :cond_0

    const-string v3, "Err! LTE EMM REJECT order"

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    iget-object v3, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v3, [I

    move-object v1, v3

    check-cast v1, [I

    .local v1, "ints":[I
    const-string v3, "gsm.lge.lte_reject_cause"

    aget v4, v1, v5

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "gsm.lge.lte_esm_reject_cause"

    aget v4, v1, v6

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "persist.radio.last_ltereject"

    invoke-static {v3, v5}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v2

    .local v2, "lastLteRejectCause":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "lastLteRejectCause = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " , new lte reject = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget v4, v1, v5

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    if-eq v2, v7, :cond_1

    if-ne v2, v8, :cond_2

    :cond_1
    aget v3, v1, v5

    if-eq v3, v7, :cond_3

    aget v3, v1, v5

    if-eq v3, v8, :cond_3

    :cond_2
    new-instance v0, Landroid/content/Intent;

    const-string v3, "com.lge.intent.action.LTE_EMM_REJECT"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v3, "rejectCode"

    aget v4, v1, v5

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v3, "esmRejectCode"

    aget v4, v1, v6

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v3, v0}, Landroid/content/Context;->sendStickyBroadcast(Landroid/content/Intent;)V

    aget v3, v1, v5

    aget v4, v1, v6

    invoke-static {v3, v4}, Lcom/android/internal/telephony/kr/KrRegStateNotification;->notifyLteRejectCauseChanged(II)V

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_3
    const-string v3, "persist.radio.last_ltereject"

    aget v4, v1, v5

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method private handleLteLock(Landroid/os/AsyncResult;)V
    .locals 3
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const-string v1, "LTE Lock Order Received!"

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    iget-object v1, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v1, :cond_1

    const-string v1, "Err! LTE Lock order"

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v1, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v1, [I

    move-object v0, v1

    check-cast v0, [I

    .local v0, "ints":[I
    const/4 v1, 0x0

    aget v1, v0, v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    const-string v1, "send intent LTE_LOCK_ORDER!"

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private handleNVItemReset()V
    .locals 4

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const v1, 0x20036

    const/4 v2, 0x0

    const/16 v3, 0x13

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->obtainMessage(I)Landroid/os/Message;

    move-result-object v3

    invoke-interface {v0, v1, v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->setModemIntegerItem(IILandroid/os/Message;)V

    return-void
.end method

.method private isOtaActivity()Z
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method protected static log(Ljava/lang/String;)V
    .locals 1
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    const-string v0, "KrLguRILEventDispatcher"

    invoke-static {v0, p0}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private registerIntentReceivers()V
    .locals 3

    .prologue
    const-string v1, "registerIntentReceivers"

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderReceiver:Landroid/content/BroadcastReceiver;

    if-nez v1, :cond_0

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .local v0, "lockOrderfilter":Landroid/content/IntentFilter;
    const-string v1, "android.intent.action.CDMA_LOCK_ORDER"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.CDMA_MAINT_REQ"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.LGT_AUTH_LOCK"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.LGT_HDR_NETWORK_ERROR"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.EHRPD_LOCK_ORDER"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.LTE_LOCK_ORDER"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.EHRPD_AN_LOCK"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.intent.action.LTE_EMM_REJECT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    new-instance v1, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher$LockOrderIntentReceiver;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher$LockOrderIntentReceiver;-><init>(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher$1;)V

    iput-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderReceiver:Landroid/content/BroadcastReceiver;

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .end local v0    # "lockOrderfilter":Landroid/content/IntentFilter;
    :cond_0
    return-void
.end method

.method private setPopUp()V
    .locals 10

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    const-string v6, "setPopUp"

    invoke-static {v6}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    const-string v2, ""

    .local v2, "message":Ljava/lang/String;
    const-string v4, ""

    .local v4, "title":Ljava/lang/String;
    iget-boolean v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTUnregister:Z

    if-eqz v6, :cond_2

    const-string v6, "lgt_unregister"

    invoke-static {v6}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_1

    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->isOtaActivity()Z

    move-result v6

    if-nez v6, :cond_1

    invoke-direct {p0, v4, v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->showPopUp(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "CDMA_RIL_EVENT++ "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v6, "android.intent.action.CDMA_RIL_EVENT"

    invoke-direct {v0, v6}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v6, "Event_Type"

    invoke-virtual {v0, v6, v9}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v6, v0}, Landroid/content/Context;->sendStickyBroadcast(Landroid/content/Intent;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "CDMA_RIL_EVENT-- : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    return-void

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_2
    iget-boolean v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTUnauthenticated:Z

    if-eqz v6, :cond_3

    const-string v6, "lgt_unauthenticated"

    invoke-static {v6}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_3
    iget-boolean v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTHDRNetworkError:Z

    if-eqz v6, :cond_4

    const-string v6, "lgt_hdr_network_error"

    invoke-static {v6}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_4
    iget-boolean v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLTEAuthError:Z

    if-eqz v6, :cond_5

    const-string v6, "lgt_hdr_network_error"

    invoke-static {v6}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_5
    iget-boolean v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLTEEMMReject:Z

    if-eqz v6, :cond_0

    iget v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNum:I

    const/4 v7, 0x5

    if-eq v6, v7, :cond_6

    iget v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNum:I

    const/4 v7, 0x6

    if-ne v6, v7, :cond_0

    :cond_6
    invoke-static {}, Lcom/android/internal/telephony/kr/KrRegStateNotification;->getLteRejectCauseString()Ljava/lang/String;

    move-result-object v2

    iget-object v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-static {v6, v2, v9}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v5

    .local v5, "toast":Landroid/widget/Toast;
    const/16 v6, 0x50

    invoke-virtual {v5, v6, v8, v8}, Landroid/widget/Toast;->setGravity(III)V

    invoke-virtual {v5}, Landroid/widget/Toast;->show()V

    const/4 v6, 0x0

    const-string v7, "support_usim_compatibility"

    invoke-static {v6, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_9

    const-string v6, "ril.card_operator"

    invoke-static {v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .local v3, "rilCardOperator":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "ril.card_operator = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    const-string v6, "LGU"

    invoke-virtual {v6, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_7

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_8

    :cond_7
    const-string v6, "persist.radio.missing_phone"

    const-string v7, "1"

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v1, Landroid/content/Intent;

    const-string v6, "com.lge.intent.action.LTE_MISSING_PHONE"

    invoke-direct {v1, v6}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v1, "intentMissingPhone":Landroid/content/Intent;
    const-string v6, "rejectCode"

    iget v7, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNum:I

    invoke-virtual {v1, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    sget-object v7, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v6, v1, v7}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    iget-object v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    iget v7, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNum:I

    invoke-static {v6, v7}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->startEmergencyDialerActivity(Landroid/content/Context;I)V

    const-string v6, "send intent LTE_MISSING_PHONE for only U+ or No USIM for USIM_COMPATIBILITY UE by Reject Cause"

    invoke-static {v6}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    .end local v1    # "intentMissingPhone":Landroid/content/Intent;
    .end local v3    # "rilCardOperator":Ljava/lang/String;
    :cond_8
    :goto_1
    const-string v2, ""

    iput-boolean v8, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLTEEMMReject:Z

    iput-boolean v8, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLTEAuthError:Z

    iput-boolean v8, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTHDRNetworkError:Z

    iput-boolean v8, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTUnauthenticated:Z

    iput-boolean v8, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mIsLGTUnregister:Z

    iput v8, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNum:I

    goto/16 :goto_0

    :cond_9
    const-string v6, "persist.radio.missing_phone"

    const-string v7, "1"

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v1, Landroid/content/Intent;

    const-string v6, "com.lge.intent.action.LTE_MISSING_PHONE"

    invoke-direct {v1, v6}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v1    # "intentMissingPhone":Landroid/content/Intent;
    const-string v6, "rejectCode"

    iget v7, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNum:I

    invoke-virtual {v1, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    sget-object v7, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v6, v1, v7}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    iget-object v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    iget v7, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNum:I

    invoke-static {v6, v7}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->startEmergencyDialerActivity(Landroid/content/Context;I)V

    const-string v6, "send intent LTE_MISSING_PHONE for U+ by Reject Cause"

    invoke-static {v6}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_1
.end method

.method public static setSimState(Landroid/content/Context;Lcom/android/internal/telephony/IccCardConstants$State;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "simState"    # Lcom/android/internal/telephony/IccCardConstants$State;

    .prologue
    sput-object p1, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mSimState:Lcom/android/internal/telephony/IccCardConstants$State;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mSimState = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mSimState:Lcom/android/internal/telephony/IccCardConstants$State;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    sget-object v0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mSimState:Lcom/android/internal/telephony/IccCardConstants$State;

    sget-object v1, Lcom/android/internal/telephony/IccCardConstants$State;->READY:Lcom/android/internal/telephony/IccCardConstants$State;

    if-eq v0, v1, :cond_0

    sget-object v0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mSimState:Lcom/android/internal/telephony/IccCardConstants$State;

    sget-object v1, Lcom/android/internal/telephony/IccCardConstants$State;->ABSENT:Lcom/android/internal/telephony/IccCardConstants$State;

    if-ne v0, v1, :cond_1

    :cond_0
    const-string v0, "sim state : ready or absent"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    invoke-static {p0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->checkMissingPhoneAndSendIntentWhenReboot(Landroid/content/Context;)V

    :cond_1
    return-void
.end method

.method private showPopUp(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;

    .prologue
    const/4 v6, 0x0

    invoke-static {}, Lcom/android/internal/telephony/TelephonyUtils;->isFactoryMode()Z

    move-result v2

    if-eqz v2, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v2, "LGU"

    const-string v3, "ril.card_operator"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "not LGU+ USIM : do not show LTE reject notification"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v2

    if-nez v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "showPopUp / message : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", mLockOrderPopup : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderPopup:Landroid/app/AlertDialog;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", mRejectNum : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNum:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderPopup:Landroid/app/AlertDialog;

    if-eqz v2, :cond_4

    iget-boolean v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v2, :cond_3

    const-string v2, "New messageRes close previous popup"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_3
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderPopup:Landroid/app/AlertDialog;

    invoke-virtual {v2}, Landroid/app/AlertDialog;->dismiss()V

    iput-object v6, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderPopup:Landroid/app/AlertDialog;

    :cond_4
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderPopup:Landroid/app/AlertDialog;

    if-nez v2, :cond_0

    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v0, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .local v0, "ad":Landroid/app/AlertDialog$Builder;
    const-string v2, "showPopUp / new AlertDialog.Builder"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    const-string v2, "showPopUp / setMessage"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    const-string v2, "telephony_dialog_ok_button"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher$2;

    invoke-direct {v3, p0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher$2;-><init>(Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    const-string v2, "showPopUp / setNeutralButton"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v2

    iput-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderPopup:Landroid/app/AlertDialog;

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderPopup:Landroid/app/AlertDialog;

    invoke-virtual {v2}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    const/16 v3, 0x7d8

    invoke-virtual {v2, v3}, Landroid/view/Window;->setType(I)V

    if-eqz p2, :cond_0

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    const-string v3, "notification"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/NotificationManager;

    .local v1, "notificationManager":Landroid/app/NotificationManager;
    new-instance v2, Landroid/app/Notification$BigTextStyle;

    new-instance v3, Landroid/app/Notification$Builder;

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v3, p1}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v3

    const v4, 0x108008a

    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v3

    const-wide/16 v4, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/app/Notification$Builder;->setWhen(J)Landroid/app/Notification$Builder;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/app/Notification$BigTextStyle;-><init>(Landroid/app/Notification$Builder;)V

    invoke-virtual {v2, p2}, Landroid/app/Notification$BigTextStyle;->bigText(Ljava/lang/CharSequence;)Landroid/app/Notification$BigTextStyle;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Notification$BigTextStyle;->build()Landroid/app/Notification;

    move-result-object v2

    iput-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNotification:Landroid/app/Notification;

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNotification:Landroid/app/Notification;

    const/16 v3, 0x20

    iput v3, v2, Landroid/app/Notification;->flags:I

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNotification:Landroid/app/Notification;

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    const-string v4, "UPLUS_ROAMING_FAIL_NOTIFICATION_TITLE"

    invoke-static {v4}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4, p2, v6}, Landroid/app/Notification;->setLatestEventInfo(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Landroid/app/PendingIntent;)V

    const v2, 0xc73b

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mRejectNotification:Landroid/app/Notification;

    invoke-virtual {v1, v2, v3}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "reject cause notification msg : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method private static startEmergencyDialerActivity(Landroid/content/Context;I)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "rejectCode"    # I

    .prologue
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.android.phone.EmergencyDialer.DIAL"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "rejectCode"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    if-eqz v0, :cond_0

    const/high16 v1, 0x10800000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    sget-object v1, Landroid/os/UserHandle;->CURRENT:Landroid/os/UserHandle;

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->startActivityAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    :cond_0
    return-void
.end method

.method public static toLteRejectCauseString(II)Ljava/lang/String;
    .locals 3
    .param p0, "rejectNum"    # I
    .param p1, "esmRejectNum"    # I

    .prologue
    if-gtz p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    sparse-switch p0, :sswitch_data_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "lgu_lteemmreject"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "message":Ljava/lang/String;
    goto :goto_0

    .end local v0    # "message":Ljava/lang/String;
    :sswitch_0
    const-string v0, ""

    .restart local v0    # "message":Ljava/lang/String;
    goto :goto_0

    .end local v0    # "message":Ljava/lang/String;
    :sswitch_1
    const/16 v1, 0x8

    if-ne p1, v1, :cond_1

    const-string v1, "lgu_lteemmreject_19_8"

    invoke-static {v1}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .restart local v0    # "message":Ljava/lang/String;
    goto :goto_0

    .end local v0    # "message":Ljava/lang/String;
    :cond_1
    const-string v0, ""

    .restart local v0    # "message":Ljava/lang/String;
    goto :goto_0

    .end local v0    # "message":Ljava/lang/String;
    :sswitch_2
    const-string v1, "lgt_unauthenticated"

    invoke-static {v1}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .restart local v0    # "message":Ljava/lang/String;
    goto :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0xa -> :sswitch_0
        0xc -> :sswitch_0
        0xf -> :sswitch_0
        0x13 -> :sswitch_1
        0x16 -> :sswitch_0
        0x54 -> :sswitch_2
        0x5f -> :sswitch_0
        0x60 -> :sswitch_0
        0x61 -> :sswitch_0
        0x63 -> :sswitch_0
        0x6f -> :sswitch_0
    .end sparse-switch
.end method

.method public static toLteRejectCauseStringforRoaming(I)Ljava/lang/String;
    .locals 3
    .param p0, "rejectNum"    # I

    .prologue
    if-gtz p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    packed-switch p0, :pswitch_data_0

    :pswitch_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "lgu_network_reject_cause_etc"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "message":Ljava/lang/String;
    goto :goto_0

    .end local v0    # "message":Ljava/lang/String;
    :pswitch_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "lgu_network_reject_cause_service"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .restart local v0    # "message":Ljava/lang/String;
    goto :goto_0

    .end local v0    # "message":Ljava/lang/String;
    :pswitch_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "lgu_network_reject_cause_data"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .restart local v0    # "message":Ljava/lang/String;
    goto :goto_0

    .end local v0    # "message":Ljava/lang/String;
    :pswitch_3
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "lgu_network_reject_cause_temp"

    invoke-static {v2}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .restart local v0    # "message":Ljava/lang/String;
    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_0
        :pswitch_3
        :pswitch_3
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method


# virtual methods
.method public dispose()V
    .locals 1

    .prologue
    const-string v0, "dispose"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    return-void
.end method

.method protected finalize()V
    .locals 2

    .prologue
    const-string v0, "finalized"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mLockOrderReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForOtaSessionFail(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForOtaSessionSuccess(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForLockStateChanged(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForCdmaSidChanged(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForWpbxStateChanged(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForNetworkErrorDisp(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForHdrLock(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForLteLock(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForLteEmmReject(Landroid/os/Handler;)V

    return-void
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    iget-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "New RIL Event Message Received : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_0
    iget v1, p1, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_0

    :cond_1
    :goto_0
    :pswitch_0
    return-void

    :pswitch_1
    iget-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v1, :cond_2

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_LGT_OTA_SESSION_FAIL : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_2
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->handleLgtOtaSessionFail()V

    goto :goto_0

    :pswitch_2
    iget-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v1, :cond_3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_LGT_OTA_SESSION_SUCCESS : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_3
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->handleLgtOtaSessionSuccess(Landroid/os/AsyncResult;)V

    goto :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_3
    iget-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v1, :cond_4

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_LOCK_STATE_CHANGED : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_4
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->handleLockStateChanged(Landroid/os/AsyncResult;)V

    goto :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_4
    iget-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v1, :cond_5

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_LGT_SID_CHANGED : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_5
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->handleLgtSidChanged(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_5
    iget-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v1, :cond_6

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_LGT_WPBX_CHANGED : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_6
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->handleLgtWpbxChanged(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_6
    iget-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v1, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_LGT_ROAMING_UI_TEST_SET_DONE : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :pswitch_7
    iget-boolean v1, p0, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->debugFilter:Z

    if-eqz v1, :cond_7

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_NET_ERR_DISP : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    :cond_7
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->handleLGTNetworkError(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_8
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_LGT_FACTORY_RESET : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :pswitch_9
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_HDR_LOCK : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->handleHdrLock(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_a
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_LTE_LOCK : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->handleLteLock(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_b
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_EMM_REJECT : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->log(Ljava/lang/String;)V

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->handleLteEmmReject(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_6
        :pswitch_0
        :pswitch_0
        :pswitch_7
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_8
        :pswitch_9
        :pswitch_a
        :pswitch_b
    .end packed-switch
.end method
