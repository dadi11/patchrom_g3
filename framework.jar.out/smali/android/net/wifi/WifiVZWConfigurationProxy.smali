.class public Landroid/net/wifi/WifiVZWConfigurationProxy;
.super Ljava/lang/Object;
.source "WifiVZWConfigurationProxy.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/net/wifi/WifiVZWConfigurationProxy$GroupCipher;,
        Landroid/net/wifi/WifiVZWConfigurationProxy$PairwiseCipher;,
        Landroid/net/wifi/WifiVZWConfigurationProxy$AuthAlgorithm;,
        Landroid/net/wifi/WifiVZWConfigurationProxy$Protocol;,
        Landroid/net/wifi/WifiVZWConfigurationProxy$KeyMgmt;
    }
.end annotation


# static fields
.field private static BSSIDField:Ljava/lang/reflect/Field; = null

.field private static ChannelField:Ljava/lang/reflect/Field; = null

.field private static CountryCodeField:Ljava/lang/reflect/Field; = null

.field private static INVALID_NETWORK_IDField:Ljava/lang/reflect/Field; = null

.field private static MaxscbField:Ljava/lang/reflect/Field; = null

.field private static SSIDField:Ljava/lang/reflect/Field; = null

.field private static final TAG:Ljava/lang/String; = "WifiVZWConfigurationProxy"

.field private static accept_mac_fileField:Ljava/lang/reflect/Field;

.field private static allowedAuthAlgorithmsField:Ljava/lang/reflect/Field;

.field private static allowedGroupCiphersField:Ljava/lang/reflect/Field;

.field private static allowedKeyManagementField:Ljava/lang/reflect/Field;

.field private static allowedPairwiseCiphersField:Ljava/lang/reflect/Field;

.field private static allowedProtocolsField:Ljava/lang/reflect/Field;

.field private static ap_isolateField:Ljava/lang/reflect/Field;

.field private static authModeField:Ljava/lang/reflect/Field;

.field private static c:Ljava/lang/Class;

.field private static deny_mac_fileField:Ljava/lang/reflect/Field;

.field private static encModeField:Ljava/lang/reflect/Field;

.field private static hiddenSSIDField:Ljava/lang/reflect/Field;

.field private static hw_modeField:Ljava/lang/reflect/Field;

.field private static ieee_modeField:Ljava/lang/reflect/Field;

.field private static macaddr_aclField:Ljava/lang/reflect/Field;

.field private static networkIdField:Ljava/lang/reflect/Field;

.field private static o:Ljava/lang/Object;

.field private static pariwiseField:Ljava/lang/reflect/Field;

.field private static preSharedKeyField:Ljava/lang/reflect/Field;

.field private static priorityField:Ljava/lang/reflect/Field;

.field private static secModeField:Ljava/lang/reflect/Field;

.field private static wepKeys1Field:Ljava/lang/reflect/Field;

.field private static wepKeys2Field:Ljava/lang/reflect/Field;

.field private static wepKeys3Field:Ljava/lang/reflect/Field;

.field private static wepKeys4Field:Ljava/lang/reflect/Field;

.field private static wepTxKeyIndexField:Ljava/lang/reflect/Field;


# instance fields
.field private allowedAuthAlgorithmsbitset:Ljava/util/BitSet;

.field private allowedGroupCiphersbitset:Ljava/util/BitSet;

.field private allowedKeyManagementbitset:Ljava/util/BitSet;

.field private allowedPairwiseCiphersbitset:Ljava/util/BitSet;

