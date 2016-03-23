.class public Lcom/lge/telephony/utils/AssistedDialNumberParser;
.super Ljava/lang/Object;
.source "AssistedDialNumberParser.java"


# static fields
.field static final aGroupName:[Ljava/lang/String;


# instance fields
.field convertPattern:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/utils/PatternPair;",
            ">;"
        }
    .end annotation
.end field

.field protected mDataManager:Lcom/lge/telephony/utils/AssistedDialDataManager;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v0, 0x6

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, ""

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "_G1"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "_G2"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "_G3"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "_G4"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "_G5"

    aput-object v2, v0, v1

    sput-object v0, Lcom/lge/telephony/utils/AssistedDialNumberParser;->aGroupName:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/lge/telephony/utils/AssistedDialDataManager;

    invoke-direct {v0, p1}, Lcom/lge/telephony/utils/AssistedDialDataManager;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/lge/telephony/utils/AssistedDialNumberParser;->mDataManager:Lcom/lge/telephony/utils/AssistedDialDataManager;

    return-void
.end method


# virtual methods
.method parseNumber(Ljava/lang/String;)Ljava/lang/String;
    .locals 11
    .param p1, "dialStr"    # Ljava/lang/String;

    .prologue
    const-string v8, "AssistedDial"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Entered parseNumber : dialStr "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v8, p0, Lcom/lge/telephony/utils/AssistedDialNumberParser;->mDataManager:Lcom/lge/telephony/utils/AssistedDialDataManager;

    invoke-virtual {v8}, Lcom/lge/telephony/utils/AssistedDialDataManager;->getPatternData()Ljava/util/ArrayList;

    move-result-object v5

    .local v5, "patternData":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/telephony/utils/PatternPair;>;"
    iput-object v5, p0, Lcom/lge/telephony/utils/AssistedDialNumberParser;->convertPattern:Ljava/util/ArrayList;

    if-nez v5, :cond_1

    .end local p1    # "dialStr":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object p1

    .restart local p1    # "dialStr":Ljava/lang/String;
    :cond_1
    const-string v8, "AssistedDial"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "dialStr : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", got patternData : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/lge/telephony/utils/AssistedDialNumberParser;->convertPattern:Ljava/util/ArrayList;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    .local v1, "index":I
    :goto_1
    iget-object v8, p0, Lcom/lge/telephony/utils/AssistedDialNumberParser;->convertPattern:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    if-ge v1, v8, :cond_0

    iget-object v8, p0, Lcom/lge/telephony/utils/AssistedDialNumberParser;->convertPattern:Ljava/util/ArrayList;

    invoke-virtual {v8, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/lge/telephony/utils/PatternPair;

    .local v4, "pattern":Lcom/lge/telephony/utils/PatternPair;
    const-string v8, "AssistedDial"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "parseNumber : dialStr is "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", currentPattern is "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v4}, Lcom/lge/telephony/utils/PatternPair;->getPattern()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v4}, Lcom/lge/telephony/utils/PatternPair;->getPattern()Ljava/lang/String;

    move-result-object v6

    .local v6, "sSearch":Ljava/lang/String;
    invoke-virtual {p1, v6}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_3

    invoke-virtual {v4}, Lcom/lge/telephony/utils/PatternPair;->getFormat()Ljava/lang/String;

    move-result-object v7

    .local v7, "sValue":Ljava/lang/String;
    const-string v8, "AssistedDial"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "dialStr : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", Matched Pattern : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v8, "ASIS"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_0

    const-string v8, "ASIS"

    invoke-virtual {v7, v8, p1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-static {v6}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v3

    .local v3, "numberPattern":Ljava/util/regex/Pattern;
    invoke-virtual {v3, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v2

    .local v2, "matcher":Ljava/util/regex/Matcher;
    invoke-virtual {v2}, Ljava/util/regex/Matcher;->matches()Z

    move-result v8

    if-eqz v8, :cond_2

    const/4 v0, 0x1

    .local v0, "groupIndex":I
    :goto_2
    invoke-virtual {v2}, Ljava/util/regex/Matcher;->groupCount()I

    move-result v8

    if-gt v0, v8, :cond_2

    sget-object v8, Lcom/lge/telephony/utils/AssistedDialNumberParser;->aGroupName:[Ljava/lang/String;

    aget-object v8, v8, v0

    invoke-virtual {v2, v0}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v8, v9}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .end local v0    # "groupIndex":I
    :cond_2
    move-object p1, v7

    goto/16 :goto_0

    .end local v2    # "matcher":Ljava/util/regex/Matcher;
    .end local v3    # "numberPattern":Ljava/util/regex/Pattern;
    .end local v7    # "sValue":Ljava/lang/String;
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_1
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/AssistedDialNumberParser;->mDataManager:Lcom/lge/telephony/utils/AssistedDialDataManager;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/utils/AssistedDialDataManager;->setContext(Landroid/content/Context;)V

    return-void
.end method
