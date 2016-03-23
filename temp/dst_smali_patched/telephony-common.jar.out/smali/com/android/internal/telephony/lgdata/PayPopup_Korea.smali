.class public Lcom/android/internal/telephony/lgdata/PayPopup_Korea;
.super Landroid/os/Handler;
.source "PayPopup_Korea.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/lgdata/PayPopup_Korea$2;,
        Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;
    }
.end annotation


# static fields
.field public static final ALL_DATA_BLOCKED_SKT:I = 0x3

.field public static final CURRENT_MCC:Ljava/lang/String; = "current_mcc"

.field public static final DATA_DISABLE_WIFI_TO_3G_TRANSITION:I = 0xa

.field public static final DATA_ENABLE_WIFI_TO_3G_TRANSITION:I = 0x9

.field public static final DATA_NETWORK_USER_PAYPOPUP_RESPONSE:Ljava/lang/String; = "data_network_user_paypopup_response"

.field public static final DATA_NETWORK_USER_PAYPOPUP_TRANSITION_FROM_WIFI_TO_MOBILE:Ljava/lang/String; = "data_network_user_paypopup_transition_from_wifi_to_mobile"

.field public static final DATA_NETWORK_WAIT_FOR_PAYPOPUP_RESPONSE:Ljava/lang/String; = "data_network_wait_for_paypopup_response"

.field public static final DOMESTIC_DIALOG_LGT:I = 0x67

.field public static final DOMESTIC_DIALOG_SKT:I = 0x64

.field public static final DOMESTIC_ROAMING_DIALOG_KT:I = 0x66

.field private static final EVENT_CHECK_DELAY_BOOTCOMPELTE_FLAG:I = 0x2bc

.field private static final EVENT_DELAYED_TOAST_KT:I = 0x258

.field private static final EVENT_RESTART_FOR_FAILSETUP_BOOT:I = 0xc9

.field private static final EVENT_START_CHARGING_POPUP:I = 0xc8

.field private static final EVENT_START_CHARGING_POPUP_ROAM:I = 0xca

.field private static final LOG_TAG:Ljava/lang/String; = "[LGE_DATA][PayPopUp_ko] "

.field public static final MOBILE_DATA_ALLOWED_LGT:I = 0x7

.field public static final MOBILE_DATA_ALLOWED_SKT:I = 0x1

.field public static final MOBILE_DATA_BLOCKED_LGT:I = 0x8

.field public static final MOBILE_DATA_BLOCKED_SKT:I = 0x2

.field public static final MOBILE_DATA_SET_BLOCKED_MMS_SKT:I = 0x6

.field private static final NETWORKOPEN_DELAY_TIMER:I = 0x3e8

.field public static final OLD_MCC:Ljava/lang/String; = "intent_old_mcc"

.field private static final PAY_POPUP_IN_CASE_OF_BOOTING:Ljava/lang/String; = "booting"

.field private static final PAY_POPUP_IN_CASE_OF_NO_DISPLAY_POPUP:Ljava/lang/String; = "no_display_popup"

.field private static final PAY_POPUP_IN_CASE_OF_OTHERS:Ljava/lang/String; = "others"

.field private static final PAY_POPUP_IN_CASE_OF_WIFI_OFF:Ljava/lang/String; = "Wifi_off"

.field private static final PAY_POPUP_NOT_ALLOWED:I = 0x12e

.field private static final PAY_POPUP_NOT_ALLOWED_NOTBOOTED:I = 0x130

.field private static final PAY_POPUP_OKAY:I = 0x12f

.field private static final PAY_POPUP_WAITING_FOR_USER_RESPONSE:I = 0x12d

.field public static final PREFERRED_DATA_NETWORK_MODE:Ljava/lang/String; = "preferred_data_network_mode"

.field private static final RETRY_DOMESTIC_DIALOG_KT:I = 0x191

.field private static final RETRY_DOMESTIC_DIALOG_LGU:I = 0x192

.field private static final RETRY_DOMESTIC_DIALOG_SKT:I = 0x190

.field private static final RETRY_POPUP_SHOW_DELAY:I = 0x1f4

.field public static final ROAMING_DIALOG_LGT:I = 0x68

.field public static final ROAMING_DIALOG_SKT:I = 0x65

.field public static final ROAM_MOBILE_DATA_ALLOWED_SKT:I = 0x4

.field public static final ROAM_MOBILE_DATA_BLOCKED_SKT:I = 0x5

.field public static airplane_mode:I


# instance fields
.field featureset:Ljava/lang/String;

.field private global_new_mcc:Ljava/lang/String;

.field private global_old_mcc:Ljava/lang/String;

.field private intent_reset:Z

.field private mActiveDomesticPopup:Z

.field private mActiveRoamingPopup:Z

.field private mConnMgr:Landroid/net/ConnectivityManager;

.field private mContext:Landroid/content/Context;

.field private mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

.field private mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

.field mIntentReceiver:Landroid/content/BroadcastReceiver;

.field public mIsok_bypass:Z

.field private mMobileEnabled:Z

.field private mPhone:Lcom/android/internal/telephony/Phone;

.field private mPhoneMgr:Lcom/android/internal/telephony/ITelephony;

.field private mResolver:Landroid/content/ContentResolver;

.field mStatus:Z

.field private mTeleMgr:Landroid/telephony/TelephonyManager;

.field private mWifiServiceExt:Lcom/lge/wifi/extension/IWifiServiceExtension;

.field private mbooting_phone:Z

.field public retryStartActivityForPopup:I

.field private roam_to_domestic_popup_need:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, -0x1

    sput v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->airplane_mode:I

    return-void
.end method

