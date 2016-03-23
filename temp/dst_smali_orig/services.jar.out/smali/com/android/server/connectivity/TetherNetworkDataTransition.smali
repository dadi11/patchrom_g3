.class public Lcom/android/server/connectivity/TetherNetworkDataTransition;
.super Ljava/lang/Object;
.source "TetherNetworkDataTransition.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/connectivity/TetherNetworkDataTransition$1;,
        Lcom/android/server/connectivity/TetherNetworkDataTransition$TetherNetworkDataReceiver;
    }
.end annotation


# static fields
.field private static final CHECK_TIMEOUT:I = 0x2710

.field public static final CMD_GET_MOBILE_HOTSPOT_FLAG:I = 0x6a

.field public static final CMD_GET_USB_TETHERING_FLAG:I = 0x6c

.field public static final CMD_SET_MOBILE_HOTSPOT_FLAG:I = 0x69

.field public static final CMD_SET_USB_TETHERING_FLAG:I = 0x6b

.field private static final DEBUG:Z = true

.field private static final INT_SIZE:I = 0x4

.field private static final LONG_TIMEOUT:J = 0x7530L

.field private static final NETWORK_STATE_CHECK_TIMEOUT:I = 0x7d0

.field public static final QCRILHOOK_CMD_GET:I = 0x91004

.field public static final QCRILHOOK_CMD_SET:I = 0x91005

.field public static final QCRILHOOK_OEM_BASE:I = 0x90000

.field public static final QCRILHOOK_OEM_LGRIL_BASE:I = 0x91000

.field public static final QCRILHOOK_OPRT_MODE:I = 0x91003

.field public static final QCRILHOOK_SVC_READ:I = 0x91001

.field public static final QCRILHOOK_SVC_WRITE:I = 0x91002

.field public static final QCRIL_EVT_HOOK_BASE:I = 0x80000

.field public static final QCRIL_EVT_HOOK_NV_READ:I = 0x80001

.field public static final QCRIL_EVT_OEM_BASE:I = 0x90000

.field public static final QCRIL_EVT_OEM_LGRIL_BASE:I = 0x91000

.field public static final QCRIL_EVT_OEM_LGRIL_CMD_GET:I = 0x91004

.field private static final RESPONSE_BUFFER_SIZE:I = 0x800

.field private static final SHORT_TIMEOUT:I = 0x1388

.field private static final TAG:Ljava/lang/String; = "TetherNetworkDataTransition"

.field private static mTetherNetworkFlagSet:Z

.field private static qcRilHookClassLoader:Ljava/lang/ClassLoader;


# instance fields
.field private connectivityObject:Ljava/lang/Object;

.field private mCm:Landroid/net/ConnectivityManager;

.field private mContext:Landroid/content/Context;

.field private mEscapeWaiting:Z

.field private final mHeaderSize:I

.field private mNetworkInfo:Landroid/net/NetworkInfo;

.field private final mOemIdentifier:Ljava/lang/String;

.field private mTetherNetworkData:Landroid/content/BroadcastReceiver;

.field private mTm:Landroid/telephony/TelephonyManager;

.field private phone:Lcom/android/internal/telephony/ITelephony;

.field private phoneEx:Lcom/lge/internal/telephony/ITelephonyEx;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    const/4 v1, 0x0

    sput-boolean v1, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTetherNetworkFlagSet:Z

    sput-object v4, Lcom/android/server/connectivity/TetherNetworkDataTransition;->qcRilHookClassLoader:Ljava/lang/ClassLoader;

    :try_start_0
    new-instance v1, Ldalvik/system/PathClassLoader;

    const-string v2, "/system/framework/qcrilhook.jar"

    invoke-static {}, Ljava/lang/ClassLoader;->getSystemClassLoader()Ljava/lang/ClassLoader;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Ldalvik/system/PathClassLoader;-><init>(Ljava/lang/String;Ljava/lang/ClassLoader;)V

    sput-object v1, Lcom/android/server/connectivity/TetherNetworkDataTransition;->qcRilHookClassLoader:Ljava/lang/ClassLoader;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    return-void

    .end local v0    # "e":Ljava/lang/Exception;
    :catch_0
    move-exception v0

    .restart local v0    # "e":Ljava/lang/Exception;
    sput-object v4, Lcom/android/server/connectivity/TetherNetworkDataTransition;->qcRilHookClassLoader:Ljava/lang/ClassLoader;

    const-string v1, "TetherNetworkDataTransition"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to init qcRilHookClassLoader class (could be not QCT model), exception= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "ctx"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "QUALCOMM"

    iput-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mOemIdentifier:Ljava/lang/String;

    const-string v0, "QUALCOMM"

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, 0x8

    iput v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mHeaderSize:I

    iput-object v1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    iput-object v1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phoneEx:Lcom/lge/internal/telephony/ITelephonyEx;

    iput-object v1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    iput-object v1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTm:Landroid/telephony/TelephonyManager;

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->connectivityObject:Ljava/lang/Object;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mEscapeWaiting:Z

    iput-object v1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    iput-object p1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mContext:Landroid/content/Context;

    return-void
