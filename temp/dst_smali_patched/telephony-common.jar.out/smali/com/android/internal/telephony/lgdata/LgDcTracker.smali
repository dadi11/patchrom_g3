.class public Lcom/android/internal/telephony/lgdata/LgDcTracker;
.super Landroid/os/Handler;
.source "LgDcTracker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/lgdata/LgDcTracker$2;,
        Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;,
        Lcom/android/internal/telephony/lgdata/LgDcTracker$IPVersion;
    }
.end annotation


# static fields
.field public static final ACTION_GW_ROAMING_DATA_CONNECTION_LGU:Ljava/lang/String; = "lge.intent.action.GW_ROAMING_DATA_CONNECTION_LGU"

.field public static final ACTION_LTE_ROAMING_DATA_CONNECTION_LGU:Ljava/lang/String; = "lge.intent.action.LTE_ROAMING_DATA_CONNECTION_LGU"

.field static final ApplyToprotectionVoiceInMobie:I = 0x1

.field public static final DATA_LTE_ROAMING:Ljava/lang/String; = "data_lte_roaming"

.field private static final LOG_TAG:Ljava/lang/String; = "[LGE_DATA][LGDCT] "

.field public static final sConnectionStatus:Ljava/lang/String; = "Connection_Status"

.field private static setTeardownRequested:[Z

.field private static voice_call_ing:Z


# instance fields
.field protected APN_ID_FOR_IMS:I

.field protected APN_ID_FOR_LTE_Roaming:I

.field public bConnectionStatus:Z

.field protected exist_ims_type_in_mpdn:Z

.field isGsm:Z

.field protected mConnMgr:Landroid/net/ConnectivityManager;

.field private mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

.field mGsst:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

.field protected mIccRecords:Ljava/util/concurrent/atomic/AtomicReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/atomic/AtomicReference",
            "<",
            "Lcom/android/internal/telephony/uicc/IccRecords;",
            ">;"
        }
    .end annotation
.end field

.field protected mIntentReceiver:Landroid/content/BroadcastReceiver;

.field private final mLTEDataRoamingSettingObserver:Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;

.field private mNotification:Landroid/app/Notification;

.field private mPhone:Lcom/android/internal/telephony/PhoneBase;

.field protected mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

.field final notificationId:I