.method public constructor <init>(Lcom/android/internal/telephony/dataconnection/DcTracker;Lcom/android/internal/telephony/PhoneBase;)V
    .locals 4
    .param p1, "dct"    # Lcom/android/internal/telephony/dataconnection/DcTracker;
    .param p2, "p"    # Lcom/android/internal/telephony/PhoneBase;

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    const-string v1, "000"

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->global_new_mcc:Ljava/lang/String;

    const-string v1, "000"

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->global_old_mcc:Ljava/lang/String;

    iput-boolean v2, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->roam_to_domestic_popup_need:Z

    const/4 v1, 0x5

    iput v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->retryStartActivityForPopup:I

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    iput-boolean v2, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mIsok_bypass:Z

    iput-boolean v2, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mActiveDomesticPopup:Z

    iput-boolean v2, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mActiveRoamingPopup:Z

    iput-boolean v2, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mStatus:Z

    iput-boolean v2, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mMobileEnabled:Z

    invoke-static {}, Lcom/lge/wifi/extension/LgWifiManager;->getWifiServiceExtIface()Lcom/lge/wifi/extension/IWifiServiceExtension;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mWifiServiceExt:Lcom/lge/wifi/extension/IWifiServiceExtension;

    iput-boolean v2, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->intent_reset:Z

    new-instance v1, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;

    invoke-direct {v1, p0}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;-><init>(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)V

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    const-string v1, "[LGE_DATA][PayPopUp_ko] "

    const-string v2, "PayPopup_Korea() has created"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "ro.afwdata.LGfeatureset"

    const-string v2, "none"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    iput-object p1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iput-object p2, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v1}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "connectivity"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/ConnectivityManager;

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mConnMgr:Landroid/net/ConnectivityManager;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v1}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "phone"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/telephony/TelephonyManager;

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mTeleMgr:Landroid/telephony/TelephonyManager;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v1}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/DataConnectionManager;->getInstance(Landroid/content/Context;)Lcom/android/internal/telephony/DataConnectionManager;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v1}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mResolver:Landroid/content/ContentResolver;

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "com.lge.DataEnabledSettingBootableSKT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.DataNetworkModePayPopupKT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.DataNetworkModePayPopupLGT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.net.conn.STARTING_IN_DATA_SETTING_DISABLE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.net.conn.STARTING_IN_ROAM_SETTING_DISABLE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.net.conn.STARTING_IN_DATA_SETTING_DISABLE_3GONLY"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.net.conn.DATA_DATA_BLOCK_IN_MMS"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "lge.intent.action.LGE_WIFI_3G_TRANSITION"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v2, "LGTBASE"

    invoke-static {v1, v2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v2, "SKTBASE"

    invoke-static {v1, v2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    :cond_0
    const-string v1, "com.lge.intent.action.LGE_CAMPED_MCC_CHANGE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.AIRPLANE_MODE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    :cond_1
    const-string v1, "android.net.conn.CONNECTIVITY_CHANGE_IMMEDIATE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.lge.intent.action.OTA_USIM_REFRESH_TO_RESET"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.BOOT_COMPLETED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v1}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v0, v3, p0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;

    return-void
.end method

.method private PayPopupforFeature(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;Ljava/lang/String;Ljava/lang/String;Z)I
    .locals 31
    .param p1, "funcName"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;
    .param p2, "reason"    # Ljava/lang/String;
    .param p3, "apntype"    # Ljava/lang/String;
    .param p4, "force_bootcomplete"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    const/4 v15, 0x0

    .local v15, "in_prog_bypass":Z
    sget-object v26, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v26

    if-eqz v26, :cond_2

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/dataconnection/DcTracker;->isRoamingOOS()Z

    move-result v26

    if-nez v26, :cond_2

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "LGP_DATA_IMS_KR TYPE type :: "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-object/from16 v1, p3

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    move-object/from16 v0, v26

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTracker;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v26, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v27, v0

    const/16 v28, 0x5

    invoke-virtual/range {v27 .. v28}, Lcom/android/internal/telephony/dataconnection/DcTracker;->apnIdToType(I)Ljava/lang/String;

    move-result-object v27

    invoke-virtual/range {v26 .. v27}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v14, "ims_type":Lcom/android/internal/telephony/dataconnection/ApnContext;
    if-eqz p3, :cond_0

    const-string v26, "ims"

    move-object/from16 v0, p3

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_0

    if-eqz v14, :cond_0

    invoke-virtual {v14}, Lcom/android/internal/telephony/dataconnection/ApnContext;->isEnabled()Z

    move-result v26

    if-eqz v26, :cond_0

    const/4 v15, 0x1

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "MPDN (IMS) TYPE :: "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->PayPopupforLGT:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    move-object/from16 v0, p1

    move-object/from16 v1, v26

    if-ne v0, v1, :cond_1

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    move-object/from16 v0, v26

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTracker;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v26, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v27, v0

    const/16 v28, 0x13

    invoke-virtual/range {v27 .. v28}, Lcom/android/internal/telephony/dataconnection/DcTracker;->apnIdToType(I)Ljava/lang/String;

    move-result-object v27

    invoke-virtual/range {v26 .. v27}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v22

    check-cast v22, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v22, "tethering_type":Lcom/android/internal/telephony/dataconnection/ApnContext;
    if-eqz p3, :cond_1

    const-string v26, "tethering"

    move-object/from16 v0, p3

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_1

    if-eqz v22, :cond_1

    invoke-virtual/range {v22 .. v22}, Lcom/android/internal/telephony/dataconnection/ApnContext;->isEnabled()Z

    move-result v26

    if-eqz v26, :cond_1

    const/4 v15, 0x1

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "MPDN U+ (TETHERING) TYPE :: "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v22    # "tethering_type":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :cond_1
    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->PayPopupforLGT:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    move-object/from16 v0, p1

    move-object/from16 v1, v26

    if-ne v0, v1, :cond_2

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    move-object/from16 v0, v26

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTracker;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v26, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v27, v0

    const/16 v28, 0x9

    invoke-virtual/range {v27 .. v28}, Lcom/android/internal/telephony/dataconnection/DcTracker;->apnIdToType(I)Ljava/lang/String;

    move-result-object v27

    invoke-virtual/range {v26 .. v27}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v10, "emergency_type":Lcom/android/internal/telephony/dataconnection/ApnContext;
    if-eqz p3, :cond_2

    const-string v26, "emergency"

    move-object/from16 v0, p3

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_2

    if-eqz v10, :cond_2

    invoke-virtual {v10}, Lcom/android/internal/telephony/dataconnection/ApnContext;->isEnabled()Z

    move-result v26

    if-eqz v26, :cond_2

    const/4 v15, 0x1

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "MPDN U+ (EMERGENCY) TYPE :: "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v10    # "emergency_type":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .end local v14    # "ims_type":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :cond_2
    sget-object v26, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_MMS_APN_MENU_NOT_CONRTOL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v26

    if-eqz v26, :cond_4

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/dataconnection/DcTracker;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v26

    const-string v27, "45008"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-nez v26, :cond_3

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/dataconnection/DcTracker;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v26

    const-string v27, "45005"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_4

    :cond_3
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/dataconnection/DcTracker;->isRoamingOOS()Z

    move-result v26

    if-nez v26, :cond_4

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    move-object/from16 v0, v26

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTracker;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v26, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v27, v0

    const/16 v28, 0x1

    invoke-virtual/range {v27 .. v28}, Lcom/android/internal/telephony/dataconnection/DcTracker;->apnIdToType(I)Ljava/lang/String;

    move-result-object v27

    invoke-virtual/range {v26 .. v27}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v18

    check-cast v18, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v18, "mms_type":Lcom/android/internal/telephony/dataconnection/ApnContext;
    if-eqz p3, :cond_4

    const-string v26, "mms"

    move-object/from16 v0, p3

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_4

    if-eqz v18, :cond_4

    invoke-virtual/range {v18 .. v18}, Lcom/android/internal/telephony/dataconnection/ApnContext;->isEnabled()Z

    move-result v26

    if-eqz v26, :cond_4

    const/4 v15, 0x1

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "MPDN (MMS) TYPE in_prog_bypass = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v18    # "mms_type":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :cond_4
    const-string v26, "sys.boot_completed"

    invoke-static/range {v26 .. v26}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v26

    const-string v27, "1"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    .local v8, "boot_completed":Z
    const/16 v26, 0x1

    move/from16 v0, p4

    move/from16 v1, v26

    if-ne v0, v1, :cond_5

    const/4 v8, 0x1

    :cond_5
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "[LGE_DATA]"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "], boot_completed["

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "]"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "force_bootcomplete : "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move/from16 v1, p4

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v8, 0x1

    if-nez v15, :cond_7

    if-nez v8, :cond_7

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "retry PayPopup due to in_prog_bypass["

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "], boot_completed["

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "]"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x2bc

    move-object/from16 v0, p0

    move/from16 v1, v26

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->hasMessages(I)Z

    move-result v26

    if-nez v26, :cond_6

    const/16 v26, 0x2bc

    move-object/from16 v0, p0

    move/from16 v1, v26

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->obtainMessage(I)Landroid/os/Message;

    move-result-object v26

    const-wide/16 v28, 0x2710

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move-wide/from16 v2, v28

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->sendMessageDelayed(Landroid/os/Message;J)Z

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "sendMessageDelayed EVENT_CHECK_DELAY_BOOTCOMPELTE_FLAG, 10"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_6
    const/16 v26, 0x12e

    :goto_0
    return v26

    :cond_7
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "[LGE_DATA]  boot_completed["

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "]"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v17, "/persist-lg/fota/silence_LCDoff.txt"

    .local v17, "mSilentResetFilePath":Ljava/lang/String;
    new-instance v20, Ljava/io/File;

    move-object/from16 v0, v20

    move-object/from16 v1, v17

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .local v20, "silentFile":Ljava/io/File;
    const-string v26, "ro.lge.hiddenreset"

    invoke-static/range {v26 .. v26}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v26

    const-string v27, "1"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    .local v12, "hiddenreset":Z
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "TEST-1 : File of silence.txt is in fota :"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v20 .. v20}, Ljava/io/File;->exists()Z

    move-result v28

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "hiddenreset :: "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "TEST-1 : data_network_user_data_disable_setting :"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v28, v0

    invoke-interface/range {v28 .. v28}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v28

    invoke-virtual/range {v28 .. v28}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v28

    const-string v29, "data_network_user_data_disable_setting"

    const/16 v30, 0x0

    invoke-static/range {v28 .. v30}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v28

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {v20 .. v20}, Ljava/io/File;->exists()Z

    move-result v26

    if-eqz v26, :cond_8

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v26, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-eq v0, v1, :cond_9

    :cond_8
    if-eqz v12, :cond_c

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v26, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_c

    :cond_9
    if-eqz v12, :cond_a

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "hiddenreset is true~!!!!"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_1
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v26, v0

    sget-object v27, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->getDataNetworkMode:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v28, ""

    const/16 v29, 0x1

    invoke-virtual/range {v26 .. v29}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    move-result v26

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v27, v0

    const/16 v27, 0x3

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_c

    const-string v26, "net.Is_phone_booted"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_user_data_disable_setting"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v24

    .local v24, "user_setting":I
    if-nez v24, :cond_b

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    const/16 v27, 0x0

    move/from16 v0, v27

    move-object/from16 v1, v26

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTracker;->mUserDataEnabled:Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mTeleMgr:Landroid/telephony/TelephonyManager;

    move-object/from16 v26, v0

    const/16 v27, 0x0

    invoke-virtual/range {v26 .. v27}, Landroid/telephony/TelephonyManager;->setDataEnabled(Z)V

    const/16 v26, 0x12d

    goto/16 :goto_0

    .end local v24    # "user_setting":I
    :cond_a
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "File of silence.txt is in fota"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .restart local v24    # "user_setting":I
    :cond_b
    const/16 v26, 0x12f

    goto/16 :goto_0

    .end local v24    # "user_setting":I
    :cond_c
    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$2;->$SwitchMap$com$android$internal$telephony$lgdata$PayPopup_Korea$PayPopupFunction:[I

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->ordinal()I

    move-result v27

    aget v26, v26, v27

    packed-switch v26, :pswitch_data_0

    const/16 v26, 0x0

    goto/16 :goto_0

    :pswitch_0
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "PayPopupforSKT()"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "in_prog_bypass :: "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    move-object/from16 v0, v26

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTracker;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v26, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v27, v0

    const/16 v28, 0x1

    invoke-virtual/range {v27 .. v28}, Lcom/android/internal/telephony/dataconnection/DcTracker;->apnIdToType(I)Ljava/lang/String;

    move-result-object v27

    invoke-virtual/range {v26 .. v27}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v6, "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    if-eqz v6, :cond_d

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v26, v0

    sget-object v27, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->getDataNetworkMode:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v28, ""

    const/16 v29, 0x0

    invoke-virtual/range {v26 .. v29}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    move-result v26

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v27, v0

    const/16 v27, 0x2

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_d

    invoke-virtual {v6}, Lcom/android/internal/telephony/dataconnection/ApnContext;->isEnabled()Z

    move-result v26

    if-eqz v26, :cond_d

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "SINGLE SKT (MMS) TYPE  :: "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v15, 0x1

    :cond_d
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "in_prog_bypass :: "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v15, :cond_17

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/dataconnection/DcTracker;->isRoamingOOS()Z

    move-result v26

    if-eqz v26, :cond_18

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "<PayPopupforSKT()> roaming = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v28, v0

    invoke-virtual/range {v28 .. v28}, Lcom/android/internal/telephony/dataconnection/DcTracker;->isRoamingOOS()Z

    move-result v28

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, " mbooting_phone = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v28, v0

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, ", airplane_mode = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    sget v28, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->airplane_mode:I

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v26, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-eq v0, v1, :cond_e

    sget v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->airplane_mode:I

    if-nez v26, :cond_f

    :cond_e
    const-string v26, "net.Is_phone_booted"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const/16 v26, -0x1

    sput v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->airplane_mode:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    const/16 v27, 0x0

    invoke-virtual/range {v26 .. v27}, Lcom/android/internal/telephony/dataconnection/DcTracker;->DataOnRoamingEnabled_OnlySel(Z)V

    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showDialog:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x65

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    const/16 v26, 0x12d

    goto/16 :goto_0

    :cond_f
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "<PayPopupforSKT()>  allows as roam toast : : reason =  "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v5, 0x0

    .local v5, "NoShowToastRoaming":Z
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    move-object/from16 v0, v26

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTracker;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Ljava/util/concurrent/ConcurrentHashMap;->values()Ljava/util/Collection;

    move-result-object v26

    invoke-interface/range {v26 .. v26}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v13

    .local v13, "i$":Ljava/util/Iterator;
    :cond_10
    :goto_2
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v26

    if-eqz v26, :cond_13

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v21

    check-cast v21, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .local v21, "tempContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getState()Lcom/android/internal/telephony/DctConstants$State;

    move-result-object v26

    sget-object v27, Lcom/android/internal/telephony/DctConstants$State;->CONNECTED:Lcom/android/internal/telephony/DctConstants$State;

    move-object/from16 v0, v26

    move-object/from16 v1, v27

    if-ne v0, v1, :cond_10

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v26

    const-string v27, "ims"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-nez v26, :cond_11

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v26

    const-string v27, "mms"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_12

    :cond_11
    const/4 v5, 0x0

    goto :goto_2

    :cond_12
    const/4 v5, 0x1

    .end local v21    # "tempContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :cond_13
    const-string v26, "ims"

    move-object/from16 v0, p3

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-nez v26, :cond_14

    const-string v26, "mms"

    move-object/from16 v0, p3

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_15

    :cond_14
    const/4 v5, 0x1

    :cond_15
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "NoShowToast = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v5, :cond_17

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "<PayPopupforSKT()> toast show check reason = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "and type = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-object/from16 v1, p3

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "roamingOn"

    move-object/from16 v0, v26

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-nez v26, :cond_16

    const-string v26, "apnChanged"

    move-object/from16 v0, v26

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-nez v26, :cond_16

    const-string v26, "dataEnabled"

    move-object/from16 v0, v26

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_17

    :cond_16
    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x4

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    .end local v5    # "NoShowToastRoaming":Z
    .end local v13    # "i$":Ljava/util/Iterator;
    :cond_17
    :goto_3
    const/16 v26, 0x12f

    goto/16 :goto_0

    :cond_18
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "<PayPopupforSKT()>  mbooting_phone = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v28, v0

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v26, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_1c

    const-string v26, "net.Is_phone_booted"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v26, v0

    sget-object v27, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->getDataNetworkMode:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v28, ""

    const/16 v29, 0x1

    invoke-virtual/range {v26 .. v29}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    move-result v26

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v27, v0

    const/16 v27, 0x3

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_1a

    const-string v26, "sys.factory.qem"

    const/16 v27, 0x0

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v11

    .local v11, "factory_qem":Z
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "[LGE_DATA] factory_qem["

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "]"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x1

    move/from16 v0, v26

    if-ne v11, v0, :cond_19

    sget-object v26, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_BLOCK_PAYPOPUP_BUT_TRYSETUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v26

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_19

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "[LGE_DATA] QEM mode, blocking data call and don\'t show charging popup"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12f

    goto/16 :goto_0

    :cond_19
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "<PayPopupforSKT()> DCM_MOBILE_NETWORK_IS_NEED_POPUP : mUserDataEnabled = false / MOBILE_DATA = false."

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    const/16 v27, 0x0

    move/from16 v0, v27

    move-object/from16 v1, v26

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTracker;->mUserDataEnabled:Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mTeleMgr:Landroid/telephony/TelephonyManager;

    move-object/from16 v26, v0

    const/16 v27, 0x0

    invoke-virtual/range {v26 .. v27}, Landroid/telephony/TelephonyManager;->setDataEnabled(Z)V

    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showDialog:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x64

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    const/16 v26, 0x12d

    goto/16 :goto_0

    .end local v11    # "factory_qem":Z
    :cond_1a
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v26, v0

    sget-object v27, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->getDataNetworkMode:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v28, ""

    const/16 v29, 0x1

    invoke-virtual/range {v26 .. v29}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    move-result v26

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v27, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_1b

    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    goto/16 :goto_3

    :cond_1b
    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x3

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    const/16 v26, 0x12e

    goto/16 :goto_0

    :cond_1c
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v26, v0

    sget-object v27, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->getDataNetworkMode:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v28, ""

    const/16 v29, 0x0

    invoke-virtual/range {v26 .. v29}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    move-result v26

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v27, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_24

    const/4 v4, 0x0

    .local v4, "NoShowToast":Z
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    move-object/from16 v0, v26

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTracker;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Ljava/util/concurrent/ConcurrentHashMap;->values()Ljava/util/Collection;

    move-result-object v26

    invoke-interface/range {v26 .. v26}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v13

    .restart local v13    # "i$":Ljava/util/Iterator;
    :cond_1d
    :goto_4
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v26

    if-eqz v26, :cond_20

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v21

    check-cast v21, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .restart local v21    # "tempContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getState()Lcom/android/internal/telephony/DctConstants$State;

    move-result-object v26

    sget-object v27, Lcom/android/internal/telephony/DctConstants$State;->CONNECTED:Lcom/android/internal/telephony/DctConstants$State;

    move-object/from16 v0, v26

    move-object/from16 v1, v27

    if-ne v0, v1, :cond_1d

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v26

    const-string v27, "ims"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-nez v26, :cond_1e

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v26

    const-string v27, "mms"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_1f

    :cond_1e
    const/4 v4, 0x0

    goto :goto_4

    :cond_1f
    const/4 v4, 0x1

    .end local v21    # "tempContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :cond_20
    if-eqz p3, :cond_22

    const-string v26, "ims"

    move-object/from16 v0, p3

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-nez v26, :cond_21

    const-string v26, "mms"

    move-object/from16 v0, p3

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_22

    :cond_21
    const/4 v4, 0x1

    :cond_22
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "NoShowToast = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v4, :cond_17

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "<PayPopupforSKT()> toast show check reason = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "and type = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-object/from16 v1, p3

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "dataEnabled"

    move-object/from16 v0, v26

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-nez v26, :cond_23

    const-string v26, "apnChanged"

    move-object/from16 v0, v26

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_17

    :cond_23
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "<PayPopupforSKT()> show_allow_toast_pupop  :: "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    goto/16 :goto_3

    .end local v4    # "NoShowToast":Z
    .end local v13    # "i$":Ljava/util/Iterator;
    :cond_24
    const/16 v26, 0x12e

    goto/16 :goto_0

    .end local v6    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :pswitch_1
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "PayPopupforKT()"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "in_prog_bypass :: "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v9, 0x0

    .local v9, "data_disable_by_paypopup":Z
    if-nez v15, :cond_2e

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v26, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_25

    const-string v26, "net.Is_phone_booted"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_wait_for_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_user_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    :cond_25
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_wait_for_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v16

    .local v16, "is_waiting":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_user_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v23

    .local v23, "user_response":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "preferred_data_network_mode"

    const/16 v28, 0x1

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v7

    .local v7, "ask_at_boot":I
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "trySetupData with reason = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "trySetupData with is_waiting = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "trySetupData with user_choice = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "trySetupData with ask at boot ="

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x1

    move/from16 v0, v16

    move/from16 v1, v26

    if-ne v0, v1, :cond_28

    if-nez v23, :cond_26

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "PayPopupforKT is waiting for user response"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12d

    goto/16 :goto_0

    :cond_26
    const/16 v26, 0x2

    move/from16 v0, v23

    move/from16 v1, v26

    if-ne v0, v1, :cond_28

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_wait_for_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_user_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "PayPopupforKT is accpeted by user"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "persist.lg.data.popup_disable"

    const/16 v27, 0x1

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v9

    if-eqz v9, :cond_27

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "persist.lg.data.popup_disable : false"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "persist.lg.data.popup_disable"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :cond_27
    const/16 v26, 0x12f

    goto/16 :goto_0

    :cond_28
    const-string v26, "persist.lg.data.popup_disable"

    const/16 v27, 0x1

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v9

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mConnMgr:Landroid/net/ConnectivityManager;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Landroid/net/ConnectivityManager;->getMobileDataEnabled()Z

    move-result v26

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-eq v0, v1, :cond_29

    if-eqz v9, :cond_2c

    :cond_29
    const/16 v26, 0x1

    move/from16 v0, v26

    if-ne v7, v0, :cond_2c

    const-string v26, "booting"

    move-object/from16 v0, v26

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-nez v26, :cond_2a

    const-string v26, "Wifi_off"

    move-object/from16 v0, v26

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_2c

    :cond_2a
    const-string v26, "sys.factory.qem"

    const/16 v27, 0x0

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v11

    .restart local v11    # "factory_qem":Z
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "[LGE_DATA] factory_qem["

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, "]"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x1

    move/from16 v0, v26

    if-ne v11, v0, :cond_2b

    sget-object v26, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_BLOCK_PAYPOPUP_BUT_TRYSETUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v26

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_2b

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "[LGE_DATA] QEM mode, blocking data call and don\'t show charging popup"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12f

    goto/16 :goto_0

    :cond_2b
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    const/16 v27, 0x0

    move/from16 v0, v27

    move-object/from16 v1, v26

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTracker;->mUserDataEnabled:Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mTeleMgr:Landroid/telephony/TelephonyManager;

    move-object/from16 v26, v0

    const/16 v27, 0x0

    invoke-virtual/range {v26 .. v27}, Landroid/telephony/TelephonyManager;->setDataEnabled(Z)V

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "persist.lg.data.popup_disable : true"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "persist.lg.data.popup_disable"

    const-string v27, "true"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showDialog:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x66

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_wait_for_paypopup_response"

    const/16 v28, 0x1

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "DATA_NETWORK_WAIT_FOR_PAYPOPUP_RESPONSE : "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v28, v0

    invoke-interface/range {v28 .. v28}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v28

    invoke-virtual/range {v28 .. v28}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v28

    const-string v29, "data_network_wait_for_paypopup_response"

    const/16 v30, 0x0

    invoke-static/range {v28 .. v30}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v28

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "PayPopupforKT is asking for the response from use"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12d

    goto/16 :goto_0

    .end local v11    # "factory_qem":Z
    :cond_2c
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mConnMgr:Landroid/net/ConnectivityManager;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Landroid/net/ConnectivityManager;->getMobileDataEnabled()Z

    move-result v26

    if-nez v26, :cond_2d

    const/16 v26, 0x12e

    goto/16 :goto_0

    :cond_2d
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, " PayPopup is just pass not asking "

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "persist.lg.data.popup_disable"

    const/16 v27, 0x1

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v9

    if-eqz v9, :cond_2e

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "persist.lg.data.popup_disable : false"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "persist.lg.data.popup_disable"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .end local v7    # "ask_at_boot":I
    .end local v16    # "is_waiting":I
    .end local v23    # "user_response":I
    :cond_2e
    const/16 v26, 0x12f

    goto/16 :goto_0

    .end local v9    # "data_disable_by_paypopup":Z
    :pswitch_2
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "PayPopupforLGT()"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "in_prog_bypass :: "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v25, ""

    .local v25, "usim_mcc":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/dataconnection/DcTracker;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v26

    if-eqz v26, :cond_2f

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/dataconnection/DcTracker;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Ljava/lang/String;->length()I

    move-result v26

    const/16 v27, 0x3

    move/from16 v0, v26

    move/from16 v1, v27

    if-le v0, v1, :cond_2f

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/dataconnection/DcTracker;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v26

    const/16 v27, 0x0

    const/16 v28, 0x3

    invoke-virtual/range {v26 .. v28}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v25

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "paypopup_usim_mcc"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2f
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v26, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_30

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v26, v0

    sget-object v27, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->getDataNetworkMode:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v28, ""

    const/16 v29, 0x1

    invoke-virtual/range {v26 .. v29}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    move-result v19

    .local v19, "mode":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v26, v0

    const/16 v26, 0x2

    move/from16 v0, v19

    move/from16 v1, v26

    if-ne v0, v1, :cond_30

    const-string v26, "net.Is_phone_booted"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "1st boot case, and just showing data blocked toast"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x8

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    .end local v19    # "mode":I
    :cond_30
    if-nez v15, :cond_3f

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v26, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_31

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_wait_for_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_user_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    :cond_31
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/dataconnection/DcTracker;->isRoamingOOS()Z

    move-result v26

    if-eqz v26, :cond_33

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mActiveDomesticPopup:Z

    move/from16 v26, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_32

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_wait_for_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_user_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const/16 v26, 0x0

    move/from16 v0, v26

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mActiveDomesticPopup:Z

    :cond_32
    :goto_5
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v26, v0

    sget-object v27, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->getDataNetworkMode:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v28, ""

    const/16 v29, 0x1

    invoke-virtual/range {v26 .. v29}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    move-result v19

    .restart local v19    # "mode":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_wait_for_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v16

    .restart local v16    # "is_waiting":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_user_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v23

    .restart local v23    # "user_response":I
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "trySetupData with mode="

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "trySetupData with is_waiting="

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "trySetupData with user_choice="

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "trySetupData with booting="

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v28, v0

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x1

    move/from16 v0, v16

    move/from16 v1, v26

    if-ne v0, v1, :cond_36

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "mobile_data"

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v28, v0

    invoke-interface/range {v28 .. v28}, Lcom/android/internal/telephony/Phone;->getPhoneId()I

    move-result v28

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v26

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_34

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_wait_for_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_user_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "When is_wating == 1 and hide paypopup so connect force!!"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12f

    goto/16 :goto_0

    .end local v16    # "is_waiting":I
    .end local v19    # "mode":I
    .end local v23    # "user_response":I
    :cond_33
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mActiveRoamingPopup:Z

    move/from16 v26, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_32

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_wait_for_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_user_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const/16 v26, 0x0

    move/from16 v0, v26

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mActiveRoamingPopup:Z

    goto/16 :goto_5

    .restart local v16    # "is_waiting":I
    .restart local v19    # "mode":I
    .restart local v23    # "user_response":I
    :cond_34
    if-nez v23, :cond_35

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "PayPopupforLGT is waiting for user response"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12d

    goto/16 :goto_0

    :cond_35
    const/16 v26, 0x2

    move/from16 v0, v23

    move/from16 v1, v26

    if-ne v0, v1, :cond_36

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_wait_for_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_user_paypopup_response"

    const/16 v28, 0x0

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "PayPopupforLGT is accpeted by user"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12f

    goto/16 :goto_0

    :cond_36
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/dataconnection/DcTracker;->isRoamingOOS()Z

    move-result v26

    if-eqz v26, :cond_39

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "abnormal case, it\'s ROAMING state"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->airplane_mode:I

    if-eqz v26, :cond_37

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v26, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_38

    :cond_37
    const-string v26, "net.Is_phone_booted"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const/16 v26, -0x1

    sput v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->airplane_mode:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    const/16 v27, 0x0

    invoke-interface/range {v26 .. v27}, Lcom/android/internal/telephony/Phone;->setDataRoamingEnabled(Z)V

    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showDialog:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x68

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    const/16 v26, 0x1

    move/from16 v0, v26

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mActiveRoamingPopup:Z

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "starting.. roaming query popup"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12d

    goto/16 :goto_0

    :cond_38
    const-string v26, "net.Is_phone_booted"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "RoamingPopup is not booting or ask at boot"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12f

    goto/16 :goto_0

    :cond_39
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "normal case, it\'s not roaming state"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    move/from16 v26, v0

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_3d

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v26, v0

    const/16 v26, 0x3

    move/from16 v0, v19

    move/from16 v1, v26

    if-ne v0, v1, :cond_3b

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "1st boot case, and need to show pay popup !!!"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v26, "net.Is_phone_booted"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v26, "sys.factory.qem"

    const/16 v27, 0x0

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v11

    .restart local v11    # "factory_qem":Z
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "[LGE_DATA] factory_qem = "

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, v27

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x1

    move/from16 v0, v26

    if-ne v11, v0, :cond_3a

    sget-object v26, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_BLOCK_PAYPOPUP_BUT_TRYSETUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v26 .. v26}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v26

    const/16 v27, 0x1

    move/from16 v0, v26

    move/from16 v1, v27

    if-ne v0, v1, :cond_3a

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "[LGE_DATA] QEM mode, blocking data call and don\'t show charging popup"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12f

    goto/16 :goto_0

    :cond_3a
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-object/from16 v26, v0

    const/16 v27, 0x0

    move/from16 v0, v27

    move-object/from16 v1, v26

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTracker;->mUserDataEnabled:Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mTeleMgr:Landroid/telephony/TelephonyManager;

    move-object/from16 v26, v0

    const/16 v27, 0x0

    invoke-virtual/range {v26 .. v27}, Landroid/telephony/TelephonyManager;->setDataEnabled(Z)V

    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showDialog:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x67

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    const/16 v26, 0x1

    move/from16 v0, v26

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mActiveDomesticPopup:Z

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    move-object/from16 v26, v0

    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v26

    const-string v27, "data_network_wait_for_paypopup_response"

    const/16 v28, 0x1

    invoke-static/range {v26 .. v28}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "PayPopupforLGT is asking for the response from use"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12d

    goto/16 :goto_0

    .end local v11    # "factory_qem":Z
    :cond_3b
    const-string v26, "net.Is_phone_booted"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDcMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v26, v0

    const/16 v26, 0x1

    move/from16 v0, v19

    move/from16 v1, v26

    if-ne v0, v1, :cond_3c

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "1st boot case, and just showing data allowed toast"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x7

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    :goto_6
    const/16 v26, 0x12f

    goto/16 :goto_0

    :cond_3c
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "1st boot case, and just showing data blocked toast"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v26, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v27, 0x8

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V

    goto :goto_6

    :cond_3d
    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    new-instance v27, Ljava/lang/StringBuilder;

    invoke-direct/range {v27 .. v27}, Ljava/lang/StringBuilder;-><init>()V

    const-string v28, "[LGE_DATA_ROAMING] global_new_mcc="

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->global_new_mcc:Ljava/lang/String;

    move-object/from16 v28, v0

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    const-string v28, ", roam_to_domestic_popup_need="

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v27

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->roam_to_domestic_popup_need:Z

    move/from16 v28, v0

    invoke-virtual/range {v27 .. v28}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v27

    invoke-virtual/range {v27 .. v27}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v27

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->global_new_mcc:Ljava/lang/String;

    move-object/from16 v26, v0

    const-string v27, "450"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-nez v26, :cond_3e

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->global_new_mcc:Ljava/lang/String;

    move-object/from16 v26, v0

    const-string v27, "000"

    invoke-virtual/range {v26 .. v27}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-nez v26, :cond_3e

    const-string v26, "450"

    move-object/from16 v0, v26

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v26

    if-eqz v26, :cond_3e

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "[LGE_DATA_ROAMING] payPopupforLGT is not booting, PAY_POPUP_NOT_ALLOWED before mcc_change from roam to domestic"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x1

    move/from16 v0, v26

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->roam_to_domestic_popup_need:Z

    const/16 v26, 0x12e

    goto/16 :goto_0

    :cond_3e
    const-string v26, "net.Is_phone_booted"

    const-string v27, "false"

    invoke-static/range {v26 .. v27}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v26, "[LGE_DATA][PayPopUp_ko] "

    const-string v27, "PayPopupforLGT is not booting or ask at boot"

    invoke-static/range {v26 .. v27}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v26, 0x12f

    goto/16 :goto_0

    .end local v16    # "is_waiting":I
    .end local v19    # "mode":I
    .end local v23    # "user_response":I
    :cond_3f
    const/16 v26, 0x12f

    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    return-object v0
