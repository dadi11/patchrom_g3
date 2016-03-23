.class public Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;
.super Lcom/android/internal/util/StateMachine;
.source "LgeFDHandlerInterfaceImpl.java"

# interfaces
.implements Lcom/android/internal/telephony/lgdata/ILgeFastDormancyHandler;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;,
        Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$IdleState;,
        Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;,
        Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$NetStatMonitor;,
        Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;,
        Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;
    }
.end annotation


# static fields
.field private static final DATA_CONNECTION_ACTIVE_PH_LINK_DORMANT:I = 0x1

.field private static final DATA_CONNECTION_ACTIVE_PH_LINK_INACTIVE:I = 0x0

.field private static final DATA_CONNECTION_ACTIVE_PH_LINK_UP:I = 0x2

.field private static final EVENT_CHECK_NETSTAT:I = 0x18c4b

.field protected static final EVENT_DATA_CONNECTION_ATTACHED:I = 0x42010

.field protected static final EVENT_DATA_CONNECTION_DETACHED:I = 0x42009

.field protected static final EVENT_DATA_STATE_CHANGED:I = 0x42004

.field protected static final EVENT_ICC_CHANGED:I = 0x42021

.field private static final EVENT_INTERNAL_DEFINED:I = 0x18c4a

.field private static final EVENT_OEM_RIL_MESSAGE_GO_DORMANT_RESPONSE:I = 0x18c4d

.field protected static final EVENT_PS_RESTRICT_DISABLED:I = 0x42017

.field protected static final EVENT_PS_RESTRICT_ENABLED:I = 0x42016

.field protected static final EVENT_RADIO_AVAILABLE:I = 0x42001

.field protected static final EVENT_RADIO_OFF_OR_NOT_AVAILABLE:I = 0x42006

.field private static final EVENT_RADIO_TECHNOLOGY_CHANGED:I = 0x18c4c

.field protected static final EVENT_RECORDS_LOADED:I = 0x42002

.field protected static final EVENT_ROAMING_OFF:I = 0x4200c

.field protected static final EVENT_ROAMING_ON:I = 0x4200b

.field private static final EVENT_TETHERTING_STATE_CHANGED:I = 0x18c4e

.field protected static final EVENT_VOICE_CALL_ENDED:I = 0x42008

.field protected static final EVENT_VOICE_CALL_STARTED:I = 0x42007

.field private static final GO_DORMANT_INTERFACE_ALL:Ljava/lang/String; = ""

.field private static final GO_DORMANT_INTERFACE_NAME:Ljava/lang/String; = "rmnet0"

.field private static final INTENT_CHECK_NETSTAT_ALARM:Ljava/lang/String; = "com.android.internal.telephony.ACTION_CHECK_NETSTAT"

.field private static final INTENT_FASTDORMANCYD_CONFIGURE:Ljava/lang/String; = "android.intent.action.ACTION_FD_CONFIGURE"

.field protected static final LISTEN_DATA_CONNECTION_STATE:I = 0x40

.field protected static final LISTEN_NONE:I = 0x0

.field private static final LOG_TAG:Ljava/lang/String; = "LG-FASTDORMANCY"

.field private static final QCRILHOOK_CLASS:Ljava/lang/String; = "com.qualcomm.qcrilhook.QcRilHook"

.field private static final QCRIL_EVT_HOOK_DATA_GO_DORMANT:I = 0x80003

.field private static currentRadioTech:I

.field private static isChangedRt:Z

.field private static oldRadioTech:I

.field private static qcRilHookClassLoader:Ljava/lang/ClassLoader;

.field private static sStatsService:Landroid/net/INetworkStatsService;


# instance fields
.field private DBG:Z

.field private VDBG:Z

.field mAlarm:Landroid/app/AlarmManager;

.field mBIPActivState:Z

.field mCallActivState:Z

.field private mCheckNetStatIntent:Landroid/app/PendingIntent;

.field protected mCi:Lcom/android/internal/telephony/CommandsInterface;

.field protected mContext:Landroid/content/Context;

.field private mDchFachState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;

.field protected mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

.field mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

.field mFDRetryManager:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;

.field mHandler:Landroid/os/Handler;

.field protected mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

.field private mIdleState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$IdleState;

.field mIntentReceiver:Landroid/content/BroadcastReceiver;

.field mIsFDValueChanged:Z

.field protected mIsReady:Z

.field mIsTetheringOn:Z

.field mLastIsDormant:Z

.field mLastIsUMTS:Z

.field mNetStatMonitor:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$NetStatMonitor;

.field protected mP:Lcom/android/internal/telephony/PhoneBase;

