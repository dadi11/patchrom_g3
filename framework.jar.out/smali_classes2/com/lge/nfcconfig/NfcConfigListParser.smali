.class public Lcom/lge/nfcconfig/NfcConfigListParser;
.super Ljava/lang/Object;
.source "NfcConfigListParser.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    }
.end annotation


# static fields
.field private static final ATTR_NAME_COUNTRY:Ljava/lang/String; = "country"

.field private static final ATTR_NAME_DEVICE:Ljava/lang/String; = "device"

.field private static final ATTR_NAME_OPERATOR:Ljava/lang/String; = "operator"

.field private static final ATTR_NAME_TARGETMODEL:Ljava/lang/String; = "targetdevice"

.field private static final DBG:Z = false

.field private static final FILE_PATH_COMMON_PROFILE:Ljava/lang/String;

.field private static final FILE_PATH_DEFAULT_PROFILE:Ljava/lang/String;

.field private static final NFC_CONFIG_FILE_POSTFIX:Ljava/lang/String; = ".xml"

.field private static final NFC_CONFIG_FILE_PREFIX:Ljava/lang/String; = "config"

.field private static final TAG:Ljava/lang/String; = "NfcConfigListParser"

.field private static final TAG_NAME_CONFIG:Ljava/lang/String; = "Config"

.field private static configList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/lge/nfcconfig/NfcConfigListParser$Config;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 17
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/lge/nfcconfig/NfcConfigParserUtil;->NFC_CONFIG_PATH:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "config.xml"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/nfcconfig/NfcConfigListParser;->FILE_PATH_DEFAULT_PROFILE:Ljava/lang/String;

    .line 18
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/lge/nfcconfig/NfcConfigParserUtil;->NFC_CONFIG_PATH:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "config_COM.xml"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/nfcconfig/NfcConfigListParser;->FILE_PATH_COMMON_PROFILE:Ljava/lang/String;

    .line 29
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/lge/nfcconfig/NfcConfigListParser;->configList:Ljava/util/List;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    return-void
.end method

.method public static getConfigFile()Z
    .locals 3

    .prologue
    .line 254
    const/4 v1, 0x0

    .line 255
    .local v1, "result":Z
    const/4 v0, 0x0

    .line 257
    .local v0, "confFile":Ljava/io/File;
    new-instance v0, Ljava/io/File;

    .end local v0    # "confFile":Ljava/io/File;
    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigListParser;->getConfigFileName()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 258
    .restart local v0    # "confFile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 259
    sget-object v2, Lcom/lge/nfcconfig/NfcConfigListParser;->configList:Ljava/util/List;

    invoke-static {v2, v0}, Lcom/lge/nfcconfig/NfcConfigListParser;->parseConfigFile(Ljava/util/List;Ljava/io/File;)Z

    move-result v1

    .line 262
    :cond_0
    return v1
.end method

.method private static getConfigFileName()Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 117
    sget-object v2, Lcom/lge/nfcconfig/NfcConfigListParser;->FILE_PATH_COMMON_PROFILE:Ljava/lang/String;

    .line 118
    .local v2, "fileName":Ljava/lang/String;
    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getCurrentOperator()Ljava/lang/String;

    move-result-object v3

    .line 119
    .local v3, "operator":Ljava/lang/String;
    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getCurrentCountry()Ljava/lang/String;

    move-result-object v0

    .line 120
    .local v0, "country":Ljava/lang/String;
    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getCurrentDevice()Ljava/lang/String;

    move-result-object v1

    .line 122
    .local v1, "device":Ljava/lang/String;
    new-instance v4, Ljava/io/File;

    invoke-static {v3, v0, v1}, Lcom/lge/nfcconfig/NfcConfigListParser;->makeConfigFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 123
    invoke-static {v3, v0, v1}, Lcom/lge/nfcconfig/NfcConfigListParser;->makeConfigFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 134
    :cond_0
    :goto_0
    return-object v2

    .line 124
    :cond_1
    new-instance v4, Ljava/io/File;

    invoke-static {v3, v0, v6}, Lcom/lge/nfcconfig/NfcConfigListParser;->makeConfigFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_2

    .line 125
    invoke-static {v3, v0, v6}, Lcom/lge/nfcconfig/NfcConfigListParser;->makeConfigFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 126
    :cond_2
    new-instance v4, Ljava/io/File;

    invoke-static {v3, v6, v6}, Lcom/lge/nfcconfig/NfcConfigListParser;->makeConfigFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 127
    invoke-static {v3, v6, v6}, Lcom/lge/nfcconfig/NfcConfigListParser;->makeConfigFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 128
    :cond_3
    new-instance v4, Ljava/io/File;

    invoke-static {v6, v0, v6}, Lcom/lge/nfcconfig/NfcConfigListParser;->makeConfigFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 129
    invoke-static {v6, v0, v6}, Lcom/lge/nfcconfig/NfcConfigListParser;->makeConfigFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0