.end method

.method static synthetic access$102(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->global_new_mcc:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$202(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->global_old_mcc:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    .prologue
    iget-boolean v0, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->roam_to_domestic_popup_need:Z

    return v0
.end method

.method static synthetic access$302(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->roam_to_domestic_popup_need:Z

    return p1
.end method

.method static synthetic access$400(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    .prologue
    iget-boolean v0, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mMobileEnabled:Z

    return v0
.end method

.method static synthetic access$402(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mMobileEnabled:Z

    return p1
.end method

.method static synthetic access$500(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Landroid/net/ConnectivityManager;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mConnMgr:Landroid/net/ConnectivityManager;

    return-object v0
.end method

.method static synthetic access$600(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/lge/wifi/extension/IWifiServiceExtension;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mWifiServiceExt:Lcom/lge/wifi/extension/IWifiServiceExtension;

    return-object v0
.end method

.method static synthetic access$702(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->intent_reset:Z

    return p1
.end method

.method static synthetic access$800(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    .prologue
    iget-boolean v0, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    return v0
.end method

.method static synthetic access$802(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    return p1
.end method

.method static synthetic access$900(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/dataconnection/DcTracker;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    return-object v0
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 10
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v9, 0x0

    const/4 v8, 0x1

    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[LGE_DATA] handleMessage msg="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget v5, p1, Landroid/os/Message;->what:I

    sparse-switch v5, :sswitch_data_0

    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[LGE_DATA] invalud handleMessage["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :sswitch_0
    const/16 v5, 0x64

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->retryRemovedPayPopup(I)V

    goto :goto_0

    :sswitch_1
    const/16 v5, 0x66

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->retryRemovedPayPopup(I)V

    goto :goto_0

    :sswitch_2
    const/16 v5, 0x67

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->retryRemovedPayPopup(I)V

    goto :goto_0

    :sswitch_3
    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    const-string v6, "[LGE_DATA] EVENT_DELAYED_TOAST_KT "

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[LGE_DATA] mStatus "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-boolean v7, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mStatus:Z

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mMobileEnabled:Z

    if-ne v5, v8, :cond_0

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v6, "KTBASE"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    iget-boolean v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mStatus:Z

    if-eq v5, v8, :cond_0

    const/4 v1, 0x0

    .local v1, "currentSubType":I
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mConnMgr:Landroid/net/ConnectivityManager;

    invoke-virtual {v5, v9}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v2

    .local v2, "mNetworkInfo":Landroid/net/NetworkInfo;
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mConnMgr:Landroid/net/ConnectivityManager;

    if-eqz v5, :cond_1

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getSubtype()I

    move-result v1

    :cond_1
    if-eq v1, v8, :cond_2

    const/4 v5, 0x2

    if-ne v1, v5, :cond_4

    :cond_2
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->gprs_connection_for_kt:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    .local v4, "str_value":Ljava/lang/String;
    :goto_1
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mWifiServiceExt:Lcom/lge/wifi/extension/IWifiServiceExtension;

    invoke-interface {v5}, Lcom/lge/wifi/extension/IWifiServiceExtension;->isShowKTPayPopup()Z

    move-result v5

    if-ne v5, v8, :cond_3

    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[LGE_DATA] mWifiServiceExt.getShowKTPayPopup() = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mWifiServiceExt:Lcom/lge/wifi/extension/IWifiServiceExtension;

    invoke-interface {v7}, Lcom/lge/wifi/extension/IWifiServiceExtension;->isShowKTPayPopup()Z

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-static {v5, v4, v9}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v5

    invoke-virtual {v5}, Landroid/widget/Toast;->show()V

    :cond_3
    iput-boolean v8, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mStatus:Z

    goto/16 :goto_0

    .end local v4    # "str_value":Ljava/lang/String;
    :cond_4
    const/16 v5, 0xd

    if-ne v1, v5, :cond_5

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->lte_connection_for_kt:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    .restart local v4    # "str_value":Ljava/lang/String;
    goto :goto_1

    .end local v4    # "str_value":Ljava/lang/String;
    :cond_5
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->wcdma_connection_for_kt:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    .restart local v4    # "str_value":Ljava/lang/String;
    goto :goto_1

    .end local v1    # "currentSubType":I
    .end local v2    # "mNetworkInfo":Landroid/net/NetworkInfo;
    .end local v4    # "str_value":Ljava/lang/String;
    :sswitch_4
    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    const-string v6, "[LGE_DATA] EVENT_CHECK_DELAY_BOOTCOMPELTE_FLAG "

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v5, "sys.boot_completed"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "1"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    .local v0, "boot_completed":Z
    const-string v5, "net.Is_phone_booted"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "true"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    .local v3, "mbooting_flag":Z
    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[LGE_DATA]boot_completed["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " boot_flag : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v0, :cond_0

    if-ne v3, v8, :cond_0

    const-string v5, "dataAttached"

    const-string v6, "default"

    invoke-virtual {p0, v5, v6, v8}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->startPayPopup(Ljava/lang/String;Ljava/lang/String;Z)Z

    goto/16 :goto_0

    :sswitch_data_0
    .sparse-switch
        0x190 -> :sswitch_0
        0x191 -> :sswitch_1
        0x192 -> :sswitch_2
        0x258 -> :sswitch_3
        0x2bc -> :sswitch_4
    .end sparse-switch
.end method

.method public retryRemovedPayPopup(I)V
    .locals 7
    .param p1, "popup_name"    # I

    .prologue
    const/16 v1, 0x64

    const/4 v4, 0x1

    const/4 v6, 0x0

    if-lt p1, v1, :cond_0

    const/16 v1, 0x68

    if-le p1, v1, :cond_1

    :cond_0
    const-string v1, "[LGE_DATA][PayPopUp_ko] "

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[LGE_DATA] retryRemovedPayPopup, Invalid popup_name["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_1
    iget v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->retryStartActivityForPopup:I

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->retryStartActivityForPopup:I

    const-string v1, "[LGE_DATA][PayPopUp_ko] "

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[LGE_DATA] Popup is removed! ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "], retryStartActivityForPopup["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->retryStartActivityForPopup:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->retryStartActivityForPopup:I

    if-lez v1, :cond_2

    const-string v1, "[LGE_DATA][PayPopUp_ko] "

    const-string v2, "[LGE_DATA] Restart Popup !"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    const-string v1, "[LGE_DATA][PayPopUp_ko] "

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[LGE_DATA][jk.soh] Invalid popup["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :pswitch_1
    :try_start_0
    sget-object v1, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showDialog:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v2, 0x64

    invoke-virtual {p0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    goto :goto_0

    :pswitch_2
    :try_start_1
    sget-object v1, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showDialog:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v2, 0x66

    invoke-virtual {p0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_1
    move-exception v1

    goto :goto_0

    :pswitch_3
    :try_start_2
    sget-object v1, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showDialog:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v2, 0x67

    invoke-virtual {p0, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_0

    :catch_2
    move-exception v1

    goto :goto_0

    :cond_2
    const/4 v1, 0x5

    iput v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->retryStartActivityForPopup:I

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v1}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "data_network_user_data_disable_setting"

    invoke-static {v1, v2, v6}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .local v0, "user_setting":I
    const-string v1, "[LGE_DATA][PayPopUp_ko] "

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[LGE_DATA] To show paypopup is failed. Restore user_setting value["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "] roam : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    invoke-virtual {v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->isRoamingOOS()Z

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MAINTAIN_USER_DATA_SETTING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    invoke-virtual {v1}, Lcom/android/internal/telephony/dataconnection/DcTracker;->isRoamingOOS()Z

    move-result v1

    if-nez v1, :cond_3

    if-ne v0, v4, :cond_3

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mTeleMgr:Landroid/telephony/TelephonyManager;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mTeleMgr:Landroid/telephony/TelephonyManager;

    invoke-virtual {v1, v4}, Landroid/telephony/TelephonyManager;->setDataEnabled(Z)V

    :cond_3
    const-string v1, "[LGE_DATA][PayPopUp_ko] "

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[LGE_DATA] <retryRemovedPopup()> MOBILE_SET : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v3}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mobile_data"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getPhoneId()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4, v6}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x64
        :pswitch_1
        :pswitch_0
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V
    .locals 11
    .param p1, "funcName"    # Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;
    .param p2, "reason"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    const/4 v6, 0x1

    const/4 v7, 0x0

    sget-object v5, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$2;->$SwitchMap$com$android$internal$telephony$lgdata$PayPopup_Korea$PayPopupFunction:[I

    invoke-virtual {p1}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->ordinal()I

    move-result v8

    aget v5, v5, v8

    packed-switch v5, :pswitch_data_0

    :goto_0
    return-void

    :pswitch_0
    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    const-string v6, "showToast()"

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v3, ""

    .local v3, "strText":Ljava/lang/String;
    packed-switch p2, :pswitch_data_1

    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "The toast doesn\'t exist for this reason : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :pswitch_1
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->always_allow_popup:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    :goto_1
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-static {v5, v3, v7}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v5

    invoke-virtual {v5}, Landroid/widget/Toast;->show()V

    goto :goto_0

    :pswitch_2
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->always_not_allow_popup_3gonly:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :pswitch_3
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->always_not_allow_popup:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :pswitch_4
    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    const-string v6, "[LGE_DATA] Roaming Toast"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v5, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_GPRS_REJECTED_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v5

    if-eqz v5, :cond_0

    const-string v5, "ril.gsm.reject_cause"

    invoke-static {v5, v7}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v0

    .local v0, "data_rejCode":I
    sparse-switch v0, :sswitch_data_0

    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[LGE_DATA] PayPopup_Korea, reject_cause= "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->roaming_alert_context_on:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :sswitch_0
    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    const-string v6, "[LGE_DATA] PayPopup_Korea, reject_cause GPRS services not allowed "

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    :sswitch_1
    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    const-string v6, "[LGE_DATA] PayPopup_Korea, reject_cause GPRS services not allowed in this PLMN "

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .end local v0    # "data_rejCode":I
    :cond_0
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->roaming_alert_context_on:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    goto/16 :goto_1

    :pswitch_5
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->roaming_not_allow_popup_in_menu:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    goto/16 :goto_1

    :pswitch_6
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->block_inmms:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    goto/16 :goto_1

    :pswitch_7
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->data_allowed_toast:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    goto/16 :goto_1

    :pswitch_8
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->data_blocked_toast:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    goto/16 :goto_1

    :pswitch_9
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->data_enable_wifi_to_3g_transition_toast:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    goto/16 :goto_1

    :pswitch_a
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->data_disable_wifi_to_3g_transition_toast:I

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    goto/16 :goto_1

    .end local v3    # "strText":Ljava/lang/String;
    :pswitch_b
    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    const-string v8, "showDialog()"

    invoke-static {v5, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v2, Landroid/content/Intent;

    const-string v5, "android.intent.action.MAIN"

    invoke-direct {v2, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v2, "intent":Landroid/content/Intent;
    packed-switch p2, :pswitch_data_2

    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "The dialog doesn\'t exist for this reason : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :pswitch_c
    const-string v5, "com.android.settings"

    const-string v8, "com.android.settings.lgesetting.wireless.DataEnabledSettingBootableSKT"

    invoke-virtual {v2, v5, v8}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :goto_2
    const/high16 v5, 0x10000000

    invoke-virtual {v2, v5}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    :try_start_0
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    sget-object v8, Landroid/os/UserHandle;->CURRENT:Landroid/os/UserHandle;

    invoke-virtual {v5, v2, v8}, Landroid/content/Context;->startActivityAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    const-string v8, "data_network_user_data_disable_setting"

    invoke-static {v5, v8, v7}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v4

    .local v4, "user_setting":I
    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE_DATA_EXCEPT] Exception user_setting : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " roam : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    invoke-virtual {v9}, Lcom/android/internal/telephony/dataconnection/DcTracker;->isRoamingOOS()Z

    move-result v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v5, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v5, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MAINTAIN_USER_DATA_SETTING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v5

    if-eqz v5, :cond_1

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    invoke-virtual {v5}, Lcom/android/internal/telephony/dataconnection/DcTracker;->isRoamingOOS()Z

    move-result v5

    if-nez v5, :cond_1

    if-ne v4, v6, :cond_1

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mTeleMgr:Landroid/telephony/TelephonyManager;

    if-eqz v5, :cond_1

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mTeleMgr:Landroid/telephony/TelephonyManager;

    invoke-virtual {v5, v6}, Landroid/telephony/TelephonyManager;->setDataEnabled(Z)V

    :cond_1
    const-string v5, "[LGE_DATA][PayPopUp_ko] "

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[LGE_DATA] <onDataConnectionAttached()> MOBILE_SET : "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v8, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v8}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v8

    invoke-virtual {v8}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "mobile_data"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v10}, Lcom/android/internal/telephony/Phone;->getPhoneId()I

    move-result v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9, v7}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v5, Ljava/lang/Exception;

    invoke-direct {v5}, Ljava/lang/Exception;-><init>()V

    throw v5

    .end local v1    # "e":Ljava/lang/Exception;
    .end local v4    # "user_setting":I
    :pswitch_d
    const-string v5, "com.android.settings"

    const-string v8, "com.android.settings.lgesetting.wireless.DataRoamingSettingsBootableSKT"

    invoke-virtual {v2, v5, v8}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto/16 :goto_2

    :pswitch_e
    const-string v5, "com.android.settings"

    const-string v8, "com.android.settings.lgesetting.wireless.DataNetworkModePayPopupKT"

    invoke-virtual {v2, v5, v8}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v8, "isRoaming"

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;

    invoke-virtual {v5}, Lcom/android/internal/telephony/dataconnection/DcTracker;->isRoamingOOS()Z

    move-result v5

    if-ne v5, v6, :cond_2

    move v5, v6

    :goto_3
    invoke-virtual {v2, v8, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    goto/16 :goto_2

    :cond_2
    move v5, v7

    goto :goto_3

    :pswitch_f
    const-string v5, "com.android.settings"

    const-string v8, "com.android.settings.lgesetting.wireless.DataNetworkModePayPopupLGT"

    invoke-virtual {v2, v5, v8}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto/16 :goto_2

    :pswitch_10
    const-string v5, "com.android.settings"

    const-string v8, "com.android.settings.lgesetting.wireless.DataNetworkModeRoamingQueryPopupLGT"

    invoke-virtual {v2, v5, v8}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto/16 :goto_2

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_b
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_9
        :pswitch_a
    .end packed-switch

    :sswitch_data_0
    .sparse-switch
        0x7 -> :sswitch_0
        0xe -> :sswitch_1
    .end sparse-switch

    :pswitch_data_2
    .packed-switch 0x64
        :pswitch_c
        :pswitch_d
        :pswitch_e
        :pswitch_f
        :pswitch_10
    .end packed-switch
.end method

.method public startPayPopup(Ljava/lang/String;Ljava/lang/String;Z)Z
    .locals 17
    .param p1, "reason"    # Ljava/lang/String;
    .param p2, "apn_type"    # Ljava/lang/String;
    .param p3, "force_bootcomplete"    # Z

    .prologue
    const/4 v12, 0x0

    .local v12, "result":I
    const-string v5, ""

    .local v5, "WhichCase":Ljava/lang/String;
    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "net.Is_phone_booted : "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "net.Is_phone_booted"

    invoke-static {v15}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v13, "net.Is_phone_booted"

    invoke-static {v13}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    const-string v14, "true"

    invoke-virtual {v13, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    move-object/from16 v0, p0

    iput-boolean v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "mbooting_phone : "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object/from16 v0, p0

    iget-boolean v15, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "SKTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-nez v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "KTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-nez v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "LGTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_9

    :cond_0
    const/16 v4, 0x20

    .local v4, "LGE_EXCEPTION_NEED_OPENNING":I
    const/4 v8, 0x0

    .local v8, "isBlockNetConn":Z
    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "isBlockNetConn() : gsm.lge.ota_is_running = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "gsm.lge.ota_is_running"

    invoke-static {v15}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v13, "gsm.lge.ota_is_running"

    invoke-static {v13}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    const-string v14, "true"

    invoke-virtual {v13, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_1

    const/4 v8, 0x1

    :cond_1
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "SKTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_2

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "SKT_OTA_USIM_DOWNLOAD = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "pref.skt_ota_usim_download"

    const-string v16, "0"

    invoke-static/range {v15 .. v16}, Lcom/lge/uicc/LGUiccManager;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v13, "pref.skt_ota_usim_download"

    const-string v14, "0"

    invoke-static {v13, v14}, Lcom/lge/uicc/LGUiccManager;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    const-string v14, "1"

    invoke-virtual {v13, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_2

    const/4 v8, 0x1

    :cond_2
    sget-object v13, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_BLOCK_PAYPOPUP_AND_TRYSETUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v13}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v13

    if-eqz v13, :cond_5

    const-string v13, "ril.card_operator"

    const-string v14, ""

    invoke-static {v13, v14}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .local v10, "operator":Ljava/lang/String;
    const-string v13, "ril.card_provisioned"

    const/4 v14, 0x1

    invoke-static {v13, v14}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v11

    .local v11, "provisioned":Z
    if-nez v11, :cond_4

    const-string v13, "SKT"

    invoke-virtual {v10, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_3

    const-string v13, "KT"

    invoke-virtual {v10, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_3

    const-string v13, "LGU"

    invoke-virtual {v10, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_4

    :cond_3
    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA] normal case  empty sim"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v8, 0x1

    :cond_4
    if-eqz v11, :cond_5

    const-string v13, "LGU"

    invoke-virtual {v10, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_5

    const-string v13, "gsm.lge.ota_is_running"

    invoke-static {v13}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    const-string v14, "true"

    invoke-virtual {v13, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_5

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA] this case is phone number change on HiddenMenu"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v8, 0x0

    .end local v10    # "operator":Ljava/lang/String;
    .end local v11    # "provisioned":Z
    :cond_5
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "KTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_6

    move-object/from16 v0, p0

    iget-boolean v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->intent_reset:Z

    if-eqz v13, :cond_6

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA] this case is reset"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v8, 0x1

    :cond_6
    if-eqz v8, :cond_7

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "isBlockNetConn = OTA"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v13, 0x0

    .end local v4    # "LGE_EXCEPTION_NEED_OPENNING":I
    .end local v8    # "isBlockNetConn":Z
    :goto_0
    return v13

    .restart local v4    # "LGE_EXCEPTION_NEED_OPENNING":I
    .restart local v8    # "isBlockNetConn":Z
    :cond_7
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    invoke-virtual {v13}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v13

    const-string v14, "data_network_user_paypopup_transition_from_wifi_to_mobile"

    const/4 v15, 0x0

    invoke-static {v13, v14, v15}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v7

    .local v7, "from_wifi_to_mobile":I
    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "isWhatKindofReason() : mbooting_phone = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object/from16 v0, p0

    iget-boolean v15, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "/ from_wifi_to_mobile = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v13, "dataAttached"

    move-object/from16 v0, p1

    invoke-virtual {v13, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_8

    const-string v13, "simLoaded"

    move-object/from16 v0, p1

    invoke-virtual {v13, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_8

    const-string v13, "roamingOn"

    move-object/from16 v0, p1

    invoke-virtual {v13, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_c

    :cond_8
    move-object/from16 v0, p0

    iget-boolean v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z

    const/4 v14, 0x1

    if-ne v13, v14, :cond_c

    const-string v9, "booting"

    .local v9, "isWhatKindofReason":Ljava/lang/String;
    :goto_1
    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "Original reason = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object/from16 v0, p1

    invoke-virtual {v14, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, " , LGE reason = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v5, v9

    .end local v4    # "LGE_EXCEPTION_NEED_OPENNING":I
    .end local v7    # "from_wifi_to_mobile":I
    .end local v8    # "isBlockNetConn":Z
    .end local v9    # "isWhatKindofReason":Ljava/lang/String;
    :cond_9
    :try_start_0
    sget-object v13, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v13}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v13

    if-eqz v13, :cond_e

    sget-object v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->PayPopupforSKT:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move/from16 v3, p3

    invoke-direct {v0, v13, v1, v2, v3}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->PayPopupforFeature(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;Ljava/lang/String;Ljava/lang/String;Z)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v12

    :cond_a
    :goto_2
    const/16 v13, 0x12d

    if-eq v12, v13, :cond_b

    const/16 v13, 0x12e

    if-ne v12, v13, :cond_10

    :cond_b
    const/4 v13, 0x0

    goto/16 :goto_0

    .restart local v4    # "LGE_EXCEPTION_NEED_OPENNING":I
    .restart local v7    # "from_wifi_to_mobile":I
    .restart local v8    # "isBlockNetConn":Z
    :cond_c
    const/4 v13, 0x1

    if-ne v7, v13, :cond_d

    const-string v9, "Wifi_off"

    .restart local v9    # "isWhatKindofReason":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    invoke-virtual {v13}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v13

    const-string v14, "data_network_user_paypopup_transition_from_wifi_to_mobile"

    const/4 v15, 0x0

    invoke-static {v13, v14, v15}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_1

    .end local v9    # "isWhatKindofReason":Ljava/lang/String;
    :cond_d
    const-string v9, "others"

    .restart local v9    # "isWhatKindofReason":Ljava/lang/String;
    goto :goto_1

    .end local v4    # "LGE_EXCEPTION_NEED_OPENNING":I
    .end local v7    # "from_wifi_to_mobile":I
    .end local v8    # "isBlockNetConn":Z
    .end local v9    # "isWhatKindofReason":Ljava/lang/String;
    :cond_e
    :try_start_1
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "KTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_f

    sget-object v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->PayPopupforKT:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move/from16 v2, p3

    invoke-direct {v0, v13, v5, v1, v2}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->PayPopupforFeature(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;Ljava/lang/String;Ljava/lang/String;Z)I

    move-result v12

    goto :goto_2

    :cond_f
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "LGTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_a

    sget-object v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->PayPopupforLGT:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move/from16 v3, p3

    invoke-direct {v0, v13, v1, v2, v3}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->PayPopupforFeature(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;Ljava/lang/String;Ljava/lang/String;Z)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result v12

    goto :goto_2

    :catch_0
    move-exception v6

    .local v6, "e":Ljava/lang/Exception;
    const/4 v13, 0x1

    goto/16 :goto_0

    .end local v6    # "e":Ljava/lang/Exception;
    :cond_10
    const/4 v13, 0x1

    goto/16 :goto_0
.end method
