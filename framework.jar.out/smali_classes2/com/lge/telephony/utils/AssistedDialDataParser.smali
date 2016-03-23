.class public Lcom/lge/telephony/utils/AssistedDialDataParser;
.super Ljava/lang/Object;
.source "AssistedDialDataParser.java"


# static fields
.field static final synthetic $assertionsDisabled:Z

.field static final mMinCapacity:I = 0xa


# instance fields
.field mLastAssistDialProperty:Ljava/lang/String;

.field mLastDialingPoint:Ljava/lang/String;

.field mLastRadioTech:Ljava/lang/String;

.field mLastRoamingStatus:Ljava/lang/String;

.field mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

.field maPatternList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/utils/PatternPair;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 26
    const-class v0, Lcom/lge/telephony/utils/AssistedDialDataParser;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lcom/lge/telephony/utils/AssistedDialDataParser;->$assertionsDisabled:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/util/ArrayList;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/utils/SIDRangeType;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 36
    .local p2, "table":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/telephony/utils/SIDRangeType;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    const-string v0, ""

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastRadioTech:Ljava/lang/String;

    .line 38
    const-string v0, ""

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastRoamingStatus:Ljava/lang/String;

    .line 39
    const-string v0, ""

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastDialingPoint:Ljava/lang/String;

    .line 40
    const-string v0, ""

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastAssistDialProperty:Ljava/lang/String;

    .line 41
    invoke-static {p1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    .line 42
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v0, p2}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->setSIDTable(Ljava/util/ArrayList;)V

    .line 43
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->maPatternList:Ljava/util/ArrayList;

    const/16 v1, 0xa

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->ensureCapacity(I)V

    .line 44
    return-void
.end method