.field private allowedProtocolsbitset:Ljava/util/BitSet;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .prologue
    const/4 v6, 0x0

    .line 202
    new-array v2, v6, [Ljava/lang/Class;

    .line 203
    .local v2, "KeyMgmtType":[Ljava/lang/Class;
    new-array v4, v6, [Ljava/lang/Class;

    .line 204
    .local v4, "ProtocolType":[Ljava/lang/Class;
    new-array v0, v6, [Ljava/lang/Class;

    .line 205
    .local v0, "AuthAlgorithm":[Ljava/lang/Class;
    new-array v3, v6, [Ljava/lang/Class;

    .line 206
    .local v3, "PairwiseCipher":[Ljava/lang/Class;
    new-array v1, v6, [Ljava/lang/Class;

    .line 210
    .local v1, "GroupCipher":[Ljava/lang/Class;
    :try_start_0
    const-string v6, "android.net.wifi.WifiVZWConfiguration"

    invoke-static {v6}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->c:Ljava/lang/Class;

    .line 211
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->c:Ljava/lang/Class;

    invoke-virtual {v6}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    .line 213
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "SSID"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->SSIDField:Ljava/lang/reflect/Field;

    .line 214
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string/jumbo v7, "networkId"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->networkIdField:Ljava/lang/reflect/Field;

    .line 215
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "INVALID_NETWORK_ID"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->INVALID_NETWORK_IDField:Ljava/lang/reflect/Field;

    .line 216
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "INVALID_NETWORK_ID"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->BSSIDField:Ljava/lang/reflect/Field;

    .line 217
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string/jumbo v7, "preSharedKey"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->preSharedKeyField:Ljava/lang/reflect/Field;

    .line 219
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string/jumbo v7, "wepKeys1"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys1Field:Ljava/lang/reflect/Field;

    .line 220
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string/jumbo v7, "wepKeys2"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys2Field:Ljava/lang/reflect/Field;

    .line 221
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string/jumbo v7, "wepKeys3"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys3Field:Ljava/lang/reflect/Field;

    .line 222
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string/jumbo v7, "wepKeys4"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys4Field:Ljava/lang/reflect/Field;

    .line 224
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string/jumbo v7, "wepTxKeyIndex"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepTxKeyIndexField:Ljava/lang/reflect/Field;

    .line 225
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string/jumbo v7, "priority"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->priorityField:Ljava/lang/reflect/Field;

    .line 226
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "hiddenSSID"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->hiddenSSIDField:Ljava/lang/reflect/Field;

    .line 227
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "allowedKeyManagement"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementField:Ljava/lang/reflect/Field;

    .line 228
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "allowedProtocols"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedProtocolsField:Ljava/lang/reflect/Field;

    .line 229
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "allowedAuthAlgorithms"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsField:Ljava/lang/reflect/Field;

    .line 230
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "allowedPairwiseCiphers"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersField:Ljava/lang/reflect/Field;

    .line 231
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "allowedGroupCiphers"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersField:Ljava/lang/reflect/Field;

    .line 232
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "Channel"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->ChannelField:Ljava/lang/reflect/Field;

    .line 233
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "CountryCode"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->CountryCodeField:Ljava/lang/reflect/Field;

    .line 234
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "Maxscb"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->MaxscbField:Ljava/lang/reflect/Field;

    .line 235
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "hw_mode"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->hw_modeField:Ljava/lang/reflect/Field;

    .line 236
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "ap_isolate"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->ap_isolateField:Ljava/lang/reflect/Field;

    .line 237
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "ieee_mode"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->ieee_modeField:Ljava/lang/reflect/Field;

    .line 238
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string/jumbo v7, "macaddr_acl"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->macaddr_aclField:Ljava/lang/reflect/Field;

    .line 239
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "accept_mac_file"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->accept_mac_fileField:Ljava/lang/reflect/Field;

    .line 240
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "deny_mac_file"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->deny_mac_fileField:Ljava/lang/reflect/Field;

    .line 241
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "authMode"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->authModeField:Ljava/lang/reflect/Field;

    .line 242
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string/jumbo v7, "secMode"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->secModeField:Ljava/lang/reflect/Field;

    .line 243
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string v7, "encMode"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->encModeField:Ljava/lang/reflect/Field;

    .line 244
    sget-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    const-string/jumbo v7, "pariwise"

    invoke-virtual {v6, v7}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    sput-object v6, Landroid/net/wifi/WifiVZWConfigurationProxy;->pariwiseField:Ljava/lang/reflect/Field;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 249
    :goto_0
    return-void

    .line 246
    :catch_0
    move-exception v5

    .line 247
    .local v5, "t":Ljava/lang/Throwable;
    const-string v6, "WifiVZWConfigurationProxy"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Unable to find NetworkManagementService"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 256
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 57
    new-instance v0, Ljava/util/BitSet;

    invoke-direct {v0}, Ljava/util/BitSet;-><init>()V

    iput-object v0, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    .line 58
    new-instance v0, Ljava/util/BitSet;

    invoke-direct {v0}, Ljava/util/BitSet;-><init>()V

    iput-object v0, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedProtocolsbitset:Ljava/util/BitSet;

    .line 59
    new-instance v0, Ljava/util/BitSet;

    invoke-direct {v0}, Ljava/util/BitSet;-><init>()V

    iput-object v0, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsbitset:Ljava/util/BitSet;

    .line 60
    new-instance v0, Ljava/util/BitSet;

    invoke-direct {v0}, Ljava/util/BitSet;-><init>()V

    iput-object v0, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersbitset:Ljava/util/BitSet;

    .line 61
    new-instance v0, Ljava/util/BitSet;

    invoke-direct {v0}, Ljava/util/BitSet;-><init>()V

    iput-object v0, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersbitset:Ljava/util/BitSet;

    .line 258
    return-void
.end method


# virtual methods
.method public clearWepWPAKey()V
    .locals 5

    .prologue
    .line 407
    :try_start_0
    const-string v0, ""

    .line 408
    .local v0, "clearKey":Ljava/lang/String;
    const-string v2, "WifiVZWConfigurationProxy"

    const-string v3, "clearWepWPAKey"

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 410
    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys1Field:Ljava/lang/reflect/Field;

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v2, v3, v0}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 411
    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys2Field:Ljava/lang/reflect/Field;

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v2, v3, v0}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 412
    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys3Field:Ljava/lang/reflect/Field;

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v2, v3, v0}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 413
    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys4Field:Ljava/lang/reflect/Field;

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v2, v3, v0}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 414
    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->preSharedKeyField:Ljava/lang/reflect/Field;

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v2, v3, v0}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 420
    .end local v0    # "clearKey":Ljava/lang/String;
    :goto_0
    return-void

    .line 417
    :catch_0
    move-exception v1

    .line 418
    .local v1, "t":Ljava/lang/Throwable;
    const-string v2, "WifiVZWConfigurationProxy"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Unable to find clearWepWPAKey "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public clearallowedAuthAlgorithmsbitset()V
    .locals 4

    .prologue
    .line 634
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    const-string v2, "clearallowedAuthAlgorithmsbitset "

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 635
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsbitset:Ljava/util/BitSet;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 636
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsbitset:Ljava/util/BitSet;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 637
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsbitset:Ljava/util/BitSet;

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 643
    :goto_0
    return-void

    .line 640
    :catch_0
    move-exception v0

    .line 641
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "clearallowedKeyManagementbitset "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public clearallowedGroupCiphersbitset()V
    .locals 4

    .prologue
    .line 715
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    const-string v2, "clearallowedGroupCiphersbitset"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 716
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersbitset:Ljava/util/BitSet;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 717
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersbitset:Ljava/util/BitSet;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 718
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersbitset:Ljava/util/BitSet;

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 719
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersbitset:Ljava/util/BitSet;

    const/4 v2, 0x3

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 725
    :goto_0
    return-void

    .line 722
    :catch_0
    move-exception v0

    .line 723
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "clearallowedGroupCiphersbitset "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public clearallowedKeyManagementbitset()V
    .locals 4

    .prologue
    .line 546
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    const-string v2, "clearallowedKeyManagementbitset "

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 547
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 548
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 549
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 550
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    const/4 v2, 0x3

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 551
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 552
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    const/4 v2, 0x5

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 558
    :goto_0
    return-void

    .line 555
    :catch_0
    move-exception v0

    .line 556
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "clearallowedKeyManagementbitset "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public clearallowedPairwiseCiphersbitset()V
    .locals 4

    .prologue
    .line 674
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    const-string v2, "clearallowedPairwiseCiphersbitset "

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 675
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersbitset:Ljava/util/BitSet;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 676
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersbitset:Ljava/util/BitSet;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 677
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersbitset:Ljava/util/BitSet;

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 683
    :goto_0
    return-void

    .line 680
    :catch_0
    move-exception v0

    .line 681
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "clearallowedPairwiseCiphersbitset "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public clearallowedProtocolbitset()V
    .locals 4

    .prologue
    .line 595
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    const-string v2, "clearallowedProtocolbitset "

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 596
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedProtocolsbitset:Ljava/util/BitSet;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V

    .line 597
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedProtocolsbitset:Ljava/util/BitSet;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/util/BitSet;->clear(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 603
    :goto_0
    return-void

    .line 600
    :catch_0
    move-exception v0

    .line 601
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "clearallowedProtocolbitset "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getAuthType()I
    .locals 5

    .prologue
    const/4 v1, 0x4

    const/4 v3, 0x3

    const/4 v2, 0x2

    const/4 v0, 0x1

    .line 757
    iget-object v4, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    invoke-virtual {v4, v0}, Ljava/util/BitSet;->get(I)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 758
    const-string v1, "WifiVZWConfigurationProxy"

    const-string v2, "getAuthType WPA_PSK"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 770
    :goto_0
    return v0

    .line 760
    :cond_0
    iget-object v0, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    invoke-virtual {v0, v1}, Ljava/util/BitSet;->get(I)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 761
    const-string v0, "WifiVZWConfigurationProxy"

    const-string v2, "getAuthType WPA2_PSK"

    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    move v0, v1

    .line 762
    goto :goto_0

    .line 763
    :cond_1
    iget-object v0, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    invoke-virtual {v0, v2}, Ljava/util/BitSet;->get(I)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 764
    const-string v0, "WifiVZWConfigurationProxy"

    const-string v1, "getAuthType WPA_EAP"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    move v0, v2

    .line 765
    goto :goto_0

    .line 766
    :cond_2
    iget-object v0, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    invoke-virtual {v0, v3}, Ljava/util/BitSet;->get(I)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 767
    const-string v0, "WifiVZWConfigurationProxy"

    const-string v1, "getAuthType IEEE8021X"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    move v0, v3

    .line 768
    goto :goto_0

    .line 770
    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getBSSIDField()Ljava/lang/String;
    .locals 5

    .prologue
    .line 309
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getBSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "BSSID"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 311
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->BSSIDField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 315
    :goto_0
    return-object v1

    .line 312
    :catch_0
    move-exception v0

    .line 313
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getBSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 315
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getChannelField()I
    .locals 5

    .prologue
    .line 775
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getChannelField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "Channel"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 778
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->ChannelField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 782
    :goto_0
    return v1

    .line 779
    :catch_0
    move-exception v0

    .line 780
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getChannelField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 782
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getINVALID_NETWORK_IDField()I
    .locals 5

    .prologue
    .line 286
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getzField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "INVALID_NETWORK_ID"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 289
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->INVALID_NETWORK_IDField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 293
    :goto_0
    return v1

    .line 290
    :catch_0
    move-exception v0

    .line 291
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getINVALID_NETWORK_IDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 293
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getMaxscbField()I
    .locals 5

    .prologue
    .line 820
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getMaxscbField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "Maxscb"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 823
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->MaxscbField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 827
    :goto_0
    return v1

    .line 824
    :catch_0
    move-exception v0

    .line 825
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getMaxscbField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 827
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getSSIDField()Ljava/lang/String;
    .locals 5

    .prologue
    .line 275
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "SSID"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 277
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->SSIDField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 281
    :goto_0
    return-object v1

    .line 278
    :catch_0
    move-exception v0

    .line 279
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 281
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getaccept_mac_fileField()Ljava/lang/String;
    .locals 5

    .prologue
    .line 935
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getaccept_mac_fileField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "accept_mac_file"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 939
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->accept_mac_fileField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 943
    :goto_0
    return-object v1

    .line 940
    :catch_0
    move-exception v0

    .line 941
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getaccept_mac_fileField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 943
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getallowedAuthAlgorithmsField(I)Ljava/util/BitSet;
    .locals 4
    .param p1, "value"    # I

    .prologue
    .line 647
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getallowedAuthAlgorithmsField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 650
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/BitSet;

    iput-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsbitset:Ljava/util/BitSet;

    .line 651
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsbitset:Ljava/util/BitSet;

    invoke-virtual {v1, p1}, Ljava/util/BitSet;->set(I)V

    .line 652
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsbitset:Ljava/util/BitSet;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 656
    :goto_0
    return-object v1

    .line 653
    :catch_0
    move-exception v0

    .line 654
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getallowedAuthAlgorithmsField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 656
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getallowedGroupCiphersField(I)Ljava/util/BitSet;
    .locals 4
    .param p1, "value"    # I

    .prologue
    .line 729
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getallowedGroupCiphersField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 732
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/BitSet;

    iput-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersbitset:Ljava/util/BitSet;

    .line 733
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersbitset:Ljava/util/BitSet;

    invoke-virtual {v1, p1}, Ljava/util/BitSet;->set(I)V

    .line 734
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersbitset:Ljava/util/BitSet;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 738
    :goto_0
    return-object v1

    .line 735
    :catch_0
    move-exception v0

    .line 736
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getallowedGroupCiphersField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 738
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getallowedKeyManagementField(I)Ljava/util/BitSet;
    .locals 4
    .param p1, "value"    # I

    .prologue
    .line 565
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getallowedKeyManagementField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 568
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/BitSet;

    iput-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    .line 571
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 575
    :goto_0
    return-object v1

    .line 572
    :catch_0
    move-exception v0

    .line 573
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getallowedKeyManagementField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 575
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getallowedPairwiseCiphersField(I)Ljava/util/BitSet;
    .locals 4
    .param p1, "value"    # I

    .prologue
    .line 687
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getallowedPairwiseCiphersField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 690
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/BitSet;

    iput-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersbitset:Ljava/util/BitSet;

    .line 691
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersbitset:Ljava/util/BitSet;

    invoke-virtual {v1, p1}, Ljava/util/BitSet;->set(I)V

    .line 692
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersbitset:Ljava/util/BitSet;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 696
    :goto_0
    return-object v1

    .line 693
    :catch_0
    move-exception v0

    .line 694
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getallowedPairwiseCiphersField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 696
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getallowedProtocolsField(I)Ljava/util/BitSet;
    .locals 4
    .param p1, "value"    # I

    .prologue
    .line 607
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getallowedProtocolsField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 610
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedProtocolsField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/BitSet;

    iput-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedProtocolsbitset:Ljava/util/BitSet;

    .line 611
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedProtocolsbitset:Ljava/util/BitSet;

    invoke-virtual {v1, p1}, Ljava/util/BitSet;->set(I)V

    .line 612
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedProtocolsbitset:Ljava/util/BitSet;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 616
    :goto_0
    return-object v1

    .line 613
    :catch_0
    move-exception v0

    .line 614
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getallowedProtocolsField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 616
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getap_isolateField()I
    .locals 5

    .prologue
    .line 866
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getap_isolateField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "ap_isolate"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 869
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->ap_isolateField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 873
    :goto_0
    return v1

    .line 870
    :catch_0
    move-exception v0

    .line 871
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getap_isolateField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 873
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getauthModeField()I
    .locals 5

    .prologue
    .line 983
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getauthModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "authMode"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 986
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->authModeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 990
    :goto_0
    return v1

    .line 987
    :catch_0
    move-exception v0

    .line 988
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getauthModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 990
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getcountryCodeField()Ljava/lang/String;
    .locals 5

    .prologue
    .line 798
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getCountryCodeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "CountryCode"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 800
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->CountryCodeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 804
    :goto_0
    return-object v1

    .line 801
    :catch_0
    move-exception v0

    .line 802
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getCountryCodeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 804
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getdeny_mac_fileField()Ljava/lang/String;
    .locals 5

    .prologue
    .line 959
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getdeny_mac_fileField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "deny_mac_file"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 963
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->deny_mac_fileField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 967
    :goto_0
    return-object v1

    .line 964
    :catch_0
    move-exception v0

    .line 965
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getdeny_mac_fileField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 967
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getencModeField()I
    .locals 5

    .prologue
    .line 1029
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getencModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "encMode"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1032
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->encModeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1036
    :goto_0
    return v1

    .line 1033
    :catch_0
    move-exception v0

    .line 1034
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getencModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1036
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public gethiddenSSIDField()Z
    .locals 5

    .prologue
    .line 523
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "gethiddenSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "hiddenSSID"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 526
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->hiddenSSIDField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 530
    :goto_0
    return v1

    .line 527
    :catch_0
    move-exception v0

    .line 528
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find gethiddenSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 530
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public gethw_modeField()Ljava/lang/String;
    .locals 5

    .prologue
    .line 843
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "gethw_modeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "hw_mode"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 846
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->hw_modeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 850
    :goto_0
    return-object v1

    .line 847
    :catch_0
    move-exception v0

    .line 848
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find gethw_modeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 850
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getieee_modeField()I
    .locals 5

    .prologue
    .line 889
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getieee_modeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "ieee_mode"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 892
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->ieee_modeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 896
    :goto_0
    return v1

    .line 893
    :catch_0
    move-exception v0

    .line 894
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getieee_modeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 896
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getmacaddr_aclField()I
    .locals 5

    .prologue
    .line 912
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getmacaddr_aclField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string/jumbo v4, "macaddr_acl"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 915
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->macaddr_aclField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 919
    :goto_0
    return v1

    .line 916
    :catch_0
    move-exception v0

    .line 917
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getmacaddr_aclField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 919
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getpariwiseField()Ljava/lang/String;
    .locals 5

    .prologue
    .line 1052
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getpariwiseField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string/jumbo v4, "pariwise"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1056
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->pariwiseField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1060
    :goto_0
    return-object v1

    .line 1057
    :catch_0
    move-exception v0

    .line 1058
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getpariwiseField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1060
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getpreSharedKeyField()Ljava/lang/String;
    .locals 5

    .prologue
    .line 331
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getPreSharedKeyField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string/jumbo v4, "preSharedKey"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 334
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->preSharedKeyField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 338
    :goto_0
    return-object v1

    .line 335
    :catch_0
    move-exception v0

    .line 336
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getPreSharedKeyField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 338
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getpriorityField()I
    .locals 5

    .prologue
    .line 500
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getpriorityField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string/jumbo v4, "priority"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 503
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->priorityField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 507
    :goto_0
    return v1

    .line 504
    :catch_0
    move-exception v0

    .line 505
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getpriorityField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 507
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getsecModeField()I
    .locals 5

    .prologue
    .line 1006
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getsecModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string/jumbo v4, "secMode"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1009
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->secModeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 1013
    :goto_0
    return v1

    .line 1010
    :catch_0
    move-exception v0

    .line 1011
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getsecModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1013
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getwepKeysField1()Ljava/lang/String;
    .locals 5

    .prologue
    .line 355
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getwepKeysField1 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string/jumbo v4, "wepKeys1"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 358
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys1Field:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 363
    :goto_0
    return-object v1

    .line 360
    :catch_0
    move-exception v0

    .line 361
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getwepKeysField1 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 363
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getwepKeysField2()Ljava/lang/String;
    .locals 5

    .prologue
    .line 368
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getwepKeysField2 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string/jumbo v4, "wepKeys2"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 371
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys2Field:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 376
    :goto_0
    return-object v1

    .line 373
    :catch_0
    move-exception v0

    .line 374
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getwepKeysField2 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 376
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getwepKeysField3()Ljava/lang/String;
    .locals 5

    .prologue
    .line 381
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getwepKeysField3 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string/jumbo v4, "wepKeys3"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 384
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys3Field:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 389
    :goto_0
    return-object v1

    .line 386
    :catch_0
    move-exception v0

    .line 387
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getwepKeysField3 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 389
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getwepKeysField4()Ljava/lang/String;
    .locals 5

    .prologue
    .line 394
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getwepKeysField4 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string/jumbo v4, "wepKeys4"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 397
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys4Field:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 402
    :goto_0
    return-object v1

    .line 399
    :catch_0
    move-exception v0

    .line 400
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getwepKeysField4 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 402
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getwepTxKeyIndexField()I
    .locals 5

    .prologue
    .line 477
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getwepTxKeyIndexField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string/jumbo v4, "wepTxKeyIndex"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 480
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepTxKeyIndexField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 484
    :goto_0
    return v1

    .line 481
    :catch_0
    move-exception v0

    .line 482
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find getwepTxKeyIndexField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 484
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public setBSSIDField(Ljava/lang/String;)V
    .locals 4
    .param p1, "bssid"    # Ljava/lang/String;

    .prologue
    .line 320
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 321
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->BSSIDField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 327
    :goto_0
    return-void

    .line 324
    :catch_0
    move-exception v0

    .line 325
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setBSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setChannelField(I)V
    .locals 4
    .param p1, "channel"    # I

    .prologue
    .line 787
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setChannelField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 788
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->ChannelField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 794
    :goto_0
    return-void

    .line 791
    :catch_0
    move-exception v0

    .line 792
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setChannelField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setINVALID_NETWORK_IDField(I)V
    .locals 4
    .param p1, "NETWORK_ID"    # I

    .prologue
    .line 298
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 299
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->INVALID_NETWORK_IDField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 305
    :goto_0
    return-void

    .line 302
    :catch_0
    move-exception v0

    .line 303
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setINVALID_NETWORK_IDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setMaxscbField(I)V
    .locals 4
    .param p1, "maxscb"    # I

    .prologue
    .line 832
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setMaxscbField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 833
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->MaxscbField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 839
    :goto_0
    return-void

    .line 836
    :catch_0
    move-exception v0

    .line 837
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setMaxscbField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setSSIDField(Ljava/lang/String;)V
    .locals 5
    .param p1, "ssid"    # Ljava/lang/String;

    .prologue
    .line 263
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 264
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->SSIDField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 266
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setSSIDField2 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "SSID"

    invoke-virtual {v3, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    sget-object v4, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v3, v4}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 271
    :goto_0
    return-void

    .line 268
    :catch_0
    move-exception v0

    .line 269
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setaccept_mac_fileField(Ljava/lang/String;)V
    .locals 4
    .param p1, "accept_mac_file"    # Ljava/lang/String;

    .prologue
    .line 948
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setaccept_mac_fileField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 949
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->accept_mac_fileField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 955
    :goto_0
    return-void

    .line 952
    :catch_0
    move-exception v0

    .line 953
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setaccept_mac_fileField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setallowedAuthAlgorithmsField(I)V
    .locals 4
    .param p1, "allowedauthalgorithms"    # I

    .prologue
    .line 661
    :try_start_0
    invoke-virtual {p0}, Landroid/net/wifi/WifiVZWConfigurationProxy;->clearallowedAuthAlgorithmsbitset()V

    .line 662
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setallowedAuthAlgorithmsField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 663
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsbitset:Ljava/util/BitSet;

    invoke-virtual {v1, p1}, Ljava/util/BitSet;->set(I)V

    .line 664
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    iget-object v3, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedAuthAlgorithmsbitset:Ljava/util/BitSet;

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 670
    :goto_0
    return-void

    .line 667
    :catch_0
    move-exception v0

    .line 668
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setallowedAuthAlgorithmsField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setallowedGroupCiphersField(I)V
    .locals 4
    .param p1, "allowedgroupciphers"    # I

    .prologue
    .line 744
    :try_start_0
    invoke-virtual {p0}, Landroid/net/wifi/WifiVZWConfigurationProxy;->clearallowedGroupCiphersbitset()V

    .line 745
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setallowedGroupCiphersField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 746
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersbitset:Ljava/util/BitSet;

    invoke-virtual {v1, p1}, Ljava/util/BitSet;->set(I)V

    .line 747
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    iget-object v3, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedGroupCiphersbitset:Ljava/util/BitSet;

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 753
    :goto_0
    return-void

    .line 750
    :catch_0
    move-exception v0

    .line 751
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setallowedGroupCiphersField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setallowedKeyManagementField(I)V
    .locals 4
    .param p1, "allowedkeymanagement"    # I

    .prologue
    .line 580
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setpreSharedKeyField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 581
    invoke-virtual {p0}, Landroid/net/wifi/WifiVZWConfigurationProxy;->clearallowedKeyManagementbitset()V

    .line 582
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    iget-object v3, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 584
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    invoke-virtual {v1, p1}, Ljava/util/BitSet;->set(I)V

    .line 586
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    iget-object v3, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedKeyManagementbitset:Ljava/util/BitSet;

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 591
    :goto_0
    return-void

    .line 588
    :catch_0
    move-exception v0

    .line 589
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setallowedKeyManagementField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setallowedPairwiseCiphersField(I)V
    .locals 4
    .param p1, "allowedpairwiseciphers"    # I

    .prologue
    .line 702
    :try_start_0
    invoke-virtual {p0}, Landroid/net/wifi/WifiVZWConfigurationProxy;->clearallowedPairwiseCiphersbitset()V

    .line 703
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setallowedPairwiseCiphersField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 704
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersbitset:Ljava/util/BitSet;

    invoke-virtual {v1, p1}, Ljava/util/BitSet;->set(I)V

    .line 705
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    iget-object v3, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedPairwiseCiphersbitset:Ljava/util/BitSet;

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 711
    :goto_0
    return-void

    .line 708
    :catch_0
    move-exception v0

    .line 709
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setallowedPairwiseCiphersField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setallowedProtocolsField(I)V
    .locals 4
    .param p1, "allowedprotocols"    # I

    .prologue
    .line 621
    :try_start_0
    invoke-virtual {p0}, Landroid/net/wifi/WifiVZWConfigurationProxy;->clearallowedProtocolbitset()V

    .line 622
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setallowedProtocolsField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 623
    iget-object v1, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedProtocolsbitset:Ljava/util/BitSet;

    invoke-virtual {v1, p1}, Ljava/util/BitSet;->set(I)V

    .line 624
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedProtocolsField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    iget-object v3, p0, Landroid/net/wifi/WifiVZWConfigurationProxy;->allowedProtocolsbitset:Ljava/util/BitSet;

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 630
    :goto_0
    return-void

    .line 627
    :catch_0
    move-exception v0

    .line 628
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setallowedProtocolsField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setap_isolateField(I)V
    .locals 4
    .param p1, "ap_isolate"    # I

    .prologue
    .line 878
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setap_isolateField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 879
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->ap_isolateField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 885
    :goto_0
    return-void

    .line 882
    :catch_0
    move-exception v0

    .line 883
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setap_isolateField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setauthModeField(I)V
    .locals 4
    .param p1, "authMode"    # I

    .prologue
    .line 995
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setauthModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 996
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->authModeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1002
    :goto_0
    return-void

    .line 999
    :catch_0
    move-exception v0

    .line 1000
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setauthModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setcountryCodeField(Ljava/lang/String;)V
    .locals 4
    .param p1, "countrycode"    # Ljava/lang/String;

    .prologue
    .line 809
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setCountryCodeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 810
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->CountryCodeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 816
    :goto_0
    return-void

    .line 813
    :catch_0
    move-exception v0

    .line 814
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setCountryCodeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setdeny_mac_fileField(Ljava/lang/String;)V
    .locals 4
    .param p1, "deny_mac_file"    # Ljava/lang/String;

    .prologue
    .line 972
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setdeny_mac_fileField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 973
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->deny_mac_fileField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 979
    :goto_0
    return-void

    .line 976
    :catch_0
    move-exception v0

    .line 977
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setdeny_mac_fileField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setencModeField(I)V
    .locals 4
    .param p1, "encMode"    # I

    .prologue
    .line 1041
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setencModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1042
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->encModeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1048
    :goto_0
    return-void

    .line 1045
    :catch_0
    move-exception v0

    .line 1046
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setencModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public sethiddenSSIDField(Z)V
    .locals 4
    .param p1, "hiddenssid"    # Z

    .prologue
    .line 535
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sethiddenSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 536
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->hiddenSSIDField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 542
    :goto_0
    return-void

    .line 539
    :catch_0
    move-exception v0

    .line 540
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find sethiddenSSIDField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public sethw_modeField(Ljava/lang/String;)V
    .locals 4
    .param p1, "hw_mode"    # Ljava/lang/String;

    .prologue
    .line 855
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sethw_modeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 856
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->hw_modeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 862
    :goto_0
    return-void

    .line 859
    :catch_0
    move-exception v0

    .line 860
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find sethw_modeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setieee_modeField(I)V
    .locals 4
    .param p1, "ieee_mode"    # I

    .prologue
    .line 901
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setieee_modeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 902
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->ieee_modeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 908
    :goto_0
    return-void

    .line 905
    :catch_0
    move-exception v0

    .line 906
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setieee_modeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setmacaddr_aclField(I)V
    .locals 4
    .param p1, "macaddr_acl"    # I

    .prologue
    .line 924
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setmacaddr_aclField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 925
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->macaddr_aclField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 931
    :goto_0
    return-void

    .line 928
    :catch_0
    move-exception v0

    .line 929
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setmacaddr_aclField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setpariwiseField(Ljava/lang/String;)V
    .locals 4
    .param p1, "pariwise"    # Ljava/lang/String;

    .prologue
    .line 1065
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setpariwiseField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1066
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->pariwiseField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1072
    :goto_0
    return-void

    .line 1069
    :catch_0
    move-exception v0

    .line 1070
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setpariwiseField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setpreSharedKeyField(Ljava/lang/String;)V
    .locals 4
    .param p1, "preSharedKey"    # Ljava/lang/String;

    .prologue
    .line 343
    :try_start_0
    invoke-virtual {p0}, Landroid/net/wifi/WifiVZWConfigurationProxy;->clearWepWPAKey()V

    .line 344
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setpreSharedKeyField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 345
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->preSharedKeyField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 351
    :goto_0
    return-void

    .line 348
    :catch_0
    move-exception v0

    .line 349
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setpreSharedKeyField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setpriorityField(I)V
    .locals 4
    .param p1, "priority"    # I

    .prologue
    .line 512
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setpriorityField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 513
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->priorityField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 519
    :goto_0
    return-void

    .line 516
    :catch_0
    move-exception v0

    .line 517
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setpriorityField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setsecModeField(I)V
    .locals 4
    .param p1, "secMode"    # I

    .prologue
    .line 1018
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setsecModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1019
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->secModeField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 1025
    :goto_0
    return-void

    .line 1022
    :catch_0
    move-exception v0

    .line 1023
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setsecModeField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setwepKeysField1(Ljava/lang/String;)V
    .locals 4
    .param p1, "webkey"    # Ljava/lang/String;

    .prologue
    .line 424
    :try_start_0
    invoke-virtual {p0}, Landroid/net/wifi/WifiVZWConfigurationProxy;->clearWepWPAKey()V

    .line 425
    const-string v1, "WifiVZWConfigurationProxy"

    const-string/jumbo v2, "setwepKeysField1 "

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 426
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys1Field:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 433
    :goto_0
    return-void

    .line 429
    :catch_0
    move-exception v0

    .line 430
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setwepKeysField1 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setwepKeysField2(Ljava/lang/String;)V
    .locals 4
    .param p1, "webkey"    # Ljava/lang/String;

    .prologue
    .line 437
    :try_start_0
    invoke-virtual {p0}, Landroid/net/wifi/WifiVZWConfigurationProxy;->clearWepWPAKey()V

    .line 438
    const-string v1, "WifiVZWConfigurationProxy"

    const-string/jumbo v2, "setwepKeysField2 "

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 439
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys2Field:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 446
    :goto_0
    return-void

    .line 442
    :catch_0
    move-exception v0

    .line 443
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setwepKeysField2 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setwepKeysField3(Ljava/lang/String;)V
    .locals 4
    .param p1, "webkey"    # Ljava/lang/String;

    .prologue
    .line 450
    :try_start_0
    invoke-virtual {p0}, Landroid/net/wifi/WifiVZWConfigurationProxy;->clearWepWPAKey()V

    .line 451
    const-string v1, "WifiVZWConfigurationProxy"

    const-string/jumbo v2, "setwepKeysField3 "

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 452
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys3Field:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 459
    :goto_0
    return-void

    .line 455
    :catch_0
    move-exception v0

    .line 456
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setwepKeysField3 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setwepKeysField4(Ljava/lang/String;)V
    .locals 4
    .param p1, "webkey"    # Ljava/lang/String;

    .prologue
    .line 463
    :try_start_0
    invoke-virtual {p0}, Landroid/net/wifi/WifiVZWConfigurationProxy;->clearWepWPAKey()V

    .line 464
    const-string v1, "WifiVZWConfigurationProxy"

    const-string/jumbo v2, "setwepKeysField4 "

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 465
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepKeys4Field:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 472
    :goto_0
    return-void

    .line 468
    :catch_0
    move-exception v0

    .line 469
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setwepKeysField4 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setwepTxKeyIndexField(I)V
    .locals 4
    .param p1, "webtxkeyindex"    # I

    .prologue
    .line 489
    :try_start_0
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setwepTxKeyIndexField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 490
    sget-object v1, Landroid/net/wifi/WifiVZWConfigurationProxy;->wepTxKeyIndexField:Ljava/lang/reflect/Field;

    sget-object v2, Landroid/net/wifi/WifiVZWConfigurationProxy;->o:Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 496
    :goto_0
    return-void

    .line 493
    :catch_0
    move-exception v0

    .line 494
    .local v0, "t":Ljava/lang/Throwable;
    const-string v1, "WifiVZWConfigurationProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to find setwepTxKeyIndexField "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
