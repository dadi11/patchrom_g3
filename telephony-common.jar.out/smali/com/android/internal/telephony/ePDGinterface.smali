.class public Lcom/android/internal/telephony/ePDGinterface;
.super Ljava/lang/Object;
.source "ePDGinterface.java"


# static fields
.field public static final DISCONNECTED_DONE:I = 0x3e4

.field private static final EVENT_EPDG_WIFI:I = 0x1f7

.field private static final EVENT_PCSCF_ADDR_CHANGED:I = 0x1fa

.field private static final EVENT_PCSCF_DONE:I = 0x1f9

.field private static final EVENT_QOS_CHANGED:I = 0x1f8

.field public static final PCS_CH:I = 0x3e5

.field public static final PCS_INFO:I = 0x3e6

.field public static final QOS_INFO:I = 0x3e7

.field private static final RIL_REQUEST_ePDG_DEACTIVATE_DATA_CALL:I = 0x1f6

.field private static final RIL_REQUEST_ePDG_SETUP_DATA_CALL:I = 0x1f5

.field static final numofpdn:I = 0x5


# instance fields
.field protected final LOG_TAG:Ljava/lang/String;

.field private ePDGList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field ePDGSetupDataCallResult:Ljava/lang/Object;

.field mConnMgr:Landroid/net/IConnectivityManager;

.field protected mIntentReceiver:Landroid/content/BroadcastReceiver;

.field public mIsUsingLGWifi:I

.field public mIsWifiConnected:Z

.field mMyRil:Lcom/android/internal/telephony/RIL;

.field mPhone:Lcom/android/internal/telephony/Phone;

.field private mSendingisAv:I

.field private mWifiInfo:Landroid/net/wifi/WifiInfo;

.field private mWifiLinkProperties:Landroid/net/LinkProperties;

.field mePDGHandler:Landroid/os/Handler;

.field public myaddr:[I

.field public myfeature:I


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/RIL;Lcom/android/internal/telephony/Phone;Landroid/content/Context;)V
    .locals 5
    .param p1, "myRIL"    # Lcom/android/internal/telephony/RIL;
    .param p2, "phone"    # Lcom/android/internal/telephony/Phone;
    .param p3, "con"    # Landroid/content/Context;

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x0

    .line 208
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 72
    const-string v1, "ePDGInterface"

    iput-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->LOG_TAG:Ljava/lang/String;

    .line 76
    iput-object v4, p0, Lcom/android/internal/telephony/ePDGinterface;->ePDGSetupDataCallResult:Ljava/lang/Object;

    .line 92
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->ePDGList:Ljava/util/ArrayList;

    .line 95
    iput v3, p0, Lcom/android/internal/telephony/ePDGinterface;->mSendingisAv:I

    .line 97
    iput-boolean v3, p0, Lcom/android/internal/telephony/ePDGinterface;->mIsWifiConnected:Z

    .line 100
    const/4 v1, 0x6

    new-array v1, v1, [I

    fill-array-data v1, :array_0

    iput-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->myaddr:[I

    .line 101
    iput v3, p0, Lcom/android/internal/telephony/ePDGinterface;->mIsUsingLGWifi:I

    .line 103
    iput v3, p0, Lcom/android/internal/telephony/ePDGinterface;->myfeature:I

    .line 107
    new-instance v1, Lcom/android/internal/telephony/ePDGinterface$1;

    invoke-direct {v1, p0}, Lcom/android/internal/telephony/ePDGinterface$1;-><init>(Lcom/android/internal/telephony/ePDGinterface;)V

    iput-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    .line 136
    const-string v1, "connectivity"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Landroid/net/IConnectivityManager$Stub;->asInterface(Landroid/os/IBinder;)Landroid/net/IConnectivityManager;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mConnMgr:Landroid/net/IConnectivityManager;

    .line 140
    new-instance v1, Lcom/android/internal/telephony/ePDGinterface$2;

    invoke-direct {v1, p0}, Lcom/android/internal/telephony/ePDGinterface$2;-><init>(Lcom/android/internal/telephony/ePDGinterface;)V

    iput-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mePDGHandler:Landroid/os/Handler;

    .line 209
    iput-object p1, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    .line 210
    iget-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p0}, Lcom/android/internal/telephony/RIL;->setePDGinterface(Lcom/android/internal/telephony/ePDGinterface;)V

    .line 211
    iput-object p2, p0, Lcom/android/internal/telephony/ePDGinterface;->mPhone:Lcom/android/internal/telephony/Phone;

    .line 213
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    move-result-object v1

    iget v1, v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    iput v1, p0, Lcom/android/internal/telephony/ePDGinterface;->myfeature:I

    .line 215
    invoke-virtual {p3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "epdg_mode_enable"

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    const/4 v2, 0x5

    if-ne v1, v2, :cond_0

    .line 217
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 218
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "android.net.wifi.STATE_CHANGE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 219
    iget-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p3, v1, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 222
    .end local v0    # "filter":Landroid/content/IntentFilter;
    :cond_0
    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_QOS_NOTIFY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 223
    iget-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mePDGHandler:Landroid/os/Handler;

    const/16 v3, 0x1f8

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/internal/telephony/RIL;->registerForDataQosChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 225
    :cond_1
    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_PCSCF_RESTORATION:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 226
    iget-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mePDGHandler:Landroid/os/Handler;

    const/16 v3, 0x1fa

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/internal/telephony/RIL;->registerForPcscfAddrChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 228
    :cond_2
    return-void

    .line 100
    :array_0
    .array-data 4
        0x0
        0x0
        0x0
        0x0
        0x0
        0x0
    .end array-data
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/ePDGinterface;)Landroid/net/LinkProperties;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/ePDGinterface;

    .prologue
    .line 69
    iget-object v0, p0, Lcom/android/internal/telephony/ePDGinterface;->mWifiLinkProperties:Landroid/net/LinkProperties;

    return-object v0
.end method

.method static synthetic access$002(Lcom/android/internal/telephony/ePDGinterface;Landroid/net/LinkProperties;)Landroid/net/LinkProperties;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/ePDGinterface;
    .param p1, "x1"    # Landroid/net/LinkProperties;

    .prologue
    .line 69
    iput-object p1, p0, Lcom/android/internal/telephony/ePDGinterface;->mWifiLinkProperties:Landroid/net/LinkProperties;

    return-object p1
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/ePDGinterface;)Landroid/net/wifi/WifiInfo;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/ePDGinterface;

    .prologue
    .line 69
    iget-object v0, p0, Lcom/android/internal/telephony/ePDGinterface;->mWifiInfo:Landroid/net/wifi/WifiInfo;

    return-object v0
