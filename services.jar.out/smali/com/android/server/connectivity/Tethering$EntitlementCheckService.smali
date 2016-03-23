.class public Lcom/android/server/connectivity/Tethering$EntitlementCheckService;
.super Landroid/app/Service;
.source "Tethering.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/connectivity/Tethering;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "EntitlementCheckService"
.end annotation


# static fields
.field public static final BLUETOOTH:I = 0x2

.field public static final ENTITLEMENT_CHECK_HOST:Ljava/lang/String; = "entitlement.mobile.att.net"

.field private static final ENTITLEMENT_FAIL_CAUSE:Ljava/lang/String; = "fail_cause"

.field private static final ENTITLEMENT_SUCCESS:Ljava/lang/String; = "success"

.field public static final FAILURE_CAUSECODE_33:I = 0x63

.field public static final HIPRI_ENABLE_TIMEOUT:I = 0x14

.field public static final HOTSPOT_CHECK_PAGE:Ljava/lang/String; = "entitlement.mobile.att.net/mhs1"

.field public static final HOTSPOT_CHECK_URL:Ljava/lang/String; = "http://entitlement.mobile.att.net/mhs1"

.field public static final TETHERING_CHECK_PAGE:Ljava/lang/String; = "entitlement.mobile.att.net/teth"

.field public static final TETHERING_CHECK_URL:Ljava/lang/String; = "http://entitlement.mobile.att.net/teth"

.field public static final USB:I = 0x1

.field public static final VIDEOCALLING_CHECK_PAGE:Ljava/lang/String; = "entitlement.mobile.att.net/gvc1"

.field public static final VIDEOCALLING_CHECK_URL:Ljava/lang/String; = "http://entitlement.mobile.att.net/gvc1"

.field public static final WIFI:I

.field private static mIsHIPRIConnectOpen:I


# instance fields
.field private final TAG:Ljava/lang/String;

.field private mAPNIntentFilter:Landroid/content/IntentFilter;

.field mCm:Landroid/net/ConnectivityManager;

.field private mEntitleType:I

.field private mEntitlementCheckType:I

.field public mHandler:Landroid/os/Handler;

.field mWifiManager:Landroid/net/wifi/WifiManager;

.field private timeOutTask:Ljava/lang/Runnable;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 1369
    const/4 v0, 0x0

    sput v0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mIsHIPRIConnectOpen:I

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 1344
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 1345
    const-string v0, "Tethering"

    iput-object v0, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->TAG:Ljava/lang/String;

    .line 1352
    iput v1, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitleType:I

    .line 1353
    iput v1, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitlementCheckType:I

    .line 1371
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mHandler:Landroid/os/Handler;

    .line 1372
    new-instance v0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService$1;

    invoke-direct {v0, p0}, Lcom/android/server/connectivity/Tethering$EntitlementCheckService$1;-><init>(Lcom/android/server/connectivity/Tethering$EntitlementCheckService;)V

    iput-object v0, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->timeOutTask:Ljava/lang/Runnable;

    return-void
.end method

