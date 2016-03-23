.class public Lcom/lge/telephony/utils/AssistedDialDataManager;
.super Ljava/lang/Object;
.source "AssistedDialDataManager.java"


# static fields
.field static final AREACODEPATH:Ljava/lang/String; = "/etc/AreaCode.xml"

.field static final PATTERNPATH:Ljava/lang/String; = "/etc/Patterns.xml"

.field static final SIDPATH:Ljava/lang/String; = "/etc/SIDRange.xml"


# instance fields
.field dataParser:Lcom/lge/telephony/utils/AssistedDialDataParser;

.field private mAreaCodeMap:Ljava/util/HashMap;
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

.field mNode:Lorg/w3c/dom/Node;

.field private mSIDTable:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/utils/SIDRangeType;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->mAreaCodeMap:Ljava/util/HashMap;

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->mSIDTable:Ljava/util/ArrayList;

    invoke-direct {p0}, Lcom/lge/telephony/utils/AssistedDialDataManager;->initSIDTable()V

    new-instance v0, Lcom/lge/telephony/utils/AssistedDialDataParser;

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->mSIDTable:Ljava/util/ArrayList;

    invoke-direct {v0, p1, v1}, Lcom/lge/telephony/utils/AssistedDialDataParser;-><init>(Landroid/content/Context;Ljava/util/ArrayList;)V

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->dataParser:Lcom/lge/telephony/utils/AssistedDialDataParser;

    invoke-virtual {p0}, Lcom/lge/telephony/utils/AssistedDialDataManager;->initAreaCodeInfo()V

    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->dataParser:Lcom/lge/telephony/utils/AssistedDialDataParser;

    const-string v1, "/etc/Patterns.xml"

    invoke-virtual {v0, v1}, Lcom/lge/telephony/utils/AssistedDialDataParser;->parsePatternsXml(Ljava/lang/String;)Lorg/w3c/dom/Node;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->mNode:Lorg/w3c/dom/Node;

    const-string v0, "AssistedDial"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "parseXml returned "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->mNode:Lorg/w3c/dom/Node;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private initSIDTable()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->mSIDTable:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    const-string v0, "/etc/SIDRange.xml"

    invoke-static {v0}, Lcom/lge/telephony/utils/AssistedDialDataParser;->getSIDTable(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->mSIDTable:Ljava/util/ArrayList;

    :cond_0
    return-void
.end method


# virtual methods
.method getAreaCodeMap()Ljava/util/HashMap;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->mAreaCodeMap:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/HashMap;

    return-object v0
.end method

.method getPatternData()Ljava/util/ArrayList;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/utils/PatternPair;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->dataParser:Lcom/lge/telephony/utils/AssistedDialDataParser;

    iget-object v1, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->mNode:Lorg/w3c/dom/Node;

    invoke-virtual {v0, v1}, Lcom/lge/telephony/utils/AssistedDialDataParser;->getPatternMap(Lorg/w3c/dom/Node;)Ljava/util/ArrayList;

    move-result-object v0

    return-object v0
.end method

.method initAreaCodeInfo()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->mAreaCodeMap:Ljava/util/HashMap;

    if-nez v0, :cond_0

    const-string v0, "/etc/AreaCode.xml"

    invoke-static {v0}, Lcom/lge/telephony/utils/AssistedDialDataParser;->getAreaCodeMap(Ljava/lang/String;)Ljava/util/HashMap;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->mAreaCodeMap:Ljava/util/HashMap;

    :cond_0
    return-void
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialDataManager;->dataParser:Lcom/lge/telephony/utils/AssistedDialDataParser;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/utils/AssistedDialDataParser;->setContext(Landroid/content/Context;)V

    return-void
.end method