.field protected mQcRilGoDormantFunc:Ljava/lang/reflect/Method;

.field protected mQcRilHookObject:Ljava/lang/Object;

.field protected mSst:Lcom/android/internal/telephony/ServiceStateTracker;

.field private final mTeleManager:Landroid/telephony/TelephonyManager;

.field protected mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

.field private mUnknownState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;

.field mfastdormancy_dial:Z

.field pm:Landroid/os/PowerManager;

.field sWakeLock:Landroid/os/PowerManager$WakeLock;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x0

    .line 125
    sput-object v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->qcRilHookClassLoader:Ljava/lang/ClassLoader;

    .line 128
    :try_start_0
    new-instance v1, Ldalvik/system/PathClassLoader;

    const-string v2, "/system/framework/qcrilhook.jar"

    invoke-static {}, Ljava/lang/ClassLoader;->getSystemClassLoader()Ljava/lang/ClassLoader;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Ldalvik/system/PathClassLoader;-><init>(Ljava/lang/String;Ljava/lang/ClassLoader;)V

    sput-object v1, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->qcRilHookClassLoader:Ljava/lang/ClassLoader;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 167
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    sput v4, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->currentRadioTech:I

    .line 168
    sput v4, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->oldRadioTech:I

    .line 169
    sput-boolean v4, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->isChangedRt:Z

    .line 187
    sput-object v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sStatsService:Landroid/net/INetworkStatsService;

    return-void

    .line 130
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_0
    move-exception v0

    .line 131
    .restart local v0    # "e":Ljava/lang/Exception;
    sput-object v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->qcRilHookClassLoader:Ljava/lang/ClassLoader;

    .line 132
    const-string v1, "LG-FASTDORMANCY"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to init qcRilHookClassLoader class (could be not QCT model), exception: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/ServiceStateTracker;Lcom/android/internal/telephony/dataconnection/DcTracker;Lcom/android/internal/telephony/PhoneBase;)V
    .locals 9
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "sst"    # Lcom/android/internal/telephony/ServiceStateTracker;
    .param p4, "dct"    # Lcom/android/internal/telephony/dataconnection/DcTracker;
    .param p5, "p"    # Lcom/android/internal/telephony/PhoneBase;

    .prologue
    .line 735
    const-string v5, "FastDormancy"

    invoke-direct {p0, v5}, Lcom/android/internal/util/StateMachine;-><init>(Ljava/lang/String;)V

    .line 81
    const/4 v5, 0x1

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->DBG:Z

    .line 82
    const/4 v5, 0x1

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->VDBG:Z

    .line 142
    const/4 v5, 0x0

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsReady:Z

    .line 145
    const/4 v5, 0x0

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCheckNetStatIntent:Landroid/app/PendingIntent;

    .line 154
    const/4 v5, 0x0

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mLastIsUMTS:Z

    .line 155
    const/4 v5, 0x1

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mLastIsDormant:Z

    .line 158
    const/4 v5, 0x0

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsFDValueChanged:Z

    .line 165
    const/4 v5, 0x0

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mHandler:Landroid/os/Handler;

    .line 173
    const/4 v5, 0x0

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mfastdormancy_dial:Z

    .line 176
    const/4 v5, 0x0

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCallActivState:Z

    .line 177
    const/4 v5, 0x0

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsTetheringOn:Z

    .line 178
    const/4 v5, 0x0

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mBIPActivState:Z

    .line 184
    const/4 v5, 0x0

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mQcRilHookObject:Ljava/lang/Object;

    .line 185
    const/4 v5, 0x0

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mQcRilGoDormantFunc:Ljava/lang/reflect/Method;

    .line 189
    new-instance v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;

    invoke-direct {v5, p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;-><init>(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)V

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    .line 989
    new-instance v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;

    const/4 v6, 0x0

    invoke-direct {v5, p0, v6}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;-><init>(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;)V

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUnknownState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;

    .line 1078
    new-instance v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$IdleState;

    const/4 v6, 0x0

    invoke-direct {v5, p0, v6}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$IdleState;-><init>(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;)V

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIdleState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$IdleState;

    .line 1321
    new-instance v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;

    const/4 v6, 0x0

    invoke-direct {v5, p0, v6}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;-><init>(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;)V

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mDchFachState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;

    .line 737
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    const-string v6, "missing TelephonyManager"

    invoke-static {v5, v6}, Lcom/android/internal/util/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/telephony/TelephonyManager;

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mTeleManager:Landroid/telephony/TelephonyManager;

    .line 739
    iput-object p1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mContext:Landroid/content/Context;

    .line 740
    iput-object p2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    .line 741
    iput-object p3, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mSst:Lcom/android/internal/telephony/ServiceStateTracker;

    .line 742
    iput-object p4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    .line 743
    iput-object p5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    .line 745
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mContext:Landroid/content/Context;

    const-string v6, "power"

    invoke-virtual {v5, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/os/PowerManager;

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->pm:Landroid/os/PowerManager;

    .line 746
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->pm:Landroid/os/PowerManager;

    const/4 v6, 0x1

    const-string v7, "DataTracker-FD"

    invoke-virtual {v5, v6, v7}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v5

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    .line 747
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    const/4 v6, 0x0

    invoke-virtual {v5, v6}, Landroid/os/PowerManager$WakeLock;->setReferenceCounted(Z)V

    .line 749
    new-instance v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-direct {v5, p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;-><init>(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)V

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    .line 750
    new-instance v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;

    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-direct {v5, p0, v6}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;-><init>(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;)V

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDRetryManager:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;

    .line 751
    new-instance v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$NetStatMonitor;

    invoke-direct {v5, p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$NetStatMonitor;-><init>(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)V

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mNetStatMonitor:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$NetStatMonitor;

    .line 754
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUnknownState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->addState(Lcom/android/internal/util/State;)V

    .line 755
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIdleState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$IdleState;

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->addState(Lcom/android/internal/util/State;)V

    .line 756
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mDchFachState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->addState(Lcom/android/internal/util/State;)V

    .line 757
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUnknownState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->setInitialState(Lcom/android/internal/util/State;)V

    .line 759
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getHandler()Landroid/os/Handler;

    move-result-object v5

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mHandler:Landroid/os/Handler;

    .line 760
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mContext:Landroid/content/Context;

    const-string v6, "alarm"

    invoke-virtual {v5, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/app/AlarmManager;

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mAlarm:Landroid/app/AlarmManager;

    .line 762
    sget-object v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->qcRilHookClassLoader:Ljava/lang/ClassLoader;

    if-eqz v5, :cond_0

    .line 764
    :try_start_0
    sget-object v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->qcRilHookClassLoader:Ljava/lang/ClassLoader;

    const-string v6, "com.qualcomm.qcrilhook.QcRilHook"

    invoke-virtual {v5, v6}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 765
    .local v1, "cl":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Landroid/content/Context;

    aput-object v7, v5, v6

    invoke-virtual {v1, v5}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v0

    .line 766
    .local v0, "c":Ljava/lang/reflect/Constructor;
    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    iget-object v7, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mContext:Landroid/content/Context;

    aput-object v7, v5, v6

    invoke-virtual {v0, v5}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mQcRilHookObject:Ljava/lang/Object;

    .line 767
    const-string v5, "qcRilGoDormant"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Class;

    const/4 v7, 0x0

    const-class v8, Ljava/lang/String;

    aput-object v8, v6, v7

    invoke-virtual {v1, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mQcRilGoDormantFunc:Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 775
    .end local v0    # "c":Ljava/lang/reflect/Constructor;
    .end local v1    # "cl":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_0
    :goto_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->start()V

    .line 776
    const/4 v5, 0x1

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsReady:Z

    .line 782
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mHandler:Landroid/os/Handler;

    const v7, 0x42004

    const/4 v8, 0x0

    invoke-interface {v5, v6, v7, v8}, Lcom/android/internal/telephony/CommandsInterface;->registerForDataNetworkStateChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 795
    invoke-static {}, Lcom/android/internal/telephony/uicc/UiccController;->getInstance()Lcom/android/internal/telephony/uicc/UiccController;

    move-result-object v5

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    .line 796
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mHandler:Landroid/os/Handler;

    const v7, 0x42021

    const/4 v8, 0x0

    invoke-virtual {v5, v6, v7, v8}, Lcom/android/internal/telephony/uicc/UiccController;->registerForIccChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 801
    :try_start_1
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    if-eqz v5, :cond_1

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v5}, Lcom/android/internal/telephony/PhoneBase;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v5

    if-eqz v5, :cond_1

    .line 802
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v5}, Lcom/android/internal/telephony/PhoneBase;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mHandler:Landroid/os/Handler;

    const v7, 0x42007

    const/4 v8, 0x0

    invoke-virtual {v5, v6, v7, v8}, Lcom/android/internal/telephony/CallTracker;->registerForVoiceCallStarted(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 803
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v5}, Lcom/android/internal/telephony/PhoneBase;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mHandler:Landroid/os/Handler;

    const v7, 0x42008

    const/4 v8, 0x0

    invoke-virtual {v5, v6, v7, v8}, Lcom/android/internal/telephony/CallTracker;->registerForVoiceCallEnded(Landroid/os/Handler;ILjava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 810
    :cond_1
    :goto_1
    new-instance v4, Landroid/content/IntentFilter;

    invoke-direct {v4}, Landroid/content/IntentFilter;-><init>()V

    .line 811
    .local v4, "filter":Landroid/content/IntentFilter;
    const-string v5, "android.intent.action.SCREEN_ON"

    invoke-virtual {v4, v5}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 812
    const-string v5, "android.intent.action.SCREEN_OFF"

    invoke-virtual {v4, v5}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 813
    const-string v5, "com.android.internal.telephony.ACTION_CHECK_NETSTAT"

    invoke-virtual {v4, v5}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 814
    const-string v5, "android.intent.action.SERVICE_STATE"

    invoke-virtual {v4, v5}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 816
    const-string v5, "com.lge.ACTION_FD_TRIGGER_TIME_VAL_CHANGED"

    invoke-virtual {v4, v5}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 818
    const-string v5, "android.net.conn.TETHER_STATE_CHANGED"

    invoke-virtual {v4, v5}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 819
    const-string v5, "android.intent.action.ACTION_FD_CONFIGURE"

    invoke-virtual {v4, v5}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 820
    const-string v5, "com.lge.intent.action.BIP_EVENT"

    invoke-virtual {v4, v5}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 823
    const-string v5, "com.fd.go"

    invoke-virtual {v4, v5}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 825
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mContext:Landroid/content/Context;

    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v5, v6, v4}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 829
    const-string v5, "Fast Dormancy Logic is ready."

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 831
    return-void

    .line 768
    .end local v4    # "filter":Landroid/content/IntentFilter;
    :catch_0
    move-exception v2

    .line 769
    .local v2, "e":Ljava/lang/Exception;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Failed to load QCRILHOOK_CLASS() class, exception: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->loge(Ljava/lang/String;)V

    .line 770
    const/4 v5, 0x0

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mQcRilHookObject:Ljava/lang/Object;

    .line 771
    const/4 v5, 0x0

    iput-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mQcRilGoDormantFunc:Ljava/lang/reflect/Method;

    goto/16 :goto_0

    .line 805
    .end local v2    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v3

    .line 806
    .local v3, "ex":Ljava/lang/Exception;
    const-string v5, "LG-FASTDORMANCY"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "exception = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method static synthetic access$000()I
    .locals 1

    .prologue
    .line 78
    sget v0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->currentRadioTech:I

    return v0
.end method

.method static synthetic access$002(I)I
    .locals 0
    .param p0, "x0"    # I

    .prologue
    .line 78
    sput p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->currentRadioTech:I

    return p0
.end method

.method static synthetic access$100()I
    .locals 1

    .prologue
    .line 78
    sget v0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->oldRadioTech:I

    return v0
.end method

.method static synthetic access$1000(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 78
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$102(I)I
    .locals 0
    .param p0, "x0"    # I

    .prologue
    .line 78
    sput p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->oldRadioTech:I

    return p0
.end method

.method static synthetic access$1200(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 78
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$1300(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 78
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$1500(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 78
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$1600(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/util/IState;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;
    .param p1, "x1"    # Lcom/android/internal/util/IState;

    .prologue
    .line 78
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V

    return-void
.end method

.method static synthetic access$200()Z
    .locals 1

    .prologue
    .line 78
    sget-boolean v0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->isChangedRt:Z

    return v0
.end method

.method static synthetic access$202(Z)Z
    .locals 0
    .param p0, "x0"    # Z

    .prologue
    .line 78
    sput-boolean p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->isChangedRt:Z

    return p0
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    .prologue
    .line 78
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mDchFachState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;

    return-object v0
.end method

.method static synthetic access$500(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    .prologue
    .line 78
    iget-boolean v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->DBG:Z

    return v0
.end method

.method static synthetic access$502(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;
    .param p1, "x1"    # Z

    .prologue
    .line 78
    iput-boolean p1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->DBG:Z

    return p1
.end method

.method static synthetic access$600(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    .prologue
    .line 78
    iget-boolean v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->VDBG:Z

    return v0
.end method

.method static synthetic access$602(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;
    .param p1, "x1"    # Z

    .prologue
    .line 78
    iput-boolean p1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->VDBG:Z

    return p1
.end method

.method static synthetic access$700(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)Lcom/android/internal/util/IState;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    .prologue
    .line 78
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$800(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    .prologue
    .line 78
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUnknownState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;

    return-object v0
.end method

.method static synthetic access$900()Landroid/net/INetworkStatsService;
    .locals 1

    .prologue
    .line 78
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sStatsService:Landroid/net/INetworkStatsService;

    return-object v0
.end method

.method static synthetic access$902(Landroid/net/INetworkStatsService;)Landroid/net/INetworkStatsService;
    .locals 0
    .param p0, "x0"    # Landroid/net/INetworkStatsService;

    .prologue
    .line 78
    sput-object p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sStatsService:Landroid/net/INetworkStatsService;

    return-object p0
.end method

.method private playRingTone(I)V
    .locals 8
    .param p1, "sound_type"    # I

    .prologue
    const/4 v7, 0x0

    .line 1624
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->getIsDebugMode()Z

    move-result v5

    if-nez v5, :cond_1

    .line 1644
    :cond_0
    :goto_0
    return-void

    .line 1627
    :cond_1
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "FD_playRingTone with "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " Sound_type"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1629
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mContext:Landroid/content/Context;

    const-string v6, "audio"

    invoke-virtual {v5, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/media/AudioManager;

    .line 1630
    .local v1, "mAudioManager":Landroid/media/AudioManager;
    const/4 v5, 0x2

    const/4 v6, -0x1

    invoke-virtual {v1, v7, v5, v6}, Landroid/media/AudioManager;->setRouting(III)V

    .line 1632
    const/4 v0, 0x4

    .line 1633
    .local v0, "StreamType":I
    invoke-virtual {v1, v0}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result v4

    .line 1634
    .local v4, "volume":I
    invoke-virtual {v1, v0, v4, v7}, Landroid/media/AudioManager;->setStreamVolume(III)V

    .line 1636
    new-instance v2, Landroid/media/RingtoneManager;

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mContext:Landroid/content/Context;

    invoke-direct {v2, v5}, Landroid/media/RingtoneManager;-><init>(Landroid/content/Context;)V

    .line 1637
    .local v2, "mRingtoneManager":Landroid/media/RingtoneManager;
    const/4 v5, 0x4

    invoke-virtual {v2, v5}, Landroid/media/RingtoneManager;->setType(I)V

    .line 1638
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mContext:Landroid/content/Context;

    invoke-virtual {v2, p1}, Landroid/media/RingtoneManager;->getRingtoneUri(I)Landroid/net/Uri;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/media/RingtoneManager;->getRingtone(Landroid/content/Context;Landroid/net/Uri;)Landroid/media/Ringtone;

    move-result-object v3

    .line 1640
    .local v3, "ringtone":Landroid/media/Ringtone;
    if-eqz v3, :cond_0

    .line 1641
    invoke-virtual {v3, v0}, Landroid/media/Ringtone;->setStreamType(I)V

    .line 1642
    invoke-virtual {v3}, Landroid/media/Ringtone;->play()V

    goto :goto_0
.end method


# virtual methods
.method public dispose()V
    .locals 2

    .prologue
    .line 836
    const-string v0, "LgeFDHandlerInterfaceImpl.dispose."

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 838
    iget-boolean v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsReady:Z

    if-eqz v0, :cond_2

    .line 839
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsReady:Z

    .line 844
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mHandler:Landroid/os/Handler;

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForDataNetworkStateChanged(Landroid/os/Handler;)V

    .line 857
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

    if-eqz v0, :cond_0

    .line 858
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/uicc/IccRecords;->unregisterForRecordsLoaded(Landroid/os/Handler;)V

    .line 860
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/uicc/UiccController;->unregisterForIccChanged(Landroid/os/Handler;)V

    .line 862
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 864
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 866
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->release()V

    .line 869
    :cond_1
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->quit()V

    .line 873
    :cond_2
    return-void
.end method

.method protected getUiccCardApplication()Lcom/android/internal/telephony/uicc/IccRecords;
    .locals 3

    .prologue
    .line 1438
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 1439
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v1

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/uicc/UiccController;->getIccRecords(II)Lcom/android/internal/telephony/uicc/IccRecords;

    move-result-object v0

    goto :goto_0
.end method

.method protected isUMTS()Z
    .locals 4

    .prologue
    const/4 v1, 0x1

    .line 1371
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v2

    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getNetworkType()I

    move-result v0

    .line 1373
    .local v0, "tech":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isUMTS(): RadioTech("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1375
    sparse-switch v0, :sswitch_data_0

    .line 1384
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v2

    const/4 v3, 0x2

    if-ne v2, v3, :cond_0

    const/16 v2, 0xe

    if-ne v0, v2, :cond_0

    .line 1388
    :goto_0
    :sswitch_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0

    .line 1375
    :sswitch_data_0
    .sparse-switch
        0x3 -> :sswitch_0
        0x8 -> :sswitch_0
        0x9 -> :sswitch_0
        0xa -> :sswitch_0
        0xf -> :sswitch_0
    .end sparse-switch
.end method

.method protected logd(Ljava/lang/String;)V
    .locals 4
    .param p1, "string"    # Ljava/lang/String;

    .prologue
    .line 1575
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->DBG:Z

    if-eqz v1, :cond_0

    .line 1576
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsReady:Z

    if-eqz v1, :cond_1

    .line 1578
    :try_start_0
    const-string v1, "LG-FASTDORMANCY"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1587
    :cond_0
    :goto_0
    return-void

    .line 1580
    :catch_0
    move-exception v0

    .line 1581
    .local v0, "oobe":Ljava/lang/ArrayIndexOutOfBoundsException;
    const-string v1, "LG-FASTDORMANCY"

    invoke-static {v1, p1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1584
    .end local v0    # "oobe":Ljava/lang/ArrayIndexOutOfBoundsException;
    :cond_1
    const-string v1, "LG-FASTDORMANCY"

    invoke-static {v1, p1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method protected loge(Ljava/lang/String;)V
    .locals 4
    .param p1, "string"    # Ljava/lang/String;

    .prologue
    .line 1543
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->VDBG:Z

    if-eqz v1, :cond_0

    .line 1544
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsReady:Z

    if-eqz v1, :cond_1

    .line 1546
    :try_start_0
    const-string v1, "LG-FASTDORMANCY"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1555
    :cond_0
    :goto_0
    return-void

    .line 1548
    :catch_0
    move-exception v0

    .line 1549
    .local v0, "oobe":Ljava/lang/ArrayIndexOutOfBoundsException;
    const-string v1, "LG-FASTDORMANCY"

    invoke-static {v1, p1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1552
    .end local v0    # "oobe":Ljava/lang/ArrayIndexOutOfBoundsException;
    :cond_1
    const-string v1, "LG-FASTDORMANCY"

    invoke-static {v1, p1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method protected logi(Ljava/lang/String;)V
    .locals 4
    .param p1, "string"    # Ljava/lang/String;

    .prologue
    .line 1607
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->VDBG:Z

    if-eqz v1, :cond_0

    .line 1608
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsReady:Z

    if-eqz v1, :cond_1

    .line 1610
    :try_start_0
    const-string v1, "LG-FASTDORMANCY"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1619
    :cond_0
    :goto_0
    return-void

    .line 1612
    :catch_0
    move-exception v0

    .line 1613
    .local v0, "oobe":Ljava/lang/ArrayIndexOutOfBoundsException;
    const-string v1, "LG-FASTDORMANCY"

    invoke-static {v1, p1}, Landroid/telephony/Rlog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1616
    .end local v0    # "oobe":Ljava/lang/ArrayIndexOutOfBoundsException;
    :cond_1
    const-string v1, "LG-FASTDORMANCY"

    invoke-static {v1, p1}, Landroid/telephony/Rlog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method protected logv(Ljava/lang/String;)V
    .locals 4
    .param p1, "string"    # Ljava/lang/String;

    .prologue
    .line 1591
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->VDBG:Z

    if-eqz v1, :cond_0

    .line 1592
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsReady:Z

    if-eqz v1, :cond_1

    .line 1594
    :try_start_0
    const-string v1, "LG-FASTDORMANCY"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->v(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1603
    :cond_0
    :goto_0
    return-void

    .line 1596
    :catch_0
    move-exception v0

    .line 1597
    .local v0, "oobe":Ljava/lang/ArrayIndexOutOfBoundsException;
    const-string v1, "LG-FASTDORMANCY"

    invoke-static {v1, p1}, Landroid/telephony/Rlog;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1600
    .end local v0    # "oobe":Ljava/lang/ArrayIndexOutOfBoundsException;
    :cond_1
    const-string v1, "LG-FASTDORMANCY"

    invoke-static {v1, p1}, Landroid/telephony/Rlog;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method protected logw(Ljava/lang/String;)V
    .locals 4
    .param p1, "string"    # Ljava/lang/String;

    .prologue
    .line 1559
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->VDBG:Z

    if-eqz v1, :cond_0

    .line 1560
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsReady:Z

    if-eqz v1, :cond_1

    .line 1562
    :try_start_0
    const-string v1, "LG-FASTDORMANCY"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1571
    :cond_0
    :goto_0
    return-void

    .line 1564
    :catch_0
    move-exception v0

    .line 1565
    .local v0, "oobe":Ljava/lang/ArrayIndexOutOfBoundsException;
    const-string v1, "LG-FASTDORMANCY"

    invoke-static {v1, p1}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1568
    .end local v0    # "oobe":Ljava/lang/ArrayIndexOutOfBoundsException;
    :cond_1
    const-string v1, "LG-FASTDORMANCY"

    invoke-static {v1, p1}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method protected onCallActiveStateChanged(Z)V
    .locals 2
    .param p1, "activState"    # Z

    .prologue
    .line 1530
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onCallActiveStateChanged : Voice call is "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/4 v0, 0x1

    if-ne p1, v0, :cond_0

    const-string v0, "started"

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1531
    iput-boolean p1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCallActivState:Z

    .line 1532
    return-void

    .line 1530
    :cond_0
    const-string v0, "ended"

    goto :goto_0
.end method

.method protected onDataCallListChanged(Landroid/os/AsyncResult;)V
    .locals 6
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const/4 v5, 0x1

    .line 1475
    iget-object v3, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v3, Ljava/util/ArrayList;

    move-object v0, v3

    check-cast v0, Ljava/util/ArrayList;

    .line 1477
    .local v0, "dcStates":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/dataconnection/DataCallResponse;>;"
    iget-object v3, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v3, :cond_1

    .line 1523
    :cond_0
    :goto_0
    return-void

    .line 1484
    :cond_1
    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mLastIsDormant:Z

    .line 1487
    sget-object v3, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v3}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 1488
    invoke-virtual {v0}, Ljava/util/ArrayList;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1492
    :cond_2
    const/4 v1, 0x0

    .local v1, "i":I
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "s":I
    :goto_1
    if-ge v1, v2, :cond_3

    .line 1494
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/internal/telephony/dataconnection/DataCallResponse;

    iget v3, v3, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->active:I

    const/4 v4, 0x2

    if-ne v3, v4, :cond_4

    .line 1495
    const/4 v3, 0x0

    iput-boolean v3, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mLastIsDormant:Z

    .line 1499
    :cond_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "prev:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", curr:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-boolean v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mLastIsDormant:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1500
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->isUMTS()Z

    move-result v3

    if-nez v3, :cond_5

    .line 1501
    const-string v3, "onDataCallListChanged(): reset all logic since the attached network is non-3G"

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    goto :goto_0

    .line 1492
    :cond_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 1506
    :cond_5
    iget-boolean v3, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mLastIsDormant:Z

    if-ne v3, v5, :cond_6

    .line 1507
    const/4 v3, 0x4

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->playRingTone(I)V

    .line 1510
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIdleState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$IdleState;

    if-eq v3, v4, :cond_0

    .line 1511
    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIdleState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$IdleState;

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V

    goto :goto_0

    .line 1515
    :cond_6
    const/4 v3, 0x3

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->playRingTone(I)V

    .line 1518
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mDchFachState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;

    if-eq v3, v4, :cond_0

    .line 1519
    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mDchFachState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V

    goto/16 :goto_0
.end method

.method protected onGoDormantReponse(Landroid/os/AsyncResult;)V
    .locals 2
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    .line 1526
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GoDormantResult"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logv(Ljava/lang/String;)V

    .line 1527
    return-void
.end method

.method protected onRadioTechnologyChanged()V
    .locals 3

    .prologue
    .line 1414
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->isUMTS()Z

    move-result v0

    .line 1416
    .local v0, "newIsUMTS":Z
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mLastIsUMTS:Z

    if-eq v1, v0, :cond_1

    .line 1418
    sget-boolean v1, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->isChangedRt:Z

    if-eqz v1, :cond_0

    sget v1, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->currentRadioTech:I

    const/16 v2, 0xd

    if-ne v1, v2, :cond_0

    .line 1419
    const-string v1, "change RT!! load DB setting!!"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1420
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->onRecordsLoaded()V

    .line 1423
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUnknownState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V

    .line 1424
    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mLastIsUMTS:Z

    .line 1426
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mLastIsUMTS:Z

    if-eqz v1, :cond_1

    .line 1427
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mLastIsDormant:Z

    if-nez v1, :cond_2

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mDchFachState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;

    if-eq v1, v2, :cond_2

    .line 1428
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mDchFachState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V

    .line 1435
    :cond_1
    :goto_0
    return-void

    .line 1429
    :cond_2
    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mLastIsDormant:Z

    const/4 v2, 0x1

    if-ne v1, v2, :cond_1

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIdleState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$IdleState;

    if-eq v1, v2, :cond_1

    .line 1430
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIdleState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$IdleState;

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V

    goto :goto_0
.end method

.method protected onRecordsLoaded()V
    .locals 1

    .prologue
    .line 1464
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->loadSettingFromDb()V

    .line 1466
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->getIsActive()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1467
    const-string v0, "Fast Dormancy is disabled."

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1468
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->dispose()V

    .line 1469
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->quit()V

    .line 1471
    :cond_0
    return-void
.end method

.method resetAll()V
    .locals 2

    .prologue
    .line 1362
    const-string v0, "resetAll()"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1364
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mAlarm:Landroid/app/AlarmManager;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCheckNetStatIntent:Landroid/app/PendingIntent;

    invoke-virtual {v0, v1}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 1365
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mNetStatMonitor:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$NetStatMonitor;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$NetStatMonitor;->checkNetStat()Z

    .line 1366
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDRetryManager:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;->resetCount()V

    .line 1367
    return-void
.end method

.method scheduleCheckNetStat()V
    .locals 8

    .prologue
    const/4 v5, 0x0

    const v6, 0x18c4b

    .line 1332
    const/4 v1, 0x1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->playRingTone(I)V

    .line 1334
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isPausingFD()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1335
    const-string v1, "Scheduling checkNetStat:mIsFdPause is true, discard sending event for FD-Triggering"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1357
    :goto_0
    return-void

    .line 1339
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->getDataTransferCheckTimerValue()J

    move-result-wide v2

    .line 1341
    .local v2, "interval":J
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Scheduling checkNetStat for "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "msec, current state is "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1343
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getCurrentState()Lcom/android/internal/util/IState;

    move-result-object v1

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUnknownState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;

    if-eq v1, v4, :cond_1

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isPreventWhenCalling()Z

    move-result v1

    if-eqz v1, :cond_3

    iget-boolean v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCallActivState:Z

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isScreenOn()Z

    move-result v1

    if-nez v1, :cond_3

    .line 1345
    :cond_1
    const-string v1, "Scheduling checkNetStat: sendMessageDelayed"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1346
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1, v6}, Landroid/os/Handler;->hasMessages(I)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1347
    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->removeMessages(I)V

    .line 1349
    :cond_2
    const-wide/16 v4, 0x3e8

    invoke-virtual {p0, v6, v4, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sendMessageDelayed(IJ)V

    goto :goto_0

    .line 1351
    :cond_3
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.android.internal.telephony.ACTION_CHECK_NETSTAT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1352
    .local v0, "intent":Landroid/content/Intent;
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mContext:Landroid/content/Context;

    invoke-static {v1, v5, v0, v5}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCheckNetStatIntent:Landroid/app/PendingIntent;

    .line 1354
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mAlarm:Landroid/app/AlarmManager;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCheckNetStatIntent:Landroid/app/PendingIntent;

    invoke-virtual {v1, v4}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 1355
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mAlarm:Landroid/app/AlarmManager;

    const/4 v4, 0x2

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    add-long/2addr v6, v2

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCheckNetStatIntent:Landroid/app/PendingIntent;

    invoke-virtual {v1, v4, v6, v7, v5}, Landroid/app/AlarmManager;->setExact(IJLandroid/app/PendingIntent;)V

    goto/16 :goto_0
.end method

.method public updateIccAvailability()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1443
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    if-nez v1, :cond_1

    .line 1461
    :cond_0
    :goto_0
    return-void

    .line 1447
    :cond_1
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->getUiccCardApplication()Lcom/android/internal/telephony/uicc/IccRecords;

    move-result-object v0

    .line 1449
    .local v0, "newIccRecords":Lcom/android/internal/telephony/uicc/IccRecords;
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

    if-eq v1, v0, :cond_0

    .line 1450
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

    if-eqz v1, :cond_2

    .line 1451
    const-string v1, "Removing stale icc objects."

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1452
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mHandler:Landroid/os/Handler;

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/uicc/IccRecords;->unregisterForRecordsLoaded(Landroid/os/Handler;)V

    .line 1453
    iput-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

    .line 1455
    :cond_2
    if-eqz v0, :cond_0

    .line 1456
    const-string v1, "New records found"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1457
    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

    .line 1458
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mHandler:Landroid/os/Handler;

    const v3, 0x42002

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/internal/telephony/uicc/IccRecords;->registerForRecordsLoaded(Landroid/os/Handler;ILjava/lang/Object;)V

    goto :goto_0
.end method