.method private SetupMobileConnection()Z
    .locals 14

    .prologue
    const/4 v13, 0x5

    const/4 v8, 0x1

    const/4 v9, 0x0

    .line 1548
    const/4 v0, 0x1

    .line 1551
    .local v0, "IsTimeout":I
    iget-object v10, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v10, v13}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v5

    .line 1553
    .local v5, "network":Landroid/net/NetworkInfo;
    if-eqz v5, :cond_1

    invoke-virtual {v5}, Landroid/net/NetworkInfo;->isConnectedOrConnecting()Z

    move-result v10

    if-eqz v10, :cond_1

    .line 1554
    const-string v9, "Tethering"

    const-string v10, "[EntitlementCheck] TYPE_MOBILE_HIPRI is already enabled, SKIP to enable it"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1610
    :cond_0
    :goto_0
    return v8

    .line 1559
    :cond_1
    iget-object v10, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    const-string v11, "enableHIPRI"

    invoke-virtual {v10, v9, v11}, Landroid/net/ConnectivityManager;->startUsingNetworkFeature(ILjava/lang/String;)I

    move-result v7

    .line 1560
    .local v7, "resultInt":I
    const-string v10, "Tethering"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "[EntitlementCheck] startUsingNetworkFeature( ), return value = "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1566
    const/4 v10, -0x1

    if-ne v7, v10, :cond_2

    .line 1567
    const-string v8, "Tethering"

    const-string v10, "[EntitlementCheck] Wrong result of startUsingNetworkFeature, maybe problems"

    invoke-static {v8, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v8, v9

    .line 1568
    goto :goto_0

    .line 1570
    :cond_2
    sput v8, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mIsHIPRIConnectOpen:I

    .line 1571
    const-string v4, "entitlement.mobile.att.net"

    .line 1575
    .local v4, "hostname":Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "counter":I
    :goto_1
    const/16 v10, 0x14

    if-ge v1, v10, :cond_3

    .line 1576
    :try_start_0
    iget-object v10, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    const/4 v11, 0x5

    invoke-virtual {v10, v11}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v5

    .line 1577
    const-string v10, "Tethering"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "[EntitlementCheck] Waiting on HIPRI connection, Count = "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1578
    if-eqz v5, :cond_4

    invoke-virtual {v5}, Landroid/net/NetworkInfo;->isConnected()Z
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v10

    if-eqz v10, :cond_4

    .line 1579
    const/4 v0, 0x0

    .line 1589
    :cond_3
    if-ne v0, v8, :cond_5

    .line 1590
    const-string v8, "Tethering"

    const-string v10, "[EntitlementCheck] Timeout on wating mobile network"

    invoke-static {v8, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v8, v9

    .line 1591
    goto :goto_0

    .line 1582
    :cond_4
    const-wide/16 v10, 0x3e8

    :try_start_1
    invoke-static {v10, v11}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0

    .line 1575
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 1584
    :catch_0
    move-exception v2

    .line 1585
    .local v2, "e":Ljava/lang/InterruptedException;
    const-string v8, "Tethering"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[EntitlementCheck] Exception on waiting, Except "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v8, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v8, v9

    .line 1586
    goto/16 :goto_0

    .line 1594
    .end local v2    # "e":Ljava/lang/InterruptedException;
    :cond_5
    const-string v10, "Tethering"

    const-string v11, "start lookupHost()"

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1596
    invoke-direct {p0, v4}, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->lookupHost(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v3

    .line 1597
    .local v3, "hostAddress":Ljava/net/InetAddress;
    if-nez v3, :cond_6

    .line 1598
    const-string v8, "Tethering"

    const-string v10, "[EntitlementCheck] Error on lookupHost()"

    invoke-static {v8, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v8, v9

    .line 1599
    goto/16 :goto_0

    .line 1602
    :cond_6
    const-string v10, "Tethering"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "start requestRouteToHostAddress() with host address = "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1603
    iget-object v10, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v10, v13, v3}, Landroid/net/ConnectivityManager;->requestRouteToHostAddress(ILjava/net/InetAddress;)Z

    move-result v6

    .line 1604
    .local v6, "resultBool":Z
    const-string v10, "Tethering"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "[EntitlementCheck] requestRouteToHost result: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1605
    if-nez v6, :cond_0

    .line 1606
    const-string v8, "Tethering"

    const-string v10, "[EntitlementCheck] Wrong requestRouteToHost result: expected true, but was false"

    invoke-static {v8, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v8, v9

    .line 1607
    goto/16 :goto_0
.end method

.method static synthetic access$600(Lcom/android/server/connectivity/Tethering$EntitlementCheckService;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/server/connectivity/Tethering$EntitlementCheckService;

    .prologue
    .line 1344
    invoke-direct {p0}, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->performServiceLayerEntitlementCheck()I

    move-result v0

    return v0
.end method

.method private getEntitlementCheckType()I
    .locals 3

    .prologue
    .line 1522
    sget-object v0, Lcom/android/server/connectivity/Tethering;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "tether_entitlement_check_type"

    const/4 v2, 0x2

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method private lookupHost(Ljava/lang/String;)Ljava/net/InetAddress;
    .locals 10
    .param p1, "hostname"    # Ljava/lang/String;

    .prologue
    const/4 v6, 0x0

    .line 1529
    :try_start_0
    invoke-static {p1}, Ljava/net/InetAddress;->getAllByName(Ljava/lang/String;)[Ljava/net/InetAddress;
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    .line 1535
    .local v4, "inetAddress":[Ljava/net/InetAddress;
    move-object v1, v4

    .local v1, "arr$":[Ljava/net/InetAddress;
    array-length v5, v1

    .local v5, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_0
    if-ge v3, v5, :cond_2

    aget-object v0, v1, v3

    .line 1536
    .local v0, "a":Ljava/net/InetAddress;
    instance-of v7, v0, Ljava/net/Inet4Address;

    if-eqz v7, :cond_1

    .line 1543
    .end local v0    # "a":Ljava/net/InetAddress;
    .end local v1    # "arr$":[Ljava/net/InetAddress;
    .end local v3    # "i$":I
    .end local v4    # "inetAddress":[Ljava/net/InetAddress;
    .end local v5    # "len$":I
    :cond_0
    :goto_1
    return-object v0

    .line 1530
    :catch_0
    move-exception v2

    .line 1531
    .local v2, "e":Ljava/net/UnknownHostException;
    const-string v7, "Tethering"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Exception on getAllByName(), Exception Msg ="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v0, v6

    .line 1532
    goto :goto_1

    .line 1538
    .end local v2    # "e":Ljava/net/UnknownHostException;
    .restart local v0    # "a":Ljava/net/InetAddress;
    .restart local v1    # "arr$":[Ljava/net/InetAddress;
    .restart local v3    # "i$":I
    .restart local v4    # "inetAddress":[Ljava/net/InetAddress;
    .restart local v5    # "len$":I
    :cond_1
    instance-of v7, v0, Ljava/net/Inet6Address;

    if-nez v7, :cond_0

    .line 1535
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 1542
    .end local v0    # "a":Ljava/net/InetAddress;
    :cond_2
    const-string v7, "Tethering"

    const-string v8, "Failed to find inetAddress in lookupHost(), return NULL"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v0, v6

    .line 1543
    goto :goto_1
.end method

.method private performServiceLayerEntitlementCheck()I
    .locals 14

    .prologue
    const/4 v13, 0x1

    .line 1614
    iget-object v10, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v10, v13}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v3

    .line 1615
    .local v3, "cur_wifi":Landroid/net/NetworkInfo;
    const/4 v7, 0x3

    .line 1616
    .local v7, "ret_code":I
    const/4 v1, 0x0

    .line 1617
    .local v1, "IsTimeout":I
    const/4 v2, 0x0

    .line 1619
    .local v2, "counter":I
    iget-object v10, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v10}, Landroid/net/ConnectivityManager;->getMobileDataEnabled()Z

    move-result v10

    if-nez v10, :cond_0

    .line 1621
    const-string v10, "Tethering"

    const-string v11, "[EntitlementCheck] Data enabler off by the setting menu"

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1622
    const/4 v10, 0x3

    .line 1678
    :goto_0
    return v10

    .line 1625
    :cond_0
    invoke-direct {p0}, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->SetupMobileConnection()Z

    move-result v6

    .line 1626
    .local v6, "ret":Z
    if-eq v6, v13, :cond_1

    .line 1627
    const-string v10, "Tethering"

    const-string v11, "[EntitlementCheck] SetupMobileConnection(), return false"

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v10, v7

    .line 1628
    goto :goto_0

    .line 1631
    :cond_1
    const/4 v9, 0x0

    .line 1636
    .local v9, "urlConnection":Ljava/net/HttpURLConnection;
    :try_start_0
    const-string v10, "Tethering"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "[EntitlementCheck] HTTP Request with mEntitleType = "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget v12, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitleType:I

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1637
    iget v10, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitleType:I

    if-ne v10, v13, :cond_3

    .line 1638
    new-instance v8, Ljava/net/URL;

    const-string v10, "http://entitlement.mobile.att.net/teth"

    invoke-direct {v8, v10}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 1645
    .local v8, "url":Ljava/net/URL;
    :goto_1
    invoke-virtual {v8}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v10

    move-object v0, v10

    check-cast v0, Ljava/net/HttpURLConnection;

    move-object v9, v0

    .line 1646
    const/4 v10, 0x1

    invoke-virtual {v9, v10}, Ljava/net/HttpURLConnection;->setInstanceFollowRedirects(Z)V

    .line 1647
    const/16 v10, 0x2710

    invoke-virtual {v9, v10}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 1648
    const/16 v10, 0x2710

    invoke-virtual {v9, v10}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 1649
    const/4 v10, 0x0

    invoke-virtual {v9, v10}, Ljava/net/HttpURLConnection;->setUseCaches(Z)V

    .line 1652
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v5

    .line 1653
    .local v5, "result":I
    const/16 v10, 0xc8

    if-ne v5, v10, :cond_5

    .line 1654
    const-string v10, "Tethering"

    const-string v11, "[EntitlementCheck] Success"

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/net/ConnectException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1655
    const/4 v7, 0x0

    .line 1677
    :goto_2
    if-eqz v9, :cond_2

    .line 1678
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_2
    move v10, v7

    goto :goto_0

    .line 1639
    .end local v5    # "result":I
    .end local v8    # "url":Ljava/net/URL;
    :cond_3
    :try_start_1
    iget v10, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitleType:I

    const/4 v11, 0x2

    if-ne v10, v11, :cond_4

    .line 1640
    new-instance v8, Ljava/net/URL;

    const-string v10, "http://entitlement.mobile.att.net/teth"

    invoke-direct {v8, v10}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .restart local v8    # "url":Ljava/net/URL;
    goto :goto_1

    .line 1642
    .end local v8    # "url":Ljava/net/URL;
    :cond_4
    new-instance v8, Ljava/net/URL;

    const-string v10, "http://entitlement.mobile.att.net/mhs1"

    invoke-direct {v8, v10}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .restart local v8    # "url":Ljava/net/URL;
    goto :goto_1

    .line 1656
    .restart local v5    # "result":I
    :cond_5
    const/16 v10, 0x193

    if-ne v5, v10, :cond_6

    .line 1657
    const-string v10, "Tethering"

    const-string v11, "[EntitlementCheck] fail cause code 33"

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1658
    const/16 v7, 0x63

    goto :goto_2

    .line 1660
    :cond_6
    const-string v10, "Tethering"

    const-string v11, "[EntitlementCheck] fail temperal network problem"

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/net/UnknownHostException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/net/ConnectException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1661
    const/4 v7, 0x3

    goto :goto_2

    .line 1664
    .end local v5    # "result":I
    .end local v8    # "url":Ljava/net/URL;
    :catch_0
    move-exception v4

    .line 1665
    .local v4, "e":Ljava/net/UnknownHostException;
    :try_start_2
    const-string v10, "Tethering"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Entitlement check - "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1666
    const/4 v7, 0x3

    .line 1677
    if-eqz v9, :cond_7

    .line 1678
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_7
    move v10, v7

    goto/16 :goto_0

    .line 1668
    .end local v4    # "e":Ljava/net/UnknownHostException;
    :catch_1
    move-exception v4

    .line 1669
    .local v4, "e":Ljava/net/ConnectException;
    :try_start_3
    const-string v10, "Tethering"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Entitlement check - "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1670
    const/4 v7, 0x3

    .line 1677
    if-eqz v9, :cond_8

    .line 1678
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_8
    move v10, v7

    goto/16 :goto_0

    .line 1672
    .end local v4    # "e":Ljava/net/ConnectException;
    :catch_2
    move-exception v4

    .line 1673
    .local v4, "e":Ljava/io/IOException;
    :try_start_4
    const-string v10, "Tethering"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Entitlement check - "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 1674
    const/16 v7, 0x63

    .line 1677
    if-eqz v9, :cond_9

    .line 1678
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_9
    move v10, v7

    goto/16 :goto_0

    .line 1677
    .end local v4    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v10

    if-eqz v9, :cond_a

    .line 1678
    invoke-virtual {v9}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_a
    throw v10
.end method


# virtual methods
.method public disableTethering()V
    .locals 11

    .prologue
    const/4 v10, 0x1

    const/4 v9, 0x0

    .line 1482
    const-string v6, "Tethering"

    const-string v7, "[EntitlementCheck] Disable Tethering"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1483
    iget-object v6, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v6}, Landroid/net/ConnectivityManager;->getTetheredIfaces()[Ljava/lang/String;

    move-result-object v4

    .line 1484
    .local v4, "mIfaces":[Ljava/lang/String;
    move-object v0, v4

    .local v0, "arr$":[Ljava/lang/String;
    array-length v2, v0

    .local v2, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_0
    if-ge v1, v2, :cond_1

    aget-object v3, v0, v1

    .line 1485
    .local v3, "mIface":Ljava/lang/String;
    const-string v6, "Tethering"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[EntitlementCheck] Untethering  Interface =>"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1486
    iget-object v6, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v6, v3}, Landroid/net/ConnectivityManager;->untether(Ljava/lang/String;)I

    .line 1487
    const-string v6, "wlan0"

    invoke-virtual {v3, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 1488
    const-string v6, "Tethering"

    const-string v7, "[EntitlementCheck] Disable Mobile Hotspot"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1490
    :try_start_0
    iget-object v6, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mWifiManager:Landroid/net/wifi/WifiManager;

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-virtual {v6, v7, v8}, Landroid/net/wifi/WifiManager;->setWifiApEnabled(Landroid/net/wifi/WifiConfiguration;Z)Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1494
    :goto_1
    sget-object v6, Lcom/android/server/connectivity/Tethering;->mContext:Landroid/content/Context;

    invoke-virtual {v6}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v6

    const-string v7, "wifi_saved_state"

    invoke-static {v6, v7, v9}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v6

    if-ne v6, v10, :cond_0

    .line 1496
    iget-object v6, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mWifiManager:Landroid/net/wifi/WifiManager;

    invoke-virtual {v6, v10}, Landroid/net/wifi/WifiManager;->setWifiEnabled(Z)Z

    .line 1497
    sget-object v6, Lcom/android/server/connectivity/Tethering;->mContext:Landroid/content/Context;

    invoke-virtual {v6}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v6

    const-string v7, "wifi_saved_state"

    invoke-static {v6, v7, v9}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 1484
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1491
    :catch_0
    move-exception v5

    .line 1492
    .local v5, "se":Ljava/lang/SecurityException;
    const-string v6, "Tethering"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "SecurityException : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v5}, Ljava/lang/SecurityException;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 1502
    .end local v3    # "mIface":Ljava/lang/String;
    .end local v5    # "se":Ljava/lang/SecurityException;
    :cond_1
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 2
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 1468
    const-string v0, "Tethering"

    const-string v1, "[EntitlementCheck] onBind()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1470
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreate()V
    .locals 8

    .prologue
    .line 1382
    const-string v5, "Tethering"

    const-string v6, "[EntitlementCheck] onCreate()"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1383
    const-string v5, "connectivity"

    invoke-virtual {p0, v5}, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/net/ConnectivityManager;

    iput-object v5, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    .line 1387
    const-string v5, "wifi"

    invoke-virtual {p0, v5}, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/net/wifi/WifiManager;

    iput-object v5, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mWifiManager:Landroid/net/wifi/WifiManager;

    .line 1388
    invoke-direct {p0}, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->getEntitlementCheckType()I

    move-result v5

    iput v5, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitlementCheckType:I

    .line 1389
    const-string v5, "Tethering"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[EntitlementCheck] onCreate(), mEntitlementCheckType = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitlementCheckType:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1392
    iget-object v5, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v5}, Landroid/net/ConnectivityManager;->getTetheredIfaces()[Ljava/lang/String;

    move-result-object v4

    .line 1393
    .local v4, "mIfaces":[Ljava/lang/String;
    move-object v0, v4

    .local v0, "arr$":[Ljava/lang/String;
    array-length v2, v0

    .local v2, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_0
    if-ge v1, v2, :cond_3

    aget-object v3, v0, v1

    .line 1394
    .local v3, "mIface":Ljava/lang/String;
    const-string v5, "Tethering"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[EntitlementCheck] onCreate() Find Interface =>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1395
    const-string v5, "wlan0"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 1396
    const/4 v5, 0x0

    iput v5, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitleType:I

    .line 1393
    :cond_0
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1397
    :cond_1
    const-string v5, "usb0"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 1398
    const/4 v5, 0x1

    iput v5, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitleType:I

    goto :goto_1

    .line 1399
    :cond_2
    const-string v5, "bt-pan"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 1400
    const/4 v5, 0x2

    iput v5, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitleType:I

    goto :goto_1

    .line 1403
    .end local v3    # "mIface":Ljava/lang/String;
    :cond_3
    return-void
.end method

.method public onDestroy()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 1451
    const-string v0, "Tethering"

    const-string v1, "[EntitlementCheck] onDestroy()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1453
    iget-object v0, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->timeOutTask:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 1455
    iget v0, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitlementCheckType:I

    if-ne v0, v3, :cond_1

    .line 1456
    iget-object v0, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    const-string v1, "enableENTITLEMENT"

    invoke-virtual {v0, v2, v1}, Landroid/net/ConnectivityManager;->stopUsingNetworkFeature(ILjava/lang/String;)I

    .line 1463
    :cond_0
    :goto_0
    return-void

    .line 1458
    :cond_1
    sget v0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mIsHIPRIConnectOpen:I

    if-ne v0, v3, :cond_0

    .line 1459
    iget-object v0, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    const-string v1, "enableHIPRI"

    invoke-virtual {v0, v2, v1}, Landroid/net/ConnectivityManager;->stopUsingNetworkFeature(ILjava/lang/String;)I

    .line 1460
    const-string v0, "Tethering"

    const-string v1, "[EntitlementCheck] stopUsingNetworkFeature() with Phone.FEATURE_ENABLE_HIPRI"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 7
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .prologue
    const/4 v6, 0x1

    .line 1406
    iget v2, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mEntitlementCheckType:I

    if-ne v2, v6, :cond_3

    .line 1407
    iget-object v2, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mCm:Landroid/net/ConnectivityManager;

    const/4 v3, 0x0

    const-string v4, "enableHIPRI"

    invoke-virtual {v2, v3, v4}, Landroid/net/ConnectivityManager;->startUsingNetworkFeature(ILjava/lang/String;)I

    move-result v1

    .line 1410
    .local v1, "result":I
    const/4 v2, 0x2

    if-eq v1, v2, :cond_0

    const/4 v2, 0x3

    if-ne v1, v2, :cond_1

    .line 1412
    :cond_0
    const-string v2, "Tethering"

    const-string v3, "[EntitlementCheck] StartUsingNetwork failed   APN_REQUEST_FAILED"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1413
    invoke-virtual {p0}, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->disableTethering()V

    .line 1414
    invoke-virtual {p0}, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->stopSelf()V

    .line 1447
    .end local v1    # "result":I
    :goto_0
    return v6

    .line 1415
    .restart local v1    # "result":I
    :cond_1
    if-nez v1, :cond_2

    .line 1416
    const-string v2, "Tethering"

    const-string v3, "[EntitlementCheck] StartUsingNetwork APN_ALREADY_ACTIVE"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1417
    invoke-virtual {p0}, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->stopSelf()V

    goto :goto_0

    .line 1419
    :cond_2
    const-string v2, "Tethering"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[EntitlementCheck] onCreate  Entitlement Successfully tried ( "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ")"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "   Set TIMEOUT 30 sec"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1422
    iget-object v2, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/android/server/connectivity/Tethering$EntitlementCheckService;->timeOutTask:Ljava/lang/Runnable;

    const-wide/16 v4, 0x7530

    invoke-virtual {v2, v3, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0

    .line 1425
    .end local v1    # "result":I
    :cond_3
    new-instance v0, Ljava/lang/Thread;

    new-instance v2, Lcom/android/server/connectivity/Tethering$EntitlementCheckService$2;

    invoke-direct {v2, p0}, Lcom/android/server/connectivity/Tethering$EntitlementCheckService$2;-><init>(Lcom/android/server/connectivity/Tethering$EntitlementCheckService;)V

    invoke-direct {v0, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 1445
    .local v0, "conn":Ljava/lang/Thread;
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method public setAlarm_Entitle()V
    .locals 8

    .prologue
    .line 1473
    sget-object v3, Lcom/android/server/connectivity/Tethering;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "tether_entitlement_check_interval"

    const/16 v5, 0x5a0

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    .line 1475
    .local v2, "intervalMin":I
    const-string v3, "Tethering"

    const-string v4, "[EntitlementCheck11] setAlarm_Entitle() "

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1476
    const v3, 0xea60

    mul-int/2addr v3, v2

    int-to-long v0, v3

    .line 1478
    .local v0, "interval":J
    # getter for: Lcom/android/server/connectivity/Tethering;->mManager:Landroid/app/AlarmManager;
    invoke-static {}, Lcom/android/server/connectivity/Tethering;->access$800()Landroid/app/AlarmManager;

    move-result-object v3

    const/4 v4, 0x2

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    add-long/2addr v6, v0

    # getter for: Lcom/android/server/connectivity/Tethering;->mAlarmSender:Landroid/app/PendingIntent;
    invoke-static {}, Lcom/android/server/connectivity/Tethering;->access$700()Landroid/app/PendingIntent;

    move-result-object v5

    invoke-virtual {v3, v4, v6, v7, v5}, Landroid/app/AlarmManager;->setExact(IJLandroid/app/PendingIntent;)V

    .line 1480
    return-void
.end method
