.class public Lcom/android/internal/telephony/IMSPhone;
.super Lcom/android/internal/telephony/IIMSPhone$Stub;
.source "IMSPhone.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/IMSPhone$1;,
        Lcom/android/internal/telephony/IMSPhone$MyHandler;
    }
.end annotation


# static fields
.field private static final ACTION_DOD_LOG_SERVICE:Ljava/lang/String; = "com.lge.ims.action.DOD_LOG_SERVICE"

.field private static final BAL_ITEM_RADIO_IMS_CALL_STATE:I = 0xb

.field private static final BAL_ITEM_RADIO_IMS_REG_STATE:I = 0xd

.field private static final BAL_ITEM_RADIO_SIP_REG_SENDING:I = 0xa

.field private static final BAL_ITEM_RADIO_VOLTE_NV_ITEMS:I = 0xc

.field private static final CALL_TYPE_SIZE:I = 0x2

.field private static DEBUG_LOG:Z = false

.field public static final IMS_NOT_REGISTERED:I = 0x0

.field public static final IMS_REGISTERED:I = 0x1

.field public static final IMS_REGISTERED_VOLTE_UNSUPPORTED:I = 0x2

.field private static final OPERATOR:Ljava/lang/String;

.field private static final OPERATOR_ATT:Ljava/lang/String; = "ATT"

.field private static final OPERATOR_KDDI:Ljava/lang/String; = "KDDI"

.field private static final OPERATOR_KT:Ljava/lang/String; = "KT"

.field private static final OPERATOR_LGU:Ljava/lang/String; = "LGU"

.field private static final OPERATOR_SKT:Ljava/lang/String; = "SKT"

.field private static final OPERATOR_TMUS:Ljava/lang/String; = "TMO"

.field private static final OPERATOR_VZW:Ljava/lang/String; = "VZW"

.field private static final PHONE_STATE_1X_REGISTRATION:I = 0x2

.field private static final PHONE_STATE_CDMA_LOCK_INFO:I = 0x1

.field private static final PHONE_STATE_ICC_EF_READ_DONE:I = 0x3

.field private static final PHONE_STATE_IMS_PREF_STATE:I = 0x4

.field private static final RIL_ICC_EF_LINEAR_FIXED_READ_DONE:I = 0x65

.field private static final RIL_ICC_EF_TRANSPARENT_READ_DONE:I = 0x66

.field private static final RIL_IMS_PREF_STATE_IND:I = 0x6e

.field private static final RIL_IMS_SET_E911_STATE:I = 0x68

.field private static final RIL_IMS_SSAC_IND:I = 0x6f

.field private static final RIL_IMS_STATUS_FOR_UICC:I = 0x69

.field private static final RIL_IMS_STAUS_SET_DONE_FOR_DAN:I = 0x67

.field private static final RIL_RESPONSE:I = 0x64

.field private static final RIL_RESPONSE_UPDATE_REG_STATE:I = 0x6a

.field private static final RIL_RESPONSE_VOICE_DOMAIN:I = 0x6b

.field private static final RIL_RESPONSE_VOLTE_CALL_STATE:I = 0x6c

.field private static final SET_E911_TELEPHONY_DIAL:I = 0x1

.field private static final SET_E911_TELEPHONY_HANGUP:I = 0x2

.field private static final SYS_INFO_ACCESS_NETWORK_INFO:I = 0x3

.field private static final SYS_INFO_APN:I = 0x9

.field private static final SYS_INFO_CLOSE_DATA_CONNECTION:I = 0x5

.field private static final SYS_INFO_CS_CALL_PROTECTION:I = 0x6

.field private static final SYS_INFO_CS_CALL_STATE:I = 0xf

.field private static final SYS_INFO_GET_PREF_REG_STATE:I = 0x65

.field private static final SYS_INFO_ICC_EF_READ:I = 0x7

.field private static final SYS_INFO_IMS_REGISTRATION_STATE:I = 0x4

.field private static final SYS_INFO_IMS_REGISTRATION_STATE_FOR_MODEM:I = 0x12

.field private static final SYS_INFO_IMS_REG_INDICATOR:I = 0x16

.field private static final SYS_INFO_IMS_REG_STATUS_FOR_DAN:I = 0xb

.field private static final SYS_INFO_IMS_STATUS_FOR_UICC:I = 0x10

.field private static final SYS_INFO_LTE_NETWORK_FEATURE:I = 0x8

.field private static final SYS_INFO_MODEM_INFO:I = 0x1

.field private static final SYS_INFO_PAN_INFO_MODE:I = 0xc8

.field private static final SYS_INFO_PCSCF_ADDRESS:I = 0x2

.field private static final SYS_INFO_SET_CFU_STATE:I = 0x14

.field private static final SYS_INFO_SET_E911_STATE:I = 0xd

.field private static final SYS_INFO_SET_E911_TELEPHONY:I = 0xe

.field private static final SYS_INFO_SINGNAL_STRENGTH:I = 0x15

.field private static final SYS_INFO_SRVCC_CALL_INFO:I = 0xa

.field private static final SYS_INFO_SRVCC_CNAP_INFO:I = 0xc

.field private static final SYS_INFO_SRVCC_IMSCALL_STATE_INFO:I = 0x13

.field private static final SYS_INFO_SRVCC_PARTYTYPE_INFO:I = 0x11

.field private static final SYS_INFO_UPDATE_REG_STATE:I = 0x64

.field private static final SYS_INFO_UPDATE_VOICE_DOMAIN_STATE:I = 0x66

.field private static final SYS_INFO_UPDATE_VOLTE_CALL_STATE:I = 0x67

.field private static final TAG:Ljava/lang/String; = "LGIMS"

