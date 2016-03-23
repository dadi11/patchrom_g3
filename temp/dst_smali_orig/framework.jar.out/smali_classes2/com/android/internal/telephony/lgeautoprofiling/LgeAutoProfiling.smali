.class public Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;
.super Ljava/lang/Object;
.source "LgeAutoProfiling.java"

# interfaces
.implements Lcom/android/internal/telephony/lgeautoprofiling/LgeKeyProfiling;
.implements Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfilingConstants;


# static fields
.field private static final DBG:Z = false

.field private static final EDBG:Z = true

.field private static final VDBG:Z = true

.field private static sCardOperator:Ljava/lang/String;

.field private static sIsCardOperatorCached:Z

.field private static sIsDebugMode:Z

.field private static sIsEnabled:Z

.field private static sLogDialstring:I

.field private static sLogFeatureLoaded:Z

.field private static sLogIdentity:I

.field private static sLogUssd:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v1, 0x0

    sput v1, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogUssd:I

    sput v1, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogDialstring:I

    sput v1, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogIdentity:I

    sput-boolean v1, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogFeatureLoaded:Z

    const-string v0, "1"

    const-string v2, "ro.debuggable"

    const-string v3, "0"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    sput-boolean v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsDebugMode:Z

    const-string v0, "persist.service.plog.enable"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "persist.service.privacy.enable"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_0

    sget-boolean v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsDebugMode:Z

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsEnabled:Z

    const-string v0, ""

    sput-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sCardOperator:Ljava/lang/String;

    sput-boolean v1, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsCardOperatorCached:Z

    return-void

    :cond_1
    move v0, v1

    goto :goto_0
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static checkEccIdleMode(Ljava/lang/String;)Z
    .locals 10
    .param p0, "dialNumber"    # Ljava/lang/String;

    .prologue
    const/4 v6, 0x0

    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_1

    :cond_0
    :goto_0
    return v6

    :cond_1
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getDefaultPhoneId()I

    move-result v1

    .local v1, "defaultPhoneId":I
    const-string v7, "CTC"

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_2

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v7

    invoke-virtual {v7}, Landroid/telephony/TelephonyManager;->isMultiSimEnabled()Z

    move-result v7

    if-eqz v7, :cond_2

    const-string v7, "ril.curr.call.sub"

    invoke-static {v7, v1}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v1

    const-string v7, "TelephonyAutoProfiling"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "CTC : [checkEccIdleMode] defaultPhoneId change to "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    const/4 v7, 0x0

    const-string v8, "ECC_IdleMode"

    invoke-static {v7, v8, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    .local v2, "eccIdleModeList":Ljava/lang/String;
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_0

    const-string v7, ","

    invoke-virtual {v2, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .local v0, "arr$":[Ljava/lang/String;
    array-length v4, v0

    .local v4, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_1
    if-ge v3, v4, :cond_0

    aget-object v5, v0, v3

    .local v5, "token":Ljava/lang/String;
    invoke-virtual {p0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_3

    const-string v6, "TelephonyAutoProfiling"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[checkEccIdleMode] Ecc_IdleMode : true - "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const/16 v8, 0x10

    invoke-static {p0, v8}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->privateLogHandler(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v6, 0x1

    goto :goto_0

    :cond_3
    add-int/lit8 v3, v3, 0x1

    goto :goto_1
.end method

.method public static checkShortCodeCall(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "number"    # Ljava/lang/String;

    .prologue
    const/4 v6, 0x0

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_1

    :cond_0
    :goto_0
    return v6

    :cond_1
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getDefaultPhoneId()I

    move-result v1

    .local v1, "defaultPhoneId":I
    const-string v7, "ShortCodeCall"

    invoke-static {p0, v7, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v4

    .local v4, "shortCode":Ljava/lang/String;
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_0

    const-string v7, ","

    invoke-virtual {v4, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .local v0, "arr$":[Ljava/lang/String;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_1
    if-ge v2, v3, :cond_0

    aget-object v5, v0, v2

    .local v5, "token":Ljava/lang/String;
    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    const/4 v6, 0x1

    goto :goto_0

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1
.end method

.method public static getClirSettingValue(Landroid/content/Context;)I
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getDefaultPhoneId()I

    move-result v1

    .local v1, "defaultPhoneId":I
    invoke-static {p0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getClirSettingValue(Landroid/content/Context;I)I

    move-result v0

    .local v0, "clirSettingValue":I
    return v0
.end method

.method public static getClirSettingValue(Landroid/content/Context;I)I
    .locals 7
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "phoneId"    # I

    .prologue
    const-string v4, "SendMyNumberInformation"

    invoke-static {p0, v4, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    .local v1, "clirSetting":Ljava/lang/String;
    invoke-static {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getSimChangedInfo(I)Ljava/lang/String;

    move-result-object v3

    .local v3, "simChangedInfo":Ljava/lang/String;
    const-string v4, "gsm.call.clir.init"

    invoke-static {v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "clirInit":Ljava/lang/String;
    const/4 v2, -0x1

    .local v2, "clirSettingValue":I
    const-string v4, "0"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    const-string v4, "gsm.call.clir.init"

    const-string v5, ""

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string v4, "0"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    add-int/lit8 v4, p1, 0x1

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    const-string v4, "gsm.call.clir.init"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    add-int/lit8 v6, p1, 0x1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v4, "TelephonyAutoProfiling"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[getClirSettingValue] This is First time after SIM change :: gsm.call.clir.init = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    return v2
.end method

.method public static getECCList(Landroid/content/Context;)[Ljava/lang/String;
    .locals 7
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getDefaultPhoneId()I

    move-result v2

    .local v2, "defaultPhoneId":I
    const-string v6, "ECC_list"

    invoke-static {p0, v6, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .local v0, "NumberString":Ljava/lang/String;
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .local v4, "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    new-instance v5, Ljava/util/StringTokenizer;

    const-string v6, ","

    invoke-direct {v5, v0, v6}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .local v5, "st":Ljava/util/StringTokenizer;
    :goto_0
    invoke-virtual {v5}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-virtual {v5}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v4, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v6

    new-array v1, v6, [Ljava/lang/String;

    .local v1, "StrArray":[Ljava/lang/String;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v6

    if-ge v3, v6, :cond_1

    invoke-interface {v4, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    aput-object v6, v1, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_1
    return-object v1
.end method

.method public static getEccListMerged(Ljava/lang/String;)Ljava/lang/String;
    .locals 24
    .param p0, "eccList"    # Ljava/lang/String;

    .prologue
    const-string v21, "CTC"

    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v21

    if-eqz v21, :cond_4

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Landroid/telephony/TelephonyManager;->isMultiSimEnabled()Z

    move-result v21

    if-eqz v21, :cond_4

    invoke-static/range {p0 .. p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v21

    if-eqz v21, :cond_4

    const-string v21, "ril.curr.call.sub"

    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getDefaultPhoneId()I

    move-result v22

    invoke-static/range {v21 .. v22}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v14

    .local v14, "phoneId":I
    invoke-static {v14}, Landroid/telephony/SubscriptionManager;->getSubIdUsingPhoneId(I)J

    move-result-wide v18

    .local v18, "subId":J
    invoke-static/range {v18 .. v19}, Landroid/telephony/SubscriptionManager;->getSlotId(J)I

    move-result v16

    .local v16, "slotId":I
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v21

    move-object/from16 v0, v21

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Landroid/telephony/TelephonyManager;->getSimState(I)I

    move-result v15

    .local v15, "simState":I
    const/4 v9, 0x0

    .local v9, "eccListSubId":Ljava/lang/String;
    const/4 v6, 0x0

    .local v6, "changed":Z
    const/16 v21, 0x1

    move/from16 v0, v21

    if-ne v15, v0, :cond_2

    const/16 v21, 0x0

    const-string v22, "no_sim_ecclist"

    move-object/from16 v0, v21

    move-object/from16 v1, v22

    invoke-static {v0, v1, v14}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v9

    const/4 v6, 0x1

    :cond_0
    :goto_0
    const-string v21, "TelephonyAutoProfiling"

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "CTC : [getEccListMerged] simState="

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, " changed="

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, " ril.ecclist.autoprofile="

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, " [sim"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    move-wide/from16 v1, v18

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "]"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v6, :cond_1

    const-string v21, "ril.ecclist.autoprofile"

    move-object/from16 v0, v21

    invoke-static {v0, v9}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    const-string p0, ""

    .end local v6    # "changed":Z
    .end local v9    # "eccListSubId":Ljava/lang/String;
    .end local v14    # "phoneId":I
    .end local v15    # "simState":I
    .end local v16    # "slotId":I
    .end local v18    # "subId":J
    .end local p0    # "eccList":Ljava/lang/String;
    :goto_1
    return-object p0

    .restart local v6    # "changed":Z
    .restart local v9    # "eccListSubId":Ljava/lang/String;
    .restart local v14    # "phoneId":I
    .restart local v15    # "simState":I
    .restart local v16    # "slotId":I
    .restart local v18    # "subId":J
    .restart local p0    # "eccList":Ljava/lang/String;
    :cond_2
    const/16 v21, 0x5

    move/from16 v0, v21

    if-ne v15, v0, :cond_3

    const/16 v21, 0x0

    const-string v22, "ECC_list"

    move-object/from16 v0, v21

    move-object/from16 v1, v22

    invoke-static {v0, v1, v14}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v9

    const/4 v6, 0x1

    goto :goto_0

    :cond_3
    if-eqz v15, :cond_0

    const/16 v21, 0x0

    const-string v22, "sim_lock_ecclist"

    move-object/from16 v0, v21

    move-object/from16 v1, v22

    invoke-static {v0, v1, v14}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v9

    const/4 v6, 0x1

    goto :goto_0

    .end local v6    # "changed":Z
    .end local v9    # "eccListSubId":Ljava/lang/String;
    .end local v14    # "phoneId":I
    .end local v15    # "simState":I
    .end local v16    # "slotId":I
    .end local v18    # "subId":J
    :cond_4
    const-string v21, "ril.ecclist.autoprofile"

    invoke-static/range {v21 .. v21}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .local v8, "eccListAutoProfile":Ljava/lang/String;
    const-string v17, ""

    .local v17, "tempEcclist":Ljava/lang/String;
    const-string v21, ","

    move-object/from16 v0, v21

    invoke-virtual {v8, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .local v4, "arr$":[Ljava/lang/String;
    array-length v12, v4

    .local v12, "len$":I
    const/4 v10, 0x0

    .local v10, "i$":I
    move v11, v10

    .end local v4    # "arr$":[Ljava/lang/String;
    .end local v10    # "i$":I
    .end local v12    # "len$":I
    .local v11, "i$":I
    :goto_2
    if-ge v11, v12, :cond_8

    aget-object v20, v4, v11

    .local v20, "token":Ljava/lang/String;
    const-string v21, ","

    move-object/from16 v0, p0

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .local v5, "arr$":[Ljava/lang/String;
    array-length v13, v5

    .local v13, "len$":I
    const/4 v10, 0x0

    .end local v11    # "i$":I
    .restart local v10    # "i$":I
    :goto_3
    if-ge v10, v13, :cond_7

    aget-object v7, v5, v10

    .local v7, "ecc":Ljava/lang/String;
    move-object/from16 v0, v20

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-nez v21, :cond_6

    const-string v21, ","

    move-object/from16 v0, p0

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v21

    if-nez v21, :cond_5

    const-string v21, ","

    move-object/from16 v0, v17

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17

    :cond_5
    move-object/from16 v0, v17

    move-object/from16 v1, v20

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17

    :cond_6
    add-int/lit8 v10, v10, 0x1

    goto :goto_3

    .end local v7    # "ecc":Ljava/lang/String;
    :cond_7
    add-int/lit8 v10, v11, 0x1

    move v11, v10

    .end local v10    # "i$":I
    .restart local v11    # "i$":I
    goto :goto_2

    .end local v5    # "arr$":[Ljava/lang/String;
    .end local v13    # "len$":I
    .end local v20    # "token":Ljava/lang/String;
    :cond_8
    move-object/from16 v0, p0

    move-object/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    goto/16 :goto_1
.end method

.method public static getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    invoke-static {p0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->getInstance(Landroid/content/Context;)Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getHomeNetworks(Landroid/content/Context;)[Ljava/lang/String;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/4 v2, 0x0

    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getDefaultPhoneId()I

    move-result v0

    .local v0, "defaultPhoneId":I
    const-string v3, "HOME_NETWORK"

    invoke-static {v2, v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    .local v1, "homeNetworks":Ljava/lang/String;
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    :cond_0
    return-object v2
.end method

.method public static getHomeNetworks(Landroid/content/Context;I)[Ljava/lang/String;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "phoneId"    # I

    .prologue
    const/4 v1, 0x0

    const-string v2, "HOME_NETWORK"

    invoke-static {v1, v2, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .local v0, "homeNetworks":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    :cond_0
    return-object v1
.end method

.method public static getNotRoamingCountry(Landroid/content/Context;I)[Ljava/lang/String;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "phoneId"    # I

    .prologue
    const/4 v1, 0x0

    const-string v2, "not_roaming_country"

    invoke-static {v1, v2, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .local v0, "notRoamingCountry":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    :cond_0
    return-object v1
.end method

.method public static getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "phoneId"    # I

    .prologue
    invoke-static {p0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeProfile;->getInstance(Landroid/content/Context;)Lcom/android/internal/telephony/lgeautoprofiling/LgeProfile;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeProfile;->getValue(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getRVMS(Landroid/content/Context;)Ljava/lang/String;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getDefaultPhoneId()I

    move-result v0

    .local v0, "defaultPhoneId":I
    invoke-static {p0, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getRVMS(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static getRVMS(Landroid/content/Context;I)Ljava/lang/String;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "phoneId"    # I

    .prologue
    const-string v0, "RVMS"

    invoke-static {p0, v0, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getRoamingNetworks(Landroid/content/Context;I)[Ljava/lang/String;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "phoneId"    # I

    .prologue
    const/4 v1, 0x0

    const-string v2, "roaming_network"

    invoke-static {v1, v2, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .local v0, "roamingNetworks":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    :cond_0
    return-object v1
.end method

.method public static getVMS(Landroid/content/Context;)Ljava/lang/String;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getDefaultPhoneId()I

    move-result v0

    .local v0, "defaultPhoneId":I
    invoke-static {p0, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getVMS(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static getVMS(Landroid/content/Context;I)Ljava/lang/String;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "phoneId"    # I

    .prologue
    const-string v0, "VMS"

    invoke-static {p0, v0, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static init(Landroid/content/Context;I)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "phoneType"    # I

    .prologue
    const-string v1, "TelephonyAutoProfiling"

    const-string v2, "[init] ******** Telephony Auto Profiling *******"

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    if-nez p0, :cond_1

    const-string v1, "TelephonyAutoProfiling"

    const-string v2, "[init] context is null, return"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {p0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->getInstance(Landroid/content/Context;)Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeFeature;->loadFeature()V

    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getDefaultPhoneId()I

    move-result v0

    .local v0, "defaultPhoneId":I
    invoke-static {p0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeProfile;->getInstance(Landroid/content/Context;)Lcom/android/internal/telephony/lgeautoprofiling/LgeProfile;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeProfile;->loadProfile(I)V

    const/4 v1, 0x2

    if-ne p1, v1, :cond_0

    const-string v1, "KR"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "ril.ecclist.autoprofile"

    const-string v2, "ECC_list"

    invoke-static {p0, v2, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static isCountry(Ljava/lang/String;)Z
    .locals 1
    .param p0, "country"    # Ljava/lang/String;

    .prologue
    sget-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->COUNTRY:Ljava/lang/String;

    invoke-static {p0, v0}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method

.method public static isLogBlocked(I)Z
    .locals 3
    .param p0, "level"    # I

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x1

    sget-boolean v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogFeatureLoaded:Z

    if-nez v2, :cond_0

    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->privateLogFeatureLoad()V

    sput-boolean v1, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogFeatureLoaded:Z

    :cond_0
    sget-boolean v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsEnabled:Z

    if-eqz v2, :cond_2

    :cond_1
    :goto_0
    return v0

    :cond_2
    sparse-switch p0, :sswitch_data_0

    goto :goto_0

    :sswitch_0
    sget v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogUssd:I

    if-eqz v2, :cond_1

    move v0, v1

    goto :goto_0

    :sswitch_1
    sget v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogDialstring:I

    if-eqz v2, :cond_1

    move v0, v1

    goto :goto_0

    :sswitch_2
    sget v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogIdentity:I

    if-eqz v2, :cond_1

    move v0, v1

    goto :goto_0

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x10 -> :sswitch_1
        0x100 -> :sswitch_2
    .end sparse-switch
.end method

.method public static isOperator(Ljava/lang/String;)Z
    .locals 1
    .param p0, "operator"    # Ljava/lang/String;

    .prologue
    sget-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->OPERATOR:Ljava/lang/String;

    invoke-static {p0, v0}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method

.method public static isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p0, "Country"    # Ljava/lang/String;
    .param p1, "Operator"    # Ljava/lang/String;

    .prologue
    sget-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->COUNTRY:Ljava/lang/String;

    invoke-static {p0, v0}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->OPERATOR:Ljava/lang/String;

    invoke-static {p1, v0}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isSimOperator(Ljava/lang/String;)Z
    .locals 3
    .param p0, "operator"    # Ljava/lang/String;

    .prologue
    sget-boolean v1, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsCardOperatorCached:Z

    if-nez v1, :cond_1

    const-string v1, "ril.card_operator"

    const-string v2, ""

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "cardOperator":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {p0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    .end local v0    # "cardOperator":Ljava/lang/String;
    :goto_0
    return v1

    .restart local v0    # "cardOperator":Ljava/lang/String;
    :cond_0
    sput-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sCardOperator:Ljava/lang/String;

    const/4 v1, 0x1

    sput-boolean v1, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsCardOperatorCached:Z

    .end local v0    # "cardOperator":Ljava/lang/String;
    :cond_1
    sget-object v1, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sCardOperator:Ljava/lang/String;

    invoke-virtual {v1, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    goto :goto_0
.end method

.method public static isSimOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 4
    .param p0, "country"    # Ljava/lang/String;
    .param p1, "operator"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x1

    sget-boolean v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsCardOperatorCached:Z

    if-nez v2, :cond_2

    const-string v2, "ril.card_operator"

    const-string v3, ""

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "cardOperator":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-static {p0, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    .end local v0    # "cardOperator":Ljava/lang/String;
    :cond_0
    :goto_0
    return v1

    .restart local v0    # "cardOperator":Ljava/lang/String;
    :cond_1
    sput-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sCardOperator:Ljava/lang/String;

    sput-boolean v1, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsCardOperatorCached:Z

    .end local v0    # "cardOperator":Ljava/lang/String;
    :cond_2
    sget-object v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->COUNTRY:Ljava/lang/String;

    invoke-static {p0, v2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_3

    sget-object v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sCardOperator:Ljava/lang/String;

    invoke-virtual {v2, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    :cond_3
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .local v0, "result":Z
    invoke-static {p0, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "true"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method private static privateLogFeatureLoad()V
    .locals 5

    .prologue
    const/4 v2, 0x0

    const-string v3, "block_private_log_level"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "feature":Ljava/lang/String;
    if-eqz v0, :cond_0

    const-string v2, "TelephonyAutoProfiling"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "sIsEnabled : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-boolean v4, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsEnabled:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    .local v1, "loglevel":I
    sget-boolean v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsEnabled:Z

    if-nez v2, :cond_0

    :try_start_0
    invoke-static {v0}, Ljava/lang/Integer;->decode(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    and-int/lit8 v2, v1, 0x1

    sput v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogUssd:I

    and-int/lit8 v2, v1, 0x10

    sput v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogDialstring:I

    and-int/lit16 v2, v1, 0x100

    sput v2, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sLogIdentity:I

    .end local v1    # "loglevel":I
    :cond_0
    return-void

    .restart local v1    # "loglevel":I
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public static privateLogHandler(Ljava/lang/String;I)Ljava/lang/String;
    .locals 1
    .param p0, "str"    # Ljava/lang/String;
    .param p1, "level"    # I

    .prologue
    sget-boolean v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->sIsEnabled:Z

    if-eqz v0, :cond_1

    .end local p0    # "str":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object p0

    .restart local p0    # "str":Ljava/lang/String;
    :cond_1
    invoke-static {p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isLogBlocked(I)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p0, ""

    goto :goto_0
.end method

.method public static supportSRVCC(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .local v0, "result":Z
    invoke-static {p0, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "true"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "ro.lge.supportvolte"

    invoke-static {v2, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    move v0, v1

    goto :goto_0
.end method

.method public static syncClearCodes(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    const-string v1, "android.intent.action.SIM_STATE_CHANGED"

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "ss"

    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "simState":Ljava/lang/String;
    const-string v1, "LOADED"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->updateClearCodes()V

    .end local v0    # "simState":Ljava/lang/String;
    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v1, "android.intent.action.ACTION_DEFAULT_SUBSCRIPTION_CHANGED"

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->updateClearCodes()V

    goto :goto_0
.end method

.method private static updateClearCodes()V
    .locals 4

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getDefaultPhoneId()I

    move-result v1

    .local v1, "defaultPhoneId":I
    const/4 v2, 0x0

    const-string v3, "custom_clear_codes"

    invoke-static {v2, v3, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getProfileInfo(Landroid/content/Context;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .local v0, "clearCodes":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "gsm.call.clear_codes"

    invoke-static {v2, v0}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    const-string v2, "gsm.call.clear_codes"

    const-string v3, ""

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static updateProfile(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    invoke-static {p0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeProfile;->getInstance(Landroid/content/Context;)Lcom/android/internal/telephony/lgeautoprofiling/LgeProfile;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeProfile;->updateProfile(Landroid/content/Intent;)V

    invoke-static {p0, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->syncClearCodes(Landroid/content/Context;Landroid/content/Intent;)V

    return-void
.end method


# virtual methods
.method public getTargetCountry()Ljava/lang/String;
    .locals 1

    .prologue
    sget-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->COUNTRY:Ljava/lang/String;

    return-object v0
.end method

.method public getTargetOperator()Ljava/lang/String;
    .locals 1

    .prologue
    sget-object v0, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->OPERATOR:Ljava/lang/String;

    return-object v0
.end method
