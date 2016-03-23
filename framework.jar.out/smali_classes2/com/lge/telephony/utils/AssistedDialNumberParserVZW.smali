.class public Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;
.super Lcom/lge/telephony/utils/AssistedDialNumberParser;
.source "AssistedDialNumberParserVZW.java"


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field private mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 7
    const-class v0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->$assertionsDisabled:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 12
    invoke-direct {p0, p1}, Lcom/lge/telephony/utils/AssistedDialNumberParser;-><init>(Landroid/content/Context;)V

    .line 9
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    .line 13
    const-string v0, "AssistedDial"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Current AssistDialNumberParser is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 14
    invoke-static {p1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    .line 16
    sget-boolean v0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 17
    :cond_0
    return-void
.end method

.method private postParse(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p1, "parsedStr"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x1

    .line 66
    const-string v2, "_OR"

    invoke-virtual {p1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 79
    .end local p1    # "parsedStr":Ljava/lang/String;
    :goto_0
    return-object p1

    .line 70
    .restart local p1    # "parsedStr":Ljava/lang/String;
    :cond_0
    const-string v2, "_OR|\\|"

    invoke-virtual {p1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 73
    .local v1, "strArray":[Ljava/lang/String;
    aget-object v2, v1, v5

    aget-object v3, v1, v5

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, -0xa

    aget-object v4, v1, v5

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    add-int/lit8 v4, v4, -0x7

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 75
    .local v0, "areaCode":Ljava/lang/String;
    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mDataManager:Lcom/lge/telephony/utils/AssistedDialDataManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialDataManager;->getAreaCodeMap()Ljava/util/HashMap;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 76
    aget-object p1, v1, v5

    goto :goto_0

    .line 79
    :cond_1
    const/4 v2, 0x2

    aget-object p1, v1, v2

    goto :goto_0
.end method


# virtual methods
.method parseNumber(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "dialStr"    # Ljava/lang/String;

    .prologue
    .line 21
    const-string v1, "AssistedDial"

    const-string v2, "parseNumber in AssistDialNumberParserVZW"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 23
    const-string v1, "cdma"

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentRadioTech()Ljava/lang/String;

    move-result-object v2

    if-ne v1, v2, :cond_5

    const-string v1, "roaming"

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentRoamingStatus()Ljava/lang/String;

    move-result-object v2

    if-ne v1, v2, :cond_5

    const-string v1, "contact"

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentDialingPoint()Ljava/lang/String;

    move-result-object v2

    if-ne v1, v2, :cond_5

    .line 27
    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefNDDPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaNDDPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 28
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefNumLength()Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    iget-object v3, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v3}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefNDDPrefix()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/2addr v2, v3

    if-ne v1, v2, :cond_3

    .line 30
    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountryCode()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountryCode()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 31
    const-string v1, "AssistedDial"

    const-string v2, "Case 3-1"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 62
    .end local p1    # "dialStr":Ljava/lang/String;
    :goto_0
    return-object p1

    .line 35
    .restart local p1    # "dialStr":Ljava/lang/String;
    :cond_1
    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefNDDPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 36
    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefNDDPrefix()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v3}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaIDDPrefix()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v3}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountryCode()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 40
    .local v0, "newStr":Ljava/lang/String;
    :goto_1
    const-string v1, "AssistedDial"

    const-string v2, "Case 3-2"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object p1, v0

    .line 41
    goto :goto_0

    .line 38
    .end local v0    # "newStr":Ljava/lang/String;
    :cond_2
    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaNDDPrefix()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v3}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaIDDPrefix()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v3}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountryCode()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .restart local v0    # "newStr":Ljava/lang/String;
    goto :goto_1

    .line 47
    .end local v0    # "newStr":Ljava/lang/String;
    :cond_3
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefNumLength()Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-ne v1, v2, :cond_4

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountryCode()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountryCode()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    .line 49
    const-string v1, "AssistedDial"

    const-string v2, "Case 4"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 50
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaIDDPrefix()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountryCode()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto/16 :goto_0

    .line 55
    :cond_4
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefNumLength()Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    iget-object v3, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v3}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefAreaCode()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    sub-int/2addr v2, v3

    if-ne v1, v2, :cond_5

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountryCode()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountryCode()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    .line 57
    const-string v1, "AssistedDial"

    const-string v2, "Case 5"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 58
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaIDDPrefix()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountryCode()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->mStateMgr:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefAreaCode()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto/16 :goto_0

    .line 62
    :cond_5
    invoke-super {p0, p1}, Lcom/lge/telephony/utils/AssistedDialNumberParser;->parseNumber(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/lge/telephony/utils/AssistedDialNumberParserVZW;->postParse(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto/16 :goto_0
.end method
