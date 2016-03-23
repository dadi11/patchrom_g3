.class public abstract Lcom/android/internal/telephony/PhoneBaseEx;
.super Lcom/android/internal/telephony/PhoneBase;
.source "PhoneBaseEx.java"


# static fields
.field public static final ALS_STATE_CHANGED_ACTION:Ljava/lang/String; = "android.intent.action.ALS_STATE_CHANGED"

.field protected static final EVENT_CANCEL_MANUAL_SEARCHING:I = 0x40f

.field protected static final EVENT_RETRY_GET_DEVICE_IDENTITY:I = 0x420

.field protected static final EVENT_SET_ERI_VERSION:I = 0x416

.field protected static final EVENT_SET_LTE_ONLY_FOR_TDD:I = 0x423

.field protected static final EVENT_SET_NETWORK_MANUAL_PREVIOUS:I = 0x40e

.field protected static final EVENT_SET_VOLTE_E911_SCAN_LIST:I = 0x417

.field protected static final EVENT_SUBSCRIPTION_INFO_READY:I = 0x3a

.field protected static final LGE_EVENT_OFFSET:I = 0x3e8

.field private static final LOG_TAG:Ljava/lang/String; = "PhoneBase"

.field public static final NETWORK_SELECTION_FAIL_KEY:Ljava/lang/String; = "network_selection_fail_key"

.field public static final VM_PRIORITY:Ljava/lang/String; = "vm_priority_key"

.field protected static isUSimSmsDeleted:Z

.field static mEcmExitTime:J


# instance fields
.field private mIsE911ForVolte:Z

.field protected mIsPhoneInEcmExitDelayState:Z

.field private mIsQCTPlatform:Z

.field protected mRD:Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

.field protected final mReferredNetworkTypeRegistrants:Landroid/os/RegistrantList;