.field private notification_intent:Landroid/content/Intent;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-boolean v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->voice_call_ing:Z

    const/16 v0, 0x18

    new-array v0, v0, [Z

    sput-object v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->setTeardownRequested:[Z

    return-void
.end method

.method public constructor <init>(Lcom/android/internal/telephony/dataconnection/DcTrackerBase;Lcom/android/internal/telephony/PhoneBase;)V
    .locals 12
    .param p1, "mmdct"    # Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    .param p2, "p"    # Lcom/android/internal/telephony/PhoneBase;

    .prologue
    const/4 v11, 0x5

    const/4 v10, 0x2

    const/4 v5, 0x1

    const/4 v9, 0x0

    const/4 v6, 0x0

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    iput-boolean v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->exist_ims_type_in_mpdn:Z

    new-instance v4, Ljava/util/concurrent/atomic/AtomicReference;

    invoke-direct {v4}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V

    iput-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mIccRecords:Ljava/util/concurrent/atomic/AtomicReference;

    iput v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->APN_ID_FOR_LTE_Roaming:I

    iput v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->APN_ID_FOR_IMS:I

    iput-boolean v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->bConnectionStatus:Z

    const/16 v4, 0x9f6

    iput v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notificationId:I

    new-instance v4, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;

    invoke-direct {v4, p0}, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;-><init>(Lcom/android/internal/telephony/lgdata/LgDcTracker;)V

    iput-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    new-instance v4, Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;

    iget-object v7, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-direct {v4, p0, v7}, Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;-><init>(Lcom/android/internal/telephony/lgdata/LgDcTracker;Landroid/os/Handler;)V

    iput-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mLTEDataRoamingSettingObserver:Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;

    const-string v4, "[LGE_DATA][LGDCT] "

    const-string v7, "LgDcTracker() has created"

    invoke-static {v4, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-object p1, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iput-object p2, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v4

    if-eq v4, v11, :cond_0

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v4

    const/4 v7, 0x6

    if-eq v4, v7, :cond_0

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v4

    if-eq v4, v10, :cond_0

    const-string v4, "[LGE_DATA][LGDCT] "

    const-string v5, "other country do not use this function. so return."

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    new-instance v1, Landroid/content/IntentFilter;

    invoke-direct {v1}, Landroid/content/IntentFilter;-><init>()V

    .local v1, "filter":Landroid/content/IntentFilter;
    const-string v4, "android.intent.action.SCREEN_ON"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "lge.test.limit_data_usage"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "com.skt.CALL_PROTECTION_STATUS_CHANGED"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "com.skt.CALL_PROTECTION_MENU_OFF"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "com.skt.CALL_PROTECTION_MENU_ON"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "com.skt.test_intent"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "com.kt.CALL_PROTECTION_CALL_START"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "com.kt.CALL_PROTECTION_MENU_OFF"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "com.kt.CALL_PROTECTION_MENU_ON"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "com.lge.GprsAttachedIsTrue"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "android.intent.action.ANY_DATA_STATE"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "android.intent.action.DATA_CONNECTION_FAILED"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "lge.android.telephony.dataflow"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "ACTIVATE_SETUP_DATA_CALL"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "lge.test.routetable.add"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "lge.test.routetable.delete"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v4, "com.lge.callingsetmobile"

    invoke-virtual {v1, v4}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v4, p2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const v7, 0x42001

    invoke-interface {v4, p0, v7, v9}, Lcom/android/internal/telephony/CommandsInterface;->registerForAvailable(Landroid/os/Handler;ILjava/lang/Object;)V

    invoke-virtual {p2}, Lcom/android/internal/telephony/PhoneBase;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v4

    if-eqz v4, :cond_1

    invoke-virtual {p2}, Lcom/android/internal/telephony/PhoneBase;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v4

    const v7, 0x4280c

    invoke-virtual {v4, p0, v7, v9}, Lcom/android/internal/telephony/ServiceStateTracker;->registerForNetworkAttached(Landroid/os/Handler;ILjava/lang/Object;)V

    :cond_1
    iget-object v4, p2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const v7, 0x42004

    invoke-interface {v4, p0, v7, v9}, Lcom/android/internal/telephony/CommandsInterface;->registerForDataNetworkStateChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    invoke-virtual {p2}, Lcom/android/internal/telephony/PhoneBase;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v4

    if-eqz v4, :cond_2

    invoke-virtual {p2}, Lcom/android/internal/telephony/PhoneBase;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v4

    const v7, 0x42008

    invoke-virtual {v4, p0, v7, v9}, Lcom/android/internal/telephony/CallTracker;->registerForVoiceCallEnded(Landroid/os/Handler;ILjava/lang/Object;)V

    invoke-virtual {p2}, Lcom/android/internal/telephony/PhoneBase;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v4

    const v7, 0x42007

    invoke-virtual {v4, p0, v7, v9}, Lcom/android/internal/telephony/CallTracker;->registerForVoiceCallStarted(Landroid/os/Handler;ILjava/lang/Object;)V

    :cond_2
    const v4, 0x42816

    invoke-virtual {p1, p0, v4, v9}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->registerForDataConnectEvent(Landroid/os/Handler;ILjava/lang/Object;)V

    invoke-static {}, Lcom/android/internal/telephony/uicc/UiccController;->getInstance()Lcom/android/internal/telephony/uicc/UiccController;

    move-result-object v4

    iput-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    const v7, 0x42021

    invoke-virtual {v4, p0, v7, v9}, Lcom/android/internal/telephony/uicc/UiccController;->registerForIccChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v4

    iget-object v7, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4, v7, v1, v9, v8}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v4

    const-string v7, "connectivity"

    invoke-virtual {v4, v7}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/net/ConnectivityManager;

    iput-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mConnMgr:Landroid/net/ConnectivityManager;

    sget-object v4, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VOICE_PROTECTION_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v4

    if-ne v4, v5, :cond_3

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v4, v4, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const v7, 0x4280f

    invoke-interface {v4, p0, v7, v9}, Lcom/android/internal/telephony/CommandsInterface;->registorForPacketPaging(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v7, "enable_call_protect_when_calling"

    invoke-static {v4, v7, v5}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const-string v4, "net.is_dropping_packet"

    const-string v7, "false"

    invoke-static {v4, v7}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    invoke-virtual {v4, v6}, Lcom/android/internal/telephony/DataConnectionManager;->functionForPacketDrop(Z)V

    :cond_3
    if-eqz p2, :cond_4

    invoke-virtual {p2}, Lcom/android/internal/telephony/PhoneBase;->getPhoneType()I

    move-result v4

    if-ne v4, v5, :cond_4

    invoke-virtual {p2}, Lcom/android/internal/telephony/PhoneBase;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v4

    instance-of v4, v4, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    if-eqz v4, :cond_4

    invoke-virtual {p2}, Lcom/android/internal/telephony/PhoneBase;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v4

    check-cast v4, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    iput-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mGsst:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->isGsm:Z

    :cond_4
    sget-object v4, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NOTI_USERDATADISABLE_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v4

    if-ne v4, v5, :cond_5

    new-instance v4, Landroid/app/Notification;

    invoke-direct {v4}, Landroid/app/Notification;-><init>()V

    iput-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    const-wide/16 v8, 0x0

    iput-wide v8, v4, Landroid/app/Notification;->when:J

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    const/16 v7, 0x10

    iput v7, v4, Landroid/app/Notification;->flags:I

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    const v7, 0x108008a

    iput v7, v4, Landroid/app/Notification;->icon:I

    new-instance v4, Landroid/content/Intent;

    invoke-direct {v4}, Landroid/content/Intent;-><init>()V

    iput-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notification_intent:Landroid/content/Intent;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    iget-object v7, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v7}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v7

    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notification_intent:Landroid/content/Intent;

    const/high16 v9, 0x10000000

    invoke-static {v7, v6, v8, v9}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v7

    iput-object v7, v4, Landroid/app/Notification;->contentIntent:Landroid/app/PendingIntent;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v4

    sget v7, Lcom/lge/internal/R$string;->data_disable_body:I

    invoke-virtual {v4, v7}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    .local v0, "details":Ljava/lang/CharSequence;
    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v4

    sget v7, Lcom/lge/internal/R$string;->data_disable_title:I

    invoke-virtual {v4, v7}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v3

    .local v3, "title":Ljava/lang/CharSequence;
    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    iput-object v3, v4, Landroid/app/Notification;->tickerText:Ljava/lang/CharSequence;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v4

    const/4 v7, 0x6

    if-ne v4, v7, :cond_6

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notification_intent:Landroid/content/Intent;

    const-string v5, "com.android.settings"

    const-string v7, "com.android.settings.lgesetting.wireless.DataEnabledSettingBootableSKT"

    invoke-virtual {v4, v5, v7}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :goto_1
    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v5}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v5

    iget-object v7, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notification_intent:Landroid/content/Intent;

    invoke-static {v5, v6, v7, v6}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v5

    iput-object v5, v4, Landroid/app/Notification;->contentIntent:Landroid/app/PendingIntent;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v5}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    iget-object v6, v6, Landroid/app/Notification;->contentIntent:Landroid/app/PendingIntent;

    invoke-virtual {v4, v5, v3, v0, v6}, Landroid/app/Notification;->setLatestEventInfo(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Landroid/app/PendingIntent;)V

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v4

    const-string v5, "notification"

    invoke-virtual {v4, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/NotificationManager;

    .local v2, "notificationManager":Landroid/app/NotificationManager;
    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mConnMgr:Landroid/net/ConnectivityManager;

    invoke-virtual {v4}, Landroid/net/ConnectivityManager;->getMobileDataEnabled()Z

    move-result v4

    if-nez v4, :cond_5

    const-string v4, "true"

    const-string v5, "persist.radio.isroaming"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_5

    const-string v4, "[LGE_DATA][LGDCT] "

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[LGEDataConnectionTracker]setNotification: put notification "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " / "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v4, 0x9f6

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    invoke-virtual {v2, v4, v5}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .end local v0    # "details":Ljava/lang/CharSequence;
    .end local v2    # "notificationManager":Landroid/app/NotificationManager;
    .end local v3    # "title":Ljava/lang/CharSequence;
    :cond_5
    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mLTEDataRoamingSettingObserver:Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v5}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;->register(Landroid/content/Context;)V

    goto/16 :goto_0

    .restart local v0    # "details":Ljava/lang/CharSequence;
    .restart local v3    # "title":Ljava/lang/CharSequence;
    :cond_6
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v4

    if-ne v4, v11, :cond_8

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notification_intent:Landroid/content/Intent;

    const-string v7, "com.android.settings"

    const-string v8, "com.android.settings.lgesetting.wireless.DataNetworkModePayPopupKT"

    invoke-virtual {v4, v7, v8}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v7, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notification_intent:Landroid/content/Intent;

    const-string v8, "isRoaming"

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v4

    if-ne v4, v5, :cond_7

    move v4, v5

    :goto_2
    invoke-virtual {v7, v8, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    goto/16 :goto_1

    :cond_7
    move v4, v6

    goto :goto_2

    :cond_8
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v4

    if-ne v4, v10, :cond_9

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notification_intent:Landroid/content/Intent;

    const-string v5, "com.android.settings"

    const-string v7, "com.android.settings.lgesetting.wireless.DataNetworkModePayPopupLGT"

    invoke-virtual {v4, v5, v7}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto/16 :goto_1

    :cond_9
    const-string v4, "[LGE_DATA][LGDCT] "

    const-string v5, "[LGEDataConnectionTracker] it\'s abnormal case"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgDcTracker;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    return-object v0
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/PhoneBase;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgDcTracker;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    return-object v0
.end method

.method static synthetic access$200()[Z
    .locals 1

    .prologue
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->setTeardownRequested:[Z

    return-object v0
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/lgdata/LgDcTracker;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgDcTracker;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->handleLTEDataOnRoamingChange()V

    return-void
.end method

.method private handleGetPreferredNetworkTypeResponse(Landroid/os/Message;)V
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v3, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v3, :cond_1

    iget-object v3, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v3, [I

    check-cast v3, [I

    const/4 v4, 0x0

    aget v2, v3, v4

    .local v2, "modemNetworkMode":I
    const-string v3, "[LGE_DATA][LGDCT] "

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "handleGetPreferredNetworkTypeResponse: modemNetworkMode = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->getPreferredNetworkMode()I

    move-result v1

    .local v1, "curPreferMode":I
    const-string v3, "[LGE_DATA][LGDCT] "

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "handleGetPreferredNetworkTypeReponse: curPreferMode = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v2, :cond_0

    const/4 v3, 0x1

    if-eq v2, v3, :cond_0

    const/4 v3, 0x2

    if-eq v2, v3, :cond_0

    const/4 v3, 0x3

    if-eq v2, v3, :cond_0

    const/16 v3, 0xc

    if-eq v2, v3, :cond_0

    const/4 v3, 0x4

    if-eq v2, v3, :cond_0

    const/4 v3, 0x5

    if-eq v2, v3, :cond_0

    const/4 v3, 0x6

    if-eq v2, v3, :cond_0

    const/4 v3, 0x7

    if-eq v2, v3, :cond_0

    const/16 v3, 0x8

    if-eq v2, v3, :cond_0

    const/16 v3, 0x9

    if-eq v2, v3, :cond_0

    const/16 v3, 0xb

    if-ne v2, v3, :cond_2

    :cond_0
    const-string v3, "[LGE_DATA][LGDCT] "

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "handleGetPreferredNetworkTypeResponse: if 1: modemNetworkMode = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eq v2, v1, :cond_1

    const-string v3, "[LGE_DATA][LGDCT] "

    const-string v4, "handleGetPreferredNetworkTypeResponse: if 2: modemNetworkMode != curPreferMode"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v3, "[LGE_DATA][LGDCT] "

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "handleGetPreferredNetworkTypeResponse: setPreferredNetworkMode set to = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v3, v2}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setPreferredNetworkMode(I)V

    .end local v1    # "curPreferMode":I
    .end local v2    # "modemNetworkMode":I
    :cond_1
    :goto_0
    return-void

    .restart local v1    # "curPreferMode":I
    .restart local v2    # "modemNetworkMode":I
    :cond_2
    const-string v3, "[LGE_DATA][LGDCT] "

    const-string v4, "handleGetPreferredNetworkTypeResponse: else: reset to default"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->resetNetworkModeToDefault()V

    goto :goto_0
.end method

.method private handleLTEDataOnRoamingChange()V
    .locals 4

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->getLTEDataRoamingEnable()Z

    move-result v0

    .local v0, "enableDataLteRoaming":Z
    const-string v1, "[LGE_DATA][LGDCT] "

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleLTEDataOnRoamingChange(), enableDataLteRoaming : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v1, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnSelectionHdlr:Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;

    invoke-virtual {v1, v0}, Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;->selectApnForLteRoamingOfUplus(Z)V

    return-void
.end method

.method private handleSetPreferredNetworkTypeResponse(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v1, :cond_0

    const-string v1, "[LGE_DATA][LGDCT] "

    const-string v2, "SetPreferredNetworkType is success"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    const-string v1, "[LGE_DATA][LGDCT] "

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SetPreferredNetworkType is failed, exception="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    const v2, 0x42805

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/PhoneBase;->getPreferredNetworkType(Landroid/os/Message;)V

    goto :goto_0
.end method

.method private retryAfterDisconnected(Ljava/lang/String;)Z
    .locals 4
    .param p1, "reason"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x1

    .local v1, "retry":Z
    const-string v2, "persist.telephony.mpdn"

    const/4 v3, 0x1

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    .local v0, "SUPPORT_MPDN":Z
    const-string v2, "radioTurnedOff"

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    if-nez v0, :cond_1

    const-string v2, "SinglePdnArbitration"

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    :cond_0
    const/4 v1, 0x0

    :cond_1
    return v1
.end method


# virtual methods
.method public changePreferrredNetworkMode(Z)V
    .locals 13
    .param p1, "enabled"    # Z

    .prologue
    const v12, 0x42806

    const/4 v11, 0x1

    const/4 v5, -0x1

    .local v5, "newPreferMode":I
    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v8}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->getPreferredNetworkMode()I

    move-result v1

    .local v1, "curPreferMode":I
    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v8}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v8

    invoke-virtual {v8}, Landroid/telephony/ServiceState;->getRadioTechnology()I

    move-result v2

    .local v2, "curRadioTech":I
    const/4 v0, 0x0

    .local v0, "Is_LWmode_selected":Z
    const-string v8, "[LGE_DATA][LGDCT] "

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[changePreferrredNetworkMode] enabled:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", curPreferMode:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v10, v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->networkModeToString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", curRadioTech:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v10}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    invoke-static {v2}, Landroid/telephony/ServiceState;->rilRadioTechnologyToString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v8}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-virtual {v8}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "mobile_data"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v10}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9, v11}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v3

    .local v3, "dataNetwork":I
    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v8}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-virtual {v8}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "data_roaming"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v10}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9, v11}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v7

    .local v7, "roamingData":I
    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v8}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-virtual {v8}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v8

    const-string v9, "lte_roaming"

    const/4 v10, 0x0

    invoke-static {v8, v9, v10}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v4

    .local v4, "lteRoaming":I
    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v8}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v6

    .local v6, "roaming":Z
    sget-object v8, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LTE_ROAMING_KT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v8}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v8

    if-eqz v8, :cond_2

    if-eqz v6, :cond_2

    const-string v8, "[LGE_DATA][LGDCT] "

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[sehyun] dataNetwork = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", roamingData = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", lteRoaming = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v4, :cond_0

    if-nez v7, :cond_2

    :cond_0
    if-eqz p1, :cond_2

    :cond_1
    :goto_0
    return-void

    :cond_2
    if-eqz p1, :cond_4

    sparse-switch v1, :sswitch_data_0

    :cond_3
    :goto_1
    :sswitch_0
    const-string v8, "[LGE_DATA][LGDCT] "

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[changePreferrredNetworkMode] newPreferMode : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v10, v5}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->networkModeToString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " / curPreferMode : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v10, v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->networkModeToString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v8, -0x1

    if-eq v5, v8, :cond_1

    if-eq v5, v1, :cond_1

    const-string v8, "[LGE_DATA][LGDCT] "

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[changePreferrredNetworkMode] change to newPreferMode:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v10, v5}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->networkModeToString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v0, :cond_5

    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {p0, v12}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v9

    invoke-virtual {v8, v5, v9}, Lcom/android/internal/telephony/PhoneBase;->setPreferredNetworkType(ILandroid/os/Message;)V

    goto :goto_0

    :sswitch_1
    const/16 v5, 0x9

    goto :goto_1

    :sswitch_2
    const/16 v5, 0xc

    goto :goto_1

    :cond_4
    sparse-switch v1, :sswitch_data_1

    goto :goto_1

    :sswitch_3
    const/4 v5, 0x3

    sget-object v8, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MODE_CHANGE_NT_MODE_WCDMA_PREF_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v8}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v8

    if-eqz v8, :cond_3

    const/4 v5, 0x0

    goto :goto_1

    :sswitch_4
    const/4 v5, 0x2

    sget-object v8, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MODECHANGE_KT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v8}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v8

    if-eqz v8, :cond_3

    const/4 v0, 0x1

    const-string v8, "[LGE_DATA][LGDCT] "

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[changePreferrredNetworkMode] Is_LWmode_selected : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    :cond_5
    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {p0, v12}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v9

    invoke-virtual {v8, v5, v9}, Lcom/android/internal/telephony/PhoneBase;->setPreferredNetworkType(ILandroid/os/Message;)V

    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v8, v5}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setPreferredNetworkMode(I)V

    goto/16 :goto_0

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_1
        0x2 -> :sswitch_0
        0x3 -> :sswitch_1
        0x9 -> :sswitch_1
        0xc -> :sswitch_2
    .end sparse-switch

    :sswitch_data_1
    .sparse-switch
        0x0 -> :sswitch_3
        0x2 -> :sswitch_0
        0x3 -> :sswitch_3
        0x9 -> :sswitch_3
        0xc -> :sswitch_4
    .end sparse-switch
