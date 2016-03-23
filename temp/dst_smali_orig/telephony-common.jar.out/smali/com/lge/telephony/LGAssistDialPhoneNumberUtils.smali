.class public Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;
.super Ljava/lang/Object;
.source "LGAssistDialPhoneNumberUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;,
        Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;,
        Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;
    }
.end annotation


# static fields
.field static final DBG:Z

.field static final LOG_TAG:Ljava/lang/String; = "LGAssistDialPhoneNumberUtils"

.field static final MAX_SEND_DIAL_LENGTH:I = 0x20

.field private static final NANP_LENGTH:I = 0xa

.field private static afterNumber:Ljava/lang/String;


# instance fields
.field private areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

.field private countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

.field private mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/16 v0, 0x10

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isLogBlocked(I)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    sput-boolean v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    return-void

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    iput-object v0, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    iput-object v0, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    invoke-direct {p0}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->initAreaCodeInfo()V

    invoke-direct {p0}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->initSIDRangeInfo()V

    return-void
.end method

.method private callAssistedDialSetIntNetwork(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Ljava/lang/String;
    .locals 10
    .param p1, "pNumber"    # Ljava/lang/String;
    .param p2, "currentCountry"    # Lcom/lge/telephony/LGReferenceCountry;
    .param p3, "context"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x0

    .local v0, "bNumberPos":I
    const/4 v6, 0x0

    .local v6, "retVal":Z
    const/4 v5, 0x0

    .local v5, "otaNdd":Ljava/lang/String;
    invoke-static {p1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getDialLengthBeforePause(Ljava/lang/String;)I

    move-result v0

    sput-object p1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    sget-boolean v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v7, :cond_0

    const-string v7, "LGAssistDialPhoneNumberUtils"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "callAssistedDialSetIntNetwork start : pNumber = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ", currentCountry = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    const/4 v7, 0x0

    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v7

    const/16 v8, 0x2a

    if-eq v7, v8, :cond_1

    const/4 v7, 0x0

    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v7

    const/16 v8, 0x23

    if-ne v7, v8, :cond_2

    :cond_1
    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    :goto_0
    return-object v7

    :cond_2
    const/16 v7, 0x20

    if-gt v0, v7, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v7

    const/16 v8, 0x20

    if-le v7, v8, :cond_4

    :cond_3
    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    goto :goto_0

    :cond_4
    const/16 v7, 0xa

    if-gt v0, v7, :cond_11

    const/4 v1, 0x0

    .local v1, "dialfromContact":I
    :try_start_0
    invoke-virtual {p3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    const-string v8, "assist_dial_from_contact"

    invoke-static {v7, v8}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_1
    invoke-virtual {p0, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getIsAssistedDialCheck(Landroid/content/Context;)I

    move-result v7

    const/4 v8, 0x1

    if-ne v7, v8, :cond_10

    const/4 v7, 0x1

    if-ne v1, v7, :cond_10

    invoke-direct {p0, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getRefCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v3

    .local v3, "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    if-eqz v3, :cond_e

    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getIndex()I

    move-result v7

    if-nez v7, :cond_e

    sget-boolean v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v7, :cond_5

    const-string v7, "LGAssistDialPhoneNumberUtils"

    const-string v8, "****** 11"

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_5
    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getNumLength()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v8

    if-ne v7, v8, :cond_9

    sget-boolean v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v7, :cond_6

    const-string v7, "LGAssistDialPhoneNumberUtils"

    const-string v8, "****** 12"

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_6
    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {p0, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getAreacodeInfoforContactNumber(Ljava/lang/String;)Z

    move-result v7

    const/4 v8, 0x1

    if-ne v7, v8, :cond_9

    sget-boolean v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v7, :cond_7

    const-string v7, "LGAssistDialPhoneNumberUtils"

    const-string v8, "****** 13"

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_7
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    sget-object v8, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    sput-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-static {p1, v7}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_8

    invoke-virtual {p3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    const-string v8, "assist_dial_new_number_check"

    const/4 v9, 0x1

    invoke-static {v7, v8, v9}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    :cond_8
    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    goto/16 :goto_0

    .end local v3    # "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    :catch_0
    move-exception v2

    .local v2, "e":Landroid/provider/Settings$SettingNotFoundException;
    invoke-virtual {v2}, Landroid/provider/Settings$SettingNotFoundException;->printStackTrace()V

    goto/16 :goto_1

    .end local v2    # "e":Landroid/provider/Settings$SettingNotFoundException;
    .restart local v3    # "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    :cond_9
    sget-boolean v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v7, :cond_a

    const-string v7, "LGAssistDialPhoneNumberUtils"

    const-string v8, "****** 14"

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_a
    const/4 v4, 0x0

    .local v4, "mReferAreaCodeLen":I
    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getAreaCode()Ljava/lang/String;

    move-result-object v7

    if-eqz v7, :cond_b

    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getAreaCode()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v4

    :cond_b
    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getNumLength()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v8

    sub-int/2addr v8, v4

    if-ne v7, v8, :cond_e

    sget-boolean v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v7, :cond_c

    const-string v7, "LGAssistDialPhoneNumberUtils"

    const-string v8, "****** 15"

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_c
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getAreaCode()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    sget-object v8, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    sput-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-static {p1, v7}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_d

    invoke-virtual {p3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    const-string v8, "assist_dial_new_number_check"

    const/4 v9, 0x1

    invoke-static {v7, v8, v9}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    :cond_d
    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    goto/16 :goto_0

    .end local v4    # "mReferAreaCodeLen":I
    :cond_e
    sget-boolean v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v7, :cond_f

    const-string v7, "LGAssistDialPhoneNumberUtils"

    const-string v8, "****** 16"

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "dialfromContact":I
    .end local v3    # "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    :cond_f
    :goto_2
    if-nez v6, :cond_18

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getNddPrefix()Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x0

    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v7

    const/16 v8, 0x2b

    if-ne v7, v8, :cond_15

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    goto/16 :goto_0

    .restart local v1    # "dialfromContact":I
    :cond_10
    const/4 v6, 0x1

    goto :goto_2

    .end local v1    # "dialfromContact":I
    :cond_11
    const/16 v7, 0xb

    if-lt v0, v7, :cond_f

    const/4 v7, 0x0

    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v7

    const/16 v8, 0x2b

    if-ne v7, v8, :cond_13

    const/4 v7, 0x1

    invoke-virtual {p1, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    invoke-direct {p0, v7, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->callAssistedLocal_CountryCode(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;)Z

    move-result v7

    if-nez v7, :cond_12

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const/4 v8, 0x1

    invoke-virtual {p1, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    sput-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    :cond_12
    const/4 v6, 0x1

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    goto/16 :goto_0

    :cond_13
    if-nez v6, :cond_14

    invoke-direct {p0, p1, p2, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->callAssistedDialing_Int_Numbers(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Z

    move-result v6

    if-nez v6, :cond_14

    invoke-virtual {p0, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getIsAssistedDialCheck(Landroid/content/Context;)I

    move-result v7

    const/4 v8, 0x1

    if-ne v7, v8, :cond_14

    invoke-direct {p0, p1, p2, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->isNeeded_OTAIddPrefix(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Z

    move-result v7

    const/4 v8, 0x1

    if-ne v7, v8, :cond_14

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    sput-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    const/4 v6, 0x1

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-static {p1, v7}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_14

    invoke-virtual {p3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    const-string v8, "assist_dial_new_number_check"

    const/4 v9, 0x1

    invoke-static {v7, v8, v9}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    :cond_14
    sget-boolean v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v7, :cond_f

    const-string v7, "LGAssistDialPhoneNumberUtils"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, " afterNumber : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    sget-object v9, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_2

    :cond_15
    if-eqz v5, :cond_16

    const/4 v7, 0x0

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v8

    invoke-virtual {p1, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v5}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v7

    const/4 v8, 0x1

    if-ne v7, v8, :cond_16

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    goto/16 :goto_0

    :cond_16
    invoke-virtual {p0, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getIsAssistedDialCheck(Landroid/content/Context;)I

    move-result v7

    const/4 v8, 0x1

    if-ne v7, v8, :cond_19

    invoke-direct {p0, p1, v0, p2, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->callAssistedDial_NumLength(Ljava/lang/String;ILcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Z

    move-result v6

    if-eqz v6, :cond_19

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-static {p1, v7}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_17

    invoke-virtual {p3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    const-string v8, "assist_dial_new_number_check"

    const/4 v9, 0x1

    invoke-static {v7, v8, v9}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    :cond_17
    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    goto/16 :goto_0

    :cond_18
    sget-boolean v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v7, :cond_19

    const-string v7, "LGAssistDialPhoneNumberUtils"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, " afterNumber : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    sget-object v9, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_19
    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    goto/16 :goto_0
.end method

.method private callAssistedDialSetVZWNetwork(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Ljava/lang/String;
    .locals 10
    .param p1, "pNumber"    # Ljava/lang/String;
    .param p2, "currentCountry"    # Lcom/lge/telephony/LGReferenceCountry;
    .param p3, "context"    # Landroid/content/Context;

    .prologue
    const/16 v7, 0x20

    const/4 v9, 0x0

    const/4 v8, 0x1

    const/4 v3, 0x0

    .local v3, "retVal":Z
    const/4 v0, 0x0

    .local v0, "bNumberPos":I
    invoke-static {p1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getDialLengthBeforePause(Ljava/lang/String;)I

    move-result v0

    sput-object p1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v5

    const/16 v6, 0x2a

    if-eq v5, v6, :cond_0

    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v5

    const/16 v6, 0x23

    if-ne v5, v6, :cond_1

    .end local p1    # "pNumber":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object p1

    .restart local p1    # "pNumber":Ljava/lang/String;
    :cond_1
    if-gt v0, v7, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-gt v5, v7, :cond_0

    const/16 v5, 0xb

    if-lt v0, v5, :cond_f

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getNddPrefix()Ljava/lang/String;

    move-result-object v2

    .local v2, "otaNdd":Ljava/lang/String;
    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v1

    .local v1, "otaCC":Ljava/lang/String;
    invoke-virtual {p1, v9}, Ljava/lang/String;->charAt(I)C

    move-result v5

    const/16 v6, 0x2b

    if-ne v5, v6, :cond_a

    if-eqz v2, :cond_4

    sget-boolean v5, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v5, :cond_2

    const-string v5, "LGAssistDialPhoneNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "ota_ndd : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    invoke-virtual {p1, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    .local v4, "temp":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v4, v9, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_9

    invoke-virtual {p1, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getAreacodeInfo(Ljava/lang/String;)Z

    move-result v5

    if-ne v5, v8, :cond_8

    invoke-virtual {p1, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    sput-object v5, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    :cond_3
    :goto_1
    const/4 v3, 0x1

    .end local v4    # "temp":Ljava/lang/String;
    :cond_4
    :goto_2
    if-nez v3, :cond_5

    if-eqz v1, :cond_5

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {p1, v9, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v5

    if-ne v5, v8, :cond_d

    sput-object p1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    const/4 v3, 0x1

    :cond_5
    :goto_3
    if-nez v3, :cond_6

    invoke-direct {p0, p1, p2, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->isNeeded_OTAIddPrefix(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Z

    move-result v5

    if-ne v5, v8, :cond_e

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    sput-object v5, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    const/4 v3, 0x1

    sget-boolean v5, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v5, :cond_6

    const-string v5, "LGAssistDialPhoneNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "afterNumber : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_6
    :goto_4
    sget-boolean v5, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v5, :cond_7

    const-string v5, "LGAssistDialPhoneNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "afterNumber : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "otaCC":Ljava/lang/String;
    .end local v2    # "otaNdd":Ljava/lang/String;
    :cond_7
    :goto_5
    sget-object p1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    goto/16 :goto_0

    .restart local v1    # "otaCC":Ljava/lang/String;
    .restart local v2    # "otaNdd":Ljava/lang/String;
    .restart local v4    # "temp":Ljava/lang/String;
    :cond_8
    invoke-virtual {p1, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    sput-object v5, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    sget-boolean v5, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v5, :cond_3

    const-string v5, "nsalty"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Not in the area code range but delete + :"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    :cond_9
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p1, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    sput-object v5, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    sget-boolean v5, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v5, :cond_3

    const-string v5, "LGAssistDialPhoneNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "afterNumber : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .end local v4    # "temp":Ljava/lang/String;
    :cond_a
    if-eqz v2, :cond_4

    sget-boolean v5, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v5, :cond_b

    const-string v5, "LGAssistDialPhoneNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "pNumber.substring(0, ota_ndd.length()) : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {p1, v9, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v5, "LGAssistDialPhoneNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "ota_ndd : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_b
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {p1, v9, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v5

    if-ne v5, v8, :cond_c

    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getAreacodeInfo(Ljava/lang/String;)Z

    move-result v5

    if-ne v5, v8, :cond_c

    sput-object p1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    const/4 v3, 0x1

    goto/16 :goto_2

    :cond_c
    const/4 v3, 0x0

    goto/16 :goto_2

    :cond_d
    const/4 v3, 0x0

    goto/16 :goto_3

    :cond_e
    invoke-virtual {p0, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getIsAssistedDialCheck(Landroid/content/Context;)I

    move-result v5

    if-ne v5, v8, :cond_6

    invoke-direct {p0, p1, p2, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->callAssistedNonUS_IDDPrefix(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Z

    move-result v3

    if-eqz v3, :cond_6

    invoke-virtual {p3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    const-string v6, "assist_dial_new_number_check"

    invoke-static {v5, v6, v8}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto/16 :goto_4

    .end local v1    # "otaCC":Ljava/lang/String;
    .end local v2    # "otaNdd":Ljava/lang/String;
    :cond_f
    sget-boolean v5, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v5, :cond_7

    const-string v5, "LGAssistDialPhoneNumberUtils"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "afterNumber : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_5
.end method

.method private callAssistedDial_NumLength(Ljava/lang/String;ILcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Z
    .locals 18
    .param p1, "pNumber"    # Ljava/lang/String;
    .param p2, "bNumberPos"    # I
    .param p3, "currentCountry"    # Lcom/lge/telephony/LGReferenceCountry;
    .param p4, "context"    # Landroid/content/Context;

    .prologue
    const/4 v14, 0x0

    .local v14, "retVal":Z
    const/4 v11, 0x0

    .local v11, "refNdd":Ljava/lang/String;
    const/4 v7, 0x0

    .local v7, "otaNdd":Ljava/lang/String;
    const/4 v6, 0x0

    .local v6, "otaIDD":Ljava/lang/String;
    const/4 v10, 0x0

    .local v10, "refCC":Ljava/lang/String;
    const/4 v5, 0x0

    .local v5, "otaCC":Ljava/lang/String;
    const/4 v2, 0x0

    .local v2, "areaCode":Ljava/lang/String;
    const/4 v9, 0x0

    .local v9, "prefixNumber":Ljava/lang/String;
    const/4 v12, 0x0

    .local v12, "refNddLen":I
    const/4 v8, 0x0

    .local v8, "otaNddLen":I
    const/4 v3, 0x0

    .local v3, "areaCodeLen":I
    const/4 v13, 0x0

    .local v13, "refNumLen":I
    move-object/from16 v0, p0

    move-object/from16 v1, p4

    invoke-direct {v0, v1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getRefCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v4

    .local v4, "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    if-nez v4, :cond_0

    move v15, v14

    .end local v14    # "retVal":Z
    .local v15, "retVal":I
    :goto_0
    return v15

    .end local v15    # "retVal":I
    .restart local v14    # "retVal":Z
    :cond_0
    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getNddPrefix()Ljava/lang/String;

    move-result-object v11

    if-eqz v11, :cond_1

    invoke-virtual {v11}, Ljava/lang/String;->length()I

    move-result v12

    :cond_1
    invoke-virtual/range {p3 .. p3}, Lcom/lge/telephony/LGReferenceCountry;->getNddPrefix()Ljava/lang/String;

    move-result-object v7

    invoke-virtual/range {p3 .. p3}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v5

    if-eqz v7, :cond_2

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v8

    move-object v9, v7

    :cond_2
    invoke-virtual/range {p3 .. p3}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getNumLength()Ljava/lang/String;

    move-result-object v16

    invoke-static/range {v16 .. v16}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v13

    if-eqz v12, :cond_5

    const/16 v16, 0x0

    :try_start_0
    move-object/from16 v0, p1

    move/from16 v1, v16

    invoke-virtual {v0, v1, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-static {v0, v11}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v16

    const/16 v17, 0x1

    move/from16 v0, v16

    move/from16 v1, v17

    if-ne v0, v1, :cond_5

    add-int v16, v13, v12

    move/from16 v0, p2

    move/from16 v1, v16

    if-ne v0, v1, :cond_5

    invoke-static {v10, v5}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v16

    const/16 v17, 0x1

    move/from16 v0, v16

    move/from16 v1, v17

    if-ne v0, v1, :cond_4

    const/4 v14, 0x1

    :cond_3
    :goto_1
    move v15, v14

    .restart local v15    # "retVal":I
    goto :goto_0

    .end local v15    # "retVal":I
    :cond_4
    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v16

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v16

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, p1

    invoke-virtual {v0, v12}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v17

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    sput-object v16, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    const/4 v14, 0x1

    goto :goto_1

    :cond_5
    if-eqz v8, :cond_7

    const/16 v16, 0x0

    move-object/from16 v0, p1

    move/from16 v1, v16

    invoke-virtual {v0, v1, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-static {v0, v7}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v16

    const/16 v17, 0x1

    move/from16 v0, v16

    move/from16 v1, v17

    if-ne v0, v1, :cond_7

    add-int v16, v13, v12

    move/from16 v0, p2

    move/from16 v1, v16

    if-ne v0, v1, :cond_7

    invoke-static {v10, v5}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v16

    const/16 v17, 0x1

    move/from16 v0, v16

    move/from16 v1, v17

    if-ne v0, v1, :cond_6

    const/4 v14, 0x1

    goto :goto_1

    :cond_6
    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v16

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v16

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, p1

    invoke-virtual {v0, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v17

    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    sput-object v16, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    const/4 v14, 0x1

    goto/16 :goto_1

    :cond_7
    move/from16 v0, p2

    if-gt v0, v13, :cond_a

    move/from16 v0, p2

    if-ne v0, v13, :cond_8

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v16

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v16

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    sput-object v16, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    const/4 v14, 0x1

    goto/16 :goto_1

    :cond_8
    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getAreaCode()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_9

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    :cond_9
    sub-int v16, v13, v3

    move/from16 v0, p2

    move/from16 v1, v16

    if-ne v0, v1, :cond_3

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v16

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v16

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    new-instance v16, Ljava/lang/StringBuilder;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v16

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    move-object/from16 v0, v16

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v16

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    sput-object v16, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v14, 0x1

    goto/16 :goto_1

    :cond_a
    const/4 v14, 0x0

    goto/16 :goto_1

    :catch_0
    move-exception v16

    goto/16 :goto_1
.end method

.method private callAssistedDialing_Int_Numbers(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Z
    .locals 11
    .param p1, "pNumber"    # Ljava/lang/String;
    .param p2, "currentCountry"    # Lcom/lge/telephony/LGReferenceCountry;
    .param p3, "context"    # Landroid/content/Context;

    .prologue
    const/4 v10, 0x1

    const/4 v5, 0x0

    .local v5, "refIdd":Ljava/lang/String;
    const/4 v4, 0x0

    .local v4, "otaIdd":Ljava/lang/String;
    const/4 v2, 0x0

    .local v2, "localCC":Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "iddPrefixLen":I
    const/4 v6, 0x0

    .local v6, "retVal":Z
    const/4 v1, 0x0

    .local v1, "isAssistDialing":Z
    invoke-direct {p0, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getRefCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v3

    .local v3, "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v5

    :cond_0
    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_1

    const/4 v8, 0x0

    :try_start_0
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {p1, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v8

    if-ne v8, v10, :cond_1

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v6, 0x1

    :cond_1
    if-nez v6, :cond_2

    if-eqz v5, :cond_2

    const/4 v8, 0x0

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {p1, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v5}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v8

    if-ne v8, v10, :cond_2

    invoke-virtual {p0, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getIsAssistedDialCheck(Landroid/content/Context;)I

    move-result v8

    if-ne v8, v10, :cond_2

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v6, 0x1

    const/4 v1, 0x1

    :cond_2
    if-eqz v6, :cond_4

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_4

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    .local v7, "temp":Ljava/lang/String;
    const/4 v8, 0x0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {v7, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v8

    if-ne v8, v10, :cond_5

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getNddPrefix()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v9

    add-int/2addr v9, v0

    invoke-virtual {p1, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    sput-object v8, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    sget-boolean v8, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v8, :cond_3

    const-string v8, "LGAssistDialPhoneNumberUtils"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "callAssistedDialing_Int_Numbers() ==>  currentCountry.getNddPrefix() : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getNddPrefix()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v8, "LGAssistDialPhoneNumberUtils"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "callAssistedDialing_Int_Numbers() ==>  pNumber.substring(idd_prefix_len + local_CC.length()) : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v10

    add-int/2addr v10, v0

    invoke-virtual {p1, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v8, "LGAssistDialPhoneNumberUtils"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "callAssistedDialing_Int_Numbers() ==>  afterNumber : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    sget-object v10, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_3
    :goto_0
    if-eqz v1, :cond_4

    sget-object v8, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-static {p1, v8}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_4

    invoke-virtual {p3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v8

    const-string v9, "assist_dial_new_number_check"

    const/4 v10, 0x1

    invoke-static {v8, v9, v10}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .end local v7    # "temp":Ljava/lang/String;
    :cond_4
    :goto_1
    return v6

    .restart local v7    # "temp":Ljava/lang/String;
    :cond_5
    if-eqz v1, :cond_3

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    sput-object v8, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v7    # "temp":Ljava/lang/String;
    :catch_0
    move-exception v8

    goto :goto_1
.end method

.method private callAssistedLocal_CountryCode(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;)Z
    .locals 5
    .param p1, "pNumber"    # Ljava/lang/String;
    .param p2, "currentCountry"    # Lcom/lge/telephony/LGReferenceCountry;

    .prologue
    const/4 v1, 0x0

    .local v1, "retVal":Z
    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v0

    .local v0, "retOtaToken":Ljava/lang/String;
    if-eqz v0, :cond_1

    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {p1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_1

    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_0

    const-string v2, "LGAssistDialPhoneNumberUtils"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "callAssistedLocal_CountryCode() ==> afterNumber : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getNddPrefix()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {p1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x1

    :cond_1
    :goto_0
    return v1

    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method private callAssistedNonUS_IDDPrefix(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Z
    .locals 12
    .param p1, "pNumber"    # Ljava/lang/String;
    .param p2, "currentCountry"    # Lcom/lge/telephony/LGReferenceCountry;
    .param p3, "context"    # Landroid/content/Context;

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    const/4 v3, 0x0

    .local v3, "otaIdd":Ljava/lang/String;
    const/4 v6, 0x0

    .local v6, "refIdd":Ljava/lang/String;
    const/4 v5, 0x0

    .local v5, "refCountryIdd":Ljava/lang/String;
    const/4 v4, 0x0

    .local v4, "refCc":Ljava/lang/String;
    invoke-direct {p0, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getRefCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v2

    .local v2, "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v5

    :cond_0
    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v3

    sget-boolean v9, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v9, :cond_1

    const-string v9, "LGAssistDialPhoneNumberUtils"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "callAssistedNonUS_IDDPrefix() ==> pNumber.substring(0, ota_idd.length()-1) : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v11

    invoke-virtual {p1, v7, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v9, "LGAssistDialPhoneNumberUtils"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "callAssistedNonUS_IDDPrefix() ==> ota_idd : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    if-nez v3, :cond_3

    :cond_2
    :goto_0
    return v7

    :cond_3
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {p1, v7, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v9

    if-eq v9, v8, :cond_2

    if-eqz v5, :cond_6

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v9

    if-lez v9, :cond_6

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {p1, v7, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v5}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v9

    if-ne v9, v8, :cond_6

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    iget-object v9, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    array-length v9, v9

    if-ge v0, v9, :cond_6

    iget-object v9, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    aget-object v9, v9, v0

    invoke-virtual {v9}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_5

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v9

    if-lez v9, :cond_5

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v11

    add-int/2addr v10, v11

    invoke-virtual {p1, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v9

    if-ne v9, v8, :cond_5

    sget-boolean v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v7, :cond_4

    const-string v7, "LGAssistDialPhoneNumberUtils"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "callAssistedNonUS_IDDPrefix() ==> refCountryIdd : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", refCc : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v7, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_4
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {p1, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    sput-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    move v7, v8

    goto/16 :goto_0

    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .end local v0    # "i":I
    :cond_6
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_2
    iget-object v9, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    array-length v9, v9

    if-ge v0, v9, :cond_2

    iget-object v9, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    aget-object v9, v9, v0

    invoke-virtual {v9}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_9

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v9

    if-lez v9, :cond_9

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {p1, v7, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v6}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v9

    if-ne v9, v8, :cond_9

    const/4 v1, 0x0

    .local v1, "j":I
    :goto_3
    iget-object v9, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    array-length v9, v9

    if-ge v1, v9, :cond_9

    iget-object v9, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    aget-object v9, v9, v1

    invoke-virtual {v9}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_8

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v9

    if-lez v9, :cond_8

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v11

    add-int/2addr v10, v11

    invoke-virtual {p1, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v9

    if-ne v9, v8, :cond_8

    sget-boolean v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v7, :cond_7

    const-string v7, "LGAssistDialPhoneNumberUtils"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "callAssistedNonUS_IDDPrefix() ==> refIdd : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", refCc : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", i="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", j="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v7, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_7
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {p1, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    sput-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    move v7, v8

    goto/16 :goto_0

    :cond_8
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_3

    .end local v1    # "j":I
    :cond_9
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_2
.end method

.method private static getDialLengthBeforePause(Ljava/lang/String;)I
    .locals 4
    .param p0, "pNumber"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .local v0, "count":I
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-ge v0, v1, :cond_2

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x2c

    if-eq v1, v2, :cond_0

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x3b

    if-ne v1, v2, :cond_1

    :cond_0
    :goto_1
    return v0

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    sget-boolean v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v1, :cond_0

    const-string v1, "LGAssistDialPhoneNumberUtils"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getDialLengthBeforePause(String pNumber) ==> count : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method private getMccForAssistedDial(I)Ljava/lang/String;
    .locals 6
    .param p1, "mcc"    # I

    .prologue
    const/4 v3, 0x0

    .local v3, "temp":I
    const/16 v4, 0xa

    new-array v1, v4, [I

    fill-array-data v1, :array_0

    .local v1, "conv_arr":[I
    const/16 v4, 0x3ff

    if-ne p1, v4, :cond_1

    sget-boolean v4, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v4, :cond_0

    const-string v4, "LGAssistDialPhoneNumberUtils"

    const-string v5, " UnKnown MCC"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v4

    :goto_0
    return-object v4

    :cond_1
    add-int/lit8 v3, p1, 0x6f

    move p1, v3

    move v2, p1

    .local v2, "ret_mcc":I
    rem-int/lit8 v4, p1, 0xa

    aget v0, v1, v4

    .local v0, "check_digit":I
    if-nez v0, :cond_2

    add-int/lit8 v2, v3, -0xa

    move v3, v2

    :cond_2
    div-int/lit8 p1, p1, 0xa

    rem-int/lit8 v4, p1, 0xa

    aget v0, v1, v4

    if-nez v0, :cond_3

    add-int/lit8 v2, v3, -0x64

    move v3, v2

    :cond_3
    div-int/lit8 p1, p1, 0xa

    rem-int/lit8 v4, p1, 0xa

    aget v0, v1, v4

    if-nez v0, :cond_4

    add-int/lit16 v2, v3, -0x3e8

    :cond_4
    const/16 v4, 0x3e7

    if-le v2, v4, :cond_5

    const/4 v2, 0x0

    :cond_5
    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :array_0
    .array-data 4
        0x0
        0x1
        0x2
        0x3
        0x4
        0x5
        0x6
        0x7
        0x8
        0x9
    .end array-data
.end method

.method private getRefCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;
    .locals 13
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v4, 0x0

    const/4 v10, 0x0

    .local v10, "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "assist_dial_reference_country"

    invoke-static {v1, v2}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .local v12, "refCountryIndex":Ljava/lang/String;
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .local v0, "mContentResolver":Landroid/content/ContentResolver;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "countryindex = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .local v3, "where":Ljava/lang/String;
    sget-boolean v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v1, :cond_0

    const-string v1, "LGAssistDialPhoneNumberUtils"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "WHERE : "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    sget-object v1, Lcom/lge/telephony/SettingsForAssistDial$AssistDial;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lcom/lge/constants/SettingsConstants$AssistDial;->PROJECTION:[Ljava/lang/String;

    move-object v5, v4

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v8

    .local v8, "cursor":Landroid/database/Cursor;
    if-nez v8, :cond_1

    const-string v1, "LGAssistDialPhoneNumberUtils"

    const-string v2, "cursor is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    move-object v11, v10

    .end local v10    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    .local v11, "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    :goto_0
    return-object v11

    .end local v11    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v10    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    :cond_1
    :try_start_0
    invoke-interface {v8}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v1

    if-eqz v1, :cond_5

    new-instance v11, Lcom/lge/telephony/LGReferenceCountry;

    invoke-direct {v11}, Lcom/lge/telephony/LGReferenceCountry;-><init>()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v10    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v11    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    :try_start_1
    const-string v1, "countryindex"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v7

    .local v7, "columnIndex":I
    sget-boolean v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v1, :cond_2

    const-string v1, "LGAssistDialPhoneNumberUtils"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " columnIndex : "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    invoke-interface {v8, v7}, Landroid/database/Cursor;->getInt(I)I

    move-result v6

    .local v6, "aa":I
    sget-boolean v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v1, :cond_3

    const-string v1, "LGAssistDialPhoneNumberUtils"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " aa : "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_3
    invoke-virtual {v11, v6}, Lcom/lge/telephony/LGReferenceCountry;->setIndex(I)V

    const-string v1, "countryindex"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v1

    invoke-virtual {v11, v1}, Lcom/lge/telephony/LGReferenceCountry;->setIndex(I)V

    const-string v1, "countryname"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v11, v1}, Lcom/lge/telephony/LGReferenceCountry;->setCountryName(Ljava/lang/String;)V

    const-string v1, "mcc"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v11, v1}, Lcom/lge/telephony/LGReferenceCountry;->setMccCode(Ljava/lang/String;)V

    const-string v1, "countrycode"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v11, v1}, Lcom/lge/telephony/LGReferenceCountry;->setCountryCode(Ljava/lang/String;)V

    const-string v1, "iddprefix"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v11, v1}, Lcom/lge/telephony/LGReferenceCountry;->setIddPrefix(Ljava/lang/String;)V

    const-string v1, "nddprefix"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v11, v1}, Lcom/lge/telephony/LGReferenceCountry;->setNddPrefix(Ljava/lang/String;)V

    const-string v1, "nanp"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v11, v1}, Lcom/lge/telephony/LGReferenceCountry;->setNanp(Ljava/lang/String;)V

    const-string v1, "area"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v11, v1}, Lcom/lge/telephony/LGReferenceCountry;->setAreaCode(Ljava/lang/String;)V

    const-string v1, "length"

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v8, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v11, v1}, Lcom/lge/telephony/LGReferenceCountry;->setNumLength(Ljava/lang/String;)V

    sget-boolean v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v1, :cond_4

    const-string v1, "LGAssistDialPhoneNumberUtils"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getRefCountry() ==> mRefCountry\'s country name : "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v11}, Lcom/lge/telephony/LGReferenceCountry;->getCountryName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :cond_4
    move-object v10, v11

    .end local v6    # "aa":I
    .end local v7    # "columnIndex":I
    .end local v11    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v10    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    :cond_5
    if-eqz v8, :cond_6

    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    :cond_6
    :goto_1
    move-object v11, v10

    .end local v10    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v11    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    goto/16 :goto_0

    .end local v11    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v10    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    :catch_0
    move-exception v9

    .local v9, "e":Ljava/lang/Exception;
    :goto_2
    :try_start_2
    invoke-virtual {v9}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz v8, :cond_6

    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    goto :goto_1

    .end local v9    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v1

    :goto_3
    if-eqz v8, :cond_7

    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    :cond_7
    throw v1

    .end local v10    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v11    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    :catchall_1
    move-exception v1

    move-object v10, v11

    .end local v11    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v10    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    goto :goto_3

    .end local v10    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v11    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    :catch_1
    move-exception v9

    move-object v10, v11

    .end local v11    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v10    # "mRefCountry":Lcom/lge/telephony/LGReferenceCountry;
    goto :goto_2
.end method

.method private initAreaCodeInfo()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    iget-object v0, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    if-nez v0, :cond_0

    const/16 v0, 0x12d

    new-array v0, v0, [Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const/4 v1, 0x0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "201"

    const-string v4, "New Jersey"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/4 v1, 0x1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "203"

    const-string v4, "Connecticut"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/4 v1, 0x2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "204"

    const-string v4, "Manitoba"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/4 v1, 0x3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "205"

    const-string v4, "Alabama"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/4 v1, 0x4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "206"

    const-string v4, "Washington"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/4 v1, 0x5

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "207"

    const-string v4, "Maine"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/4 v1, 0x6

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "208"

    const-string v4, "Idaho"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/4 v1, 0x7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "209"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "210"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "212"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xa

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "213"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xb

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "214"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xc

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "215"

    const-string v4, "Pennsylvania"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xd

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "216"

    const-string v4, "Ohio"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xe

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "217"

    const-string v4, "Illinois"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xf

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "218"

    const-string v4, "Minnesota"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x10

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "219"

    const-string v4, "Indiana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x11

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "224"

    const-string v4, "Illinois"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x12

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "225"

    const-string v4, "Louisiana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x13

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "226"

    const-string v4, "Ontario"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x14

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "228"

    const-string v4, "Mississippi"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x15

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "229"

    const-string v4, "Georgia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x16

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "231"

    const-string v4, "Michigan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x17

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "234"

    const-string v4, "Ohio"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x18

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "239"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x19

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "240"

    const-string v4, "Maryland"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "248"

    const-string v4, "Michigan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "250"

    const-string v4, "British Columbia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "251"

    const-string v4, "Alabama"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "252"

    const-string v4, "North Carolina"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "253"

    const-string v4, "Washington"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "254"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x20

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "256"

    const-string v4, "Alabama"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x21

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "260"

    const-string v4, "Indiana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x22

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "262"

    const-string v4, "Wisconsin"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x23

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "267"

    const-string v4, "Pennsylvania"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x24

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "269"

    const-string v4, "Michigan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x25

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "270"

    const-string v4, "Kentucky"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x26

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "276"

    const-string v4, "Virginia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x27

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "281"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x28

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "289"

    const-string v4, "Ontario"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x29

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "301"

    const-string v4, "Maryland"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x2a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "302"

    const-string v4, "Delaware"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x2b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "303"

    const-string v4, "Colorado"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x2c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "304"

    const-string v4, "West Virginia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x2d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "305"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x2e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "306"

    const-string v4, "Saskatchewan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x2f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "307"

    const-string v4, "Wyoming"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x30

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "308"

    const-string v4, "Nebraska"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x31

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "309"

    const-string v4, "Illinois"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x32

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "310"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x33

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "312"

    const-string v4, "Illinois"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x34

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "313"

    const-string v4, "Michigan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x35

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "314"

    const-string v4, "Missouri"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x36

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "315"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x37

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "316"

    const-string v4, "Kansas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x38

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "317"

    const-string v4, "Indiana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x39

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "318"

    const-string v4, "Louisiana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x3a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "319"

    const-string v4, "Iowa"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x3b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "320"

    const-string v4, "Minnesota"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x3c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "321"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x3d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "323"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x3e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "325"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x3f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "330"

    const-string v4, "Ohio"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x40

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "334"

    const-string v4, "Alabama"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x41

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "336"

    const-string v4, "North Carolina"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x42

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "337"

    const-string v4, "Louisiana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x43

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "339"

    const-string v4, "Massachusetts"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x44

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "347"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x45

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "351"

    const-string v4, "Massachusetts"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x46

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "352"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x47

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "360"

    const-string v4, "Washington"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x48

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "361"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x49

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "386"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x4a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "401"

    const-string v4, "Rhode Island"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x4b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "402"

    const-string v4, "Nebraska"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x4c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "403"

    const-string v4, "Alberta"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x4d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "404"

    const-string v4, "Georgia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x4e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "405"

    const-string v4, "Oklahoma"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x4f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "406"

    const-string v4, "Montana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x50

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "407"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x51

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "408"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x52

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "409"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x53

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "410"

    const-string v4, "Maryland"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x54

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "412"

    const-string v4, "Pennsylvania"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x55

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "413"

    const-string v4, "Massachusetts"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x56

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "414"

    const-string v4, "Wisconsin"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x57

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "415"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x58

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "416"

    const-string v4, "Ontario"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x59

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "417"

    const-string v4, "Missouri"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x5a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "418"

    const-string v4, "Quebec"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x5b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "419"

    const-string v4, "Ohio"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x5c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "423"

    const-string v4, "Tennessee"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x5d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "424"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x5e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "425"

    const-string v4, "Washington"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x5f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "430"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x60

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "432"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x61

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "434"

    const-string v4, "Virginia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x62

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "435"

    const-string v4, "Utah"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x63

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "438"

    const-string v4, "Quebec"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x64

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "440"

    const-string v4, "Ohio"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x65

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "443"

    const-string v4, "Maryland"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x66

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "450"

    const-string v4, "Quebec"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x67

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "469"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x68

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "478"

    const-string v4, "Georgia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x69

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "479"

    const-string v4, "Arkansas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x6a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "480"

    const-string v4, "Arizona"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x6b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "484"

    const-string v4, "Pennsylvania"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x6c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "501"

    const-string v4, "Arkansas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x6d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "502"

    const-string v4, "Kentucky"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x6e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "503"

    const-string v4, "Oregon"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x6f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "504"

    const-string v4, "Louisiana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x70

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "505"

    const-string v4, "New Mexico"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x71

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "506"

    const-string v4, "New Brunswick"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x72

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "507"

    const-string v4, "Minnesota"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x73

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "508"

    const-string v4, "Massachusetts"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x74

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "509"

    const-string v4, "Washington"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x75

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "510"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x76

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "512"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x77

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "513"

    const-string v4, "Ohio"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x78

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "514"

    const-string v4, "Quebec"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x79

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "515"

    const-string v4, "Iowa"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x7a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "516"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x7b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "517"

    const-string v4, "Michigan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x7c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "518"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x7d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "519"

    const-string v4, "Ontario"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x7e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "520"

    const-string v4, "Arizona"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x7f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "530"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x80

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "540"

    const-string v4, "Virginia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x81

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "541"

    const-string v4, "Oregon"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x82

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "551"

    const-string v4, "New Jersey"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x83

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "559"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x84

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "561"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x85

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "562"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x86

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "563"

    const-string v4, "Iowa"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x87

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "567"

    const-string v4, "Ohio"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x88

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "570"

    const-string v4, "Pennsylvania"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x89

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "571"

    const-string v4, "Virginia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x8a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "573"

    const-string v4, "Missouri"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x8b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "574"

    const-string v4, "Indiana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x8c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "575"

    const-string v4, "New Mexico"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x8d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "580"

    const-string v4, "Oklahoma"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x8e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "585"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x8f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "586"

    const-string v4, "Michigan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x90

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "601"

    const-string v4, "Mississippi"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x91

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "602"

    const-string v4, "Arizona"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x92

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "603"

    const-string v4, "New Hampshire"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x93

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "604"

    const-string v4, "British Columbia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x94

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "605"

    const-string v4, "South Dakota"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x95

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "606"

    const-string v4, "Kentucky"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x96

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "607"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x97

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "608"

    const-string v4, "Wisconsin"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x98

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "609"

    const-string v4, "New Jersey"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x99

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "610"

    const-string v4, "Pennsylvania"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x9a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "612"

    const-string v4, "Minnesota"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x9b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "613"

    const-string v4, "Ontario"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x9c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "614"

    const-string v4, "Ohio"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x9d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "615"

    const-string v4, "Tennessee"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x9e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "616"

    const-string v4, "Michigan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x9f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "617"

    const-string v4, "Massachusetts"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xa0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "618"

    const-string v4, "Illinois"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xa1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "619"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xa2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "620"

    const-string v4, "Kansas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xa3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "623"

    const-string v4, "Arizona"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xa4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "626"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xa5

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "630"

    const-string v4, "Illinois"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xa6

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "631"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xa7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "636"

    const-string v4, "Missouri"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xa8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "641"

    const-string v4, "Iowa"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xa9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "646"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xaa

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "647"

    const-string v4, "Ontario"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xab

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "650"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xac

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "651"

    const-string v4, "Minnesota"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xad

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "660"

    const-string v4, "Missouri"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xae

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "661"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xaf

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "662"

    const-string v4, "Mississippi"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xb0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "678"

    const-string v4, "Georgia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xb1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "682"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xb2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "701"

    const-string v4, "North Dakota"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xb3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "702"

    const-string v4, "Nevada"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xb4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "703"

    const-string v4, "Virginia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xb5

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "704"

    const-string v4, "North Carolina"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xb6

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "705"

    const-string v4, "Ontario"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xb7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "706"

    const-string v4, "Georgia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xb8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "707"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xb9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "708"

    const-string v4, "Illinois"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xba

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "709"

    const-string v4, "Newfoundland"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xbb

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "712"

    const-string v4, "Iowa"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xbc

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "713"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xbd

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "714"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xbe

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "715"

    const-string v4, "Wisconsin"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xbf

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "716"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xc0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "717"

    const-string v4, "Pennsylvania"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xc1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "718"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xc2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "719"

    const-string v4, "Colorado"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xc3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "720"

    const-string v4, "Colorado"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xc4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "724"

    const-string v4, "Pennsylvania"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xc5

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "727"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xc6

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "731"

    const-string v4, "Tennessee"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xc7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "732"

    const-string v4, "New Jersey"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xc8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "734"

    const-string v4, "Michigan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xc9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "740"

    const-string v4, "Ohio"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xca

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "754"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xcb

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "760"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xcc

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "763"

    const-string v4, "Minnesota"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xcd

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "765"

    const-string v4, "Indiana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xce

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "767"

    const-string v4, "Dominica"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xcf

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "769"

    const-string v4, "Mississippi"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xd0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "770"

    const-string v4, "Georgia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xd1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "772"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xd2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "773"

    const-string v4, "Illinois"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xd3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "774"

    const-string v4, "Massachusetts"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xd4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "775"

    const-string v4, "Nevada"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xd5

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "778"

    const-string v4, "British Columbia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xd6

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "780"

    const-string v4, "Alberta"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xd7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "781"

    const-string v4, "Massachusetts"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xd8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "785"

    const-string v4, "Kansas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xd9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "786"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xda

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "800"

    const-string v4, "Toll Free Numbers"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xdb

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "801"

    const-string v4, "Utah"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xdc

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "802"

    const-string v4, "Vermont"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xdd

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "803"

    const-string v4, "South Carolina"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xde

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "804"

    const-string v4, "Virginia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xdf

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "805"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xe0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "806"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xe1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "807"

    const-string v4, "Ontario"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xe2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "808"

    const-string v4, "Hawaii"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xe3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "809"

    const-string v4, "Dominican Republic"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xe4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "812"

    const-string v4, "Indiana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xe5

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "813"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xe6

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "814"

    const-string v4, "Pennsylvania"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xe7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "815"

    const-string v4, "Illinois"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xe8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "816"

    const-string v4, "Missouri"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xe9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "817"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xea

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "818"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xeb

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "819"

    const-string v4, "Quebec"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xec

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "828"

    const-string v4, "North Carolina"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xed

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "830"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xee

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "831"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xef

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "832"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xf0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "843"

    const-string v4, "South Carolina"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xf1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "845"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xf2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "847"

    const-string v4, "Illinois"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xf3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "848"

    const-string v4, "New Jersey"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xf4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "850"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xf5

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "856"

    const-string v4, "New Jersey"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xf6

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "857"

    const-string v4, "Massachusetts"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xf7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "858"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xf8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "859"

    const-string v4, "Kentucky"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xf9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "860"

    const-string v4, "Connecticut"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xfa

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "861"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xfb

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "863"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xfc

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "864"

    const-string v4, "South Carolina"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xfd

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "865"

    const-string v4, "Tennessee"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xfe

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "866"

    const-string v4, "Toll Free Numbers"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0xff

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "867"

    const-string v4, "Yukon, NW Terr., Nunavut"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x100

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "870"

    const-string v4, "Arkansas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x101

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "877"

    const-string v4, "Toll Free Numbers"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x102

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "878"

    const-string v4, "Pennsylvania"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x103

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "888"

    const-string v4, "Toll Free Numbers"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x104

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "901"

    const-string v4, "Tennessee"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x105

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "902"

    const-string v4, "Nova Scotia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x106

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "903"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x107

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "904"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x108

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "905"

    const-string v4, "Ontario"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x109

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "906"

    const-string v4, "Michigan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x10a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "907"

    const-string v4, "Alaska"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x10b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "908"

    const-string v4, "New Jersey"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x10c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "909"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x10d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "910"

    const-string v4, "North Carolina"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x10e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "912"

    const-string v4, "Georgia"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x10f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "913"

    const-string v4, "Kansas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x110

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "914"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x111

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "915"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x112

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "916"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x113

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "917"

    const-string v4, "New York"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x114

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "918"

    const-string v4, "Oklahoma"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x115

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "919"

    const-string v4, "North Carolina"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x116

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "920"

    const-string v4, "Wisconsin"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x117

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "925"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x118

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "928"

    const-string v4, "Arizona"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x119

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "931"

    const-string v4, "Tennessee"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x11a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "936"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x11b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "937"

    const-string v4, "Ohio"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x11c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "940"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x11d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "941"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x11e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "947"

    const-string v4, "Michigan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x11f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "949"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x120

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "951"

    const-string v4, "California"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x121

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "952"

    const-string v4, "Minnesota"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x122

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "954"

    const-string v4, "Florida"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x123

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "956"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x124

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "970"

    const-string v4, "Colorado"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x125

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "971"

    const-string v4, "Oregon"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x126

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "972"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x127

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "973"

    const-string v4, "New Jersey"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x128

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "978"

    const-string v4, "Massachusetts"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x129

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "979"

    const-string v4, "Texas"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x12a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "980"

    const-string v4, "North Carolina"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x12b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "985"

    const-string v4, "Louisiana"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    const/16 v1, 0x12c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    const-string v3, "989"

    const-string v4, "Michigan"

    invoke-direct {v2, p0, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;-><init>(Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;Ljava/lang/String;Ljava/lang/String;Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$1;)V

    aput-object v2, v0, v1

    iput-object v0, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    :cond_0
    return-void
.end method

.method private initSIDRangeInfo()V
    .locals 11

    .prologue
    const/16 v10, 0x2a

    const/4 v5, 0x1

    const/16 v9, 0xd5

    const/16 v8, 0xa6

    const/4 v7, 0x0

    iget-object v0, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    if-nez v0, :cond_0

    const/16 v0, 0xe5

    new-array v0, v0, [Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    new-instance v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v2, 0x87f

    invoke-direct {v1, v5, v7, v5, v2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v1, v0, v7

    new-instance v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/4 v2, 0x2

    const/16 v3, 0x3a80

    const/16 v4, 0x3aff

    invoke-direct {v1, v2, v5, v3, v4}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v1, v0, v5

    const/4 v1, 0x2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/4 v3, 0x3

    const/4 v4, 0x2

    const/16 v5, 0x7ae0

    const/16 v6, 0x7aef

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/4 v1, 0x3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/4 v3, 0x4

    const/4 v4, 0x3

    const/16 v5, 0x2060

    const/16 v6, 0x207f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/4 v1, 0x4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/4 v3, 0x5

    const/4 v4, 0x4

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/4 v1, 0x5

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/4 v3, 0x6

    const/4 v4, 0x5

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/4 v1, 0x6

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/4 v3, 0x7

    const/4 v4, 0x6

    const/16 v5, 0x2520

    const/16 v6, 0x253f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/4 v1, 0x7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x8

    const/4 v4, 0x7

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x9

    const/16 v4, 0x8

    const/16 v5, 0x1fd0

    const/16 v6, 0x1fdf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xa

    const/16 v4, 0x9

    const/16 v5, 0x7d80

    const/16 v6, 0x7dff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xa

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xb

    const/16 v4, 0xa

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xb

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xc

    const/16 v4, 0xb

    const/16 v5, 0x25b0

    const/16 v6, 0x25bf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xc

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xd

    const/16 v4, 0xc

    const/16 v5, 0x1e00

    const/16 v6, 0x1e7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xd

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xe

    const/16 v4, 0xd

    const/16 v5, 0x5980

    const/16 v6, 0x59ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xe

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xf

    const/16 v4, 0xe

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xf

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x10

    const/16 v4, 0xf

    const/16 v5, 0x1f90

    const/16 v6, 0x1f9f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x10

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x11

    const/16 v4, 0x10

    const/16 v5, 0x7ab0

    const/16 v6, 0x7abf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x11

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x12

    const/16 v4, 0x11

    const/16 v5, 0x34a0

    const/16 v6, 0x34bf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x12

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x13

    const/16 v4, 0x12

    const/16 v5, 0x1fe0

    const/16 v6, 0x1fef

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x13

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x14

    const/16 v4, 0x13

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x14

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x15

    const/16 v4, 0x14

    const/16 v5, 0x5d80

    const/16 v6, 0x5dff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x15

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x16

    const/16 v4, 0x15

    const/16 v5, 0x7f80

    const/16 v6, 0x7f89

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x16

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x17

    const/16 v4, 0x16

    const/16 v5, 0x2380

    const/16 v6, 0x239f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x17

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x18

    const/16 v4, 0x17

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x18

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x19

    const/16 v4, 0x18

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x19

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x1a

    const/16 v4, 0x19

    const/16 v5, 0x7a00

    const/16 v6, 0x7a1f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x1b

    const/16 v4, 0x1a

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x1c

    const/16 v4, 0x1b

    const/16 v5, 0x27c0

    const/16 v6, 0x27df

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x1d

    const/16 v4, 0x1c

    const/16 v5, 0x7c80

    const/16 v6, 0x7d7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x1e

    const/16 v4, 0x1d

    const/16 v5, 0x1fb0

    const/16 v6, 0x1fbf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x1f

    const/16 v4, 0x1e

    const/16 v5, 0x2a80

    const/16 v6, 0x2a8f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x20

    const/16 v4, 0x1f

    const/16 v5, 0x3ce0

    const/16 v6, 0x3cff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x20

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x21

    const/16 v4, 0x20

    const/16 v5, 0x2320

    const/16 v6, 0x233f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x21

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x22

    const/16 v4, 0x21

    const/16 v5, 0x26e0

    const/16 v6, 0x26ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x22

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x23

    const/16 v4, 0x22

    const/16 v5, 0x2b60

    const/16 v6, 0x2b7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x23

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x24

    const/16 v4, 0x23

    const/16 v5, 0x2480

    const/16 v6, 0x249f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x24

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x25

    const/16 v4, 0x24

    const/16 v5, 0x4000

    const/16 v6, 0x47ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x25

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x26

    const/16 v4, 0x25

    const/16 v5, 0x2290

    const/16 v6, 0x229f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x26

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x27

    const/16 v4, 0x26

    const/16 v5, 0x1fc0

    const/16 v6, 0x1fcf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x27

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x28

    const/16 v4, 0x27

    const/16 v5, 0x2460

    const/16 v6, 0x247f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x28

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x29

    const/16 v4, 0x28

    const/16 v5, 0x2440

    const/16 v6, 0x245f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x29

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x29

    const/16 v4, 0x7c00

    const/16 v5, 0x7c0a

    invoke-direct {v2, v10, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    new-instance v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v2, 0x2b

    const/16 v3, 0x3500

    const/16 v4, 0x37ff

    invoke-direct {v1, v2, v10, v3, v4}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v1, v0, v10

    const/16 v1, 0x2b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x2c

    const/16 v4, 0x2b

    const/16 v5, 0x7b80

    const/16 v6, 0x7bff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x2c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x2d

    const/16 v4, 0x2c

    const/16 v5, 0x27e0

    const/16 v6, 0x27ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x2d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x2e

    const/16 v4, 0x2d

    const/16 v5, 0x2b80

    const/16 v6, 0x2b8f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x2e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x2f

    const/16 v4, 0x2e

    const/16 v5, 0x7f20

    const/16 v6, 0x7f3f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x2f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x30

    const/16 v4, 0x2f

    const/16 v5, 0x2300

    const/16 v6, 0x231f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x30

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x31

    const/16 v4, 0x30

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x31

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x32

    const/16 v4, 0x31

    const/16 v5, 0x7e00

    const/16 v6, 0x7e7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x32

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x33

    const/16 v4, 0x32

    const/16 v5, 0x79e0

    const/16 v6, 0x79ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x33

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x34

    const/16 v4, 0x33

    const/16 v5, 0x3f00

    const/16 v6, 0x3f7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x34

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x35

    const/16 v4, 0x34

    const/16 v5, 0x24e0

    const/16 v6, 0x24ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x35

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x36

    const/16 v4, 0x35

    const/16 v5, 0x5800

    const/16 v6, 0x580f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x36

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x37

    const/16 v4, 0x36

    const/16 v5, 0x22d0

    const/16 v6, 0x22df

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x37

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x38

    const/16 v4, 0x37

    const/16 v5, 0x2590

    const/16 v6, 0x259f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x38

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x39

    const/16 v4, 0x38

    const/16 v5, 0x2280

    const/16 v6, 0x228f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x39

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x3a

    const/16 v4, 0x39

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x3a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x3b

    const/16 v4, 0x3a

    const/16 v5, 0x7a40

    const/16 v6, 0x7a5f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x3b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x3c

    const/16 v4, 0x3b

    const/16 v5, 0x2020

    const/16 v6, 0x203f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x3c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x3d

    const/16 v4, 0x3c

    const/16 v5, 0x7fc0

    const/16 v6, 0x7fdf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x3d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x3e

    const/16 v4, 0x3d

    const/16 v5, 0x24a0

    const/16 v6, 0x24bf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x3e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x3f

    const/16 v4, 0x3e

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x3f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x40

    const/16 v4, 0x3f

    const/16 v5, 0x2a78

    const/16 v6, 0x2a7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x40

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x41

    const/16 v4, 0x40

    const/16 v5, 0x2620

    const/16 v6, 0x263f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x41

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x42

    const/16 v4, 0x41

    const/16 v5, 0x1f00

    const/16 v6, 0x1f0f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x42

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x43

    const/16 v4, 0x42

    const/16 v5, 0x2b20

    const/16 v6, 0x2b3f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x43

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x44

    const/16 v4, 0x43

    const/16 v5, 0x2ad0

    const/16 v6, 0x2adf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x44

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x45

    const/16 v4, 0x44

    const/16 v5, 0x5f80

    const/16 v6, 0x5f83

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x45

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x46

    const/16 v4, 0x45

    const/16 v5, 0x5c80

    const/16 v6, 0x5d7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x46

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x47

    const/16 v4, 0x46

    const/16 v5, 0x7a60

    const/16 v6, 0x7a7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x47

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x48

    const/16 v4, 0x47

    const/16 v5, 0x2bf0

    const/16 v6, 0x2be4

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x48

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x49

    const/16 v4, 0x48

    const/16 v5, 0x24c0

    const/16 v6, 0x24df

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x49

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x4a

    const/16 v4, 0x49

    const/16 v5, 0x2160

    const/16 v6, 0x217f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x4a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x4b

    const/16 v4, 0x4a

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x4b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x4c

    const/16 v4, 0x4b

    const/16 v5, 0x5600

    const/16 v6, 0x56ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x4c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x4d

    const/16 v4, 0x4c

    const/16 v5, 0x2400

    const/16 v6, 0x241f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x4d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x4e

    const/16 v4, 0x4d

    const/16 v5, 0x7ad0

    const/16 v6, 0x7adf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x4e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x4f

    const/16 v4, 0x4e

    const/16 v5, 0x5e80

    const/16 v6, 0x5eff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x4f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x50

    const/16 v4, 0x4f

    const/16 v5, 0x5e80

    const/16 v6, 0x5eff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x50

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x51

    const/16 v4, 0x50

    const/16 v5, 0x1f80

    const/16 v6, 0x1f8f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x51

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x52

    const/16 v4, 0x51

    const/16 v5, 0x7a80

    const/16 v6, 0x7a8f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x52

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x53

    const/16 v4, 0x52

    const/16 v5, 0x25e0

    const/16 v6, 0x25ef

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x53

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x54

    const/16 v4, 0x53

    const/16 v5, 0x7fa0

    const/16 v6, 0x7fbf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x54

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x55

    const/16 v4, 0x54

    const/16 v5, 0x2260

    const/16 v6, 0x227f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x55

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x56

    const/16 v4, 0x55

    const/16 v5, 0x2260

    const/16 v6, 0x227f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x56

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x57

    const/16 v4, 0x56

    const/16 v5, 0x7a20

    const/16 v6, 0x7a3f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x57

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x58

    const/16 v4, 0x57

    const/16 v5, 0x7f60

    const/16 v6, 0x7f7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x58

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x59

    const/16 v4, 0x58

    const/16 v5, 0x7fe0

    const/16 v6, 0x7fff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x59

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x5a

    const/16 v4, 0x59

    const/16 v5, 0x2990

    const/16 v6, 0x299f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x5a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x5b

    const/16 v4, 0x5a

    const v5, 0x26701

    const/16 v6, 0x3dff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x5b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x5c

    const/16 v4, 0x5b

    const/16 v5, 0x5f60

    const/16 v6, 0x5f7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x5c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x5d

    const/16 v4, 0x5c

    const/16 v5, 0x3880

    const/16 v6, 0x39ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x5d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x5e

    const/16 v4, 0x5d

    const/16 v5, 0x2900

    const/16 v6, 0x297f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x5e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x5f

    const/16 v4, 0x5e

    const/16 v5, 0x3d00

    const/16 v6, 0x3d7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x5f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x60

    const/16 v4, 0x5f

    const/16 v5, 0x3c60

    const/16 v6, 0x3c7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x60

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x61

    const/16 v4, 0x60

    const/16 v5, 0x5f40

    const/16 v6, 0x5f43

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x61

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x62

    const/16 v4, 0x61

    const/16 v5, 0x2100

    const/16 v6, 0x211f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x62

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x63

    const/16 v4, 0x62

    const/16 v5, 0x5a80

    const/16 v6, 0x5b7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x63

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x64

    const/16 v4, 0x63

    const/16 v5, 0x1ff0

    const/16 v6, 0x1fff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x64

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x65

    const/16 v4, 0x64

    const/16 v5, 0x3000

    const/16 v6, 0x33ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x65

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x66

    const/16 v4, 0x65

    const/16 v5, 0x3c20

    const/16 v6, 0x3c3f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x66

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x67

    const/16 v4, 0x66

    const/16 v5, 0x22e0

    const/16 v6, 0x22ef

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x67

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x68

    const/16 v4, 0x67

    const/16 v5, 0x2680

    const/16 v6, 0x269f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x68

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x69

    const/16 v4, 0x68

    const/16 v5, 0x2bc0

    const/16 v6, 0x2bcf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x69

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x6a

    const/16 v4, 0x69

    const/16 v5, 0x2b40

    const/16 v6, 0x2b5f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x6a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x6b

    const/16 v4, 0x6a

    const/16 v5, 0x880

    const/16 v6, 0x8ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x6b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x6c

    const/16 v4, 0x6b

    const/16 v5, 0x2c30

    const/16 v6, 0x2c3f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x6c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x6d

    const/16 v4, 0x6c

    const/16 v5, 0x542e

    const/16 v6, 0x543e

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x6d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x6e

    const/16 v4, 0x6d

    const/16 v5, 0x3458

    const/16 v6, 0x349f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x6e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x6f

    const/16 v4, 0x6e

    const/16 v5, 0x2a20

    const/16 v6, 0x2a21

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x6f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x70

    const/16 v4, 0x6f

    const/16 v5, 0x3c00

    const/16 v6, 0x3c1f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x70

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x71

    const/16 v4, 0x70

    const/16 v5, 0x2580

    const/16 v6, 0x258f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x71

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x72

    const/16 v4, 0x71

    const/16 v5, 0x23c0

    const/16 v6, 0x23df

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x72

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x73

    const/16 v4, 0x72

    const/16 v5, 0x2140

    const/16 v6, 0x215f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x73

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x74

    const/16 v4, 0x73

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x74

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x75

    const/16 v4, 0x74

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x75

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x76

    const/16 v4, 0x75

    const/16 v5, 0x5f20

    const/16 v6, 0x5f3f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x76

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x77

    const/16 v4, 0x76

    const/16 v5, 0x2c20

    const/16 v6, 0x2c2f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x77

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x78

    const/16 v4, 0x77

    const/16 v5, 0x2740

    const/16 v6, 0x275f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x78

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x79

    const/16 v4, 0x78

    const/16 v5, 0x27a0

    const/16 v6, 0x27bf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x79

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x7a

    const/16 v4, 0x79

    const/16 v5, 0x2880

    const/16 v6, 0x28ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x7a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x7b

    const/16 v4, 0x7a

    const/16 v5, 0x34e0

    const/16 v6, 0x34ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x7b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x7c

    const/16 v4, 0x7b

    const/16 v5, 0x2240

    const/16 v6, 0x225f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x7c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x7d

    const/16 v4, 0x7c

    const/16 v5, 0x7af0

    const/16 v6, 0x7af3

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x7d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x7e

    const/16 v4, 0x7d

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x7e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x7f

    const/16 v4, 0x7e

    const/16 v5, 0x2c10

    const/16 v6, 0x2c1f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x7f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x80

    const/16 v4, 0x7f

    const/16 v5, 0x7a90

    const/16 v6, 0x7a9f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x80

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x81

    const/16 v4, 0x80

    const/16 v5, 0x2220

    const/16 v6, 0x223f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x81

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x82

    const/16 v4, 0x81

    const/16 v5, 0x23a0

    const/16 v6, 0x23bf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x82

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x83

    const/16 v4, 0x82

    const/16 v5, 0x6000

    const/16 v6, 0x61f3

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x83

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x84

    const/16 v4, 0x83

    const/16 v5, 0x3e32

    const/16 v6, 0x3e41

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x84

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x85

    const/16 v4, 0x84

    const/16 v5, 0x2a00

    const/16 v6, 0x2a0f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x85

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x86

    const/16 v4, 0x85

    const/16 v5, 0x3ca0

    const/16 v6, 0x3cbf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x86

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x87

    const/16 v4, 0x86

    const/16 v5, 0x1f70

    const/16 v6, 0x1f7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x87

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x88

    const/16 v4, 0x87

    const/16 v5, 0x2040

    const/16 v6, 0x205f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x88

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x89

    const/16 v4, 0x88

    const/16 v5, 0x2700

    const/16 v6, 0x271f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x89

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x8a

    const/16 v4, 0x89

    const/16 v5, 0x3b80

    const/16 v6, 0x3bff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x8a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x8b

    const/16 v4, 0x8a

    const/16 v5, 0x2780

    const/16 v6, 0x279f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x8b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x8c

    const/16 v4, 0x8b

    const/16 v5, 0x2a90

    const/16 v6, 0x2a9f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x8c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x8d

    const/16 v4, 0x8c

    const/16 v5, 0x3cc0

    const/16 v6, 0x3cdf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x8d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x8e

    const/16 v4, 0x8d

    const/16 v5, 0x5e00

    const/16 v6, 0x5e7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x8e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x8f

    const/16 v4, 0x8e

    const/16 v5, 0x7aa0

    const/16 v6, 0x7aaf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x8f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x90

    const/16 v4, 0x8f

    const/16 v5, 0x2bd0

    const/16 v6, 0x2bdf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x90

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x91

    const/16 v4, 0x90

    const/16 v5, 0x2180

    const/16 v6, 0x21ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x91

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x92

    const/16 v4, 0x91

    const/16 v5, 0x7f00

    const/16 v6, 0x7f1f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x92

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x93

    const/16 v4, 0x92

    const/16 v5, 0x2340

    const/16 v6, 0x235f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x93

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x94

    const/16 v4, 0x93

    const/16 v5, 0x2420

    const/16 v6, 0x243f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x94

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x95

    const/16 v4, 0x94

    const/16 v5, 0x25d0

    const/16 v6, 0x25df

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x95

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x96

    const/16 v4, 0x95

    const/16 v5, 0x5700

    const/16 v6, 0x577f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x96

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x97

    const/16 v4, 0x96

    const/16 v5, 0x2c50

    const/16 v6, 0x2c5f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x97

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x98

    const/16 v4, 0x97

    const/16 v5, 0x3a00

    const/16 v6, 0x3a7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x98

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x99

    const/16 v4, 0x98

    const/16 v5, 0x2ae0

    const/16 v6, 0x2aef

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x99

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x9a

    const/16 v4, 0x99

    const/16 v5, 0x7f40

    const/16 v6, 0x7f5f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x9a

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x9b

    const/16 v4, 0x9a

    const/16 v5, 0x2b00

    const/16 v6, 0x2b1f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x9b

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x9c

    const/16 v4, 0x9b

    const/16 v5, 0x7980

    const/16 v6, 0x799f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x9c

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x9d

    const/16 v4, 0x9c

    const/16 v5, 0x7e80

    const/16 v6, 0x7eff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x9d

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x9e

    const/16 v4, 0x9d

    const/16 v5, 0x2980

    const/16 v6, 0x298f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x9e

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0x9f

    const/16 v4, 0x9e

    const/16 v5, 0x3f80

    const/16 v6, 0x3f8f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0x9f

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xa0

    const/16 v4, 0x9e

    const/16 v5, 0x3f90

    const/16 v6, 0x3fff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xa0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xa1

    const/16 v4, 0x9f

    const/16 v5, 0x5f00

    const/16 v6, 0x5f1f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xa1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xa2

    const/16 v4, 0xa0

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xa2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xa3

    const/16 v4, 0xa1

    const/16 v5, 0x7ac0

    const/16 v6, 0x7acf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xa3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xa4

    const/16 v4, 0xa2

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xa4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xa5

    const/16 v4, 0xa3

    const/16 v5, 0x24e0

    const/16 v6, 0x24ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xa5

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xa4

    const/16 v4, 0x22f0

    const/16 v5, 0x22ff

    invoke-direct {v2, v8, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    new-instance v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v2, 0xa7

    const/16 v3, 0xa5

    const/16 v4, 0x3e80

    const/16 v5, 0x3eff

    invoke-direct {v1, v2, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v1, v0, v8

    const/16 v1, 0xa7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xa8

    const/16 v4, 0x2c80

    const/16 v5, 0x2d22

    invoke-direct {v2, v3, v8, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xa8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xa9

    const/16 v4, 0xa7

    const/16 v5, 0x2600

    const/16 v6, 0x261f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xa9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xaa

    const/16 v4, 0xa8

    const/16 v5, 0x1f60

    const/16 v6, 0x1f6f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xaa

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xab

    const/16 v4, 0xa9

    const/16 v5, 0x1f50

    const/16 v6, 0x1f5f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xab

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xac

    const/16 v4, 0xaa

    const/16 v5, 0x1f30

    const/16 v6, 0x1f3f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xac

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xad

    const/16 v4, 0xab

    const/16 v5, 0x1f40

    const/16 v6, 0x1f47

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xad

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xae

    const/16 v4, 0xac

    const/16 v5, 0x2bb0

    const/16 v6, 0x2bbf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xae

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xaf

    const/16 v4, 0xad

    const/16 v5, 0x2a10

    const/16 v6, 0x2a1f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xaf

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xb0

    const/16 v4, 0xae

    const/16 v5, 0x22a0

    const/16 v6, 0x22af

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xb0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xb1

    const/16 v4, 0xaf

    const/16 v5, 0x3c80

    const/16 v6, 0x3c9f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xb1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xb2

    const/16 v4, 0xb0

    const/16 v5, 0x2200

    const/16 v6, 0x221f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xb2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xb3

    const/16 v4, 0xb1

    const/16 v5, 0x5b80

    const/16 v6, 0x5bff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xb3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xb4

    const/16 v4, 0xb2

    const/16 v5, 0x22c0

    const/16 v6, 0x22cf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xb4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xb5

    const/16 v4, 0xb3

    const/16 v5, 0x23e0

    const/16 v6, 0x23ff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xb5

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xb6

    const/16 v4, 0xb4

    const/16 v5, 0x25c0

    const/16 v6, 0x25cf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xb6

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xb7

    const/16 v4, 0xb5

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xb7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xb8

    const/16 v4, 0xb6

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xb8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xb9

    const/16 v4, 0xb7

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xb9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xba

    const/16 v4, 0xb8

    const/16 v5, 0x2640

    const/16 v6, 0x265f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xba

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xbb

    const/16 v4, 0xb9

    const v5, 0x19007

    const/16 v6, 0x287f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xbb

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xbc

    const/16 v4, 0xba

    const/16 v5, 0x5c00

    const/16 v6, 0x5c7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xbc

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xbd

    const/16 v4, 0xbb

    const/16 v5, 0x3b00

    const/16 v6, 0x3b7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xbd

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xbe

    const/16 v4, 0xbc

    const/16 v5, 0x2560

    const/16 v6, 0x257f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xbe

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xbf

    const/16 v4, 0xbd

    const/16 v5, 0x79a0

    const/16 v6, 0x79bf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xbf

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xc0

    const/16 v4, 0xbe

    const/16 v5, 0x25a0

    const/16 v6, 0x25af

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xc0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xc1

    const/16 v4, 0xbf

    const/16 v5, 0x5780

    const/16 v6, 0x5783

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xc1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xc2

    const/16 v4, 0xc0

    const/16 v5, 0x5a00

    const/16 v6, 0x5a7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xc2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xc3

    const/16 v4, 0xc1

    const/16 v5, 0x3c40

    const/16 v6, 0x3c5f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xc3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xc4

    const/16 v4, 0xc2

    const/16 v5, 0x34c0

    const/16 v6, 0x34df

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xc4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xc5

    const/16 v4, 0xc3

    const/16 v5, 0x2a68

    const/16 v6, 0x2a77

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xc5

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xc6

    const/16 v4, 0xc4

    const/16 v5, 0x26a0

    const/16 v6, 0x26bf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xc6

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xc7

    const/16 v4, 0xc5

    const/16 v5, 0x2000

    const/16 v6, 0x201f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xc7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xc8

    const/16 v4, 0xc6

    const/16 v5, 0x2360

    const/16 v6, 0x237f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xc8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xc9

    const/16 v4, 0xc7

    const/16 v5, 0x2aa0

    const/16 v6, 0x2aaf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xc9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xca

    const/16 v4, 0xc8

    const/16 v5, 0x2660

    const/16 v6, 0x267f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xca

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xcb

    const/16 v4, 0xc9

    const/16 v5, 0x2120

    const/16 v6, 0x213f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xcb

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xcc

    const/16 v4, 0xca

    const/16 v5, 0x3800

    const/16 v6, 0x387f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xcc

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xcd

    const/16 v4, 0xcb

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xcd

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xce

    const/16 v4, 0xcc

    const/16 v5, 0x2a30

    const/16 v6, 0x2a3f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xce

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xcf

    const/16 v4, 0xcd

    const/16 v5, 0x26c0

    const/16 v6, 0x26df

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xcf

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xd0

    const/16 v4, 0xce

    const/16 v5, 0x3e22

    const/16 v6, 0x3e31

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xd0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xd1

    const/16 v4, 0xcf

    const/16 v5, 0x2c70

    const/16 v6, 0x2c7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xd1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xd2

    const/16 v4, 0xd0

    const/16 v5, 0x2c70

    const/16 v6, 0x2c7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xd2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xd3

    const/16 v4, 0xd1

    const/16 v5, 0x2c70

    const/16 v6, 0x2c7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xd3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xd4

    const/16 v4, 0xd2

    const/16 v5, 0x5880

    const/16 v6, 0x597f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xd4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xd3

    invoke-direct {v2, v9, v3, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    new-instance v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v2, 0xd6

    const/16 v3, 0xd4

    const/16 v4, 0x79c0

    const/16 v5, 0x79df

    invoke-direct {v1, v2, v3, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v1, v0, v9

    const/16 v1, 0xd6

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xd7

    const/16 v4, 0x2a50

    const/16 v5, 0x2a67

    invoke-direct {v2, v3, v9, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xd7

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xd8

    const/16 v4, 0xd6

    const/16 v5, 0x2ac0

    const/16 v6, 0x2acf

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xd8

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xd9

    const/16 v4, 0xd7

    invoke-direct {v2, v3, v4, v7, v7}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xd9

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xda

    const/16 v4, 0xd8

    const/16 v5, 0x7b00

    const/16 v6, 0x7b7f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xda

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xdb

    const/16 v4, 0xd9

    const/16 v5, 0x3400

    const/16 v6, 0x347f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xdb

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xdc

    const/16 v4, 0xda

    const/16 v5, 0x2af0

    const/16 v6, 0x2aff

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xdc

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xdd

    const/16 v4, 0xdb

    const/16 v5, 0x2c40

    const/16 v6, 0x2c4f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xdd

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xde

    const/16 v4, 0xdb

    const/16 v5, 0x2c60

    const/16 v6, 0x2c6f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xde

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xdf

    const/16 v4, 0xdc

    const/16 v5, 0x2720

    const/16 v6, 0x273f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xdf

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xe0

    const/16 v4, 0xdd

    const/16 v5, 0x2760

    const/16 v6, 0x277f

    invoke-direct {v2, v3, v4, v5, v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xe0

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xe1

    const/16 v4, 0x6400

    const/16 v5, 0x65ff

    invoke-direct {v2, v3, v10, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xe1

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xe2

    const/16 v4, 0x2d24

    const/16 v5, 0x2d4f

    invoke-direct {v2, v3, v8, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xe2

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xe3

    const/16 v4, 0x2d51

    const/16 v5, 0x2fff

    invoke-direct {v2, v3, v8, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xe3

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xe4

    const/16 v4, 0x2a50

    const/16 v5, 0x2d23

    invoke-direct {v2, v3, v9, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    const/16 v1, 0xe4

    new-instance v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    const/16 v3, 0xe5

    const/16 v4, 0x2d50

    const/16 v5, 0x2d50

    invoke-direct {v2, v3, v9, v4, v5}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;-><init>(IIII)V

    aput-object v2, v0, v1

    iput-object v0, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    :cond_0
    return-void
.end method

.method public static is611DialNumber(Ljava/lang/String;)Z
    .locals 2
    .param p0, "number"    # Ljava/lang/String;

    .prologue
    const-string v0, "*611"

    .local v0, "is611Check":Ljava/lang/String;
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {p0, v0}, Landroid/telephony/PhoneNumberUtils;->compare(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static isNanpSimplified(Ljava/lang/String;)Z
    .locals 3
    .param p0, "dialStr"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .local v0, "retVal":Z
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    const/16 v2, 0xa

    if-ne v1, v2, :cond_0

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->isTwoToNine(C)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x3

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->isTwoToNine(C)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method private isNeeded_OTAIddPrefix(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Z
    .locals 12
    .param p1, "pNumber"    # Ljava/lang/String;
    .param p2, "currentCountry"    # Lcom/lge/telephony/LGReferenceCountry;
    .param p3, "context"    # Landroid/content/Context;

    .prologue
    const/4 v7, 0x1

    const/4 v6, 0x0

    const/4 v4, 0x0

    .local v4, "refCC":Ljava/lang/String;
    const/4 v2, 0x0

    .local v2, "otaCC":Ljava/lang/String;
    const/4 v3, 0x0

    .local v3, "otherCC":Ljava/lang/String;
    const/4 v5, 0x0

    .local v5, "retVal":Z
    invoke-direct {p0, p3}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getRefCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v1

    .local v1, "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v4

    :cond_0
    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_3

    :try_start_0
    sget-boolean v8, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v8, :cond_1

    const-string v8, "LGAssistDialPhoneNumberUtils"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, " isNeeded_OTAIddPrefix() ==> pNumber.substring(0, ota_CC.length()) : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const/4 v10, 0x0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v11

    invoke-virtual {p1, v10, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v8, "LGAssistDialPhoneNumberUtils"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, " isNeeded_OTAIddPrefix() ==>  ota_CC : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    const/4 v8, 0x0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {p1, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v8

    if-ne v8, v7, :cond_3

    invoke-virtual {p2}, Lcom/lge/telephony/LGReferenceCountry;->getNanp()Ljava/lang/String;

    move-result-object v7

    const-string v8, "1"

    invoke-static {v7, v8}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v7

    const/16 v8, 0xa

    if-le v7, v8, :cond_2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {p1, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    sput-object v7, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->afterNumber:Ljava/lang/String;

    :cond_2
    const/4 v5, 0x1

    :goto_0
    return v6

    :cond_3
    if-eqz v4, :cond_5

    sget-boolean v6, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v6, :cond_4

    const-string v6, "LGAssistDialPhoneNumberUtils"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, " isNeeded_OTAIddPrefix() ==> pNumber.substring(0, ref_CC.length()) : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const/4 v9, 0x0

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {p1, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v6, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v6, "LGAssistDialPhoneNumberUtils"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, " isNeeded_OTAIddPrefix() ==>  ref_CC : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v6, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_4
    const/4 v6, 0x0

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v8

    invoke-virtual {p1, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v6

    if-ne v6, v7, :cond_5

    const/4 v5, 0x1

    move v6, v7

    goto :goto_0

    :cond_5
    if-nez v5, :cond_7

    iget-object v6, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    if-eqz v6, :cond_7

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    iget-object v6, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    array-length v6, v6

    if-ge v0, v6, :cond_7

    iget-object v6, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    aget-object v6, v6, v0

    invoke-virtual {v6}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v6

    if-lez v6, :cond_6

    const/4 v6, 0x0

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v8

    invoke-virtual {p1, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z
    :try_end_0
    .catch Ljava/lang/StringIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v6

    if-ne v6, v7, :cond_6

    const/4 v5, 0x1

    move v6, v7

    goto :goto_0

    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .end local v0    # "i":I
    :catch_0
    move-exception v6

    :cond_7
    move v6, v5

    goto/16 :goto_0
.end method

.method private static isTwoToNine(C)Z
    .locals 1
    .param p0, "c"    # C

    .prologue
    const/16 v0, 0x32

    if-lt p0, v0, :cond_0

    const/16 v0, 0x39

    if-gt p0, v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private loadAllCountryForAssistedDial(Landroid/content/Context;)V
    .locals 10
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v3, 0x0

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .local v0, "mContentResolver":Landroid/content/ContentResolver;
    sget-object v1, Lcom/lge/telephony/SettingsForAssistDial$AssistDial;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lcom/lge/constants/SettingsConstants$AssistDial;->PROJECTION:[Ljava/lang/String;

    move-object v4, v3

    move-object v5, v3

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .local v6, "cursor":Landroid/database/Cursor;
    if-nez v6, :cond_1

    const-string v1, "LGAssistDialPhoneNumberUtils"

    const-string v2, "cursor is null"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-interface {v6}, Landroid/database/Cursor;->getCount()I

    move-result v1

    new-array v1, v1, [Lcom/lge/telephony/LGReferenceCountry;

    iput-object v1, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    sget-boolean v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v1, :cond_2

    const-string v1, "LGAssistDialPhoneNumberUtils"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " cursor.getCount()  : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-interface {v6}, Landroid/database/Cursor;->getCount()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    :try_start_0
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v1

    if-eqz v1, :cond_3

    const/4 v8, 0x0

    .local v8, "i":I
    :goto_1
    invoke-interface {v6}, Landroid/database/Cursor;->getCount()I

    move-result v1

    if-ge v8, v1, :cond_3

    new-instance v9, Lcom/lge/telephony/LGReferenceCountry;

    invoke-direct {v9}, Lcom/lge/telephony/LGReferenceCountry;-><init>()V

    .local v9, "mRc":Lcom/lge/telephony/LGReferenceCountry;
    const-string v1, "countryindex"

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v1

    invoke-virtual {v9, v1}, Lcom/lge/telephony/LGReferenceCountry;->setIndex(I)V

    const-string v1, "countryname"

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v9, v1}, Lcom/lge/telephony/LGReferenceCountry;->setCountryName(Ljava/lang/String;)V

    const-string v1, "mcc"

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v9, v1}, Lcom/lge/telephony/LGReferenceCountry;->setMccCode(Ljava/lang/String;)V

    const-string v1, "countrycode"

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v9, v1}, Lcom/lge/telephony/LGReferenceCountry;->setCountryCode(Ljava/lang/String;)V

    const-string v1, "iddprefix"

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v9, v1}, Lcom/lge/telephony/LGReferenceCountry;->setIddPrefix(Ljava/lang/String;)V

    const-string v1, "nddprefix"

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v9, v1}, Lcom/lge/telephony/LGReferenceCountry;->setNddPrefix(Ljava/lang/String;)V

    const-string v1, "nanp"

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v9, v1}, Lcom/lge/telephony/LGReferenceCountry;->setNanp(Ljava/lang/String;)V

    const-string v1, "area"

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v9, v1}, Lcom/lge/telephony/LGReferenceCountry;->setAreaCode(Ljava/lang/String;)V

    const-string v1, "length"

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v9, v1}, Lcom/lge/telephony/LGReferenceCountry;->setNumLength(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    aput-object v9, v1, v8

    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    add-int/lit8 v8, v8, 0x1

    goto/16 :goto_1

    .end local v8    # "i":I
    .end local v9    # "mRc":Lcom/lge/telephony/LGReferenceCountry;
    :cond_3
    if-eqz v6, :cond_0

    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    :catch_0
    move-exception v7

    .local v7, "e":Ljava/lang/Exception;
    :try_start_1
    invoke-virtual {v7}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v6, :cond_0

    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .end local v7    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v1

    if-eqz v6, :cond_4

    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_4
    throw v1
.end method

.method private reCreateReferenceCountryList(Landroid/content/Context;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v3, 0x0

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    .local v1, "mContentResolver":Landroid/content/ContentResolver;
    sget-object v2, Lcom/lge/telephony/SettingsForAssistDial$AssistDial;->CONTENT_URI:Landroid/net/Uri;

    invoke-virtual {v1, v2, v3, v3}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    const-string v2, "assist_dial_check"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const-string v2, "area"

    invoke-static {v1, v2}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "mAreaCode":Ljava/lang/String;
    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_0

    const-string v2, "LGAssistDialPhoneNumberUtils"

    const-string v3, "reCreateReferenceCountryList - reCreate assist_dail DB"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    if-eqz v0, :cond_1

    const-string v2, ""

    invoke-static {v0, v2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_2

    :cond_1
    invoke-static {v1}, Lcom/lge/telephony/SettingsForAssistDial$AssistDial;->initAssistDialCountryDetailList(Landroid/content/ContentResolver;)V

    :goto_0
    return-void

    :cond_2
    invoke-static {v1, v0}, Lcom/lge/telephony/SettingsForAssistDial$AssistDial;->initAssistDialCountryDetailList(Landroid/content/ContentResolver;Ljava/lang/String;)V

    goto :goto_0
.end method


# virtual methods
.method public convertToCdma611Number(Ljava/lang/String;Landroid/content/Context;)Ljava/lang/String;
    .locals 6
    .param p1, "number"    # Ljava/lang/String;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    .local v1, "IddNumber":Ljava/lang/String;
    const-string v0, "19085594899"

    .local v0, "Cdma611Number":Ljava/lang/String;
    invoke-virtual {p0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getAssistedDialCurrentCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v2

    .local v2, "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    sget-boolean v3, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v3, :cond_0

    const-string v3, "LGAssistDialPhoneNumberUtils"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "convertToCdma611Number()... before number "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    invoke-virtual {p0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->isCdmaVzWNetwork(Landroid/content/Context;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {p0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->isInternationalCdmaIdd(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    if-eqz v2, :cond_3

    invoke-virtual {v2}, Lcom/lge/telephony/LGReferenceCountry;->getNanp()Ljava/lang/String;

    move-result-object v3

    const-string v4, "1"

    invoke-static {v3, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_3

    move-object p1, v0

    :cond_1
    :goto_0
    sget-boolean v3, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v3, :cond_2

    const-string v3, "LGAssistDialPhoneNumberUtils"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "convertToCdma611Number()... after number = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    return-object p1

    :cond_3
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_4

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_4
    move-object p1, v0

    goto :goto_0
.end method

.method public convertToCdmaVoiceMailNumber(Ljava/lang/String;Landroid/content/Context;)Ljava/lang/String;
    .locals 5
    .param p1, "number"    # Ljava/lang/String;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x0

    .local v0, "IddNumber":Ljava/lang/String;
    invoke-virtual {p0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getAssistedDialCurrentCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v1

    .local v1, "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_0

    const-string v2, "LGAssistDialPhoneNumberUtils"

    const-string v3, "convertToCdmaVoiceMailNumber()..."

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    invoke-virtual {p0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->isCdmaVzWNetwork(Landroid/content/Context;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {p0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->isInternationalCdmaIdd(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    if-eqz v1, :cond_3

    invoke-virtual {v1}, Lcom/lge/telephony/LGReferenceCountry;->getNanp()Ljava/lang/String;

    move-result-object v2

    const-string v3, "1"

    invoke-static {v2, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "1"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :cond_1
    :goto_0
    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_2

    const-string v2, "LGAssistDialPhoneNumberUtils"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "convertToCdmaVoiceMailNumber()... number = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    return-object p1

    :cond_3
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_4

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "1"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_4
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "1"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method

.method public getAreacodeInfo(Ljava/lang/String;)Z
    .locals 7
    .param p1, "pNumber"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v1, 0x0

    .local v1, "i":I
    const/4 v0, 0x0

    .local v0, "areacode":Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v4

    const/16 v5, 0xa

    if-le v4, v5, :cond_4

    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x31

    if-ne v4, v5, :cond_2

    const/4 v4, 0x4

    invoke-virtual {p1, v2, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    :goto_0
    sget-boolean v4, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v4, :cond_0

    const-string v4, "LGAssistDialPhoneNumberUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " getAreacodeInfo(String pNumber) ==> areacode : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v4, "LGAssistDialPhoneNumberUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " getAreacodeInfo(String pNumber) ==> areacodeInfo.toString() : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    invoke-virtual {v6}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    const/4 v1, 0x0

    :goto_1
    iget-object v4, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    array-length v4, v4

    if-ge v1, v4, :cond_4

    sget-boolean v4, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v4, :cond_1

    const-string v4, "LGAssistDialPhoneNumberUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " getAreacodeInfo(String pNumber) ==> areacodeInfo[i].getAreacode() : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    aget-object v6, v6, v1

    invoke-virtual {v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;->getAreacode()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "  :  "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    aget-object v6, v6, v1

    invoke-virtual {v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;->getCityname()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    iget-object v4, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    aget-object v4, v4, v1

    invoke-virtual {v4}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;->getAreacode()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v0}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_3

    :goto_2
    return v2

    :cond_2
    const/4 v4, 0x3

    invoke-virtual {p1, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_4
    move v2, v3

    goto :goto_2
.end method

.method public getAreacodeInfoforContactNumber(Ljava/lang/String;)Z
    .locals 7
    .param p1, "pNumber"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v1, 0x0

    .local v1, "i":I
    const/4 v0, 0x0

    .local v0, "areacode":Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v4

    const/16 v5, 0xa

    if-lt v4, v5, :cond_4

    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x31

    if-ne v4, v5, :cond_2

    const/4 v4, 0x4

    invoke-virtual {p1, v2, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    :goto_0
    sget-boolean v4, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v4, :cond_0

    const-string v4, "LGAssistDialPhoneNumberUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " getAreacodeInfoContactNumber(String pNumber) ==> areacode : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v4, "LGAssistDialPhoneNumberUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " getAreacodeInfoContactNumber(String pNumber) ==> areacodeInfo.toString() : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    invoke-virtual {v6}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    const/4 v1, 0x0

    :goto_1
    iget-object v4, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    array-length v4, v4

    if-ge v1, v4, :cond_4

    sget-boolean v4, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v4, :cond_1

    const-string v4, "LGAssistDialPhoneNumberUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " getAreacodeInfoContactNumber(String pNumber) ==> areacodeInfo[i].getAreacode() : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    aget-object v6, v6, v1

    invoke-virtual {v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;->getAreacode()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "  :  "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    aget-object v6, v6, v1

    invoke-virtual {v6}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;->getCityname()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    iget-object v4, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->areacodeInfo:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;

    aget-object v4, v4, v1

    invoke-virtual {v4}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$AreaCode;->getAreacode()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v0}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_3

    :goto_2
    return v2

    :cond_2
    const/4 v4, 0x3

    invoke-virtual {p1, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_4
    move v2, v3

    goto :goto_2
.end method

.method public getAssistedDialCurrentCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;
    .locals 16
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v4, 0x0

    .local v4, "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    const/16 v2, 0x3ff

    .local v2, "beforeMcc":I
    :try_start_0
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v13

    const-string v14, "assist_dial_ota_mcc"

    invoke-static {v13, v14}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_0
    const-string v13, "phone"

    move-object/from16 v0, p1

    invoke-virtual {v0, v13}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/telephony/TelephonyManager;

    .local v11, "telephonyManager":Landroid/telephony/TelephonyManager;
    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v9

    .local v9, "mcc":Ljava/lang/String;
    sget-boolean v13, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v13, :cond_0

    const-string v13, "LGAssistDialPhoneNumberUtils"

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, " ***** getAssistedDialCurrentCountry() Real ==> MCC : "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    if-nez v13, :cond_1

    invoke-direct/range {p0 .. p1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->loadAllCountryForAssistedDial(Landroid/content/Context;)V

    :cond_1
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    if-eqz v13, :cond_2

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    array-length v13, v13

    if-nez v13, :cond_5

    :cond_2
    invoke-direct/range {p0 .. p1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->reCreateReferenceCountryList(Landroid/content/Context;)V

    invoke-direct/range {p0 .. p1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->loadAllCountryForAssistedDial(Landroid/content/Context;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    if-eqz v13, :cond_3

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    array-length v13, v13

    if-nez v13, :cond_5

    :cond_3
    sget-boolean v13, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v13, :cond_4

    const-string v13, "LGAssistDialPhoneNumberUtils"

    const-string v14, "mRefCountryList is not vaild"

    invoke-static {v13, v14}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_4
    move-object v5, v4

    .end local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .local v5, "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    :goto_1
    return-object v5

    .end local v5    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .end local v9    # "mcc":Ljava/lang/String;
    .end local v11    # "telephonyManager":Landroid/telephony/TelephonyManager;
    .restart local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    :catch_0
    move-exception v6

    .local v6, "e":Landroid/provider/Settings$SettingNotFoundException;
    invoke-virtual {v6}, Landroid/provider/Settings$SettingNotFoundException;->printStackTrace()V

    goto :goto_0

    .end local v6    # "e":Landroid/provider/Settings$SettingNotFoundException;
    .restart local v9    # "mcc":Ljava/lang/String;
    .restart local v11    # "telephonyManager":Landroid/telephony/TelephonyManager;
    :cond_5
    invoke-virtual {v11}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v13

    const/4 v14, 0x1

    if-ne v13, v14, :cond_d

    sget-boolean v13, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v13, :cond_6

    const-string v13, "LGAssistDialPhoneNumberUtils"

    const-string v14, " ***** PHONE_TYPE_GSM"

    invoke-static {v13, v14}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_6
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_2
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    array-length v13, v13

    if-ge v7, v13, :cond_a

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    aget-object v13, v13, v7

    invoke-virtual {v13}, Lcom/lge/telephony/LGReferenceCountry;->getMccCode()Ljava/lang/String;

    move-result-object v12

    .local v12, "tempMcc":Ljava/lang/String;
    const-string v13, ","

    invoke-virtual {v12, v13}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .local v1, "allMccForOneCountry":[Ljava/lang/String;
    const/4 v8, 0x0

    .local v8, "j":I
    :goto_3
    array-length v13, v1

    if-ge v8, v13, :cond_9

    aget-object v13, v1, v8

    invoke-static {v9, v13}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_8

    new-instance v4, Lcom/lge/telephony/LGReferenceCountry;

    .end local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    invoke-direct {v4}, Lcom/lge/telephony/LGReferenceCountry;-><init>()V

    .restart local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    aget-object v4, v13, v7

    if-eqz v4, :cond_7

    sget-boolean v13, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v13, :cond_7

    const-string v13, "LGAssistDialPhoneNumberUtils"

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, " ***USE MCC*** correntCountry  ===> "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getCountryName()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_7
    move-object v5, v4

    .end local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v5    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    goto :goto_1

    .end local v5    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    :cond_8
    add-int/lit8 v8, v8, 0x1

    goto :goto_3

    :cond_9
    add-int/lit8 v7, v7, 0x1

    goto :goto_2

    .end local v1    # "allMccForOneCountry":[Ljava/lang/String;
    .end local v8    # "j":I
    .end local v12    # "tempMcc":Ljava/lang/String;
    :cond_a
    const/4 v3, 0x0

    .local v3, "countrySID":I
    :try_start_1
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v13

    const-string v14, "assist_dial_ota_sid"

    invoke-static {v13, v14}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_1 .. :try_end_1} :catch_1

    move-result v3

    :goto_4
    const/4 v7, 0x0

    :goto_5
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    array-length v13, v13

    if-ge v7, v13, :cond_15

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    aget-object v13, v13, v7

    invoke-virtual {v13}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->getStart()I

    move-result v13

    if-lt v3, v13, :cond_c

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    aget-object v13, v13, v7

    invoke-virtual {v13}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->getEnd()I

    move-result v13

    if-gt v3, v13, :cond_c

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    aget-object v13, v13, v7

    invoke-virtual {v13}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->getCountryIndex()I

    move-result v10

    .local v10, "otaIndex":I
    new-instance v4, Lcom/lge/telephony/LGReferenceCountry;

    .end local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    invoke-direct {v4}, Lcom/lge/telephony/LGReferenceCountry;-><init>()V

    .restart local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    aget-object v4, v13, v10

    if-eqz v4, :cond_b

    sget-boolean v13, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v13, :cond_b

    const-string v13, "LGAssistDialPhoneNumberUtils"

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, " ***USE MCC*** correntCountry  ===> "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getCountryName()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_b
    move-object v5, v4

    .end local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v5    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    goto/16 :goto_1

    .end local v5    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .end local v10    # "otaIndex":I
    .restart local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    :catch_1
    move-exception v6

    .restart local v6    # "e":Landroid/provider/Settings$SettingNotFoundException;
    invoke-virtual {v6}, Landroid/provider/Settings$SettingNotFoundException;->printStackTrace()V

    goto :goto_4

    .end local v6    # "e":Landroid/provider/Settings$SettingNotFoundException;
    :cond_c
    add-int/lit8 v7, v7, 0x1

    goto :goto_5

    .end local v3    # "countrySID":I
    .end local v7    # "i":I
    :cond_d
    invoke-virtual {v11}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v13

    const/4 v14, 0x2

    if-ne v13, v14, :cond_15

    sget-boolean v13, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v13, :cond_e

    const-string v13, "LGAssistDialPhoneNumberUtils"

    const-string v14, " ***** PHONE_TYPE_CDMA"

    invoke-static {v13, v14}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_e
    const/4 v3, 0x0

    .restart local v3    # "countrySID":I
    :try_start_2
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v13

    const-string v14, "assist_dial_ota_sid"

    invoke-static {v13, v14}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_2
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_2 .. :try_end_2} :catch_2

    move-result v3

    :goto_6
    if-eqz v3, :cond_11

    const/4 v7, 0x0

    .restart local v7    # "i":I
    :goto_7
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    array-length v13, v13

    if-ge v7, v13, :cond_11

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    aget-object v13, v13, v7

    invoke-virtual {v13}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->getStart()I

    move-result v13

    if-lt v3, v13, :cond_10

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    aget-object v13, v13, v7

    invoke-virtual {v13}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->getEnd()I

    move-result v13

    if-gt v3, v13, :cond_10

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->countrySIDDataTable:[Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;

    aget-object v13, v13, v7

    invoke-virtual {v13}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->getCountryIndex()I

    move-result v10

    .restart local v10    # "otaIndex":I
    new-instance v4, Lcom/lge/telephony/LGReferenceCountry;

    .end local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    invoke-direct {v4}, Lcom/lge/telephony/LGReferenceCountry;-><init>()V

    .restart local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    aget-object v4, v13, v10

    if-eqz v4, :cond_f

    sget-boolean v13, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v13, :cond_f

    const-string v13, "LGAssistDialPhoneNumberUtils"

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, " ***USE SID*** correntCountry  ===> "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getCountryName()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_f
    move-object v5, v4

    .end local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v5    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    goto/16 :goto_1

    .end local v5    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .end local v7    # "i":I
    .end local v10    # "otaIndex":I
    .restart local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    :catch_2
    move-exception v6

    .restart local v6    # "e":Landroid/provider/Settings$SettingNotFoundException;
    invoke-virtual {v6}, Landroid/provider/Settings$SettingNotFoundException;->printStackTrace()V

    goto :goto_6

    .end local v6    # "e":Landroid/provider/Settings$SettingNotFoundException;
    .restart local v7    # "i":I
    :cond_10
    add-int/lit8 v7, v7, 0x1

    goto :goto_7

    .end local v7    # "i":I
    :cond_11
    const/4 v7, 0x0

    .restart local v7    # "i":I
    :goto_8
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    array-length v13, v13

    if-ge v7, v13, :cond_15

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    aget-object v13, v13, v7

    invoke-virtual {v13}, Lcom/lge/telephony/LGReferenceCountry;->getMccCode()Ljava/lang/String;

    move-result-object v12

    .restart local v12    # "tempMcc":Ljava/lang/String;
    const-string v13, ","

    invoke-virtual {v12, v13}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .restart local v1    # "allMccForOneCountry":[Ljava/lang/String;
    const/4 v8, 0x0

    .restart local v8    # "j":I
    :goto_9
    array-length v13, v1

    if-ge v8, v13, :cond_14

    aget-object v13, v1, v8

    invoke-static {v9, v13}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_13

    new-instance v4, Lcom/lge/telephony/LGReferenceCountry;

    .end local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    invoke-direct {v4}, Lcom/lge/telephony/LGReferenceCountry;-><init>()V

    .restart local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    aget-object v4, v13, v7

    if-eqz v4, :cond_12

    sget-boolean v13, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v13, :cond_12

    const-string v13, "LGAssistDialPhoneNumberUtils"

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, " ***USE MCC*** correntCountry  ===> "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getCountryName()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_12
    move-object v5, v4

    .end local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v5    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    goto/16 :goto_1

    .end local v5    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    :cond_13
    add-int/lit8 v8, v8, 0x1

    goto :goto_9

    :cond_14
    add-int/lit8 v7, v7, 0x1

    goto :goto_8

    .end local v1    # "allMccForOneCountry":[Ljava/lang/String;
    .end local v3    # "countrySID":I
    .end local v7    # "i":I
    .end local v8    # "j":I
    .end local v12    # "tempMcc":Ljava/lang/String;
    :cond_15
    move-object v5, v4

    .end local v4    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v5    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    goto/16 :goto_1
.end method

.method public getAssitedDialFinalNumberForCDMA(Ljava/lang/String;Landroid/content/Context;)Ljava/lang/String;
    .locals 5
    .param p1, "number"    # Ljava/lang/String;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_0

    const-string v2, "LGAssistDialPhoneNumberUtils"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "before Assisted Dial Number: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    invoke-virtual {p2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "assist_dial_new_number_check"

    const/4 v4, 0x0

    invoke-static {v2, v3, v4}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x7

    if-ge v2, v3, :cond_2

    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_1

    const-string v2, "LGAssistDialPhoneNumberUtils"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "after Assisted Dial Number: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    move-object v1, p1

    .end local p1    # "number":Ljava/lang/String;
    .local v1, "number":Ljava/lang/String;
    :goto_0
    return-object v1

    .end local v1    # "number":Ljava/lang/String;
    .restart local p1    # "number":Ljava/lang/String;
    :cond_2
    invoke-virtual {p0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getAssistedDialCurrentCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    .local v0, "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    if-nez v0, :cond_3

    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_3

    const-string v2, "AssistedDialPhoneNumberUtils"

    const-string v3, " ****** currentCountry ===> null "

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_3
    if-eqz v0, :cond_9

    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getNanp()Ljava/lang/String;

    move-result-object v2

    const-string v3, "1"

    invoke-static {v2, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_7

    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_4

    const-string v2, "LGAssistDialPhoneNumberUtils"

    const-string v3, " VZW NEWWORK"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_4
    invoke-direct {p0, p1, v0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->callAssistedDialSetVZWNetwork(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    :cond_5
    :goto_1
    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_6

    const-string v2, "LGAssistDialPhoneNumberUtils"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "after Assisted Dial Number: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_6
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    move-object v1, p1

    .end local p1    # "number":Ljava/lang/String;
    .restart local v1    # "number":Ljava/lang/String;
    goto :goto_0

    .end local v1    # "number":Ljava/lang/String;
    .restart local p1    # "number":Ljava/lang/String;
    :cond_7
    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_8

    const-string v2, "LGAssistDialPhoneNumberUtils"

    const-string v3, " INT NETWORK"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_8
    invoke-direct {p0, p1, v0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->callAssistedDialSetIntNetwork(Ljava/lang/String;Lcom/lge/telephony/LGReferenceCountry;Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    goto :goto_1

    :cond_9
    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_5

    const-string v2, "LGAssistDialPhoneNumberUtils"

    const-string v3, "currentCountry ===> null"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public getAssitedDialFinalNumberForGSM(Ljava/lang/String;Landroid/content/Context;)Ljava/lang/String;
    .locals 13
    .param p1, "number"    # Ljava/lang/String;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    const/4 v9, 0x0

    .local v9, "ret_val":Z
    sget-boolean v10, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v10, :cond_0

    const-string v10, "LGAssistDialPhoneNumberUtils"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "before Assisted Dial Number: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    invoke-virtual {p0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getIsAssistedDialCheck(Landroid/content/Context;)I

    move-result v0

    .local v0, "assistDialCheck":I
    const/4 v2, 0x0

    .local v2, "dialframContact":I
    if-eqz v0, :cond_1

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v10

    const/4 v11, 0x7

    if-ge v10, v11, :cond_3

    :cond_1
    sget-boolean v10, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v10, :cond_2

    const-string v10, "LGAssistDialPhoneNumberUtils"

    const-string v11, " assistDialCheck== 0 || number.length()<7 "

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v10, "LGAssistDialPhoneNumberUtils"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "after Assisted Dial Number: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    move-object v6, p1

    .end local p1    # "number":Ljava/lang/String;
    .local v6, "number":Ljava/lang/String;
    :goto_0
    return-object v6

    .end local v6    # "number":Ljava/lang/String;
    .restart local p1    # "number":Ljava/lang/String;
    :cond_3
    invoke-virtual {p0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getAssistedDialCurrentCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v1

    .local v1, "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    if-eqz v1, :cond_d

    sget-boolean v10, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v10, :cond_4

    const-string v10, "LGAssistDialPhoneNumberUtils"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, " Assited Dial for GSM  : before Number :  "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_4
    const/4 v7, 0x0

    .local v7, "ref_Idd":Ljava/lang/String;
    invoke-direct {p0, p2}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getRefCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v4

    .local v4, "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    if-eqz v4, :cond_c

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v7

    const-string v10, "LGAssistDialPhoneNumberUtils"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "before Assisted Dial ref_Idd: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v7, :cond_5

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v11

    if-lt v10, v11, :cond_5

    const/4 v10, 0x0

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v11

    invoke-virtual {p1, v10, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v7}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v10

    const/4 v11, 0x1

    if-ne v10, v11, :cond_5

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "+"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v11

    invoke-virtual {p1, v11}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v9, 0x1

    :cond_5
    :try_start_0
    invoke-virtual {p2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v10

    const-string v11, "assist_dial_from_contact"

    invoke-static {v10, v11}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_1
    const-string v10, "LGAssistDialPhoneNumberUtils"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "before Assisted Dial dialframContact: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v10, "LGAssistDialPhoneNumberUtils"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "before Assisted Dial mRefer.getIndex(): "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getIndex()I

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v10, 0x1

    if-ne v2, v10, :cond_a

    if-nez v9, :cond_a

    const/4 v8, 0x0

    .local v8, "ref_Ndd":Ljava/lang/String;
    if-eqz v4, :cond_6

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getNddPrefix()Ljava/lang/String;

    move-result-object v8

    :cond_6
    if-eqz v8, :cond_7

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v10

    const/4 v11, 0x7

    if-le v10, v11, :cond_7

    const-string v10, "LGAssistDialPhoneNumberUtils"

    const-string v11, "****** 1 "

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {p1, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v10

    const/16 v11, 0xa

    if-gt v10, v11, :cond_7

    const/4 v10, 0x0

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v11

    invoke-virtual {p1, v10, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v8}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v10

    const/4 v11, 0x1

    if-ne v10, v11, :cond_7

    const-string v10, "LGAssistDialPhoneNumberUtils"

    const-string v11, "****** 2 "

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "+"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v11

    invoke-virtual {p1, v11}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v9, 0x1

    :cond_7
    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getIndex()I

    move-result v10

    if-nez v10, :cond_a

    const-string v10, "LGAssistDialPhoneNumberUtils"

    const-string v11, "****** 3"

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v9, :cond_8

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getNumLength()Ljava/lang/String;

    move-result-object v11

    invoke-static {v11}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v11

    if-ne v10, v11, :cond_8

    const-string v10, "LGAssistDialPhoneNumberUtils"

    const-string v11, "****** 4"

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getAreacodeInfoforContactNumber(Ljava/lang/String;)Z

    move-result v10

    const/4 v11, 0x1

    if-ne v10, v11, :cond_8

    const-string v10, "LGAssistDialPhoneNumberUtils"

    const-string v11, "****** 5"

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "+"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v9, 0x1

    :cond_8
    if-nez v9, :cond_a

    const-string v10, "LGAssistDialPhoneNumberUtils"

    const-string v11, "****** 6"

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v5, 0x0

    .local v5, "mReferAreaCodeLen":I
    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getAreaCode()Ljava/lang/String;

    move-result-object v10

    if-eqz v10, :cond_9

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getAreaCode()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v5

    :cond_9
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v10

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getNumLength()Ljava/lang/String;

    move-result-object v11

    invoke-static {v11}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v11

    sub-int/2addr v11, v5

    if-ne v10, v11, :cond_a

    const-string v10, "LGAssistDialPhoneNumberUtils"

    const-string v11, "****** 7"

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "+"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getCountryCode()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v4}, Lcom/lge/telephony/LGReferenceCountry;->getAreaCode()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .end local v4    # "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    .end local v5    # "mReferAreaCodeLen":I
    .end local v7    # "ref_Idd":Ljava/lang/String;
    .end local v8    # "ref_Ndd":Ljava/lang/String;
    :cond_a
    :goto_2
    sget-boolean v10, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v10, :cond_b

    const-string v10, "LGAssistDialPhoneNumberUtils"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, " Assited Dial for GSM  : after Number :  "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_b
    invoke-virtual {p2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v10

    const-string v11, "assist_dial_from_contact"

    const/4 v12, 0x0

    invoke-static {v10, v11, v12}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const/4 v10, 0x0

    iput-object v10, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->mRefCountryList:[Lcom/lge/telephony/LGReferenceCountry;

    move-object v6, p1

    .end local p1    # "number":Ljava/lang/String;
    .restart local v6    # "number":Ljava/lang/String;
    goto/16 :goto_0

    .end local v6    # "number":Ljava/lang/String;
    .restart local v4    # "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    .restart local v7    # "ref_Idd":Ljava/lang/String;
    .restart local p1    # "number":Ljava/lang/String;
    :catch_0
    move-exception v3

    .local v3, "e":Landroid/provider/Settings$SettingNotFoundException;
    invoke-virtual {v3}, Landroid/provider/Settings$SettingNotFoundException;->printStackTrace()V

    goto/16 :goto_1

    .end local v3    # "e":Landroid/provider/Settings$SettingNotFoundException;
    :cond_c
    sget-boolean v10, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v10, :cond_a

    const-string v10, "LGAssistDialPhoneNumberUtils"

    const-string v11, "mRefer ===> null"

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .end local v4    # "mRefer":Lcom/lge/telephony/LGReferenceCountry;
    .end local v7    # "ref_Idd":Ljava/lang/String;
    :cond_d
    sget-boolean v10, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v10, :cond_a

    const-string v10, "LGAssistDialPhoneNumberUtils"

    const-string v11, "currentCountry ===> null"

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2
.end method

.method public getIsAssistedDialCheck(Landroid/content/Context;)I
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "assist_dial"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .local v0, "isAssistedDialCheck":I
    return v0
.end method

.method public isCdmaVzWMccCode(Ljava/lang/String;)Z
    .locals 6
    .param p1, "Mcc"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v4, 0x7

    new-array v1, v4, [Ljava/lang/String;

    const-string v4, "310"

    aput-object v4, v1, v3

    const-string v4, "311"

    aput-object v4, v1, v2

    const/4 v4, 0x2

    const-string v5, "312"

    aput-object v5, v1, v4

    const/4 v4, 0x3

    const-string v5, "313"

    aput-object v5, v1, v4

    const/4 v4, 0x4

    const-string v5, "314"

    aput-object v5, v1, v4

    const/4 v4, 0x5

    const-string v5, "315"

    aput-object v5, v1, v4

    const/4 v4, 0x6

    const-string v5, "316"

    aput-object v5, v1, v4

    .local v1, "vzwMcc":[Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v4, v1

    if-ge v0, v4, :cond_1

    aget-object v4, v1, v0

    invoke-static {p1, v4}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_0

    :goto_1
    return v2

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    move v2, v3

    goto :goto_1
.end method

.method public isCdmaVzWNetwork(Landroid/content/Context;)Z
    .locals 5
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getAssistedDialCurrentCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    .local v0, "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    if-nez v0, :cond_0

    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_0

    const-string v2, "isCdmaVzWNetwork"

    const-string v3, " ****** currentCountry ===> null "

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getCountryName()Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v3

    sget v4, Lcom/lge/internal/R$string;->STR_res_USA_NORMAL:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    sget-boolean v1, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v1, :cond_1

    const-string v1, "isCdmaVzWNetwork"

    const-string v2, " ****** vzw "

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    const/4 v1, 0x1

    :cond_2
    :goto_0
    return v1

    :cond_3
    sget-boolean v2, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->DBG:Z

    if-eqz v2, :cond_2

    const-string v2, "isCdmaVzWNetwork"

    const-string v3, " ****** non vzw "

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public isInternationalCdmaIdd(Landroid/content/Context;)Ljava/lang/String;
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-virtual {p0, p1}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;->getAssistedDialCurrentCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    .local v0, "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method
