.class public Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;
.super Ljava/lang/Object;
.source "WifiHostapdApi.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;,
        Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;
    }
.end annotation


# static fields
.field private static final LOCAL_LOGD:Z = true

.field private static final TAG:Ljava/lang/String; = "WifiHostapApi"

.field private static mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;


# instance fields
.field private final associatedStaMacArrayLst:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mAuthMode:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

.field private final mContext:Landroid/content/Context;

.field private mEncMode:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

.field private mMacFilterCount:I

.field private mMacFilterMode:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

.field private mSecMode:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

.field private mSsid:Ljava/lang/String;

.field private mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

.field private final mWifiManager:Landroid/net/wifi/WifiManager;

.field private final mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

.field private final macFilterLst:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 48
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    .line 60
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    const-string/jumbo v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiManager:Landroid/net/wifi/WifiManager;

    .line 61
    new-instance v0, Landroid/net/wifi/WifiConfiguration;

    invoke-direct {v0}, Landroid/net/wifi/WifiConfiguration;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    .line 62
    new-instance v0, Landroid/net/wifi/WifiManagerProxy;

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/net/wifi/WifiManagerProxy;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    .line 63
    new-instance v0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    const-string/jumbo v1, "wlan0"

    invoke-direct {v0, v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    .line 68
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->associatedStaMacArrayLst:Ljava/util/ArrayList;

    .line 69
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->macFilterLst:Ljava/util/ArrayList;

    .line 70
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->DENY_UNLESS_IN_ACCEPT_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterMode:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .line 71
    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterCount:I

    .line 73
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0}, Ljava/lang/String;-><init>()V

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mSsid:Ljava/lang/String;

    .line 74
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mAuthMode:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 75
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mSecMode:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 76
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;->NO_ENCRYPTION:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    iput-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mEncMode:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .line 78
    return-void
.end method

