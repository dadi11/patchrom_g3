.class synthetic Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;
.super Ljava/lang/Object;
.source "WifiSapWrapperBcm.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1008
    name = null
.end annotation


# static fields
.field static final synthetic $SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapMacFilterMode:[I

.field static final synthetic $SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapOperationMode:[I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 516
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->values()[Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    sput-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapMacFilterMode:[I

    :try_start_0
    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapMacFilterMode:[I

    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ACCEPT_UNLESS_IN_DENY_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_4

    :goto_0
    :try_start_1
    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapMacFilterMode:[I

    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->DENY_UNLESS_IN_ACCEPT_LIST:Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapMacFilterMode;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_3

    .line 311
    :goto_1
    invoke-static {}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->values()[Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    sput-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapOperationMode:[I

    :try_start_2
    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapOperationMode:[I

    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->IEEE802_11_b:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_2
    .catch Ljava/lang/NoSuchFieldError; {:try_start_2 .. :try_end_2} :catch_2

    :goto_2
    :try_start_3
    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapOperationMode:[I

    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->IEEE802_11_g_only:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_3
    .catch Ljava/lang/NoSuchFieldError; {:try_start_3 .. :try_end_3} :catch_1

    :goto_3
    :try_start_4
    sget-object v0, Lcom/lge/wifi/impl/mobilehotspot/WifiSapWrapperBcm$2;->$SwitchMap$com$lge$wifi$impl$wifiSap$WifiSapOperationMode:[I

    sget-object v1, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->IEEE802_11_bgn:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    invoke-virtual {v1}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->ordinal()I

    move-result v1

    const/4 v2, 0x3

    aput v2, v0, v1
    :try_end_4
    .catch Ljava/lang/NoSuchFieldError; {:try_start_4 .. :try_end_4} :catch_0

    :goto_4
    return-void

    :catch_0
    move-exception v0

    goto :goto_4

    :catch_1
    move-exception v0

    goto :goto_3

    :catch_2
    move-exception v0

    goto :goto_2

    .line 516
    :catch_3
    move-exception v0

    goto :goto_1

    :catch_4
    move-exception v0

    goto :goto_0
.end method