.end method

.method public static getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;
    .locals 10
    .param p0, "tagname"    # Ljava/lang/String;

    .prologue
    .line 225
    new-instance v8, Ljava/io/File;

    sget-object v9, Lcom/lge/nfcconfig/NfcConfigListParser;->FILE_PATH_DEFAULT_PROFILE:Ljava/lang/String;

    invoke-direct {v8, v9}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    const-string v9, "Config"

    invoke-static {v8, v9}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getNodeList(Ljava/io/File;Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object v2

    .line 226
    .local v2, "headNodeList":Lorg/w3c/dom/NodeList;
    const-string v5, ""

    .line 228
    .local v5, "resultValue":Ljava/lang/String;
    if-nez v2, :cond_0

    move-object v6, v5

    .line 251
    .end local v5    # "resultValue":Ljava/lang/String;
    .local v6, "resultValue":Ljava/lang/String;
    :goto_0
    return-object v6

    .line 230
    .end local v6    # "resultValue":Ljava/lang/String;
    .restart local v5    # "resultValue":Ljava/lang/String;
    :cond_0
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    invoke-interface {v2}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v8

    if-ge v3, v8, :cond_5

    .line 231
    invoke-interface {v2, v3}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v8

    invoke-interface {v8}, Lorg/w3c/dom/Node;->getChildNodes()Lorg/w3c/dom/NodeList;

    move-result-object v1

    .line 234
    .local v1, "headChildNodeList":Lorg/w3c/dom/NodeList;
    if-nez v1, :cond_2

    .line 230
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 236
    :cond_2
    const/4 v4, 0x0

    .local v4, "j":I
    :goto_2
    invoke-interface {v1}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v8

    if-ge v4, v8, :cond_1

    .line 237
    invoke-interface {v1, v4}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v0

    .line 239
    .local v0, "childNode":Lorg/w3c/dom/Node;
    if-nez v0, :cond_4

    .line 236
    :cond_3
    :goto_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 241
    :cond_4
    instance-of v8, v0, Lorg/w3c/dom/Element;

    if-eqz v8, :cond_3

    .line 243
    const-string v8, "targetdevice"

    invoke-static {v0, v8}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getAttributeValue(Lorg/w3c/dom/Node;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 244
    .local v7, "targetModelName":Ljava/lang/String;
    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_3

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getCurrentDevice()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8, v7}, Lcom/lge/nfcconfig/NfcConfigTargetListParser;->isTargetModel(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_3

    .line 246
    invoke-interface {v0}, Lorg/w3c/dom/Node;->getLastChild()Lorg/w3c/dom/Node;

    move-result-object v8

    invoke-interface {v8}, Lorg/w3c/dom/Node;->getTextContent()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v5

    goto :goto_3

    .end local v0    # "childNode":Lorg/w3c/dom/Node;
    .end local v1    # "headChildNodeList":Lorg/w3c/dom/NodeList;
    .end local v4    # "j":I
    .end local v7    # "targetModelName":Ljava/lang/String;
    :cond_5
    move-object v6, v5

    .line 251
    .end local v5    # "resultValue":Ljava/lang/String;
    .restart local v6    # "resultValue":Ljava/lang/String;
    goto :goto_0
.end method

.method private static getDefaultConfig(Lcom/lge/nfcconfig/NfcConfigListParser$Config;)Z
    .locals 7
    .param p0, "config"    # Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    .prologue
    .line 205
    new-instance v5, Ljava/io/File;

    sget-object v6, Lcom/lge/nfcconfig/NfcConfigListParser;->FILE_PATH_DEFAULT_PROFILE:Ljava/lang/String;

    invoke-direct {v5, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    const-string v6, "Config"

    invoke-static {v5, v6}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getNodeList(Ljava/io/File;Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object v2

    .line 207
    .local v2, "headNodeList":Lorg/w3c/dom/NodeList;
    if-nez v2, :cond_0

    const/4 v5, 0x0

    .line 222
    :goto_0
    return v5

    .line 209
    :cond_0
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    invoke-interface {v2}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v5

    if-ge v3, v5, :cond_4

    .line 210
    invoke-interface {v2, v3}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v5

    invoke-interface {v5}, Lorg/w3c/dom/Node;->getChildNodes()Lorg/w3c/dom/NodeList;

    move-result-object v1

    .line 212
    .local v1, "headChildNodeList":Lorg/w3c/dom/NodeList;
    if-nez v1, :cond_2

    .line 209
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 214
    :cond_2
    const/4 v4, 0x0

    .local v4, "j":I
    :goto_2
    invoke-interface {v1}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v5

    if-ge v4, v5, :cond_1

    .line 215
    invoke-interface {v1, v4}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v0

    .line 217
    .local v0, "childNode":Lorg/w3c/dom/Node;
    if-nez v0, :cond_3

    .line 214
    :goto_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 219
    :cond_3
    invoke-static {p0, v0}, Lcom/lge/nfcconfig/NfcConfigListParser;->setConfigValue(Lcom/lge/nfcconfig/NfcConfigListParser$Config;Lorg/w3c/dom/Node;)V

    goto :goto_3

    .line 222
    .end local v0    # "childNode":Lorg/w3c/dom/Node;
    .end local v1    # "headChildNodeList":Lorg/w3c/dom/NodeList;
    .end local v4    # "j":I
    :cond_4
    const/4 v5, 0x1

    goto :goto_0
.end method

.method private static makeConfigFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "operator"    # Ljava/lang/String;
    .param p1, "country"    # Ljava/lang/String;
    .param p2, "device"    # Ljava/lang/String;

    .prologue
    .line 97
    const-string v0, "config"

    .line 99
    .local v0, "fileName":Ljava/lang/String;
    if-eqz p0, :cond_0

    .line 100
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 103
    :cond_0
    if-eqz p1, :cond_1

    .line 104
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 107
    :cond_1
    if-eqz p2, :cond_2

    .line 108
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 111
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".xml"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 113
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/lge/nfcconfig/NfcConfigParserUtil;->NFC_CONFIG_PATH:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private static parseConfigFile(Ljava/util/List;Ljava/io/File;)Z
    .locals 8
    .param p1, "file"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/lge/nfcconfig/NfcConfigListParser$Config;",
            ">;",
            "Ljava/io/File;",
            ")Z"
        }
    .end annotation

    .prologue
    .line 167
    .local p0, "configList":Ljava/util/List;, "Ljava/util/List<Lcom/lge/nfcconfig/NfcConfigListParser$Config;>;"
    const-string v7, "Config"

    invoke-static {p1, v7}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getNodeList(Ljava/io/File;Ljava/lang/String;)Lorg/w3c/dom/NodeList;

    move-result-object v4

    .line 169
    .local v4, "headNodeList":Lorg/w3c/dom/NodeList;
    if-nez v4, :cond_0

    const/4 v7, 0x0

    .line 202
    :goto_0
    return v7

    .line 171
    :cond_0
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_1
    invoke-interface {v4}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v7

    if-ge v5, v7, :cond_6

    .line 172
    invoke-interface {v4, v5}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v3

    .line 174
    .local v3, "headNode":Lorg/w3c/dom/Node;
    if-nez v3, :cond_2

    .line 171
    :cond_1
    :goto_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 176
    :cond_2
    instance-of v7, v3, Lorg/w3c/dom/Element;

    if-eqz v7, :cond_1

    .line 177
    new-instance v2, Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    invoke-direct {v2}, Lcom/lge/nfcconfig/NfcConfigListParser$Config;-><init>()V

    .line 179
    .local v2, "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Lcom/lge/nfcconfig/NfcConfigListParser$Config;)Z

    move-result v7

    if-nez v7, :cond_3

    .line 183
    :cond_3
    const-string v7, "operator"

    invoke-static {v3, v7}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getAttributeValue(Lorg/w3c/dom/Node;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    iput-object v7, v2, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mOperator:Ljava/lang/String;

    .line 184
    const-string v7, "country"

    invoke-static {v3, v7}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getAttributeValue(Lorg/w3c/dom/Node;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    iput-object v7, v2, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mCountry:Ljava/lang/String;

    .line 185
    const-string v7, "device"

    invoke-static {v3, v7}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getAttributeValue(Lorg/w3c/dom/Node;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    iput-object v7, v2, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDevice:Ljava/lang/String;

    .line 187
    invoke-interface {v3}, Lorg/w3c/dom/Node;->getChildNodes()Lorg/w3c/dom/NodeList;

    move-result-object v1

    .line 189
    .local v1, "childNodes":Lorg/w3c/dom/NodeList;
    if-eqz v1, :cond_1

    .line 191
    const/4 v6, 0x0

    .local v6, "j":I
    :goto_3
    invoke-interface {v1}, Lorg/w3c/dom/NodeList;->getLength()I

    move-result v7

    if-ge v6, v7, :cond_5

    .line 192
    invoke-interface {v1, v6}, Lorg/w3c/dom/NodeList;->item(I)Lorg/w3c/dom/Node;

    move-result-object v0

    .line 194
    .local v0, "cNode":Lorg/w3c/dom/Node;
    if-nez v0, :cond_4

    .line 191
    :goto_4
    add-int/lit8 v6, v6, 0x1

    goto :goto_3

    .line 196
    :cond_4
    invoke-static {v2, v0}, Lcom/lge/nfcconfig/NfcConfigListParser;->setConfigValue(Lcom/lge/nfcconfig/NfcConfigListParser$Config;Lorg/w3c/dom/Node;)V

    goto :goto_4

    .line 198
    .end local v0    # "cNode":Lorg/w3c/dom/Node;
    :cond_5
    invoke-interface {p0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 202
    .end local v1    # "childNodes":Lorg/w3c/dom/NodeList;
    .end local v2    # "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    .end local v3    # "headNode":Lorg/w3c/dom/Node;
    .end local v6    # "j":I
    :cond_6
    const/4 v7, 0x1

    goto :goto_0
.end method

.method private static searchConfig()Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    .locals 4

    .prologue
    .line 265
    sget-object v2, Lcom/lge/nfcconfig/NfcConfigListParser;->configList:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    .line 266
    .local v0, "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mOperator:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mCountry:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDevice:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 272
    .end local v0    # "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    :goto_0
    return-object v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static searchConfig(Ljava/lang/String;Ljava/lang/String;)Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    .locals 5
    .param p0, "operator"    # Ljava/lang/String;
    .param p1, "country"    # Ljava/lang/String;

    .prologue
    .line 300
    sget-object v3, Lcom/lge/nfcconfig/NfcConfigListParser;->configList:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    .line 301
    .local v0, "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    iget-object v3, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mOperator:Ljava/lang/String;

    invoke-virtual {v3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mCountry:Ljava/lang/String;

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDevice:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 312
    .end local v0    # "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    :goto_0
    return-object v0

    .line 307
    :cond_1
    invoke-static {p0}, Lcom/lge/nfcconfig/NfcConfigListParser;->searchConfigByOperator(Ljava/lang/String;)Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    move-result-object v2

    .local v2, "tmpConfig":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    if-nez v2, :cond_2

    .line 308
    invoke-static {p1}, Lcom/lge/nfcconfig/NfcConfigListParser;->searchConfigByCounty(Ljava/lang/String;)Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    move-result-object v2

    if-nez v2, :cond_2

    .line 309
    const/4 v0, 0x0

    goto :goto_0

    :cond_2
    move-object v0, v2

    .line 312
    goto :goto_0
.end method

.method public static searchConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    .locals 3
    .param p0, "operator"    # Ljava/lang/String;
    .param p1, "country"    # Ljava/lang/String;
    .param p2, "device"    # Ljava/lang/String;

    .prologue
    .line 315
    sget-object v2, Lcom/lge/nfcconfig/NfcConfigListParser;->configList:Ljava/util/List;

    if-nez v2, :cond_0

    .line 316
    const/4 v0, 0x0

    .line 326
    :goto_0
    return-object v0

    .line 319
    :cond_0
    sget-object v2, Lcom/lge/nfcconfig/NfcConfigListParser;->configList:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    .line 320
    .local v0, "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mOperator:Ljava/lang/String;

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mCountry:Ljava/lang/String;

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDevice:Ljava/lang/String;

    invoke-virtual {v2, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    goto :goto_0

    .line 326
    .end local v0    # "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    :cond_2
    invoke-static {p0, p1}, Lcom/lge/nfcconfig/NfcConfigListParser;->searchConfig(Ljava/lang/String;Ljava/lang/String;)Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    move-result-object v0

    goto :goto_0
.end method

.method private static searchConfigByCounty(Ljava/lang/String;)Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    .locals 4
    .param p0, "country"    # Ljava/lang/String;

    .prologue
    .line 287
    sget-object v2, Lcom/lge/nfcconfig/NfcConfigListParser;->configList:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    .line 288
    .local v0, "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mOperator:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mCountry:Ljava/lang/String;

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDevice:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 294
    .end local v0    # "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    :goto_0
    return-object v0

    :cond_1
    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigListParser;->searchConfig()Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    move-result-object v0

    goto :goto_0
.end method

.method private static searchConfigByOperator(Ljava/lang/String;)Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    .locals 4
    .param p0, "operator"    # Ljava/lang/String;

    .prologue
    .line 276
    sget-object v2, Lcom/lge/nfcconfig/NfcConfigListParser;->configList:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    .line 277
    .local v0, "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mOperator:Ljava/lang/String;

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mCountry:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDevice:Ljava/lang/String;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 283
    .end local v0    # "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    :goto_0
    return-object v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static setConfigValue(Lcom/lge/nfcconfig/NfcConfigListParser$Config;Lorg/w3c/dom/Node;)V
    .locals 8
    .param p0, "config"    # Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    .param p1, "childNode"    # Lorg/w3c/dom/Node;

    .prologue
    .line 137
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    .line 163
    :cond_0
    :goto_0
    return-void

    .line 141
    :cond_1
    instance-of v7, p1, Lorg/w3c/dom/Element;

    if-eqz v7, :cond_0

    .line 142
    invoke-static {p1}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getNodeValue(Lorg/w3c/dom/Node;)Ljava/lang/String;

    move-result-object v5

    .line 143
    .local v5, "value":Ljava/lang/String;
    const-string v7, "targetdevice"

    invoke-static {p1, v7}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getAttributeValue(Lorg/w3c/dom/Node;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 144
    .local v4, "targetModelName":Ljava/lang/String;
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v0

    .local v0, "arr$":[Ljava/lang/reflect/Field;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_1
    if-ge v2, v3, :cond_0

    aget-object v1, v0, v2

    .line 146
    .local v1, "f":Ljava/lang/reflect/Field;
    :try_start_0
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v6

    .line 147
    .local v6, "valueString":Ljava/lang/String;
    if-eqz v6, :cond_2

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v7

    if-lez v7, :cond_2

    const-string v7, "m"

    invoke-virtual {v6, v7}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 148
    const/4 v7, 0x1

    invoke-virtual {v6, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    .line 151
    :cond_2
    invoke-interface {p1}, Lorg/w3c/dom/Node;->getNodeName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->getCurrentDevice()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v4}, Lcom/lge/nfcconfig/NfcConfigTargetListParser;->isTargetModel(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_3

    .line 153
    invoke-virtual {v1, p0, v5}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 158
    .end local v6    # "valueString":Ljava/lang/String;
    :catch_0
    move-exception v7

    .line 144
    :cond_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_1
.end method