.end method

.method static synthetic access$100(Lcom/android/server/connectivity/TetherNetworkDataTransition;)Landroid/net/NetworkInfo;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/connectivity/TetherNetworkDataTransition;

    .prologue
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    return-object v0
.end method

.method static synthetic access$102(Lcom/android/server/connectivity/TetherNetworkDataTransition;Landroid/net/NetworkInfo;)Landroid/net/NetworkInfo;
    .locals 0
    .param p0, "x0"    # Lcom/android/server/connectivity/TetherNetworkDataTransition;
    .param p1, "x1"    # Landroid/net/NetworkInfo;

    .prologue
    iput-object p1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    return-object p1
.end method

.method static synthetic access$200(Lcom/android/server/connectivity/TetherNetworkDataTransition;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/server/connectivity/TetherNetworkDataTransition;

    .prologue
    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->notifyNetworkConnectivityChange()V

    return-void
.end method

.method static synthetic access$300()Z
    .locals 1

    .prologue
    sget-boolean v0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTetherNetworkFlagSet:Z

    return v0
.end method

.method static synthetic access$402(Lcom/android/server/connectivity/TetherNetworkDataTransition;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/server/connectivity/TetherNetworkDataTransition;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mEscapeWaiting:Z

    return p1
.end method

.method private addLgGpsRilHookHeader(Ljava/nio/ByteBuffer;II)V
    .locals 1
    .param p1, "buf"    # Ljava/nio/ByteBuffer;
    .param p2, "requestId"    # I
    .param p3, "requestSize"    # I

    .prologue
    const-string v0, "QUALCOMM"

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {p1, p2}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-virtual {p1, p3}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    return-void
.end method

.method private checkMobileConnection(Landroid/net/NetworkInfo$State;)Z
    .locals 8
    .param p1, "expectedState"    # Landroid/net/NetworkInfo$State;

    .prologue
    const/4 v3, 0x1

    const/4 v4, 0x0

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getConnectivityManager()Landroid/net/ConnectivityManager;

    move-result-object v5

    iput-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    const-string v5, "TetherNetworkDataTransition"

    const-string v6, "[DEBUG][NSH]checkMobileConnection"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    iget-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    if-eqz v5, :cond_2

    iget-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    const/4 v6, 0x0

    invoke-virtual {v5, v6}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v2

    .local v2, "netInfoMobile":Landroid/net/NetworkInfo;
    iget-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    const/4 v6, 0x5

    invoke-virtual {v5, v6}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v1

    .local v1, "netInfoHipri":Landroid/net/NetworkInfo;
    sget-object v5, Landroid/net/NetworkInfo$State;->DISCONNECTED:Landroid/net/NetworkInfo$State;

    invoke-virtual {p1, v5}, Landroid/net/NetworkInfo$State;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    const-string v5, "TetherNetworkDataTransition"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "NetworkInfo for TYPE_MOBILE getState= "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ",  TYPE_MOBILE_HIPRI getState =  "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v5

    if-ne v5, p1, :cond_2

    const-string v5, "TetherNetworkDataTransition"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "NetworkInfo for TYPE_MOBILE or TYPE_MOBILE_HIPRI "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "netInfoHipri":Landroid/net/NetworkInfo;
    .end local v2    # "netInfoMobile":Landroid/net/NetworkInfo;
    :goto_0
    return v3

    .restart local v1    # "netInfoHipri":Landroid/net/NetworkInfo;
    .restart local v2    # "netInfoMobile":Landroid/net/NetworkInfo;
    :cond_0
    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v5

    if-ne v5, p1, :cond_1

    const-string v5, "TetherNetworkDataTransition"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "NetworkInfo for TYPE_MOBILE"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v1    # "netInfoHipri":Landroid/net/NetworkInfo;
    .end local v2    # "netInfoMobile":Landroid/net/NetworkInfo;
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    move v3, v4

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "netInfoHipri":Landroid/net/NetworkInfo;
    .restart local v2    # "netInfoMobile":Landroid/net/NetworkInfo;
    :cond_1
    :try_start_1
    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v5

    if-ne v5, p1, :cond_2

    const-string v5, "TetherNetworkDataTransition"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "NetworkInfo for TYPE_MOBILE_HIPRI"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v1}, Landroid/net/NetworkInfo;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .end local v1    # "netInfoHipri":Landroid/net/NetworkInfo;
    .end local v2    # "netInfoMobile":Landroid/net/NetworkInfo;
    :cond_2
    move v3, v4

    goto :goto_0
.end method

.method public static createBufferWithNativeByteOrder([B)Ljava/nio/ByteBuffer;
    .locals 2
    .param p0, "bytes"    # [B

    .prologue
    invoke-static {p0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .local v0, "buf":Ljava/nio/ByteBuffer;
    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method private getConnectivityManager()Landroid/net/ConnectivityManager;
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mContext:Landroid/content/Context;

    const-string v1, "connectivity"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    iput-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    :cond_0
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    return-object v0
.end method

.method private getPhone()Lcom/android/internal/telephony/ITelephony;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    if-nez v0, :cond_0

    const-string v0, "phone"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/ITelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephony;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    :cond_0
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    return-object v0
.end method

.method private getPhoneEx()Lcom/lge/internal/telephony/ITelephonyEx;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phoneEx:Lcom/lge/internal/telephony/ITelephonyEx;

    if-nez v0, :cond_0

    const-string v0, "phone"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/internal/telephony/ITelephonyEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phoneEx:Lcom/lge/internal/telephony/ITelephonyEx;

    :cond_0
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phoneEx:Lcom/lge/internal/telephony/ITelephonyEx;

    return-object v0
.end method

.method private getTelephonyManager()Landroid/telephony/TelephonyManager;
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTm:Landroid/telephony/TelephonyManager;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mContext:Landroid/content/Context;

    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    iput-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTm:Landroid/telephony/TelephonyManager;

    :cond_0
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTm:Landroid/telephony/TelephonyManager;

    return-object v0
.end method

.method private notifyNetworkConnectivityChange()V
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->connectivityObject:Ljava/lang/Object;

    monitor-enter v1

    :try_start_0
    const-string v0, "TetherNetworkDataTransition"

    const-string v2, "notify network connectivity changed"

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->connectivityObject:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private registerConnectivityReceiver()V
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTetherNetworkData:Landroid/content/BroadcastReceiver;

    if-eqz v1, :cond_0

    :goto_0
    return-void

    :cond_0
    new-instance v1, Lcom/android/server/connectivity/TetherNetworkDataTransition$TetherNetworkDataReceiver;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/android/server/connectivity/TetherNetworkDataTransition$TetherNetworkDataReceiver;-><init>(Lcom/android/server/connectivity/TetherNetworkDataTransition;Lcom/android/server/connectivity/TetherNetworkDataTransition$1;)V

    iput-object v1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTetherNetworkData:Landroid/content/BroadcastReceiver;

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "android.net.conn.CONNECTIVITY_CHANGE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.ANY_DATA_STATE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTetherNetworkData:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    goto :goto_0
.end method

.method private sendRilOemHookMsg(I[B)Landroid/os/AsyncResult;
    .locals 13
    .param p1, "requestId"    # I
    .param p2, "request"    # [B

    .prologue
    const-string v2, "com.qualcomm.qcrilhook.QcRilHook"

    .local v2, "QCRILHOOK_CLASS":Ljava/lang/String;
    const/4 v3, 0x0

    .local v3, "ar":Landroid/os/AsyncResult;
    sget-object v9, Lcom/android/server/connectivity/TetherNetworkDataTransition;->qcRilHookClassLoader:Ljava/lang/ClassLoader;

    if-eqz v9, :cond_0

    :try_start_0
    sget-object v9, Lcom/android/server/connectivity/TetherNetworkDataTransition;->qcRilHookClassLoader:Ljava/lang/ClassLoader;

    const-string v10, "com.qualcomm.qcrilhook.QcRilHook"

    invoke-virtual {v9, v10}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v5

    .local v5, "cl":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const/4 v9, 0x1

    new-array v9, v9, [Ljava/lang/Class;

    const/4 v10, 0x0

    const-class v11, Landroid/content/Context;

    aput-object v11, v9, v10

    invoke-virtual {v5, v9}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v4

    .local v4, "c":Ljava/lang/reflect/Constructor;
    const/4 v9, 0x1

    new-array v9, v9, [Ljava/lang/Object;

    const/4 v10, 0x0

    iget-object v11, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mContext:Landroid/content/Context;

    aput-object v11, v9, v10

    invoke-virtual {v4, v9}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v8

    .local v8, "qcrilObj":Ljava/lang/Object;
    const-wide/16 v10, 0x1f4

    :try_start_1
    invoke-static {v10, v11}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    :goto_0
    :try_start_2
    const-string v9, "sendQcRilHookMsg"

    const/4 v10, 0x2

    new-array v10, v10, [Ljava/lang/Class;

    const/4 v11, 0x0

    sget-object v12, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v12, v10, v11

    const/4 v11, 0x1

    const-class v12, [B

    aput-object v12, v10, v11

    invoke-virtual {v5, v9, v10}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    .local v7, "mSendMsg":Ljava/lang/reflect/Method;
    const/4 v9, 0x2

    new-array v9, v9, [Ljava/lang/Object;

    const/4 v10, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    aput-object v11, v9, v10

    const/4 v10, 0x1

    aput-object p2, v9, v10

    invoke-virtual {v7, v8, v9}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    move-object v0, v9

    check-cast v0, Landroid/os/AsyncResult;

    move-object v3, v0

    .end local v4    # "c":Ljava/lang/reflect/Constructor;
    .end local v5    # "cl":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v7    # "mSendMsg":Ljava/lang/reflect/Method;
    .end local v8    # "qcrilObj":Ljava/lang/Object;
    :cond_0
    :goto_1
    return-object v3

    .restart local v4    # "c":Ljava/lang/reflect/Constructor;
    .restart local v5    # "cl":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .restart local v8    # "qcrilObj":Ljava/lang/Object;
    :catch_0
    move-exception v6

    .local v6, "e":Ljava/lang/InterruptedException;
    const-string v9, "TetherNetworkDataTransition"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Failed: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .end local v4    # "c":Ljava/lang/reflect/Constructor;
    .end local v5    # "cl":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v6    # "e":Ljava/lang/InterruptedException;
    .end local v8    # "qcrilObj":Ljava/lang/Object;
    :catch_1
    move-exception v6

    .local v6, "e":Ljava/lang/Exception;
    const-string v9, "TetherNetworkDataTransition"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Failed: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method private sendTetherBroadcast(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2
    .param p1, "ctx"    # Landroid/content/Context;
    .param p2, "action"    # Ljava/lang/String;

    .prologue
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0, p2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "broadcast":Landroid/content/Intent;
    const/high16 v1, 0x24000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    return-void
.end method

.method private unregisterConnectivityReceiver()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTetherNetworkData:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTetherNetworkData:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTetherNetworkData:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method private waitForMobileConnection(Landroid/net/NetworkInfo$State;J)Z
    .locals 8
    .param p1, "expectedState"    # Landroid/net/NetworkInfo$State;
    .param p2, "timeout"    # J

    .prologue
    const/4 v1, 0x1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .local v2, "startTime":J
    const/4 v4, 0x0

    iput-boolean v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mEscapeWaiting:Z

    :goto_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    sub-long/2addr v4, v2

    cmp-long v4, v4, p2

    if-lez v4, :cond_0

    invoke-direct {p0, p1}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->checkMobileConnection(Landroid/net/NetworkInfo$State;)Z

    move-result v1

    :goto_1
    return v1

    :cond_0
    iget-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->connectivityObject:Ljava/lang/Object;

    monitor-enter v4

    :try_start_0
    iget-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->connectivityObject:Ljava/lang/Object;

    const-wide/16 v6, 0x7d0

    invoke-virtual {v5, v6, v7}, Ljava/lang/Object;->wait(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_2
    :try_start_1
    iget-boolean v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mEscapeWaiting:Z

    if-ne v5, v1, :cond_1

    const-string v5, "TetherNetworkDataTransition"

    const-string v6, "Escape mobile connection waiting"

    invoke-static {v5, v6}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    monitor-exit v4

    goto :goto_1

    :catchall_0
    move-exception v1

    monitor-exit v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_2
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_2

    .end local v0    # "e":Ljava/lang/InterruptedException;
    :cond_1
    invoke-direct {p0, p1}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->checkMobileConnection(Landroid/net/NetworkInfo$State;)Z

    move-result v5

    if-nez v5, :cond_2

    monitor-exit v4

    goto :goto_0

    :cond_2
    monitor-exit v4
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1
.end method

.method private waitForNetworkState(ILandroid/net/NetworkInfo$State;J)Z
    .locals 11
    .param p1, "networkType"    # I
    .param p2, "expectedState"    # Landroid/net/NetworkInfo$State;
    .param p3, "timeout"    # J

    .prologue
    const/4 v4, 0x1

    const/4 v1, 0x0

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getConnectivityManager()Landroid/net/ConnectivityManager;

    move-result-object v5

    iput-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    iget-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    if-nez v5, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .local v2, "startTime":J
    iget-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    if-eqz v5, :cond_0

    :try_start_0
    iget-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v5, p1}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v5

    iput-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    iget-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    if-eqz v5, :cond_0

    const-string v5, "TetherNetworkDataTransition"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "mNetworkInfo before state : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    invoke-virtual {v7}, Landroid/net/NetworkInfo;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iput-boolean v1, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mEscapeWaiting:Z

    :goto_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    sub-long/2addr v6, v2

    cmp-long v5, v6, p3

    if-lez v5, :cond_2

    :try_start_1
    iget-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v5, p1}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v5

    invoke-virtual {v5}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v5

    if-ne v5, p2, :cond_0

    const-string v5, "TetherNetworkDataTransition"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "networktype: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " state: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v7, p1}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move v1, v4

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .restart local v0    # "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_2
    const-string v5, "TetherNetworkDataTransition"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Wait for the connectivity state for network: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " to be "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {p2}, Landroid/net/NetworkInfo$State;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v5, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->connectivityObject:Ljava/lang/Object;

    monitor-enter v5

    :try_start_2
    iget-object v6, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->connectivityObject:Ljava/lang/Object;

    const-wide/16 v8, 0x7d0

    invoke-virtual {v6, v8, v9}, Ljava/lang/Object;->wait(J)V
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :goto_2
    :try_start_3
    iget-boolean v6, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mEscapeWaiting:Z

    if-ne v6, v4, :cond_3

    const-string v1, "TetherNetworkDataTransition"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Escape!! network state for "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    invoke-virtual {v7}, Landroid/net/NetworkInfo;->getType()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " is: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    invoke-virtual {v7}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v1, v6}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    monitor-exit v5

    move v1, v4

    goto/16 :goto_0

    :catch_2
    move-exception v0

    .local v0, "e":Ljava/lang/InterruptedException;
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    goto :goto_2

    .end local v0    # "e":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v1

    monitor-exit v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v1

    :cond_3
    :try_start_4
    iget-object v6, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v6, p1}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v6

    iput-object v6, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :goto_3
    :try_start_5
    iget-object v6, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    if-eqz v6, :cond_5

    iget-object v6, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    invoke-virtual {v6}, Landroid/net/NetworkInfo;->getType()I

    move-result v6

    if-ne v6, p1, :cond_4

    iget-object v6, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    invoke-virtual {v6}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v6

    if-eq v6, p2, :cond_5

    :cond_4
    const-string v6, "TetherNetworkDataTransition"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "network state for "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    invoke-virtual {v8}, Landroid/net/NetworkInfo;->getType()I

    move-result v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " is: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mNetworkInfo:Landroid/net/NetworkInfo;

    invoke-virtual {v8}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    monitor-exit v5

    goto/16 :goto_1

    :cond_5
    const-string v1, "TetherNetworkDataTransition"

    const-string v6, "[DEBUG][NSH]expectedState reached"

    invoke-static {v1, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    monitor-exit v5
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move v1, v4

    goto/16 :goto_0

    :catch_3
    move-exception v6

    goto :goto_3
.end method


# virtual methods
.method public checkDataProfile()Z
    .locals 6

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .local v1, "result":Z
    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getPhoneEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phoneEx:Lcom/lge/internal/telephony/ITelephonyEx;

    :try_start_0
    iget-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phoneEx:Lcom/lge/internal/telephony/ITelephonyEx;

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phoneEx:Lcom/lge/internal/telephony/ITelephonyEx;

    const/4 v4, 0x4

    const/4 v5, 0x0

    invoke-interface {v3, v4, v5}, Lcom/lge/internal/telephony/ITelephonyEx;->checkDataProfileEx(II)Z

    move-result v1

    :cond_0
    const-string v3, "TetherNetworkDataTransition"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "checkDataProfile check apn info : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move v2, v1

    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    goto :goto_0
.end method

.method public connectMobile()Z
    .locals 6

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getConnectivityManager()Landroid/net/ConnectivityManager;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    iget-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    if-nez v3, :cond_0

    :goto_0
    return v1

    :cond_0
    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->registerConnectivityReceiver()V

    :try_start_0
    iget-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTm:Landroid/telephony/TelephonyManager;

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroid/telephony/TelephonyManager;->setDataEnabled(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    sget-object v3, Landroid/net/NetworkInfo$State;->CONNECTED:Landroid/net/NetworkInfo$State;

    const-wide/16 v4, 0x7530

    invoke-direct {p0, v3, v4, v5}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->waitForMobileConnection(Landroid/net/NetworkInfo$State;J)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->unregisterConnectivityReceiver()V

    const-string v2, "TetherNetworkDataTransition"

    const-string v3, "Can\'t change to connect Mobile Data connection"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_1
    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->unregisterConnectivityReceiver()V

    move v1, v2

    goto :goto_0
.end method

.method public connectMobileCheck()Z
    .locals 8

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    const/4 v0, 0x0

    .local v0, "doWait":Z
    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getConnectivityManager()Landroid/net/ConnectivityManager;

    move-result-object v4

    iput-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    iget-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    if-nez v4, :cond_1

    :cond_0
    :goto_0
    return v2

    :cond_1
    const-string v4, "TetherNetworkDataTransition"

    const-string v5, "[DEBUG][NSH]connectMobileCheck"

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    iget-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v4}, Landroid/net/ConnectivityManager;->getMobileDataEnabled()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v4

    if-eqz v4, :cond_0

    :try_start_1
    iget-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v4

    invoke-virtual {v4}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v4

    sget-object v5, Landroid/net/NetworkInfo$State;->CONNECTED:Landroid/net/NetworkInfo$State;

    if-eq v4, v5, :cond_2

    iget-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    const/4 v5, 0x5

    invoke-virtual {v4, v5}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v4

    invoke-virtual {v4}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v4

    sget-object v5, Landroid/net/NetworkInfo$State;->CONNECTED:Landroid/net/NetworkInfo$State;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    if-eq v4, v5, :cond_2

    const/4 v0, 0x1

    :cond_2
    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->registerConnectivityReceiver()V

    if-ne v0, v3, :cond_3

    sget-object v4, Landroid/net/NetworkInfo$State;->CONNECTED:Landroid/net/NetworkInfo$State;

    const-wide/16 v6, 0x2710

    invoke-direct {p0, v4, v6, v7}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->waitForMobileConnection(Landroid/net/NetworkInfo$State;J)Z

    move-result v4

    if-nez v4, :cond_3

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->unregisterConnectivityReceiver()V

    const-string v3, "TetherNetworkDataTransition"

    const-string v4, "Can\'t change to connect Mobile Data connectMobileCheck"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .end local v1    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v1

    .restart local v1    # "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .end local v1    # "e":Ljava/lang/Exception;
    :cond_3
    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->unregisterConnectivityReceiver()V

    :try_start_2
    iget-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v4

    invoke-virtual {v4}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v4

    sget-object v5, Landroid/net/NetworkInfo$State;->CONNECTED:Landroid/net/NetworkInfo$State;

    if-eq v4, v5, :cond_4

    iget-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    const/4 v5, 0x5

    invoke-virtual {v4, v5}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v4

    invoke-virtual {v4}, Landroid/net/NetworkInfo;->getState()Landroid/net/NetworkInfo$State;

    move-result-object v4

    sget-object v5, Landroid/net/NetworkInfo$State;->CONNECTED:Landroid/net/NetworkInfo$State;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    if-ne v4, v5, :cond_0

    :cond_4
    move v2, v3

    goto :goto_0

    :catch_2
    move-exception v1

    .restart local v1    # "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public connectMobileNoWait()Z
    .locals 5

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getConnectivityManager()Landroid/net/ConnectivityManager;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTm:Landroid/telephony/TelephonyManager;

    iget-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    if-nez v3, :cond_0

    :goto_0
    return v1

    :cond_0
    :try_start_0
    iget-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTm:Landroid/telephony/TelephonyManager;

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroid/telephony/TelephonyManager;->setDataEnabled(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move v1, v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public disconnectMobile()Z
    .locals 6

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getConnectivityManager()Landroid/net/ConnectivityManager;

    move-result-object v2

    iput-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getTelephonyManager()Landroid/telephony/TelephonyManager;

    move-result-object v2

    iput-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTm:Landroid/telephony/TelephonyManager;

    iget-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->registerConnectivityReceiver()V

    :try_start_0
    iget-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTm:Landroid/telephony/TelephonyManager;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/telephony/TelephonyManager;->setDataEnabled(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    sget-object v2, Landroid/net/NetworkInfo$State;->DISCONNECTED:Landroid/net/NetworkInfo$State;

    const-wide/16 v4, 0x7530

    invoke-direct {p0, v2, v4, v5}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->waitForMobileConnection(Landroid/net/NetworkInfo$State;J)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->unregisterConnectivityReceiver()V

    const-string v2, "TetherNetworkDataTransition"

    const-string v3, "can not disconnect Mobile Data connection"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_1
    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->unregisterConnectivityReceiver()V

    const/4 v1, 0x1

    goto :goto_0
.end method

.method public getFlag(I)Ljava/lang/String;
    .locals 11
    .param p1, "itemId"    # I

    .prologue
    const/4 v3, 0x0

    .local v3, "length":I
    const/16 v8, 0x8

    new-array v4, v8, [B

    .local v4, "requestData":[B
    invoke-static {v4}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->createBufferWithNativeByteOrder([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .local v0, "buf":Ljava/nio/ByteBuffer;
    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    const v8, 0x91004

    invoke-direct {p0, v8, v4}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->sendRilOemHookMsg(I[B)Landroid/os/AsyncResult;

    move-result-object v7

    .local v7, "result":Landroid/os/AsyncResult;
    iget-object v8, v7, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v8, :cond_1

    iget-object v8, v7, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v8, [B

    check-cast v8, [B

    invoke-static {v8}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->createBufferWithNativeByteOrder([B)Ljava/nio/ByteBuffer;

    move-result-object v6

    .local v6, "responseData":Ljava/nio/ByteBuffer;
    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v3

    new-array v5, v3, [B

    .local v5, "responseBytes":[B
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v3, :cond_0

    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->get()B

    move-result v8

    aput-byte v8, v5, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, v5}, Ljava/lang/String;-><init>([B)V

    .local v2, "itemValue":Ljava/lang/String;
    const-string v8, "TetherNetworkDataTransition"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "getCommands itemId "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "-END"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "i":I
    .end local v2    # "itemValue":Ljava/lang/String;
    .end local v5    # "responseBytes":[B
    .end local v6    # "responseData":Ljava/nio/ByteBuffer;
    :goto_1
    return-object v2

    :cond_1
    const-string v8, "TetherNetworkDataTransition"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Unable to read item "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, 0x0

    goto :goto_1
.end method

.method public getNetworkTechType()I
    .locals 4

    .prologue
    const/4 v1, -0x1

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getPhone()Lcom/android/internal/telephony/ITelephony;

    move-result-object v2

    iput-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    iget-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    if-nez v2, :cond_0

    const-string v2, "TetherNetworkDataTransition"

    const-string v3, "phone is null at isMultiPDNNetworkEnabled"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v1

    :cond_0
    :try_start_0
    iget-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v2}, Lcom/android/internal/telephony/ITelephony;->getNetworkType()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e4":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public getTetherNetworkDataFlagSet()Z
    .locals 1

    .prologue
    sget-boolean v0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTetherNetworkFlagSet:Z

    return v0
.end method

.method public isGsmNetwork()Z
    .locals 5

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getPhone()Lcom/android/internal/telephony/ITelephony;

    move-result-object v4

    iput-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    iget-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    if-nez v4, :cond_1

    const-string v3, "TetherNetworkDataTransition"

    const-string v4, "phone is null at isMultiPDNNetworkEnabled"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return v2

    :cond_1
    :try_start_0
    iget-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v4}, Lcom/android/internal/telephony/ITelephony;->getNetworkType()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .local v1, "networkType":I
    if-eq v3, v1, :cond_2

    const/4 v4, 0x2

    if-eq v4, v1, :cond_2

    const/4 v4, 0x3

    if-eq v4, v1, :cond_2

    const/16 v4, 0x8

    if-eq v4, v1, :cond_2

    const/16 v4, 0x9

    if-eq v4, v1, :cond_2

    const/16 v4, 0xa

    if-eq v4, v1, :cond_2

    const/16 v4, 0xb

    if-eq v4, v1, :cond_2

    const/16 v4, 0xf

    if-ne v4, v1, :cond_0

    :cond_2
    move v2, v3

    goto :goto_0

    .end local v1    # "networkType":I
    :catch_0
    move-exception v0

    .local v0, "e4":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public isLteOrEhrpdNetwork()Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getPhone()Lcom/android/internal/telephony/ITelephony;

    move-result-object v2

    iput-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    iget-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    if-nez v2, :cond_1

    const-string v2, "TetherNetworkDataTransition"

    const-string v3, "phone is null at isMultiPDNNetworkEnabled"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return v1

    :cond_1
    const/16 v2, 0xd

    :try_start_0
    iget-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v3}, Lcom/android/internal/telephony/ITelephony;->getNetworkType()I

    move-result v3

    if-eq v2, v3, :cond_2

    const/16 v2, 0xe

    iget-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v3}, Lcom/android/internal/telephony/ITelephony;->getNetworkType()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    if-ne v2, v3, :cond_0

    :cond_2
    const/4 v1, 0x1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e4":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public isMobileDataEnabled()Z
    .locals 5

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .local v1, "mIsMobileDataEnabled":Z
    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getConnectivityManager()Landroid/net/ConnectivityManager;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    iget-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    if-nez v3, :cond_0

    const-string v3, "TetherNetworkDataTransition"

    const-string v4, "ConnectivityManager is null at is MobileDataEnabled!"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v2

    :cond_0
    :try_start_0
    iget-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mCm:Landroid/net/ConnectivityManager;

    invoke-virtual {v3}, Landroid/net/ConnectivityManager;->getMobileDataEnabled()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    move v2, v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public isPamPdnDataProfileEnabled()Z
    .locals 5

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getPhone()Lcom/android/internal/telephony/ITelephony;

    move-result-object v3

    iput-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    iget-object v3, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    if-nez v3, :cond_1

    const-string v2, "TetherNetworkDataTransition"

    const-string v3, "phone is null at isMultiPDNNetworkEnabled"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return v1

    :cond_1
    const/16 v3, 0xd

    :try_start_0
    iget-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v4}, Lcom/android/internal/telephony/ITelephony;->getNetworkType()I

    move-result v4

    if-eq v3, v4, :cond_2

    const/16 v3, 0xe

    iget-object v4, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phone:Lcom/android/internal/telephony/ITelephony;

    invoke-interface {v4}, Lcom/android/internal/telephony/ITelephony;->getNetworkType()I

    move-result v4

    if-ne v3, v4, :cond_3

    :cond_2
    invoke-virtual {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->checkDataProfile()Z

    move-result v3

    if-eqz v3, :cond_0

    move v1, v2

    goto :goto_0

    :cond_3
    const-string v3, "TetherNetworkDataTransition"

    const-string v4, "mobile data will use as tether network "

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move v1, v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e4":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public notifyPhoneTetherStatus(Z)Z
    .locals 2
    .param p1, "tethered"    # Z

    .prologue
    if-eqz p1, :cond_0

    const-string v0, "TetherNetworkDataTransition"

    const-string v1, "&&&&&&&&&&& TETHER REQUEST ++++++++++++++++"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    const-string v0, "TetherNetworkDataTransition"

    const-string v1, "USB Tethering flag setting"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v1, 0x6b

    if-eqz p1, :cond_1

    const-string v0, "1"

    :goto_1
    invoke-virtual {p0, v1, v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->setFlag(ILjava/lang/String;)V

    sput-boolean p1, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mTetherNetworkFlagSet:Z

    const/4 v0, 0x1

    return v0

    :cond_0
    const-string v0, "TetherNetworkDataTransition"

    const-string v1, "&&&&&&&&&&& TETHER REQUEST ----------------"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    const-string v0, "0"

    goto :goto_1
.end method

.method public readMipErrorCode()I
    .locals 4

    .prologue
    const/4 v1, 0x0

    .local v1, "mipError":I
    invoke-direct {p0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getPhoneEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    iput-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phoneEx:Lcom/lge/internal/telephony/ITelephonyEx;

    :try_start_0
    iget-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phoneEx:Lcom/lge/internal/telephony/ITelephonyEx;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->phoneEx:Lcom/lge/internal/telephony/ITelephonyEx;

    invoke-interface {v2}, Lcom/lge/internal/telephony/ITelephonyEx;->getMipErrorCode()I

    move-result v1

    :goto_0
    return v1

    :cond_0
    const-string v2, "TetherNetworkDataTransition"

    const-string v3, "phone is null FATAL ERROR"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e3":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public sendLgRilHookMsg(ILjava/lang/String;)Landroid/os/AsyncResult;
    .locals 4
    .param p1, "requestId"    # I
    .param p2, "payload"    # Ljava/lang/String;

    .prologue
    iget v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mHeaderSize:I

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v3

    add-int/2addr v2, v3

    new-array v1, v2, [B

    .local v1, "request":[B
    invoke-static {v1}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->createBufferWithNativeByteOrder([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .local v0, "reqBuffer":Ljava/nio/ByteBuffer;
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-direct {p0, v0, p1, v2}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->addLgGpsRilHookHeader(Ljava/nio/ByteBuffer;II)V

    invoke-virtual {p2}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-direct {p0, p1, v1}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->sendRilOemHookMsg(I[B)Landroid/os/AsyncResult;

    move-result-object v2

    return-object v2
.end method

.method public sendLgRilHookMsg(I[B)Landroid/os/AsyncResult;
    .locals 4
    .param p1, "requestId"    # I
    .param p2, "payload"    # [B

    .prologue
    iget v2, p0, Lcom/android/server/connectivity/TetherNetworkDataTransition;->mHeaderSize:I

    array-length v3, p2

    add-int/2addr v2, v3

    new-array v1, v2, [B

    .local v1, "request":[B
    invoke-static {v1}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->createBufferWithNativeByteOrder([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .local v0, "reqBuffer":Ljava/nio/ByteBuffer;
    array-length v2, p2

    invoke-direct {p0, v0, p1, v2}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->addLgGpsRilHookHeader(Ljava/nio/ByteBuffer;II)V

    invoke-virtual {v0, p2}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-direct {p0, p1, v1}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->sendRilOemHookMsg(I[B)Landroid/os/AsyncResult;

    move-result-object v2

    return-object v2
.end method

.method public setFlag(ILjava/lang/String;)V
    .locals 4
    .param p1, "itemId"    # I
    .param p2, "itemValue"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .local v1, "length":I
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    :cond_0
    add-int/lit8 v3, v1, 0x8

    new-array v2, v3, [B

    .local v2, "requestData":[B
    invoke-static {v2}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->createBufferWithNativeByteOrder([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .local v0, "buf":Ljava/nio/ByteBuffer;
    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    if-eqz p2, :cond_1

    invoke-virtual {p2}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    :cond_1
    const v3, 0x91005

    invoke-direct {p0, v3, v2}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->sendRilOemHookMsg(I[B)Landroid/os/AsyncResult;

    return-void
.end method
