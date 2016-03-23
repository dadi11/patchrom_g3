.class public Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;
.super Ljava/lang/Object;
.source "LgeSimInfo.java"

# interfaces
.implements Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfilingConstants;


# static fields
.field private static final DBG:Z = true

.field private static final EDBG:Z = true

.field private static final TAG:Ljava/lang/String; = "LgeSimInfo"

.field private static final VDBG:Z = true

.field private static final VDF_MCC_MNC_TABLE:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mGid:Ljava/lang/String;

.field private mImsi:Ljava/lang/String;

.field private mMcc:Ljava/lang/String;

.field private mMnc:Ljava/lang/String;

.field private mPhoneId:I

.field private mSpn:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 64
    new-instance v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo$1;

    invoke-direct {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo$1;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->VDF_MCC_MNC_TABLE:Ljava/util/HashMap;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 85
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 87
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 0
    .param p1, "mcc"    # Ljava/lang/String;
    .param p2, "mnc"    # Ljava/lang/String;
    .param p3, "gid"    # Ljava/lang/String;
    .param p4, "spn"    # Ljava/lang/String;
    .param p5, "imsi"    # Ljava/lang/String;
    .param p6, "phoneId"    # I

    .prologue
    .line 89
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 90
    iput-object p1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMcc:Ljava/lang/String;

    .line 91
    iput-object p2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMnc:Ljava/lang/String;

    .line 92
    iput-object p3, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mGid:Ljava/lang/String;

    .line 93
    iput-object p4, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mSpn:Ljava/lang/String;

    .line 94
    iput-object p5, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mImsi:Ljava/lang/String;

    .line 95
    iput p6, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mPhoneId:I

    .line 96
    return-void
.end method

.method public static createFromPreference(Landroid/content/Context;I)Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "phoneId"    # I

    .prologue
    const/4 v6, 0x0

    .line 250
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "simInfo_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v7

    .line 252
    .local v7, "preference":Landroid/content/SharedPreferences;
    new-instance v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;

    const-string v1, "mcc"

    invoke-interface {v7, v1, v6}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "mnc"

    invoke-interface {v7, v2, v6}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "gid"

    invoke-interface {v7, v3, v6}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "spn"

    invoke-interface {v7, v4, v6}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "imsi"

    invoke-interface {v7, v5, v6}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move v6, p1

    invoke-direct/range {v0 .. v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    return-object v0
.end method

.method static getDefaultPhoneId()I
    .locals 2

    .prologue
    .line 318
    invoke-static {}, Landroid/telephony/SubscriptionManager;->getDefaultSubId()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getPhoneId(J)I

    move-result v0

    return v0
.end method

.method private static getMCCMNC_VdfGlobalProfiling(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;
    .locals 5
    .param p0, "mcc"    # Ljava/lang/String;
    .param p1, "mnc"    # Ljava/lang/String;

    .prologue
    .line 165
    const-string v2, "LgeSimInfo"

    const-string v3, "[getSimInfo] VDF Regional Feature"

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 167
    const-string v2, "persist.radio.mcc-list"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 169
    .local v0, "mccList":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    .line 170
    const-string v2, ","

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    .line 172
    .local v1, "regionalVersion":Ljava/lang/Boolean;
    const-string v2, "LgeSimInfo"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[getSimInfo] mccList exists, mccList : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", regionalVersion : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 174
    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 175
    invoke-virtual {v0, p0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 176
    const-string v2, "LgeSimInfo"

    const-string v3, "[getSimInfo] MCC from SIM doesn\'t exist in the list"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 178
    const-string p0, ""

    .line 179
    const-string p1, ""

    .line 193
    .end local v1    # "regionalVersion":Ljava/lang/Boolean;
    :cond_0
    :goto_0
    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    aput-object p0, v2, v3

    const/4 v3, 0x1

    aput-object p1, v2, v3

    return-object v2

    .line 182
    .restart local v1    # "regionalVersion":Ljava/lang/Boolean;
    :cond_1
    move-object p0, v0

    .line 183
    sget-object v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->VDF_MCC_MNC_TABLE:Ljava/util/HashMap;

    invoke-virtual {v2, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    .end local p1    # "mnc":Ljava/lang/String;
    check-cast p1, Ljava/lang/String;

    .line 185
    .restart local p1    # "mnc":Ljava/lang/String;
    if-nez p1, :cond_0

    .line 186
    const-string v2, "LgeSimInfo"

    const-string v3, "[getSimInfo] error.. cannot find matched mnc"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 188
    const-string p0, ""

    .line 189
    const-string p1, ""

    goto :goto_0
.end method

.method static getPhoneId(J)I
    .locals 4
    .param p0, "subId"    # J

    .prologue
    .line 322
    invoke-static {p0, p1}, Landroid/telephony/SubscriptionManager;->getPhoneId(J)I

    move-result v0

    .line 324
    .local v0, "phoneId":I
    if-ltz v0, :cond_0

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getPhoneCount()I

    move-result v1

    if-lt v0, v1, :cond_1

    .line 325
    :cond_0
    const/4 v0, 0x0

    .line 329
    :cond_1
    const-string v1, "LgeSimInfo"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getPhoneId() : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 332
    return v0
.end method

.method public static getSimChangedInfo(I)Ljava/lang/String;
    .locals 4
    .param p0, "phoneId"    # I

    .prologue
    .line 198
    const-string v1, ""

    .line 199
    .local v1, "simChanged":Ljava/lang/String;
    const-string v0, "persist.radio.iccid-changed"

    .line 200
    .local v0, "iccidStatusprop":Ljava/lang/String;
    if-eqz p0, :cond_0

    .line 201
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    add-int/lit8 v3, p0, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 204
    :cond_0
    const-string v2, "F"

    invoke-static {v0, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 206
    return-object v1
.end method

.method public static getSimInfo()Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;
    .locals 1

    .prologue
    .line 99
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getDefaultPhoneId()I

    move-result v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getSimInfo(I)Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;

    move-result-object v0

    return-object v0
.end method

.method public static getSimInfo(I)Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;
    .locals 14
    .param p0, "phoneId"    # I

    .prologue
    .line 104
    const/4 v1, 0x0

    .line 105
    .local v1, "mcc":Ljava/lang/String;
    const/4 v2, 0x0

    .line 106
    .local v2, "mnc":Ljava/lang/String;
    const/4 v4, 0x0

    .line 107
    .local v4, "spn":Ljava/lang/String;
    const/4 v3, 0x0

    .line 108
    .local v3, "gid":Ljava/lang/String;
    const-string v5, ""

    .line 109
    .local v5, "imsi":Ljava/lang/String;
    const/4 v7, 0x0

    .line 110
    .local v7, "numeric":Ljava/lang/String;
    const/4 v8, 0x0

    .line 112
    .local v8, "simState":I
    invoke-static {p0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getSubIdUsingPhoneId(I)J

    move-result-wide v10

    .line 114
    .local v10, "subId":J
    invoke-static {v10, v11}, Landroid/telephony/SubscriptionManager;->getSlotId(J)I

    move-result v9

    .line 116
    .local v9, "slotId":I
    const-string v0, "gsm.sim.operator.numeric"

    const-string v6, ""

    invoke-static {v0, v10, v11, v6}, Landroid/telephony/TelephonyManager;->getTelephonyProperty(Ljava/lang/String;JLjava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 117
    const-string v0, "gsm.sim.operator.alpha"

    const-string v6, ""

    invoke-static {v0, v10, v11, v6}, Landroid/telephony/TelephonyManager;->getTelephonyProperty(Ljava/lang/String;JLjava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 120
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Landroid/telephony/TelephonyManagerEx;->getDefault()Landroid/telephony/TelephonyManagerEx;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 121
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0, v9}, Landroid/telephony/TelephonyManager;->getSimState(I)I

    move-result v8

    .line 122
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Landroid/telephony/TelephonyManagerEx;->getDefault()Landroid/telephony/TelephonyManagerEx;

    move-result-object v6

    invoke-virtual {v6, v10, v11}, Landroid/telephony/TelephonyManagerEx;->getMSIN(J)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 123
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0, v10, v11}, Landroid/telephony/TelephonyManager;->getGroupIdLevel1(J)Ljava/lang/String;

    move-result-object v3

    .line 126
    const-string v0, "LgeSimInfo"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "TelephonyManagerEx : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {}, Landroid/telephony/TelephonyManagerEx;->getDefault()Landroid/telephony/TelephonyManagerEx;

    move-result-object v13

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, " TelephonyManager : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v13

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, " getIMSI: "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const/16 v13, 0x100

    invoke-static {v5, v13}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->privateLogHandler(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, " getGroupIdLevel1: "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const/16 v13, 0x100

    invoke-static {v3, v13}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->privateLogHandler(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v0, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 134
    :cond_0
    const/4 v0, 0x2

    if-eq v0, v8, :cond_3

    const/4 v0, 0x3

    if-eq v0, v8, :cond_3

    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v6, 0x5

    if-lt v0, v6, :cond_3

    .line 137
    const/4 v0, 0x0

    const/4 v6, 0x3

    invoke-virtual {v7, v0, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 138
    const/4 v0, 0x3

    invoke-virtual {v7, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    .line 149
    :goto_0
    const-string v0, "EU"

    const-string v6, "VDF"

    invoke-static {v0, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "COM"

    const-string v6, "VDF"

    invoke-static {v0, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "ro.build.regional"

    const/4 v6, 0x0

    invoke-static {v0, v6}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 153
    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getMCCMNC_VdfGlobalProfiling(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v12

    .line 154
    .local v12, "vdf_mccmnc":[Ljava/lang/String;
    const/4 v0, 0x0

    aget-object v1, v12, v0

    .line 155
    const/4 v0, 0x1

    aget-object v2, v12, v0

    .line 158
    .end local v12    # "vdf_mccmnc":[Ljava/lang/String;
    :cond_2
    const-string v0, "LgeSimInfo"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "[getSimInfo] *** SIM Info, MCC : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, ", MNC : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, ", subId : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, ", phoneId : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, ", slotId : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, ", IMSI : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v0, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 160
    new-instance v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;

    move v6, p0

    invoke-direct/range {v0 .. v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    return-object v0

    .line 142
    :cond_3
    const-string v0, "LgeSimInfo"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "[getSimInfo] numeric is invalid, numeric : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const/16 v13, 0x100

    invoke-static {v7, v13}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->privateLogHandler(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, ", subId : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, ", phoneId : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v13, ", slotId : "

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v0, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0
.end method

.method static getSubIdUsingPhoneId(I)J
    .locals 4
    .param p0, "phoneId"    # I

    .prologue
    .line 336
    const-wide/16 v0, -0x3e8

    .line 338
    .local v0, "subId":J
    invoke-static {p0}, Landroid/telephony/SubscriptionManager;->getSubId(I)[J

    move-result-object v2

    .line 340
    .local v2, "subIds":[J
    if-eqz v2, :cond_0

    array-length v3, v2

    if-lez v3, :cond_0

    .line 341
    const/4 v3, 0x0

    aget-wide v0, v2, v3

    .line 344
    :cond_0
    return-wide v0
.end method

.method public static writeToPreference(Landroid/content/Context;Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;I)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "simInfo"    # Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;
    .param p2, "phoneId"    # I

    .prologue
    .line 260
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "simInfo_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {p0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 262
    .local v0, "editor":Landroid/content/SharedPreferences$Editor;
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    .line 264
    const-string v1, "mcc"

    invoke-virtual {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getMcc()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 265
    const-string v1, "mnc"

    invoke-virtual {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getMnc()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 266
    const-string v1, "gid"

    invoke-virtual {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getGid()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 267
    const-string v1, "spn"

    invoke-virtual {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getSpn()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 268
    const-string v1, "imsi"

    invoke-virtual {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getImsi()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 270
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 271
    return-void
.end method


# virtual methods
.method public equals(Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;)Z
    .locals 4
    .param p1, "simInfo"    # Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 220
    if-ne p0, p1, :cond_0

    .line 221
    const-string v1, "LgeSimInfo"

    const-string v2, "[equals] return true"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 242
    :goto_0
    return v0

    .line 225
    :cond_0
    if-nez p1, :cond_1

    .line 226
    const-string v0, "LgeSimInfo"

    const-string v2, "[equals] return false"

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v0, v1

    .line 227
    goto :goto_0

    .line 230
    :cond_1
    iget-object v2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMcc:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    iget-object v2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMnc:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    iget-object v2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mImsi:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 231
    iget-object v2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMcc:Ljava/lang/String;

    invoke-virtual {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getMcc()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMnc:Ljava/lang/String;

    invoke-virtual {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getMnc()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mGid:Ljava/lang/String;

    invoke-virtual {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getGid()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mSpn:Ljava/lang/String;

    invoke-virtual {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getSpn()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mImsi:Ljava/lang/String;

    invoke-virtual {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getImsi()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 236
    const-string v1, "LgeSimInfo"

    const-string v2, "[equals] return true"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 241
    :cond_2
    const-string v0, "LgeSimInfo"

    const-string v2, "[equals] return false"

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v0, v1

    .line 242
    goto :goto_0
.end method

.method public getGid()Ljava/lang/String;
    .locals 1

    .prologue
    .line 294
    iget-object v0, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mGid:Ljava/lang/String;

    return-object v0
.end method

.method public getImsi()Ljava/lang/String;
    .locals 1

    .prologue
    .line 310
    iget-object v0, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mImsi:Ljava/lang/String;

    return-object v0
.end method

.method public getMcc()Ljava/lang/String;
    .locals 1

    .prologue
    .line 278
    iget-object v0, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMcc:Ljava/lang/String;

    return-object v0
.end method

.method public getMnc()Ljava/lang/String;
    .locals 1

    .prologue
    .line 286
    iget-object v0, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMnc:Ljava/lang/String;

    return-object v0
.end method

.method public getPhoneId()I
    .locals 1

    .prologue
    .line 314
    iget v0, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mPhoneId:I

    return v0
.end method

.method public getSpn()Ljava/lang/String;
    .locals 1

    .prologue
    .line 302
    iget-object v0, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mSpn:Ljava/lang/String;

    return-object v0
.end method

.method public isNull()Z
    .locals 1

    .prologue
    .line 246
    iget-object v0, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMcc:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMnc:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setGid(Ljava/lang/String;)V
    .locals 0
    .param p1, "gid"    # Ljava/lang/String;

    .prologue
    .line 290
    iput-object p1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mGid:Ljava/lang/String;

    .line 291
    return-void
.end method

.method public setImsi(Ljava/lang/String;)V
    .locals 0
    .param p1, "imsi"    # Ljava/lang/String;

    .prologue
    .line 306
    iput-object p1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mImsi:Ljava/lang/String;

    .line 307
    return-void
.end method

.method public setMcc(Ljava/lang/String;)V
    .locals 0
    .param p1, "mcc"    # Ljava/lang/String;

    .prologue
    .line 274
    iput-object p1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMcc:Ljava/lang/String;

    .line 275
    return-void
.end method

.method public setMnc(Ljava/lang/String;)V
    .locals 0
    .param p1, "mnc"    # Ljava/lang/String;

    .prologue
    .line 282
    iput-object p1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMnc:Ljava/lang/String;

    .line 283
    return-void
.end method

.method public setSpn(Ljava/lang/String;)V
    .locals 0
    .param p1, "spn"    # Ljava/lang/String;

    .prologue
    .line 298
    iput-object p1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mSpn:Ljava/lang/String;

    .line 299
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .prologue
    .line 213
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "SimInfo - MCC : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMcc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", MNC : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mMnc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", GID : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mGid:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", SPN : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mSpn:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", IMSI : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->mImsi:Ljava/lang/String;

    const/16 v2, 0x100

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->privateLogHandler(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
