.class public Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;
.super Ljava/lang/Object;
.source "WifiSapSecurityType.java"


# instance fields
.field private final mAuthMode:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

.field private final mEncMode:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

.field private final mSecMode:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;


# direct methods
.method public constructor <init>(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V
    .locals 0
    .param p1, "authMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .param p2, "secMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    .param p3, "encMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->mAuthMode:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    iput-object p2, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->mSecMode:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    iput-object p3, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->mEncMode:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    return-void
.end method


# virtual methods
.method public getAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->mAuthMode:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    return-object v0
.end method

.method public getEncMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->mEncMode:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    return-object v0
.end method

.method public getSecMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->mSecMode:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    return-object v0
.end method