.field private static mContext:Landroid/content/Context;

.field private static mIMSPhone:Lcom/android/internal/telephony/IMSPhone;

.field private static mSysMonitor:Lcom/android/internal/telephony/ISysMonitor;


# instance fields
.field private mCM:Lcom/android/internal/telephony/CommandsInterface;

.field private mCNAPInfo:Ljava/lang/String;

.field private mConnectedNumber:Ljava/lang/String;

.field private mDataConnMngr:Lcom/android/internal/telephony/DataConnectionManager;

.field private mHandler:Landroid/os/Handler;

.field private mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

.field private mImsPrefState:I

.field private mImsRegIndicator:I

.field private mIsimHandler:Lcom/android/internal/telephony/LGImsIsimHandler;

.field private mPhone:Lcom/android/internal/telephony/Phone;

.field private mSysMode:I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 62
    const-string v0, "ro.build.target_operator"

    const-string v1, ""

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    .line 146
    sput-object v2, Lcom/android/internal/telephony/IMSPhone;->mIMSPhone:Lcom/android/internal/telephony/IMSPhone;

    .line 147
    sput-object v2, Lcom/android/internal/telephony/IMSPhone;->mContext:Landroid/content/Context;

    .line 148
    sput-object v2, Lcom/android/internal/telephony/IMSPhone;->mSysMonitor:Lcom/android/internal/telephony/ISysMonitor;

    .line 149
    const/4 v0, 0x1

    sput-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v0, 0x0

    .line 192
    invoke-direct {p0}, Lcom/android/internal/telephony/IIMSPhone$Stub;-><init>()V

    .line 151
    iput-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    .line 152
    iput-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    .line 153
    iput-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    .line 154
    iput-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mDataConnMngr:Lcom/android/internal/telephony/DataConnectionManager;

    .line 156
    iput-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mIsimHandler:Lcom/android/internal/telephony/LGImsIsimHandler;

    .line 158
    iput-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    .line 159
    iput-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mConnectedNumber:Ljava/lang/String;

    .line 160
    iput-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mCNAPInfo:Ljava/lang/String;

    .line 162
    const/4 v0, 0x2

    iput v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsRegIndicator:I

    .line 165
    iput v3, p0, Lcom/android/internal/telephony/IMSPhone;->mImsPrefState:I

    .line 166
    iput v3, p0, Lcom/android/internal/telephony/IMSPhone;->mSysMode:I

    .line 193
    const-string v0, "user"

    const-string v1, "ro.build.type"

    const-string v2, "userdebug"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 194
    sput-boolean v3, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    .line 197
    :cond_0
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_1

    .line 198
    const-string v0, "LGIMS"

    const-string v1, "IMSPhone is created..."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 200
    :cond_1
    return-void
.end method

.method static synthetic access$100()Z
    .locals 1

    .prologue
    .line 51
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    return v0
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/IMSPhone;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/IMSPhone;

    .prologue
    .line 51
    iget v0, p0, Lcom/android/internal/telephony/IMSPhone;->mSysMode:I

    return v0
.end method

.method static synthetic access$202(Lcom/android/internal/telephony/IMSPhone;I)I
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/IMSPhone;
    .param p1, "x1"    # I

    .prologue
    .line 51
    iput p1, p0, Lcom/android/internal/telephony/IMSPhone;->mSysMode:I

    return p1
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/IMSPhone;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/IMSPhone;

    .prologue
    .line 51
    iget v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsPrefState:I

    return v0
.end method

.method static synthetic access$302(Lcom/android/internal/telephony/IMSPhone;I)I
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/IMSPhone;
    .param p1, "x1"    # I

    .prologue
    .line 51
    iput p1, p0, Lcom/android/internal/telephony/IMSPhone;->mImsPrefState:I

    return p1
.end method

.method static synthetic access$400()Landroid/content/Context;
    .locals 1

    .prologue
    .line 51
    sget-object v0, Lcom/android/internal/telephony/IMSPhone;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method public static getInstance()Lcom/android/internal/telephony/IMSPhone;
    .locals 2

    .prologue
    .line 169
    sget-object v0, Lcom/android/internal/telephony/IMSPhone;->mIMSPhone:Lcom/android/internal/telephony/IMSPhone;

    if-nez v0, :cond_0

    .line 170
    new-instance v0, Lcom/android/internal/telephony/IMSPhone;

    invoke-direct {v0}, Lcom/android/internal/telephony/IMSPhone;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/IMSPhone;->mIMSPhone:Lcom/android/internal/telephony/IMSPhone;

    .line 171
    const-string v0, "com.lge.ims.phone"

    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->mIMSPhone:Lcom/android/internal/telephony/IMSPhone;

    invoke-static {v0, v1}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 173
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_0

    .line 174
    const-string v0, "LGIMS"

    const-string v1, "IMS phone sevice is Added to service manager"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 178
    :cond_0
    sget-object v0, Lcom/android/internal/telephony/IMSPhone;->mIMSPhone:Lcom/android/internal/telephony/IMSPhone;

    return-object v0
.end method

.method public static getSysMonitor()Lcom/android/internal/telephony/ISysMonitor;
    .locals 2

    .prologue
    .line 271
    sget-object v0, Lcom/android/internal/telephony/IMSPhone;->mSysMonitor:Lcom/android/internal/telephony/ISysMonitor;

    if-nez v0, :cond_0

    .line 272
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_0

    .line 273
    const-string v0, "LGIMS"

    const-string v1, "ISysMonitor is null"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 280
    :cond_0
    sget-object v0, Lcom/android/internal/telephony/IMSPhone;->mSysMonitor:Lcom/android/internal/telephony/ISysMonitor;

    return-object v0
