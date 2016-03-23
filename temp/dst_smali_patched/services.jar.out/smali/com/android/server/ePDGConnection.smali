.class public Lcom/android/server/ePDGConnection;
.super Lcom/android/internal/util/StateMachine;
.source "ePDGConnection.java"


# static fields
.field static final BAD_LOSSINWIFI:I = 0x138c

.field protected static final BASE:I = 0x40000

.field static final CBS_APN_CHANGED:I = 0x12c

.field static final CONNECTIVITY_FAIL:I = 0x8

.field static final CON_FAIL_RSP:I = 0x1

.field static final CON_LOST:I = 0x3

.field static final CON_SUCCESS_RSP:I = 0x0

.field protected static final DBG:Z = true

.field static final DISCONNECTED_SUCCESS:I = 0x2

.field static final EPDG_ONLY_INROAM:I = 0x68

.field protected static final EVENT_APN_CHANGED:I = 0x4001b

.field protected static final EVENT_APN_DISCONNECT_NOW:I = 0x4001d

.field protected static final EVENT_BAD_WIFI_STATUS:I = 0x4000b

.field protected static final EVENT_CALLSTATUS_CH:I = 0x40015

.field protected static final EVENT_CONNECTED:I = 0x40005

.field protected static final EVENT_DELAYED_DISCONNECT:I = 0x4001c

.field protected static final EVENT_DELAYED_TEMP_COMPLETE:I = 0x40021

.field protected static final EVENT_DISCONNECTED:I = 0x40006

.field protected static final EVENT_EPDG_CONNECTED:I = 0x40013

.field protected static final EVENT_EPDG_REQUEST:I = 0x40002

.field protected static final EVENT_EPDG_SETUP_DATA_CALL:I = 0x4000a

.field protected static final EVENT_EPDG_TIME:I = 0x4001f

.field protected static final EVENT_FQDN_RSP:I = 0x40008

.field protected static final EVENT_HANDOVER_FAIL:I = 0x4000c

.field protected static final EVENT_LTEREGI_FAIL:I = 0x40018

.field protected static final EVENT_LTE_CONNECTED:I = 0x40012

.field protected static final EVENT_MANGER_START:I = 0x40004

.field protected static final EVENT_MANGER_STOP:I = 0x40003

.field protected static final EVENT_NET_STATE:I = 0x40011

.field protected static final EVENT_PCSCF_CH:I = 0x4000e

.field protected static final EVENT_PDN_PRI_CH:I = 0x40010

.field protected static final EVENT_QOS_INFO:I = 0x4000f

.field protected static final EVENT_RADIO_OFF:I = 0x4001e

.field protected static final EVENT_RETRY:I = 0x4001a

.field protected static final EVENT_ROAM_IMFO:I = 0x40023

.field protected static final EVENT_SET_INIT_VALUE:I = 0x40020

.field protected static final EVENT_TIME_OUT:I = 0x40007

.field protected static final EVENT_UNKNOWN_TECH:I = 0x40022

.field protected static final EVENT_USER_DISCONNECT:I = 0x40009

.field protected static final EVENT_WFCSETTING_CH:I = 0x40016

.field protected static final EVENT_WFC_PREFER_CH:I = 0x40014

.field protected static final EVENT_WIFI_CONNECT:I = 0x40000

.field protected static final EVENT_WIFI_CONNECT_DETAIL:I = 0x40024

.field protected static final EVENT_WIFI_DISCONNECT:I = 0x40001

.field protected static final EVENT_ePDGREGI_FAIL:I = 0x40017

.field protected static final EVENT_ePDGRTP_FAIL:I = 0x40019

.field static final EXIT_FAIL_STATUS:I = 0xa

.field static final FAIL_CAUSE_BASE:I = 0x1388

.field static final FAIL_CONNECTION:I = 0x138b

.field static final FAIL_EPS_SCAN:I = 0x138a

.field static final FAIL_NO_RSP:I = 0x1389

.field static final FixedLTE:I = 0x1

.field static final FixedePDG:I = 0x2

.field static final HANDOVER_FAIL:I = 0x138d

.field static final HANDOVER_TO_LTE:I = 0x6

.field static final HANDOVER_TO_ePDG:I = 0x7

.field static final HandoverError:I = 0x64

.field static final IMSREGI_FAIL_LTE:I = 0x65

.field static final IMSREGI_FAIL_ePDG:I = 0x66

.field static final IMS_APN_CHANGED:I = 0xc8

.field public static final IMS_CELL_ONLY:I = 0x3

.field public static final IMS_CELL_PREF:I = 0x2

.field static final IMS_DEREGI:I = 0x191

.field static final IMS_INTHEHOME:I = 0x69

.field static final IMS_REGI_OK:I = 0x190

.field static final IMS_TYPE:I = 0x0

.field public static final IMS_WIFI_ONLY:I = 0x1

.field public static final IMS_WIFI_PREF:I = 0x0

.field static final IWLAN_S2b:I = 0x12

.field protected static final LOG_TAG:Ljava/lang/String; = "ePDG"

.field static final LTEConnected:I = 0x1

.field static final LTE_TECH:I = 0xe

.field static final NETWROKLost:I = 0x1392

.field static final NO_APN:I = 0x138f

.field static final NO_LIST:I = 0x3e7

.field public static final PDN_IS_NOT_AVA:I = 0x2

.field public static final PDN_MMS_TYPE:I = 0x0

.field public static final PDN_TMUS_TYPE:I = 0x1

