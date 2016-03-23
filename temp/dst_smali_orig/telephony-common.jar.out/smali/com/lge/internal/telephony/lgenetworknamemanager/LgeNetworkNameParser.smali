.class public Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;
.super Lorg/xml/sax/helpers/DefaultHandler;
.source "LgeNetworkNameParser.java"


# static fields
.field static final DBG:Z

.field static final LOG_TAG:Ljava/lang/String; = "LgeNetworkNameParser"


# instance fields
.field private mConditions:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field private mCorrections:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field private mFixedData:Ljava/util/HashMap;
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

.field mTestMode:Z

.field private skipCorrrectionParsing:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameConstants;->DBG:Z

    sput-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->DBG:Z

    return-void
.end method

.method protected constructor <init>(Z)V
    .locals 3
    .param p1, "testMode"    # Z

    .prologue
    invoke-direct {p0}, Lorg/xml/sax/helpers/DefaultHandler;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mConditions:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mCorrections:Ljava/util/ArrayList;

    iput-boolean p1, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mTestMode:Z

    iget-boolean v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mTestMode:Z

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mFixedData:Ljava/util/HashMap;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mFixedData:Ljava/util/HashMap;

    const-string v1, "country"

    const-string v2, "ro.build.target_country"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mFixedData:Ljava/util/HashMap;

    const-string v1, "operator"

    const-string v2, "ro.build.target_operator"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mFixedData:Ljava/util/HashMap;

    const-string v1, "region"

    const-string v2, "ro.build.target_region"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->DBG:Z

    if-eqz v0, :cond_0

    const-string v0, "LgeNetworkNameParser"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mFixedData : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mFixedData:Ljava/util/HashMap;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method private needToAddFixedData(Ljava/lang/String;)Z
    .locals 2
    .param p1, "attrName"    # Ljava/lang/String;

    .prologue
    iget-boolean v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mTestMode:Z

    if-nez v0, :cond_2

    const-string v0, "country"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "operator"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "region"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_0
    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->DBG:Z

    if-eqz v0, :cond_1

    const-string v0, "LgeNetworkNameParser"

    const-string v1, "testmode is off : do not add fixed Data"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private needToSkipParsingCurReq(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 2
    .param p1, "nodeName"    # Ljava/lang/String;
    .param p2, "attrName"    # Ljava/lang/String;
    .param p3, "attrValue"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    iget-boolean v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mTestMode:Z

    if-nez v0, :cond_0

    const-string v0, "condition"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mFixedData:Ljava/util/HashMap;

    invoke-virtual {v0, p2}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mFixedData:Ljava/util/HashMap;

    invoke-virtual {v0, p2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0, p3, v1}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameUtils;->matchData(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method


# virtual methods
.method public endDocument()V
    .locals 2

    .prologue
    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->DBG:Z

    if-eqz v0, :cond_0

    const-string v0, "LgeNetworkNameParser"

    const-string v1, "End Parsing"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method protected getConditions()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mConditions:Ljava/util/ArrayList;

    return-object v0
.end method

.method protected getCorrections()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mCorrections:Ljava/util/ArrayList;

    return-object v0
.end method

.method public startDocument()V
    .locals 3

    .prologue
    sget-boolean v0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->DBG:Z

    if-eqz v0, :cond_0

    const-string v1, "LgeNetworkNameParser"

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Start Parsing(Test Mode : "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-boolean v0, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mTestMode:Z

    if-eqz v0, :cond_1

    const-string v0, "ON"

    :goto_0
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ")"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void

    :cond_1
    const-string v0, "OFF"

    goto :goto_0
.end method

.method public startElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/xml/sax/Attributes;)V
    .locals 7
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "local"    # Ljava/lang/String;
    .param p3, "nodeName"    # Ljava/lang/String;
    .param p4, "attrs"    # Lorg/xml/sax/Attributes;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .prologue
    new-instance v3, Ljava/util/HashMap;

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    .local v3, "map":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v4, "condition"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    sget-boolean v4, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->DBG:Z

    if-eqz v4, :cond_0

    const-string v4, "LgeNetworkNameParser"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[condition "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mConditions:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    add-int/lit8 v6, v6, 0x1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "] "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    const/4 v4, 0x0

    iput-boolean v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->skipCorrrectionParsing:Z

    :cond_1
    :goto_0
    const/4 v2, 0x0

    .local v2, "index":I
    :goto_1
    invoke-interface {p4}, Lorg/xml/sax/Attributes;->getLength()I

    move-result v4

    if-ge v2, v4, :cond_8

    invoke-interface {p4, v2}, Lorg/xml/sax/Attributes;->getLocalName(I)Ljava/lang/String;

    move-result-object v0

    .local v0, "attrName":Ljava/lang/String;
    invoke-interface {p4, v0}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .local v1, "attrValue":Ljava/lang/String;
    sget-boolean v4, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->DBG:Z

    if-eqz v4, :cond_2

    const-string v4, "LgeNetworkNameParser"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "  ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    invoke-direct {p0, p3, v0, v1}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->needToSkipParsingCurReq(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_6

    sget-boolean v4, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->DBG:Z

    if-eqz v4, :cond_3

    const-string v5, "LgeNetworkNameParser"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "  fixed data doesn\'t match, skip this requirement data - ["

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, "] system value : "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mFixedData:Ljava/util/HashMap;

    invoke-virtual {v4, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, ", xml value : "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, ", fixedData : "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v6, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mFixedData:Ljava/util/HashMap;

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v5, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_3
    const/4 v4, 0x1

    iput-boolean v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->skipCorrrectionParsing:Z

    .end local v0    # "attrName":Ljava/lang/String;
    .end local v1    # "attrValue":Ljava/lang/String;
    .end local v2    # "index":I
    :cond_4
    :goto_2
    return-void

    :cond_5
    const-string v4, "correction"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-boolean v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->skipCorrrectionParsing:Z

    if-nez v4, :cond_4

    sget-boolean v4, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->DBG:Z

    if-eqz v4, :cond_1

    const-string v4, "LgeNetworkNameParser"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[correction "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mCorrections:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    add-int/lit8 v6, v6, 0x1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "] "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .restart local v0    # "attrName":Ljava/lang/String;
    .restart local v1    # "attrValue":Ljava/lang/String;
    .restart local v2    # "index":I
    :cond_6
    invoke-direct {p0, v0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->needToAddFixedData(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_7

    invoke-virtual {v3, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_7
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_1

    .end local v0    # "attrName":Ljava/lang/String;
    .end local v1    # "attrValue":Ljava/lang/String;
    :cond_8
    const-string v4, "condition"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_9

    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mConditions:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_9
    const-string v4, "correction"

    invoke-virtual {p3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    iget-object v4, p0, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameParser;->mCorrections:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2
.end method