.end method

.method public dispose()V
    .locals 3

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v0

    const/4 v1, 0x5

    if-eq v0, v1, :cond_0

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v0

    const/4 v1, 0x6

    if-eq v0, v1, :cond_0

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v0

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    const-string v0, "[LGE_DATA][LGDCT] "

    const-string v1, "other country do not use this function. so return."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_GPRS_REJECTED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->isGsm:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mGsst:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mGsst:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    const/16 v1, 0x3ef

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;->setPdpRejectedNotification(II)V

    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v0, v0, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForAvailable(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/android/internal/telephony/ServiceStateTracker;->unregisterForNetworkAttached(Landroid/os/Handler;)V

    :cond_2
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VOICE_PROTECTION_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v0, v0, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregistorForPacketPaging(Landroid/os/Handler;)V

    :cond_3
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v0, v0, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForDataNetworkStateChanged(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/android/internal/telephony/CallTracker;->unregisterForVoiceCallEnded(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/android/internal/telephony/CallTracker;->unregisterForVoiceCallStarted(Landroid/os/Handler;)V

    :cond_4
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v0, p0}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->unregisterForDataConnectEvent(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mUiccController:Lcom/android/internal/telephony/uicc/UiccController;

    invoke-virtual {v0, p0}, Lcom/android/internal/telephony/uicc/UiccController;->unregisterForIccChanged(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mLTEDataRoamingSettingObserver:Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;->unregister(Landroid/content/Context;)V

    goto :goto_0
.end method

.method public getLTEDataRoamingEnable()Z
    .locals 4

    .prologue
    const/4 v2, 0x0

    :try_start_0
    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .local v0, "resolver":Landroid/content/ContentResolver;
    const-string v3, "data_lte_roaming"

    invoke-static {v0, v3}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    if-eqz v3, :cond_0

    const/4 v2, 0x1

    .end local v0    # "resolver":Landroid/content/ContentResolver;
    :cond_0
    :goto_0
    return v2

    :catch_0
    move-exception v1

    .local v1, "snfe":Landroid/provider/Settings$SettingNotFoundException;
    goto :goto_0
.end method

.method public getOverallState()Lcom/android/internal/telephony/DctConstants$State;
    .locals 7

    .prologue
    const/4 v3, 0x0

    .local v3, "isConnecting":Z
    const/4 v4, 0x1

    .local v4, "isFailed":Z
    const/4 v2, 0x0

    .local v2, "isAnyEnabled":Z
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v5, v5, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v5}, Ljava/util/concurrent/ConcurrentHashMap;->values()Ljava/util/Collection;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v0, "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    invoke-virtual {v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->isEnabled()Z

    move-result v5

    if-eqz v5, :cond_0

    const/4 v2, 0x1

    sget-object v5, Lcom/android/internal/telephony/lgdata/LgDcTracker$2;->$SwitchMap$com$android$internal$telephony$DctConstants$State:[I

    invoke-virtual {v0}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getState()Lcom/android/internal/telephony/DctConstants$State;

    move-result-object v6

    invoke-virtual {v6}, Lcom/android/internal/telephony/DctConstants$State;->ordinal()I

    move-result v6

    aget v5, v5, v6

    packed-switch v5, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    const-string v5, "[LGE_DATA][LGDCT] "

    const-string v6, "overall state is CONNECTED"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v5, Lcom/android/internal/telephony/DctConstants$State;->CONNECTED:Lcom/android/internal/telephony/DctConstants$State;

    .end local v0    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :goto_1
    return-object v5

    .restart local v0    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :pswitch_1
    const/4 v3, 0x1

    const/4 v4, 0x0

    goto :goto_0

    :pswitch_2
    const/4 v4, 0x0

    goto :goto_0

    .end local v0    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :cond_1
    if-nez v2, :cond_2

    const-string v5, "[LGE_DATA][LGDCT] "

    const-string v6, "overall state is IDLE"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v5, Lcom/android/internal/telephony/DctConstants$State;->IDLE:Lcom/android/internal/telephony/DctConstants$State;

    goto :goto_1

    :cond_2
    if-eqz v3, :cond_3

    const-string v5, "[LGE_DATA][LGDCT] "

    const-string v6, "overall state is CONNECTING"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v5, Lcom/android/internal/telephony/DctConstants$State;->CONNECTING:Lcom/android/internal/telephony/DctConstants$State;

    goto :goto_1

    :cond_3
    if-nez v4, :cond_4

    const-string v5, "[LGE_DATA][LGDCT] "

    const-string v6, "overall state is IDLE"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v5, Lcom/android/internal/telephony/DctConstants$State;->IDLE:Lcom/android/internal/telephony/DctConstants$State;

    goto :goto_1

    :cond_4
    const-string v5, "[LGE_DATA][LGDCT] "

    const-string v6, "overall state is FAILED"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v5, Lcom/android/internal/telephony/DctConstants$State;->FAILED:Lcom/android/internal/telephony/DctConstants$State;

    goto :goto_1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_2
    .end packed-switch
.end method

.method public handleCSProtection(Landroid/os/AsyncResult;)V
    .locals 6
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    iget-object v2, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v2, :cond_2

    const-string v2, "[LGE_DATA][LGDCT] "

    const-string v3, "handleCSProtection"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    .local v0, "ModemInfo":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_0

    const-string v2, "[LGE_DATA][LGDCT] "

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleCSProtection ModemInfo = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v2, "1"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .local v1, "bEnabled":Z
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    sget-object v4, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->setBlockPacketMenuProcess:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v5, ""

    if-eqz v1, :cond_1

    const/4 v2, 0x1

    :goto_0
    invoke-virtual {v3, v4, v5, v2}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    .end local v0    # "ModemInfo":Ljava/lang/String;
    .end local v1    # "bEnabled":Z
    :cond_0
    :goto_1
    return-void

    .restart local v0    # "ModemInfo":Ljava/lang/String;
    .restart local v1    # "bEnabled":Z
    :cond_1
    const/4 v2, 0x0

    goto :goto_0

    .end local v0    # "ModemInfo":Ljava/lang/String;
    .end local v1    # "bEnabled":Z
    :cond_2
    const-string v2, "[LGE_DATA][LGDCT] "

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleCSProtection, exception="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 65
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "handleMessage msg="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->what:I

    move/from16 v60, v0

    sparse-switch v60, :sswitch_data_0

    :cond_0
    :goto_0
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "Unidentified event msg="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    :goto_1
    return-void

    :sswitch_0
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "EVENT_RADIO_AVAILABLE"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v60, "upgrade.mpdn.db"

    const/16 v61, 0x0

    invoke-static/range {v60 .. v61}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v60

    if-eqz v60, :cond_2

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v60

    if-nez v60, :cond_2

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "Netowrk mode change from gw to gwl when upgrade APN DB"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    const/16 v61, 0x9

    const/16 v62, 0x0

    invoke-virtual/range {v60 .. v62}, Lcom/android/internal/telephony/PhoneBase;->setPreferredNetworkType(ILandroid/os/Message;)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    const/16 v61, 0x9

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setPreferredNetworkMode(I)V

    :cond_2
    const-string v60, "upgrade.mpdn.db"

    const-string v61, "false"

    invoke-static/range {v60 .. v61}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VOICE_PROTECTION_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_1

    const-string v60, "net.Is_phone_booted"

    invoke-static/range {v60 .. v60}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v60

    const-string v61, "true"

    invoke-virtual/range {v60 .. v61}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v46

    .local v46, "mbooting_phone":Z
    if-eqz v46, :cond_1

    const-string v60, "ro.product.model"

    invoke-static/range {v60 .. v60}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v47

    .local v47, "model":Ljava/lang/String;
    const-string v60, "LG-F160S"

    move-object/from16 v0, v60

    move-object/from16 v1, v47

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-nez v60, :cond_3

    const-string v60, "LG-F180S"

    move-object/from16 v0, v60

    move-object/from16 v1, v47

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-nez v60, :cond_3

    const-string v60, "LG-F200S"

    move-object/from16 v0, v60

    move-object/from16 v1, v47

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-eqz v60, :cond_4

    :cond_3
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] NV model = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v47

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    :cond_4
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] Non NV model = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v47

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v44

    .local v44, "mContext":Landroid/content/Context;
    invoke-virtual/range {v44 .. v44}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v60

    const-string v61, "multi_rab_setting"

    const/16 v62, 0x1

    invoke-static/range {v60 .. v62}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v60

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_5

    const/16 v22, 0x1

    .local v22, "bEnabled":Z
    :goto_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v60, v0

    if-eqz v60, :cond_7

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] bEnabled = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v22

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v61, v0

    sget-object v62, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->setBlockPacketMenuProcess:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v63, ""

    if-eqz v22, :cond_6

    const/16 v60, 0x1

    :goto_3
    move-object/from16 v0, v61

    move-object/from16 v1, v62

    move-object/from16 v2, v63

    move/from16 v3, v60

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    goto/16 :goto_1

    .end local v22    # "bEnabled":Z
    :cond_5
    const/16 v22, 0x0

    goto :goto_2

    .restart local v22    # "bEnabled":Z
    :cond_6
    const/16 v60, 0x0

    goto :goto_3

    :cond_7
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA]dataMgr Null"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .end local v22    # "bEnabled":Z
    .end local v44    # "mContext":Landroid/content/Context;
    .end local v46    # "mbooting_phone":Z
    .end local v47    # "model":Ljava/lang/String;
    :sswitch_1
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "EVENT_RADIO_REGISTERED_TO_NETWORK"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SELECT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_1

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnSelectionHdlr:Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v61, v0

    move-object/from16 v0, v61

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnSelectionHdlr:Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;

    move-object/from16 v61, v0

    const-string v61, "Select_default_APN_between_domestic_and_roaming"

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;->selectApn(Ljava/lang/String;)V

    goto/16 :goto_1

    :sswitch_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v61, v0

    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v60, v0

    check-cast v60, Landroid/os/AsyncResult;

    move-object/from16 v0, v61

    move-object/from16 v1, v60

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->onLockStateChanged(Landroid/os/AsyncResult;)V

    goto/16 :goto_1

    :sswitch_3
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v44

    .restart local v44    # "mContext":Landroid/content/Context;
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "EVENT_PACKET_PAGING_RECEIVED"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "Packet Paing Drop"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v60, v0

    const/16 v61, 0x0

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/DataConnectionManager;->functionForPacketDrop(Z)V

    goto/16 :goto_1

    .end local v44    # "mContext":Landroid/content/Context;
    :sswitch_4
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v21, v0

    check-cast v21, Landroid/os/AsyncResult;

    .local v21, "ar":Landroid/os/AsyncResult;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mConnMgr:Landroid/net/ConnectivityManager;

    move-object/from16 v60, v0

    const/16 v61, 0x0

    invoke-virtual/range {v60 .. v61}, Landroid/net/ConnectivityManager;->getLinkProperties(I)Landroid/net/LinkProperties;

    move-result-object v52

    .local v52, "p":Landroid/net/LinkProperties;
    move-object/from16 v0, v21

    iget-object v0, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    move-object/from16 v60, v0

    check-cast v60, Ljava/util/ArrayList;

    move-object/from16 v26, v60

    check-cast v26, Ljava/util/ArrayList;

    .local v26, "dataCallStates":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/dataconnection/DataCallResponse;>;"
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "EVENT_DATA_STATE_CHANGED = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, v21

    iget-object v0, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    move-object/from16 v60, v0

    if-eqz v60, :cond_8

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "onDataStateChanged(ar): exception; likely radio not available, ignore"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    :cond_8
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v60, v0

    const-string v61, "default"

    invoke-virtual/range {v60 .. v61}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v12, "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    if-eqz v12, :cond_9

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getState()Lcom/android/internal/telephony/DctConstants$State;

    move-result-object v60

    sget-object v61, Lcom/android/internal/telephony/DctConstants$State;->CONNECTED:Lcom/android/internal/telephony/DctConstants$State;

    move-object/from16 v0, v60

    move-object/from16 v1, v61

    if-ne v0, v1, :cond_9

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA_STATE]Default is connected"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_9
    const/16 v40, 0x0

    .local v40, "isAnyDataCallDormant":Z
    const/16 v39, 0x0

    .local v39, "isAnyDataCallActive":Z
    if-eqz v52, :cond_d

    if-eqz v26, :cond_d

    invoke-virtual/range {v26 .. v26}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v36

    .local v36, "i$":Ljava/util/Iterator;
    :cond_a
    :goto_4
    invoke-interface/range {v36 .. v36}, Ljava/util/Iterator;->hasNext()Z

    move-result v60

    if-eqz v60, :cond_d

    invoke-interface/range {v36 .. v36}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v49

    check-cast v49, Lcom/android/internal/telephony/dataconnection/DataCallResponse;

    .local v49, "newState":Lcom/android/internal/telephony/dataconnection/DataCallResponse;
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_b

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "newState = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v49

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, "iface = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v52 .. v52}, Landroid/net/LinkProperties;->getInterfaceName()Ljava/lang/String;

    move-result-object v62

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_b
    move-object/from16 v0, v49

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->ifname:Ljava/lang/String;

    move-object/from16 v60, v0

    invoke-virtual/range {v52 .. v52}, Landroid/net/LinkProperties;->getInterfaceName()Ljava/lang/String;

    move-result-object v61

    invoke-virtual/range {v60 .. v61}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-eqz v60, :cond_a

    move-object/from16 v0, v49

    iget v0, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->active:I

    move/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v61, v0

    const/16 v61, 0x2

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_c

    const/16 v39, 0x1

    :cond_c
    move-object/from16 v0, v49

    iget v0, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->active:I

    move/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v61, v0

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_a

    const/16 v40, 0x1

    goto :goto_4

    .end local v36    # "i$":Ljava/util/Iterator;
    .end local v49    # "newState":Lcom/android/internal/telephony/dataconnection/DataCallResponse;
    :cond_d
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "isAnyDataCallActive = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v39

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, "  isAnyDataCallDormant = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v40

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v39, :cond_1

    if-eqz v40, :cond_1

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VOICE_PROTECTION_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_1

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    const-string v61, "activity"

    invoke-virtual/range {v60 .. v61}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/app/ActivityManager;

    .local v11, "am":Landroid/app/ActivityManager;
    const/16 v60, 0x1

    move/from16 v0, v60

    invoke-virtual {v11, v0}, Landroid/app/ActivityManager;->getRunningTasks(I)Ljava/util/List;

    move-result-object v55

    .local v55, "taskInfo":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningTaskInfo;>;"
    if-eqz v55, :cond_1

    const/16 v60, 0x0

    move-object/from16 v0, v55

    move/from16 v1, v60

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v60

    check-cast v60, Landroid/app/ActivityManager$RunningTaskInfo;

    move-object/from16 v0, v60

    iget-object v0, v0, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    move-object/from16 v58, v0

    .local v58, "topActivity":Landroid/content/ComponentName;
    invoke-virtual/range {v58 .. v58}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v48

    .local v48, "name":Ljava/lang/String;
    invoke-virtual/range {v58 .. v58}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v59

    .local v59, "topclassname":Ljava/lang/String;
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "topActivity.getPackageName(); = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v48

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "topActivity.getClassName(); = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v59

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "VOICE CALL  ::"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    sget-boolean v62, Lcom/android/internal/telephony/lgdata/LgDcTracker;->voice_call_ing:Z

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v60, "com.android.incallui.InCallActivity"

    invoke-virtual/range {v59 .. v60}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-eqz v60, :cond_1

    sget-boolean v60, Lcom/android/internal/telephony/lgdata/LgDcTracker;->voice_call_ing:Z

    if-eqz v60, :cond_1

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "(InCallScreen) topActivity.getClassName(); = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v59

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v60, v0

    sget-object v61, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->getAlreadyAppUsedPacket:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v62, ""

    const/16 v63, 0x0

    invoke-virtual/range {v60 .. v63}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    move-result v60

    if-nez v60, :cond_1

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v60

    const/16 v61, 0x6

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_1

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v60, v0

    const/16 v61, 0x1

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/DataConnectionManager;->functionForPacketDrop(Z)V

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "functionForPacketDrop is called"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .end local v11    # "am":Landroid/app/ActivityManager;
    .end local v12    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .end local v21    # "ar":Landroid/os/AsyncResult;
    .end local v26    # "dataCallStates":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/dataconnection/DataCallResponse;>;"
    .end local v39    # "isAnyDataCallActive":Z
    .end local v40    # "isAnyDataCallDormant":Z
    .end local v48    # "name":Ljava/lang/String;
    .end local v52    # "p":Landroid/net/LinkProperties;
    .end local v55    # "taskInfo":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningTaskInfo;>;"
    .end local v58    # "topActivity":Landroid/content/ComponentName;
    .end local v59    # "topclassname":Ljava/lang/String;
    :sswitch_5
    const/16 v60, 0x1

    sput-boolean v60, Lcom/android/internal/telephony/lgdata/LgDcTracker;->voice_call_ing:Z

    goto/16 :goto_1

    :sswitch_6
    const/16 v60, 0x0

    sput-boolean v60, Lcom/android/internal/telephony/lgdata/LgDcTracker;->voice_call_ing:Z

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VOICE_PROTECTION_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_1

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v60

    invoke-virtual/range {v60 .. v60}, Landroid/telephony/ServiceState;->getState()I

    move-result v60

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_e

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA] functionForResetDrop for STATE_OUT_OF_SERVICE"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v60, v0

    const/16 v61, 0x0

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/DataConnectionManager;->functionForPacketDrop(Z)V

    goto/16 :goto_1

    :cond_e
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA] functionForPacketDrop for ACTION_VOICE_CALL_ENDED"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v60, v0

    const/16 v61, 0x0

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/DataConnectionManager;->functionForPacketDrop(Z)V

    goto/16 :goto_1

    :sswitch_7
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "EVENT_SETDEFAULT_TOCHANGE_AFTER_DELAY complete : "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->getOverallState()Lcom/android/internal/telephony/DctConstants$State;

    move-result-object v62

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->getOverallState()Lcom/android/internal/telephony/DctConstants$State;

    move-result-object v60

    sget-object v61, Lcom/android/internal/telephony/DctConstants$State;->IDLE:Lcom/android/internal/telephony/DctConstants$State;

    move-object/from16 v0, v60

    move-object/from16 v1, v61

    if-ne v0, v1, :cond_1

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnSelectionHdlr:Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v61, v0

    move-object/from16 v0, v61

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnSelectionHdlr:Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;

    move-object/from16 v61, v0

    const-string v61, "Added_APN_failed"

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;->selectApn(Ljava/lang/String;)V

    goto/16 :goto_1

    :sswitch_8
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    instance-of v0, v0, Lcom/android/internal/telephony/dataconnection/ApnContext;

    move/from16 v60, v0

    if-eqz v60, :cond_f

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v61, v0

    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v60, v0

    check-cast v60, Lcom/android/internal/telephony/dataconnection/ApnContext;

    move-object/from16 v0, v61

    move-object/from16 v1, v60

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->onTrySetupData(Lcom/android/internal/telephony/dataconnection/ApnContext;)Z

    goto/16 :goto_1

    :cond_f
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    instance-of v0, v0, Ljava/lang/String;

    move/from16 v60, v0

    if-eqz v60, :cond_10

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v61, v0

    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v60, v0

    check-cast v60, Ljava/lang/String;

    move-object/from16 v0, v61

    move-object/from16 v1, v60

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->onTrySetupData(Ljava/lang/String;)Z

    goto/16 :goto_1

    :cond_10
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "EVENT_TRY_SETUP request w/o apnContext or String"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    :sswitch_9
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "EVENT_DATA_ERROR_FAIL_CAUSE"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v60, v0

    check-cast v60, Landroid/os/AsyncResult;

    move-object/from16 v0, p0

    move-object/from16 v1, v60

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->pdpreject_causecode(Landroid/os/AsyncResult;)V

    goto/16 :goto_1

    :sswitch_a
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v60, v0

    check-cast v60, Landroid/os/AsyncResult;

    move-object/from16 v0, p0

    move-object/from16 v1, v60

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->handleCSProtection(Landroid/os/AsyncResult;)V

    goto/16 :goto_1

    :sswitch_b
    invoke-direct/range {p0 .. p1}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->handleGetPreferredNetworkTypeResponse(Landroid/os/Message;)V

    goto/16 :goto_1

    :sswitch_c
    invoke-direct/range {p0 .. p1}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->handleSetPreferredNetworkTypeResponse(Landroid/os/Message;)V

    goto/16 :goto_1

    :sswitch_d
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v50, v0

    check-cast v50, Landroid/os/AsyncResult;

    .local v50, "new_ar":Landroid/os/AsyncResult;
    move-object/from16 v0, v50

    iget-object v0, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    move-object/from16 v60, v0

    check-cast v60, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;

    move-object/from16 v45, v60

    check-cast v45, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;

    .local v45, "mLgDataMsg":Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;
    if-eqz v45, :cond_1

    move-object/from16 v0, v45

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->valid:Z

    move/from16 v60, v0

    if-eqz v60, :cond_1

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] EVENT_FAKE_DATACONNECTION_EVENT  valid : "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v45

    iget v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->what:I

    move/from16 v62, v0

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, v45

    iget v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->what:I

    move/from16 v60, v0

    sparse-switch v60, :sswitch_data_1

    goto/16 :goto_0

    :sswitch_e
    move-object/from16 v0, v45

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->success:Z

    move/from16 v43, v0

    .local v43, "issucess":Z
    move-object/from16 v0, v45

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->type:Ljava/lang/String;

    move-object/from16 v17, v0

    .local v17, "apnType":Ljava/lang/String;
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] apnType = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, " valid ="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v45

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->valid:Z

    move/from16 v62, v0

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v19, 0x0

    .local v19, "apn_info":Lcom/android/internal/telephony/dataconnection/ApnSetting;
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] EVENT_DATA_SETUP_COMPLETE apnType = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    move-object/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .restart local v12    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    if-nez v12, :cond_16

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA] EVENT_DATA_SETUP_COMPLETE apnContext is NULL!"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .end local v12    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .end local v17    # "apnType":Ljava/lang/String;
    .end local v19    # "apn_info":Lcom/android/internal/telephony/dataconnection/ApnSetting;
    .end local v43    # "issucess":Z
    :sswitch_f
    move-object/from16 v0, v45

    iget v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->apntype_n:I

    move/from16 v20, v0

    .local v20, "apntype":I
    move-object/from16 v0, v45

    iget v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->enable:I

    move/from16 v32, v0

    .local v32, "enable":I
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] EVENT_ENABLE_NEW_APN type =  "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, " enable = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v60, v0

    invoke-static/range {v20 .. v20}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v61

    invoke-virtual/range {v60 .. v61}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v15, "apnContext_new":Lcom/android/internal/telephony/dataconnection/ApnContext;
    const/16 v60, 0x1

    move/from16 v0, v32

    move/from16 v1, v60

    if-ne v0, v1, :cond_11

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDcTracker;->setTeardownRequested:[Z

    const/16 v61, 0x0

    aput-boolean v61, v60, v20

    goto/16 :goto_0

    :cond_11
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDcTracker;->setTeardownRequested:[Z

    const/16 v61, 0x1

    aput-boolean v61, v60, v20

    goto/16 :goto_0

    .end local v15    # "apnContext_new":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .end local v20    # "apntype":I
    .end local v32    # "enable":I
    :sswitch_10
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA] EVENT_TRY_SETUP_DATA = "

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, v45

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->reason:Ljava/lang/String;

    move-object/from16 v53, v0

    .local v53, "reason":Ljava/lang/String;
    goto/16 :goto_0

    .end local v53    # "reason":Ljava/lang/String;
    :sswitch_11
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA] EVENT_ROAMING_OFF = "

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v60, "true"

    const-string v61, "persist.radio.isroaming"

    invoke-static/range {v61 .. v61}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v61

    invoke-virtual/range {v60 .. v61}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-nez v60, :cond_0

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NOTI_USERDATADISABLE_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    const-string v61, "notification"

    invoke-virtual/range {v60 .. v61}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v51

    check-cast v51, Landroid/app/NotificationManager;

    .local v51, "notificationManager":Landroid/app/NotificationManager;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    sget v61, Lcom/lge/internal/R$string;->data_disable_body:I

    invoke-virtual/range {v60 .. v61}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v30

    .local v30, "details":Ljava/lang/CharSequence;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    sget v61, Lcom/lge/internal/R$string;->data_disable_title:I

    invoke-virtual/range {v60 .. v61}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v56

    .local v56, "title":Ljava/lang/CharSequence;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    move-object/from16 v60, v0

    move-object/from16 v0, v56

    move-object/from16 v1, v60

    iput-object v0, v1, Landroid/app/Notification;->tickerText:Ljava/lang/CharSequence;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notification_intent:Landroid/content/Intent;

    move-object/from16 v61, v0

    const-string v62, "isRoaming"

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v60

    const/16 v63, 0x1

    move/from16 v0, v60

    move/from16 v1, v63

    if-ne v0, v1, :cond_12

    const/16 v60, 0x1

    :goto_5
    move-object/from16 v0, v61

    move-object/from16 v1, v62

    move/from16 v2, v60

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v61, v0

    invoke-virtual/range {v61 .. v61}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v61

    const/16 v62, 0x0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notification_intent:Landroid/content/Intent;

    move-object/from16 v63, v0

    const/16 v64, 0x0

    invoke-static/range {v61 .. v64}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v60

    iput-object v0, v1, Landroid/app/Notification;->contentIntent:Landroid/app/PendingIntent;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v61, v0

    invoke-virtual/range {v61 .. v61}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v61

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    move-object/from16 v62, v0

    move-object/from16 v0, v62

    iget-object v0, v0, Landroid/app/Notification;->contentIntent:Landroid/app/PendingIntent;

    move-object/from16 v62, v0

    move-object/from16 v0, v60

    move-object/from16 v1, v61

    move-object/from16 v2, v56

    move-object/from16 v3, v30

    move-object/from16 v4, v62

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/app/Notification;->setLatestEventInfo(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Landroid/app/PendingIntent;)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    invoke-virtual/range {v60 .. v60}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v60

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "mobile_data"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v62, v0

    invoke-virtual/range {v62 .. v62}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v62

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    const/16 v62, 0x1

    invoke-static/range {v60 .. v62}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v27

    .local v27, "dataNetwork":I
    const/16 v60, 0x1

    move/from16 v0, v27

    move/from16 v1, v60

    if-ne v0, v1, :cond_13

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[EVENT_ROAMING_OFF] clean Notification"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v60, 0x9f6

    move-object/from16 v0, v51

    move/from16 v1, v60

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V

    goto/16 :goto_0

    .end local v27    # "dataNetwork":I
    :cond_12
    const/16 v60, 0x0

    goto/16 :goto_5

    .restart local v27    # "dataNetwork":I
    :cond_13
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[EVENT_ROAMING_OFF] put notification"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v60, 0x9f6

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    move-object/from16 v61, v0

    move-object/from16 v0, v51

    move/from16 v1, v60

    move-object/from16 v2, v61

    invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    goto/16 :goto_0

    .end local v27    # "dataNetwork":I
    .end local v30    # "details":Ljava/lang/CharSequence;
    .end local v51    # "notificationManager":Landroid/app/NotificationManager;
    .end local v56    # "title":Ljava/lang/CharSequence;
    :sswitch_12
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA] EVENT_ROAMING_ON = "

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v41

    .local v41, "isRoaming":Z
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "onRoamingOn: setup data on roaming"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v41, :cond_14

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_ROAMING_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_14

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SELECT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_14

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mAllApnSettings:Ljava/util/ArrayList;

    move-object/from16 v60, v0

    if-eqz v60, :cond_14

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "onRoamingOn: sendModemProfile"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v61, v0

    invoke-virtual/range {v61 .. v61}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->getInitialProfiles()[Lcom/android/internal/telephony/dataconnection/ApnSetting;

    move-result-object v61

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->sendModemProfile([Lcom/android/internal/telephony/dataconnection/ApnSetting;)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->getDataOnRoamingEnabled()Z

    move-result v60

    if-nez v60, :cond_14

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->getPreferredNetworkMode()I

    move-result v60

    const/16 v61, 0x9

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_14

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "Roaming Disable and mode=NT_MODE_WCDMA_PREF"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    const/16 v61, 0x0

    const v62, 0x42806

    move-object/from16 v0, p0

    move/from16 v1, v62

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v62

    invoke-virtual/range {v60 .. v62}, Lcom/android/internal/telephony/PhoneBase;->setPreferredNetworkType(ILandroid/os/Message;)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    const/16 v61, 0x0

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setPreferredNetworkMode(I)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    invoke-virtual/range {v60 .. v60}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v60

    const-string v61, "preferred_network_mode"

    const/16 v62, 0x0

    invoke-static/range {v60 .. v62}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    :cond_14
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v60

    if-eqz v60, :cond_15

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NOTI_USERDATADISABLE_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_15

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    const-string v61, "notification"

    invoke-virtual/range {v60 .. v61}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v51

    check-cast v51, Landroid/app/NotificationManager;

    .restart local v51    # "notificationManager":Landroid/app/NotificationManager;
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[EVENT_ROAMING_ON]this case is on roaming, so clean Notification"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v60, 0x9f6

    move-object/from16 v0, v51

    move/from16 v1, v60

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V

    .end local v51    # "notificationManager":Landroid/app/NotificationManager;
    :cond_15
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_MPDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_0

    if-eqz v41, :cond_0

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LTE_ROAMING_KT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->getDataOnRoamingEnabled()Z

    move-result v28

    .local v28, "data_roaming":Z
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] KT LTE roaming = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v41

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, " data roaming = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v28

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, "supprot ModeChange For POAB"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    move/from16 v1, v28

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->changePreferrredNetworkMode(Z)V

    goto/16 :goto_0

    .end local v28    # "data_roaming":Z
    .end local v41    # "isRoaming":Z
    .restart local v12    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .restart local v17    # "apnType":Ljava/lang/String;
    .restart local v19    # "apn_info":Lcom/android/internal/telephony/dataconnection/ApnSetting;
    .restart local v43    # "issucess":Z
    :cond_16
    if-eqz v12, :cond_17

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnSetting()Lcom/android/internal/telephony/dataconnection/ApnSetting;

    move-result-object v19

    :cond_17
    if-eqz v43, :cond_25

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_GPRS_REJECTED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_18

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->isGsm:Z

    move/from16 v60, v0

    if-eqz v60, :cond_18

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mGsst:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mGsst:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    move-object/from16 v61, v0

    const/16 v61, 0x3ef

    const/16 v62, 0x0

    invoke-virtual/range {v60 .. v62}, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;->setPdpRejectedNotification(II)V

    :cond_18
    const-string v16, ""

    .local v16, "apnStr":Ljava/lang/String;
    if-eqz v19, :cond_19

    move-object/from16 v0, v19

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/ApnSetting;->apn:Ljava/lang/String;

    move-object/from16 v16, v0

    :cond_19
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] onDataSetupComplete: success apn name="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_ON_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_1c

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v60

    const-string v61, "ims"

    invoke-static/range {v60 .. v61}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v60

    if-eqz v60, :cond_1c

    const/16 v34, 0x0

    .local v34, "found_ims_pcscf":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    const-string v61, "ims"

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/PhoneBase;->getPcscfAddress(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v60

    if-eqz v60, :cond_1b

    const/16 v35, 0x0

    .local v35, "i":I
    :goto_6
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    const-string v61, "ims"

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/PhoneBase;->getPcscfAddress(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v60

    move-object/from16 v0, v60

    array-length v0, v0

    move/from16 v60, v0

    move/from16 v0, v35

    move/from16 v1, v60

    if-ge v0, v1, :cond_1b

    const/16 v60, 0x2

    move/from16 v0, v35

    move/from16 v1, v60

    if-ge v0, v1, :cond_1b

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA][pcscf] getPcscfAddress"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v35

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, "["

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v62, v0

    const-string v63, "ims"

    invoke-virtual/range {v62 .. v63}, Lcom/android/internal/telephony/PhoneBase;->getPcscfAddress(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v62

    aget-object v62, v62, v35

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, "]"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    const-string v61, "ims"

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/PhoneBase;->getPcscfAddress(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v60

    aget-object v60, v60, v35

    if-eqz v60, :cond_1a

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA][pcscf] set v4 or v6 property["

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v35

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, "]"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v60, Ljava/lang/StringBuilder;

    invoke-direct/range {v60 .. v60}, Ljava/lang/StringBuilder;-><init>()V

    const-string v61, "net.pcscf"

    invoke-virtual/range {v60 .. v61}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v60

    move-object/from16 v0, v60

    move/from16 v1, v35

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v60

    invoke-virtual/range {v60 .. v60}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v60

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v61, v0

    const-string v62, "ims"

    invoke-virtual/range {v61 .. v62}, Lcom/android/internal/telephony/PhoneBase;->getPcscfAddress(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v61

    aget-object v61, v61, v35

    invoke-static/range {v60 .. v61}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    or-int/lit8 v34, v34, 0x1

    :cond_1a
    add-int/lit8 v35, v35, 0x1

    goto/16 :goto_6

    .end local v35    # "i":I
    :cond_1b
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    const-string v61, "ims"

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->getLinkProperties(Ljava/lang/String;)Landroid/net/LinkProperties;

    move-result-object v37

    .local v37, "imsLp":Landroid/net/LinkProperties;
    if-eqz v37, :cond_22

    :try_start_0
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] found_ims_pcscf = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v34

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, "  dns = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v37 .. v37}, Landroid/net/LinkProperties;->getDnsServers()Ljava/util/List;

    move-result-object v62

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] dns size = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v37 .. v37}, Landroid/net/LinkProperties;->getDnsServers()Ljava/util/List;

    move-result-object v62

    invoke-interface/range {v62 .. v62}, Ljava/util/List;->size()I

    move-result v62

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_7
    if-eqz v37, :cond_1c

    invoke-virtual/range {v37 .. v37}, Landroid/net/LinkProperties;->getDnsServers()Ljava/util/List;

    move-result-object v60

    invoke-interface/range {v60 .. v60}, Ljava/util/List;->size()I

    move-result v60

    if-nez v60, :cond_1c

    if-nez v34, :cond_1c

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA] cleanUpConnection ims pdn "

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v60, v0

    const-string v61, "ims"

    invoke-virtual/range {v60 .. v61}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v7, "ImsApnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    const/16 v61, 0x1

    move-object/from16 v0, v60

    move/from16 v1, v61

    invoke-virtual {v0, v1, v7}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->sendCleanUpConnection(ZLcom/android/internal/telephony/dataconnection/ApnContext;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v7    # "ImsApnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .end local v34    # "found_ims_pcscf":I
    .end local v37    # "imsLp":Landroid/net/LinkProperties;
    :cond_1c
    :goto_8
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DISCONNECT_DEFAULT_PDN_WITHOUT_DNS_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_1d

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v60

    const-string v61, "default"

    invoke-static/range {v60 .. v61}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v60

    if-eqz v60, :cond_1d

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    const-string v61, "default"

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->getLinkProperties(Ljava/lang/String;)Landroid/net/LinkProperties;

    move-result-object v29

    .local v29, "defaultLp":Landroid/net/LinkProperties;
    if-eqz v29, :cond_23

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] default PDN, dns = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v29 .. v29}, Landroid/net/LinkProperties;->getDnsServers()Ljava/util/List;

    move-result-object v62

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {v29 .. v29}, Landroid/net/LinkProperties;->getDnsServers()Ljava/util/List;

    move-result-object v60

    invoke-interface/range {v60 .. v60}, Ljava/util/List;->size()I

    move-result v60

    if-nez v60, :cond_1d

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA] cleanUpConnection default pdn "

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v60, v0

    const-string v61, "default"

    invoke-virtual/range {v60 .. v61}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v6, "DefaultApnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    const/16 v61, 0x1

    move-object/from16 v0, v60

    move/from16 v1, v61

    invoke-virtual {v0, v1, v6}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->sendCleanUpConnection(ZLcom/android/internal/telephony/dataconnection/ApnContext;)V

    .end local v6    # "DefaultApnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .end local v29    # "defaultLp":Landroid/net/LinkProperties;
    :cond_1d
    :goto_9
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_FAST_CONNECT_DEFAULT_PDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_20

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v60

    const-string v61, "ims"

    invoke-static/range {v60 .. v61}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v60

    if-eqz v60, :cond_20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    invoke-virtual/range {v60 .. v60}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v60

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "mobile_data"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v62, v0

    invoke-virtual/range {v62 .. v62}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v62

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    const/16 v62, 0x1

    invoke-static/range {v60 .. v62}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v60

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_20

    const/4 v10, 0x0

    .local v10, "alarmIntent":Landroid/app/PendingIntent;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v60, v0

    const-string v61, "default"

    invoke-virtual/range {v60 .. v61}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v13, "apnContext_default":Lcom/android/internal/telephony/dataconnection/ApnContext;
    if-eqz v13, :cond_1e

    invoke-virtual {v13}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getReconnectIntent()Landroid/app/PendingIntent;

    move-result-object v10

    :cond_1e
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[onDataSetupComplete] : alarmIntent  :"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, "  default  :"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v10, :cond_1f

    invoke-virtual {v13}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getState()Lcom/android/internal/telephony/DctConstants$State;

    move-result-object v60

    sget-object v61, Lcom/android/internal/telephony/DctConstants$State;->CONNECTED:Lcom/android/internal/telephony/DctConstants$State;

    move-object/from16 v0, v60

    move-object/from16 v1, v61

    if-eq v0, v1, :cond_1f

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mReconnectIntentForDefaultType:Landroid/content/Intent;

    move-object/from16 v60, v0

    if-eqz v60, :cond_1f

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "onDataSetupComplete: cancel alarmIntent  :"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, "   default  :"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    invoke-virtual {v0, v13}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->cancelReconnectAlarm(Lcom/android/internal/telephony/dataconnection/ApnContext;)V

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "onDataSetupComplete: fast reconnect Default with Intent "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v62, v0

    move-object/from16 v0, v62

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mReconnectIntentForDefaultType:Landroid/content/Intent;

    move-object/from16 v62, v0

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v61, v0

    move-object/from16 v0, v61

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mReconnectIntentForDefaultType:Landroid/content/Intent;

    move-object/from16 v61, v0

    invoke-virtual/range {v60 .. v61}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    :cond_1f
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    const/16 v61, 0x0

    move-object/from16 v0, v61

    move-object/from16 v1, v60

    iput-object v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mReconnectIntentForDefaultType:Landroid/content/Intent;

    .end local v10    # "alarmIntent":Landroid/app/PendingIntent;
    .end local v13    # "apnContext_default":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :cond_20
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_OTA_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_21

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v60

    const-string v61, "default"

    invoke-virtual/range {v60 .. v61}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-eqz v60, :cond_21

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    const/16 v61, 0x1

    move/from16 v0, v61

    move-object/from16 v1, v60

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->internetPDNconnected:Z

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] Default PDN Connected, internetPDNconnected = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v62, v0

    move-object/from16 v0, v62

    iget-boolean v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->internetPDNconnected:Z

    move/from16 v62, v0

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_21
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_LTE_ROAMING_LGU:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v60

    if-eqz v60, :cond_0

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v60

    const-string v61, "default"

    invoke-virtual/range {v60 .. v61}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-eqz v60, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v60

    invoke-virtual/range {v60 .. v60}, Landroid/telephony/ServiceState;->getRadioTechnology()I

    move-result v8

    .local v8, "aRadioTech":I
    const/16 v60, 0x1

    move/from16 v0, v60

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/internal/telephony/lgdata/LgDcTracker;->bConnectionStatus:Z

    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->getLTEDataRoamingEnable()Z

    move-result v60

    if-eqz v60, :cond_24

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] send intent LTE_ROAMING_DATA_CONNECTION_LGU, Connection_Status="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->bConnectionStatus:Z

    move/from16 v62, v0

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, " , RadioTechnology="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v38, Landroid/content/Intent;

    const-string v60, "lge.intent.action.LTE_ROAMING_DATA_CONNECTION_LGU"

    move-object/from16 v0, v38

    move-object/from16 v1, v60

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v38, "intentForRoaming":Landroid/content/Intent;
    const-string v60, "Connection_Status"

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->bConnectionStatus:Z

    move/from16 v61, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v60

    move/from16 v2, v61

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    :goto_a
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    move-object/from16 v0, v60

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_0

    .end local v8    # "aRadioTech":I
    .end local v38    # "intentForRoaming":Landroid/content/Intent;
    .restart local v34    # "found_ims_pcscf":I
    .restart local v37    # "imsLp":Landroid/net/LinkProperties;
    :cond_22
    :try_start_1
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA] Ims LinkProperties is null"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_7

    :catch_0
    move-exception v31

    .local v31, "e":Ljava/lang/Exception;
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "handleMessage : Exception has been occurred."

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_8

    .end local v31    # "e":Ljava/lang/Exception;
    .end local v34    # "found_ims_pcscf":I
    .end local v37    # "imsLp":Landroid/net/LinkProperties;
    .restart local v29    # "defaultLp":Landroid/net/LinkProperties;
    :cond_23
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA] Default LinkProperties is null"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_9

    .end local v29    # "defaultLp":Landroid/net/LinkProperties;
    .restart local v8    # "aRadioTech":I
    :cond_24
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] send intent GW_ROAMING_DATA_CONNECTION_LGU, Connection_Status="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->bConnectionStatus:Z

    move/from16 v62, v0

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, " , RadioTechnology="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v38, Landroid/content/Intent;

    const-string v60, "lge.intent.action.GW_ROAMING_DATA_CONNECTION_LGU"

    move-object/from16 v0, v38

    move-object/from16 v1, v60

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v38    # "intentForRoaming":Landroid/content/Intent;
    const-string v60, "Connection_Status"

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->bConnectionStatus:Z

    move/from16 v61, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v60

    move/from16 v2, v61

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    goto :goto_a

    .end local v8    # "aRadioTech":I
    .end local v16    # "apnStr":Ljava/lang/String;
    .end local v38    # "intentForRoaming":Landroid/content/Intent;
    :cond_25
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SELECT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_26

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v60

    const/16 v61, 0x6

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_26

    const v60, 0x4280b

    move-object/from16 v0, p0

    move/from16 v1, v60

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->hasMessages(I)Z

    move-result v60

    if-eqz v60, :cond_26

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[onDataSetupComplete] : Remove EVENT_SETDEFAULT_TOCHANGE_AFTER_DELAY"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const v60, 0x4280b

    move-object/from16 v0, p0

    move/from16 v1, v60

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->removeMessages(I)V

    :cond_26
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_GPRS_REJECTED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_28

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    move-object/from16 v60, v0

    const v61, 0x42808

    move-object/from16 v0, p0

    move/from16 v1, v61

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v61

    invoke-interface/range {v60 .. v61}, Lcom/android/internal/telephony/CommandsInterface;->getLastPdpFailCause(Landroid/os/Message;)V

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->isGsm:Z

    move/from16 v60, v0

    if-eqz v60, :cond_28

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v42

    .local v42, "isRoamingValue":Z
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    invoke-virtual/range {v60 .. v60}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v60

    const-string v61, "airplane_mode_on"

    const/16 v62, 0x0

    invoke-static/range {v60 .. v62}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v9

    .local v9, "airplaneMode":I
    sget-object v23, Lcom/android/internal/telephony/dataconnection/DcFailCause;->UNKNOWN:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    .local v23, "cause":Lcom/android/internal/telephony/dataconnection/DcFailCause;
    const/16 v24, 0x0

    .local v24, "causeValue":Ljava/lang/String;
    move-object/from16 v0, v45

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->cause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    move-object/from16 v60, v0

    if-eqz v60, :cond_27

    move-object/from16 v0, v45

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->cause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    move-object/from16 v23, v0

    new-instance v60, Ljava/lang/StringBuilder;

    invoke-direct/range {v60 .. v60}, Ljava/lang/StringBuilder;-><init>()V

    const-string v61, "("

    invoke-virtual/range {v60 .. v61}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v60

    invoke-virtual/range {v23 .. v23}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->getErrorCode()I

    move-result v61

    invoke-virtual/range {v60 .. v61}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v60

    const-string v61, ") "

    invoke-virtual/range {v60 .. v61}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v60

    invoke-virtual/range {v23 .. v23}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-virtual/range {v60 .. v61}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v60

    invoke-virtual/range {v60 .. v60}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v24

    :cond_27
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "causeValue "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v12, :cond_28

    if-eqz v23, :cond_28

    sget-object v60, Lcom/android/internal/telephony/dataconnection/DcFailCause;->UNKNOWN:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    move-object/from16 v0, v23

    move-object/from16 v1, v60

    if-eq v0, v1, :cond_28

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v60

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v61, v0

    const-string v61, "ims"

    invoke-virtual/range {v60 .. v61}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-nez v60, :cond_2b

    invoke-virtual/range {v23 .. v23}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->isPermanentFail()Z

    move-result v60

    if-eqz v60, :cond_2b

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v60

    const/16 v61, 0x5

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_2b

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mGsst:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mGsst:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    move-object/from16 v61, v0

    const/16 v61, 0x3f0

    invoke-virtual/range {v23 .. v23}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->getErrorCode()I

    move-result v62

    invoke-virtual/range {v60 .. v62}, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;->setPdpRejectedNotification(II)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    const-string v61, "connectivity"

    invoke-virtual/range {v60 .. v61}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v25

    check-cast v25, Landroid/net/ConnectivityManager;

    .local v25, "cm":Landroid/net/ConnectivityManager;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v61, v0

    invoke-virtual/range {v61 .. v61}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v61

    sget v62, Lcom/lge/internal/R$string;->dataBlock_noti_text:I

    invoke-virtual/range {v61 .. v62}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v61

    invoke-interface/range {v61 .. v61}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v61

    const/16 v62, 0x1

    invoke-static/range {v60 .. v62}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v57

    .local v57, "toast":Landroid/widget/Toast;
    const/16 v60, 0x50

    const/16 v61, 0x0

    const/16 v62, 0x0

    move-object/from16 v0, v57

    move/from16 v1, v60

    move/from16 v2, v61

    move/from16 v3, v62

    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/Toast;->setGravity(III)V

    invoke-virtual/range {v57 .. v57}, Landroid/widget/Toast;->show()V

    .end local v9    # "airplaneMode":I
    .end local v23    # "cause":Lcom/android/internal/telephony/dataconnection/DcFailCause;
    .end local v24    # "causeValue":Ljava/lang/String;
    .end local v25    # "cm":Landroid/net/ConnectivityManager;
    .end local v42    # "isRoamingValue":Z
    .end local v57    # "toast":Landroid/widget/Toast;
    :cond_28
    :goto_b
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SELECT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_29

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v60

    const/16 v61, 0x6

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_29

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnSelectionHdlr:Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v61, v0

    move-object/from16 v0, v61

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnSelectionHdlr:Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;

    move-object/from16 v61, v0

    const-string v61, "Added_APN_failed"

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;->selectApn(Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnSelectionHdlr:Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;

    move-object/from16 v60, v0

    const/16 v61, 0x1

    move/from16 v0, v61

    move-object/from16 v1, v60

    iput-boolean v0, v1, Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;->APN_FAIL_Flag:Z

    :cond_29
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_LTE_ROAMING_LGU:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v60

    if-eqz v60, :cond_0

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v60

    const-string v61, "default"

    invoke-virtual/range {v60 .. v61}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-eqz v60, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v60

    invoke-virtual/range {v60 .. v60}, Landroid/telephony/ServiceState;->getRadioTechnology()I

    move-result v8

    .restart local v8    # "aRadioTech":I
    const/16 v60, 0x0

    move/from16 v0, v60

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/internal/telephony/lgdata/LgDcTracker;->bConnectionStatus:Z

    const/16 v60, 0x2

    move/from16 v0, v60

    if-eq v8, v0, :cond_2a

    const/16 v60, 0x1

    move/from16 v0, v60

    if-ne v8, v0, :cond_0

    :cond_2a
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->getLTEDataRoamingEnable()Z

    move-result v60

    if-eqz v60, :cond_2c

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] send intent LTE_ROAMING_DATA_CONNECTION_LGU, Connection_Status="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->bConnectionStatus:Z

    move/from16 v62, v0

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, " , RadioTechnology="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v38, Landroid/content/Intent;

    const-string v60, "lge.intent.action.LTE_ROAMING_DATA_CONNECTION_LGU"

    move-object/from16 v0, v38

    move-object/from16 v1, v60

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v38    # "intentForRoaming":Landroid/content/Intent;
    const-string v60, "Connection_Status"

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->bConnectionStatus:Z

    move/from16 v61, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v60

    move/from16 v2, v61

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    :goto_c
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    move-object/from16 v0, v60

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_0

    .end local v8    # "aRadioTech":I
    .end local v38    # "intentForRoaming":Landroid/content/Intent;
    .restart local v9    # "airplaneMode":I
    .restart local v23    # "cause":Lcom/android/internal/telephony/dataconnection/DcFailCause;
    .restart local v24    # "causeValue":Ljava/lang/String;
    .restart local v42    # "isRoamingValue":Z
    :cond_2b
    if-eqz v42, :cond_28

    const/16 v60, 0x1

    move/from16 v0, v60

    if-eq v9, v0, :cond_28

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v60

    const/16 v61, 0x2

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_28

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/ApnContext;->isEnabled()Z

    move-result v60

    if-eqz v60, :cond_28

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[MIN]setNorification!!"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mGsst:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mGsst:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    move-object/from16 v61, v0

    const/16 v61, 0x3f0

    invoke-virtual/range {v23 .. v23}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->getErrorCode()I

    move-result v62

    invoke-virtual/range {v60 .. v62}, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;->setPdpRejectedNotification(II)V

    goto/16 :goto_b

    .end local v9    # "airplaneMode":I
    .end local v23    # "cause":Lcom/android/internal/telephony/dataconnection/DcFailCause;
    .end local v24    # "causeValue":Ljava/lang/String;
    .end local v42    # "isRoamingValue":Z
    .restart local v8    # "aRadioTech":I
    :cond_2c
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] send intent GW_ROAMING_DATA_CONNECTION_LGU, Connection_Status="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->bConnectionStatus:Z

    move/from16 v62, v0

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, " , RadioTechnology="

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v38, Landroid/content/Intent;

    const-string v60, "lge.intent.action.GW_ROAMING_DATA_CONNECTION_LGU"

    move-object/from16 v0, v38

    move-object/from16 v1, v60

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v38    # "intentForRoaming":Landroid/content/Intent;
    const-string v60, "Connection_Status"

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->bConnectionStatus:Z

    move/from16 v61, v0

    move-object/from16 v0, v38

    move-object/from16 v1, v60

    move/from16 v2, v61

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    goto/16 :goto_c

    .end local v8    # "aRadioTech":I
    .end local v12    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .end local v17    # "apnType":Ljava/lang/String;
    .end local v19    # "apn_info":Lcom/android/internal/telephony/dataconnection/ApnSetting;
    .end local v38    # "intentForRoaming":Landroid/content/Intent;
    .end local v43    # "issucess":Z
    :sswitch_13
    move-object/from16 v0, v45

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTrackerMsg;->type:Ljava/lang/String;

    move-object/from16 v18, v0

    .local v18, "apnType_done":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    move-object/from16 v1, v18

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v14, "apnContext_done":Lcom/android/internal/telephony/dataconnection/ApnContext;
    if-eqz v14, :cond_0

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] EVENT_DISCONNECT_DONE = type : "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v18

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VOICE_PROTECTION_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_2d

    invoke-virtual {v14}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v60

    const-string v61, "default"

    invoke-static/range {v60 .. v61}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v60

    if-eqz v60, :cond_2d

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v60, v0

    const/16 v61, 0x0

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/DataConnectionManager;->functionForPacketDrop(Z)V

    :cond_2d
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_OTA_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_0

    invoke-virtual {v14}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v60

    const-string v61, "default"

    invoke-virtual/range {v60 .. v61}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-eqz v60, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    const/16 v61, 0x0

    move/from16 v0, v61

    move-object/from16 v1, v60

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->internetPDNconnected:Z

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] Default PDN Disonnected, internetPDNconnected = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v62, v0

    move-object/from16 v0, v62

    iget-boolean v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->internetPDNconnected:Z

    move/from16 v62, v0

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .end local v14    # "apnContext_done":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .end local v18    # "apnType_done":Ljava/lang/String;
    :sswitch_14
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[LGE_DATA] EVENT_APN_CHANGED = "

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SELECT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v60

    invoke-virtual/range {v60 .. v60}, Landroid/telephony/ServiceState;->getRadioTechnology()I

    move-result v60

    const/16 v61, 0xe

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v60

    const/16 v61, 0x6

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_0

    const v60, 0x4280b

    move-object/from16 v0, p0

    move/from16 v1, v60

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v60

    const-wide/16 v62, 0x2ee0

    move-object/from16 v0, p0

    move-object/from16 v1, v60

    move-wide/from16 v2, v62

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0

    :sswitch_15
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "EVENT_RECORDS_LOADED"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SELECT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnSelectionHdlr:Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;->setApnID()V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnSelectionHdlr:Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v61, v0

    move-object/from16 v0, v61

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnSelectionHdlr:Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;

    move-object/from16 v61, v0

    const-string v61, "Select_default_APN_between_domestic_and_roaming"

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/lgdata/ApnSelectionHandler;->selectApn(Ljava/lang/String;)V

    goto/16 :goto_0

    :sswitch_16
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    invoke-virtual/range {v60 .. v60}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v60

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "mobile_data"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v62, v0

    invoke-virtual/range {v62 .. v62}, Lcom/android/internal/telephony/PhoneBase;->getPhoneId()I

    move-result v62

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    const/16 v62, 0x1

    invoke-static/range {v60 .. v62}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v60

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_30

    const/16 v33, 0x1

    .local v33, "enabled":Z
    :goto_d
    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] CMD_SET_USER_DATA_ENABLE = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v33

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VOICE_PROTECTION_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_2e

    if-nez v33, :cond_2e

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    move-object/from16 v0, v60

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v60, v0

    const/16 v61, 0x0

    invoke-virtual/range {v60 .. v61}, Lcom/android/internal/telephony/DataConnectionManager;->functionForPacketDrop(Z)V

    :cond_2e
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v54

    .local v54, "roaming":Z
    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_MPDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_2f

    if-eqz v54, :cond_2f

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LTE_ROAMING_KT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    if-eqz v60, :cond_2f

    const-string v60, "[LGE_DATA][LGDCT] "

    new-instance v61, Ljava/lang/StringBuilder;

    invoke-direct/range {v61 .. v61}, Ljava/lang/StringBuilder;-><init>()V

    const-string v62, "[LGE_DATA] taegyu KT LTE Roaming roaming = "

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    move-object/from16 v0, v61

    move/from16 v1, v54

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v61

    const-string v62, "supprot ModeChange For POAB"

    invoke-virtual/range {v61 .. v62}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v61

    invoke-virtual/range {v61 .. v61}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v61

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    move/from16 v1, v33

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->changePreferrredNetworkMode(Z)V

    :cond_2f
    const-string v60, "true"

    const-string v61, "persist.radio.isroaming"

    invoke-static/range {v61 .. v61}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v61

    invoke-virtual/range {v60 .. v61}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v60

    if-nez v60, :cond_0

    sget-object v60, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NOTI_USERDATADISABLE_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v60

    const/16 v61, 0x1

    move/from16 v0, v60

    move/from16 v1, v61

    if-ne v0, v1, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    const-string v61, "notification"

    invoke-virtual/range {v60 .. v61}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v51

    check-cast v51, Landroid/app/NotificationManager;

    .restart local v51    # "notificationManager":Landroid/app/NotificationManager;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    sget v61, Lcom/lge/internal/R$string;->data_disable_body:I

    invoke-virtual/range {v60 .. v61}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v30

    .restart local v30    # "details":Ljava/lang/CharSequence;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v60

    sget v61, Lcom/lge/internal/R$string;->data_disable_title:I

    invoke-virtual/range {v60 .. v61}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v56

    .restart local v56    # "title":Ljava/lang/CharSequence;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    move-object/from16 v60, v0

    move-object/from16 v0, v56

    move-object/from16 v1, v60

    iput-object v0, v1, Landroid/app/Notification;->tickerText:Ljava/lang/CharSequence;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notification_intent:Landroid/content/Intent;

    move-object/from16 v61, v0

    const-string v62, "isRoaming"

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v60, v0

    invoke-virtual/range {v60 .. v60}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v60

    const/16 v63, 0x1

    move/from16 v0, v60

    move/from16 v1, v63

    if-ne v0, v1, :cond_31

    const/16 v60, 0x1

    :goto_e
    move-object/from16 v0, v61

    move-object/from16 v1, v62

    move/from16 v2, v60

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v61, v0

    invoke-virtual/range {v61 .. v61}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v61

    const/16 v62, 0x0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->notification_intent:Landroid/content/Intent;

    move-object/from16 v63, v0

    const/16 v64, 0x0

    invoke-static/range {v61 .. v64}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v61

    move-object/from16 v0, v61

    move-object/from16 v1, v60

    iput-object v0, v1, Landroid/app/Notification;->contentIntent:Landroid/app/PendingIntent;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    move-object/from16 v60, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v61, v0

    invoke-virtual/range {v61 .. v61}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v61

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    move-object/from16 v62, v0

    move-object/from16 v0, v62

    iget-object v0, v0, Landroid/app/Notification;->contentIntent:Landroid/app/PendingIntent;

    move-object/from16 v62, v0

    move-object/from16 v0, v60

    move-object/from16 v1, v61

    move-object/from16 v2, v56

    move-object/from16 v3, v30

    move-object/from16 v4, v62

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/app/Notification;->setLatestEventInfo(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Landroid/app/PendingIntent;)V

    if-eqz v33, :cond_32

    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[CMD_SET_USER_DATA_ENABLE]clean Notification"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v60, 0x9f6

    move-object/from16 v0, v51

    move/from16 v1, v60

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V

    goto/16 :goto_0

    .end local v30    # "details":Ljava/lang/CharSequence;
    .end local v33    # "enabled":Z
    .end local v51    # "notificationManager":Landroid/app/NotificationManager;
    .end local v54    # "roaming":Z
    .end local v56    # "title":Ljava/lang/CharSequence;
    :cond_30
    const/16 v33, 0x0

    goto/16 :goto_d

    .restart local v30    # "details":Ljava/lang/CharSequence;
    .restart local v33    # "enabled":Z
    .restart local v51    # "notificationManager":Landroid/app/NotificationManager;
    .restart local v54    # "roaming":Z
    .restart local v56    # "title":Ljava/lang/CharSequence;
    :cond_31
    const/16 v60, 0x0

    goto :goto_e

    :cond_32
    const-string v60, "[LGE_DATA][LGDCT] "

    const-string v61, "[CMD_SET_USER_DATA_ENABLE]setNotification: put notification"

    invoke-static/range {v60 .. v61}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v60, 0x9f6

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mNotification:Landroid/app/Notification;

    move-object/from16 v61, v0

    move-object/from16 v0, v51

    move/from16 v1, v60

    move-object/from16 v2, v61

    invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x42001 -> :sswitch_0
        0x42004 -> :sswitch_4
        0x42007 -> :sswitch_5
        0x42008 -> :sswitch_6
        0x42805 -> :sswitch_b
        0x42806 -> :sswitch_c
        0x42808 -> :sswitch_9
        0x4280a -> :sswitch_a
        0x4280b -> :sswitch_7
        0x4280c -> :sswitch_1
        0x4280d -> :sswitch_2
        0x4280f -> :sswitch_3
        0x42816 -> :sswitch_d
        0x42817 -> :sswitch_8
    .end sparse-switch

    :sswitch_data_1
    .sparse-switch
        0x42000 -> :sswitch_e
        0x42002 -> :sswitch_15
        0x42003 -> :sswitch_10
        0x4200b -> :sswitch_12
        0x4200c -> :sswitch_11
        0x4200d -> :sswitch_f
        0x4200f -> :sswitch_13
        0x42013 -> :sswitch_14
        0x4201e -> :sswitch_16
    .end sparse-switch