.method private AddMacFilterAllowList()Z
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 89
    const-string v0, "WifiHostapApi"

    const-string v1, "AddMacFilterAllowList : "

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 91
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;->LIST_TYPE_WHITE:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;

    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;->CMD_TYPE_ADD:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;

    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->macFilterLst:Ljava/util/ArrayList;

    invoke-direct {p0, v0, v1, v2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetAccessControlLists(Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;Ljava/util/ArrayList;)Z

    move-result v0

    if-eq v3, v0, :cond_0

    .line 94
    const-string v0, "WifiHostapApi"

    const-string v1, "AddMacFilterAllowList : SetAccessControlLists() Failed"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 97
    :cond_0
    return v3
.end method

.method private AddMacFilterDenyList()Z
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 128
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;->LIST_TYPE_BLACK:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;

    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;->CMD_TYPE_ADD:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;

    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->macFilterLst:Ljava/util/ArrayList;

    invoke-direct {p0, v0, v1, v2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetAccessControlLists(Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;Ljava/util/ArrayList;)Z

    move-result v0

    if-eq v3, v0, :cond_0

    .line 131
    const-string v0, "WifiHostapApi"

    const-string v1, "AddMacFilterDenyList : SetAccessControlLists() Failed"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 134
    :cond_0
    return v3
.end method

.method private CheckAutoShutOffTimeValidity(I)Z
    .locals 1
    .param p1, "time"    # I

    .prologue
    .line 158
    sparse-switch p1, :sswitch_data_0

    .line 172
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 169
    :sswitch_0
    const/4 v0, 0x1

    goto :goto_0

    .line 158
    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_0
        0x5 -> :sswitch_0
        0xa -> :sswitch_0
        0x14 -> :sswitch_0
        0x1e -> :sswitch_0
        0x28 -> :sswitch_0
        0x32 -> :sswitch_0
        0x3c -> :sswitch_0
        0x5a -> :sswitch_0
        0x78 -> :sswitch_0
    .end sparse-switch
.end method

.method private CheckMacAddressValidity(Ljava/lang/String;)Z
    .locals 5
    .param p1, "macAdd"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x1

    .line 177
    const-string v2, "(([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2})"

    invoke-static {v2, p1}, Ljava/util/regex/Pattern;->matches(Ljava/lang/String;Ljava/lang/CharSequence;)Z

    move-result v0

    .line 179
    .local v0, "bIsMacAdd":Z
    if-eq v1, v0, :cond_0

    .line 180
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CheckMacAddressValidity not MAC add ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 181
    const/4 v1, 0x0

    .line 185
    :goto_0
    return v1

    .line 183
    :cond_0
    const-string v2, "WifiHostapApi"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CheckMacAddressValidity true ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private CheckSecurityTypeValidity(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)Z
    .locals 1
    .param p1, "authMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .param p2, "secMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    .param p3, "encMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .prologue
    .line 191
    const/4 v0, 0x1

    return v0
.end method

.method private CheckWepKeyValidity(Ljava/lang/String;)Z
    .locals 1
    .param p1, "wepKey"    # Ljava/lang/String;

    .prologue
    .line 196
    const/4 v0, 0x0

    return v0
.end method

.method private ResetToDefault()Z
    .locals 1

    .prologue
    .line 499
    const/4 v0, 0x0

    return v0
.end method

.method private RetrieveAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    .locals 1

    .prologue
    .line 512
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 515
    .local v0, "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    return-object v0
.end method

.method private RetrieveMacFilterAllowList()Ljava/util/ArrayList;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 522
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .line 524
    .local v5, "macAllowLst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v6, 0x0

    .line 529
    .local v6, "maclists":[Ljava/lang/String;
    const/4 v7, 0x1

    :try_start_0
    invoke-static {v7}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->getAccessControlLists(I)Ljava/lang/String;

    move-result-object v7

    const-string v8, "\\n"

    invoke-virtual {v7, v8}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v6

    .line 534
    :goto_0
    if-eqz v6, :cond_0

    .line 535
    move-object v0, v6

    .local v0, "arr$":[Ljava/lang/String;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_1
    if-ge v2, v3, :cond_0

    aget-object v4, v0, v2

    .line 536
    .local v4, "list":Ljava/lang/String;
    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 535
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 530
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "len$":I
    .end local v4    # "list":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 531
    .local v1, "e":Ljava/lang/NullPointerException;
    const-string v7, "WifiHostapApi"

    const-string v8, "RetrieveMacFilterAllowList There is no client "

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 540
    .end local v1    # "e":Ljava/lang/NullPointerException;
    :cond_0
    const-string v7, "WifiHostapApi"

    const-string v8, "RetrieveMacFilterAllowList "

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 541
    return-object v5
.end method

.method private RetrieveMacFilterDenyList()Ljava/util/ArrayList;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 548
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .line 550
    .local v5, "macDenyLst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v6, 0x0

    .line 555
    .local v6, "maclists":[Ljava/lang/String;
    const/4 v7, 0x0

    :try_start_0
    invoke-static {v7}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->getAccessControlLists(I)Ljava/lang/String;

    move-result-object v7

    const-string v8, "\\n"

    invoke-virtual {v7, v8}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v6

    .line 560
    :goto_0
    if-eqz v6, :cond_0

    .line 561
    move-object v0, v6

    .local v0, "arr$":[Ljava/lang/String;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_1
    if-ge v2, v3, :cond_0

    aget-object v4, v0, v2

    .line 562
    .local v4, "list":Ljava/lang/String;
    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 561
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 556
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "len$":I
    .end local v4    # "list":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 557
    .local v1, "e":Ljava/lang/NullPointerException;
    const-string v7, "WifiHostapApi"

    const-string v8, "RetrieveMacFilterDenyList There is no client "

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 566
    .end local v1    # "e":Ljava/lang/NullPointerException;
    :cond_0
    const-string v7, "WifiHostapApi"

    const-string v8, "RetrieveMacFilterDenyList "

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 567
    return-object v5
.end method

.method private RetrieveSecurityMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    .locals 1

    .prologue
    .line 571
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;->NO_SECURITY:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 574
    .local v0, "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    return-object v0
.end method

.method private RetrieveSsid()Ljava/lang/String;
    .locals 4

    .prologue
    .line 578
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-object v0, v1, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    .line 580
    .local v0, "sReturnVal":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 581
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    array-length v1, v1

    const/16 v2, 0x20

    if-le v1, v2, :cond_1

    .line 582
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RetrieveSsid : not supported ssid length ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 588
    :cond_0
    const/4 v0, 0x0

    .end local v0    # "sReturnVal":Ljava/lang/String;
    :cond_1
    return-object v0
.end method

.method private SetAccessControlLists(Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;Ljava/util/ArrayList;)Z
    .locals 6
    .param p1, "listType"    # Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;
    .param p2, "cmdType"    # Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;",
            "Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;)Z"
        }
    .end annotation

    .prologue
    .local p3, "filterLst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 598
    const-string v3, "WifiHostapApi"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "SetAccessControlLists : ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 600
    invoke-virtual {p3}, Ljava/util/ArrayList;->size()I

    move-result v3

    new-array v3, v3, [Ljava/lang/String;

    invoke-virtual {p3, v3}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 603
    .local v0, "filter":[Ljava/lang/String;
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;->LIST_TYPE_BLACK:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;

    if-ne p1, v3, :cond_2

    .line 608
    invoke-static {v2, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setAccessControlLists(I[Ljava/lang/String;)Z

    move-result v3

    if-ne v3, v1, :cond_1

    .line 617
    :cond_0
    :goto_0
    return v1

    :cond_1
    move v1, v2

    .line 608
    goto :goto_0

    .line 610
    :cond_2
    sget-object v3, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;->LIST_TYPE_WHITE:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;

    if-ne p1, v3, :cond_3

    .line 615
    invoke-static {v1, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setAccessControlLists(I[Ljava/lang/String;)Z

    move-result v3

    if-eq v3, v1, :cond_0

    move v1, v2

    goto :goto_0

    :cond_3
    move v1, v2

    .line 617
    goto :goto_0
.end method

.method private SetAuthMode(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;)Z
    .locals 3
    .param p1, "authMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .prologue
    .line 642
    const-string v0, "auth_algs="

    .line 644
    .local v0, "sCmdVal":Ljava/lang/String;
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->OPEN_SYSTEM_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    if-ne v1, p1, :cond_0

    .line 645
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "1"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 657
    :goto_0
    const/4 v1, 0x0

    return v1

    .line 646
    :cond_0
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;->SHARED_KEY_AUTH:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    if-ne v1, p1, :cond_1

    .line 647
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "2"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 649
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "3"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private SetEncryptionMode(Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;)Z
    .locals 1
    .param p1, "encMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    .param p2, "secMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .prologue
    .line 755
    const/4 v0, 0x1

    return v0
.end method

.method private SetSecurityMode(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;)Z
    .locals 1
    .param p1, "secMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .prologue
    .line 888
    const/4 v0, 0x0

    return v0
.end method

.method private SyncMacFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    .locals 2

    .prologue
    .line 992
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ACCEPT_UNLESS_IN_DENY_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .line 996
    .local v0, "filterMode":Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    invoke-direct {p0, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->UpdateMacFilterMode(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;)Z

    .line 998
    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetMacFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    move-result-object v1

    return-object v1
.end method

.method private UpdateAuthMode(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;)V
    .locals 0
    .param p1, "authMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .prologue
    .line 1002
    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mAuthMode:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    .line 1003
    return-void
.end method

.method private UpdateEncryptionMode(Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V
    .locals 0
    .param p1, "encMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .prologue
    .line 1007
    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mEncMode:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    .line 1008
    return-void
.end method

.method private UpdateMacFilterMode(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;)Z
    .locals 5
    .param p1, "filterMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .prologue
    const/4 v4, 0x1

    .line 1016
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UpdateMacFilterMode ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "] <- ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterMode:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1019
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterMode:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    if-eq p1, v1, :cond_1

    .line 1020
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->NUM_OF_MAC_FILTER_MODE:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterMode:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    if-eq v1, v2, :cond_0

    .line 1025
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ACCEPT_UNLESS_IN_DENY_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterMode:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    if-ne v1, v2, :cond_2

    .line 1027
    invoke-direct {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->RetrieveMacFilterAllowList()Ljava/util/ArrayList;

    move-result-object v0

    .line 1029
    .local v0, "filterLst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;->LIST_TYPE_WHITE:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;

    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;->CMD_TYPE_DELETE:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;

    invoke-direct {p0, v1, v2, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetAccessControlLists(Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;Ljava/util/ArrayList;)Z

    move-result v1

    if-eq v4, v1, :cond_0

    .line 1032
    const-string v1, "WifiHostapApi"

    const-string v2, "UpdateMacFilterMode : SetAccessControlLists(WHITE) Failed"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1046
    .end local v0    # "filterLst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_0
    :goto_0
    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterMode:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .line 1047
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UpdateMacFilterMode : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterMode:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1049
    :cond_1
    return v4

    .line 1036
    :cond_2
    invoke-direct {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->RetrieveMacFilterDenyList()Ljava/util/ArrayList;

    move-result-object v0

    .line 1038
    .restart local v0    # "filterLst":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;->LIST_TYPE_BLACK:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;

    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;->CMD_TYPE_DELETE:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;

    invoke-direct {p0, v1, v2, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetAccessControlLists(Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;Ljava/util/ArrayList;)Z

    move-result v1

    if-eq v4, v1, :cond_0

    .line 1041
    const-string v1, "WifiHostapApi"

    const-string v2, "UpdateMacFilterMode : SetAccessControlLists(BLACK) Failed"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private UpdateSecurityMode(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;)V
    .locals 0
    .param p1, "secMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .prologue
    .line 1053
    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mSecMode:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    .line 1054
    return-void
.end method


# virtual methods
.method public AddMacFilterAllowList(Ljava/lang/String;I)Z
    .locals 5
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    const/4 v4, 0x1

    .line 101
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 103
    .local v0, "macList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    .line 104
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AddMacFilterAllowList : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 106
    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 108
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;->LIST_TYPE_WHITE:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;

    if-nez p2, :cond_1

    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;->CMD_TYPE_ADD:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;

    :goto_0
    invoke-direct {p0, v2, v1, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetAccessControlLists(Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;Ljava/util/ArrayList;)Z

    move-result v1

    if-eq v4, v1, :cond_0

    .line 112
    const-string v1, "WifiHostapApi"

    const-string v2, "AddMacFilterAllowList : SetAccessControlLists() Failed"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 115
    :cond_0
    return v4

    .line 108
    :cond_1
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;->CMD_TYPE_DELETE:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;

    goto :goto_0
.end method

.method public AddMacFilterDenyList(Ljava/lang/String;I)Z
    .locals 5
    .param p1, "mac"    # Ljava/lang/String;
    .param p2, "addORdel"    # I

    .prologue
    const/4 v4, 0x1

    .line 138
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 140
    .local v0, "macList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 141
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AddMacFilterDenyList : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 143
    sget-object v2, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;->LIST_TYPE_BLACK:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;

    if-nez p2, :cond_1

    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;->CMD_TYPE_ADD:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;

    :goto_0
    invoke-direct {p0, v2, v1, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->SetAccessControlLists(Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclListType;Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;Ljava/util/ArrayList;)Z

    move-result v1

    if-eq v4, v1, :cond_0

    .line 147
    const-string v1, "WifiHostapApi"

    const-string v2, "AddMacFilterDenyList : SetAccessControlLists() Failed"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 150
    :cond_0
    return v4

    .line 143
    :cond_1
    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;->CMD_TYPE_DELETE:Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi$WifiQsapAclCmdType;

    goto :goto_0
.end method

.method public EnableSoftAp(Z)Z
    .locals 3
    .param p1, "bEnable"    # Z

    .prologue
    .line 201
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EnableSoftAp : bEnable "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 203
    const/4 v0, 0x1

    return v0
.end method

.method public GetAllAssocMacList()[Ljava/lang/String;
    .locals 5

    .prologue
    .line 211
    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->RetrieveAssoStaMacList()Z

    .line 213
    const/4 v0, 0x0

    .line 214
    .local v0, "count":I
    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetAssoStaMacListCount()I

    move-result v0

    .line 216
    if-nez v0, :cond_1

    .line 217
    const/4 v2, 0x0

    .line 228
    :cond_0
    return-object v2

    .line 220
    :cond_1
    new-array v2, v0, [Ljava/lang/String;

    .line 222
    .local v2, "items":[Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_0

    .line 224
    iget-object v4, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->associatedStaMacArrayLst:Ljava/util/ArrayList;

    invoke-virtual {v4, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 225
    .local v3, "macaddr":Ljava/lang/String;
    aput-object v3, v2, v1

    .line 222
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method public GetApIsolation()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 235
    const/4 v0, 0x0

    .line 237
    .local v0, "apIsolation":I
    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_isolated"

    invoke-static {v2, v3, v1}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 238
    if-nez v0, :cond_0

    .line 242
    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x1

    goto :goto_0
.end method

.method public GetAssoStaMacListCount()I
    .locals 4

    .prologue
    .line 251
    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->RetrieveAssoStaMacList()Z

    .line 253
    const/4 v0, 0x0

    .line 255
    .local v0, "count":I
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->associatedStaMacArrayLst:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v0

    .line 257
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "GetAssoStaMacListCount : Assoc Count ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 259
    return v0
.end method

.method public GetAutoShutOffTime()I
    .locals 1

    .prologue
    .line 266
    const/4 v0, -0x1

    return v0
.end method

.method public GetChannel()I
    .locals 6

    .prologue
    const/4 v2, -0x1

    const/4 v5, 0x0

    .line 273
    const/4 v1, 0x0

    .line 274
    .local v1, "sReturnVal":I
    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_frequency"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 275
    .local v0, "sRet_frequency":I
    if-nez v0, :cond_3

    .line 276
    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_2g_channel"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    .line 278
    if-eqz v1, :cond_1

    .line 279
    if-ltz v1, :cond_0

    const/16 v3, 0xe

    if-le v1, v3, :cond_2

    .line 280
    :cond_0
    const-string v3, "WifiHostapApi"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "GetChannel unsupported channel ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 292
    :cond_1
    :goto_0
    return v2

    .line 283
    :cond_2
    const-string v2, "WifiHostapApi"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "GetChannel  ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v2, v1

    .line 284
    goto :goto_0

    .line 289
    :cond_3
    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_5g_channel"

    invoke-static {v2, v3, v5}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    .line 291
    const-string v2, "WifiHostapApi"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "GetChannel    ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v2, v1

    .line 292
    goto :goto_0
.end method

.method public GetCountryCode()Ljava/lang/String;
    .locals 3

    .prologue
    .line 299
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mhs_country"

    invoke-static {v1, v2}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 302
    .local v0, "sReturnVal":Ljava/lang/String;
    return-object v0
.end method

.method public GetHiddenSsid()Z
    .locals 4

    .prologue
    .line 308
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iget-boolean v0, v1, Landroid/net/wifi/WifiConfiguration;->hiddenSSID:Z

    .line 310
    .local v0, "sReturnVal":Z
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "p2pGetHideSSID  ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 311
    return v0
.end method

.method public GetMacFilterByIndex(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .prologue
    .line 319
    const/4 v0, 0x0

    return-object v0
.end method

.method public GetMacFilterCount()I
    .locals 1

    .prologue
    .line 326
    iget v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterCount:I

    return v0
.end method

.method public GetMacFilterMode()Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;
    .locals 3

    .prologue
    .line 333
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GetMacFilterMode : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterMode:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 334
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterMode:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    return-object v0
.end method

.method public GetMaxNumOfClients()I
    .locals 1

    .prologue
    .line 340
    const/4 v0, -0x1

    return v0
.end method

.method public GetOperationMode()Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    .locals 1

    .prologue
    .line 345
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->IEEE802_11_MAX:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    .line 347
    .local v0, "opMode":Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    return-object v0
.end method

.method public GetSecurityType()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;
    .locals 4

    .prologue
    .line 354
    new-instance v0, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;

    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mAuthMode:Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mSecMode:Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mEncMode:Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    invoke-direct {v0, v1, v2, v3}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;-><init>(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V

    return-object v0
.end method

.method public GetSoftApStatus()Z
    .locals 3

    .prologue
    .line 363
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiManager:Landroid/net/wifi/WifiManager;

    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->getWifiApState()I

    move-result v0

    const/16 v1, 0xd

    if-ne v0, v1, :cond_0

    .line 364
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GetSoftApStatus : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiManager:Landroid/net/wifi/WifiManager;

    invoke-virtual {v2}, Landroid/net/wifi/WifiManager;->getWifiApState()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 365
    const/4 v0, 0x1

    .line 367
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public GetSsid()Ljava/lang/String;
    .locals 1

    .prologue
    .line 372
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mSsid:Ljava/lang/String;

    return-object v0
.end method

.method public GetWepKey1()Ljava/lang/String;
    .locals 1

    .prologue
    .line 378
    const/4 v0, 0x0

    return-object v0
.end method

.method public GetWepKey2()Ljava/lang/String;
    .locals 1

    .prologue
    .line 384
    const/4 v0, 0x0

    return-object v0
.end method

.method public GetWepKey3()Ljava/lang/String;
    .locals 1

    .prologue
    .line 390
    const/4 v0, 0x0

    return-object v0
.end method

.method public GetWepKey4()Ljava/lang/String;
    .locals 1

    .prologue
    .line 396
    const/4 v0, 0x0

    return-object v0
.end method

.method public GetWepKeyIndex()I
    .locals 1

    .prologue
    .line 402
    const/4 v0, -0x1

    return v0
.end method

.method public GetWpaKey()Ljava/lang/String;
    .locals 1

    .prologue
    .line 408
    const/4 v0, 0x0

    return-object v0
.end method

.method public MacFilterremoveAllowedList(Ljava/lang/String;)I
    .locals 4
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x1

    .line 414
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MacFilterremoveAllowedList ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 416
    invoke-static {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->HostapRemoveMacInList(ILjava/lang/String;)Z

    move-result v1

    if-ne v1, v0, :cond_0

    .line 420
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public MacFilterremoveDeniedList(Ljava/lang/String;)I
    .locals 4
    .param p1, "mac"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x1

    .line 427
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MacFilterremoveDeniedList ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 429
    const/4 v1, 0x2

    invoke-static {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->HostapRemoveMacInList(ILjava/lang/String;)Z

    move-result v1

    if-ne v1, v0, :cond_0

    .line 433
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public RetrieveAssoStaMacList()Z
    .locals 1

    .prologue
    .line 506
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->associatedStaMacArrayLst:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 508
    const/4 v0, 0x0

    return v0
.end method

.method public SetApIsolation(Z)Z
    .locals 3
    .param p1, "apIsolation"    # Z

    .prologue
    .line 627
    const/4 v2, 0x1

    if-ne p1, v2, :cond_0

    .line 628
    const/4 v0, 0x1

    .line 633
    .local v0, "ap_int":I
    :goto_0
    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    .line 635
    .local v1, "isolate":Ljava/lang/String;
    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    invoke-virtual {v2, v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setApIsolation(Ljava/lang/String;)Z

    move-result v2

    return v2

    .line 631
    .end local v0    # "ap_int":I
    .end local v1    # "isolate":Ljava/lang/String;
    :cond_0
    const/4 v0, 0x0

    .restart local v0    # "ap_int":I
    goto :goto_0
.end method

.method public SetAutoShutOffTime(I)Z
    .locals 4
    .param p1, "time"    # I

    .prologue
    const/4 v3, 0x0

    .line 661
    invoke-direct {p0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->CheckAutoShutOffTimeValidity(I)Z

    move-result v0

    if-nez v0, :cond_0

    .line 662
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SetAutoShutOffTime : unsupported time ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 666
    :cond_0
    return v3
.end method

.method public SetChannel(I)Z
    .locals 5
    .param p1, "channel"    # I

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 678
    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_frequency"

    invoke-static {v3, v4, v2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 680
    .local v0, "sRet_frequency":I
    if-nez v0, :cond_3

    .line 681
    if-ltz p1, :cond_0

    const/16 v3, 0xe

    if-le p1, v3, :cond_1

    .line 682
    :cond_0
    const-string v1, "WifiHostapApi"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SetChannel : unsupported channel ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v1, v2

    .line 703
    :goto_0
    return v1

    .line 687
    :cond_1
    if-nez p1, :cond_2

    .line 688
    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_2g_channel"

    invoke-static {v2, v3, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 689
    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_2g_channel"

    const/4 v4, 0x6

    invoke-static {v2, v3, v4}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 696
    :goto_1
    const-string v2, "WifiHostapApi"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SetChannel : ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 693
    :cond_2
    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "mhs_2g_channel"

    invoke-static {v2, v3, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 694
    const-string v2, "WifiHostapApi"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "p2pSetSocialChannel : ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 700
    :cond_3
    iget-object v3, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "mhs_5g_channel"

    invoke-static {v3, v4, v2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    .line 702
    const-string v2, "WifiHostapApi"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SetChannel    ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0
.end method

.method public SetCommit()Z
    .locals 2

    .prologue
    .line 716
    const-string v0, "WifiHostapApi"

    const-string v1, "SetCommit ----"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 717
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiManagerProxy:Landroid/net/wifi/WifiManagerProxy;

    if-eqz v0, :cond_0

    .line 726
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public SetCountryCode(Ljava/lang/String;)Z
    .locals 3
    .param p1, "countryCode"    # Ljava/lang/String;

    .prologue
    .line 731
    if-eqz p1, :cond_0

    .line 732
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mhs_country"

    invoke-static {v0, v1, p1}, Landroid/provider/Settings$System;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    .line 733
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetCountryCode : ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 734
    const/4 v0, 0x1

    .line 736
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public SetDisassociateStation(Ljava/lang/String;)Z
    .locals 4
    .param p1, "staMac"    # Ljava/lang/String;

    .prologue
    .line 744
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DISASSOCIATE "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 747
    .local v0, "sCmdVal":Ljava/lang/String;
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SetDisassociateStation : ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 750
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    invoke-virtual {v1, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setApDiassoc(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public SetHiddenSsid(Z)Z
    .locals 3
    .param p1, "hiddenSsid"    # Z

    .prologue
    .line 761
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "p2pSetHideSSID: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 764
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iput-boolean p1, v0, Landroid/net/wifi/WifiConfiguration;->hiddenSSID:Z

    .line 765
    const/4 v0, 0x1

    return v0
.end method

.method public SetMacFilterByIndex(ILjava/lang/String;)Z
    .locals 4
    .param p1, "index"    # I
    .param p2, "bssid"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x1

    .line 781
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setMacFilterByIndex ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 783
    if-ltz p1, :cond_2

    invoke-virtual {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->GetMacFilterCount()I

    move-result v1

    if-ge p1, v1, :cond_2

    .line 788
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->macFilterLst:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge p1, v1, :cond_0

    .line 789
    invoke-direct {p0, p2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->CheckMacAddressValidity(Ljava/lang/String;)Z

    move-result v1

    if-ne v0, v1, :cond_1

    .line 790
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->macFilterLst:Ljava/util/ArrayList;

    invoke-virtual {v1, p1, p2}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 800
    :goto_0
    return v0

    .line 794
    :cond_0
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SetMacFilterByIndex failure : Out of list size["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 800
    :cond_1
    :goto_1
    const/4 v0, 0x0

    goto :goto_0

    .line 797
    :cond_2
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SetMacFilterByIndex failure : Out of index range["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public SetMacFilterCount(I)Z
    .locals 4
    .param p1, "filterCount"    # I

    .prologue
    .line 808
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SetMacFilterCount ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 812
    iput p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterCount:I

    .line 817
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->macFilterLst:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 818
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mMacFilterCount:I

    if-ge v0, v1, :cond_0

    .line 819
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->macFilterLst:Ljava/util/ArrayList;

    const-string v2, "00:00:00:00:00:00"

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 818
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 822
    :cond_0
    const/4 v1, 0x1

    return v1
.end method

.method public SetMacFilterMode(Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;)Z
    .locals 4
    .param p1, "filterMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    .prologue
    const/4 v3, 0x0

    .line 831
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SetMacFilterMode : ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 837
    sget-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ACCEPT_UNLESS_IN_DENY_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    if-ne v0, p1, :cond_0

    .line 848
    invoke-direct {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->AddMacFilterAllowList()Z

    .line 863
    :goto_0
    return v3

    .line 862
    :cond_0
    invoke-direct {p0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->AddMacFilterDenyList()Z

    goto :goto_0
.end method

.method public SetMaxNumOfClients(I)Z
    .locals 5
    .param p1, "numClients"    # I

    .prologue
    const/4 v1, 0x0

    .line 872
    if-ltz p1, :cond_0

    const/16 v2, 0xa

    if-le p1, v2, :cond_2

    .line 873
    :cond_0
    const-string v2, "WifiHostapApi"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SetMaxNumOfClients : unsupported num ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 878
    :cond_1
    :goto_0
    return v1

    .line 876
    :cond_2
    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    .line 878
    .local v0, "max":Ljava/lang/String;
    iget-object v2, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    invoke-virtual {v2, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setMaxClients(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_1

    const/4 v1, 0x1

    goto :goto_0
.end method

.method public SetOperationMode(Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;)Z
    .locals 3
    .param p1, "opMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    .prologue
    .line 882
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SetOperationMode  ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 883
    const/4 v0, 0x0

    return v0
.end method

.method public SetSecurityType(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;)Z
    .locals 1
    .param p1, "secType"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;

    .prologue
    .line 899
    const/4 v0, 0x1

    return v0
.end method

.method public SetSsid(Ljava/lang/String;)Z
    .locals 4
    .param p1, "ssid"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 903
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    array-length v1, v1

    const/16 v2, 0x20

    if-le v1, v2, :cond_1

    .line 904
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SetSsid : not supported ssid length ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 914
    :cond_0
    :goto_0
    return v0

    .line 908
    :cond_1
    if-eqz p1, :cond_0

    .line 909
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiVZWConfig:Landroid/net/wifi/WifiConfiguration;

    iput-object p1, v0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    .line 910
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SetSsid : ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 911
    invoke-virtual {p0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->UpdateSsid(Ljava/lang/String;)V

    .line 912
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public SetWepKey1(Ljava/lang/String;)Z
    .locals 1
    .param p1, "wepKey"    # Ljava/lang/String;

    .prologue
    .line 923
    const/4 v0, 0x0

    return v0
.end method

.method public SetWepKey2(Ljava/lang/String;)Z
    .locals 1
    .param p1, "wepKey"    # Ljava/lang/String;

    .prologue
    .line 932
    const/4 v0, 0x0

    return v0
.end method

.method public SetWepKey3(Ljava/lang/String;)Z
    .locals 1
    .param p1, "wepKey"    # Ljava/lang/String;

    .prologue
    .line 941
    const/4 v0, 0x0

    return v0
.end method

.method public SetWepKey4(Ljava/lang/String;)Z
    .locals 1
    .param p1, "wepKey"    # Ljava/lang/String;

    .prologue
    .line 950
    const/4 v0, 0x0

    return v0
.end method

.method public SetWepKeyIndex(I)Z
    .locals 1
    .param p1, "index"    # I

    .prologue
    .line 955
    const/4 v0, 0x0

    return v0
.end method

.method public SetWpaKey(Ljava/lang/String;)Z
    .locals 1
    .param p1, "phassphrase"    # Ljava/lang/String;

    .prologue
    .line 960
    const/4 v0, 0x0

    return v0
.end method

.method public SyncConfigVaules()V
    .locals 2

    .prologue
    .line 968
    const-string v0, "WifiHostapApi"

    const-string v1, "SyncConfigVaules"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 971
    return-void
.end method

.method public SyncConfigVaulesWithDriver()V
    .locals 2

    .prologue
    .line 979
    const-string v0, "WifiHostapApi"

    const-string v1, "SyncConfigVaulesWithDriver"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 985
    return-void
.end method

.method public UpdateSecurityType(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;)Z
    .locals 4
    .param p1, "secType"    # Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;

    .prologue
    .line 1058
    invoke-virtual {p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->getAuthMode()Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;

    move-result-object v0

    .line 1059
    .local v0, "authMode":Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;
    invoke-virtual {p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->getSecMode()Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;

    move-result-object v2

    .line 1060
    .local v2, "secMode":Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;
    invoke-virtual {p1}, Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityType;->getEncMode()Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;

    move-result-object v1

    .line 1062
    .local v1, "encMode":Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;
    invoke-direct {p0, v0, v2, v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->CheckSecurityTypeValidity(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 1063
    const/4 v3, 0x0

    .line 1069
    :goto_0
    return v3

    .line 1065
    :cond_0
    invoke-direct {p0, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->UpdateAuthMode(Lcom/lge/wifi/impl/wifiSap/WifiSapAuthMode;)V

    .line 1066
    invoke-direct {p0, v2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->UpdateSecurityMode(Lcom/lge/wifi/impl/wifiSap/WifiSapSecurityMode;)V

    .line 1067
    invoke-direct {p0, v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->UpdateEncryptionMode(Lcom/lge/wifi/impl/wifiSap/WifiSapEncryptionMode;)V

    .line 1069
    const/4 v3, 0x1

    goto :goto_0
.end method

.method public UpdateSsid(Ljava/lang/String;)V
    .locals 0
    .param p1, "ssid"    # Ljava/lang/String;

    .prologue
    .line 1073
    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mSsid:Ljava/lang/String;

    .line 1074
    return-void
.end method

.method public getWpsNfcConfTokenFromAP(II)Ljava/lang/String;
    .locals 2
    .param p1, "isEnabled"    # I
    .param p2, "isNDEF"    # I

    .prologue
    .line 1108
    const-string v0, "WifiHostapApi"

    const-string v1, "WPS : getWpsNfcConfTokenFromAP"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1109
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->getWpsNfcConfTokenFromAP(II)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWpsNfcHandoverSelect(I)Ljava/lang/String;
    .locals 2
    .param p1, "isNDEF"    # I

    .prologue
    .line 1113
    const-string v0, "WifiHostapApi"

    const-string v1, "WPS : getWpsNfcHandoverSelect"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1114
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    invoke-virtual {v0, p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->getWpsNfcHandoverSelect(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public removeAlltheList()I
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 449
    const-string v2, "WifiHostapApi"

    const-string v3, "removeAlltheList "

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 451
    const-string v2, "all"

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->HostapRemoveMacInList(ILjava/lang/String;)Z

    move-result v2

    if-ne v2, v0, :cond_0

    .line 455
    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method public removeMacFilterAllowList()I
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 465
    const-string v1, "WifiHostapApi"

    const-string v2, "removeMacFilterAllowList "

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 467
    const-string v1, "all"

    invoke-static {v0, v1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->HostapRemoveMacInList(ILjava/lang/String;)Z

    move-result v1

    if-ne v1, v0, :cond_0

    .line 471
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public removeMacFilterDenyList()I
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 482
    const-string v1, "WifiHostapApi"

    const-string v2, "removeMacFilterDenyList "

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 484
    const/4 v1, 0x2

    const-string v2, "all"

    invoke-static {v1, v2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->HostapRemoveMacInList(ILjava/lang/String;)Z

    move-result v1

    if-ne v1, v0, :cond_0

    .line 488
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setMacaddracl(I)Z
    .locals 4
    .param p1, "value"    # I

    .prologue
    .line 770
    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    .line 771
    .local v0, "addr_acl":Ljava/lang/String;
    const-string v1, "WifiHostapApi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setMacaddracl : ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 773
    iget-object v1, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    invoke-virtual {v1, v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setMacaddracl(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setTxPower(I)I
    .locals 1
    .param p1, "txPower"    # I

    .prologue
    .line 1083
    invoke-static {p1}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setTxPower(I)I

    move-result v0

    return v0
.end method

.method public setWpsCancel()I
    .locals 2

    .prologue
    .line 1093
    const-string v0, "WifiHostapApi"

    const-string v1, "WPS : setWpsCancel"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1094
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setWpsCancel()I

    move-result v0

    return v0
.end method

.method public setWpsNfcPwToken(Ljava/lang/String;II)I
    .locals 2
    .param p1, "NDEF"    # Ljava/lang/String;
    .param p2, "isEnabled"    # I
    .param p3, "isNDEF"    # I

    .prologue
    .line 1103
    const-string v0, "WifiHostapApi"

    const-string v1, "WPS : setWpsNfcPwToken"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1104
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    invoke-virtual {v0, p1, p2, p3}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setWpsNfcPwToken(Ljava/lang/String;II)I

    move-result v0

    return v0
.end method

.method public setWpsNfcReportHandover(Ljava/lang/String;Ljava/lang/String;)I
    .locals 2
    .param p1, "reqNDEF"    # Ljava/lang/String;
    .param p2, "selNDEF"    # Ljava/lang/String;

    .prologue
    .line 1118
    const-string v0, "WifiHostapApi"

    const-string v1, "WPS : setWpsNfcReportHandover"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1119
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setWpsNfcReportHandover(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public setWpsPbc()I
    .locals 2

    .prologue
    .line 1098
    const-string v0, "WifiHostapApi"

    const-string v1, "WPS : setWpsPbc"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1099
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setWpsPbc()I

    move-result v0

    return v0
.end method

.method public setWpsPin(Ljava/lang/String;I)I
    .locals 3
    .param p1, "PinNum"    # Ljava/lang/String;
    .param p2, "expirationTime"    # I

    .prologue
    .line 1088
    const-string v0, "WifiHostapApi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "WPS : setWpsPin expiretime is["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] PinNum is["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1089
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiHostapdApi;->mWifiHostapdNative:Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;

    invoke-virtual {v0, p1, p2}, Lcom/lge/wifi/impl/wifiSap/WifiHostapdNative;->setWpsPin(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method