.end method

.method static synthetic access$102(Lcom/android/internal/telephony/ePDGinterface;Landroid/net/wifi/WifiInfo;)Landroid/net/wifi/WifiInfo;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/ePDGinterface;
    .param p1, "x1"    # Landroid/net/wifi/WifiInfo;

    .prologue
    .line 69
    iput-object p1, p0, Lcom/android/internal/telephony/ePDGinterface;->mWifiInfo:Landroid/net/wifi/WifiInfo;

    return-object p1
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/ePDGinterface;Landroid/os/AsyncResult;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/ePDGinterface;
    .param p1, "x1"    # Landroid/os/AsyncResult;

    .prologue
    .line 69
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/ePDGinterface;->onQoSChanged(Landroid/os/AsyncResult;)V

    return-void
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/ePDGinterface;Landroid/os/AsyncResult;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/ePDGinterface;
    .param p1, "x1"    # Landroid/os/AsyncResult;

    .prologue
    .line 69
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/ePDGinterface;->onGetPcscfAddressCompleted(Landroid/os/AsyncResult;)V

    return-void
.end method

.method static synthetic access$400(Lcom/android/internal/telephony/ePDGinterface;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/ePDGinterface;

    .prologue
    .line 69
    invoke-direct {p0}, Lcom/android/internal/telephony/ePDGinterface;->onNotifyPCS()V

    return-void
.end method

.method static ePDGcommandString(I)Ljava/lang/String;
    .locals 1
    .param p0, "request"    # I

    .prologue
    .line 748
    sparse-switch p0, :sswitch_data_0

    .line 753
    const-string v0, "unknown ePDG req"

    :goto_0
    return-object v0

    .line 750
    :sswitch_0
    const-string v0, "RIL_REQUEST_VSS_ePDG_SET_PREF_TECH"

    goto :goto_0

    .line 751
    :sswitch_1
    const-string v0, "RIL_REQUEST_WIFI_AVAILABLE"

    goto :goto_0

    .line 752
    :sswitch_2
    const-string v0, "UNSOL_EPCSTATUS"

    goto :goto_0

    .line 748
    nop

    :sswitch_data_0
    .sparse-switch
        0x172 -> :sswitch_0
        0x173 -> :sswitch_1
        0x415 -> :sswitch_2
    .end sparse-switch
.end method

.method static isePDGrequest(I)Z
    .locals 1
    .param p0, "reqorunsol"    # I

    .prologue
    const/4 v0, 0x1

    .line 673
    sparse-switch p0, :sswitch_data_0

    .line 682
    const/4 v0, 0x0

    :sswitch_0
    return v0

    .line 673
    :sswitch_data_0
    .sparse-switch
        0x172 -> :sswitch_0
        0x173 -> :sswitch_0
        0x415 -> :sswitch_0
    .end sparse-switch
.end method

.method private onGetPcscfAddressCompleted(Landroid/os/AsyncResult;)V
    .locals 12
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    .line 649
    iget-object v0, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v0, :cond_0

    .line 650
    const-string v0, "onGetPcscfAddressCompleted, there is Exception"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 660
    :goto_0
    return-void

    .line 653
    :cond_0
    iget-object v0, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    move-object v5, v0

    check-cast v5, Ljava/lang/String;

    .line 655
    .local v5, "result":Ljava/lang/String;
    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/ePDGinterface;->mConnMgr:Landroid/net/IConnectivityManager;

    const/16 v1, 0x3e6

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-interface/range {v0 .. v11}, Landroid/net/IConnectivityManager;->notifyEPDGCallResult(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 656
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private onNotifyPCS()V
    .locals 12

    .prologue
    .line 665
    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/ePDGinterface;->mConnMgr:Landroid/net/IConnectivityManager;

    const/16 v1, 0x3e5

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-interface/range {v0 .. v11}, Landroid/net/IConnectivityManager;->notifyEPDGCallResult(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 668
    :goto_0
    return-void

    .line 666
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private onQoSChanged(Landroid/os/AsyncResult;)V
    .locals 12
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    .line 613
    const-string v0, "onGetQoSChanged : ENTRY"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 615
    const/4 v5, 0x0

    .line 621
    .local v5, "result":Ljava/lang/String;
    iget-object v0, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    instance-of v0, v0, Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 623
    iget-object v5, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    .end local v5    # "result":Ljava/lang/String;
    check-cast v5, Ljava/lang/String;

    .line 624
    .restart local v5    # "result":Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " GET QoS Info: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 633
    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/ePDGinterface;->mConnMgr:Landroid/net/IConnectivityManager;

    const/16 v1, 0x3e7

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-interface/range {v0 .. v11}, Landroid/net/IConnectivityManager;->notifyEPDGCallResult(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 642
    :goto_0
    return-void

    .line 628
    :cond_0
    const-string v0, "onQoSChanged : EXIT with Error, result is not String object"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 634
    :catch_0
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method public ConvtRespEPDGSetupDataCall(Lcom/android/internal/telephony/dataconnection/DataCallResponse;Ljava/lang/String;)V
    .locals 25
    .param p1, "dc"    # Lcom/android/internal/telephony/dataconnection/DataCallResponse;
    .param p2, "apntype"    # Ljava/lang/String;

    .prologue
    .line 392
    move-object/from16 v0, p1

    iget v3, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->version:I

    .line 393
    .local v3, "eVersion":I
    move-object/from16 v0, p1

    iget v4, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->status:I

    .line 394
    .local v4, "eStatus":I
    move-object/from16 v0, p1

    iget v5, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->cid:I

    .line 395
    .local v5, "eCid":I
    move-object/from16 v0, p1

    iget v6, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->active:I

    .line 396
    .local v6, "eActive":I
    move-object/from16 v0, p1

    iget-object v7, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->type:Ljava/lang/String;

    .line 397
    .local v7, "eType":Ljava/lang/String;
    move-object/from16 v0, p1

    iget-object v8, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->ifname:Ljava/lang/String;

    .line 398
    .local v8, "eIfname":Ljava/lang/String;
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->addresses:[Ljava/lang/String;

    move-object/from16 v18, v0

    .line 399
    .local v18, "addresses":[Ljava/lang/String;
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->dnses:[Ljava/lang/String;

    move-object/from16 v21, v0

    .line 400
    .local v21, "dnses":[Ljava/lang/String;
    move-object/from16 v0, p1

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->gateways:[Ljava/lang/String;

    move-object/from16 v22, v0

    .line 401
    .local v22, "gateways":[Ljava/lang/String;
    move-object/from16 v0, p1

    iget v12, v0, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->suggestedRetryTime:I

    .line 403
    .local v12, "suggestedRetryTime":I
    new-instance v14, Ljava/lang/StringBuffer;

    invoke-direct {v14}, Ljava/lang/StringBuffer;-><init>()V

    .line 404
    .local v14, "EAddr":Ljava/lang/StringBuffer;
    new-instance v15, Ljava/lang/StringBuffer;

    invoke-direct {v15}, Ljava/lang/StringBuffer;-><init>()V

    .line 405
    .local v15, "EDnses":Ljava/lang/StringBuffer;
    new-instance v16, Ljava/lang/StringBuffer;

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuffer;-><init>()V

    .line 407
    .local v16, "EGateways":Ljava/lang/StringBuffer;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[ePDG] ConvtRespEPDGSetupDataCall : "

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 408
    move-object/from16 v19, v18

    .local v19, "arr$":[Ljava/lang/String;
    move-object/from16 v0, v19

    array-length v0, v0

    move/from16 v24, v0

    .local v24, "len$":I
    const/16 v23, 0x0

    .local v23, "i$":I
    :goto_0
    move/from16 v0, v23

    move/from16 v1, v24

    if-ge v0, v1, :cond_0

    aget-object v17, v19, v23

    .line 409
    .local v17, "addr":Ljava/lang/String;
    move-object/from16 v0, v17

    invoke-virtual {v14, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 410
    const-string v2, ","

    invoke-virtual {v14, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 408
    add-int/lit8 v23, v23, 0x1

    goto :goto_0

    .line 412
    .end local v17    # "addr":Ljava/lang/String;
    :cond_0
    move-object/from16 v0, v18

    array-length v2, v0

    if-lez v2, :cond_1

    invoke-virtual {v14}, Ljava/lang/StringBuffer;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v14, v2}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 414
    :cond_1
    move-object/from16 v19, v21

    move-object/from16 v0, v19

    array-length v0, v0

    move/from16 v24, v0

    const/16 v23, 0x0

    :goto_1
    move/from16 v0, v23

    move/from16 v1, v24

    if-ge v0, v1, :cond_2

    aget-object v17, v19, v23

    .line 415
    .restart local v17    # "addr":Ljava/lang/String;
    move-object/from16 v0, v17

    invoke-virtual {v15, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 416
    const-string v2, ","

    invoke-virtual {v15, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 414
    add-int/lit8 v23, v23, 0x1

    goto :goto_1

    .line 418
    .end local v17    # "addr":Ljava/lang/String;
    :cond_2
    move-object/from16 v0, v21

    array-length v2, v0

    if-lez v2, :cond_3

    invoke-virtual {v15}, Ljava/lang/StringBuffer;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v15, v2}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 420
    :cond_3
    move-object/from16 v19, v22

    move-object/from16 v0, v19

    array-length v0, v0

    move/from16 v24, v0

    const/16 v23, 0x0

    :goto_2
    move/from16 v0, v23

    move/from16 v1, v24

    if-ge v0, v1, :cond_4

    aget-object v17, v19, v23

    .line 421
    .restart local v17    # "addr":Ljava/lang/String;
    invoke-virtual/range {v16 .. v17}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 422
    const-string v2, ","

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 420
    add-int/lit8 v23, v23, 0x1

    goto :goto_2

    .line 424
    .end local v17    # "addr":Ljava/lang/String;
    :cond_4
    move-object/from16 v0, v22

    array-length v2, v0

    if-lez v2, :cond_5

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuffer;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->deleteCharAt(I)Ljava/lang/StringBuffer;

    .line 425
    :cond_5
    invoke-virtual {v14}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v15}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual/range {v16 .. v16}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v11

    move-object/from16 v2, p0

    move-object/from16 v13, p2

    invoke-virtual/range {v2 .. v13}, Lcom/android/internal/telephony/ePDGinterface;->notifyEPDGCallResult(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V

    .line 427
    new-instance v20, Ljava/lang/Integer;

    move-object/from16 v0, v20

    invoke-direct {v0, v5}, Ljava/lang/Integer;-><init>(I)V

    .line 428
    .local v20, "currentCid":Ljava/lang/Integer;
    if-ltz v5, :cond_6

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/ePDGinterface;->ePDGList:Ljava/util/ArrayList;

    move-object/from16 v0, v20

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_6

    .line 430
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/ePDGinterface;->ePDGList:Ljava/util/ArrayList;

    move-object/from16 v0, v20

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 433
    :cond_6
    return-void
.end method

.method public ePDGDeactivateDataCall(Ljava/lang/String;IILandroid/os/Message;)V
    .locals 7
    .param p1, "apntype"    # Ljava/lang/String;
    .param p2, "cid"    # I
    .param p3, "reason"    # I
    .param p4, "result"    # Landroid/os/Message;

    .prologue
    .line 232
    move v1, p3

    .line 233
    .local v1, "eReason":I
    const/4 v3, 0x0

    .line 235
    .local v3, "num":I
    iget-object v5, p0, Lcom/android/internal/telephony/ePDGinterface;->mePDGHandler:Landroid/os/Handler;

    const/16 v6, 0x1f6

    invoke-virtual {v5, v6, p1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    .line 237
    .local v2, "msgResult":Landroid/os/Message;
    const/16 v5, 0x29

    invoke-static {v5, v2}, Lcom/android/internal/telephony/RILRequest;->obtain(ILandroid/os/Message;)Lcom/android/internal/telephony/RILRequest;

    move-result-object v4

    .line 239
    .local v4, "rr":Lcom/android/internal/telephony/RILRequest;
    iget-object v5, v4, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    const/4 v6, 0x2

    invoke-virtual {v5, v6}, Landroid/os/Parcel;->writeInt(I)V

    .line 240
    iget-object v5, v4, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-static {p2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 241
    iget-object v5, v4, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 243
    iget-object v5, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v5, v4}, Lcom/android/internal/telephony/RIL;->send(Lcom/android/internal/telephony/RILRequest;)V

    .line 244
    const-string v5, "RIL_REQUEST_ePDG_DEACTIVATE_DATA_CALL send ======>"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 245
    new-instance v0, Ljava/lang/Integer;

    invoke-direct {v0, p2}, Ljava/lang/Integer;-><init>(I)V

    .line 246
    .local v0, "currentCid":Ljava/lang/Integer;
    iget-object v5, p0, Lcom/android/internal/telephony/ePDGinterface;->ePDGList:Ljava/util/ArrayList;

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 247
    return-void
.end method

.method public ePDGSetupDataCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "radioTechnology"    # Ljava/lang/String;
    .param p2, "profile"    # Ljava/lang/String;
    .param p3, "apn"    # Ljava/lang/String;
    .param p4, "user"    # Ljava/lang/String;
    .param p5, "password"    # Ljava/lang/String;
    .param p6, "authType"    # Ljava/lang/String;
    .param p7, "protocol"    # Ljava/lang/String;
    .param p8, "apntype"    # Ljava/lang/String;

    .prologue
    .line 254
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mePDGHandler:Landroid/os/Handler;

    const/16 v3, 0x1f5

    invoke-virtual {v2, v3, p8}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .line 256
    .local v0, "msgResult":Landroid/os/Message;
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    iget v2, v2, Lcom/android/internal/telephony/RIL;->testmode:I

    const/4 v3, 0x5

    if-ne v2, v3, :cond_0

    .line 258
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    iput-object p7, v2, Lcom/android/internal/telephony/RIL;->Emulprotocol:Ljava/lang/String;

    .line 259
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    const/16 v3, 0xb

    invoke-virtual {v2, v3, v0}, Lcom/android/internal/telephony/RIL;->emulNetworkState(ILandroid/os/Message;)V

    .line 295
    :goto_0
    return-void

    .line 262
    :cond_0
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    iget v2, v2, Lcom/android/internal/telephony/RIL;->testmode:I

    const/4 v3, 0x2

    if-ne v2, v3, :cond_1

    .line 263
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    const/16 v3, 0xc

    invoke-virtual {v2, v3, v0}, Lcom/android/internal/telephony/RIL;->emulNetworkState(ILandroid/os/Message;)V

    goto :goto_0

    .line 270
    :cond_1
    const/16 v2, 0x1b

    invoke-static {v2, v0}, Lcom/android/internal/telephony/RILRequest;->obtain(ILandroid/os/Message;)Lcom/android/internal/telephony/RILRequest;

    move-result-object v1

    .line 273
    .local v1, "rr":Lcom/android/internal/telephony/RILRequest;
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    const/4 v3, 0x7

    invoke-virtual {v2, v3}, Landroid/os/Parcel;->writeInt(I)V

    .line 275
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v2, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 276
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v2, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 277
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v2, p3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 278
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v2, p4}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 279
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v2, p5}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 280
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v2, p6}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 281
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v2, p7}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 283
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Lcom/android/internal/telephony/RILRequest;->serialString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    iget v3, v1, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    invoke-static {v3}, Lcom/android/internal/telephony/RIL;->requestToString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 287
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v2, v1}, Lcom/android/internal/telephony/RIL;->send(Lcom/android/internal/telephony/RILRequest;)V

    goto/16 :goto_0
.end method

.method public getPcscfAddress(ILjava/lang/String;)V
    .locals 3
    .param p1, "cid"    # I
    .param p2, "ipv"    # Ljava/lang/String;

    .prologue
    .line 514
    iget-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mePDGHandler:Landroid/os/Handler;

    const/16 v2, 0x1f9

    invoke-virtual {v1, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    .line 516
    .local v0, "msgResult":Landroid/os/Message;
    iget-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p1, p2, v0}, Lcom/android/internal/telephony/RIL;->getPcscfAddress(ILjava/lang/String;Landroid/os/Message;)V

    .line 517
    return-void
.end method

.method protected log(Ljava/lang/String;)V
    .locals 1
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    .line 759
    const-string v0, "ePDGInterface"

    invoke-static {v0, p1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 760
    return-void
.end method

.method makeAddrString(Ljava/lang/String;)V
    .locals 8
    .param p1, "macAddr"    # Ljava/lang/String;

    .prologue
    .line 540
    const-string v6, ":"

    invoke-virtual {p1, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .line 542
    .local v5, "result":[Ljava/lang/String;
    const/4 v2, 0x0

    .line 543
    .local v2, "i":I
    move-object v1, v5

    .local v1, "arr$":[Ljava/lang/String;
    array-length v4, v1

    .local v4, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_0
    if-ge v3, v4, :cond_0

    aget-object v0, v1, v3

    .line 545
    .local v0, "addr":Ljava/lang/String;
    iget-object v6, p0, Lcom/android/internal/telephony/ePDGinterface;->myaddr:[I

    const/16 v7, 0x10

    invoke-static {v0, v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;I)I

    move-result v7

    aput v7, v6, v2

    .line 546
    add-int/lit8 v2, v2, 0x1

    .line 547
    const/4 v6, 0x6

    if-ne v2, v6, :cond_1

    .line 551
    .end local v0    # "addr":Ljava/lang/String;
    :cond_0
    return-void

    .line 543
    .restart local v0    # "addr":Ljava/lang/String;
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0
.end method

.method public notifyEPDGCallResult(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    .locals 13
    .param p1, "version"    # I
    .param p2, "status"    # I
    .param p3, "cid"    # I
    .param p4, "active"    # I
    .param p5, "type"    # Ljava/lang/String;
    .param p6, "ifname"    # Ljava/lang/String;
    .param p7, "addresses"    # Ljava/lang/String;
    .param p8, "dnses"    # Ljava/lang/String;
    .param p9, "gateways"    # Ljava/lang/String;
    .param p10, "suggestedRetryTime"    # I
    .param p11, "apntype"    # Ljava/lang/String;

    .prologue
    .line 440
    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/ePDGinterface;->mConnMgr:Landroid/net/IConnectivityManager;

    move v1, p1

    move v2, p2

    move/from16 v3, p3

    move/from16 v4, p4

    move-object/from16 v5, p5

    move-object/from16 v6, p6

    move-object/from16 v7, p7

    move-object/from16 v8, p8

    move-object/from16 v9, p9

    move/from16 v10, p10

    move-object/from16 v11, p11

    invoke-interface/range {v0 .. v11}, Landroid/net/IConnectivityManager;->notifyEPDGCallResult(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 444
    :goto_0
    return-void

    .line 441
    :catch_0
    move-exception v12

    .line 442
    .local v12, "e":Landroid/os/RemoteException;
    const-string v0, "notifyEPDGCallResult RemoteException !!"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public notifyEPDGPDNStatus(Ljava/util/ArrayList;)V
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/dataconnection/DataCallResponse;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 450
    .local p1, "dcrList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/dataconnection/DataCallResponse;>;"
    const/4 v0, 0x0

    .line 451
    .local v0, "eActive":I
    const/4 v2, 0x0

    .line 452
    .local v2, "found":Z
    const/4 v6, 0x0

    .line 454
    .local v6, "mycid":I
    iget-object v8, p0, Lcom/android/internal/telephony/ePDGinterface;->ePDGList:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v7

    .line 456
    .local v7, "num":I
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[ePDG] notifyEPDGPDNStatus start size="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 458
    if-nez v7, :cond_1

    .line 509
    :cond_0
    return-void

    .line 463
    :cond_1
    iget-object v8, p0, Lcom/android/internal/telephony/ePDGinterface;->ePDGList:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/ArrayList;

    .line 465
    .local v5, "listclone":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Integer;>;"
    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :cond_2
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    .line 467
    .local v1, "eCid":Ljava/lang/Integer;
    const/4 v2, 0x0

    .line 468
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v6

    .line 470
    const/4 v4, 0x0

    .local v4, "k":I
    :goto_1
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v8

    if-ge v4, v8, :cond_4

    .line 472
    invoke-virtual {p1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse;

    iget v8, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->cid:I

    if-eq v6, v8, :cond_3

    .line 474
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "check cid="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " list cid= "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {p1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse;

    iget v8, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->cid:I

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 470
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 477
    :cond_3
    invoke-virtual {p1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse;

    iget v0, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse;->active:I

    .line 481
    if-nez v0, :cond_5

    .line 483
    :try_start_0
    iget-object v8, p0, Lcom/android/internal/telephony/ePDGinterface;->mConnMgr:Landroid/net/IConnectivityManager;

    const/4 v9, 0x0

    const/4 v10, 0x0

    const-string v11, "notused"

    invoke-interface {v8, v9, v6, v10, v11}, Landroid/net/IConnectivityManager;->notifyEPDGPDNStatus(IIILjava/lang/String;)V

    .line 484
    iget-object v8, p0, Lcom/android/internal/telephony/ePDGinterface;->ePDGList:Ljava/util/ArrayList;

    invoke-virtual {v8, v1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 492
    :goto_2
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "notifyEPDGPDNStatus send :  "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1

    .line 495
    :goto_3
    const/4 v2, 0x1

    .line 498
    :cond_4
    if-nez v2, :cond_2

    .line 500
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " is not exist, so this is disconnected!! "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 502
    :try_start_1
    iget-object v8, p0, Lcom/android/internal/telephony/ePDGinterface;->mConnMgr:Landroid/net/IConnectivityManager;

    const/4 v9, 0x0

    const/4 v10, 0x0

    const-string v11, "NotUsed"

    invoke-interface {v8, v9, v6, v10, v11}, Landroid/net/IConnectivityManager;->notifyEPDGPDNStatus(IIILjava/lang/String;)V

    .line 503
    iget-object v8, p0, Lcom/android/internal/telephony/ePDGinterface;->ePDGList:Ljava/util/ArrayList;

    invoke-virtual {v8, v1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 504
    :catch_0
    move-exception v8

    goto/16 :goto_0

    .line 488
    :cond_5
    :try_start_2
    invoke-virtual {p1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse;

    const/4 v9, 0x0

    invoke-virtual {p0, v8, v9}, Lcom/android/internal/telephony/ePDGinterface;->ConvtRespEPDGSetupDataCall(Lcom/android/internal/telephony/dataconnection/DataCallResponse;Ljava/lang/String;)V
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_2

    .line 493
    :catch_1
    move-exception v8

    goto :goto_3
.end method

.method public notifyToEPDGClient([I)V
    .locals 6
    .param p1, "status"    # [I

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    .line 315
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "notifyToEPDGClient <======  status : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    aget v3, p1, v5

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " profileID = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    aget v3, p1, v4

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 316
    const/4 v1, 0x0

    .line 319
    .local v1, "extendedRAT":I
    aget v1, p1, v5

    .line 322
    if-nez v1, :cond_0

    .line 324
    const-string v2, "extendedRAT reported UNKNOWN!!"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 328
    :cond_0
    aget v2, p1, v4

    const/16 v3, 0x9

    if-eq v2, v3, :cond_2

    .line 330
    iget v2, p0, Lcom/android/internal/telephony/ePDGinterface;->myfeature:I

    if-ne v2, v4, :cond_1

    aget v2, p1, v4

    if-eq v2, v4, :cond_1

    .line 332
    const-string v2, "it is not ims pdn so go out!!"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 347
    :goto_0
    return-void

    .line 335
    :cond_1
    iget v2, p0, Lcom/android/internal/telephony/ePDGinterface;->myfeature:I

    const/16 v3, 0xb

    if-ne v2, v3, :cond_2

    aget v2, p1, v4

    const/4 v3, 0x2

    if-eq v2, v3, :cond_2

    .line 337
    const-string v2, "it is not ims pdn so go out!!"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 343
    :cond_2
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mConnMgr:Landroid/net/IConnectivityManager;

    invoke-interface {v2, v1}, Landroid/net/IConnectivityManager;->ePDGHandOverStatus(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 344
    :catch_0
    move-exception v0

    .line 345
    .local v0, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[ePDG] notifyToEPDGClient RemoteException : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method protected processCallBackUnSoli(ILjava/lang/Object;)V
    .locals 0
    .param p1, "requestCommand"    # I
    .param p2, "qcrildata"    # Ljava/lang/Object;

    .prologue
    .line 733
    packed-switch p1, :pswitch_data_0

    .line 743
    .end local p2    # "qcrildata":Ljava/lang/Object;
    :goto_0
    return-void

    .line 736
    .restart local p2    # "qcrildata":Ljava/lang/Object;
    :pswitch_0
    check-cast p2, [I

    .end local p2    # "qcrildata":Ljava/lang/Object;
    check-cast p2, [I

    invoke-virtual {p0, p2}, Lcom/android/internal/telephony/ePDGinterface;->notifyToEPDGClient([I)V

    goto :goto_0

    .line 733
    :pswitch_data_0
    .packed-switch 0x415
        :pswitch_0
    .end packed-switch
.end method

.method public processSoli(ILandroid/os/Parcel;)Ljava/lang/Object;
    .locals 3
    .param p1, "requestCommand"    # I
    .param p2, "p"    # Landroid/os/Parcel;

    .prologue
    .line 718
    const/4 v0, 0x0

    .line 719
    .local v0, "ret":Ljava/lang/Object;
    packed-switch p1, :pswitch_data_0

    .line 726
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unrecognized solicited response: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 729
    :pswitch_0
    return-object v0

    .line 719
    nop

    :pswitch_data_0
    .packed-switch 0x172
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public processSolicited(ILandroid/os/Parcel;)Ljava/lang/Object;
    .locals 3
    .param p1, "requestCommand"    # I
    .param p2, "p"    # Landroid/os/Parcel;

    .prologue
    .line 688
    const/4 v0, 0x0

    .line 689
    .local v0, "ret":Ljava/lang/Object;
    packed-switch p1, :pswitch_data_0

    .line 696
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unrecognized solicited response: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 699
    :pswitch_0
    return-object v0

    .line 689
    nop

    :pswitch_data_0
    .packed-switch 0x172
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public processUnSoli(ILandroid/os/Parcel;)Ljava/lang/Object;
    .locals 3
    .param p1, "requestCommand"    # I
    .param p2, "p"    # Landroid/os/Parcel;

    .prologue
    .line 704
    const/4 v0, 0x0

    .line 705
    .local v0, "ret":Ljava/lang/Object;
    packed-switch p1, :pswitch_data_0

    .line 710
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unrecognized unsolicited response: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 713
    .end local v0    # "ret":Ljava/lang/Object;
    :goto_0
    return-object v0

    .line 707
    .restart local v0    # "ret":Ljava/lang/Object;
    :pswitch_0
    iget-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, p2}, Lcom/android/internal/telephony/RIL;->responseInts(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    .line 705
    :pswitch_data_0
    .packed-switch 0x415
        :pswitch_0
    .end packed-switch
.end method

.method public responseSetePDGPrefTech(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 3
    .param p1, "p"    # Landroid/os/Parcel;

    .prologue
    .line 523
    const-string v1, "responseSetePDGPrefTech-entered"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 526
    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mConnMgr:Landroid/net/IConnectivityManager;

    const/4 v2, 0x1

    invoke-interface {v1, v2}, Landroid/net/IConnectivityManager;->ePDGPrefTechdone(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 531
    :goto_0
    const/4 v1, 0x0

    return-object v1

    .line 528
    :catch_0
    move-exception v0

    .line 529
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[ePDG] responseSetePDGPrefTech RemoteException : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public sendWifiStatustoModem(ZLjava/util/Collection;Ljava/lang/String;)V
    .locals 9
    .param p1, "isavail"    # Z
    .param p3, "macAddr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Ljava/util/Collection",
            "<",
            "Landroid/net/LinkAddress;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .local p2, "address":Ljava/util/Collection;, "Ljava/util/Collection<Landroid/net/LinkAddress;>;"
    const/16 v8, 0x1f7

    const/4 v7, 0x0

    .line 555
    const/4 v3, 0x0

    .line 556
    .local v3, "myAddr":Ljava/net/InetAddress;
    const/4 v4, 0x0

    .line 559
    .local v4, "mywifiAddr":I
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[EPDG]sendWifiStatustoModem: macAddr="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 561
    if-nez p1, :cond_0

    .line 564
    const/4 v5, 0x0

    iget-object v6, p0, Lcom/android/internal/telephony/ePDGinterface;->mePDGHandler:Landroid/os/Handler;

    invoke-virtual {v6, v8}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v6

    invoke-virtual {p0, v7, v5, v7, v6}, Lcom/android/internal/telephony/ePDGinterface;->setWifiAvaiable(I[IILandroid/os/Message;)V

    .line 605
    :goto_0
    return-void

    .line 570
    :cond_0
    invoke-virtual {p0, p3}, Lcom/android/internal/telephony/ePDGinterface;->makeAddrString(Ljava/lang/String;)V

    .line 574
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    const/4 v5, 0x6

    if-ge v1, v5, :cond_1

    .line 576
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[EPDG] macAddr ["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " ]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/ePDGinterface;->myaddr:[I

    aget v6, v6, v1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 574
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 579
    :cond_1
    invoke-interface {p2}, Ljava/util/Collection;->size()I

    move-result v5

    if-eqz v5, :cond_2

    .line 581
    invoke-interface {p2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/LinkAddress;

    .line 584
    .local v0, "adr":Landroid/net/LinkAddress;
    invoke-virtual {v0}, Landroid/net/LinkAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object v3

    .line 588
    instance-of v5, v3, Ljava/net/Inet4Address;

    if-eqz v5, :cond_3

    .line 593
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[EPDG]we found IPv4 addr!!! "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 604
    .end local v0    # "adr":Landroid/net/LinkAddress;
    .end local v2    # "i$":Ljava/util/Iterator;
    :cond_2
    const/4 v5, 0x1

    iget-object v6, p0, Lcom/android/internal/telephony/ePDGinterface;->myaddr:[I

    iget-object v7, p0, Lcom/android/internal/telephony/ePDGinterface;->mePDGHandler:Landroid/os/Handler;

    invoke-virtual {v7, v8}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v7

    invoke-virtual {p0, v5, v6, v4, v7}, Lcom/android/internal/telephony/ePDGinterface;->setWifiAvaiable(I[IILandroid/os/Message;)V

    goto :goto_0

    .line 599
    .restart local v0    # "adr":Landroid/net/LinkAddress;
    .restart local v2    # "i$":Ljava/util/Iterator;
    :cond_3
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[EPDG]some strange addr in the list!!! "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    goto :goto_2
.end method

.method public setWifiAvaiable(I[IILandroid/os/Message;)V
    .locals 5
    .param p1, "isAvaialbe"    # I
    .param p2, "macAddr"    # [I
    .param p3, "IPv4Addr"    # I
    .param p4, "result"    # Landroid/os/Message;

    .prologue
    const/4 v4, 0x6

    .line 351
    const-string v2, "setWifiAvaiable entered ======>"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 353
    const/16 v2, 0x173

    invoke-static {v2, p4}, Lcom/android/internal/telephony/RILRequest;->obtain(ILandroid/os/Message;)Lcom/android/internal/telephony/RILRequest;

    move-result-object v1

    .line 356
    .local v1, "rr":Lcom/android/internal/telephony/RILRequest;
    if-nez p1, :cond_0

    iget v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mSendingisAv:I

    if-nez v2, :cond_0

    .line 388
    :goto_0
    return-void

    .line 361
    :cond_0
    if-nez p2, :cond_1

    .line 363
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    if-ge v0, v4, :cond_2

    .line 365
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/os/Parcel;->writeInt(I)V

    .line 363
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 370
    .end local v0    # "i":I
    :cond_1
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_2
    if-ge v0, v4, :cond_2

    .line 372
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    aget v3, p2, v0

    invoke-virtual {v2, v3}, Landroid/os/Parcel;->writeInt(I)V

    .line 370
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 376
    :cond_2
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v2, p1}, Landroid/os/Parcel;->writeInt(I)V

    .line 377
    iget-object v2, v1, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v2, p3}, Landroid/os/Parcel;->writeInt(I)V

    .line 379
    iput p1, p0, Lcom/android/internal/telephony/ePDGinterface;->mSendingisAv:I

    .line 382
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Lcom/android/internal/telephony/RILRequest;->serialString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "> "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    iget v3, v1, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    invoke-static {v3}, Lcom/android/internal/telephony/RIL;->requestToString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " ,isAvaialbe: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " ,ipv4Addr "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 384
    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v2, v1}, Lcom/android/internal/telephony/RIL;->send(Lcom/android/internal/telephony/RILRequest;)V

    .line 385
    const-string v2, "setWifiAvaiable send ======>"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public setePDGsetprefTest(Ljava/lang/String;ILandroid/os/Message;)V
    .locals 3
    .param p1, "apn"    # Ljava/lang/String;
    .param p2, "data_pref"    # I
    .param p3, "result"    # Landroid/os/Message;

    .prologue
    .line 300
    const/16 v1, 0x172

    invoke-static {v1, p3}, Lcom/android/internal/telephony/RILRequest;->obtain(ILandroid/os/Message;)Lcom/android/internal/telephony/RILRequest;

    move-result-object v0

    .line 302
    .local v0, "rr":Lcom/android/internal/telephony/RILRequest;
    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 303
    iget-object v1, v0, Lcom/android/internal/telephony/RILRequest;->mParcel:Landroid/os/Parcel;

    invoke-virtual {v1, p2}, Landroid/os/Parcel;->writeInt(I)V

    .line 305
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Lcom/android/internal/telephony/RILRequest;->serialString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    iget v2, v0, Lcom/android/internal/telephony/RILRequest;->mRequest:I

    invoke-static {v2}, Lcom/android/internal/telephony/RIL;->requestToString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " ,apn: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " ,data_tech "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    .line 307
    iget-object v1, p0, Lcom/android/internal/telephony/ePDGinterface;->mMyRil:Lcom/android/internal/telephony/RIL;

    invoke-virtual {v1, v0}, Lcom/android/internal/telephony/RIL;->send(Lcom/android/internal/telephony/RILRequest;)V

    .line 309
    return-void
.end method