.end method

.method public static isPhoneRequired(Landroid/content/Context;)Z
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 182
    if-eqz p0, :cond_0

    .line 183
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 185
    .local v0, "pm":Landroid/content/pm/PackageManager;
    if-eqz v0, :cond_0

    const-string v1, "com.lge.ims.imsphone"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 186
    const/4 v1, 0x1

    .line 189
    .end local v0    # "pm":Landroid/content/pm/PackageManager;
    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private setBalItem(II)V
    .locals 4
    .param p1, "item"    # I
    .param p2, "data"    # I

    .prologue
    .line 1106
    sget-boolean v1, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v1, :cond_0

    .line 1107
    const-string v1, "LGIMS"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setBalItem :: item ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "), data ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1110
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    if-nez v1, :cond_2

    .line 1111
    sget-boolean v1, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v1, :cond_1

    .line 1112
    const-string v1, "LGIMS"

    const-string v2, "mHandler is null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1192
    :cond_1
    :goto_0
    return-void

    .line 1117
    :cond_2
    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    if-nez v1, :cond_3

    .line 1118
    sget-boolean v1, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v1, :cond_1

    .line 1119
    const-string v1, "LGIMS"

    const-string v2, "mCM is null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1124
    :cond_3
    const/4 v0, -0x1

    .line 1126
    .local v0, "index":I
    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    const-string v2, "LGU"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 1127
    packed-switch p1, :pswitch_data_0

    .line 1133
    sget-boolean v1, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v1, :cond_4

    .line 1134
    const-string v1, "LGIMS"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unknown item ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1183
    :cond_4
    :goto_1
    const/4 v1, -0x1

    if-eq v0, v1, :cond_1

    .line 1187
    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v1, :cond_1

    .line 1191
    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    iget-object v2, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    const/16 v3, 0x64

    invoke-virtual {v2, v3}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-interface {v1, v0, p2, v2}, Lcom/android/internal/telephony/Phone;->setModemIntegerItem(IILandroid/os/Message;)V

    goto :goto_0

    .line 1129
    :pswitch_0
    const/4 v0, 0x7

    .line 1130
    goto :goto_1

    .line 1138
    :cond_5
    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    const-string v2, "SKT"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 1139
    packed-switch p1, :pswitch_data_1

    .line 1147
    :pswitch_1
    sget-boolean v1, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v1, :cond_4

    .line 1148
    const-string v1, "LGIMS"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unknown item ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 1141
    :pswitch_2
    const v0, 0x6002d

    .line 1142
    goto :goto_1

    .line 1144
    :pswitch_3
    const v0, 0x60039

    .line 1145
    goto :goto_1

    .line 1152
    :cond_6
    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    const-string v2, "KT"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 1153
    packed-switch p1, :pswitch_data_2

    .line 1161
    :pswitch_4
    sget-boolean v1, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v1, :cond_4

    .line 1162
    const-string v1, "LGIMS"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unknown item ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 1155
    :pswitch_5
    const v0, 0x6002d

    .line 1156
    goto/16 :goto_1

    .line 1158
    :pswitch_6
    const v0, 0x60039

    .line 1159
    goto/16 :goto_1

    .line 1166
    :cond_7
    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    const-string v2, "TMO"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    const-string v2, "ATT"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 1167
    :cond_8
    packed-switch p1, :pswitch_data_3

    .line 1176
    sget-boolean v1, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v1, :cond_4

    .line 1177
    const-string v1, "LGIMS"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unknown item ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .line 1169
    :pswitch_7
    const v0, 0x6002d

    .line 1170
    goto/16 :goto_1

    .line 1173
    :pswitch_8
    const/16 v0, 0x1e

    .line 1174
    goto/16 :goto_1

    .line 1127
    nop

    :pswitch_data_0
    .packed-switch 0xa
        :pswitch_0
    .end packed-switch

    .line 1139
    :pswitch_data_1
    .packed-switch 0xb
        :pswitch_2
        :pswitch_1
        :pswitch_3
    .end packed-switch

    .line 1153
    :pswitch_data_2
    .packed-switch 0xb
        :pswitch_5
        :pswitch_4
        :pswitch_6
    .end packed-switch

    .line 1167
    :pswitch_data_3
    .packed-switch 0xb
        :pswitch_7
        :pswitch_8
    .end packed-switch
.end method

