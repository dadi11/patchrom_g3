.class public Lcom/lge/nfcconfig/NfcConfigParserUtil;
.super Ljava/lang/Object;
.source "NfcConfigParserUtil.java"


# static fields
.field public static NFC_CONFIG_PATH:Ljava/lang/String; = null

.field private static final TAG:Ljava/lang/String; = "NfcConfigParserUtil"

.field private static currentCountry:Ljava/lang/String;

.field private static currentDevice:Ljava/lang/String;

.field private static currentOperator:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-string v0, "/system/etc/nfc/"

    sput-object v0, Lcom/lge/nfcconfig/NfcConfigParserUtil;->NFC_CONFIG_PATH:Ljava/lang/String;

    const-string v0, ""

    sput-object v0, Lcom/lge/nfcconfig/NfcConfigParserUtil;->currentDevice:Ljava/lang/String;

    const-string v0, ""

    sput-object v0, Lcom/lge/nfcconfig/NfcConfigParserUtil;->currentCountry:Ljava/lang/String;

    const-string v0, ""

    sput-object v0, Lcom/lge/nfcconfig/NfcConfigParserUtil;->currentOperator:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getAttributeValue(Lorg/w3c/dom/Node;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "node"    # Lorg/w3c/dom/Node;
    .param p1, "attName"    # Ljava/lang/String;

    .prologue
    :try_start_0
    invoke-interface {p0}, Lorg/w3c/dom/Node;->getAttributes()Lorg/w3c/dom/NamedNodeMap;

    move-result-object v0

    invoke-interface {v0, p1}, Lorg/w3c/dom/NamedNodeMap;->getNamedItem(Ljava/lang/String;)Lorg/w3c/dom/Node;

    move-result-object v0

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeValue()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    const-string v0, ""

    goto :goto_0
.end method

.method public static getCurrentCountry()Ljava/lang/String;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/nfcconfig/NfcConfigParserUtil;->currentCountry:Ljava/lang/String;

    return-object v0
.end method

.method public static getCurrentDevice()Ljava/lang/String;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/nfcconfig/NfcConfigParserUtil;->currentDevice:Ljava/lang/String;

    return-object v0
.end method

.method public static getCurrentOperator()Ljava/lang/String;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/nfcconfig/NfcConfigParserUtil;->currentOperator:Ljava/lang/String;

    return-object v0
.end method

.method public static getNodeList(Ljava/io/File;Ljava/lang/String;)Lorg/w3c/dom/NodeList;
    .locals 3
    .param p0, "file"    # Ljava/io/File;
    .param p1, "element"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .local v2, "headList":Lorg/w3c/dom/NodeList;
    invoke-static {p0}, Lcom/lge/nfcconfig/NfcConfigParserUtil;->openFile(Ljava/io/File;)Lorg/w3c/dom/Document;

    move-result-object v0

    .local v0, "doc":Lorg/w3c/dom/Document;
    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    :try_start_0
    invoke-interface {v0, p1}, Lorg/w3c/dom/Document;->getElementsByTagName(Ljava/lang/String;)Lorg/w3c/dom/NodeList;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    :cond_0
    :goto_0
    return-object v2

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public static getNodeValue(Lorg/w3c/dom/Node;)Ljava/lang/String;
    .locals 1
    .param p0, "node"    # Lorg/w3c/dom/Node;

    .prologue
    :try_start_0
    invoke-interface {p0}, Lorg/w3c/dom/Node;->getLastChild()Lorg/w3c/dom/Node;

    move-result-object v0

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getTextContent()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    const-string v0, ""

    goto :goto_0
.end method

.method private static openFile(Ljava/io/File;)Lorg/w3c/dom/Document;
    .locals 4
    .param p0, "file"    # Ljava/io/File;

    .prologue
    const/4 v1, 0x0

    .local v1, "doc":Lorg/w3c/dom/Document;
    if-eqz p0, :cond_0

    :try_start_0
    invoke-static {}, Ljavax/xml/parsers/DocumentBuilderFactory;->newInstance()Ljavax/xml/parsers/DocumentBuilderFactory;

    move-result-object v3

    .local v3, "factory":Ljavax/xml/parsers/DocumentBuilderFactory;
    invoke-virtual {v3}, Ljavax/xml/parsers/DocumentBuilderFactory;->newDocumentBuilder()Ljavax/xml/parsers/DocumentBuilder;

    move-result-object v0

    .local v0, "builder":Ljavax/xml/parsers/DocumentBuilder;
    invoke-virtual {v0, p0}, Ljavax/xml/parsers/DocumentBuilder;->parse(Ljava/io/File;)Lorg/w3c/dom/Document;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .end local v0    # "builder":Ljavax/xml/parsers/DocumentBuilder;
    .end local v3    # "factory":Ljavax/xml/parsers/DocumentBuilderFactory;
    :cond_0
    :goto_0
    return-object v1

    :catch_0
    move-exception v2

    .local v2, "e":Ljava/lang/Exception;
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public static setCurrentCountry(Ljava/lang/String;)V
    .locals 0
    .param p0, "mCountry"    # Ljava/lang/String;

    .prologue
    sput-object p0, Lcom/lge/nfcconfig/NfcConfigParserUtil;->currentCountry:Ljava/lang/String;

    return-void
.end method

.method public static setCurrentDevice(Ljava/lang/String;)V
    .locals 0
    .param p0, "mDevice"    # Ljava/lang/String;

    .prologue
    sput-object p0, Lcom/lge/nfcconfig/NfcConfigParserUtil;->currentDevice:Ljava/lang/String;

    return-void
.end method

.method public static setCurrentOperator(Ljava/lang/String;)V
    .locals 0
    .param p0, "mOperator"    # Ljava/lang/String;

    .prologue
    sput-object p0, Lcom/lge/nfcconfig/NfcConfigParserUtil;->currentOperator:Ljava/lang/String;

    return-void
.end method