.end method

.method public isLTEDataRoamingAvailable()Z
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method protected pdpreject_causecode(Landroid/os/AsyncResult;)V
    .locals 10
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const/4 v8, 0x0

    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v6}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v4

    .local v4, "mContext":Landroid/content/Context;
    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v6, v6, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    const-string v7, "default"

    invoke-virtual {v6, v7}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v1, "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    const/4 v5, 0x0

    .local v5, "rawPdpRejectCuase":I
    iget-object v6, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v6, :cond_0

    iget-object v6, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v6, [I

    check-cast v6, [I

    aget v5, v6, v8

    :cond_0
    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v6}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v3

    .local v3, "isRoaming":Z
    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v6}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v6

    const-string v7, "airplane_mode_on"

    invoke-static {v6, v7, v8}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .local v0, "airplaneMode":I
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ") "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {v5}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->fromInt(I)Lcom/android/internal/telephony/dataconnection/DcFailCause;

    move-result-object v7

    invoke-virtual {v7}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .local v2, "causeValue":Ljava/lang/String;
    const-string v6, "[LGE_DATA][LGDCT] "

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "######## EVENT_DATA_ERROR_FAIL_CAUSE ("

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ")"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v6, v6, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    sget-object v7, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->debugFileWrite:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    const/4 v9, 0x4

    invoke-virtual {v6, v7, v8, v9}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v6

    const/4 v7, 0x2

    if-ne v6, v7, :cond_1

    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-virtual {v6}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isRoamingOOS()Z

    move-result v6

    if-eqz v6, :cond_1

    const/16 v6, 0x21

    if-ne v5, v6, :cond_1

    sget-object v6, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_REJECT_INTENT_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v6}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v6

    if-eqz v6, :cond_1

    const-string v6, "[LGE_DATA][LGDCT] "

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[LGE_DATA][PDP_reject] EVENT_DATA_ERROR_FAIL_CAUSE ("

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ")"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v6, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    iget-object v6, v6, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    invoke-virtual {v6, v5}, Lcom/android/internal/telephony/DataConnectionManager;->SendBroadcastPdpRejectCause(I)V

    :cond_1
    return-void
.end method

.method public setLTEDataRoamingEnable(Z)V
    .locals 4
    .param p1, "enable"    # Z

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->getLTEDataRoamingEnable()Z

    move-result v1

    if-eq v1, p1, :cond_0

    const-string v1, "[LGE_DATA][LGDCT] "

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setLTEDataRoamingEnable, enable="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .local v0, "resolver":Landroid/content/ContentResolver;
    const-string v2, "data_lte_roaming"

    if-eqz p1, :cond_1

    const/4 v1, 0x1

    :goto_0
    invoke-static {v0, v2, v1}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .end local v0    # "resolver":Landroid/content/ContentResolver;
    :cond_0
    return-void

    .restart local v0    # "resolver":Landroid/content/ContentResolver;
    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setLTEDataRoamingEnableNotApplyObserver(Z)V
    .locals 4
    .param p1, "enable"    # Z

    .prologue
    const-string v1, "[LGE_DATA][LGDCT] "

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setLTEDataRoamingEnableNotApplyObserver, enable="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mLTEDataRoamingSettingObserver:Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;->unregister(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .local v0, "resolver":Landroid/content/ContentResolver;
    const-string v2, "data_lte_roaming"

    if-eqz p1, :cond_0

    const/4 v1, 0x1

    :goto_0
    invoke-static {v0, v2, v1}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mLTEDataRoamingSettingObserver:Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDcTracker$LTEDataRoamingSettingObserver;->register(Landroid/content/Context;)V

    return-void

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method