.field private mVmUrgent:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 100
    const-wide/16 v0, 0x0

    sput-wide v0, Lcom/android/internal/telephony/PhoneBaseEx;->mEcmExitTime:J

    .line 124
    const/4 v0, 0x0

    sput-boolean v0, Lcom/android/internal/telephony/PhoneBaseEx;->isUSimSmsDeleted:Z

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/android/internal/telephony/PhoneNotifier;Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Z)V
    .locals 7
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;
    .param p3, "context"    # Landroid/content/Context;
    .param p4, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p5, "unitTestMode"    # Z

    .prologue
    .line 133
    const v6, 0x7fffffff

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move v5, p5

    invoke-direct/range {v0 .. v6}, Lcom/android/internal/telephony/PhoneBaseEx;-><init>(Ljava/lang/String;Lcom/android/internal/telephony/PhoneNotifier;Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;ZI)V

    .line 134
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/android/internal/telephony/PhoneNotifier;Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;ZI)V
    .locals 9
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;
    .param p3, "context"    # Landroid/content/Context;
    .param p4, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p5, "unitTestMode"    # Z
    .param p6, "phoneId"    # I

    .prologue
    const/4 v8, 0x0

    const/4 v7, 0x0

    .line 139
    invoke-direct/range {p0 .. p6}, Lcom/android/internal/telephony/PhoneBase;-><init>(Ljava/lang/String;Lcom/android/internal/telephony/PhoneNotifier;Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;ZI)V

    .line 104
    iput-boolean v7, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mIsE911ForVolte:Z

    .line 108
    iput-boolean v7, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mVmUrgent:Z

    .line 120
    new-instance v3, Landroid/os/RegistrantList;

    invoke-direct {v3}, Landroid/os/RegistrantList;-><init>()V

    iput-object v3, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mReferredNetworkTypeRegistrants:Landroid/os/RegistrantList;

    .line 128
    iput-boolean v7, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mIsQCTPlatform:Z

    .line 141
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getPhoneType()I

    move-result v3

    const/4 v4, 0x5

    if-ne v3, v4, :cond_0

    .line 218
    :goto_0
    return-void

    .line 146
    :cond_0
    const-string v3, "KR"

    const-string v4, "LGU"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 147
    iget-object v3, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    iget-object v4, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-static {v3, v4}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->getRILEventDispatcher(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;)Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    move-result-object v3

    iput-object v3, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mRD:Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    .line 151
    :cond_1
    const-string v3, "KR"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 152
    invoke-static {p3}, Lcom/android/internal/telephony/TelephonyUtils;->parseKrTelephonyStringXML(Landroid/content/Context;)V

    .line 157
    :cond_2
    const-string v3, "KR"

    const-string v4, "LGU"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 158
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v3

    const-string v4, "mcc_change"

    invoke-virtual {v3, v4, v7}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 159
    .local v0, "prefs":Landroid/content/SharedPreferences;
    const-string v3, "mcc"

    const-string v4, ""

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 160
    .local v1, "savedMcc":Ljava/lang/String;
    const-string v3, "PhoneBase"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "SharedPreference(mcc_change) saved mcc = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 161
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_3

    const-string v3, "000"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 165
    :cond_3
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "mcc"

    const-string v5, "450"

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 166
    const-string v3, "PhoneBase"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Init SharedPreference(mcc_change) new mcc = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "mcc"

    const-string v6, ""

    invoke-interface {v0, v5, v6}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 169
    .end local v0    # "prefs":Landroid/content/SharedPreferences;
    .end local v1    # "savedMcc":Ljava/lang/String;
    :cond_4
    const-string v3, "KR"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 170
    const-string v3, "persist.radio.camped_mccmnc"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 172
    .local v2, "savedPropertyCamped_MccMnc":Ljava/lang/String;
    const-string v3, "PhoneBase"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "savedPropertyCamped_MccMnc = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 174
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 175
    const-string v3, "KR"

    const-string v4, "SKT"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_b

    .line 176
    const-string v3, "persist.radio.camped_mccmnc"

    const-string v4, "45005"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 189
    .end local v2    # "savedPropertyCamped_MccMnc":Ljava/lang/String;
    :cond_5
    :goto_1
    const-string v3, "KR"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    .line 190
    iget-object v3, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    iget-object v4, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-static {v3, v4, p6}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->getInstance(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;I)Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    .line 195
    :cond_6
    const-string v3, "VZW"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_7

    const-string v3, "LRA"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_8

    .line 196
    :cond_7
    const/4 v3, 0x1

    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "apn2_disable"

    invoke-static {v4, v5, v7}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v4

    if-ne v3, v4, :cond_8

    .line 197
    const-string v3, "VZW"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_e

    .line 198
    const-string v3, "gsm.sim.operator.numeric"

    const-string v4, "311480"

    invoke-virtual {p0, v3, v4}, Lcom/android/internal/telephony/PhoneBaseEx;->setSystemProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 208
    :cond_8
    :goto_2
    const-string v3, "support_assisted_dialing"

    invoke-static {v8, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_9

    const-string v3, "support_smart_dialing"

    invoke-static {v8, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_a

    .line 210
    :cond_9
    invoke-static {p3}, Lcom/lge/telephony/utils/AssistedDialUtils;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialUtils;

    .line 216
    :cond_a
    invoke-direct {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->isQCTPlatform()Z

    move-result v3

    iput-boolean v3, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mIsQCTPlatform:Z

    goto/16 :goto_0

    .line 177
    .restart local v2    # "savedPropertyCamped_MccMnc":Ljava/lang/String;
    :cond_b
    const-string v3, "KR"

    const-string v4, "KT"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_c

    .line 178
    const-string v3, "persist.radio.camped_mccmnc"

    const-string v4, "45008"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 179
    :cond_c
    const-string v3, "KR"

    const-string v4, "LGU"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_d

    .line 180
    const-string v3, "persist.radio.camped_mccmnc"

    const-string v4, "45006"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 182
    :cond_d
    const-string v3, "persist.radio.camped_mccmnc"

    const-string v4, "45006"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_1

    .line 199
    .end local v2    # "savedPropertyCamped_MccMnc":Ljava/lang/String;
    :cond_e
    const-string v3, "LRA"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_8

    .line 200
    const-string v3, "gsm.apn.sim.operator.numeric"

    const-string v4, "311480"

    invoke-virtual {p0, v3, v4}, Lcom/android/internal/telephony/PhoneBaseEx;->setSystemProperty(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2
.end method

.method public static getEndTimeForEcm()J
    .locals 8

    .prologue
    const-wide/16 v4, 0x0

    .line 536
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 537
    .local v0, "currentTime":J
    sget-wide v6, Lcom/android/internal/telephony/PhoneBaseEx;->mEcmExitTime:J

    sub-long v2, v6, v0

    .line 539
    .local v2, "relatvieEcmExitTime":J
    cmp-long v6, v2, v4

    if-lez v6, :cond_0

    .line 540
    const-string v4, "PhoneBase"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getEndTimeForEcm() : relative ecmExitTime = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 544
    .end local v2    # "relatvieEcmExitTime":J
    :goto_0
    return-wide v2

    .line 543
    .restart local v2    # "relatvieEcmExitTime":J
    :cond_0
    const-string v6, "PhoneBase"

    const-string v7, "getEndTimeForEcm() : wrong case"

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-wide v2, v4

    .line 544
    goto :goto_0
.end method

.method private getLteBand(I)J
    .locals 2
    .param p1, "tddStatus"    # I

    .prologue
    .line 765
    const/4 v0, 0x1

    if-ne p1, v0, :cond_0

    .line 766
    const-wide v0, 0x10000000000L

    .line 768
    :goto_0
    return-wide v0

    :cond_0
    const-wide/16 v0, 0x5

    goto :goto_0
.end method

.method private isQCTPlatform()Z
    .locals 5

    .prologue
    .line 988
    const-string v1, "msm, mdm, apq"

    .line 989
    .local v1, "qct":Ljava/lang/String;
    const-string v2, "ro.baseband"

    const-string v3, "null"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    .line 990
    .local v0, "baseband":Ljava/lang/String;
    const-string v2, "PhoneBase"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "isQCTPlatform baseband = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 991
    invoke-virtual {v1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    return v2
.end method

.method public static resetEcmExitTime()V
    .locals 2

    .prologue
    .line 548
    const-string v0, "PhoneBase"

    const-string v1, "resetEcmExitTime()"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 549
    const-wide/16 v0, 0x0

    sput-wide v0, Lcom/android/internal/telephony/PhoneBaseEx;->mEcmExitTime:J

    .line 550
    return-void
.end method

.method public static setCurrentTimeForEcm(J)V
    .locals 4
    .param p0, "delayMillis"    # J

    .prologue
    .line 527
    const/4 v0, 0x0

    const-string v1, "support_emergency_callback_mode_for_gsm"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 528
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    add-long/2addr v0, p0

    sput-wide v0, Lcom/android/internal/telephony/PhoneBaseEx;->mEcmExitTime:J

    .line 529
    const-string v0, "PhoneBase"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setCurrentTimeForEcm() : mEcmExitTime = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-wide v2, Lcom/android/internal/telephony/PhoneBaseEx;->mEcmExitTime:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 531
    :cond_0
    return-void
.end method


# virtual methods
.method public PlayVZWERISound()V
    .locals 1

    .prologue
    .line 396
    const-string v0, "PlayVZWERISound"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 397
    return-void
.end method

.method public StopVZWERISound()V
    .locals 1

    .prologue
    .line 401
    const-string v0, "StopVZWERISound"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 402
    return-void
.end method

.method public cancelManualSearchingRequest()V
    .locals 2

    .prologue
    .line 938
    const-string v0, "PhoneBase"

    const-string v1, "cancelManualSearchingRequest: not possible in CDMA"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 939
    return-void
.end method

.method public changePlmnNameForESAME(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "Sim_Numeric"    # Ljava/lang/String;
    .param p3, "Subscriber_id"    # Ljava/lang/String;
    .param p4, "roaming"    # Z

    .prologue
    .line 981
    const-string v0, "changePlmnNameForESAME"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 982
    const/4 v0, 0x0

    return-object v0
.end method

.method public changePlmnNameForSwedish(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "opLong"    # Ljava/lang/String;
    .param p2, "opShort"    # Ljava/lang/String;
    .param p3, "opNumeric"    # Ljava/lang/String;

    .prologue
    .line 975
    const-string v0, "changePlmnNameForSwedish"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 976
    const/4 v0, 0x0

    return-object v0
.end method

.method public closeImsPdn(I)V
    .locals 2
    .param p1, "reason"    # I

    .prologue
    .line 814
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Lcom/android/internal/telephony/CommandsInterface;->closeImsPdn(ILandroid/os/Message;)V

    .line 815
    return-void
.end method

.method public dialForVolte(Ljava/lang/String;)Z
    .locals 2
    .param p1, "dialString"    # Ljava/lang/String;

    .prologue
    .line 347
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "SUPPORT_E911_FOR_VOLTE"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 348
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallTracker;->dialForVolte(Ljava/lang/String;)Z

    move-result v0

    .line 350
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public dispose()V
    .locals 3

    .prologue
    .line 222
    invoke-super {p0}, Lcom/android/internal/telephony/PhoneBase;->dispose()V

    .line 225
    const-string v0, "KR"

    const-string v1, "LGU"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 226
    const-string v0, "PhoneBase"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mRD = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mRD:Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 227
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mRD:Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mRD:Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;

    invoke-virtual {v0}, Lcom/android/internal/telephony/kr/KrLguRILEventDispatcher;->dispose()V

    .line 230
    :cond_0
    return-void
.end method

.method public emptySIMMessageDB()V
    .locals 6

    .prologue
    .line 712
    :try_start_0
    invoke-static {}, Lcom/lge/telephony/msim/LGMSimTelephonyManager;->getDefault()Lcom/lge/telephony/msim/LGMSimTelephonyManager;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/telephony/msim/LGMSimTelephonyManager;->isMultiSimEnabled()Z

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    .line 713
    iget-object v1, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/uicc/ILGSmsSimUtils;->ALL_ICC_DS_URI:Landroid/net/Uri;

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v1, v2, v3, v4, v5}, Landroid/database/sqlite/SqliteWrapper;->delete(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    .line 718
    :goto_0
    iget-object v1, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/uicc/ILGSmsSimUtils;->SMS_CONCAT_URI:Landroid/net/Uri;

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v1, v2, v3, v4, v5}, Landroid/database/sqlite/SqliteWrapper;->delete(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    .line 726
    :goto_1
    return-void

    .line 715
    :cond_0
    const-string v1, "PhoneBase"

    const-string v2, "[PhoneBase] emptySIMMessageDB() - Delete ILGSmsSimUtils.ICC_URI"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 716
    iget-object v1, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/uicc/ILGSmsSimUtils;->ICC_URI:Landroid/net/Uri;

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v1, v2, v3, v4, v5}, Landroid/database/sqlite/SqliteWrapper;->delete(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Landroid/database/sqlite/SQLiteException; {:try_start_0 .. :try_end_0} :catch_2

    goto :goto_0

    .line 719
    :catch_0
    move-exception v0

    .line 720
    .local v0, "e":Ljava/lang/NullPointerException;
    const-string v1, "PhoneBase"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "emptySIMMessageDB :: NullPointerException"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/NullPointerException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 721
    .end local v0    # "e":Ljava/lang/NullPointerException;
    :catch_1
    move-exception v0

    .line 722
    .local v0, "e":Ljava/lang/IllegalArgumentException;
    const-string v1, "PhoneBase"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "emptySIMMessageDB :: IllegalArgumentException"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 723
    .end local v0    # "e":Ljava/lang/IllegalArgumentException;
    :catch_2
    move-exception v0

    .line 724
    .local v0, "e":Landroid/database/sqlite/SQLiteException;
    const-string v1, "PhoneBase"

    const-string v2, "[TEL-SMS] sql exception"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public exitVolteE911EmergencyMode()V
    .locals 2

    .prologue
    .line 384
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/CommandsInterface;->exitVolteE911EmergencyMode(Landroid/os/Message;)V

    .line 385
    return-void
.end method

.method public getAlertId()I
    .locals 1

    .prologue
    .line 406
    const-string v0, "getAlertId"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 407
    const/4 v0, 0x0

    return v0
.end method

.method public getCallBarringOption(Ljava/lang/String;Landroid/os/Message;)V
    .locals 1
    .param p1, "commandInterfaceCBReason"    # Ljava/lang/String;
    .param p2, "onComplete"    # Landroid/os/Message;

    .prologue
    .line 329
    const-string v0, "getCallBarringOption"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 330
    return-void
.end method

.method public getCdmaEriHomeSystems()Ljava/lang/String;
    .locals 1

    .prologue
    .line 418
    const-string v0, "getCdmaEriHomeSystems"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 419
    const/4 v0, 0x0

    return-object v0
.end method

.method public getCdmaInfo()[Ljava/lang/String;
    .locals 2

    .prologue
    .line 503
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v0

    .line 505
    .local v0, "sst":Lcom/android/internal/telephony/ServiceStateTracker;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/ServiceStateTracker;->getEhrpdInfo()[Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getCdmaLteEhrpdForced()Ljava/lang/String;
    .locals 2

    .prologue
    .line 490
    const-string v0, "PhoneBase"

    const-string v1, "Error! getCdmaLteEhrpdForced() in PhoneBase should not be called, GSMPhone & CDMAPhone inactive."

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 492
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDebugInfoValue(Landroid/os/Message;)V
    .locals 2
    .param p1, "result"    # Landroid/os/Message;

    .prologue
    .line 911
    const-string v0, "PhoneBase"

    const-string v1, "getDebugInfoValue"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 912
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1}, Lcom/android/internal/telephony/CommandsInterface;->getDebugInfoValue(Landroid/os/Message;)V

    .line 913
    return-void
.end method

.method public getDmNodeHandlerDiagMonNetwork(ZII)Ljava/lang/String;
    .locals 7
    .param p1, "setpreferrednetworktype"    # Z
    .param p2, "preferrednetworktype"    # I
    .param p3, "networksignal"    # I

    .prologue
    .line 613
    const-string v3, ""

    .line 614
    .local v3, "result":Ljava/lang/String;
    const/4 v0, 0x1

    .line 615
    .local v0, "m1xSignal":I
    const/4 v1, 0x2

    .line 616
    .local v1, "m3GSignal":I
    const/4 v2, 0x3

    .line 618
    .local v2, "m4GSignal":I
    if-eqz p1, :cond_0

    .line 619
    const/4 v4, 0x0

    invoke-virtual {p0, p2, v4}, Lcom/android/internal/telephony/PhoneBaseEx;->setPreferredNetworkType(ILandroid/os/Message;)V

    .line 620
    const-string v4, "PhoneBase"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "preferrednetworktype = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 634
    :goto_0
    return-object v3

    .line 621
    :cond_0
    if-lez p3, :cond_4

    .line 622
    if-ne p3, v0, :cond_2

    .line 623
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getSignalStrength()Landroid/telephony/SignalStrength;

    move-result-object v4

    invoke-virtual {v4}, Landroid/telephony/SignalStrength;->getCdmaDbm()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    .line 629
    :cond_1
    :goto_1
    const-string v4, "PhoneBase"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "preferred network = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ", signalstrength = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 624
    :cond_2
    if-ne p3, v1, :cond_3

    .line 625
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getSignalStrength()Landroid/telephony/SignalStrength;

    move-result-object v4

    invoke-virtual {v4}, Landroid/telephony/SignalStrength;->getEvdoDbm()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    .line 626
    :cond_3
    if-ne p3, v2, :cond_1

    .line 627
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getSignalStrength()Landroid/telephony/SignalStrength;

    move-result-object v4

    invoke-virtual {v4}, Landroid/telephony/SignalStrength;->getLteRsrp()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    .line 631
    :cond_4
    const-string v4, "PhoneBase"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "UNKNOWN network signal : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getEriFileVersion()I
    .locals 1

    .prologue
    .line 412
    const-string v0, "getEriFileVersion"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 413
    const/4 v0, 0x0

    return v0
.end method

.method public getHDRRoamingIndicator()I
    .locals 2

    .prologue
    .line 482
    const-string v0, "PhoneBase"

    const-string v1, "Error! getHDRRoamingIndicator() in PhoneBase should not be called, GSMPhone & CDMAPhone inactive."

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 484
    const/4 v0, 0x0

    return v0
.end method

.method public getIsE911ForVolte()Z
    .locals 3

    .prologue
    .line 369
    const-string v0, "PhoneBase"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getIsE911ForVolte() - mIsE911ForVolte = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mIsE911ForVolte:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 370
    iget-boolean v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mIsE911ForVolte:Z

    return v0
.end method

.method public getIsQCT()Z
    .locals 1

    .prologue
    .line 995
    iget-boolean v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mIsQCTPlatform:Z

    return v0
.end method

.method public getLteInfo()[Ljava/lang/String;
    .locals 2

    .prologue
    .line 498
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v0

    .line 500
    .local v0, "sst":Lcom/android/internal/telephony/ServiceStateTracker;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/android/internal/telephony/ServiceStateTracker;->getLteInfo()[Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getMSIN()Ljava/lang/String;
    .locals 1

    .prologue
    .line 308
    const-string v0, "getMSIN"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 309
    const/4 v0, 0x0

    return-object v0
.end method

.method public getModemIntegerItem(ILandroid/os/Message;)V
    .locals 3
    .param p1, "item_index"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 461
    const-string v0, "PhoneBase"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PhoneBase getModemIntegerItem item_index = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 462
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->getModemIntegerItem(ILandroid/os/Message;)V

    .line 463
    return-void
.end method

.method public getModemStringItem(ILandroid/os/Message;)V
    .locals 3
    .param p1, "item_index"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 473
    const-string v0, "PhoneBase"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PhoneBase getModemStringItem item_index = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 474
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->getModemStringItem(ILandroid/os/Message;)V

    .line 475
    return-void
.end method

.method public getSearchStatus(Landroid/os/Message;)V
    .locals 2
    .param p1, "response"    # Landroid/os/Message;

    .prologue
    .line 945
    const-string v0, "PhoneBase"

    const-string v1, "getSearchStatus: not possible in CDMA"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 946
    return-void
.end method

.method public getStatusId()I
    .locals 1

    .prologue
    .line 435
    const-string v0, "getStatusId"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 436
    const/4 v0, 0x0

    return v0
.end method

.method public getTimeFromSIB16String()[J
    .locals 2

    .prologue
    .line 644
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v0

    .line 645
    .local v0, "sst":Lcom/android/internal/telephony/ServiceStateTracker;
    invoke-virtual {v0}, Lcom/android/internal/telephony/ServiceStateTracker;->getTimeFromSIB16String()[J

    move-result-object v1

    return-object v1
.end method

.method public getValueFromSIB16String()[I
    .locals 2

    .prologue
    .line 640
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v0

    .line 641
    .local v0, "sst":Lcom/android/internal/telephony/ServiceStateTracker;
    invoke-virtual {v0}, Lcom/android/internal/telephony/ServiceStateTracker;->getValueFromSIB16String()[I

    move-result-object v1

    return-object v1
.end method

.method public getVoiceMessageUrgent()Z
    .locals 1

    .prologue
    .line 746
    iget-boolean v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mVmUrgent:Z

    return v0
.end method

.method public getVolteE911NetworkType()V
    .locals 2

    .prologue
    .line 380
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/CommandsInterface;->getVolteE911NetworkType(Landroid/os/Message;)V

    .line 381
    return-void
.end method

.method protected handleEnterEmergencyCallbackMode(J)V
    .locals 0
    .param p1, "delayInMillis"    # J

    .prologue
    .line 581
    return-void
.end method

.method protected handleExitEmergencyCallbackModeEx()V
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 665
    iput-boolean v1, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mIsPhoneInEcmExitDelayState:Z

    .line 670
    const/4 v2, 0x0

    const-string v3, "support_network_change_auto_retry"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 671
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "network_change_auto_retry"

    invoke-static {v2, v3, v1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 678
    :cond_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "support_emergency_callback_mode_for_gsm"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 679
    invoke-static {}, Lcom/android/internal/telephony/PhoneBaseEx;->resetEcmExitTime()V

    .line 684
    :cond_1
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "SUPPORT_E911_FOR_VOLTE"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 685
    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/PhoneBaseEx;->setIsE911ForVolte(Z)V

    .line 690
    :cond_2
    const-string v2, "VZW"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    const-string v2, "LRA"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 691
    :cond_3
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "apn2_disable"

    invoke-static {v2, v3, v1}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    if-ne v2, v0, :cond_6

    .line 694
    .local v0, "apn2Disabled":Z
    :goto_0
    if-eqz v0, :cond_5

    .line 699
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getState()Lcom/android/internal/telephony/PhoneConstants$State;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-eq v2, v3, :cond_4

    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getState()Lcom/android/internal/telephony/PhoneConstants$State;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-eq v2, v3, :cond_5

    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->isInEmergencyCall()Z

    move-result v2

    if-nez v2, :cond_5

    .line 701
    :cond_4
    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/PhoneBaseEx;->setRadioPower(Z)V

    .line 706
    .end local v0    # "apn2Disabled":Z
    :cond_5
    return-void

    :cond_6
    move v0, v1

    .line 691
    goto :goto_0
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 235
    iget-boolean v3, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mIsTheCurrentActivePhone:Z

    if-nez v3, :cond_1

    .line 236
    const-string v3, "PhoneBase"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Received message "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p1, Landroid/os/Message;->what:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "] while being destroyed. Ignoring."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 280
    :cond_0
    :goto_0
    :sswitch_0
    return-void

    .line 240
    :cond_1
    iget v3, p1, Landroid/os/Message;->what:I

    sparse-switch v3, :sswitch_data_0

    .line 277
    invoke-super {p0, p1}, Lcom/android/internal/telephony/PhoneBase;->handleMessage(Landroid/os/Message;)V

    goto :goto_0

    .line 243
    :sswitch_1
    const-string v3, "PhoneBase"

    const-string v4, "Event EVENT_SET_VOLTE_E911_SCAN_LIST Received Broadcast(change) "

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 244
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 245
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v3, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v3, :cond_0

    .line 246
    new-instance v1, Landroid/content/Intent;

    const-string v3, "com.lge.intent.action.VOLTE_E911_SCAN_LIST_COMPLETE"

    invoke-direct {v1, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 247
    .local v1, "intent_i":Landroid/content/Intent;
    iget-object v3, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    sget-object v4, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v3, v1, v4}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto :goto_0

    .line 254
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v1    # "intent_i":Landroid/content/Intent;
    :sswitch_2
    const-string v3, "PhoneBase"

    const-string v4, "CTC : Event EVENT_SET_LTE_ONLY_FOR_TDD"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 255
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 256
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v3, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    if-eqz v3, :cond_2

    iget-object v3, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    instance-of v3, v3, Landroid/os/Message;

    if-nez v3, :cond_2

    .line 257
    const-string v3, "PhoneBase"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "CTC : ar.userObj is not Message type  ar.userObj = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 260
    :cond_2
    iget-object v2, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v2, Landroid/os/Message;

    .line 261
    .local v2, "message":Landroid/os/Message;
    iget-object v3, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v3, :cond_3

    .line 262
    if-eqz v2, :cond_0

    .line 263
    iget-object v3, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    iget-object v4, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-static {v2, v3, v4}, Landroid/os/AsyncResult;->forMessage(Landroid/os/Message;Ljava/lang/Object;Ljava/lang/Throwable;)Landroid/os/AsyncResult;

    .line 264
    invoke-virtual {v2}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 268
    :cond_3
    iget-object v3, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    iget v4, p1, Landroid/os/Message;->arg1:I

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/PhoneBaseEx;->getLteBand(I)J

    move-result-wide v4

    invoke-interface {v3, v4, v5, v2}, Lcom/android/internal/telephony/CommandsInterface;->setLteBandMode(JLandroid/os/Message;)V

    goto :goto_0

    .line 240
    nop

    :sswitch_data_0
    .sparse-switch
        0x40f -> :sswitch_0
        0x417 -> :sswitch_1
        0x423 -> :sswitch_2
    .end sparse-switch
.end method

.method public hangUpForVolte(Z)Z
    .locals 2
    .param p1, "isE911WithEcbm"    # Z

    .prologue
    .line 355
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "SUPPORT_E911_FOR_VOLTE"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 356
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/PhoneBaseEx;->setIsE911ForVolte(Z)V

    .line 357
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getCallTracker()Lcom/android/internal/telephony/CallTracker;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallTracker;->hangUpForVolte(Z)Z

    move-result v0

    .line 359
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public initForSupportedEcmOnGsm(Landroid/content/Context;)Z
    .locals 7
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/16 v6, 0x1a

    .line 553
    const-string v1, "support_emergency_callback_mode_for_gsm"

    invoke-static {p1, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 554
    invoke-static {}, Lcom/android/internal/telephony/PhoneBaseEx;->getEndTimeForEcm()J

    move-result-wide v2

    .line 555
    .local v2, "mEcmTimeout":J
    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-lez v1, :cond_0

    .line 556
    invoke-virtual {p0, v2, v3}, Lcom/android/internal/telephony/PhoneBaseEx;->handleEnterEmergencyCallbackMode(J)V

    .line 575
    :goto_0
    const/4 v1, 0x1

    .line 577
    .end local v2    # "mEcmTimeout":J
    :goto_1
    return v1

    .line 559
    .restart local v2    # "mEcmTimeout":J
    :cond_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v4, "SUPPORT_E911_FOR_VOLTE"

    invoke-static {v1, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 560
    invoke-virtual {p0}, Lcom/android/internal/telephony/PhoneBaseEx;->getIsE911ForVolte()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 562
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.intent.action.ACTION_ECBM_EXIT_FOR_VOLTE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 563
    .local v0, "intent":Landroid/content/Intent;
    iget-object v1, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    sget-object v4, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v4}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 564
    const-string v1, "PhoneBase"

    const-string v4, "GSMPhone - ACTION_ECBM_EXIT_FOR_VOLTE"

    invoke-static {v1, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 567
    .end local v0    # "intent":Landroid/content/Intent;
    :cond_1
    iget-object v1, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/PhoneBaseEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v4

    invoke-interface {v1, v4}, Lcom/android/internal/telephony/CommandsInterface;->exitEmergencyCallbackMode(Landroid/os/Message;)V

    goto :goto_0

    .line 572
    :cond_2
    iget-object v1, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/PhoneBaseEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v4

    invoke-interface {v1, v4}, Lcom/android/internal/telephony/CommandsInterface;->exitEmergencyCallbackMode(Landroid/os/Message;)V

    goto :goto_0

    .line 577
    .end local v2    # "mEcmTimeout":J
    :cond_3
    const/4 v1, 0x0

    goto :goto_1
.end method

.method public isInEcmExitDelay()Z
    .locals 1

    .prologue
    .line 659
    iget-boolean v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mIsPhoneInEcmExitDelayState:Z

    return v0
.end method

.method public lgeResetEPSLOCI(Landroid/os/Message;)V
    .locals 1
    .param p1, "response"    # Landroid/os/Message;

    .prologue
    .line 962
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1}, Lcom/android/internal/telephony/CommandsInterface;->lgeResetEPSLOCI(Landroid/os/Message;)V

    .line 963
    return-void
.end method

.method public loadVolteE911ScanList(II)V
    .locals 2
    .param p1, "airplaneModeState"    # I
    .param p2, "imsRegiState"    # I

    .prologue
    .line 376
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0x417

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/PhoneBaseEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-interface {v0, p1, p2, v1}, Lcom/android/internal/telephony/CommandsInterface;->loadVolteE911ScanList(IILandroid/os/Message;)V

    .line 377
    return-void
.end method

.method public mocaAlarmEvent([BLandroid/os/Message;)V
    .locals 2
    .param p1, "data"    # [B
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 868
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-mocaAlarmEvent"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 869
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->mocaAlarmEvent([BLandroid/os/Message;)V

    .line 870
    return-void
.end method

.method public mocaAlarmEventReg(ILandroid/os/Message;)V
    .locals 2
    .param p1, "event"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 863
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-mocaAlarmEventReg"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 864
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->mocaAlarmEventReg(ILandroid/os/Message;)V

    .line 865
    return-void
.end method

.method public mocaCheckMem(Landroid/os/Message;)V
    .locals 2
    .param p1, "response"    # Landroid/os/Message;

    .prologue
    .line 899
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-mocaCheckMem"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 900
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1}, Lcom/android/internal/telephony/CommandsInterface;->mocaCheckMem(Landroid/os/Message;)V

    .line 901
    return-void
.end method

.method public mocaGetData(ILandroid/os/Message;)V
    .locals 2
    .param p1, "buf_num"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 878
    if-eqz p1, :cond_0

    const v0, 0xffff

    if-ne p1, v0, :cond_1

    .line 879
    :cond_0
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-mocaGetData"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 881
    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->mocaGetData(ILandroid/os/Message;)V

    .line 882
    return-void
.end method

.method public mocaGetMisc(IILandroid/os/Message;)V
    .locals 2
    .param p1, "kindOfData"    # I
    .param p2, "buf_num"    # I
    .param p3, "response"    # Landroid/os/Message;

    .prologue
    .line 892
    if-eqz p2, :cond_0

    const v0, 0xffff

    if-ne p2, v0, :cond_1

    .line 893
    :cond_0
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-mocaGetMisc"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 895
    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2, p3}, Lcom/android/internal/telephony/CommandsInterface;->mocaGetMisc(IILandroid/os/Message;)V

    .line 896
    return-void
.end method

.method public mocaGetRFParameter(IILandroid/os/Message;)V
    .locals 2
    .param p1, "kindOfData"    # I
    .param p2, "buf_num"    # I
    .param p3, "response"    # Landroid/os/Message;

    .prologue
    .line 885
    if-eqz p2, :cond_0

    const v0, 0xffff

    if-ne p2, v0, :cond_1

    .line 886
    :cond_0
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-mocaGetRFParameter"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 888
    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2, p3}, Lcom/android/internal/telephony/CommandsInterface;->mocaGetRFParameter(IILandroid/os/Message;)V

    .line 889
    return-void
.end method

.method public mocaSetEvent([BLandroid/os/Message;)V
    .locals 2
    .param p1, "data"    # [B
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 858
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-mocaSetEvent"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 859
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->mocaSetEvent([BLandroid/os/Message;)V

    .line 860
    return-void
.end method

.method public mocaSetLog([BLandroid/os/Message;)V
    .locals 2
    .param p1, "data"    # [B
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 854
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-mocaSetLog"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 855
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->mocaSetLog([BLandroid/os/Message;)V

    .line 856
    return-void
.end method

.method public mocaSetMem(ILandroid/os/Message;)V
    .locals 2
    .param p1, "percent"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 873
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-mocaSetMem"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 874
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->mocaSetMem(ILandroid/os/Message;)V

    .line 875
    return-void
.end method

.method public oemSsaAlarmEvent([BLandroid/os/Message;)V
    .locals 2
    .param p1, "data"    # [B
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 829
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-oemSsaAlarmEvent"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 830
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->oemSsaAlarmEvent([BLandroid/os/Message;)V

    .line 831
    return-void
.end method

.method public oemSsaCheckMem(Landroid/os/Message;)V
    .locals 2
    .param p1, "response"    # Landroid/os/Message;

    .prologue
    .line 848
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-oemSsaCheckMem"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 849
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1}, Lcom/android/internal/telephony/CommandsInterface;->oemSsaCheckMem(Landroid/os/Message;)V

    .line 850
    return-void
.end method

.method public oemSsaGetData(ILandroid/os/Message;)V
    .locals 2
    .param p1, "buf_num"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 844
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-oemSsaGetData"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 845
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->oemSsaGetData(ILandroid/os/Message;)V

    .line 846
    return-void
.end method

.method public oemSsaHdvAlarmEvent([BLandroid/os/Message;)V
    .locals 2
    .param p1, "data"    # [B
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 834
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-oemSsaHdvAlarmEvent"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 835
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->oemSsaHdvAlarmEvent([BLandroid/os/Message;)V

    .line 836
    return-void
.end method

.method public oemSsaSetEvent([BLandroid/os/Message;)V
    .locals 2
    .param p1, "data"    # [B
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 824
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-oemSsaSetEvent"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 825
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->oemSsaSetEvent([BLandroid/os/Message;)V

    .line 826
    return-void
.end method

.method public oemSsaSetLog([BLandroid/os/Message;)V
    .locals 2
    .param p1, "data"    # [B
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 820
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-oemSsaSetLog"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 821
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->oemSsaSetLog([BLandroid/os/Message;)V

    .line 822
    return-void
.end method

.method public oemSsaSetMem(ILandroid/os/Message;)V
    .locals 2
    .param p1, "percent"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 839
    const-string v0, "PhoneBase"

    const-string v1, "phonebase-oemSsaSetMem"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 840
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->oemSsaSetMem(ILandroid/os/Message;)V

    .line 841
    return-void
.end method

.method public prepareEri()V
    .locals 1

    .prologue
    .line 391
    const-string v0, "prepareEri"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 392
    return-void
.end method

.method public registerForSetPreferredNetworkType(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 284
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mReferredNetworkTypeRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1, p2, p3}, Landroid/os/RegistrantList;->addUnique(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 285
    return-void
.end method

.method public registerLGECipheringInd(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 517
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2, p3}, Lcom/android/internal/telephony/CommandsInterface;->registerLGECipheringInd(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 518
    return-void
.end method

.method public registerLGERACInd(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 967
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2, p3}, Lcom/android/internal/telephony/CommandsInterface;->registerLGERACInd(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 968
    return-void
.end method

.method public registerLGEUnsol(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 442
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2, p3}, Lcom/android/internal/telephony/CommandsInterface;->registerLGEUnsol(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 443
    return-void
.end method

.method public resetVoiceMessageCount()V
    .locals 1

    .prologue
    .line 732
    const-string v0, "resetVoiceMessageCount"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 733
    return-void
.end method

.method public selectPreviousNetworkManually(Lcom/android/internal/telephony/OperatorInfo;Landroid/os/Message;)V
    .locals 2
    .param p1, "network"    # Lcom/android/internal/telephony/OperatorInfo;
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 951
    const-string v0, "PhoneBase"

    const-string v1, "selectPreviousNetworkManually: not possible in CDMA"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 952
    return-void
.end method

.method public sendIMSRegistate(I)V
    .locals 2
    .param p1, "regiState"    # I

    .prologue
    .line 511
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Lcom/android/internal/telephony/CommandsInterface;->sendIMSRegistate(ILandroid/os/Message;)V

    .line 512
    return-void
.end method

.method public setCSGSelectionManual(ILandroid/os/Message;)V
    .locals 2
    .param p1, "data"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 956
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->setCSGSelectionManual(ILandroid/os/Message;)V

    .line 957
    const-string v0, "PhoneBase"

    const-string v1, "setCSGSelectionManualt "

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 958
    return-void
.end method

.method public setCallBarringOption(ILjava/lang/String;ILjava/lang/String;Landroid/os/Message;)V
    .locals 1
    .param p1, "commandInterfaceCBAction"    # I
    .param p2, "commandInterfaceCBReason"    # Ljava/lang/String;
    .param p3, "serviceClass"    # I
    .param p4, "password"    # Ljava/lang/String;
    .param p5, "onComplete"    # Landroid/os/Message;

    .prologue
    .line 337
    const-string v0, "setCallBarringOption"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 338
    return-void
.end method

.method public setCallBarringPass(Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)V
    .locals 1
    .param p1, "oldPwd"    # Ljava/lang/String;
    .param p2, "newPwd"    # Ljava/lang/String;
    .param p3, "onComplete"    # Landroid/os/Message;

    .prologue
    .line 341
    const-string v0, "setCallBarringPass"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 342
    return-void
.end method

.method public setCallForwardingOption(IILjava/lang/String;IILandroid/os/Message;)V
    .locals 1
    .param p1, "commandInterfaceCFAction"    # I
    .param p2, "commandInterfaceCFReason"    # I
    .param p3, "dialingNumber"    # Ljava/lang/String;
    .param p4, "serviceClass"    # I
    .param p5, "timerSeconds"    # I
    .param p6, "onComplete"    # Landroid/os/Message;

    .prologue
    .line 324
    const-string v0, "setCallForwardingOption"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 325
    return-void
.end method

.method public setCdmaEriVersion(ILandroid/os/Message;)V
    .locals 1
    .param p1, "value"    # I
    .param p2, "result"    # Landroid/os/Message;

    .prologue
    .line 423
    const-string v0, "setCdmaEriVersion"

    invoke-static {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->logUnexpectedCdmaMethodCall(Ljava/lang/String;)V

    .line 424
    return-void
.end method

.method public setCdmaFactoryReset(Landroid/os/Message;)V
    .locals 2
    .param p1, "result"    # Landroid/os/Message;

    .prologue
    .line 428
    const-string v0, "PhoneBase"

    const-string v1, "setCdmaFactoryReset"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 429
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1}, Lcom/android/internal/telephony/CommandsInterface;->setCdmaFactoryReset(Landroid/os/Message;)V

    .line 430
    return-void
.end method

.method public setDebugInfoValue(ILandroid/os/Message;)V
    .locals 3
    .param p1, "param"    # I
    .param p2, "result"    # Landroid/os/Message;

    .prologue
    .line 906
    const-string v0, "PhoneBase"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setDebugInfoValue param = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 907
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->setDebugInfoValue(ILandroid/os/Message;)V

    .line 908
    return-void
.end method

.method public setImsStatusForDan(ILandroid/os/Message;)V
    .locals 1
    .param p1, "ims_status"    # I
    .param p2, "result"    # Landroid/os/Message;

    .prologue
    .line 587
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->setImsStatusForDan(ILandroid/os/Message;)V

    .line 588
    return-void
.end method

.method public setIsE911ForVolte(Z)V
    .locals 3
    .param p1, "isE911ForVolte"    # Z

    .prologue
    .line 364
    const-string v0, "PhoneBase"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setIsE911ForVolte() - isE911ForVolte = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 365
    iput-boolean p1, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mIsE911ForVolte:Z

    .line 366
    return-void
.end method

.method public setLteACarrierAggregation(ILandroid/os/Message;)V
    .locals 1
    .param p1, "param"    # I
    .param p2, "result"    # Landroid/os/Message;

    .prologue
    .line 918
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->setLteACarrierAggregation(ILandroid/os/Message;)V

    .line 919
    return-void
.end method

.method public setMiMoAntennaControlTest(Landroid/os/Message;I)V
    .locals 1
    .param p1, "result"    # Landroid/os/Message;
    .param p2, "mask"    # I

    .prologue
    .line 651
    const/16 v0, 0x8

    invoke-virtual {p0, p1, v0, p2}, Lcom/android/internal/telephony/PhoneBaseEx;->setMiMoAntennaControlTest(Landroid/os/Message;II)V

    .line 652
    return-void
.end method

.method public setMiMoAntennaControlTest(Landroid/os/Message;II)V
    .locals 1
    .param p1, "result"    # Landroid/os/Message;
    .param p2, "sys_mode"    # I
    .param p3, "mask"    # I

    .prologue
    .line 654
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2, p3}, Lcom/android/internal/telephony/CommandsInterface;->setMiMoAntennaControlTest(Landroid/os/Message;II)V

    .line 655
    return-void
.end method

.method public setModemIntegerItem(IILandroid/os/Message;)V
    .locals 3
    .param p1, "item_index"    # I
    .param p2, "data"    # I
    .param p3, "response"    # Landroid/os/Message;

    .prologue
    .line 455
    const-string v0, "PhoneBase"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PhoneBase setModemIntegerItem data = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 456
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2, p3}, Lcom/android/internal/telephony/CommandsInterface;->setModemIntegerItem(IILandroid/os/Message;)V

    .line 457
    return-void
.end method

.method public setModemStringItem(ILjava/lang/String;Landroid/os/Message;)V
    .locals 3
    .param p1, "item_index"    # I
    .param p2, "data"    # Ljava/lang/String;
    .param p3, "response"    # Landroid/os/Message;

    .prologue
    .line 467
    const-string v0, "PhoneBase"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PhoneBase setModemStringItem data = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 468
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2, p3}, Lcom/android/internal/telephony/CommandsInterface;->setModemStringItem(ILjava/lang/String;Landroid/os/Message;)V

    .line 469
    return-void
.end method

.method public setPreferredNetworkType(ILandroid/os/Message;)V
    .locals 2
    .param p1, "networkType"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 296
    invoke-super {p0, p1, p2}, Lcom/android/internal/telephony/PhoneBase;->setPreferredNetworkType(ILandroid/os/Message;)V

    .line 299
    const/4 v0, 0x0

    const-string v1, "vzw_gfit"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 300
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mReferredNetworkTypeRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0}, Landroid/os/RegistrantList;->notifyRegistrants()V

    .line 303
    :cond_0
    return-void
.end method

.method public setRmnetAutoconnect(ILandroid/os/Message;)V
    .locals 1
    .param p1, "param"    # I
    .param p2, "result"    # Landroid/os/Message;

    .prologue
    .line 314
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->setRmnetAutoconnect(ILandroid/os/Message;)V

    .line 315
    return-void
.end method

.method public setTddStatus(ILandroid/os/Message;)V
    .locals 10
    .param p1, "status"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    const/16 v9, 0x423

    const/4 v8, 0x2

    const/16 v7, 0xb

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 773
    iget-object v2, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "preferred_network_mode"

    sget v4, Lcom/android/internal/telephony/RILConstants;->PREFERRED_NETWORK_MODE:I

    invoke-static {v2, v3, v4}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    .line 775
    .local v1, "nwMode":I
    const-string v2, "PhoneBase"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CTC : setTddStatus status = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " PREFERRED_NETWORK_MODE = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 776
    const/16 v2, 0x8

    if-ge v1, v2, :cond_1

    if-ne p1, v6, :cond_1

    .line 777
    const-string v2, "PhoneBase"

    const-string v3, "CTC : can not call setTddStatus(1) at LTE off"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 778
    if-eqz p2, :cond_0

    .line 780
    invoke-static {v8}, Lcom/android/internal/telephony/CommandException;->fromRilErrno(I)Lcom/android/internal/telephony/CommandException;

    move-result-object v0

    .line 781
    .local v0, "ex":Lcom/android/internal/telephony/CommandException;
    const/4 v2, 0x0

    invoke-static {p2, v2, v0}, Landroid/os/AsyncResult;->forMessage(Landroid/os/Message;Ljava/lang/Object;Ljava/lang/Throwable;)Landroid/os/AsyncResult;

    .line 782
    invoke-virtual {p2}, Landroid/os/Message;->sendToTarget()V

    .line 809
    .end local v0    # "ex":Lcom/android/internal/telephony/CommandException;
    :cond_0
    :goto_0
    return-void

    .line 786
    :cond_1
    if-ne p1, v6, :cond_2

    .line 787
    if-eq v1, v7, :cond_4

    .line 788
    iget-object v2, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-virtual {p0, v9, v6, v5, p2}, Lcom/android/internal/telephony/PhoneBaseEx;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v3

    invoke-interface {v2, v7, v3}, Lcom/android/internal/telephony/CommandsInterface;->setPreferredNetworkType(ILandroid/os/Message;)V

    goto :goto_0

    .line 792
    :cond_2
    if-nez p1, :cond_3

    .line 793
    if-eq v1, v7, :cond_4

    .line 794
    iget-object v2, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-virtual {p0, v9, v5, v5, p2}, Lcom/android/internal/telephony/PhoneBaseEx;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v3

    invoke-interface {v2, v1, v3}, Lcom/android/internal/telephony/CommandsInterface;->setPreferredNetworkType(ILandroid/os/Message;)V

    goto :goto_0

    .line 799
    :cond_3
    const-string v2, "PhoneBase"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CTC : setTddStatus status something wrong !! "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 800
    if-eqz p2, :cond_0

    .line 802
    invoke-static {v8}, Lcom/android/internal/telephony/CommandException;->fromRilErrno(I)Lcom/android/internal/telephony/CommandException;

    move-result-object v0

    .line 803
    .restart local v0    # "ex":Lcom/android/internal/telephony/CommandException;
    const/4 v2, 0x0

    invoke-static {p2, v2, v0}, Landroid/os/AsyncResult;->forMessage(Landroid/os/Message;Ljava/lang/Object;Ljava/lang/Throwable;)Landroid/os/AsyncResult;

    .line 804
    invoke-virtual {p2}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 808
    .end local v0    # "ex":Lcom/android/internal/telephony/CommandException;
    :cond_4
    iget-object v2, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-direct {p0, p1}, Lcom/android/internal/telephony/PhoneBaseEx;->getLteBand(I)J

    move-result-wide v4

    invoke-interface {v2, v4, v5, p2}, Lcom/android/internal/telephony/CommandsInterface;->setLteBandMode(JLandroid/os/Message;)V

    goto :goto_0
.end method

.method public setUeMode(ILandroid/os/Message;)V
    .locals 1
    .param p1, "uemode"    # I
    .param p2, "result"    # Landroid/os/Message;

    .prologue
    .line 931
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->setUeMode(ILandroid/os/Message;)V

    .line 932
    return-void
.end method

.method public setVoiceMessageUrgent(Z)V
    .locals 0
    .param p1, "urgent"    # Z

    .prologue
    .line 740
    iput-boolean p1, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mVmUrgent:Z

    .line 741
    return-void
.end method

.method public setVoiceMessageWaiting(II)V
    .locals 2
    .param p1, "line"    # I
    .param p2, "countWaiting"    # I

    .prologue
    .line 753
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mContext:Landroid/content/Context;

    const-string v1, "KRVMSType"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 761
    :goto_0
    return-void

    .line 760
    :cond_0
    const-string v0, "PhoneBase"

    const-string v1, "Error! This function should never be executed, inactive Phone."

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public uknightEventSet([BLandroid/os/Message;)V
    .locals 1
    .param p1, "data"    # [B
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 595
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->uknightEventSet([BLandroid/os/Message;)V

    .line 596
    return-void
.end method

.method public uknightGetData(ILandroid/os/Message;)V
    .locals 1
    .param p1, "buf_num"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 604
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->uknightGetData(ILandroid/os/Message;)V

    .line 605
    return-void
.end method

.method public uknightLogSet([BLandroid/os/Message;)V
    .locals 1
    .param p1, "data"    # [B
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 592
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->uknightLogSet([BLandroid/os/Message;)V

    .line 593
    return-void
.end method

.method public uknightMemCheck(Landroid/os/Message;)V
    .locals 1
    .param p1, "response"    # Landroid/os/Message;

    .prologue
    .line 607
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1}, Lcom/android/internal/telephony/CommandsInterface;->uknightMemCheck(Landroid/os/Message;)V

    .line 608
    return-void
.end method

.method public uknightMemSet(ILandroid/os/Message;)V
    .locals 1
    .param p1, "percent"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 601
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->uknightMemSet(ILandroid/os/Message;)V

    .line 602
    return-void
.end method

.method public uknightStateChangeSet(ILandroid/os/Message;)V
    .locals 1
    .param p1, "event"    # I
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 598
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/telephony/CommandsInterface;->uknightStateChangeSet(ILandroid/os/Message;)V

    .line 599
    return-void
.end method

.method public unregisterForSetPreferredNetworkType(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 288
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mReferredNetworkTypeRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 289
    return-void
.end method

.method public unregisterLGECipheringInd(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 521
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1}, Lcom/android/internal/telephony/CommandsInterface;->unregisterLGECipheringInd(Landroid/os/Handler;)V

    .line 522
    return-void
.end method

.method public unregisterLGERACInd(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 970
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1}, Lcom/android/internal/telephony/CommandsInterface;->unregisterLGERACInd(Landroid/os/Handler;)V

    .line 971
    return-void
.end method

.method public unregisterLGEUnsol(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 449
    iget-object v0, p0, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1}, Lcom/android/internal/telephony/CommandsInterface;->unregisterLGEUnsol(Landroid/os/Handler;)V

    .line 450
    return-void
.end method