.method public static setOemSsaHdvAlarmEvent([B)Z
    .locals 6
    .param p0, "mask"    # [B

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 1209
    new-instance v0, Landroid/content/Intent;

    const-string v3, "com.lge.ims.action.DOD_LOG_SERVICE"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1211
    .local v0, "intent":Landroid/content/Intent;
    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    .line 1212
    :cond_0
    sget-boolean v1, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v1, :cond_2

    .line 1213
    const-string v1, "LGIMS"

    const-string v3, "setOemSsatHdvAlarmEvent failed.."

    invoke-static {v1, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v1, v2

    .line 1227
    :goto_0
    return v1

    .line 1219
    :cond_1
    const-string v3, "LGIMS"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "send OemSsaHdvAlarmEvent Intent: length="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    array-length v5, p0

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " value="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget-byte v5, p0, v2

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1220
    array-length v3, p0

    if-ne v3, v1, :cond_2

    aget-byte v3, p0, v2

    const/4 v4, -0x1

    if-eq v3, v4, :cond_2

    .line 1222
    const-string v3, "byte_array_param"

    aget-byte v2, p0, v2

    invoke-virtual {v0, v3, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;B)Landroid/content/Intent;

    .line 1223
    sget-object v2, Lcom/android/internal/telephony/IMSPhone;->mContext:Landroid/content/Context;

    invoke-virtual {v2, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0

    :cond_2
    move v1, v2

    .line 1227
    goto :goto_0
.end method


# virtual methods
.method public getCNAPInfo()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1204
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mCNAPInfo:Ljava/lang/String;

    return-object v0
.end method

.method public getConnectedNumber()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1200
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mConnectedNumber:Ljava/lang/String;

    return-object v0
.end method

.method public getImsCallInfo()Lcom/android/internal/telephony/ImsCallInfo;
    .locals 1

    .prologue
    .line 1196
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    return-object v0
.end method

.method public getImsRegIndicator()I
    .locals 1

    .prologue
    .line 1231
    iget v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsRegIndicator:I

    return v0
.end method

.method public getSysInfo(IILjava/lang/String;)[Ljava/lang/String;
    .locals 10
    .param p1, "item"    # I
    .param p2, "param"    # I
    .param p3, "paramEx"    # Ljava/lang/String;

    .prologue
    const v6, 0xffff

    const/4 v8, 0x2

    const/4 v4, 0x0

    const/4 v7, 0x1

    const/4 v9, 0x0

    .line 588
    sparse-switch p1, :sswitch_data_0

    .line 783
    sget-boolean v5, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v5, :cond_0

    .line 784
    const-string v5, "LGIMS"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Unknown item ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ")"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 789
    :cond_0
    :goto_0
    return-object v4

    .line 592
    :sswitch_0
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v5, :cond_0

    .line 596
    const/4 v5, 0x4

    if-ne p2, v5, :cond_3

    .line 597
    if-eqz p3, :cond_1

    if-eqz p3, :cond_2

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 598
    :cond_1
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    const-string v6, "INET"

    invoke-interface {v5, v6}, Lcom/android/internal/telephony/Phone;->getPcscfAddress(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    .line 600
    :cond_2
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    const-string v6, "INET"

    invoke-interface {v5, v6, p3}, Lcom/android/internal/telephony/Phone;->getPcscfAddress(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    .line 602
    :cond_3
    const/4 v5, 0x6

    if-ne p2, v5, :cond_6

    .line 603
    if-eqz p3, :cond_4

    if-eqz p3, :cond_5

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_5

    .line 604
    :cond_4
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    const-string v6, "INET6"

    invoke-interface {v5, v6}, Lcom/android/internal/telephony/Phone;->getPcscfAddress(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    .line 606
    :cond_5
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    const-string v6, "INET6"

    invoke-interface {v5, v6, p3}, Lcom/android/internal/telephony/Phone;->getPcscfAddress(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    .line 610
    :cond_6
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5, p3}, Lcom/android/internal/telephony/Phone;->getPcscfAddress(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    .line 617
    :sswitch_1
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v5, :cond_0

    .line 621
    const/16 v5, 0xd

    if-ne p2, v5, :cond_7

    .line 622
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getLteInfo()[Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    .line 623
    :cond_7
    const/16 v5, 0xe

    if-ne p2, v5, :cond_0

    .line 624
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getCdmaInfo()[Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    .line 632
    :sswitch_2
    new-array v4, v7, [Ljava/lang/String;

    .line 634
    .local v4, "result":[Ljava/lang/String;
    const-string v5, "FAILURE"

    aput-object v5, v4, v9

    .line 636
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v5, :cond_0

    .line 640
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    if-eqz v5, :cond_0

    .line 644
    if-eqz p3, :cond_8

    if-eqz p3, :cond_9

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v5

    if-nez v5, :cond_9

    .line 645
    :cond_8
    const-string p3, "linear_fixed"

    .line 649
    :cond_9
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    check-cast v5, Lcom/android/internal/telephony/PhoneProxy;

    invoke-virtual {v5}, Lcom/android/internal/telephony/PhoneProxy;->getIccCard()Lcom/android/internal/telephony/IccCard;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/uicc/IccCardProxy;

    .line 651
    .local v0, "iccCP":Lcom/android/internal/telephony/uicc/IccCardProxy;
    if-eqz v0, :cond_0

    .line 655
    invoke-virtual {v0}, Lcom/android/internal/telephony/uicc/IccCardProxy;->getIccFileHandler()Lcom/android/internal/telephony/uicc/IccFileHandler;

    move-result-object v1

    .line 657
    .local v1, "iccFH":Lcom/android/internal/telephony/uicc/IccFileHandler;
    if-eqz v1, :cond_0

    .line 658
    const-string v5, "linear_fixed"

    invoke-virtual {v5, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_a

    .line 660
    and-int v5, p2, v6

    iget-object v6, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    const/16 v7, 0x65

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Lcom/android/internal/telephony/uicc/IccFileHandler;->loadEFLinearFixedAll(ILandroid/os/Message;)V

    .line 662
    const-string v5, "SUCCESS"

    aput-object v5, v4, v9

    goto/16 :goto_0

    .line 663
    :cond_a
    const-string v5, "transparent"

    invoke-virtual {v5, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 664
    and-int v5, p2, v6

    iget-object v6, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    const/16 v7, 0x66

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v6, v7, v8}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Lcom/android/internal/telephony/uicc/IccFileHandler;->loadEFTransparent(ILandroid/os/Message;)V

    .line 666
    const-string v5, "SUCCESS"

    aput-object v5, v4, v9

    goto/16 :goto_0

    .line 676
    .end local v0    # "iccCP":Lcom/android/internal/telephony/uicc/IccCardProxy;
    .end local v1    # "iccFH":Lcom/android/internal/telephony/uicc/IccFileHandler;
    .end local v4    # "result":[Ljava/lang/String;
    :sswitch_3
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v5, :cond_0

    .line 680
    const/4 v4, 0x0

    .line 684
    .restart local v4    # "result":[Ljava/lang/String;
    if-ne p2, v7, :cond_d

    .line 685
    new-array v4, v7, [Ljava/lang/String;

    .line 687
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->isEmergencyCallSupportedOnLte()Z

    move-result v5

    if-eqz v5, :cond_c

    .line 688
    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v9

    .line 702
    :cond_b
    :goto_1
    if-eqz v4, :cond_0

    .line 703
    sget-boolean v5, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v5, :cond_0

    .line 704
    const-string v5, "LGIMS"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "LTE network feature :: param("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "), result("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    aget-object v7, v4, v9

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ")"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 690
    :cond_c
    invoke-static {v9}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v9

    goto :goto_1

    .line 692
    :cond_d
    if-ne p2, v8, :cond_b

    .line 693
    new-array v4, v7, [Ljava/lang/String;

    .line 695
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->isVoiceCallSupprotedOnLte()Z

    move-result v5

    if-eqz v5, :cond_e

    .line 696
    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v9

    goto :goto_1

    .line 698
    :cond_e
    invoke-static {v9}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v9

    goto :goto_1

    .line 713
    .end local v4    # "result":[Ljava/lang/String;
    :sswitch_4
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v5, :cond_0

    .line 717
    new-array v4, v7, [Ljava/lang/String;

    .line 719
    .restart local v4    # "result":[Ljava/lang/String;
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5, p3}, Lcom/android/internal/telephony/Phone;->getActiveApnHost(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v9

    goto/16 :goto_0

    .line 726
    .end local v4    # "result":[Ljava/lang/String;
    :sswitch_5
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v5, :cond_0

    .line 730
    new-array v4, v7, [Ljava/lang/String;

    .line 732
    .restart local v4    # "result":[Ljava/lang/String;
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getState()Lcom/android/internal/telephony/PhoneConstants$State;

    move-result-object v5

    sget-object v6, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-ne v5, v6, :cond_f

    .line 733
    invoke-static {v9}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v9

    .line 741
    :goto_2
    if-eqz v4, :cond_0

    .line 742
    sget-boolean v5, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v5, :cond_0

    .line 743
    const-string v5, "LGIMS"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getState "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    aget-object v7, v4, v9

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 734
    :cond_f
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getState()Lcom/android/internal/telephony/PhoneConstants$State;

    move-result-object v5

    sget-object v6, Lcom/android/internal/telephony/PhoneConstants$State;->RINGING:Lcom/android/internal/telephony/PhoneConstants$State;

    if-ne v5, v6, :cond_10

    .line 735
    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v9

    goto :goto_2

    .line 736
    :cond_10
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getState()Lcom/android/internal/telephony/PhoneConstants$State;

    move-result-object v5

    sget-object v6, Lcom/android/internal/telephony/PhoneConstants$State;->OFFHOOK:Lcom/android/internal/telephony/PhoneConstants$State;

    if-ne v5, v6, :cond_11

    .line 737
    invoke-static {v8}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v9

    goto :goto_2

    .line 739
    :cond_11
    invoke-static {v9}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v9

    goto :goto_2

    .line 752
    .end local v4    # "result":[Ljava/lang/String;
    :sswitch_6
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v5, :cond_0

    .line 755
    new-array v4, v7, [Ljava/lang/String;

    .line 756
    .restart local v4    # "result":[Ljava/lang/String;
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v5}, Lcom/android/internal/telephony/Phone;->getSignalStrength()Landroid/telephony/SignalStrength;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/SignalStrength;->getDbm()I

    move-result v2

    .line 757
    .local v2, "nrsrp":I
    const-string v5, "LGIMS"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "nrsrp"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 758
    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v9

    goto/16 :goto_0

    .line 764
    .end local v2    # "nrsrp":I
    .end local v4    # "result":[Ljava/lang/String;
    :sswitch_7
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v5, :cond_0

    .line 767
    new-array v3, v7, [Ljava/lang/String;

    .line 768
    .local v3, "panInfoMode":[Ljava/lang/String;
    iget-object v5, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    check-cast v5, Lcom/android/internal/telephony/PhoneProxy;

    invoke-virtual {v5}, Lcom/android/internal/telephony/PhoneProxy;->getLteTddInfo()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v9

    move-object v4, v3

    .line 769
    goto/16 :goto_0

    .line 774
    .end local v3    # "panInfoMode":[Ljava/lang/String;
    :sswitch_8
    new-array v4, v8, [Ljava/lang/String;

    .line 776
    .restart local v4    # "result":[Ljava/lang/String;
    iget v5, p0, Lcom/android/internal/telephony/IMSPhone;->mSysMode:I

    invoke-static {v5}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v9

    .line 777
    iget v5, p0, Lcom/android/internal/telephony/IMSPhone;->mImsPrefState:I

    invoke-static {v5}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v7

    goto/16 :goto_0

    .line 588
    :sswitch_data_0
    .sparse-switch
        0x2 -> :sswitch_0
        0x3 -> :sswitch_1
        0x7 -> :sswitch_2
        0x8 -> :sswitch_3
        0x9 -> :sswitch_4
        0xf -> :sswitch_5
        0x15 -> :sswitch_6
        0x65 -> :sswitch_8
        0xc8 -> :sswitch_7
    .end sparse-switch
.end method

.method public handleRemoteException()V
    .locals 3

    .prologue
    .line 284
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/IMSPhone;->mSysMonitor:Lcom/android/internal/telephony/ISysMonitor;

    .line 286
    sget-object v0, Lcom/android/internal/telephony/IMSPhone;->mContext:Landroid/content/Context;

    new-instance v1, Landroid/content/Intent;

    const-string v2, "com.lge.ims.action.IMS_PHONE_STARTED"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    .line 288
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_0

    .line 289
    const-string v0, "LGIMS"

    const-string v1, "handling remote exception"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 291
    :cond_0
    return-void
.end method

.method public setDefaultPhone(Landroid/content/Context;Lcom/android/internal/telephony/Phone;Lcom/android/internal/telephony/CommandsInterface;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "phone"    # Lcom/android/internal/telephony/Phone;
    .param p3, "cm"    # Lcom/android/internal/telephony/CommandsInterface;

    .prologue
    const/4 v4, 0x0

    .line 203
    sget-boolean v1, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v1, :cond_0

    .line 204
    const-string v1, "LGIMS"

    const-string v2, "setDefaultPhone is called..."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 207
    :cond_0
    if-eqz p1, :cond_1

    if-eqz p2, :cond_1

    if-nez p3, :cond_3

    .line 208
    :cond_1
    sget-boolean v1, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v1, :cond_2

    .line 209
    const-string v1, "LGIMS"

    const-string v2, "context or phone or cm is null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 268
    :cond_2
    :goto_0
    return-void

    .line 214
    :cond_3
    sput-object p1, Lcom/android/internal/telephony/IMSPhone;->mContext:Landroid/content/Context;

    .line 215
    iput-object p3, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    .line 216
    iput-object p2, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    .line 218
    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    if-nez v1, :cond_4

    .line 219
    new-instance v1, Lcom/android/internal/telephony/IMSPhone$MyHandler;

    invoke-direct {v1, p0, v4}, Lcom/android/internal/telephony/IMSPhone$MyHandler;-><init>(Lcom/android/internal/telephony/IMSPhone;Lcom/android/internal/telephony/IMSPhone$1;)V

    iput-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    .line 222
    :cond_4
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 224
    .local v0, "pm":Landroid/content/pm/PackageManager;
    if-eqz v0, :cond_5

    const-string v1, "com.lge.ims.srvcc"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    if-nez v1, :cond_5

    .line 225
    const-string v1, "LGIMS"

    const-string v2, "SRVCC feature enabled..."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 226
    new-instance v1, Lcom/android/internal/telephony/ImsCallInfoImpl;

    invoke-direct {v1}, Lcom/android/internal/telephony/ImsCallInfoImpl;-><init>()V

    iput-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    .line 230
    :cond_5
    if-eqz v0, :cond_6

    const-string v1, "com.lge.ims.hvolte"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 231
    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v2, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    const/16 v3, 0x6e

    invoke-interface {v1, v2, v3, v4}, Lcom/android/internal/telephony/CommandsInterface;->registerIMSPrefStatusInd(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 232
    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v2, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    const/16 v3, 0x6f

    invoke-interface {v1, v2, v3, v4}, Lcom/android/internal/telephony/CommandsInterface;->registerSsacChangeInfoInd(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 235
    :cond_6
    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mIsimHandler:Lcom/android/internal/telephony/LGImsIsimHandler;

    if-eqz v1, :cond_7

    .line 236
    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mIsimHandler:Lcom/android/internal/telephony/LGImsIsimHandler;

    invoke-virtual {v1}, Lcom/android/internal/telephony/LGImsIsimHandler;->dispose()V

    .line 239
    :cond_7
    new-instance v1, Lcom/android/internal/telephony/LGImsIsimHandler;

    sget-object v2, Lcom/android/internal/telephony/IMSPhone;->mContext:Landroid/content/Context;

    invoke-direct {v1, v2}, Lcom/android/internal/telephony/LGImsIsimHandler;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mIsimHandler:Lcom/android/internal/telephony/LGImsIsimHandler;

    .line 241
    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    const-string v2, "ATT"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 267
    :cond_8
    :goto_1
    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->mContext:Landroid/content/Context;

    new-instance v2, Landroid/content/Intent;

    const-string v3, "com.lge.ims.action.IMS_PHONE_STARTED"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_0

    .line 243
    :cond_9
    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    const-string v2, "KT"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    .line 245
    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    const-string v2, "LGU"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_a

    .line 246
    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    if-eqz v1, :cond_8

    goto :goto_1

    .line 258
    :cond_a
    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    const-string v2, "TMO"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    .line 260
    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    const-string v2, "VZW"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    .line 262
    sget-object v1, Lcom/android/internal/telephony/IMSPhone;->OPERATOR:Ljava/lang/String;

    const-string v2, "KDDI"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    goto :goto_1
.end method

.method public setListener(Lcom/android/internal/telephony/ISysMonitor;)V
    .locals 3
    .param p1, "listener"    # Lcom/android/internal/telephony/ISysMonitor;

    .prologue
    .line 1098
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_0

    .line 1099
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setListener listener "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1101
    :cond_0
    sput-object p1, Lcom/android/internal/telephony/IMSPhone;->mSysMonitor:Lcom/android/internal/telephony/ISysMonitor;

    .line 1102
    return-void
.end method

.method public setSysInfo(IIILjava/lang/String;)V
    .locals 11
    .param p1, "item"    # I
    .param p2, "param1"    # I
    .param p3, "param2"    # I
    .param p4, "paramEx"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x2

    const/4 v5, 0x0

    const/4 v1, 0x1

    .line 794
    sparse-switch p1, :sswitch_data_0

    .line 1090
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_0

    .line 1091
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unknown item ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1095
    :cond_0
    :goto_0
    :sswitch_0
    return-void

    .line 797
    :sswitch_1
    invoke-direct {p0, p2, p3}, Lcom/android/internal/telephony/IMSPhone;->setBalItem(II)V

    goto :goto_0

    .line 803
    :sswitch_2
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v0, :cond_0

    .line 807
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_1

    .line 808
    const-string v0, "LGIMS"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "REG STATE = "

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 811
    :cond_1
    if-lez p2, :cond_2

    move v4, v1

    .line 813
    .local v4, "regState":Z
    :goto_1
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v0, v4}, Lcom/android/internal/telephony/Phone;->setImsRegistrationState(Z)V

    goto :goto_0

    .end local v4    # "regState":Z
    :cond_2
    move v4, v5

    .line 811
    goto :goto_1

    .line 819
    :sswitch_3
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v0, :cond_0

    .line 823
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_3

    .line 824
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "REG STATE FOR MODEM = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 827
    :cond_3
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v0, p2}, Lcom/android/internal/telephony/Phone;->sendIMSRegistate(I)V

    goto :goto_0

    .line 833
    :sswitch_4
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v0, :cond_0

    .line 837
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v0, p2}, Lcom/android/internal/telephony/Phone;->closeImsPdn(I)V

    goto :goto_0

    .line 854
    :sswitch_5
    iput-object p4, p0, Lcom/android/internal/telephony/IMSPhone;->mConnectedNumber:Ljava/lang/String;

    .line 855
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    if-eqz v0, :cond_0

    .line 856
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    invoke-virtual {v0, p4}, Lcom/android/internal/telephony/ImsCallInfoImpl;->setConnectedNumber(Ljava/lang/String;)V

    .line 857
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    invoke-virtual {v0, p2}, Lcom/android/internal/telephony/ImsCallInfoImpl;->setConnectedNumberPresentation(I)V

    .line 858
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    invoke-virtual {v0, p3}, Lcom/android/internal/telephony/ImsCallInfoImpl;->setIsConferenceCall(I)V

    goto :goto_0

    .line 863
    :sswitch_6
    iput-object p4, p0, Lcom/android/internal/telephony/IMSPhone;->mCNAPInfo:Ljava/lang/String;

    .line 864
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    if-eqz v0, :cond_0

    .line 865
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    invoke-virtual {v0, p4}, Lcom/android/internal/telephony/ImsCallInfoImpl;->setConnectedName(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 870
    :sswitch_7
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    if-eqz v0, :cond_0

    .line 871
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    invoke-virtual {v0, p2}, Lcom/android/internal/telephony/ImsCallInfoImpl;->setPartyType(I)V

    goto/16 :goto_0

    .line 875
    :sswitch_8
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    if-eqz v0, :cond_0

    .line 876
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mImsCallInfo:Lcom/android/internal/telephony/ImsCallInfoImpl;

    invoke-virtual {v0, p2}, Lcom/android/internal/telephony/ImsCallInfoImpl;->setIMSCallState(I)V

    goto/16 :goto_0

    .line 884
    :sswitch_9
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v0, :cond_0

    .line 889
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_4

    .line 890
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "IMS REG is DONE"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 892
    :cond_4
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    const/16 v2, 0x67

    invoke-virtual {v1, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-interface {v0, p2, v1}, Lcom/android/internal/telephony/Phone;->setImsStatusForDan(ILandroid/os/Message;)V

    goto/16 :goto_0

    .line 899
    :sswitch_a
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v0, :cond_0

    .line 903
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_5

    .line 904
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Emergency Call State"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 905
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Emergency Call mode"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 909
    :cond_5
    const-string v0, "LGIMS"

    const-string v1, "Not yet implented in Phone"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 915
    :sswitch_b
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    if-eqz v0, :cond_0

    .line 919
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_6

    .line 920
    const-string v0, "LGIMS"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "SYS_INFO_SET_E911_TELEPHONY param2"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v0, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 921
    const-string v0, "LGIMS"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "SYS_INFO_SET_E911_TELEPHONY paramEx"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v0, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 924
    :cond_6
    if-ne p2, v1, :cond_8

    .line 925
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_7

    .line 926
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SYS_INFO_SET_E911_TELEPHONY - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 928
    :cond_7
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v0, p4}, Lcom/android/internal/telephony/Phone;->dialForVolte(Ljava/lang/String;)Z

    goto/16 :goto_0

    .line 930
    :cond_8
    if-ne p2, v2, :cond_b

    .line 932
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_9

    .line 933
    const-string v0, "LGIMS"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "SYS_INFO_SET_E911_TELEPHONY - "

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 936
    :cond_9
    if-ne p3, v1, :cond_a

    .line 937
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/Phone;->hangUpForVolte(Z)Z

    goto/16 :goto_0

    .line 940
    :cond_a
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v0, v5}, Lcom/android/internal/telephony/Phone;->hangUpForVolte(Z)Z

    goto/16 :goto_0

    .line 946
    :cond_b
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_0

    .line 947
    const-string v0, "LGIMS"

    const-string v1, "SYS_INFO_SET_E911_TELEPHONY - NOT EXPECTED"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 956
    :sswitch_c
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    if-eqz v0, :cond_0

    .line 960
    if-eqz p4, :cond_0

    .line 964
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_c

    .line 965
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "IMS Status for UICC = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 966
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "IMS Status code = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 968
    :cond_c
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    const/16 v2, 0x69

    invoke-virtual {v1, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-interface {v0, p4, v1}, Lcom/android/internal/telephony/CommandsInterface;->sendEnvelope(Ljava/lang/String;Landroid/os/Message;)V

    goto/16 :goto_0

    .line 975
    :sswitch_d
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    if-eqz v0, :cond_0

    .line 979
    const-string v0, "LGIMS"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "update ims reg state :: sys mode = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " , state = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v0, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 983
    new-array v3, v2, [I

    .line 984
    .local v3, "callType":[I
    aput v5, v3, v5

    .line 985
    aput v1, v3, v1

    .line 989
    new-array v4, v2, [I

    .line 991
    .local v4, "regState":[I
    if-nez p3, :cond_e

    .line 993
    aput v5, v4, v5

    .line 994
    aput v5, v4, v1

    .line 1005
    :cond_d
    :goto_2
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    const/16 v5, 0x6a

    invoke-virtual {v1, v5}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v5

    move v1, p2

    invoke-interface/range {v0 .. v5}, Lcom/android/internal/telephony/CommandsInterface;->updateIMSStateReq(II[I[ILandroid/os/Message;)V

    goto/16 :goto_0

    .line 995
    :cond_e
    if-ne p3, v1, :cond_f

    .line 997
    aput v1, v4, v5

    .line 998
    aput v1, v4, v1

    goto :goto_2

    .line 999
    :cond_f
    if-ne p3, v2, :cond_d

    .line 1001
    aput v5, v4, v5

    .line 1002
    aput v1, v4, v1

    goto :goto_2

    .line 1013
    .end local v3    # "callType":[I
    .end local v4    # "regState":[I
    :sswitch_e
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    if-eqz v0, :cond_0

    .line 1017
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "update voice domain state = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1026
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    const/16 v2, 0x6b

    invoke-virtual {v1, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-interface {v0, p2, v1}, Lcom/android/internal/telephony/CommandsInterface;->setVoiceDomainPref(ILandroid/os/Message;)V

    goto/16 :goto_0

    .line 1034
    :sswitch_f
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    if-eqz v0, :cond_0

    .line 1038
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "update volte call state = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1047
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mCM:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v1, p0, Lcom/android/internal/telephony/IMSPhone;->mHandler:Landroid/os/Handler;

    const/16 v2, 0x6c

    invoke-virtual {v1, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-interface {v0, p2, v1}, Lcom/android/internal/telephony/CommandsInterface;->setVolteCallStatus(ILandroid/os/Message;)V

    goto/16 :goto_0

    .line 1054
    :sswitch_10
    iput p2, p0, Lcom/android/internal/telephony/IMSPhone;->mImsRegIndicator:I

    .line 1055
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_0

    .line 1056
    const-string v0, "LGIMS"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "IMS Reg Indicator : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/IMSPhone;->mImsRegIndicator:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 1064
    :sswitch_11
    sget-boolean v0, Lcom/android/internal/telephony/IMSPhone;->DEBUG_LOG:Z

    if-eqz v0, :cond_10

    .line 1065
    const-string v0, "LGIMS"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "CFU STATE = "

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v9, " Target is "

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1068
    :cond_10
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    check-cast v0, Lcom/android/internal/telephony/PhoneProxy;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneProxy;->getIccCard()Lcom/android/internal/telephony/IccCard;

    move-result-object v7

    check-cast v7, Lcom/android/internal/telephony/uicc/IccCardProxy;

    .line 1070
    .local v7, "iccCP":Lcom/android/internal/telephony/uicc/IccCardProxy;
    if-eqz v7, :cond_0

    .line 1074
    if-eqz p4, :cond_0

    .line 1078
    invoke-virtual {v7}, Lcom/android/internal/telephony/uicc/IccCardProxy;->getIccRecords()Lcom/android/internal/telephony/uicc/IccRecords;

    move-result-object v8

    .line 1079
    .local v8, "r":Lcom/android/internal/telephony/uicc/IccRecords;
    if-eqz v8, :cond_11

    .line 1080
    if-ne p2, v1, :cond_12

    move v0, v1

    :goto_3
    invoke-virtual {v8, v1, v0, p4}, Lcom/android/internal/telephony/uicc/IccRecords;->setVoiceCallForwardingFlag(IZLjava/lang/String;)V

    .line 1083
    :cond_11
    iget-object v0, p0, Lcom/android/internal/telephony/IMSPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    check-cast v0, Lcom/android/internal/telephony/PhoneProxy;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneProxy;->getActivePhone()Lcom/android/internal/telephony/Phone;

    move-result-object v6

    check-cast v6, Lcom/android/internal/telephony/gsm/GSMPhone;

    .line 1084
    .local v6, "gsmPhone":Lcom/android/internal/telephony/gsm/GSMPhone;
    if-ne p2, v1, :cond_13

    :goto_4
    invoke-virtual {v6, v1}, Lcom/android/internal/telephony/gsm/GSMPhone;->setCallForwardingPreference(Z)V

    goto/16 :goto_0

    .end local v6    # "gsmPhone":Lcom/android/internal/telephony/gsm/GSMPhone;
    :cond_12
    move v0, v5

    .line 1080
    goto :goto_3

    .restart local v6    # "gsmPhone":Lcom/android/internal/telephony/gsm/GSMPhone;
    :cond_13
    move v1, v5

    .line 1084
    goto :goto_4

    .line 794
    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_1
        0x4 -> :sswitch_2
        0x5 -> :sswitch_4
        0x6 -> :sswitch_0
        0xa -> :sswitch_5
        0xb -> :sswitch_9
        0xc -> :sswitch_6
        0xd -> :sswitch_a
        0xe -> :sswitch_b
        0x10 -> :sswitch_c
        0x11 -> :sswitch_7
        0x12 -> :sswitch_3
        0x13 -> :sswitch_8
        0x14 -> :sswitch_11
        0x16 -> :sswitch_10
        0x64 -> :sswitch_d
        0x66 -> :sswitch_e
        0x67 -> :sswitch_f
    .end sparse-switch
.end method
