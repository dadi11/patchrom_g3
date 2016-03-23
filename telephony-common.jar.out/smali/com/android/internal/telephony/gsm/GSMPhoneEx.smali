.class public Lcom/android/internal/telephony/gsm/GSMPhoneEx;
.super Lcom/android/internal/telephony/gsm/GSMPhone;
.source "GSMPhoneEx.java"


# static fields
.field private static final DEFAULT_ECM_EXIT_TIMER_VALUE:I = 0x493e0

.field private static final LOCAL_DEBUG:Z = true

.field protected static final LOG_TAG:Ljava/lang/String; = "GSMPhoneEx"

.field public static final mIndiaGWLArray:[Ljava/lang/String;

.field private static sIsLte:Z

.field private static smIsCheckedLTEReady:Z

.field private static smPhone:Lcom/android/internal/telephony/Phone;


# instance fields
.field gfUtils:Lcom/android/internal/telephony/gfit/GfitUtils;

.field private mEcmExitRespRegistrant:Landroid/os/Registrant;

.field private final mEcmTimerResetRegistrants:Landroid/os/RegistrantList;

.field protected mEsn:Ljava/lang/String;

.field private mExitEcmRunnable:Ljava/lang/Runnable;

.field protected mIsPhoneInEcmState:Z

.field protected mMeid:Ljava/lang/String;

.field private mSimStateReceiver:Landroid/content/BroadcastReceiver;

.field protected mWakeLock:Landroid/os/PowerManager$WakeLock;

.field protected retryNum:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 121
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smPhone:Lcom/android/internal/telephony/Phone;

    .line 122
    sput-boolean v2, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smIsCheckedLTEReady:Z

    .line 123
    sput-boolean v3, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->sIsLte:Z

    .line 643
    const/16 v0, 0x2d

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "40402"

    aput-object v1, v0, v2

    const-string v1, "40403"

    aput-object v1, v0, v3

    const/4 v1, 0x2

    const-string v2, "40410"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "40416"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "40431"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "40440"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "40445"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "40449"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "40470"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "40490"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "40492"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "40493"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "40494"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "40495"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "40496"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "40497"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "40498"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "40551"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "40552"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "40553"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "40554"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "40555"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "40556"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "405840"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "405854"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, "405855"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, "405856"

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    const-string v2, "405857"

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    const-string v2, "405858"

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    const-string v2, "405859"

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    const-string v2, "405860"

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    const-string v2, "405861"

    aput-object v2, v0, v1

    const/16 v1, 0x20

    const-string v2, "405862"

    aput-object v2, v0, v1

    const/16 v1, 0x21

    const-string v2, "405863"

    aput-object v2, v0, v1

    const/16 v1, 0x22

    const-string v2, "405864"

    aput-object v2, v0, v1

    const/16 v1, 0x23

    const-string v2, "405865"

    aput-object v2, v0, v1

    const/16 v1, 0x24

    const-string v2, "405866"

    aput-object v2, v0, v1

    const/16 v1, 0x25

    const-string v2, "405867"

    aput-object v2, v0, v1

    const/16 v1, 0x26

    const-string v2, "405868"

    aput-object v2, v0, v1

    const/16 v1, 0x27

    const-string v2, "405869"

    aput-object v2, v0, v1

    const/16 v1, 0x28

    const-string v2, "405870"

    aput-object v2, v0, v1

    const/16 v1, 0x29

    const-string v2, "405871"

    aput-object v2, v0, v1

    const/16 v1, 0x2a

    const-string v2, "405872"

    aput-object v2, v0, v1

    const/16 v1, 0x2b

    const-string v2, "405873"

    aput-object v2, v0, v1

    const/16 v1, 0x2c

    const-string v2, "405874"

    aput-object v2, v0, v1

    sput-object v0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIndiaGWLArray:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;

    .prologue
    .line 128
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;Z)V

    .line 129
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;I)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;
    .param p4, "phoneId"    # I

    .prologue
    .line 175
    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;ZI)V

    .line 176
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;Z)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;
    .param p4, "unitTestMode"    # Z

    .prologue
    const/4 v6, 0x0

    const/16 v5, 0x1a

    const/4 v4, 0x0

    .line 133
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/android/internal/telephony/gsm/GSMPhone;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;Z)V

    .line 92
    iput v4, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->retryNum:I

    .line 103
    new-instance v2, Landroid/os/RegistrantList;

    invoke-direct {v2}, Landroid/os/RegistrantList;-><init>()V

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEcmTimerResetRegistrants:Landroid/os/RegistrantList;

    .line 112
    new-instance v2, Lcom/android/internal/telephony/gsm/GSMPhoneEx$1;

    invoke-direct {v2, p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx$1;-><init>(Lcom/android/internal/telephony/gsm/GSMPhoneEx;)V

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mExitEcmRunnable:Ljava/lang/Runnable;

    .line 373
    new-instance v2, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;

    invoke-direct {v2, p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;-><init>(Lcom/android/internal/telephony/gsm/GSMPhoneEx;)V

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    .line 136
    const-string v2, "vzw_gfit"

    invoke-static {p1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 137
    new-instance v2, Lcom/android/internal/telephony/gfit/GfitUtils;

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mSST:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    invoke-direct {v2, v3, p0}, Lcom/android/internal/telephony/gfit/GfitUtils;-><init>(Lcom/android/internal/telephony/ServiceStateTracker;Lcom/android/internal/telephony/PhoneBaseEx;)V

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->gfUtils:Lcom/android/internal/telephony/gfit/GfitUtils;

    .line 142
    :cond_0
    const-string v2, "support_emergency_callback_mode_for_gsm"

    invoke-static {p1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 143
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v3, 0x19

    invoke-interface {v2, p0, v3, v6}, Lcom/android/internal/telephony/CommandsInterface;->setEmergencyCallbackMode(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 144
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v2, p0, v5, v6}, Lcom/android/internal/telephony/CommandsInterface;->registerForExitEmergencyCallbackMode(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 147
    :cond_1
    const-string v2, "power"

    invoke-virtual {p1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/os/PowerManager;

    .line 149
    .local v1, "pm":Landroid/os/PowerManager;
    const/4 v2, 0x1

    const-string v3, "GSMPhoneEx"

    invoke-virtual {v1, v2, v3}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v2

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    .line 151
    const-string v2, "ril.cdma.inecmmode"

    const-string v3, "false"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 152
    .local v0, "inEcm":Ljava/lang/String;
    const-string v2, "true"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    .line 154
    iget-boolean v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    if-eqz v2, :cond_2

    .line 156
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->initForSupportedEcmOnGsm(Landroid/content/Context;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 159
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->exitEmergencyCallbackMode(Landroid/os/Message;)V

    .line 165
    :cond_2
    iput-boolean v4, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmExitDelayState:Z

    .line 169
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->processRegistering(Landroid/content/Context;)V

    .line 171
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;ZI)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;
    .param p4, "unitTestMode"    # Z
    .param p5, "phoneId"    # I

    .prologue
    const/4 v6, 0x0

    const/16 v5, 0x1a

    const/4 v4, 0x0

    .line 181
    invoke-direct/range {p0 .. p5}, Lcom/android/internal/telephony/gsm/GSMPhone;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;ZI)V

    .line 92
    iput v4, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->retryNum:I

    .line 103
    new-instance v2, Landroid/os/RegistrantList;

    invoke-direct {v2}, Landroid/os/RegistrantList;-><init>()V

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEcmTimerResetRegistrants:Landroid/os/RegistrantList;

    .line 112
    new-instance v2, Lcom/android/internal/telephony/gsm/GSMPhoneEx$1;

    invoke-direct {v2, p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx$1;-><init>(Lcom/android/internal/telephony/gsm/GSMPhoneEx;)V

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mExitEcmRunnable:Ljava/lang/Runnable;

    .line 373
    new-instance v2, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;

    invoke-direct {v2, p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;-><init>(Lcom/android/internal/telephony/gsm/GSMPhoneEx;)V

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    .line 184
    const-string v2, "vzw_gfit"

    invoke-static {p1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 185
    new-instance v2, Lcom/android/internal/telephony/gfit/GfitUtils;

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mSST:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    invoke-direct {v2, v3, p0}, Lcom/android/internal/telephony/gfit/GfitUtils;-><init>(Lcom/android/internal/telephony/ServiceStateTracker;Lcom/android/internal/telephony/PhoneBaseEx;)V

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->gfUtils:Lcom/android/internal/telephony/gfit/GfitUtils;

    .line 190
    :cond_0
    const-string v2, "support_emergency_callback_mode_for_gsm"

    invoke-static {p1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 191
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v3, 0x19

    invoke-interface {v2, p0, v3, v6}, Lcom/android/internal/telephony/CommandsInterface;->setEmergencyCallbackMode(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 192
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v2, p0, v5, v6}, Lcom/android/internal/telephony/CommandsInterface;->registerForExitEmergencyCallbackMode(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 195
    :cond_1
    const-string v2, "power"

    invoke-virtual {p1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/os/PowerManager;

    .line 197
    .local v1, "pm":Landroid/os/PowerManager;
    const/4 v2, 0x1

    const-string v3, "GSMPhoneEx"

    invoke-virtual {v1, v2, v3}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v2

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    .line 199
    const-string v2, "ril.cdma.inecmmode"

    const-string v3, "false"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 200
    .local v0, "inEcm":Ljava/lang/String;
    const-string v2, "true"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    iput-boolean v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    .line 202
    iget-boolean v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    if-eqz v2, :cond_2

    .line 203
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->initForSupportedEcmOnGsm(Landroid/content/Context;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 205
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->exitEmergencyCallbackMode(Landroid/os/Message;)V

    .line 211
    :cond_2
    iput-boolean v4, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmExitDelayState:Z

    .line 215
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->processRegistering(Landroid/content/Context;)V

    .line 217
    return-void
.end method

.method static synthetic access$000()Z
    .locals 1

    .prologue
    .line 76
    sget-boolean v0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smIsCheckedLTEReady:Z

    return v0
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/gsm/GSMPhoneEx;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/gsm/GSMPhoneEx;

    .prologue
    .line 76
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/gsm/GSMPhoneEx;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/gsm/GSMPhoneEx;

    .prologue
    .line 76
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method private getPreferredNetworkMode()I
    .locals 4

    .prologue
    .line 683
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "preferred_network_mode"

    sget v3, Lcom/android/internal/telephony/Phone;->PREFERRED_NT_MODE:I

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 685
    .local v0, "nwMode":I
    return v0
.end method

.method private handleEnterEmergencyCallbackMode(Landroid/os/Message;)V
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 744
    const-string v2, "GSMPhoneEx"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleEnterEmergencyCallbackMode,mIsPhoneInEcmState= "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-boolean v4, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 747
    iget-boolean v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    if-nez v2, :cond_0

    .line 748
    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    .line 750
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->sendEmergencyCallbackModeChange()V

    .line 751
    const-string v2, "ril.cdma.inecmmode"

    const-string v3, "true"

    invoke-virtual {p0, v2, v3}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->setSystemProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 755
    const-string v2, "ro.cdma.ecmexittimer"

    const-wide/32 v4, 0x493e0

    invoke-static {v2, v4, v5}, Landroid/os/SystemProperties;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 757
    .local v0, "delayInMillis":J
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mExitEcmRunnable:Ljava/lang/Runnable;

    invoke-virtual {p0, v2, v0, v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 759
    invoke-static {v0, v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->setCurrentTimeForEcm(J)V

    .line 762
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v2}, Landroid/os/PowerManager$WakeLock;->acquire()V

    .line 764
    .end local v0    # "delayInMillis":J
    :cond_0
    return-void
.end method

.method private handleExitEmergencyCallbackMode(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 776
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 777
    .local v0, "ar":Landroid/os/AsyncResult;
    const-string v1, "GSMPhoneEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleExitEmergencyCallbackMode,ar.exception , mIsPhoneInEcmState "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-boolean v3, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 780
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mExitEcmRunnable:Ljava/lang/Runnable;

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 782
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEcmExitRespRegistrant:Landroid/os/Registrant;

    if-eqz v1, :cond_0

    .line 783
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEcmExitRespRegistrant:Landroid/os/Registrant;

    invoke-virtual {v1, v0}, Landroid/os/Registrant;->notifyRegistrant(Landroid/os/AsyncResult;)V

    .line 786
    :cond_0
    iget-object v1, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v1, :cond_3

    .line 787
    iget-boolean v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    if-eqz v1, :cond_1

    .line 788
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    .line 789
    const-string v1, "ril.cdma.inecmmode"

    const-string v2, "false"

    invoke-virtual {p0, v1, v2}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->setSystemProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 793
    :cond_1
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->handleExitEmergencyCallbackModeEx()V

    .line 797
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v1}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 798
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v1}, Landroid/os/PowerManager$WakeLock;->release()V

    .line 803
    :cond_2
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->sendEmergencyCallbackModeChange()V

    .line 805
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setInternalDataEnabled(Z)Z

    .line 807
    :cond_3
    return-void
.end method

.method private isCbEnable(I)Z
    .locals 1
    .param p1, "action"    # I

    .prologue
    const/4 v0, 0x1

    .line 879
    if-ne p1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isIndiaGWLMode()Z
    .locals 8

    .prologue
    const/4 v5, 0x0

    .line 665
    sget-object v6, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v6}, Lcom/android/internal/telephony/Phone;->getSubscriberId()Ljava/lang/String;

    move-result-object v4

    .line 666
    .local v4, "simImsi":Ljava/lang/String;
    if-eqz v4, :cond_0

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v6

    const/4 v7, 0x5

    if-ge v6, v7, :cond_1

    .line 676
    :cond_0
    :goto_0
    return v5

    .line 670
    :cond_1
    sget-object v0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIndiaGWLArray:[Ljava/lang/String;

    .local v0, "arr$":[Ljava/lang/String;
    array-length v2, v0

    .local v2, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_1
    if-ge v1, v2, :cond_0

    aget-object v3, v0, v1

    .line 671
    .local v3, "mccmnc":Ljava/lang/String;
    invoke-virtual {v4, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 672
    const/4 v5, 0x1

    goto :goto_0

    .line 670
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1
.end method

.method public static isIndiaSim()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 651
    sget-object v2, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v2}, Lcom/android/internal/telephony/Phone;->getSubscriberId()Ljava/lang/String;

    move-result-object v0

    .line 653
    .local v0, "simImsi":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x5

    if-ge v2, v3, :cond_1

    .line 661
    :cond_0
    :goto_0
    return v1

    .line 657
    :cond_1
    const-string v2, "404"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "405"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 658
    :cond_2
    const/4 v1, 0x1

    goto :goto_0
.end method

.method private isLteEnabledByMccMnc(Ljava/lang/String;)Z
    .locals 6
    .param p1, "simMccMnc"    # Ljava/lang/String;

    .prologue
    .line 496
    const-string v5, "ro.lge.enable_ltemode_mccmnc"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 497
    .local v4, "mccMncLteConfig":Ljava/lang/String;
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_1

    .line 498
    const-string v5, ","

    invoke-virtual {v4, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .local v0, "arr$":[Ljava/lang/String;
    array-length v2, v0

    .local v2, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_0
    if-ge v1, v2, :cond_1

    aget-object v3, v0, v1

    .line 499
    .local v3, "mccMnc":Ljava/lang/String;
    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 500
    const/4 v5, 0x1

    .line 504
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "i$":I
    .end local v2    # "len$":I
    .end local v3    # "mccMnc":Ljava/lang/String;
    :goto_1
    return v5

    .line 498
    .restart local v0    # "arr$":[Ljava/lang/String;
    .restart local v1    # "i$":I
    .restart local v2    # "len$":I
    .restart local v3    # "mccMnc":Ljava/lang/String;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 504
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "i$":I
    .end local v2    # "len$":I
    .end local v3    # "mccMnc":Ljava/lang/String;
    :cond_1
    const/4 v5, 0x0

    goto :goto_1
.end method

.method public static isLteNetwork()Z
    .locals 1

    .prologue
    .line 424
    sget-boolean v0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->sIsLte:Z

    return v0
.end method

.method public static isLteSim(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 29
    .param p0, "simMccMnc"    # Ljava/lang/String;
    .param p1, "simSpn"    # Ljava/lang/String;
    .param p2, "simGid"    # Ljava/lang/String;
    .param p3, "simImsi"    # Ljava/lang/String;
    .param p4, "simMcc"    # Ljava/lang/String;
    .param p5, "simMnc"    # Ljava/lang/String;

    .prologue
    .line 522
    const/4 v2, 0x4

    new-array v0, v2, [Ljava/lang/String;

    move-object/from16 v27, v0

    const/4 v2, 0x0

    aput-object p0, v27, v2

    const/4 v2, 0x1

    aput-object p3, v27, v2

    const/4 v2, 0x2

    aput-object p1, v27, v2

    const/4 v2, 0x3

    aput-object p2, v27, v2

    .line 524
    .local v27, "simInfo":[Ljava/lang/String;
    const-string v2, "ro.build.target_operator"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "GLOBAL"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "ro.build.target_region"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "EU"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 525
    :cond_0
    const/4 v2, 0x1

    .line 634
    :goto_0
    return v2

    .line 533
    :cond_1
    invoke-static {}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->isIndiaSim()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 534
    invoke-static {}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->isIndiaGWLMode()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 535
    const/4 v2, 0x1

    goto :goto_0

    .line 537
    :cond_2
    const/4 v2, 0x0

    goto :goto_0

    .line 542
    :cond_3
    sget-boolean v2, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smIsCheckedLTEReady:Z

    if-eqz v2, :cond_4

    .line 543
    const-string v2, "LteReadySetting"

    const-string v3, "[GSMPhoneEx] isLteSim() has already done. Just return sIsLte."

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 544
    sget-boolean v2, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->sIsLte:Z

    goto :goto_0

    .line 547
    :cond_4
    sget-object v2, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v2}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    .line 548
    .local v1, "contentResolver":Landroid/content/ContentResolver;
    const-string v2, "content://com.lge.lteconfig.LteReadyProvider"

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    const/4 v3, 0x0

    const-string v4, "mccmnc=?"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/String;

    const/4 v6, 0x0

    aput-object p0, v5, v6

    const/4 v6, 0x0

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v7

    .line 550
    .local v7, "cursor":Landroid/database/Cursor;
    if-eqz v7, :cond_13

    .line 551
    const-string v2, "_id"

    invoke-interface {v7, v2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v18

    .line 552
    .local v18, "id_index":I
    const-string v2, "mccmnc"

    invoke-interface {v7, v2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v25

    .line 553
    .local v25, "mccmnc_index":I
    const-string v2, "imsi_str"

    invoke-interface {v7, v2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v19

    .line 554
    .local v19, "imsi_index":I
    const-string v2, "spn_str"

    invoke-interface {v7, v2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v28

    .line 555
    .local v28, "spn_index":I
    const-string v2, "gid_str"

    invoke-interface {v7, v2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v15

    .line 556
    .local v15, "gid_index":I
    const-string v2, "lte_value"

    invoke-interface {v7, v2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v23

    .line 557
    .local v23, "lte_index":I
    const/16 v24, 0x0

    .line 558
    .local v24, "maxCnt":I
    const/16 v22, -0x1

    .line 560
    .local v22, "lteVal":I
    :cond_5
    :goto_1
    invoke-interface {v7}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_11

    .line 561
    move/from16 v0, v18

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v17

    .line 562
    .local v17, "id":I
    move/from16 v0, v25

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v12

    .line 563
    .local v12, "dbMccmnc":Ljava/lang/String;
    move/from16 v0, v19

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v9

    .line 564
    .local v9, "dbImsi":Ljava/lang/String;
    move/from16 v0, v28

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v13

    .line 565
    .local v13, "dbSpn":Ljava/lang/String;
    invoke-interface {v7, v15}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v8

    .line 566
    .local v8, "dbGid":Ljava/lang/String;
    move/from16 v0, v23

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v11

    .line 567
    .local v11, "dbLte":I
    const-string v2, "%d, MCCMNC : %s, ISMI : %s , SPN : %s , GID : %s , LTE : %d"

    const/4 v3, 0x6

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static/range {v17 .. v17}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    aput-object v12, v3, v4

    const/4 v4, 0x2

    aput-object v9, v3, v4

    const/4 v4, 0x3

    aput-object v13, v3, v4

    const/4 v4, 0x4

    aput-object v8, v3, v4

    const/4 v4, 0x5

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v26

    .line 569
    .local v26, "record":Ljava/lang/String;
    const-string v2, "LteReadySetting"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[FRW] Record : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, v26

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 571
    const/4 v14, 0x0

    .line 572
    .local v14, "equalColCnt":I
    const/16 v20, 0x0

    .line 574
    .local v20, "isWrong":Z
    const/4 v2, 0x4

    new-array v10, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object v12, v10, v2

    const/4 v2, 0x1

    aput-object v9, v10, v2

    const/4 v2, 0x2

    aput-object v13, v10, v2

    const/4 v2, 0x3

    aput-object v8, v10, v2

    .line 576
    .local v10, "dbInfo":[Ljava/lang/String;
    const-string v2, "LteReadySetting"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[simInfo] simMccMnc : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " simImsi : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " simSpn : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p1

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " simGid : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p2

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 577
    const-string v2, "LteReadySetting"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[dbInfo] dbMccmnc : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " dbImsi : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " dbSpn : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " dbGid : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 579
    const/16 v16, 0x0

    .local v16, "i":I
    :goto_2
    array-length v2, v10

    move/from16 v0, v16

    if-ge v0, v2, :cond_10

    .line 581
    aget-object v2, v10, v16

    if-eqz v2, :cond_6

    aget-object v2, v10, v16

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 582
    :cond_6
    const-string v2, "LteReadySetting"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "dbInfo["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, v16

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "] is null"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 579
    :cond_7
    :goto_3
    add-int/lit8 v16, v16, 0x1

    goto :goto_2

    .line 584
    :cond_8
    aget-object v2, v27, v16

    if-eqz v2, :cond_9

    aget-object v2, v27, v16

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_a

    .line 585
    :cond_9
    const-string v2, "LteReadySetting"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "simInfo["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, v16

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "] is null"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 587
    aget-object v2, v10, v16

    if-eqz v2, :cond_7

    aget-object v2, v10, v16

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_7

    .line 588
    const/16 v20, 0x1

    goto :goto_3

    .line 595
    :cond_a
    aget-object v2, v27, v16

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    aget-object v3, v10, v16

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v2, v3, :cond_b

    .line 596
    const/16 v20, 0x1

    goto :goto_3

    .line 597
    :cond_b
    aget-object v2, v10, v16

    aget-object v3, v27, v16

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_f

    .line 598
    const/16 v21, 0x0

    .local v21, "j":I
    :goto_4
    aget-object v2, v10, v16

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    move/from16 v0, v21

    if-ge v0, v2, :cond_e

    .line 599
    aget-object v2, v10, v16

    move/from16 v0, v21

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x5f

    if-ne v2, v3, :cond_d

    .line 598
    :cond_c
    add-int/lit8 v21, v21, 0x1

    goto :goto_4

    .line 603
    :cond_d
    aget-object v2, v10, v16

    move/from16 v0, v21

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    aget-object v3, v27, v16

    move/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    if-eq v2, v3, :cond_c

    .line 604
    const/16 v20, 0x1

    .line 609
    :cond_e
    if-nez v20, :cond_7

    .line 610
    add-int/lit8 v14, v14, 0x1

    goto/16 :goto_3

    .line 613
    .end local v21    # "j":I
    :cond_f
    add-int/lit8 v14, v14, 0x1

    goto/16 :goto_3

    .line 617
    :cond_10
    const-string v2, "LteReadySetting"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[FRW] id : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, v17

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ,isWrong : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, v20

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ,equalColCnt : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 619
    if-nez v20, :cond_5

    .line 620
    const-string v2, "LteReadySetting"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[FRW] Candidate Record : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, v26

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 622
    move/from16 v0, v24

    if-lt v14, v0, :cond_5

    .line 623
    move/from16 v24, v14

    .line 624
    move/from16 v22, v11

    goto/16 :goto_1

    .line 629
    .end local v8    # "dbGid":Ljava/lang/String;
    .end local v9    # "dbImsi":Ljava/lang/String;
    .end local v10    # "dbInfo":[Ljava/lang/String;
    .end local v11    # "dbLte":I
    .end local v12    # "dbMccmnc":Ljava/lang/String;
    .end local v13    # "dbSpn":Ljava/lang/String;
    .end local v14    # "equalColCnt":I
    .end local v16    # "i":I
    .end local v17    # "id":I
    .end local v20    # "isWrong":Z
    .end local v26    # "record":Ljava/lang/String;
    :cond_11
    const-string v2, "LteReadySetting"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[FRW] return lteVal : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move/from16 v0, v22

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ,if 1-> LTE, if 0-> LTE Ready."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 631
    const/4 v2, 0x1

    move/from16 v0, v22

    if-ne v0, v2, :cond_12

    const/4 v2, 0x1

    goto/16 :goto_0

    :cond_12
    const/4 v2, 0x0

    goto/16 :goto_0

    .line 634
    .end local v15    # "gid_index":I
    .end local v18    # "id_index":I
    .end local v19    # "imsi_index":I
    .end local v22    # "lteVal":I
    .end local v23    # "lte_index":I
    .end local v24    # "maxCnt":I
    .end local v25    # "mccmnc_index":I
    .end local v28    # "spn_index":I
    :cond_13
    const/4 v2, 0x0

    goto/16 :goto_0
.end method

.method private processRegistering(Landroid/content/Context;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v3, 0x0

    .line 223
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "android.intent.action.SIM_STATE_CHANGED"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0, v1, v3, v3}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;

    .line 226
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->isMultiSimEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 227
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "android.intent.action.ACTION_DEFAULT_SUBSCRIPTION_CHANGED"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0, v1, v3, v3}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;

    .line 230
    :cond_0
    const/4 v0, 0x1

    invoke-static {p1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->init(Landroid/content/Context;I)V

    .line 232
    return-void
.end method

.method private setPreferredNetworkMode(I)V
    .locals 2
    .param p1, "nwMode"    # I

    .prologue
    .line 689
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "preferred_network_mode"

    invoke-static {v0, v1, p1}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 690
    return-void
.end method


# virtual methods
.method public cancelManualSearchingRequest()V
    .locals 3

    .prologue
    .line 1139
    const/16 v1, 0x40f

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .line 1141
    .local v0, "msg":Landroid/os/Message;
    const-string v1, "GSMPhone"

    const-string v2, "cancelManualSearchingRequest()"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1143
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1, v0}, Lcom/android/internal/telephony/CommandsInterface;->cancelManualSearchingRequest(Landroid/os/Message;)V

    .line 1144
    return-void
.end method

.method public changePlmnNameForESAME(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "Sim_Numeric"    # Ljava/lang/String;
    .param p3, "Subscriber_id"    # Ljava/lang/String;
    .param p4, "roaming"    # Z

    .prologue
    const/4 v5, 0x0

    .line 1271
    const/4 v0, 0x0

    .line 1272
    .local v0, "mcc":Ljava/lang/String;
    const/4 v1, 0x0

    .line 1274
    .local v1, "mcc_sim":I
    const-string v2, "GSMPhoneEx"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[changePlmnName] Sim_Numeric: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " Subscriber_id: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " PLMN name: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1276
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x4

    if-le v2, v3, :cond_0

    .line 1277
    const/4 v2, 0x3

    invoke-virtual {p2, v5, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 1278
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 1281
    :cond_0
    if-eqz p1, :cond_2

    const-string v2, "H pannon"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1282
    const-string p1, "Telenor HU"

    .line 1311
    .end local p1    # "name":Ljava/lang/String;
    :cond_1
    :goto_0
    return-object p1

    .line 1284
    .restart local p1    # "name":Ljava/lang/String;
    :cond_2
    const-string v2, "GSMPhoneEx"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[changePlmnName] mcc_sim: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1286
    if-lez v1, :cond_1

    if-eqz p1, :cond_1

    if-eqz p3, :cond_1

    .line 1289
    sparse-switch v1, :sswitch_data_0

    goto :goto_0

    .line 1293
    :sswitch_0
    const-string v2, "Airtel"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    const-string v2, "IND airtel"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 1294
    :cond_3
    const-string p1, "airtel"

    goto :goto_0

    .line 1296
    :cond_4
    const-string v2, "Vodafone"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1297
    const-string p1, "Vodafone IN"

    goto :goto_0

    .line 1301
    :sswitch_1
    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x6

    if-le v2, v3, :cond_1

    if-nez p4, :cond_1

    const-string v2, "Cell C"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1302
    const-string v2, "6550713"

    const/4 v3, 0x7

    invoke-virtual {p3, v5, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1303
    const-string p1, "Red Bull"

    goto :goto_0

    .line 1289
    nop

    :sswitch_data_0
    .sparse-switch
        0x194 -> :sswitch_0
        0x195 -> :sswitch_0
        0x28f -> :sswitch_1
    .end sparse-switch
.end method

.method public changePlmnNameForSwedish(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p1, "opLong"    # Ljava/lang/String;
    .param p2, "opShort"    # Ljava/lang/String;
    .param p3, "opNumeric"    # Ljava/lang/String;

    .prologue
    const/4 v8, 0x5

    const/4 v7, 0x6

    const/4 v6, 0x0

    .line 1172
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getMSIN()Ljava/lang/String;

    move-result-object v2

    .line 1173
    .local v2, "sim_imsi":Ljava/lang/String;
    move-object v0, p1

    .line 1175
    .local v0, "newOpLong":Ljava/lang/String;
    if-nez v2, :cond_0

    .line 1176
    const-string v3, "GSMPhoneEx"

    const-string v4, "changePlmnNameForSwedish: sim_imsi = null"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v1, v0

    .line 1263
    .end local v0    # "newOpLong":Ljava/lang/String;
    .local v1, "newOpLong":Ljava/lang/String;
    :goto_0
    return-object v1

    .line 1180
    .end local v1    # "newOpLong":Ljava/lang/String;
    .restart local v0    # "newOpLong":Ljava/lang/String;
    :cond_0
    const-string v3, " "

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_f

    .line 1181
    const-string v3, "GSMPhoneEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "changePlmnNameForSwedish: sim_imsi = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1183
    invoke-virtual {v2, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "24008"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 1184
    const-string v3, "24008"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 1185
    const-string v0, "Telenor SE"

    .line 1187
    :cond_1
    const-string v3, "24004"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 1188
    const-string v0, "SWEDEN"

    .line 1190
    :cond_2
    const-string v3, "24024"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 1191
    const-string v0, "Sweden Mobile"

    .line 1195
    :cond_3
    invoke-virtual {v2, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "24002"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 1196
    const-string v3, "24002"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 1197
    const-string v0, "3SE"

    .line 1199
    :cond_4
    const-string v3, "24004"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 1200
    const-string v0, "3SE"

    .line 1204
    :cond_5
    invoke-virtual {v2, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "24007"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_9

    .line 1205
    const-string v3, "GSMPhoneEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "changePlmnNameForSwedish: Tele2 Sweden IMSI = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1206
    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "240070"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "240071"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "240072"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "240073"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "240074"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "240075"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "240076"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_10

    .line 1213
    :cond_6
    const-string v3, "24007"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_7

    .line 1214
    const-string v0, "Tele2 SE"

    .line 1216
    :cond_7
    const-string v3, "24005"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_8

    .line 1217
    const-string v0, "Tele2 SE"

    .line 1219
    :cond_8
    const-string v3, "24024"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_9

    .line 1220
    const-string v0, "Tele2 SE"

    .line 1237
    :cond_9
    :goto_1
    invoke-virtual {v2, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "24001"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_b

    .line 1238
    const-string v3, "24001"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_a

    .line 1239
    const-string v0, "Telia SE"

    .line 1241
    :cond_a
    const-string v3, "24005"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_b

    .line 1242
    const-string v0, "Sweden 3G"

    .line 1245
    :cond_b
    const-string v3, " "

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_e

    .line 1246
    const-string v3, "24007"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_c

    .line 1247
    const-string v0, "Tele2 SE"

    .line 1249
    :cond_c
    const-string v3, "24005"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_d

    .line 1250
    const-string v0, "Sweden 3G"

    .line 1252
    :cond_d
    const-string v3, "24024"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_e

    .line 1253
    const-string v0, "Sweden Mobile"

    .line 1256
    :cond_e
    const-string v3, " "

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_f

    .line 1257
    move-object v0, p2

    .line 1261
    :cond_f
    const-string v3, "GSMPhoneEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "changePlmnNameForSwedish: newOpLong = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v1, v0

    .line 1263
    .end local v0    # "newOpLong":Ljava/lang/String;
    .restart local v1    # "newOpLong":Ljava/lang/String;
    goto/16 :goto_0

    .line 1222
    .end local v1    # "newOpLong":Ljava/lang/String;
    .restart local v0    # "newOpLong":Ljava/lang/String;
    :cond_10
    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "240077"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_11

    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "240078"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_11

    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string v4, "240079"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_9

    .line 1225
    :cond_11
    const-string v3, "24007"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_12

    .line 1226
    const-string v0, "Comviq SE"

    .line 1228
    :cond_12
    const-string v3, "24005"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_13

    .line 1229
    const-string v0, "Comviq SE"

    .line 1231
    :cond_13
    const-string v3, "24024"

    invoke-virtual {p3, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_9

    .line 1232
    const-string v0, "Comviq SE"

    goto/16 :goto_1
.end method

.method public checkLteReady()V
    .locals 14

    .prologue
    const/4 v13, 0x0

    const/4 v12, 0x3

    const/4 v9, 0x0

    const/4 v8, 0x1

    .line 428
    iget-object v10, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;

    if-eqz v10, :cond_0

    .line 429
    invoke-static {}, Lcom/android/internal/telephony/PhoneFactory;->getDefaultPhone()Lcom/android/internal/telephony/Phone;

    move-result-object v10

    sput-object v10, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smPhone:Lcom/android/internal/telephony/Phone;

    .line 430
    invoke-direct {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getPreferredNetworkMode()I

    move-result v7

    .line 431
    .local v7, "settingsNetworkMode":I
    iget-object v10, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;

    invoke-virtual {v10}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v10

    const-string v11, "user_selected_network_mode"

    invoke-static {v10, v11, v9}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v10

    if-ne v10, v8, :cond_1

    move v6, v8

    .line 433
    .local v6, "mUserSelectNetworkMode":Z
    :goto_0
    const-string v10, "gsm.sim.operator.numeric"

    invoke-static {v10}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 435
    .local v0, "simMccMnc":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v10

    if-eqz v10, :cond_2

    .line 493
    .end local v0    # "simMccMnc":Ljava/lang/String;
    .end local v6    # "mUserSelectNetworkMode":Z
    .end local v7    # "settingsNetworkMode":I
    :cond_0
    :goto_1
    return-void

    .restart local v7    # "settingsNetworkMode":I
    :cond_1
    move v6, v9

    .line 431
    goto :goto_0

    .line 439
    .restart local v0    # "simMccMnc":Ljava/lang/String;
    .restart local v6    # "mUserSelectNetworkMode":Z
    :cond_2
    const-string v10, "gsm.sim.operator.alpha"

    invoke-static {v10}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 440
    .local v1, "simSpn":Ljava/lang/String;
    new-instance v10, Lcom/lge/uicc/LGUiccCard;

    invoke-direct {v10}, Lcom/lge/uicc/LGUiccCard;-><init>()V

    invoke-virtual {v10}, Lcom/lge/uicc/LGUiccCard;->getGid1()Ljava/lang/String;

    move-result-object v2

    .line 441
    .local v2, "simGid":Ljava/lang/String;
    sget-object v10, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v10}, Lcom/android/internal/telephony/Phone;->getSubscriberId()Ljava/lang/String;

    move-result-object v3

    .line 442
    .local v3, "simImsi":Ljava/lang/String;
    invoke-virtual {v0, v9, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    .line 443
    .local v4, "simMcc":Ljava/lang/String;
    invoke-virtual {v0, v12}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    .line 445
    .local v5, "simMnc":Ljava/lang/String;
    const-string v10, "LteReadySetting"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "[FRW] mcc : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " mnc : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " imsi : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " gid : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " spn : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 458
    invoke-static/range {v0 .. v5}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->isLteSim(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_4

    const-string v10, "450"

    invoke-virtual {v10, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_4

    const-string v10, "454"

    invoke-virtual {v10, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_3

    const-string v10, "ro.build.target_operator"

    invoke-static {v10}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    const-string v11, "H3G"

    invoke-virtual {v10, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_4

    :cond_3
    const-string v10, "001"

    invoke-virtual {v10, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_6

    const-string v10, "01"

    invoke-virtual {v10, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_6

    .line 463
    :cond_4
    sput-boolean v8, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->sIsLte:Z

    .line 464
    const-string v9, "LteReadySetting"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[GSMPhoneEx] Current SIM is lte, mUserSelectNetworkMode : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 466
    if-nez v6, :cond_5

    const/16 v9, 0x9

    if-eq v7, v9, :cond_5

    .line 467
    const/16 v7, 0x9

    .line 468
    invoke-direct {p0, v7}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->setPreferredNetworkMode(I)V

    .line 469
    sget-object v9, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v9, v7, v13}, Lcom/android/internal/telephony/Phone;->setPreferredNetworkType(ILandroid/os/Message;)V

    .line 490
    :cond_5
    :goto_2
    const-string v9, "LteReadySetting"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[GSMPhoneEx] Set Network mode to settingsNetworkMode : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 491
    sput-boolean v8, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smIsCheckedLTEReady:Z

    goto/16 :goto_1

    .line 473
    :cond_6
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->isLteEnabledByMccMnc(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_8

    .line 474
    const-string v9, "LteReadySetting"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[GSMPhoneEx] Current SIM is LTE enabled by mcc mnc, mUserSelectNetworkMode : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 475
    sput-boolean v8, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->sIsLte:Z

    .line 479
    :goto_3
    const-string v9, "LteReadySetting"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[GSMPhoneEx] Current SIM is lte-ready,  before settingsNetworkMode : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 481
    if-nez v6, :cond_5

    .line 482
    if-ltz v7, :cond_7

    const/4 v9, 0x2

    if-le v7, v9, :cond_5

    .line 483
    :cond_7
    const/4 v7, 0x0

    .line 484
    invoke-direct {p0, v7}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->setPreferredNetworkMode(I)V

    .line 485
    sget-object v9, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v9, v7, v13}, Lcom/android/internal/telephony/Phone;->setPreferredNetworkType(ILandroid/os/Message;)V

    goto :goto_2

    .line 477
    :cond_8
    sput-boolean v9, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->sIsLte:Z

    goto :goto_3
.end method

.method public dispose()V
    .locals 2

    .prologue
    .line 248
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GSMPhone;->dispose()V

    .line 251
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "support_emergency_callback_mode_for_gsm"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 252
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForExitEmergencyCallbackMode(Landroid/os/Handler;)V

    .line 253
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mExitEcmRunnable:Ljava/lang/Runnable;

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 259
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 264
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "vzw_gfit"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 265
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->gfUtils:Lcom/android/internal/telephony/gfit/GfitUtils;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->dispose()V

    .line 268
    :cond_1
    return-void
.end method

.method public exitEmergencyCallbackMode()V
    .locals 3

    .prologue
    .line 717
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getState()Lcom/android/internal/telephony/PhoneConstants$State;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-eq v1, v2, :cond_0

    .line 718
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmExitDelayState:Z

    .line 741
    :goto_0
    return-void

    .line 724
    :cond_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "SUPPORT_E911_FOR_VOLTE"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 725
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getIsE911ForVolte()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 727
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.intent.action.ACTION_ECBM_EXIT_FOR_VOLTE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 728
    .local v0, "intent":Landroid/content/Intent;
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 729
    const-string v1, "GSMPhoneEx"

    const-string v2, "exitEmergencyCallbackMode - ACTION_ECBM_EXIT_FOR_VOLTE"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 735
    .end local v0    # "intent":Landroid/content/Intent;
    :cond_1
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v1}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 736
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v1}, Landroid/os/PowerManager$WakeLock;->release()V

    .line 740
    :cond_2
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v2, 0x1a

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-interface {v1, v2}, Lcom/android/internal/telephony/CommandsInterface;->exitEmergencyCallbackMode(Landroid/os/Message;)V

    goto :goto_0
.end method

.method protected finalize()V
    .locals 2

    .prologue
    .line 287
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GSMPhone;->finalize()V

    .line 290
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 291
    const-string v0, "GSMPhoneEx"

    const-string v1, "UNEXPECTED; mWakeLock is held when finalizing."

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 292
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->release()V

    .line 295
    :cond_0
    return-void
.end method

.method public getCallBarringOption(Ljava/lang/String;Landroid/os/Message;)V
    .locals 3
    .param p1, "commandInterfaceCBReason"    # Ljava/lang/String;
    .param p2, "onComplete"    # Landroid/os/Message;

    .prologue
    .line 866
    const-string v0, "Setting the service class to None"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->log(Ljava/lang/String;)V

    .line 867
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-interface {v0, p1, v1, v2, p2}, Lcom/android/internal/telephony/CommandsInterface;->queryFacilityLock(Ljava/lang/String;Ljava/lang/String;ILandroid/os/Message;)V

    .line 868
    return-void
.end method

.method public getCallForwardingIndicator()Z
    .locals 1

    .prologue
    .line 1318
    const-string v0, "SBM"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "YMO"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1319
    :cond_0
    const/4 v0, 0x0

    .line 1321
    :goto_0
    return v0

    :cond_1
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getCallForwardingIndicator()Z

    move-result v0

    goto :goto_0
.end method

.method protected getCustomizedVoiceMailNumber(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "number"    # Ljava/lang/String;

    .prologue
    const/4 v7, 0x0

    .line 976
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->isNetworkRoaming()Z

    move-result v0

    .line 977
    .local v0, "is_roaming":Z
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-static {v5}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 980
    .local v3, "sp":Landroid/content/SharedPreferences;
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getPhoneId()I

    move-result v1

    .line 983
    .local v1, "phoneId":I
    invoke-static {}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getSimInfo()Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;

    move-result-object v2

    .line 985
    .local v2, "simInfo":Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;
    const-string v4, "vm_number_key"

    .line 987
    .local v4, "vmNumberKey":Ljava/lang/String;
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->isMultiSimEnabled()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 988
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 991
    :cond_0
    invoke-virtual {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getMcc()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_2

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getMnc()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_2

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getMcc()Ljava/lang/String;

    move-result-object v5

    const-string v6, "214"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getMcc()Ljava/lang/String;

    move-result-object v5

    const-string v6, "208"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeSimInfo;->getMnc()Ljava/lang/String;

    move-result-object v5

    const-string v6, "20"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 994
    :cond_1
    invoke-interface {v3, v4, v7}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 995
    if-nez v0, :cond_6

    .line 996
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getVMS(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object p1

    .line 1004
    :cond_2
    :goto_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 1008
    const-string v5, "VZW"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_7

    .line 1009
    const-string v5, "*86"

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 1015
    :goto_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 1016
    if-eqz v0, :cond_8

    .line 1017
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getRVMS(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object p1

    .line 1018
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 1019
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getVMS(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object p1

    .line 1030
    :cond_3
    :goto_2
    const-string v5, "support_smart_dialing"

    invoke-static {v7, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 1031
    const-string v5, "ril.card_operator"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "SPR"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 1032
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getLine1Number()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 1038
    :cond_4
    const/16 v5, 0x10

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isLogBlocked(I)Z

    move-result v5

    if-nez v5, :cond_5

    const-string v5, "GSMPhoneEx"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getVoiceMailNumber() - number : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1039
    :cond_5
    return-object p1

    .line 998
    :cond_6
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getRVMS(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    .line 1011
    :cond_7
    invoke-interface {v3, v4, v7}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_1

    .line 1023
    :cond_8
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getVMS(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object p1

    goto :goto_2
.end method

.method public getDeviceId()Ljava/lang/String;
    .locals 3

    .prologue
    .line 1046
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "support_vzw_Los_upgrade"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1047
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getImei()Ljava/lang/String;

    move-result-object v0

    .line 1048
    .local v0, "mDeviceId":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/16 v2, 0xf

    if-ne v1, v2, :cond_0

    .line 1049
    const-string v1, "GSMPhoneEx"

    const-string v2, "getDeviceId(): returns IMEI(14) in CDMA-LTE Phone"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1050
    const/4 v1, 0x0

    const/16 v2, 0xe

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 1054
    .end local v0    # "mDeviceId":Ljava/lang/String;
    :goto_0
    return-object v1

    :cond_0
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getDeviceId()Ljava/lang/String;

    move-result-object v1

    goto :goto_0
.end method

.method public getDeviceSvn()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1061
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1062
    const-string v0, "ro.lge.swversion"

    const-string v1, "0"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1065
    :goto_0
    return-object v0

    :cond_0
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getDeviceSvn()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getEsn()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1071
    const-string v0, "VZW"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "LRA"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1072
    :cond_0
    const-string v0, "GSMPhoneEx"

    const-string v1, "Esn is returned in VZW GSM"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1073
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEsn:Ljava/lang/String;

    .line 1076
    :goto_0
    return-object v0

    :cond_1
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getEsn()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getLine1Number()Ljava/lang/String;
    .locals 3

    .prologue
    .line 1094
    const-string v2, "VZW"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1095
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIccRecords:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/internal/telephony/uicc/IccRecords;

    .line 1096
    .local v1, "r":Lcom/android/internal/telephony/uicc/IccRecords;
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/android/internal/telephony/uicc/IccRecords;->getMsisdnNumber()Ljava/lang/String;

    move-result-object v0

    .line 1098
    .local v0, "mdnNumber":Ljava/lang/String;
    :goto_0
    invoke-static {v0}, Lcom/lge/telephony/LGSpecialNumberUtils;->getValidMdnForVZW(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1103
    .end local v0    # "mdnNumber":Ljava/lang/String;
    .end local v1    # "r":Lcom/android/internal/telephony/uicc/IccRecords;
    :goto_1
    return-object v0

    .line 1096
    .restart local v1    # "r":Lcom/android/internal/telephony/uicc/IccRecords;
    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 1103
    .end local v1    # "r":Lcom/android/internal/telephony/uicc/IccRecords;
    :cond_1
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getLine1Number()Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method public getMSIN()Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 850
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIccRecords:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/internal/telephony/uicc/IccRecords;

    .line 852
    .local v1, "r":Lcom/android/internal/telephony/uicc/IccRecords;
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/android/internal/telephony/uicc/IccRecords;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    .line 855
    :cond_0
    :goto_0
    return-object v2

    .line 854
    :cond_1
    invoke-virtual {v1}, Lcom/android/internal/telephony/uicc/IccRecords;->getIMSI()Ljava/lang/String;

    move-result-object v0

    .line 855
    .local v0, "imsi":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v1}, Lcom/android/internal/telephony/uicc/IccRecords;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    goto :goto_0
.end method

.method public getMeid()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1082
    const-string v0, "VZW"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "LRA"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1083
    :cond_0
    const-string v0, "GSMPhoneEx"

    const-string v1, "Meid is returned in VZW GSM"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1084
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mMeid:Ljava/lang/String;

    .line 1088
    :goto_0
    return-object v0

    .line 1087
    :cond_1
    const-string v0, "GSMPhoneEx"

    const-string v1, "[GSMPhone] getMeid() is a CDMA method"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1088
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getMeid()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getSearchStatus(Landroid/os/Message;)V
    .locals 1
    .param p1, "response"    # Landroid/os/Message;

    .prologue
    .line 1149
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p1}, Lcom/android/internal/telephony/CommandsInterface;->getSearchStatus(Landroid/os/Message;)V

    .line 1150
    return-void
.end method

.method public getStatusId()I
    .locals 1

    .prologue
    .line 958
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mSST:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;->isManualSelectionAvailable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 959
    const/4 v0, 0x0

    .line 961
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method protected handleEnterEmergencyCallbackMode(J)V
    .locals 3
    .param p1, "delayInMillis"    # J

    .prologue
    .line 767
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 768
    const-string v0, "GSMPhoneEx"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleEnterEmergencyCallbackMode, delayInMillis= "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 770
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mExitEcmRunnable:Ljava/lang/Runnable;

    invoke-virtual {p0, v0, p1, p2}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 771
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->acquire()V

    .line 773
    :cond_0
    return-void
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v3, 0x0

    .line 302
    iget-boolean v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsTheCurrentActivePhone:Z

    if-nez v2, :cond_1

    .line 303
    const-string v2, "GSMPhoneEx"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Received message "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p1, Landroid/os/Message;->what:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "] while being destroyed. Ignoring."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 370
    :cond_0
    :goto_0
    return-void

    .line 308
    :cond_1
    iget v2, p1, Landroid/os/Message;->what:I

    sparse-switch v2, :sswitch_data_0

    .line 366
    invoke-super {p0, p1}, Lcom/android/internal/telephony/gsm/GSMPhone;->handleMessage(Landroid/os/Message;)V

    goto :goto_0

    .line 312
    :sswitch_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 314
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v2, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v2, :cond_2

    .line 318
    iget v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->retryNum:I

    const/16 v3, 0xa

    if-gt v2, v3, :cond_0

    .line 319
    const/16 v2, 0x420

    const-wide/16 v4, 0x3e8

    invoke-virtual {p0, v2, v4, v5}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->sendEmptyMessageDelayed(IJ)Z

    goto :goto_0

    .line 324
    :cond_2
    iget-object v2, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, [Ljava/lang/String;

    move-object v1, v2

    check-cast v1, [Ljava/lang/String;

    .line 325
    .local v1, "respId":[Ljava/lang/String;
    aget-object v2, v1, v3

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mImei:Ljava/lang/String;

    .line 326
    const/4 v2, 0x1

    aget-object v2, v1, v2

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mImeiSv:Ljava/lang/String;

    .line 327
    const/4 v2, 0x2

    aget-object v2, v1, v2

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEsn:Ljava/lang/String;

    .line 328
    const/4 v2, 0x3

    aget-object v2, v1, v2

    iput-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mMeid:Ljava/lang/String;

    .line 331
    iput v3, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->retryNum:I

    goto :goto_0

    .line 341
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v1    # "respId":[Ljava/lang/String;
    :sswitch_1
    const-string v2, "GSMPhoneEx"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "EVENT_RETRY_GET_DEVICE_IDENTITY : retryNum = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->retryNum:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 342
    iget v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->retryNum:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->retryNum:I

    .line 343
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v3, 0x15

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->getDeviceIdentity(Landroid/os/Message;)V

    goto :goto_0

    .line 351
    :sswitch_2
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->handleEnterEmergencyCallbackMode(Landroid/os/Message;)V

    goto :goto_0

    .line 355
    :sswitch_3
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->handleExitEmergencyCallbackMode(Landroid/os/Message;)V

    goto :goto_0

    .line 361
    :sswitch_4
    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Landroid/os/AsyncResult;

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->handleSetSelectNetwork(Landroid/os/AsyncResult;)V

    goto :goto_0

    .line 308
    :sswitch_data_0
    .sparse-switch
        0x15 -> :sswitch_0
        0x19 -> :sswitch_2
        0x1a -> :sswitch_3
        0x40e -> :sswitch_4
        0x420 -> :sswitch_1
    .end sparse-switch
.end method

.method handleTimerInEmergencyCallbackMode(I)V
    .locals 6
    .param p1, "action"    # I

    .prologue
    .line 815
    packed-switch p1, :pswitch_data_0

    .line 827
    const-string v2, "GSMPhoneEx"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleTimerInEmergencyCallbackMode, unsupported action "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 829
    :goto_0
    return-void

    .line 817
    :pswitch_0
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mExitEcmRunnable:Ljava/lang/Runnable;

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 818
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEcmTimerResetRegistrants:Landroid/os/RegistrantList;

    sget-object v3, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v2, v3}, Landroid/os/RegistrantList;->notifyResult(Ljava/lang/Object;)V

    goto :goto_0

    .line 821
    :pswitch_1
    const-string v2, "ro.cdma.ecmexittimer"

    const-wide/32 v4, 0x493e0

    invoke-static {v2, v4, v5}, Landroid/os/SystemProperties;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 823
    .local v0, "delayInMillis":J
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mExitEcmRunnable:Ljava/lang/Runnable;

    invoke-virtual {p0, v2, v0, v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 824
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEcmTimerResetRegistrants:Landroid/os/RegistrantList;

    sget-object v3, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {v2, v3}, Landroid/os/RegistrantList;->notifyResult(Ljava/lang/Object;)V

    goto :goto_0

    .line 815
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected initInstance()V
    .locals 1

    .prologue
    .line 243
    new-instance v0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;-><init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCT:Lcom/android/internal/telephony/gsm/GsmCallTracker;

    .line 244
    return-void
.end method

.method protected initSubscriptionSpecifics()V
    .locals 1

    .prologue
    .line 237
    new-instance v0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;-><init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mSST:Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;

    .line 238
    new-instance v0, Lcom/android/internal/telephony/dataconnection/DcTracker;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/dataconnection/DcTracker;-><init>(Lcom/android/internal/telephony/PhoneBase;)V

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    .line 239
    return-void
.end method

.method public isInEcm()Z
    .locals 1

    .prologue
    .line 703
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    return v0
.end method

.method public registerForEcmTimerReset(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 838
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEcmTimerResetRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1, p2, p3}, Landroid/os/RegistrantList;->addUnique(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 839
    return-void
.end method

.method public removeReferences()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 272
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GSMPhone;->removeReferences()V

    .line 275
    iput-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mExitEcmRunnable:Ljava/lang/Runnable;

    .line 279
    const-string v0, "vzw_gfit"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 280
    iput-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->gfUtils:Lcom/android/internal/telephony/gfit/GfitUtils;

    .line 283
    :cond_0
    return-void
.end method

.method public saveClirSetting(I)V
    .locals 7
    .param p1, "commandInterfaceCLIRMode"    # I

    .prologue
    .line 926
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-static {v4}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 927
    .local v3, "sp":Landroid/content/SharedPreferences;
    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 929
    .local v1, "editor":Landroid/content/SharedPreferences$Editor;
    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;

    const-string v5, "set_clir_option_by_call_setting"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 930
    const/4 v4, 0x1

    if-ne p1, v4, :cond_3

    .line 931
    const-string v4, "button_clir_key"

    const-string v5, "HIDE"

    invoke-interface {v1, v4, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 940
    :cond_0
    :goto_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getPhoneId()I

    move-result v2

    .line 942
    .local v2, "phoneId":I
    const-string v0, "clir_key"

    .line 943
    .local v0, "clirKey":Ljava/lang/String;
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v4

    invoke-virtual {v4}, Landroid/telephony/TelephonyManager;->isMultiSimEnabled()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 944
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 947
    :cond_1
    invoke-interface {v1, v0, p1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 950
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    move-result v4

    if-nez v4, :cond_2

    .line 951
    const-string v4, "GSMPhoneEx"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "saveClirSetting - failed to commit CLIR preference, sub : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 954
    :cond_2
    return-void

    .line 932
    .end local v0    # "clirKey":Ljava/lang/String;
    .end local v2    # "phoneId":I
    :cond_3
    const/4 v4, 0x2

    if-ne p1, v4, :cond_4

    .line 933
    const-string v4, "button_clir_key"

    const-string v5, "SHOW"

    invoke-interface {v1, v4, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    .line 935
    :cond_4
    const-string v4, "GSMPhoneEx"

    const-string v5, "AT&T CLIR MMI code : Unexpected response"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method protected saveVoiceMailNumberForSIMFieldException(Landroid/os/AsyncResult;)V
    .locals 2
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    .line 1108
    const-string v0, "TMO"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "EU"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "COM"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1110
    :cond_0
    const-class v0, Ljava/lang/RuntimeException;

    iget-object v1, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v0, v1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1113
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mVmNumber:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->storeVoiceMailNumber(Ljava/lang/String;)V

    .line 1114
    const/4 v0, 0x0

    iput-object v0, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    .line 1118
    :cond_1
    return-void
.end method

.method public selectPreviousNetworkManually(Lcom/android/internal/telephony/OperatorInfo;Landroid/os/Message;)V
    .locals 5
    .param p1, "network"    # Lcom/android/internal/telephony/OperatorInfo;
    .param p2, "response"    # Landroid/os/Message;

    .prologue
    .line 1158
    new-instance v1, Lcom/android/internal/telephony/PhoneBase$NetworkSelectMessage;

    invoke-direct {v1}, Lcom/android/internal/telephony/PhoneBase$NetworkSelectMessage;-><init>()V

    .line 1159
    .local v1, "nsm":Lcom/android/internal/telephony/PhoneBase$NetworkSelectMessage;
    iput-object p2, v1, Lcom/android/internal/telephony/PhoneBase$NetworkSelectMessage;->message:Landroid/os/Message;

    .line 1160
    invoke-virtual {p1}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/android/internal/telephony/PhoneBase$NetworkSelectMessage;->operatorNumeric:Ljava/lang/String;

    .line 1164
    const/16 v2, 0x40e

    invoke-virtual {p0, v2, v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .line 1166
    .local v0, "msg":Landroid/os/Message;
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-virtual {p1}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorRAT()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v2, v3, v4, v0}, Lcom/android/internal/telephony/CommandsInterface;->setPreviousNetworkSelectionModeManual(Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    .line 1167
    return-void
.end method

.method sendEmergencyCallbackModeChange()V
    .locals 3

    .prologue
    .line 708
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.EMERGENCY_CALLBACK_MODE_CHANGED"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 709
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "phoneinECMState"

    iget-boolean v2, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mIsPhoneInEcmState:Z

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 710
    const/4 v1, 0x0

    const/4 v2, -0x1

    invoke-static {v0, v1, v2}, Landroid/app/ActivityManagerNative;->broadcastStickyIntent(Landroid/content/Intent;Ljava/lang/String;I)V

    .line 711
    const-string v1, "GSMPhoneEx"

    const-string v2, "sendEmergencyCallbackModeChange"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 712
    return-void
.end method

.method public setCallBarringOption(ILjava/lang/String;ILjava/lang/String;Landroid/os/Message;)V
    .locals 6
    .param p1, "commandInterfaceCBAction"    # I
    .param p2, "commandInterfaceCBReason"    # Ljava/lang/String;
    .param p3, "serviceClass"    # I
    .param p4, "password"    # Ljava/lang/String;
    .param p5, "onComplete"    # Landroid/os/Message;

    .prologue
    .line 875
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->isCbEnable(I)Z

    move-result v2

    move-object v1, p2

    move-object v3, p4

    move v4, p3

    move-object v5, p5

    invoke-interface/range {v0 .. v5}, Lcom/android/internal/telephony/CommandsInterface;->setFacilityLock(Ljava/lang/String;ZLjava/lang/String;ILandroid/os/Message;)V

    .line 876
    return-void
.end method

.method public setCallBarringPass(Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)V
    .locals 2
    .param p1, "oldPwd"    # Ljava/lang/String;
    .param p2, "newPwd"    # Ljava/lang/String;
    .param p3, "onComplete"    # Landroid/os/Message;

    .prologue
    .line 883
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const-string v1, "AB"

    invoke-interface {v0, v1, p1, p2, p3}, Lcom/android/internal/telephony/CommandsInterface;->changeBarringPassword(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    .line 884
    return-void
.end method

.method public setOnEcbModeExitResponse(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 695
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEcmExitRespRegistrant:Landroid/os/Registrant;

    .line 696
    return-void
.end method

.method protected syncClirSetting()V
    .locals 7

    .prologue
    const/4 v5, -0x1

    .line 894
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-static {v4}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 897
    .local v3, "sp":Landroid/content/SharedPreferences;
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->getPhoneId()I

    move-result v2

    .line 899
    .local v2, "phoneId":I
    const-string v0, "clir_key"

    .line 900
    .local v0, "clirKey":Ljava/lang/String;
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v4

    invoke-virtual {v4}, Landroid/telephony/TelephonyManager;->isMultiSimEnabled()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 901
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 904
    :cond_0
    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;

    invoke-static {v4, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getClirSettingValue(Landroid/content/Context;I)I

    move-result v4

    invoke-interface {v3, v0, v4}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    .line 906
    .local v1, "clirSetting":I
    if-eq v1, v5, :cond_2

    .line 907
    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->saveClirSetting(I)V

    .line 913
    :goto_0
    const-string v4, "GSMPhoneEx"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "syncClirSetting :: clirSetting = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 914
    if-ltz v1, :cond_1

    .line 915
    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v5, 0x0

    invoke-interface {v4, v1, v5}, Lcom/android/internal/telephony/CommandsInterface;->setCLIR(ILandroid/os/Message;)V

    .line 917
    :cond_1
    return-void

    .line 909
    :cond_2
    invoke-interface {v3, v0, v5}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    goto :goto_0
.end method

.method public unregisterForEcmTimerReset(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 842
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEcmTimerResetRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0, p1}, Landroid/os/RegistrantList;->remove(Landroid/os/Handler;)V

    .line 843
    return-void
.end method

.method public unsetOnEcbModeExitResponse(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    .line 699
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mEcmExitRespRegistrant:Landroid/os/Registrant;

    invoke-virtual {v0}, Landroid/os/Registrant;->clear()V

    .line 700
    return-void
.end method

.method protected updateDeviceInfo()V
    .locals 2

    .prologue
    .line 967
    const/4 v0, 0x0

    const-string v1, "SUPPORT_UPDATE_DEVICE_INFO"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 968
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0x15

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/CommandsInterface;->getDeviceIdentity(Landroid/os/Message;)V

    .line 971
    :cond_0
    return-void
.end method