.field static final PREF_IWLAN_TECH:I = 0x2

.field static final PREF_WWAN_TECH:I = 0x0

.field static final RADIO_POWER_OFF:I = 0x1f4

.field static final REQ_TIME_OUT:I = 0x3e9

.field static final RTPTIMEOUT:I = 0x1390

.field static final RTPTIMEOUT_ePDG:I = 0x67

.field static final SCAN_FAIL:I = 0x3e8

.field static final VZWAPP_TYPE:I = 0x1

.field static final WIFISIG_BAD:I = 0x2

.field static final WIFISIG_GOOD:I = 0x0

.field static final WIFISIG_MID:I = 0x1

.field static final WRONGTECH:I = 0x1391

.field static final WiFi_LOST:I = 0x138e

.field static final ePDGConnected:I = 0x2

.field protected static mCount:I


# instance fields
.field public CallState:I

.field protected FQDNForTestApp:Ljava/lang/String;

.field protected FQDNStaticFlag:Z

.field public WFCPrefer:I

.field public WFCSettings:Z

.field public cid:I

.field public currentPref:I

.field protected ePDGAddrForTestApp:[Ljava/lang/String;

.field protected ePDGAddrStaticFlag:Z

.field protected isChangingRAT:Z

.field public isGoodPacket:Z

.field public isIMSRegi:Z

.field protected isManager:Z

.field protected isMobileavail:Z

.field public isRoaming:Z

.field public isWaitingDereig:Z

.field protected isWaitingRAT:Z

.field protected isWiFi:Z

.field public mApn:Ljava/lang/String;

.field public mCompletedMsg:Landroid/os/Message;

.field protected mContext:Landroid/content/Context;

.field protected mCurrentGW:Ljava/lang/String;

.field protected mEIf:Ljava/lang/String;

.field mExtendedRat:I

.field protected mFailReason:I

.field protected mFid:I

.field protected mFqdn:Ljava/lang/String;

.field protected mGWList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field protected mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

.field protected mLastNetworkReason:I

.field public mLostMsg:Landroid/os/Message;

.field protected mNetworkCapabilities:Landroid/net/NetworkCapabilities;

.field protected mV4Addr:Ljava/lang/String;

.field protected mV6Addr:Ljava/lang/String;

.field protected mcc:Ljava/lang/String;

.field protected mnc:Ljava/lang/String;

.field protected mobileRadioTech:I

.field protected mobileservicestate:I

.field public myfeature:I

.field protected pcscfAddr_ipv4:[Ljava/lang/String;

.field protected pcscfAddr_ipv6:[Ljava/lang/String;

.field wifiDetailedState:I


# direct methods
.method protected constructor <init>(Ljava/lang/String;I)V
    .locals 4
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "id"    # I

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, p1}, Lcom/android/internal/util/StateMachine;-><init>(Ljava/lang/String;)V

    iput v1, p0, Lcom/android/server/ePDGConnection;->mFailReason:I

    iput v1, p0, Lcom/android/server/ePDGConnection;->mLastNetworkReason:I

    iput v1, p0, Lcom/android/server/ePDGConnection;->mFid:I

    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->isWiFi:Z

    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->isChangingRAT:Z

    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->isWaitingRAT:Z

    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->isMobileavail:Z

    iput v3, p0, Lcom/android/server/ePDGConnection;->mobileservicestate:I

    iput v1, p0, Lcom/android/server/ePDGConnection;->mobileRadioTech:I

    iput-boolean v3, p0, Lcom/android/server/ePDGConnection;->isManager:Z

    iput-object v2, p0, Lcom/android/server/ePDGConnection;->mCurrentGW:Ljava/lang/String;

    iput-object v2, p0, Lcom/android/server/ePDGConnection;->mV4Addr:Ljava/lang/String;

    iput-object v2, p0, Lcom/android/server/ePDGConnection;->mV6Addr:Ljava/lang/String;

    iput-object v2, p0, Lcom/android/server/ePDGConnection;->mEIf:Ljava/lang/String;

    iput-object v2, p0, Lcom/android/server/ePDGConnection;->mcc:Ljava/lang/String;

    iput-object v2, p0, Lcom/android/server/ePDGConnection;->mnc:Ljava/lang/String;

    iput-object v2, p0, Lcom/android/server/ePDGConnection;->mFqdn:Ljava/lang/String;

    iput v1, p0, Lcom/android/server/ePDGConnection;->currentPref:I

    const/16 v0, 0x63

    iput v0, p0, Lcom/android/server/ePDGConnection;->cid:I

    iput-boolean v3, p0, Lcom/android/server/ePDGConnection;->isGoodPacket:Z

    const-string v0, "UnKnown"

    iput-object v0, p0, Lcom/android/server/ePDGConnection;->mApn:Ljava/lang/String;

    iput v1, p0, Lcom/android/server/ePDGConnection;->mExtendedRat:I

    iput v1, p0, Lcom/android/server/ePDGConnection;->WFCPrefer:I

    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->WFCSettings:Z

    iput v1, p0, Lcom/android/server/ePDGConnection;->CallState:I

    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->isRoaming:Z

    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->isIMSRegi:Z

    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->isWaitingDereig:Z

    iput v1, p0, Lcom/android/server/ePDGConnection;->wifiDetailedState:I

    new-instance v0, Landroid/net/NetworkCapabilities;

    invoke-direct {v0}, Landroid/net/NetworkCapabilities;-><init>()V

    iput-object v0, p0, Lcom/android/server/ePDGConnection;->mNetworkCapabilities:Landroid/net/NetworkCapabilities;

    iput-object v2, p0, Lcom/android/server/ePDGConnection;->FQDNForTestApp:Ljava/lang/String;

    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->FQDNStaticFlag:Z

    new-array v0, v3, [Ljava/lang/String;

    iput-object v0, p0, Lcom/android/server/ePDGConnection;->ePDGAddrForTestApp:[Ljava/lang/String;

    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->ePDGAddrStaticFlag:Z

    iput-object v2, p0, Lcom/android/server/ePDGConnection;->mContext:Landroid/content/Context;

    iput v1, p0, Lcom/android/server/ePDGConnection;->myfeature:I

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    move-result-object v0

    iget v0, v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    iput v0, p0, Lcom/android/server/ePDGConnection;->myfeature:I

    return-void
.end method

.method static makePDGConnection(I)Lcom/android/server/ePDGConnection;
    .locals 1
    .param p0, "id"    # I

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method private notifyQoSInfo(Landroid/net/NetworkCapabilities$Flow;)V
    .locals 7
    .param p1, "flow"    # Landroid/net/NetworkCapabilities$Flow;

    .prologue
    new-instance v4, Landroid/content/Intent;

    const-string v5, "com.lge.internal.telephony.qos-changed"

    invoke-direct {v4, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v4, "intent_qos":Landroid/content/Intent;
    const-string v5, "type"

    const-string v6, "ims"

    invoke-virtual {v4, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v5, "id"

    invoke-virtual {p1}, Landroid/net/NetworkCapabilities$Flow;->getID()I

    move-result v6

    invoke-virtual {v4, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v5, "status"

    invoke-virtual {p1}, Landroid/net/NetworkCapabilities$Flow;->getState()Landroid/net/NetworkCapabilities$FlowState;

    move-result-object v6

    invoke-virtual {v6}, Landroid/net/NetworkCapabilities$FlowState;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v5, "tx-desc"

    const-string v6, "tx"

    invoke-virtual {p1, v6}, Landroid/net/NetworkCapabilities$Flow;->getFlowDescriptions(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v5, "rx-desc"

    const-string v6, "rx"

    invoke-virtual {p1, v6}, Landroid/net/NetworkCapabilities$Flow;->getFlowDescriptions(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v5, "notifyQoSInfo : Broadcast QoS Information"

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    const-string v5, "    type : ims "

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "    id : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p1}, Landroid/net/NetworkCapabilities$Flow;->getID()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "    status : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p1}, Landroid/net/NetworkCapabilities$Flow;->getState()Landroid/net/NetworkCapabilities$FlowState;

    move-result-object v6

    invoke-virtual {v6}, Landroid/net/NetworkCapabilities$FlowState;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "    tx-desc : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "tx"

    invoke-virtual {p1, v6}, Landroid/net/NetworkCapabilities$Flow;->getFlowDescriptions(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "    rx-desc : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "rx"

    invoke-virtual {p1, v6}, Landroid/net/NetworkCapabilities$Flow;->getFlowDescriptions(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    const-string v5, "tx"

    invoke-virtual {p1, v5}, Landroid/net/NetworkCapabilities$Flow;->getFlowFilterCount(Ljava/lang/String;)I

    move-result v1

    .local v1, "TXcount":I
    const-string v5, "rx"

    invoke-virtual {p1, v5}, Landroid/net/NetworkCapabilities$Flow;->getFlowFilterCount(Ljava/lang/String;)I

    move-result v0

    .local v0, "RXcount":I
    const-string v5, "TX-filterCount"

    invoke-virtual {v4, v5, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v5, "RX-filterCount"

    invoke-virtual {v4, v5, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "    TXcount : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "    RXcount : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    if-nez v1, :cond_3

    const-string v5, "tx-filter"

    const-string v6, ""

    invoke-virtual {v4, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v5, "    tx-filter : "

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    :cond_0
    if-nez v0, :cond_4

    const-string v5, "rx-filter"

    const-string v6, ""

    invoke-virtual {v4, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v5, "    rx-filter : "

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    :cond_1
    iget-object v5, p0, Lcom/android/server/ePDGConnection;->mContext:Landroid/content/Context;

    if-eqz v5, :cond_2

    iget-object v5, p0, Lcom/android/server/ePDGConnection;->mContext:Landroid/content/Context;

    invoke-virtual {v5, v4}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    :cond_2
    return-void

    :cond_3
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    if-ge v3, v1, :cond_0

    const-string v5, "tx"

    invoke-virtual {p1, v3, v5}, Landroid/net/NetworkCapabilities$Flow;->getFlowFilter(ILjava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .local v2, "filter":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "tx-filter["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "    tx-filter["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "] : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .end local v2    # "filter":Ljava/lang/String;
    .end local v3    # "i":I
    :cond_4
    const/4 v3, 0x0

    .restart local v3    # "i":I
    :goto_1
    if-ge v3, v0, :cond_1

    const-string v5, "rx"

    invoke-virtual {p1, v3, v5}, Landroid/net/NetworkCapabilities$Flow;->getFlowFilter(ILjava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .restart local v2    # "filter":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "rx-filter["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "    rx-filter["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "] : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_1
.end method

.method private setFlowState(Landroid/net/NetworkCapabilities$Flow;I)Z
    .locals 4
    .param p1, "flow"    # Landroid/net/NetworkCapabilities$Flow;
    .param p2, "qos_status"    # I

    .prologue
    const/4 v1, 0x0

    invoke-virtual {p1}, Landroid/net/NetworkCapabilities$Flow;->getState()Landroid/net/NetworkCapabilities$FlowState;

    move-result-object v0

    .local v0, "flowState":Landroid/net/NetworkCapabilities$FlowState;
    packed-switch p2, :pswitch_data_0

    :goto_0
    return v1

    :pswitch_0
    sget-object v2, Landroid/net/NetworkCapabilities$FlowState;->INACTIVE:Landroid/net/NetworkCapabilities$FlowState;

    if-eq v0, v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Abnomal Flow State Change: QoS ID ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Landroid/net/NetworkCapabilities$Flow;->getID()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), Current State ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), New State ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/NetworkCapabilities$FlowState;->ACTIVATED:Landroid/net/NetworkCapabilities$FlowState;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    sget-object v1, Landroid/net/NetworkCapabilities$FlowState;->ACTIVATED:Landroid/net/NetworkCapabilities$FlowState;

    invoke-virtual {p1, v1}, Landroid/net/NetworkCapabilities$Flow;->setState(Landroid/net/NetworkCapabilities$FlowState;)V

    :cond_1
    :goto_1
    const/4 v1, 0x1

    goto :goto_0

    :pswitch_1
    sget-object v2, Landroid/net/NetworkCapabilities$FlowState;->INACTIVE:Landroid/net/NetworkCapabilities$FlowState;

    if-ne v0, v2, :cond_2

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Abnomal Flow State Change: QoS ID ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Landroid/net/NetworkCapabilities$Flow;->getID()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), Current State ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), New State ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/NetworkCapabilities$FlowState;->ENABLED:Landroid/net/NetworkCapabilities$FlowState;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    sget-object v1, Landroid/net/NetworkCapabilities$FlowState;->ENABLED:Landroid/net/NetworkCapabilities$FlowState;

    invoke-virtual {p1, v1}, Landroid/net/NetworkCapabilities$Flow;->setState(Landroid/net/NetworkCapabilities$FlowState;)V

    goto :goto_1

    :pswitch_2
    sget-object v2, Landroid/net/NetworkCapabilities$FlowState;->INACTIVE:Landroid/net/NetworkCapabilities$FlowState;

    if-ne v0, v2, :cond_3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Abnomal Flow State Change: QoS ID ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Landroid/net/NetworkCapabilities$Flow;->getID()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), Current State ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), New State ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/NetworkCapabilities$FlowState;->INACTIVE:Landroid/net/NetworkCapabilities$FlowState;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_3
    sget-object v1, Landroid/net/NetworkCapabilities$FlowState;->INACTIVE:Landroid/net/NetworkCapabilities$FlowState;

    invoke-virtual {p1, v1}, Landroid/net/NetworkCapabilities$Flow;->setState(Landroid/net/NetworkCapabilities$FlowState;)V

    goto/16 :goto_1

    :pswitch_3
    sget-object v2, Landroid/net/NetworkCapabilities$FlowState;->INACTIVE:Landroid/net/NetworkCapabilities$FlowState;

    if-ne v0, v2, :cond_4

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Abnomal Flow State Change: QoS ID ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Landroid/net/NetworkCapabilities$Flow;->getID()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), Current State ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), New State ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/NetworkCapabilities$FlowState;->DISABLED:Landroid/net/NetworkCapabilities$FlowState;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_4
    sget-object v1, Landroid/net/NetworkCapabilities$FlowState;->DISABLED:Landroid/net/NetworkCapabilities$FlowState;

    invoke-virtual {p1, v1}, Landroid/net/NetworkCapabilities$Flow;->setState(Landroid/net/NetworkCapabilities$FlowState;)V

    goto/16 :goto_1

    :pswitch_4
    sget-object v2, Landroid/net/NetworkCapabilities$FlowState;->INACTIVE:Landroid/net/NetworkCapabilities$FlowState;

    if-ne v0, v2, :cond_5

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Abnomal Flow State Change: QoS ID ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Landroid/net/NetworkCapabilities$Flow;->getID()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), Current State ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), New State ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Landroid/net/NetworkCapabilities$FlowState;->SUSPENDED:Landroid/net/NetworkCapabilities$FlowState;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_5
    sget-object v1, Landroid/net/NetworkCapabilities$FlowState;->SUSPENDED:Landroid/net/NetworkCapabilities$FlowState;

    invoke-virtual {p1, v1}, Landroid/net/NetworkCapabilities$Flow;->setState(Landroid/net/NetworkCapabilities$FlowState;)V

    goto/16 :goto_1

    :pswitch_5
    sget-object v2, Landroid/net/NetworkCapabilities$FlowState;->INACTIVE:Landroid/net/NetworkCapabilities$FlowState;

    if-ne v0, v2, :cond_1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Abnomal Flow State Change: QoS ID ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Landroid/net/NetworkCapabilities$Flow;->getID()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), Modified Event Received at State ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_5
        :pswitch_2
        :pswitch_4
        :pswitch_1
        :pswitch_3
    .end packed-switch
.end method


# virtual methods
.method public checkSameAddr(Ljava/lang/String;)I
    .locals 3
    .param p1, "GWaddr"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .local v0, "i":I
    iget-object v2, p0, Lcom/android/server/ePDGConnection;->mGWList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v1

    .local v1, "s":I
    :goto_0
    if-ge v0, v1, :cond_1

    iget-object v2, p0, Lcom/android/server/ePDGConnection;->mGWList:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .end local v0    # "i":I
    :goto_1
    return v0

    .restart local v0    # "i":I
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    const-string v2, "if it is second pdn, we do not configure list"

    invoke-virtual {p0, v2}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    const/16 v0, 0x3e7

    goto :goto_1
.end method

.method protected clearSettings()V
    .locals 1

    .prologue
    const-string v0, "clearSettings"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/server/ePDGConnection;->mCurrentGW:Ljava/lang/String;

    iget-object v0, p0, Lcom/android/server/ePDGConnection;->mGWList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    const/16 v0, 0x63

    iput v0, p0, Lcom/android/server/ePDGConnection;->cid:I

    return-void
.end method

.method public ePDGDeactivateDataCall(Ljava/lang/String;II)V
    .locals 3
    .param p1, "apn"    # Ljava/lang/String;
    .param p2, "cid"    # I
    .param p3, "reason"    # I

    .prologue
    const-string v1, "[ePDG] Deactivate data call start : "

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    :try_start_0
    iget-object v1, p0, Lcom/android/server/ePDGConnection;->mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

    invoke-interface {v1, p1, p2, p3}, Lcom/android/internal/telephony/ILGTelephony;->ePDGDeactivateDataCall(Ljava/lang/String;II)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[ePDG] Deactivate data call RemoteException : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public ePDGHandOverStatus(I)V
    .locals 0
    .param p1, "extendedRAT"    # I

    .prologue
    return-void
.end method

.method public ePDGSetupDataCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 9
    .param p1, "radioTechnology"    # Ljava/lang/String;
    .param p2, "profile"    # Ljava/lang/String;
    .param p3, "apn"    # Ljava/lang/String;
    .param p4, "user"    # Ljava/lang/String;
    .param p5, "password"    # Ljava/lang/String;
    .param p6, "authType"    # Ljava/lang/String;
    .param p7, "protocol"    # Ljava/lang/String;

    .prologue
    const-string v0, "[ePDG] ePDG Setup Data Call start : "

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGConnection;->mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

    if-nez v0, :cond_0

    const-string v0, "Jphone"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/ILGTelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ILGTelephony;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/ePDGConnection;->mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

    :cond_0
    iget-object v0, p0, Lcom/android/server/ePDGConnection;->mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

    if-nez v0, :cond_1

    const-string v0, "[ePDG] pref change cause mLGphoneinterface is null"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_1
    iget-boolean v0, p0, Lcom/android/server/ePDGConnection;->isChangingRAT:Z

    if-eqz v0, :cond_2

    const-string v0, "[ePDG] wait!! until rat change : "

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/server/ePDGConnection;->isWaitingRAT:Z

    goto :goto_0

    :cond_2
    :try_start_0
    iget-object v0, p0, Lcom/android/server/ePDGConnection;->mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    move-object/from16 v7, p7

    invoke-interface/range {v0 .. v7}, Lcom/android/internal/telephony/ILGTelephony;->ePDGSetupDataCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/ePDGConnection;->mApn:Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v8

    .local v8, "e":Landroid/os/RemoteException;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[ePDG] setup data call RemoteException : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public ePDGbringUp(Landroid/os/Message;Landroid/os/Message;Ljava/lang/String;Ljava/lang/String;I)Z
    .locals 1
    .param p1, "onCompletedMsg"    # Landroid/os/Message;
    .param p2, "onLostMsg"    # Landroid/os/Message;
    .param p3, "mymcc"    # Ljava/lang/String;
    .param p4, "mymnc"    # Ljava/lang/String;
    .param p5, "fid"    # I

    .prologue
    iput-object p3, p0, Lcom/android/server/ePDGConnection;->mcc:Ljava/lang/String;

    iput-object p4, p0, Lcom/android/server/ePDGConnection;->mnc:Ljava/lang/String;

    iput-object p1, p0, Lcom/android/server/ePDGConnection;->mCompletedMsg:Landroid/os/Message;

    iput-object p2, p0, Lcom/android/server/ePDGConnection;->mLostMsg:Landroid/os/Message;

    iput p5, p0, Lcom/android/server/ePDGConnection;->mFid:I

    const v0, 0x40002

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(I)V

    const/4 v0, 0x1

    return v0
.end method

.method public ePDGteardown(Landroid/os/Message;)Z
    .locals 1
    .param p1, "onCompletedMsg"    # Landroid/os/Message;

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method public getAPNTypewithFid(I)Ljava/lang/String;
    .locals 2
    .param p1, "fid"    # I

    .prologue
    packed-switch p1, :pswitch_data_0

    const-string v0, "unknown"

    :goto_0
    return-object v0

    :pswitch_0
    const-string v0, "ims"

    goto :goto_0

    :pswitch_1
    iget v0, p0, Lcom/android/server/ePDGConnection;->myfeature:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    const-string v0, "cbs"

    goto :goto_0

    :cond_0
    const-string v0, "vzwapp"

    goto :goto_0

    :pswitch_2
    const-string v0, "vzwCF"

    goto :goto_0

    :pswitch_3
    const-string v0, "vzwstatic"

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public getConnectionID()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/android/server/ePDGConnection;->mFid:I

    return v0
.end method

.method public getHostByName(Ljava/lang/String;)[Ljava/lang/String;
    .locals 6
    .param p1, "strFQDN"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    .local v3, "objIPs":[Ljava/net/InetAddress;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getHostByName ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    :try_start_0
    invoke-static {p1}, Ljava/net/InetAddress;->getAllByName(Ljava/lang/String;)[Ljava/net/InetAddress;
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    array-length v4, v3

    new-array v2, v4, [Ljava/lang/String;

    .local v2, "objIPStrs":[Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "nIndex":I
    :goto_0
    array-length v4, v3

    if-ge v1, v4, :cond_0

    aget-object v4, v3, v1

    invoke-virtual {v4}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getHostByName ip=["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget-object v5, v2, v1

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .end local v1    # "nIndex":I
    .end local v2    # "objIPStrs":[Ljava/lang/String;
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/net/UnknownHostException;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "UnknownHostException : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/UnknownHostException;->printStackTrace()V

    const/4 v2, 0x0

    .end local v0    # "e":Ljava/net/UnknownHostException;
    :cond_0
    return-object v2
.end method

.method public getprefer()I
    .locals 1

    .prologue
    const/4 v0, 0x2

    return v0
.end method

.method public isConnected()Z
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method protected log(Ljava/lang/String;)V
    .locals 3
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    const-string v0, "ePDG"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/server/ePDGConnection;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method protected makeFQDN()Ljava/lang/String;
    .locals 2

    .prologue
    iget-boolean v0, p0, Lcom/android/server/ePDGConnection;->FQDNStaticFlag:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/ePDGConnection;->FQDNForTestApp:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/server/ePDGConnection;->mFqdn:Ljava/lang/String;

    iget-object v0, p0, Lcom/android/server/ePDGConnection;->mFqdn:Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/android/server/ePDGConnection;->mcc:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/android/server/ePDGConnection;->mnc:Ljava/lang/String;

    if-nez v0, :cond_2

    :cond_1
    const-string v0, "makeFQDN Fail"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    const/4 v0, 0x0

    goto :goto_0

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "epdg.epc.mnc"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGConnection;->mnc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".mcc"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/server/ePDGConnection;->mcc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".pub.3gppnetwork.org"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/ePDGConnection;->mFqdn:Ljava/lang/String;

    iget-object v0, p0, Lcom/android/server/ePDGConnection;->mFqdn:Ljava/lang/String;

    goto :goto_0
.end method

.method protected notifyePDGCompleted(II)V
    .locals 7
    .param p1, "type"    # I
    .param p2, "reason"    # I

    .prologue
    const/4 v3, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move-object v4, v3

    move-object v5, v3

    move-object v6, v3

    invoke-virtual/range {v0 .. v6}, Lcom/android/server/ePDGConnection;->notifyePDGCompleted(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method protected notifyePDGCompleted(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 12
    .param p1, "type"    # I
    .param p2, "reason"    # I
    .param p3, "ipaddr"    # Ljava/lang/String;
    .param p4, "ipif"    # Ljava/lang/String;
    .param p5, "ipsecGW"    # Ljava/lang/String;
    .param p6, "idnss"    # Ljava/lang/String;

    .prologue
    const/4 v10, 0x0

    .local v10, "connectionCompletedMsg":Landroid/os/Message;
    const/4 v1, 0x3

    if-eq p1, v1, :cond_0

    const/16 v1, 0x138d

    if-eq p1, v1, :cond_0

    const/16 v1, 0x8

    if-eq p1, v1, :cond_0

    const/16 v1, 0xa

    if-ne p1, v1, :cond_1

    :cond_0
    iget-object v10, p0, Lcom/android/server/ePDGConnection;->mLostMsg:Landroid/os/Message;

    :goto_0
    if-nez v10, :cond_2

    const-string v1, "connectionCompletedMsg is null!!!!!!!!!!!!!! "

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    :goto_1
    return-void

    :cond_1
    iget-object v10, p0, Lcom/android/server/ePDGConnection;->mCompletedMsg:Landroid/os/Message;

    goto :goto_0

    :cond_2
    new-instance v0, Lcom/android/server/ePDGConnInfo;

    iget v3, p0, Lcom/android/server/ePDGConnection;->mFid:I

    iget-object v4, p0, Lcom/android/server/ePDGConnection;->mCurrentGW:Ljava/lang/String;

    iget-object v5, p0, Lcom/android/server/ePDGConnection;->mFqdn:Ljava/lang/String;

    move v1, p1

    move v2, p2

    move-object v6, p3

    move-object/from16 v7, p4

    move-object/from16 v8, p5

    move-object/from16 v9, p6

    invoke-direct/range {v0 .. v9}, Lcom/android/server/ePDGConnInfo;-><init>(IIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .local v0, "sendingResult":Lcom/android/server/ePDGConnInfo;
    const/4 v1, 0x0

    invoke-static {v10, v0, v1}, Landroid/os/AsyncResult;->forMessage(Landroid/os/Message;Ljava/lang/Object;Ljava/lang/Throwable;)Landroid/os/AsyncResult;

    :try_start_0
    invoke-virtual {v10}, Landroid/os/Message;->sendToTarget()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v11

    .local v11, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ePDG notification ERROR "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    goto :goto_1
.end method

.method public onNetworkupdate(ZII)Z
    .locals 1
    .param p1, "isWiFi"    # Z
    .param p2, "mobileState"    # I
    .param p3, "mobileTech"    # I

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method protected onPCSChanged(Ljava/lang/String;)V
    .locals 0
    .param p1, "result"    # Ljava/lang/String;

    .prologue
    return-void
.end method

.method protected onQoSChanged(Ljava/lang/String;)V
    .locals 1
    .param p1, "result"    # Ljava/lang/String;

    .prologue
    const-string v0, "onQoSChanged : EXIT with Success"

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    return-void
.end method

.method public pcsch(Ljava/lang/String;)Z
    .locals 1
    .param p1, "type"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public resetCBLooper(Landroid/os/Message;Landroid/os/Message;)V
    .locals 0
    .param p1, "onCompletedMsg"    # Landroid/os/Message;
    .param p2, "onLostMsg"    # Landroid/os/Message;

    .prologue
    iput-object p1, p0, Lcom/android/server/ePDGConnection;->mCompletedMsg:Landroid/os/Message;

    iput-object p2, p0, Lcom/android/server/ePDGConnection;->mLostMsg:Landroid/os/Message;

    return-void
.end method

.method public setCallStatus(I)V
    .locals 1
    .param p1, "callstatus"    # I

    .prologue
    const v0, 0x40015

    invoke-virtual {p0, v0, p1}, Lcom/android/server/ePDGConnection;->obtainMessage(II)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(Landroid/os/Message;)V

    return-void
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 0
    .param p1, "setcon"    # Landroid/content/Context;

    .prologue
    iput-object p1, p0, Lcom/android/server/ePDGConnection;->mContext:Landroid/content/Context;

    return-void
.end method

.method public setEPDGAddrByTestApp(ZLjava/lang/String;)V
    .locals 2
    .param p1, "enable"    # Z
    .param p2, "ePDGAddr"    # Ljava/lang/String;

    .prologue
    iput-boolean p1, p0, Lcom/android/server/ePDGConnection;->ePDGAddrStaticFlag:Z

    iget-object v0, p0, Lcom/android/server/ePDGConnection;->ePDGAddrForTestApp:[Ljava/lang/String;

    const/4 v1, 0x0

    aput-object p2, v0, v1

    return-void
.end method

.method public setEPDGForIODT(Ljava/lang/String;)I
    .locals 1
    .param p1, "GWAddr"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/android/server/ePDGConnection;->mGWList:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/android/server/ePDGConnection;->mGWList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public setEPDGGWAddr([Ljava/lang/String;)I
    .locals 4
    .param p1, "GWAddr"    # [Ljava/lang/String;

    .prologue
    if-nez p1, :cond_0

    const/4 v2, 0x0

    :goto_0
    return v2

    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    array-length v1, p1

    .local v1, "s":I
    :goto_1
    if-ge v0, v1, :cond_1

    iget-object v2, p0, Lcom/android/server/ePDGConnection;->mGWList:Ljava/util/ArrayList;

    aget-object v3, p1, v0

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    iget-object v2, p0, Lcom/android/server/ePDGConnection;->mGWList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    goto :goto_0
.end method

.method public setFQDNByTestApp(ZLjava/lang/String;)V
    .locals 0
    .param p1, "enable"    # Z
    .param p2, "fqdn"    # Ljava/lang/String;

    .prologue
    iput-boolean p1, p0, Lcom/android/server/ePDGConnection;->FQDNStaticFlag:Z

    iput-object p2, p0, Lcom/android/server/ePDGConnection;->FQDNForTestApp:Ljava/lang/String;

    return-void
.end method

.method public setManagerStatus(Z)V
    .locals 1
    .param p1, "setvalue"    # Z

    .prologue
    if-eqz p1, :cond_0

    const v0, 0x40004

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(I)V

    :goto_0
    return-void

    :cond_0
    const v0, 0x40003

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(I)V

    goto :goto_0
.end method

.method public setNetworkstate(II)V
    .locals 1
    .param p1, "mobileState"    # I
    .param p2, "mobileTech"    # I

    .prologue
    const v0, 0x40011

    invoke-virtual {p0, v0, p1, p2}, Lcom/android/server/ePDGConnection;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(Landroid/os/Message;)V

    return-void
.end method

.method public setPCSInfo(Ljava/lang/String;)Z
    .locals 1
    .param p1, "pcs"    # Ljava/lang/String;

    .prologue
    const v0, 0x4000e

    invoke-virtual {p0, v0, p1}, Lcom/android/server/ePDGConnection;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(Landroid/os/Message;)V

    const/4 v0, 0x1

    return v0
.end method

.method public setQosInfo(Ljava/lang/String;)Z
    .locals 1
    .param p1, "qos"    # Ljava/lang/String;

    .prologue
    const v0, 0x4000f

    invoke-virtual {p0, v0, p1}, Lcom/android/server/ePDGConnection;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(Landroid/os/Message;)V

    const/4 v0, 0x1

    return v0
.end method

.method public setWFCPreferChange(I)V
    .locals 1
    .param p1, "prefer"    # I

    .prologue
    const v0, 0x40014

    invoke-virtual {p0, v0, p1}, Lcom/android/server/ePDGConnection;->obtainMessage(II)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(Landroid/os/Message;)V

    return-void
.end method

.method public setWFCsettingChange(I)V
    .locals 1
    .param p1, "isWFCEnable"    # I

    .prologue
    const v0, 0x40016

    invoke-virtual {p0, v0, p1}, Lcom/android/server/ePDGConnection;->obtainMessage(II)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(Landroid/os/Message;)V

    return-void
.end method

.method public setWIFIStatus(ZI)V
    .locals 1
    .param p1, "setvalue"    # Z
    .param p2, "detail_status"    # I

    .prologue
    if-eqz p1, :cond_0

    const v0, 0x40024

    invoke-virtual {p0, v0, p2}, Lcom/android/server/ePDGConnection;->obtainMessage(II)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(Landroid/os/Message;)V

    :goto_0
    return-void

    :cond_0
    const v0, 0x40001

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(I)V

    goto :goto_0
.end method

.method public setWIFIStatus(ZZ)V
    .locals 1
    .param p1, "setvalue"    # Z
    .param p2, "isgood"    # Z

    .prologue
    if-eqz p1, :cond_1

    iget v0, p0, Lcom/android/server/ePDGConnection;->mFid:I

    if-nez v0, :cond_0

    if-nez p2, :cond_0

    const v0, 0x4000b

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(I)V

    :goto_0
    return-void

    :cond_0
    const/high16 v0, 0x40000

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(I)V

    goto :goto_0

    :cond_1
    const v0, 0x40001

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(I)V

    goto :goto_0
.end method

.method public setePDGsetprefTest(Ljava/lang/String;I)V
    .locals 6
    .param p1, "apn"    # Ljava/lang/String;
    .param p2, "data_pref"    # I

    .prologue
    const-wide/16 v4, 0xfa0

    const v3, 0x40021

    iget v1, p0, Lcom/android/server/ePDGConnection;->currentPref:I

    if-ne v1, p2, :cond_0

    :goto_0
    return-void

    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[ePDG] data_perf is changed so change to : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/server/ePDGConnection;->mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

    if-nez v1, :cond_1

    const-string v1, "Jphone"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/ILGTelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ILGTelephony;

    move-result-object v1

    iput-object v1, p0, Lcom/android/server/ePDGConnection;->mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

    :cond_1
    iget-object v1, p0, Lcom/android/server/ePDGConnection;->mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

    if-nez v1, :cond_2

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[ePDG] pref change cause mLGphoneinterface is null"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iput p2, p0, Lcom/android/server/ePDGConnection;->currentPref:I

    :try_start_0
    iget-object v1, p0, Lcom/android/server/ePDGConnection;->mLGPhoneService:Lcom/android/internal/telephony/ILGTelephony;

    invoke-interface {v1, p1, p2}, Lcom/android/internal/telephony/ILGTelephony;->setePDGsetprefTest(Ljava/lang/String;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    iget-boolean v1, p0, Lcom/android/server/ePDGConnection;->isChangingRAT:Z

    if-eqz v1, :cond_3

    invoke-virtual {p0, v3}, Lcom/android/server/ePDGConnection;->removeMessages(I)V

    invoke-virtual {p0, v3}, Lcom/android/server/ePDGConnection;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {p0, v1, v4, v5}, Lcom/android/server/ePDGConnection;->sendMessageDelayed(Landroid/os/Message;J)V

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[ePDG] setePDGsetprefTest RemoteException : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    goto :goto_1

    .end local v0    # "e":Landroid/os/RemoteException;
    :cond_3
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->isChangingRAT:Z

    invoke-virtual {p0, v3}, Lcom/android/server/ePDGConnection;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {p0, v1, v4, v5}, Lcom/android/server/ePDGConnection;->sendMessageDelayed(Landroid/os/Message;J)V

    goto :goto_0
.end method

.method public setinitPrichange(I)V
    .locals 1
    .param p1, "privalue"    # I

    .prologue
    const v0, 0x40010

    invoke-virtual {p0, v0, p1}, Lcom/android/server/ePDGConnection;->obtainMessage(II)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(Landroid/os/Message;)V

    return-void
.end method

.method public setinitialvalue(IIIZZII)V
    .locals 3
    .param p1, "WFC_setting"    # I
    .param p2, "wfcprefer"    # I
    .param p3, "call_status"    # I
    .param p4, "isWifiConnected"    # Z
    .param p5, "isgood"    # Z
    .param p6, "mobileState"    # I
    .param p7, "mobileTech"    # I

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    iput p6, p0, Lcom/android/server/ePDGConnection;->mobileservicestate:I

    iput p7, p0, Lcom/android/server/ePDGConnection;->mobileRadioTech:I

    if-nez p6, :cond_0

    const/16 v0, 0xe

    if-ne p7, v0, :cond_0

    move v0, v1

    :goto_0
    iput-boolean v0, p0, Lcom/android/server/ePDGConnection;->isMobileavail:Z

    iput p2, p0, Lcom/android/server/ePDGConnection;->WFCPrefer:I

    if-eq p1, v1, :cond_1

    iput-boolean v2, p0, Lcom/android/server/ePDGConnection;->WFCSettings:Z

    :goto_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "setinitialvalue, WFC settings : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/server/ePDGConnection;->WFCSettings:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " wfcprefer: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/server/ePDGConnection;->WFCPrefer:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " call status : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " isWiFi"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " isGood"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " isMobileava"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/server/ePDGConnection;->isMobileavail:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->log(Ljava/lang/String;)V

    iput p3, p0, Lcom/android/server/ePDGConnection;->CallState:I

    iput-boolean p4, p0, Lcom/android/server/ePDGConnection;->isWiFi:Z

    iput-boolean p5, p0, Lcom/android/server/ePDGConnection;->isGoodPacket:Z

    const v0, 0x40020

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGConnection;->sendMessage(Landroid/os/Message;)V

    return-void

    :cond_0
    move v0, v2

    goto :goto_0

    :cond_1
    iput-boolean v1, p0, Lcom/android/server/ePDGConnection;->WFCSettings:Z

    goto :goto_1
.end method