.method private backupCurrentState(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "radioTech"    # Ljava/lang/String;
    .param p2, "roamStatus"    # Ljava/lang/String;
    .param p3, "dialingPoint"    # Ljava/lang/String;
    .param p4, "assistDialProp"    # Ljava/lang/String;

    .prologue
    .line 87
    iput-object p1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastRadioTech:Ljava/lang/String;

    .line 88
    iput-object p2, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastRoamingStatus:Ljava/lang/String;

    .line 89
    iput-object p3, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastDialingPoint:Ljava/lang/String;

    .line 90
    iput-object p4, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastAssistDialProperty:Ljava/lang/String;

    .line 91
    return-void
.end method

.method public static getAreaCodeMap(Ljava/lang/String;)Ljava/util/HashMap;
    .locals 11
    .param p0, "sFileName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v10, 0x1

    .line 162
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 164
    .local v0, "AreaCodeMap":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v7, "AssistedDial"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "try to parseXml : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 166
    :try_start_0
    invoke-static {}, Lorg/xmlpull/v1/XmlPullParserFactory;->newInstance()Lorg/xmlpull/v1/XmlPullParserFactory;

    move-result-object v3

    .line 167
    .local v3, "factory":Lorg/xmlpull/v1/XmlPullParserFactory;
    const/4 v7, 0x1

    invoke-virtual {v3, v7}, Lorg/xmlpull/v1/XmlPullParserFactory;->setNamespaceAware(Z)V

    .line 168
    invoke-virtual {v3}, Lorg/xmlpull/v1/XmlPullParserFactory;->newPullParser()Lorg/xmlpull/v1/XmlPullParser;

    move-result-object v6

    .line 169
    .local v6, "xpp":Lorg/xmlpull/v1/XmlPullParser;
    new-instance v5, Ljava/io/FileReader;

    invoke-direct {v5, p0}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    .line 170
    .local v5, "reader":Ljava/io/Reader;
    invoke-interface {v6, v5}, Lorg/xmlpull/v1/XmlPullParser;->setInput(Ljava/io/Reader;)V

    .line 171
    invoke-interface {v6}, Lorg/xmlpull/v1/XmlPullParser;->getEventType()I

    move-result v2

    .line 173
    .local v2, "eventType":I
    :goto_0
    if-eq v10, v2, :cond_1

    .line 174
    packed-switch v2, :pswitch_data_0

    .line 197
    :cond_0
    :goto_1
    :pswitch_0
    invoke-interface {v6}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v2

    goto :goto_0

    .line 176
    :pswitch_1
    const-string v7, "AssistedDial"

    const-string v8, "Start AreaCode.xml doc"

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 200
    .end local v2    # "eventType":I
    .end local v3    # "factory":Lorg/xmlpull/v1/XmlPullParserFactory;
    .end local v5    # "reader":Ljava/io/Reader;
    .end local v6    # "xpp":Lorg/xmlpull/v1/XmlPullParser;
    :catch_0
    move-exception v7

    .line 208
    :cond_1
    :goto_2
    return-object v0

    .line 183
    .restart local v2    # "eventType":I
    .restart local v3    # "factory":Lorg/xmlpull/v1/XmlPullParserFactory;
    .restart local v5    # "reader":Ljava/io/Reader;
    .restart local v6    # "xpp":Lorg/xmlpull/v1/XmlPullParser;
    :pswitch_2
    const-string v7, "area"

    invoke-interface {v6}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_0

    .line 184
    const/4 v7, 0x0

    const-string v8, "number"

    invoke-interface {v6, v7, v8}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 185
    .local v4, "number":Ljava/lang/String;
    const/4 v7, 0x0

    const-string v8, "city"

    invoke-interface {v6, v7, v8}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 188
    .local v1, "city":Ljava/lang/String;
    invoke-virtual {v0, v4, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2

    goto :goto_1

    .line 202
    .end local v1    # "city":Ljava/lang/String;
    .end local v2    # "eventType":I
    .end local v3    # "factory":Lorg/xmlpull/v1/XmlPullParserFactory;
    .end local v4    # "number":Ljava/lang/String;
    .end local v5    # "reader":Ljava/io/Reader;
    .end local v6    # "xpp":Lorg/xmlpull/v1/XmlPullParser;
    :catch_1
    move-exception v7

    goto :goto_2

    .line 204
    :catch_2
    move-exception v7

    goto :goto_2

    .line 174
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method public static getSIDTable(Ljava/lang/String;)Ljava/util/ArrayList;
    .locals 14
    .param p0, "sFileName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/utils/SIDRangeType;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v13, 0x1

    .line 240
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 242
    .local v0, "array":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/telephony/utils/SIDRangeType;>;"
    const-string v10, "AssistedDial"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "try to parseXml : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 244
    :try_start_0
    invoke-static {}, Lorg/xmlpull/v1/XmlPullParserFactory;->newInstance()Lorg/xmlpull/v1/XmlPullParserFactory;

    move-result-object v5

    .line 245
    .local v5, "factory":Lorg/xmlpull/v1/XmlPullParserFactory;
    const/4 v10, 0x1

    invoke-virtual {v5, v10}, Lorg/xmlpull/v1/XmlPullParserFactory;->setNamespaceAware(Z)V

    .line 246
    invoke-virtual {v5}, Lorg/xmlpull/v1/XmlPullParserFactory;->newPullParser()Lorg/xmlpull/v1/XmlPullParser;

    move-result-object v9

    .line 247
    .local v9, "xpp":Lorg/xmlpull/v1/XmlPullParser;
    new-instance v7, Ljava/io/FileReader;

    invoke-direct {v7, p0}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    .line 248
    .local v7, "reader":Ljava/io/Reader;
    invoke-interface {v9, v7}, Lorg/xmlpull/v1/XmlPullParser;->setInput(Ljava/io/Reader;)V

    .line 249
    invoke-interface {v9}, Lorg/xmlpull/v1/XmlPullParser;->getEventType()I

    move-result v3

    .line 251
    .local v3, "eventType":I
    :goto_0
    if-eq v13, v3, :cond_1

    .line 252
    packed-switch v3, :pswitch_data_0

    .line 277
    :cond_0
    :goto_1
    :pswitch_0
    invoke-interface {v9}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v3

    goto :goto_0

    .line 254
    :pswitch_1
    const-string v10, "AssistedDial"

    const-string v11, "Start AreaCode.xml doc"

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 280
    .end local v3    # "eventType":I
    .end local v5    # "factory":Lorg/xmlpull/v1/XmlPullParserFactory;
    .end local v7    # "reader":Ljava/io/Reader;
    .end local v9    # "xpp":Lorg/xmlpull/v1/XmlPullParser;
    :catch_0
    move-exception v10

    .line 288
    :cond_1
    :goto_2
    return-object v0

    .line 261
    .restart local v3    # "eventType":I
    .restart local v5    # "factory":Lorg/xmlpull/v1/XmlPullParserFactory;
    .restart local v7    # "reader":Ljava/io/Reader;
    .restart local v9    # "xpp":Lorg/xmlpull/v1/XmlPullParser;
    :pswitch_2
    const-string v10, "sidrange"

    invoke-interface {v9}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_0

    .line 262
    const/4 v10, 0x0

    const-string v11, "index"

    invoke-interface {v9, v10, v11}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v6

    .line 263
    .local v6, "index":I
    const/4 v10, 0x0

    const-string v11, "countryIndex"

    invoke-interface {v9, v10, v11}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v1

    .line 264
    .local v1, "countryIndex":I
    const/4 v10, 0x0

    const-string v11, "start"

    invoke-interface {v9, v10, v11}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v8

    .line 265
    .local v8, "start":I
    const/4 v10, 0x0

    const-string v11, "end"

    invoke-interface {v9, v10, v11}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v2

    .line 268
    .local v2, "end":I
    new-instance v10, Lcom/lge/telephony/utils/SIDRangeType;

    invoke-direct {v10, v6, v1, v8, v2}, Lcom/lge/telephony/utils/SIDRangeType;-><init>(IIII)V

    invoke-virtual {v0, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2

    goto :goto_1

    .line 282
    .end local v1    # "countryIndex":I
    .end local v2    # "end":I
    .end local v3    # "eventType":I
    .end local v5    # "factory":Lorg/xmlpull/v1/XmlPullParserFactory;
    .end local v6    # "index":I
    .end local v7    # "reader":Ljava/io/Reader;
    .end local v8    # "start":I
    .end local v9    # "xpp":Lorg/xmlpull/v1/XmlPullParser;
    :catch_1
    move-exception v4

    .line 283
    .local v4, "ex2":Ljava/io/FileNotFoundException;
    const-string v10, "AssistedDial"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Failed to open "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .line 284
    .end local v4    # "ex2":Ljava/io/FileNotFoundException;
    :catch_2
    move-exception v10

    goto :goto_2

    .line 252
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method private preParsePattern(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "sPattern"    # Ljava/lang/String;

    .prologue
    .line 94
    const-string v0, "AssistedDial"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "preParsePattern start for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 95
    const-string v0, "_OTA_IDD"

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaIDDPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 96
    const-string v0, "_OTA_NDD"

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaNDDPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 97
    const-string v0, "_OTA_CC"

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOtaCountryCode()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 98
    const-string v0, "_REF_IDD"

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefIDDPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 99
    const-string v0, "_REF_NDD"

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefNDDPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 100
    const-string v0, "_REF_CC"

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefCountryCode()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 101
    const-string v0, "_REF_NUMLEN"

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefNumLength()Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 102
    const-string v0, "_REF_PNLEN"

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefPNLength()Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 103
    const-string v0, "_REF_AC"

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getRefAreaCode()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 104
    return-object p1
.end method


# virtual methods
.method checkStateChanged()Z
    .locals 2

    .prologue
    .line 80
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastRadioTech:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->isRadioTechChanged(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastRoamingStatus:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->isRoamingStatusChanged(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastDialingPoint:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->isDialingPointChanged(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mLastAssistDialProperty:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->isAssistDialPropertyChanged(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method getPatternMap(Lorg/w3c/dom/Node;)Ljava/util/ArrayList;
    .locals 14
    .param p1, "operatorNode"    # Lorg/w3c/dom/Node;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/w3c/dom/Node;",
            ")",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/utils/PatternPair;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v13, 0x1

    const/4 v12, 0x0

    .line 108
    const/4 v6, 0x0

    .line 109
    .local v6, "nodeList":Lorg/w3c/dom/NodeList;
    const/4 v2, 0x0

    .line 110
    .local v2, "curNode":Lorg/w3c/dom/Node;
    if-nez p1, :cond_0

    .line 111
    const/4 v9, 0x0

    .line 158
    .end local p1    # "operatorNode":Lorg/w3c/dom/Node;
    :goto_0
    return-object v9

    .line 116
    .restart local p1    # "operatorNode":Lorg/w3c/dom/Node;
    :cond_0
    iget-object v9, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v9}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentRadioTech()Ljava/lang/String;

    move-result-object v3

    .line 117
    .local v3, "curRadioTech":Ljava/lang/String;
    iget-object v9, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v9}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentRoamingStatus()Ljava/lang/String;

    move-result-object v4

    .line 118
    .local v4, "curRoamingStatus":Ljava/lang/String;
    iget-object v9, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v9}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentDialingPoint()Ljava/lang/String;

    move-result-object v1

    .line 119
    .local v1, "curDialingPoint":Ljava/lang/String;
    iget-object v9, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v9}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getCurrentAssistDialProperty()Ljava/lang/String;

    move-result-object v0

    .line 121
    .local v0, "curAssistDialProperty":Ljava/lang/String;
    const-string v9, "AssistedDial"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "tech : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", roam : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", point : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", curProp : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 123
    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialDataParser;->checkStateChanged()Z

    move-result v9

    if-nez v9, :cond_1

    .line 124
    iget-object v9, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->maPatternList:Ljava/util/ArrayList;

    goto :goto_0

    .line 127
    :cond_1
    check-cast p1, Lorg/w3c/dom/Element;

    .end local p1    # "operatorNode":Lorg/w3c/dom/Node;
    invoke-interface {p1, v3}, Lorg/w3c/dom/Element;->getElementsByTagName(Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object v6

    .line 128
    sget-boolean v9, Lcom/lge/telephony/utils/AssistedDialDataParser;->$assertionsDisabled:Z

    if-nez v9, :cond_2

    invoke-interface {v6}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v9

    if-eq v13, v9, :cond_2

    new-instance v9, Ljava/lang/AssertionError;

    invoke-direct {v9}, Ljava/lang/AssertionError;-><init>()V

    throw v9

    .line 129
    :cond_2
    invoke-interface {v6, v12}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v2

    .line 131
    check-cast v2, Lorg/w3c/dom/Element;

    .end local v2    # "curNode":Lorg/w3c/dom/Node;
    invoke-interface {v2, v4}, Lorg/w3c/dom/Element;->getElementsByTagName(Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object v6

    .line 132
    sget-boolean v9, Lcom/lge/telephony/utils/AssistedDialDataParser;->$assertionsDisabled:Z

    if-nez v9, :cond_3

    invoke-interface {v6}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v9

    if-eq v13, v9, :cond_3

    new-instance v9, Ljava/lang/AssertionError;

    invoke-direct {v9}, Ljava/lang/AssertionError;-><init>()V

    throw v9

    .line 133
    :cond_3
    invoke-interface {v6, v12}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v2

    .line 135
    .restart local v2    # "curNode":Lorg/w3c/dom/Node;
    check-cast v2, Lorg/w3c/dom/Element;

    .end local v2    # "curNode":Lorg/w3c/dom/Node;
    invoke-interface {v2, v0}, Lorg/w3c/dom/Element;->getElementsByTagName(Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object v6

    .line 136
    sget-boolean v9, Lcom/lge/telephony/utils/AssistedDialDataParser;->$assertionsDisabled:Z

    if-nez v9, :cond_4

    invoke-interface {v6}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v9

    if-eq v13, v9, :cond_4

    new-instance v9, Ljava/lang/AssertionError;

    invoke-direct {v9}, Ljava/lang/AssertionError;-><init>()V

    throw v9

    .line 137
    :cond_4
    invoke-interface {v6, v12}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v2

    .line 139
    .restart local v2    # "curNode":Lorg/w3c/dom/Node;
    check-cast v2, Lorg/w3c/dom/Element;

    .end local v2    # "curNode":Lorg/w3c/dom/Node;
    invoke-interface {v2, v1}, Lorg/w3c/dom/Element;->getElementsByTagName(Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object v6

    .line 140
    sget-boolean v9, Lcom/lge/telephony/utils/AssistedDialDataParser;->$assertionsDisabled:Z

    if-nez v9, :cond_5

    invoke-interface {v6}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v9

    if-eq v13, v9, :cond_5

    new-instance v9, Ljava/lang/AssertionError;

    invoke-direct {v9}, Ljava/lang/AssertionError;-><init>()V

    throw v9

    .line 141
    :cond_5
    invoke-interface {v6, v12}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v2

    .line 143
    .restart local v2    # "curNode":Lorg/w3c/dom/Node;
    const-string v9, "AssistedDial"

    const-string v10, "reached <pattern>"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v9, v2

    .line 144
    check-cast v9, Lorg/w3c/dom/Element;

    const-string v10, "pattern"

    invoke-interface {v9, v10}, Lorg/w3c/dom/Element;->getElementsByTagName(Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object v6

    .line 145
    iget-object v9, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->maPatternList:Ljava/util/ArrayList;

    invoke-virtual {v9}, Ljava/util/ArrayList;->clear()V

    .line 146
    const/4 v5, 0x0

    .local v5, "index":I
    :goto_1
    invoke-interface {v6}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v9

    if-ge v5, v9, :cond_6

    .line 147
    invoke-interface {v6, v5}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v9

    check-cast v9, Lorg/w3c/dom/Element;

    const-string v10, "search"

    invoke-interface {v9, v10}, Lorg/w3c/dom/Element;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 148
    .local v8, "sSearch":Ljava/lang/String;
    invoke-interface {v6, v5}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v9

    check-cast v9, Lorg/w3c/dom/Element;

    const-string v10, "format"

    invoke-interface {v9, v10}, Lorg/w3c/dom/Element;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 152
    .local v7, "sFormat":Ljava/lang/String;
    iget-object v9, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->maPatternList:Ljava/util/ArrayList;

    new-instance v10, Lcom/lge/telephony/utils/PatternPair;

    invoke-direct {p0, v8}, Lcom/lge/telephony/utils/AssistedDialDataParser;->preParsePattern(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-direct {p0, v7}, Lcom/lge/telephony/utils/AssistedDialDataParser;->preParsePattern(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-direct {v10, v11, v12}, Lcom/lge/telephony/utils/PatternPair;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v9, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 146
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 157
    .end local v7    # "sFormat":Ljava/lang/String;
    .end local v8    # "sSearch":Ljava/lang/String;
    :cond_6
    invoke-direct {p0, v3, v4, v1, v0}, Lcom/lge/telephony/utils/AssistedDialDataParser;->backupCurrentState(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 158
    iget-object v9, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->maPatternList:Ljava/util/ArrayList;

    goto/16 :goto_0
.end method

.method public parsePatternsXml(Ljava/lang/String;)Lorg/w3c/dom/Node;
    .locals 13
    .param p1, "sFileName"    # Ljava/lang/String;

    .prologue
    const/4 v10, 0x0

    .line 51
    const-string v9, "AssistedDial"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "try to parseXml : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v9, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 54
    :try_start_0
    invoke-static {}, Ljavax/xml/parsers/DocumentBuilderFactory;->newInstance()Ljavax/xml/parsers/DocumentBuilderFactory;

    move-result-object v4

    .line 55
    .local v4, "factory":Ljavax/xml/parsers/DocumentBuilderFactory;
    invoke-virtual {v4}, Ljavax/xml/parsers/DocumentBuilderFactory;->newDocumentBuilder()Ljavax/xml/parsers/DocumentBuilder;

    move-result-object v1

    .line 56
    .local v1, "builder":Ljavax/xml/parsers/DocumentBuilder;
    new-instance v9, Ljava/io/File;

    invoke-direct {v9, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v9}, Ljavax/xml/parsers/DocumentBuilder;->parse(Ljava/io/File;)Lorg/w3c/dom/Document;

    move-result-object v2

    .line 57
    .local v2, "doc":Lorg/w3c/dom/Document;
    invoke-interface {v2}, Lorg/w3c/dom/Document;->getDocumentElement()Lorg/w3c/dom/Element;

    move-result-object v8

    .line 58
    .local v8, "root":Lorg/w3c/dom/Element;
    const-string v9, "operator"

    invoke-interface {v8, v9}, Lorg/w3c/dom/Element;->getElementsByTagName(Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object v7

    .line 59
    .local v7, "nodeList":Lorg/w3c/dom/NodeList;
    const/4 v6, 0x0

    .line 60
    .local v6, "node":Lorg/w3c/dom/Node;
    const/4 v5, 0x0

    .local v5, "index":I
    :goto_0
    invoke-interface {v7}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v9

    if-ge v5, v9, :cond_0

    .line 61
    invoke-interface {v7, v5}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v6

    .line 62
    iget-object v9, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v9}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->getOperatorName()Ljava/lang/String;

    move-result-object v11

    move-object v0, v6

    check-cast v0, Lorg/w3c/dom/Element;

    move-object v9, v0

    const-string v12, "operator"

    invoke-interface {v9, v12}, Lorg/w3c/dom/Element;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v11, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 66
    :cond_0
    if-nez v6, :cond_2

    .line 67
    const-string v9, "AssistedDial"

    const-string v11, "Failed to load xml!! Something WRONG!!"

    invoke-static {v9, v11}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    move-object v6, v10

    .line 75
    .end local v1    # "builder":Ljavax/xml/parsers/DocumentBuilder;
    .end local v2    # "doc":Lorg/w3c/dom/Document;
    .end local v4    # "factory":Ljavax/xml/parsers/DocumentBuilderFactory;
    .end local v5    # "index":I
    .end local v6    # "node":Lorg/w3c/dom/Node;
    .end local v7    # "nodeList":Lorg/w3c/dom/NodeList;
    .end local v8    # "root":Lorg/w3c/dom/Element;
    :goto_1
    return-object v6

    .line 60
    .restart local v1    # "builder":Ljavax/xml/parsers/DocumentBuilder;
    .restart local v2    # "doc":Lorg/w3c/dom/Document;
    .restart local v4    # "factory":Ljavax/xml/parsers/DocumentBuilderFactory;
    .restart local v5    # "index":I
    .restart local v6    # "node":Lorg/w3c/dom/Node;
    .restart local v7    # "nodeList":Lorg/w3c/dom/NodeList;
    .restart local v8    # "root":Lorg/w3c/dom/Element;
    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 70
    :cond_2
    const-string v9, "AssistedDial"

    const-string/jumbo v11, "xml has been parsed"

    invoke-static {v9, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 72
    .end local v1    # "builder":Ljavax/xml/parsers/DocumentBuilder;
    .end local v2    # "doc":Lorg/w3c/dom/Document;
    .end local v4    # "factory":Ljavax/xml/parsers/DocumentBuilderFactory;
    .end local v5    # "index":I
    .end local v6    # "node":Lorg/w3c/dom/Node;
    .end local v7    # "nodeList":Lorg/w3c/dom/NodeList;
    .end local v8    # "root":Lorg/w3c/dom/Element;
    :catch_0
    move-exception v3

    .line 73
    .local v3, "e":Ljava/lang/Exception;
    const-string v9, "AssistedDial"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Exception "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "Has occured!!"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v9, v11}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 74
    invoke-virtual {v3}, Ljava/lang/Exception;->printStackTrace()V

    move-object v6, v10

    .line 75
    goto :goto_1
.end method

.method public parseXmlWithXmlPullParser(Ljava/lang/String;)Ljava/lang/Object;
    .locals 9
    .param p1, "sFileName"    # Ljava/lang/String;

    .prologue
    const/4 v8, 0x1

    .line 212
    const-string v5, "AssistedDial"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "try to parseXml : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 214
    :try_start_0
    invoke-static {}, Lorg/xmlpull/v1/XmlPullParserFactory;->newInstance()Lorg/xmlpull/v1/XmlPullParserFactory;

    move-result-object v1

    .line 215
    .local v1, "factory":Lorg/xmlpull/v1/XmlPullParserFactory;
    const/4 v5, 0x1

    invoke-virtual {v1, v5}, Lorg/xmlpull/v1/XmlPullParserFactory;->setNamespaceAware(Z)V

    .line 216
    invoke-virtual {v1}, Lorg/xmlpull/v1/XmlPullParserFactory;->newPullParser()Lorg/xmlpull/v1/XmlPullParser;

    move-result-object v4

    .line 217
    .local v4, "xpp":Lorg/xmlpull/v1/XmlPullParser;
    new-instance v2, Ljava/io/FileReader;

    invoke-direct {v2, p1}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    .line 218
    .local v2, "reader":Ljava/io/Reader;
    invoke-interface {v4, v2}, Lorg/xmlpull/v1/XmlPullParser;->setInput(Ljava/io/Reader;)V

    .line 219
    invoke-interface {v4}, Lorg/xmlpull/v1/XmlPullParser;->getEventType()I

    move-result v0

    .local v0, "eventType":I
    :goto_0
    if-eq v8, v0, :cond_0

    .line 220
    packed-switch v0, :pswitch_data_0

    .line 219
    :goto_1
    :pswitch_0
    invoke-interface {v4}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v0

    goto :goto_0

    .line 223
    :pswitch_1
    invoke-interface {v4}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v3

    .line 224
    .local v3, "tagName":Ljava/lang/String;
    const-string v5, "AssistedDial"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "START_TAG : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_1

    .line 229
    .end local v0    # "eventType":I
    .end local v1    # "factory":Lorg/xmlpull/v1/XmlPullParserFactory;
    .end local v2    # "reader":Ljava/io/Reader;
    .end local v3    # "tagName":Ljava/lang/String;
    .end local v4    # "xpp":Lorg/xmlpull/v1/XmlPullParser;
    :catch_0
    move-exception v5

    .line 236
    :cond_0
    :goto_2
    const/4 v5, 0x0

    return-object v5

    .line 233
    :catch_1
    move-exception v5

    goto :goto_2

    .line 231
    :catch_2
    move-exception v5

    goto :goto_2

    .line 220
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 47
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataParser;->mStateManager:Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/utils/AssistedDialPhoneStateManager;->setContext(Landroid/content/Context;)V

    .line 48
    return-void
.end method
