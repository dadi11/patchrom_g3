.class public abstract Lcom/android/internal/telephony/InboundSmsHandlerEx;
.super Lcom/android/internal/telephony/InboundSmsHandler;
.source "InboundSmsHandlerEx.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;,
        Lcom/android/internal/telephony/InboundSmsHandlerEx$EMSSegmentExpirationRunnable;
    }
.end annotation


# static fields
.field private static final ACTION_KTLBS_DATA_SMS_RECEIVED:Ljava/lang/String; = "com.kt.location.action.KTLBS_DATA_SMS_RECEIVED"

.field protected static final APP_DIRECTED_SMS_FORMATTED:I = 0x0

.field protected static final APP_DIRECTED_SMS_NORMAL:I = -0x1

.field protected static final APP_DIRECTED_SMS_PROCESSED:I = 0x1

.field protected static final APP_DIRECTED_SMS_VZWLBSROVER:I = -0x2

.field private static final DUPLICATE_PROJECTION:[Ljava/lang/String;

.field public static final EMS_EXPIRATION_TIME:I = 0x493e0

.field private static final ENCRYPTING_STATE:Ljava/lang/String; = "trigger_restart_min_framework"

.field static final INCOMPLETE_SELECT:Ljava/lang/String; = "reference_number=? AND time=?"

.field private static final KEYWORD_MOBILEBOX_PRO:Ljava/lang/String; = "Mobilbox Pro"

.field private static final KIZON_PACKAGE:Ljava/lang/String; = "com.lge.band"

.field private static final KIZON_PATTERN:Ljava/util/regex/Pattern;

.field private static final KIZON_PREFIX:Ljava/lang/String; = "^KizON.*\\[[0-9a-zA-Z+/=]{6}\\]"

.field private static final MCAFEE_PACKAGE:Ljava/lang/String; = "com.wsandroid.suite.lge"

.field private static final MCAFEE_PATTERN:Ljava/util/regex/Pattern;

.field private static final MCAFEE_PREFIX:Ljava/lang/String; = "service.wsandroid.lge.token"

.field private static final MCAFEE_WEB_PREFIX:Ljava/lang/String;

.field private static final MEM_THRESHOLD:I = 0x2000

.field public static final MISSING_CONCAT_CHAR:Ljava/lang/String; = "(...)"

.field private static final MOBILEBOX_PRO_SERVER:Ljava/lang/String; = "3311"

.field private static final NEED_TO_CHANGE_DELIVER_ACTION:[Ljava/lang/String;

.field private static final PDU_SEQUENCE_PORT_ICC_TIME_PROJECTION:[Ljava/lang/String;

.field public static RECEIVE_DAN_SUCCESS:Z = false

.field private static final SMS_INBOX_CONSTRAINT:Ljava/lang/String; = "(type = 1)"

.field private static final SMS_INBOX_MAX_COUNT:I = 0x32

.field private static final SPTS_ADDRESS:Ljava/lang/String; = "00000000000"

.field public static final STITCHING_WAIT_TIME:J = 0x2932e00L

.field private static final TAG:Ljava/lang/String; = "Mms Testbed"

.field private static final VVMApp:Ljava/lang/String; = "com.coremobility.app.vnotes"

.field private static final mOperatorMessages:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field protected static final mRawUri:Landroid/net/Uri;

.field private static final prefixVZW:Ljava/lang/String; = "//VZW"


# instance fields
.field public final APPLICATION_PERMISSION:Ljava/lang/String;

.field public final METADATA_NAME:Ljava/lang/String;

.field private VZWSignature:[Landroid/content/pm/Signature;

.field protected lgu:Lcom/android/internal/telephony/LGUSmsUtils;

.field protected sprintReassemblySms:Lcom/android/internal/telephony/LGSprintReassemblySms;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .prologue
    const/4 v6, 0x4

    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 122
    sput-boolean v2, Lcom/android/internal/telephony/InboundSmsHandlerEx;->RECEIVE_DAN_SUCCESS:Z

    .line 125
    sget-object v0, Landroid/provider/Telephony$Sms;->CONTENT_URI:Landroid/net/Uri;

    const-string v1, "raw"

    invoke-static {v0, v1}, Landroid/net/Uri;->withAppendedPath(Landroid/net/Uri;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    sput-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mRawUri:Landroid/net/Uri;

    .line 138
    const/4 v0, 0x5

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "pdu"

    aput-object v1, v0, v2

    const-string v1, "sequence"

    aput-object v1, v0, v3

    const-string v1, "destination_port"

    aput-object v1, v0, v4

    const-string v1, "icc_index"

    aput-object v1, v0, v5

    const-string v1, "time"

    aput-object v1, v0, v6

    sput-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_SEQUENCE_PORT_ICC_TIME_PROJECTION:[Ljava/lang/String;

    .line 153
    const/4 v0, 0x5

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "_id"

    aput-object v1, v0, v2

    const-string v1, "address"

    aput-object v1, v0, v3

    const-string v1, "date_sent"

    aput-object v1, v0, v4

    const-string v1, "person"

    aput-object v1, v0, v5

    const-string v1, "body"

    aput-object v1, v0, v6

    sput-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->DUPLICATE_PROJECTION:[Ljava/lang/String;

    .line 188
    new-array v0, v6, [Ljava/lang/String;

    const-string v1, "android.provider.Telephony.VOICE_RECEIVED"

    aput-object v1, v0, v2

    const-string v1, "android.provider.Telephony.VIDEO_RECEIVED"

    aput-object v1, v0, v3

    const-string v1, "android.provider.Telephony.CALLBACKURL_SKT_RECEIVED"

    aput-object v1, v0, v4

    const-string v1, "android.provider.Telephony.CALLBACKURL_KT_RECEIVED"

    aput-object v1, v0, v5

    sput-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->NEED_TO_CHANGE_DELIVER_ACTION:[Ljava/lang/String;

    .line 206
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mOperatorMessages:Ljava/util/HashMap;

    .line 211
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "^((\\[[wW][eE][bB]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/lge/internal/R$string;->SMS_WEB_SEND:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\\])[ \n\r]?)?"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->MCAFEE_WEB_PREFIX:Ljava/lang/String;

    .line 212
    sget-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->MCAFEE_WEB_PREFIX:Ljava/lang/String;

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->MCAFEE_PATTERN:Ljava/util/regex/Pattern;

    .line 217
    const-string v0, "^KizON.*\\[[0-9a-zA-Z+/=]{6}\\]"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->KIZON_PATTERN:Ljava/util/regex/Pattern;

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;Landroid/content/Context;Lcom/android/internal/telephony/SmsStorageMonitor;Lcom/android/internal/telephony/PhoneBase;Lcom/android/internal/telephony/CellBroadcastHandler;)V
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "storageMonitor"    # Lcom/android/internal/telephony/SmsStorageMonitor;
    .param p4, "phone"    # Lcom/android/internal/telephony/PhoneBase;
    .param p5, "cellBroadcastHandler"    # Lcom/android/internal/telephony/CellBroadcastHandler;

    .prologue
    const/4 v2, 0x1

    .line 228
    invoke-direct/range {p0 .. p5}, Lcom/android/internal/telephony/InboundSmsHandler;-><init>(Ljava/lang/String;Landroid/content/Context;Lcom/android/internal/telephony/SmsStorageMonitor;Lcom/android/internal/telephony/PhoneBase;Lcom/android/internal/telephony/CellBroadcastHandler;)V

    .line 1001
    const-string v0, "com.verizon.permissions.appdirectedsms"

    iput-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->APPLICATION_PERMISSION:Ljava/lang/String;

    .line 1002
    const-string v0, "com.verizon.directedAppSMS"

    iput-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->METADATA_NAME:Ljava/lang/String;

    .line 230
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v1, "OperatorMessage"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-ne v0, v2, :cond_0

    .line 231
    invoke-static {}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->initOperatorMessagesMap()V

    .line 236
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v1, "lgu_dispatch"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-ne v0, v2, :cond_1

    .line 237
    new-instance v0, Lcom/android/internal/telephony/LGUSmsUtils;

    iget-object v1, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1, v2, p0}, Lcom/android/internal/telephony/LGUSmsUtils;-><init>(Landroid/content/ContentResolver;Landroid/content/Context;Lcom/android/internal/telephony/InboundSmsHandler;)V

    iput-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->lgu:Lcom/android/internal/telephony/LGUSmsUtils;

    .line 242
    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v1, "sprint_reassembly_sms"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 243
    new-instance v0, Lcom/android/internal/telephony/LGSprintReassemblySms;

    iget-object v1, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1, p0}, Lcom/android/internal/telephony/LGSprintReassemblySms;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/InboundSmsHandler;)V

    iput-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sprintReassemblySms:Lcom/android/internal/telephony/LGSprintReassemblySms;

    .line 246
    :cond_2
    return-void
.end method

.method static synthetic access$000()[Ljava/lang/String;
    .locals 1

    .prologue
    .line 108
    sget-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_SEQUENCE_PORT_ICC_TIME_PROJECTION:[Ljava/lang/String;

    return-object v0
.end method

.method private addGsmOperatorMessages([[BZZLcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;Landroid/content/BroadcastReceiver;)V
    .locals 6
    .param p1, "pdus"    # [[B
    .param p2, "isConcat"    # Z
    .param p3, "existsPortAddrs"    # Z
    .param p4, "sms"    # Lcom/android/internal/telephony/SmsMessageBase;
    .param p6, "receiver"    # Landroid/content/BroadcastReceiver;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([[BZZ",
            "Lcom/android/internal/telephony/SmsMessageBase;",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/SmsOperatorBasicMessage;",
            ">;",
            "Landroid/content/BroadcastReceiver;",
            ")V"
        }
    .end annotation

    .prologue
    .line 1469
    .local p5, "operatorMessageList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/telephony/SmsOperatorBasicMessage;>;"
    const/4 v0, 0x1

    if-ne p3, v0, :cond_1

    .line 1470
    const-string v1, "KTPortMessage"

    move-object v0, p0

    move-object v2, p1

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    invoke-direct/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->addOperatorMessageList(Ljava/lang/String;[[BLcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;Landroid/content/BroadcastReceiver;)V

    .line 1471
    const-string v1, "SKTCommonPush"

    move-object v0, p0

    move-object v2, p1

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    invoke-direct/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->addOperatorMessageList(Ljava/lang/String;[[BLcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;Landroid/content/BroadcastReceiver;)V

    .line 1472
    const-string v1, "SKTUrlCallback"

    move-object v0, p0

    move-object v2, p1

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    invoke-direct/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->addOperatorMessageList(Ljava/lang/String;[[BLcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;Landroid/content/BroadcastReceiver;)V

    .line 1473
    const-string v1, "lgu_gsm_operator_message"

    move-object v0, p0

    move-object v2, p1

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    invoke-direct/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->addOperatorMessageList(Ljava/lang/String;[[BLcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;Landroid/content/BroadcastReceiver;)V

    .line 1479
    :goto_0
    if-nez p2, :cond_0

    .line 1480
    const-string v1, "specialMessage"

    move-object v0, p0

    move-object v2, p1

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    invoke-direct/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->addOperatorMessageList(Ljava/lang/String;[[BLcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;Landroid/content/BroadcastReceiver;)V

    .line 1482
    :cond_0
    return-void

    .line 1475
    :cond_1
    const-string v1, "KTUrlCallback"

    move-object v0, p0

    move-object v2, p1

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    invoke-direct/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->addOperatorMessageList(Ljava/lang/String;[[BLcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;Landroid/content/BroadcastReceiver;)V

    .line 1476
    const-string v1, "spam"

    move-object v0, p0

    move-object v2, p1

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    invoke-direct/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->addOperatorMessageList(Ljava/lang/String;[[BLcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;Landroid/content/BroadcastReceiver;)V

    goto :goto_0
.end method

.method private addOperatorMessageList(Ljava/lang/String;[[BLcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;Landroid/content/BroadcastReceiver;)V
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "pdus"    # [[B
    .param p3, "sms"    # Lcom/android/internal/telephony/SmsMessageBase;
    .param p5, "receiver"    # Landroid/content/BroadcastReceiver;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "[[B",
            "Lcom/android/internal/telephony/SmsMessageBase;",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/SmsOperatorBasicMessage;",
            ">;",
            "Landroid/content/BroadcastReceiver;",
            ")V"
        }
    .end annotation

    .prologue
    .line 1485
    .local p4, "operatorMessageList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/telephony/SmsOperatorBasicMessage;>;"
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-static {v0, p1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1486
    const-string v0, "spam"

    if-ne p1, v0, :cond_1

    .line 1487
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-static {v0, p3, p2, p5}, Lcom/android/internal/telephony/LGSmsTelephonyManager;->getOperatorSpamMessage(Landroid/content/Context;Lcom/android/internal/telephony/SmsMessageBase;[[BLandroid/content/BroadcastReceiver;)Lcom/lge/telephony/SmsOperatorBasicMessage;

    move-result-object v0

    invoke-virtual {p4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1492
    :cond_0
    :goto_0
    return-void

    .line 1489
    :cond_1
    sget-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mOperatorMessages:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v1, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-static {v0, v1, p3, p2, p5}, Lcom/android/internal/telephony/LGSmsTelephonyManager;->getOperatorMessage(Ljava/lang/String;Landroid/content/Context;Lcom/android/internal/telephony/SmsMessageBase;[[BLandroid/content/BroadcastReceiver;)Lcom/lge/telephony/SmsOperatorBasicMessage;

    move-result-object v0

    invoke-virtual {p4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method private addSMSPermissionTracking()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 2264
    iget-object v3, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    .line 2265
    .local v2, "pm":Landroid/content/pm/PackageManager;
    new-instance v3, Landroid/content/Intent;

    const-string v4, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v3, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v3, v5}, Landroid/content/pm/PackageManager;->queryBroadcastReceivers(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v1

    .line 2267
    .local v1, "pkgList":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_0

    .line 2268
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    if-ge v0, v3, :cond_0

    .line 2269
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleNewSms(), [Permission Check] allowed SMS_RECEIVED_ACTION Activity : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/pm/ResolveInfo;

    iget-object v3, v3, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2268
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 2274
    .end local v0    # "i":I
    :cond_0
    new-instance v3, Landroid/content/Intent;

    const-string v4, "android.provider.Telephony.SMS_DELIVER"

    invoke-direct {v3, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v3, v5}, Landroid/content/pm/PackageManager;->queryBroadcastReceivers(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v1

    .line 2276
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_1

    .line 2277
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_1
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    if-ge v0, v3, :cond_1

    .line 2278
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleNewSms(), [Permission Check] allowed SMS_DELIVER_ACTION Activity : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/pm/ResolveInfo;

    iget-object v3, v3, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2277
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 2281
    .end local v0    # "i":I
    :cond_1
    return-void
.end method

.method private checkDuplicateMsg(Landroid/database/Cursor;)Z
    .locals 4
    .param p1, "cursor"    # Landroid/database/Cursor;

    .prologue
    .line 2487
    invoke-interface {p1}, Landroid/database/Cursor;->getCount()I

    move-result v0

    .line 2488
    .local v0, "cursorCount":I
    if-nez v0, :cond_0

    .line 2489
    const-string v2, "checkDuplicateKddiMessage(), [KDDI]  Not duplicated message "

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->i(Ljava/lang/String;)I

    .line 2490
    const/4 v1, 0x0

    .line 2503
    .local v1, "isDuplicated":Z
    :goto_0
    return v1

    .line 2493
    .end local v1    # "isDuplicated":Z
    :cond_0
    :goto_1
    invoke-interface {p1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 2494
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "checkDuplicateKddiMessage(), [KDDI] Stored message data: _id= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/4 v3, 0x3

    invoke-interface {p1, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "  address ="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/4 v3, 0x1

    invoke-interface {p1, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "  mcTimeStamp= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/4 v3, 0x2

    invoke-interface {p1, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "  body = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/4 v3, 0x4

    invoke-interface {p1, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->i(Ljava/lang/String;)I

    goto :goto_1

    .line 2499
    :cond_1
    const-string v2, "checkDuplicateKddiMessage(), [KDDI] Duplicated message "

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2500
    const/4 v1, 0x1

    .restart local v1    # "isDuplicated":Z
    goto :goto_0
.end method

.method private checkKDDIConcatTimeStamp(Lcom/android/internal/telephony/InboundSmsTracker;Ljava/lang/String;)V
    .locals 10
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "refNumber"    # Ljava/lang/String;

    .prologue
    .line 2452
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getTimestamp()J

    move-result-wide v6

    const-wide/32 v8, 0x3e800

    sub-long/2addr v6, v8

    invoke-static {v6, v7}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v0

    .line 2453
    .local v0, "comparingTime":Ljava/lang/String;
    const-string v4, "reference_number=? AND date<?"

    .line 2454
    .local v4, "whereEx":Ljava/lang/String;
    const/4 v5, 0x2

    new-array v3, v5, [Ljava/lang/String;

    const/4 v5, 0x0

    aput-object p2, v3, v5

    const/4 v5, 0x1

    aput-object v0, v3, v5

    .line 2457
    .local v3, "whereArgsEx":[Ljava/lang/String;
    :try_start_0
    iget-object v5, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v6, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sRawUri:Landroid/net/Uri;

    invoke-virtual {v4}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v6, v7, v3}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v1

    .line 2458
    .local v1, "deleteCnt":I
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "processMessagePart(), [KDDI] duplicated reference number & more than 256 secs earlier timestamp : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/database/SQLException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 2464
    .end local v1    # "deleteCnt":I
    :goto_0
    return-void

    .line 2459
    :catch_0
    move-exception v2

    .line 2460
    .local v2, "e":Landroid/database/SQLException;
    const-string v5, "processMessagePart(), Can\'t access multipart SMS database"

    invoke-static {v5, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 2461
    .end local v2    # "e":Landroid/database/SQLException;
    :catch_1
    move-exception v2

    .line 2462
    .local v2, "e":Ljava/lang/RuntimeException;
    const-string v5, "processMessagePart(), Runtime Exception: maybe concat reference is mixed"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method private checkKDDIDuplicateMsg(Lcom/android/internal/telephony/SmsMessageBase;I)I
    .locals 9
    .param p1, "sms"    # Lcom/android/internal/telephony/SmsMessageBase;
    .param p2, "destPort"    # I

    .prologue
    const/4 v6, 0x0

    const/4 v8, 0x1

    .line 2340
    instance-of v1, p1, Lcom/android/internal/telephony/cdma/SmsMessage;

    if-eqz v1, :cond_0

    move-object v1, p1

    .line 2341
    check-cast v1, Lcom/android/internal/telephony/cdma/SmsMessage;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/SmsMessage;->getSmsEnvelope()Lcom/android/internal/telephony/cdma/sms/SmsEnvelope;

    move-result-object v1

    iget v1, v1, Lcom/android/internal/telephony/cdma/sms/SmsEnvelope;->messageType:I

    if-ne v1, v8, :cond_0

    .line 2344
    new-instance v0, Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getPdu()[B

    move-result-object v1

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getTimestampMillis()J

    move-result-wide v2

    invoke-virtual {p0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->is3gpp2()Z

    move-result v5

    move v4, p2

    invoke-direct/range {v0 .. v6}, Lcom/android/internal/telephony/InboundSmsTracker;-><init>([BJIZZ)V

    .line 2345
    .local v0, "tracker":Lcom/android/internal/telephony/InboundSmsTracker;
    const/4 v1, 0x2

    invoke-virtual {p0, v1, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(ILjava/lang/Object;)V

    move v1, v8

    .line 2357
    .end local v0    # "tracker":Lcom/android/internal/telephony/InboundSmsTracker;
    :goto_0
    return v1

    .line 2350
    :cond_0
    iget v1, p1, Lcom/android/internal/telephony/SmsMessageBase;->mMessageRef:I

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getTimestampMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getMessageBody()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->checkDuplicateKddiMessage(ILjava/lang/Long;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v7

    .line 2351
    .local v7, "discard":Z
    if-eqz v7, :cond_1

    .line 2353
    const-string v1, "dispatchNormalMessage(), [KDDI] discard duplicate Message "

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    move v1, v8

    .line 2354
    goto :goto_0

    .line 2356
    :cond_1
    new-instance v0, Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getPdu()[B

    move-result-object v1

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getTimestampMillis()J

    move-result-wide v2

    invoke-virtual {p0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->is3gpp2()Z

    move-result v5

    move v4, p2

    invoke-direct/range {v0 .. v6}, Lcom/android/internal/telephony/InboundSmsTracker;-><init>([BJIZZ)V

    .line 2357
    .restart local v0    # "tracker":Lcom/android/internal/telephony/InboundSmsTracker;
    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->addTrackerToRawTableAndSendMessage(Lcom/android/internal/telephony/InboundSmsTracker;)I

    move-result v1

    goto :goto_0
.end method

.method private checkKRConcatTimeStamp(Lcom/android/internal/telephony/InboundSmsTracker;Ljava/lang/String;Ljava/lang/String;)V
    .locals 10
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "address"    # Ljava/lang/String;
    .param p3, "refNumber"    # Ljava/lang/String;

    .prologue
    .line 2469
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getTimestamp()J

    move-result-wide v6

    const-wide/32 v8, 0x927c0

    sub-long/2addr v6, v8

    invoke-static {v6, v7}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v0

    .line 2470
    .local v0, "comparingTime":Ljava/lang/String;
    const-string v4, "address=? AND reference_number=? AND date<?"

    .line 2471
    .local v4, "whereEx":Ljava/lang/String;
    const/4 v5, 0x3

    new-array v3, v5, [Ljava/lang/String;

    const/4 v5, 0x0

    aput-object p2, v3, v5

    const/4 v5, 0x1

    aput-object p3, v3, v5

    const/4 v5, 0x2

    aput-object v0, v3, v5

    .line 2474
    .local v3, "whereArgsEx":[Ljava/lang/String;
    :try_start_0
    iget-object v5, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v6, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sRawUri:Landroid/net/Uri;

    invoke-virtual {v4}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v6, v7, v3}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v1

    .line 2475
    .local v1, "deleteCnt":I
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "processMessagePart(), [KRSMS] duplicated reference number & more than 10 minutes earlier timestamp"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/database/SQLException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 2481
    .end local v1    # "deleteCnt":I
    :goto_0
    return-void

    .line 2476
    :catch_0
    move-exception v2

    .line 2477
    .local v2, "e":Landroid/database/SQLException;
    const-string v5, "processMessagePart(), Can\'t access multipart SMS database"

    invoke-static {v5, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 2478
    .end local v2    # "e":Landroid/database/SQLException;
    :catch_1
    move-exception v2

    .line 2479
    .local v2, "e":Ljava/lang/RuntimeException;
    const-string v5, "processMessagePart(), Runtime Exception: maybe concat reference is mixed"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method private controlSeperateSmsUicc(Lcom/android/internal/telephony/InboundSmsTracker;Landroid/database/Cursor;)Ljava/lang/String;
    .locals 3
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "cursor"    # Landroid/database/Cursor;

    .prologue
    .line 2365
    const-string v2, "icc_index"

    invoke-interface {p2, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v0

    .line 2366
    .local v0, "iccColumn":I
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1}, Ljava/lang/String;-><init>()V

    .line 2367
    .local v1, "iccSring":Ljava/lang/String;
    invoke-interface {p2}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 2369
    :cond_0
    invoke-interface {p2, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    if-lez v2, :cond_1

    .line 2370
    invoke-interface {p2, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 2371
    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 2373
    :cond_1
    invoke-interface {p2}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 2375
    :cond_2
    const/4 v2, -0x1

    invoke-interface {p2, v2}, Landroid/database/Cursor;->moveToPosition(I)Z

    .line 2376
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->lgeGetIndexOnIcc()I

    move-result v2

    if-lez v2, :cond_3

    .line 2377
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->lgeGetIndexOnIcc()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 2379
    :cond_3
    return-object v1
.end method

.method private deleteDuplicateSMSKDDI(Landroid/database/Cursor;)Z
    .locals 9
    .param p1, "cursor"    # Landroid/database/Cursor;

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 2521
    invoke-interface {p1}, Landroid/database/Cursor;->getCount()I

    move-result v5

    const/16 v6, 0x13

    if-le v5, v6, :cond_0

    .line 2522
    invoke-interface {p1}, Landroid/database/Cursor;->moveToNext()Z

    .line 2523
    invoke-interface {p1, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 2525
    .local v0, "_id":Ljava/lang/String;
    :try_start_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "content://sms/"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    .line 2526
    .local v1, "dup_delete_MessageUri":Landroid/net/Uri;
    iget-object v5, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    const-string v6, "_id =?"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/String;

    const/4 v8, 0x0

    aput-object v0, v7, v8

    invoke-virtual {v5, v1, v6, v7}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    .line 2527
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "checkDuplicateKddiMessage(), [KDDI] delete old one in duplicate SMS database  _id: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2534
    if-eqz p1, :cond_0

    .line 2535
    invoke-interface {p1}, Landroid/database/Cursor;->close()V

    .end local v0    # "_id":Ljava/lang/String;
    .end local v1    # "dup_delete_MessageUri":Landroid/net/Uri;
    :cond_0
    :goto_0
    move v3, v4

    .line 2540
    :cond_1
    :goto_1
    return v3

    .line 2528
    .restart local v0    # "_id":Ljava/lang/String;
    :catch_0
    move-exception v2

    .line 2529
    .local v2, "e":Landroid/database/sqlite/SQLiteException;
    :try_start_1
    invoke-direct {p0, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->isLowMemory(Landroid/database/sqlite/SQLiteException;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 2530
    const-string v4, "checkDuplicateKddiMessage(), [KDDI]  Can\'t access duplicate SMS database"

    invoke-static {v4, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2534
    if-eqz p1, :cond_1

    .line 2535
    invoke-interface {p1}, Landroid/database/Cursor;->close()V

    goto :goto_1

    .line 2534
    :cond_2
    if-eqz p1, :cond_0

    .line 2535
    invoke-interface {p1}, Landroid/database/Cursor;->close()V

    goto :goto_0

    .line 2534
    .end local v2    # "e":Landroid/database/sqlite/SQLiteException;
    :catchall_0
    move-exception v3

    if-eqz p1, :cond_3

    .line 2535
    invoke-interface {p1}, Landroid/database/Cursor;->close()V

    :cond_3
    throw v3
.end method

.method private dispatchPduKRTestbed(Ljava/lang/String;ILjava/lang/String;[[BLandroid/content/BroadcastReceiver;)I
    .locals 10
    .param p1, "address"    # Ljava/lang/String;
    .param p2, "messageCount"    # I
    .param p3, "serviceCenter"    # Ljava/lang/String;
    .param p4, "pdus"    # [[B
    .param p5, "resultReceiver"    # Landroid/content/BroadcastReceiver;

    .prologue
    .line 2681
    new-instance v9, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v9}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 2682
    .local v9, "output":Ljava/io/ByteArrayOutputStream;
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_0
    if-ge v7, p2, :cond_1

    .line 2683
    aget-object v0, p4, v7

    const-string v1, "3gpp2"

    invoke-static {v0, v1}, Landroid/telephony/SmsMessage;->createFromPdu([BLjava/lang/String;)Landroid/telephony/SmsMessage;

    move-result-object v8

    .line 2685
    .local v8, "msg":Landroid/telephony/SmsMessage;
    if-eqz v8, :cond_0

    .line 2686
    invoke-virtual {v8}, Landroid/telephony/SmsMessage;->getUserData()[B

    move-result-object v6

    .line 2687
    .local v6, "data":[B
    const/4 v0, 0x0

    array-length v1, v6

    invoke-virtual {v9, v6, v0, v1}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 2682
    .end local v6    # "data":[B
    :cond_0
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 2693
    .end local v8    # "msg":Landroid/telephony/SmsMessage;
    :cond_1
    sget-boolean v0, Lcom/lge/config/ConfigBuildFlags;->CAPP_WAPSERVICE:Z

    if-eqz v0, :cond_2

    .line 2694
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mWapPush:Lcom/android/internal/telephony/WapPushOverSmsEx;

    invoke-virtual {v9}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    move-object v2, p5

    move-object v3, p0

    move-object v4, p3

    move-object v5, p1

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/WapPushOverSmsEx;->dispatchWapPdu([BLandroid/content/BroadcastReceiver;Lcom/android/internal/telephony/InboundSmsHandler;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 2699
    :goto_1
    return v0

    :cond_2
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mWapPush:Lcom/android/internal/telephony/WapPushOverSmsEx;

    invoke-virtual {v9}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    move-object v2, p5

    move-object v3, p0

    move-object v4, p3

    move-object v5, p1

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/WapPushOverSmsEx;->dispatchWapPdu([BLandroid/content/BroadcastReceiver;Lcom/android/internal/telephony/InboundSmsHandler;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_1
.end method

.method private dispatchVVM3Pdu([B)V
    .locals 6
    .param p1, "vvm3pduToDispatch"    # [B

    .prologue
    .line 1901
    new-instance v1, Landroid/content/Intent;

    const-string v0, "android.provider.Telephony.WAP_PUSH_RECEIVED"

    invoke-direct {v1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1902
    .local v1, "intent":Landroid/content/Intent;
    const-string v0, "data"

    invoke-virtual {v1, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[B)Landroid/content/Intent;

    .line 1903
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[sms.mt.vvm3] intent = "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1904
    const-string v2, "android.permission.RECEIVE_SMS"

    const/16 v3, 0x10

    const/4 v4, 0x0

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 1906
    const-string v0, "[sms.mt.vvm3] dispatchVVM3Pdu end]"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1907
    return-void
.end method

.method private getSMSInboxMessageCount()I
    .locals 9

    .prologue
    const/4 v3, 0x0

    .line 1578
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    .line 1579
    .local v1, "resolver":Landroid/content/ContentResolver;
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    sget-object v2, Landroid/provider/Telephony$Sms;->CONTENT_URI:Landroid/net/Uri;

    const-string v4, "(type = 1)"

    move-object v5, v3

    move-object v6, v3

    invoke-static/range {v0 .. v6}, Landroid/database/sqlite/SqliteWrapper;->query(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v8

    .line 1583
    .local v8, "cursor":Landroid/database/Cursor;
    if-nez v8, :cond_0

    .line 1584
    const/4 v7, 0x0

    .line 1589
    :goto_0
    return v7

    .line 1587
    :cond_0
    invoke-interface {v8}, Landroid/database/Cursor;->getCount()I

    move-result v7

    .line 1588
    .local v7, "count":I
    invoke-interface {v8}, Landroid/database/Cursor;->close()V

    goto :goto_0
.end method

.method private getVZWSignatures(Landroid/content/pm/PackageManager;)Z
    .locals 10
    .param p1, "pm"    # Landroid/content/pm/PackageManager;

    .prologue
    const/4 v7, 0x0

    .line 1041
    :try_start_0
    const-string v8, "com.verizon.permissions.appdirectedsms"

    const/16 v9, 0x40

    invoke-virtual {p1, v8, v9}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v5

    .line 1047
    .local v5, "permissionPkgInfo":Landroid/content/pm/PackageInfo;
    if-eqz v5, :cond_1

    .line 1048
    iget-object v8, v5, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    iput-object v8, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->VZWSignature:[Landroid/content/pm/Signature;

    .line 1050
    iget-object v8, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->VZWSignature:[Landroid/content/pm/Signature;

    if-nez v8, :cond_0

    .line 1051
    const-string v8, "getVZWSignatures(), Can\'t find permission package signatures"

    invoke-static {v8}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1061
    .end local v5    # "permissionPkgInfo":Landroid/content/pm/PackageInfo;
    :goto_0
    return v7

    .line 1042
    :catch_0
    move-exception v1

    .line 1043
    .local v1, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    const-string v8, "getVZWSignatures(), Can\'t find permission package: com.verizon.permissions.appdirectedsms"

    invoke-static {v8}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0

    .line 1054
    .end local v1    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    .restart local v5    # "permissionPkgInfo":Landroid/content/pm/PackageInfo;
    :cond_0
    const/4 v3, 0x0

    .line 1055
    .local v3, "index":I
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->VZWSignature:[Landroid/content/pm/Signature;

    .local v0, "arr$":[Landroid/content/pm/Signature;
    array-length v4, v0

    .local v4, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_1
    if-ge v2, v4, :cond_1

    aget-object v6, v0, v2

    .line 1056
    .local v6, "signature":Landroid/content/pm/Signature;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "getVZWSignatures(), VZWSignature: index = [ "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " ]"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1057
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "getVZWSignatures(), VZWSignature : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v6}, Landroid/content/pm/Signature;->toCharsString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1058
    add-int/lit8 v3, v3, 0x1

    .line 1055
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 1061
    .end local v0    # "arr$":[Landroid/content/pm/Signature;
    .end local v2    # "i$":I
    .end local v3    # "index":I
    .end local v4    # "len$":I
    .end local v6    # "signature":Landroid/content/pm/Signature;
    :cond_1
    const/4 v7, 0x1

    goto :goto_0
.end method

.method private handleCdmaSmsCDG2(Landroid/telephony/SmsMessage;)V
    .locals 10
    .param p1, "sms"    # Landroid/telephony/SmsMessage;

    .prologue
    const/16 v9, 0x1002

    const/16 v8, 0x32

    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 2286
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleMessage(), CDMA SMS CDG2 Test mode"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "cdma_sms_cdg2"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2287
    invoke-static {}, Landroid/telephony/SmsMessage;->isCdmaVoice()Z

    move-result v3

    if-ne v3, v6, :cond_0

    .line 2288
    iget-object v3, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v4, "sms_over_lgims"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 2289
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleMessage(), KEY_SMS_OVER_LGIMS: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "sms_over_lgims"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2290
    const-string v3, "persist.radio.sms_ims"

    const-string v4, "false"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 2291
    .local v0, "mImsRegi":Ljava/lang/String;
    const-string v3, "false"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 2292
    const-string v3, "handleMessage(), IMS is not registered!Execute SMS CDG2 Test mode"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2293
    iget-object v3, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mStorageMonitor:Lcom/android/internal/telephony/SmsStorageMonitor;

    invoke-virtual {v3, v6}, Lcom/android/internal/telephony/SmsStorageMonitor;->setStorageAvailableStatus(Z)V

    .line 2294
    iget-object v1, p1, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    check-cast v1, Lcom/android/internal/telephony/cdma/SmsMessage;

    .line 2295
    .local v1, "smsCdma":Lcom/android/internal/telephony/cdma/SmsMessage;
    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/SmsMessage;->getTeleService()I

    move-result v2

    .line 2297
    .local v2, "teleService":I
    if-ne v2, v9, :cond_0

    .line 2298
    invoke-direct {p0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->getSMSInboxMessageCount()I

    move-result v3

    if-lt v3, v8, :cond_0

    .line 2299
    iget-object v3, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mStorageMonitor:Lcom/android/internal/telephony/SmsStorageMonitor;

    invoke-virtual {v3, v7}, Lcom/android/internal/telephony/SmsStorageMonitor;->setStorageAvailableStatus(Z)V

    .line 2318
    .end local v0    # "mImsRegi":Ljava/lang/String;
    .end local v1    # "smsCdma":Lcom/android/internal/telephony/cdma/SmsMessage;
    .end local v2    # "teleService":I
    :cond_0
    :goto_0
    return-void

    .line 2303
    .restart local v0    # "mImsRegi":Ljava/lang/String;
    :cond_1
    const-string v3, "handleMessage(), IMS is registered!Ignore SMS CDG2 Test mode"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0

    .line 2306
    .end local v0    # "mImsRegi":Ljava/lang/String;
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleMessage(), KEY_SMS_OVER_LGIMS: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "sms_over_lgims"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2307
    iget-object v3, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mStorageMonitor:Lcom/android/internal/telephony/SmsStorageMonitor;

    invoke-virtual {v3, v6}, Lcom/android/internal/telephony/SmsStorageMonitor;->setStorageAvailableStatus(Z)V

    .line 2308
    iget-object v1, p1, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    check-cast v1, Lcom/android/internal/telephony/cdma/SmsMessage;

    .line 2309
    .restart local v1    # "smsCdma":Lcom/android/internal/telephony/cdma/SmsMessage;
    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/SmsMessage;->getTeleService()I

    move-result v2

    .line 2311
    .restart local v2    # "teleService":I
    if-ne v2, v9, :cond_0

    .line 2312
    invoke-direct {p0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->getSMSInboxMessageCount()I

    move-result v3

    if-lt v3, v8, :cond_0

    .line 2313
    iget-object v3, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mStorageMonitor:Lcom/android/internal/telephony/SmsStorageMonitor;

    invoke-virtual {v3, v7}, Lcom/android/internal/telephony/SmsStorageMonitor;->setStorageAvailableStatus(Z)V

    goto :goto_0
.end method

.method private handleConcatStitching(Lcom/android/internal/telephony/InboundSmsTracker;I[[BZZZLjava/lang/String;Landroid/telephony/SmsMessage;)Ljava/lang/String;
    .locals 3
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "messageCount"    # I
    .param p3, "pdus"    # [[B
    .param p4, "exceedFirstTimePeriod"    # Z
    .param p5, "exceedSecondTimePeriod"    # Z
    .param p6, "allSegmentReceived"    # Z
    .param p7, "missingSegIndex"    # Ljava/lang/String;
    .param p8, "stitchRefMsg"    # Landroid/telephony/SmsMessage;

    .prologue
    .line 2408
    if-eqz p4, :cond_2

    .line 2409
    new-instance p7, Ljava/lang/String;

    .end local p7    # "missingSegIndex":Ljava/lang/String;
    invoke-direct {p7}, Ljava/lang/String;-><init>()V

    .line 2410
    .restart local p7    # "missingSegIndex":Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, p2, :cond_2

    .line 2411
    aget-object v1, p3, v0

    if-eqz v1, :cond_1

    aget-object v1, p3, v0

    array-length v1, v1

    if-lez v1, :cond_1

    .line 2413
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "processMessagePart, [RED] fill pdu seg = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 2410
    :cond_0
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 2415
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "processMessagePart, [RED] fill missing seg= "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 2416
    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p7, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p7

    .line 2417
    const-string v1, ","

    invoke-virtual {p7, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p7

    .line 2418
    if-eqz p8, :cond_0

    .line 2419
    invoke-virtual {p8}, Landroid/telephony/SmsMessage;->getPdu()[B

    move-result-object v1

    aput-object v1, p3, v0

    .line 2420
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "processMessagePart, pdus["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] = stitchRefMsg.getPdu()"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    goto :goto_1

    .line 2425
    .end local v0    # "i":I
    :cond_2
    if-nez p6, :cond_4

    if-nez p4, :cond_3

    if-eqz p5, :cond_4

    .line 2426
    :cond_3
    const/4 v1, 0x1

    iput-boolean v1, p1, Lcom/android/internal/telephony/InboundSmsTracker;->isNeedToKeepDB:Z

    .line 2430
    :goto_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "processMessagePart, [RED] tracker.isNeedToKeepDB="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p1, Lcom/android/internal/telephony/InboundSmsTracker;->isNeedToKeepDB:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 2431
    return-object p7

    .line 2428
    :cond_4
    const/4 v1, 0x0

    iput-boolean v1, p1, Lcom/android/internal/telephony/InboundSmsTracker;->isNeedToKeepDB:Z

    goto :goto_2
.end method

.method private handleConcatStitching2(IZZZLjava/lang/String;Landroid/content/Intent;)V
    .locals 2
    .param p1, "messageCount"    # I
    .param p2, "exceedFirstTimePeriod"    # Z
    .param p3, "exceedSecondTimePeriod"    # Z
    .param p4, "allSegmentReceived"    # Z
    .param p5, "missingSegIndex"    # Ljava/lang/String;
    .param p6, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v1, 0x1

    .line 2436
    if-le p1, v1, :cond_0

    .line 2437
    if-nez p4, :cond_1

    if-eqz p2, :cond_1

    if-nez p3, :cond_1

    .line 2438
    const-string v0, "ctreplace"

    invoke-virtual {p6, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 2439
    if-eqz p5, :cond_0

    .line 2440
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "processMessagePart(), [RED] missingSegIndex = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2441
    const-string v0, "missingSegIndex"

    invoke-virtual {p6, v0, p5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 2447
    :cond_0
    :goto_0
    return-void

    .line 2444
    :cond_1
    const-string v0, "ctreplace"

    const/4 v1, 0x0

    invoke-virtual {p6, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    goto :goto_0
.end method

.method private handleEmsSegTimer(Lcom/android/internal/telephony/InboundSmsTracker;JZI)V
    .locals 26
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "firstTime"    # J
    .param p4, "isFirtMTconcat"    # Z
    .param p5, "mMessageCount"    # I

    .prologue
    .line 2546
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt] tracker.getMessageCount() = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, p5

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2547
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v2

    const/4 v3, 0x1

    if-eq v2, v3, :cond_0

    .line 2549
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v3, "concat_stitching"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 2550
    const/4 v2, 0x1

    move/from16 v0, p4

    if-ne v0, v2, :cond_0

    .line 2551
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    mul-int/lit8 v2, v2, 0x14

    mul-int/lit16 v2, v2, 0x3e8

    int-to-long v8, v2

    .line 2553
    .local v8, "dispatchTime":J
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "addTrackerToRawTable, [RED] create first timer. dispatchTime = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 2554
    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;

    move-object/from16 v4, p0

    move-object/from16 v5, p1

    move-wide/from16 v6, p2

    invoke-direct/range {v3 .. v9}, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;-><init>(Lcom/android/internal/telephony/InboundSmsHandlerEx;Lcom/android/internal/telephony/InboundSmsTracker;JJ)V

    invoke-direct {v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    .line 2579
    .end local v8    # "dispatchTime":J
    :cond_0
    :goto_0
    return-void

    .line 2561
    :cond_1
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v3, "concat_expired_time"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 2562
    const/4 v2, 0x1

    move/from16 v0, p4

    if-ne v0, v2, :cond_0

    .line 2563
    const-wide/32 v16, 0x5265c00

    .line 2564
    .local v16, "expiryTime":J
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "addTrackerToRawTable, [RED] CMCC create first timer. expiryTime = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-wide/from16 v0, v16

    invoke-virtual {v2, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 2565
    new-instance v2, Ljava/lang/Thread;

    new-instance v11, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;

    move-object/from16 v12, p0

    move-object/from16 v13, p1

    move-wide/from16 v14, p2

    invoke-direct/range {v11 .. v17}, Lcom/android/internal/telephony/InboundSmsHandlerEx$IncompleteConcatDispatchTimer;-><init>(Lcom/android/internal/telephony/InboundSmsHandlerEx;Lcom/android/internal/telephony/InboundSmsTracker;JJ)V

    invoke-direct {v2, v11}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    goto :goto_0

    .line 2571
    .end local v16    # "expiryTime":J
    :cond_2
    const-string v2, "[sms.mt] calls EMSSegmentExpirationRunnable"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2572
    new-instance v2, Ljava/lang/Thread;

    new-instance v19, Lcom/android/internal/telephony/InboundSmsHandlerEx$EMSSegmentExpirationRunnable;

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getAddress()Ljava/lang/String;

    move-result-object v21

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getReferenceNumber()I

    move-result v22

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v23

    move-object/from16 v20, p0

    move-wide/from16 v24, p2

    invoke-direct/range {v19 .. v25}, Lcom/android/internal/telephony/InboundSmsHandlerEx$EMSSegmentExpirationRunnable;-><init>(Lcom/android/internal/telephony/InboundSmsHandlerEx;Ljava/lang/String;IIJ)V

    move-object/from16 v0, v19

    invoke-direct {v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private handleMsgKRTestbed(IZ[[BLandroid/database/Cursor;I)I
    .locals 4
    .param p1, "destPort"    # I
    .param p2, "isCdmaWapPush"    # Z
    .param p3, "pdus"    # [[B
    .param p4, "cursor"    # Landroid/database/Cursor;
    .param p5, "cursorCount"    # I

    .prologue
    const/4 v3, 0x2

    .line 2660
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, p5, :cond_2

    .line 2661
    invoke-interface {p4}, Landroid/database/Cursor;->moveToNext()Z

    .line 2662
    const/4 v2, 0x1

    invoke-interface {p4, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v0

    .line 2664
    .local v0, "cursorSequence":I
    if-nez p2, :cond_0

    .line 2665
    add-int/lit8 v0, v0, -0x1

    .line 2667
    :cond_0
    const/4 v2, 0x0

    invoke-interface {p4, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/util/HexDump;->hexStringToByteArray(Ljava/lang/String;)[B

    move-result-object v2

    aput-object v2, p3, v0

    .line 2672
    if-nez v0, :cond_1

    invoke-interface {p4, v3}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_1

    .line 2673
    invoke-interface {p4, v3}, Landroid/database/Cursor;->getInt(I)I

    move-result p1

    .line 2660
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 2676
    .end local v0    # "cursorSequence":I
    :cond_2
    return p1
.end method

.method private static initOperatorMessagesMap()V
    .locals 3

    .prologue
    .line 1459
    sget-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mOperatorMessages:Ljava/util/HashMap;

    const-string v1, "specialMessage"

    const-string v2, "GsmSmsKRSpecialMessage"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1460
    sget-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mOperatorMessages:Ljava/util/HashMap;

    const-string v1, "SKTCommonPush"

    const-string v2, "GsmSmsSKTPortMessage"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1461
    sget-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mOperatorMessages:Ljava/util/HashMap;

    const-string v1, "SKTUrlCallback"

    const-string v2, "GsmSmsSKTUrlCallback"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1462
    sget-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mOperatorMessages:Ljava/util/HashMap;

    const-string v1, "KTPortMessage"

    const-string v2, "GsmSmsKTPortMessage"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1463
    sget-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mOperatorMessages:Ljava/util/HashMap;

    const-string v1, "KTUrlCallback"

    const-string v2, "GsmSmsKTUrlCallback"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1464
    sget-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mOperatorMessages:Ljava/util/HashMap;

    const-string v1, "lgu_gsm_operator_message"

    const-string v2, "GsmSmsLGUMessage"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1465
    return-void
.end method

.method private isDirectedToMailboxPro(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p1, "messageBody"    # Ljava/lang/String;
    .param p2, "originatingAddress"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .line 2585
    if-nez p1, :cond_1

    .line 2593
    :cond_0
    :goto_0
    return v0

    .line 2589
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "isDirectedToMailboxPro: messageBody: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "originatingAddress "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 2593
    const-string v1, "Mobilbox Pro"

    invoke-virtual {p1, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "3311"

    invoke-virtual {v1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method private isItSignedByVZW(Landroid/content/pm/PackageManager;Ljava/lang/String;)Z
    .locals 11
    .param p1, "pm"    # Landroid/content/pm/PackageManager;
    .param p2, "pkgName"    # Ljava/lang/String;

    .prologue
    const/4 v8, 0x0

    .line 1067
    const-string v9, "isItSignedByVZW(), Non-system app"

    invoke-static {v9}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1070
    const/16 v9, 0x40

    :try_start_0
    invoke-virtual {p1, p2, v9}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v7

    .line 1076
    .local v7, "pkgInfo":Landroid/content/pm/PackageInfo;
    if-nez v7, :cond_0

    .line 1100
    .end local v7    # "pkgInfo":Landroid/content/pm/PackageInfo;
    :goto_0
    return v8

    .line 1071
    :catch_0
    move-exception v3

    .line 1072
    .local v3, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "isItSignedByVZW(), Can\'t find applicaiton: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0

    .line 1081
    .end local v3    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    .restart local v7    # "pkgInfo":Landroid/content/pm/PackageInfo;
    :cond_0
    iget-object v1, v7, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    .line 1083
    .local v1, "appSignatures":[Landroid/content/pm/Signature;
    if-nez v1, :cond_1

    .line 1084
    const-string v9, "isItSignedByVZW(), Can\'t find signatures"

    invoke-static {v9}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    goto :goto_0

    .line 1088
    :cond_1
    move-object v2, v1

    .local v2, "arr$":[Landroid/content/pm/Signature;
    array-length v6, v2

    .local v6, "len$":I
    const/4 v5, 0x0

    .local v5, "i$":I
    :goto_1
    if-ge v5, v6, :cond_4

    aget-object v0, v2, v5

    .line 1089
    .local v0, "appSignature":Landroid/content/pm/Signature;
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "isItSignedByVZW(), application Signature : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v0}, Landroid/content/pm/Signature;->toCharsString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1090
    iget-object v9, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->VZWSignature:[Landroid/content/pm/Signature;

    if-eqz v9, :cond_3

    .line 1091
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_2
    iget-object v9, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->VZWSignature:[Landroid/content/pm/Signature;

    array-length v9, v9

    if-ge v4, v9, :cond_3

    .line 1092
    iget-object v9, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->VZWSignature:[Landroid/content/pm/Signature;

    aget-object v9, v9, v4

    invoke-virtual {v9, v0}, Landroid/content/pm/Signature;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_2

    .line 1093
    const-string v8, "isItSignedByVZW(), signature Match"

    invoke-static {v8}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1094
    const/4 v8, 0x1

    goto :goto_0

    .line 1091
    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 1088
    .end local v4    # "i":I
    :cond_3
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 1099
    .end local v0    # "appSignature":Landroid/content/pm/Signature;
    :cond_4
    const-string v9, "isItSignedByVZW(), not signature Match"

    invoke-static {v9}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    goto :goto_0
.end method

.method private isLowMemory(Landroid/database/sqlite/SQLiteException;)Z
    .locals 10
    .param p1, "e"    # Landroid/database/sqlite/SQLiteException;

    .prologue
    const/4 v5, 0x1

    .line 2069
    instance-of v6, p1, Landroid/database/sqlite/SQLiteFullException;

    if-eqz v6, :cond_1

    .line 2079
    :cond_0
    :goto_0
    return v5

    .line 2071
    :cond_1
    invoke-virtual {p1}, Landroid/database/sqlite/SQLiteException;->getMessage()Ljava/lang/String;

    move-result-object v6

    const-string v7, "no transaction is active"

    invoke-virtual {v6, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 2072
    new-instance v4, Landroid/os/StatFs;

    const-string v6, "/data"

    invoke-direct {v4, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 2073
    .local v4, "stat":Landroid/os/StatFs;
    invoke-virtual {v4}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v6

    int-to-long v0, v6

    .line 2074
    .local v0, "availBlocks":J
    invoke-virtual {v4}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v2, v6

    .line 2075
    .local v2, "blockSize":J
    mul-long v6, v0, v2

    const-wide/16 v8, 0x2000

    cmp-long v6, v6, v8

    if-ltz v6, :cond_0

    .line 2079
    .end local v0    # "availBlocks":J
    .end local v2    # "blockSize":J
    .end local v4    # "stat":Landroid/os/StatFs;
    :cond_2
    const/4 v5, 0x0

    goto :goto_0
.end method

.method private processDirectedSMS(Lcom/android/internal/telephony/InboundSmsTracker;I[[BLandroid/content/BroadcastReceiver;)I
    .locals 11
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "messageCount"    # I
    .param p3, "pdus"    # [[B
    .param p4, "resultReceiver"    # Landroid/content/BroadcastReceiver;

    .prologue
    .line 1289
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[sms.mt] processMessagePart messageCount =["

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1291
    const/4 v10, 0x0

    .line 1292
    .local v10, "msg":Landroid/telephony/SmsMessage;
    const-string v9, ""

    .line 1293
    .local v9, "messageBody":Ljava/lang/String;
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_0
    if-ge v8, p2, :cond_3

    .line 1294
    aget-object v2, p3, v8

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->is3gpp2()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "3gpp2"

    :goto_1
    invoke-static {v2, v0}, Landroid/telephony/SmsMessage;->createFromPdu([BLjava/lang/String;)Landroid/telephony/SmsMessage;

    move-result-object v10

    .line 1297
    if-nez v10, :cond_1

    .line 1293
    :goto_2
    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    .line 1294
    :cond_0
    const-string v0, "3gpp"

    goto :goto_1

    .line 1302
    :cond_1
    if-nez v8, :cond_2

    .line 1303
    invoke-virtual {v10}, Landroid/telephony/SmsMessage;->getMessageBody()Ljava/lang/String;

    move-result-object v9

    goto :goto_2

    .line 1305
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v10}, Landroid/telephony/SmsMessage;->getMessageBody()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    goto :goto_2

    .line 1310
    :cond_3
    if-nez v10, :cond_4

    .line 1311
    const-string v0, "[sms.mt] application directed sms null"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 1312
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 1313
    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    .line 1314
    const/4 v0, 0x2

    .line 1359
    :goto_3
    return v0

    .line 1318
    :cond_4
    iget-object v0, v10, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    iput-object v9, v0, Lcom/android/internal/telephony/SmsMessageBase;->mMessageBody:Ljava/lang/String;

    .line 1319
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[processMessagePart] msg.mWrappedSmsMessage.messageBody = "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, v10, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    iget-object v2, v2, Lcom/android/internal/telephony/SmsMessageBase;->mMessageBody:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 1322
    const/4 v7, -0x1

    .line 1323
    .local v7, "directedSmsStatus":I
    iget-object v0, v10, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    if-eqz v0, :cond_5

    .line 1324
    iget-object v0, v10, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    invoke-virtual {p0, v0, p4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->parseDirectedSMS(Lcom/android/internal/telephony/SmsMessageBase;Landroid/content/BroadcastReceiver;)I

    move-result v7

    .line 1327
    :cond_5
    const/4 v0, 0x1

    if-ne v0, v7, :cond_6

    .line 1328
    const-string v0, "[processMessagePart] return parseDirectedSMS = true"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 1329
    const-string v0, "[sms.mt] app directed sms has been processed."

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 1330
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 1331
    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    .line 1332
    const/4 v0, 0x1

    goto :goto_3

    .line 1333
    :cond_6
    if-nez v7, :cond_7

    .line 1334
    const-string v0, "[processMessagePart] Discard!! there is no application for Application Directed SMS"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 1335
    const-string v0, "[sms.mt] app directed sms has been discarded."

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 1336
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 1337
    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    .line 1338
    const/4 v0, 0x1

    goto :goto_3

    .line 1341
    :cond_7
    const/4 v0, -0x2

    if-ne v0, v7, :cond_8

    .line 1343
    new-instance v1, Landroid/content/Intent;

    const-string v0, "android.intent.action.DATA_SMS_RECEIVED"

    invoke-direct {v1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1344
    .local v1, "intent":Landroid/content/Intent;
    new-instance v6, Landroid/content/ComponentName;

    const-string v0, "com.lge.vzwsmsfilter"

    const-string v2, "com.lge.vzwsmsfilter.SmsFilterReceiver"

    invoke-direct {v6, v0, v2}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 1345
    .local v6, "componentName":Landroid/content/ComponentName;
    invoke-virtual {v1, v6}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 1346
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Delivering SMS to: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v6}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v6}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1348
    const-string v0, "pdus"

    invoke-virtual {v1, v0, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 1349
    const-string v0, "format"

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getFormat()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1350
    const-string v2, "android.permission.RECEIVE_SMS"

    const/16 v3, 0x10

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object v0, p0

    move-object v4, p4

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 1353
    const/4 v0, 0x1

    goto/16 :goto_3

    .line 1357
    .end local v1    # "intent":Landroid/content/Intent;
    .end local v6    # "componentName":Landroid/content/ComponentName;
    :cond_8
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[processMessagePart] directedSmsStatus = "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 1359
    const/16 v0, 0xb

    goto/16 :goto_3
.end method

.method private processLegacyVVM(Lcom/android/internal/telephony/InboundSmsTracker;I[[B)I
    .locals 7
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "messageCount"    # I
    .param p3, "pdus"    # [[B

    .prologue
    const/4 v5, 0x2

    .line 1365
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[sms.mt.legacyVVM] processLegacyVVM messageCount =["

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1367
    const/4 v3, 0x0

    .line 1368
    .local v3, "msg":Landroid/telephony/SmsMessage;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, p2, :cond_1

    .line 1369
    aget-object v6, p3, v0

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->is3gpp2()Z

    move-result v4

    if-eqz v4, :cond_0

    const-string v4, "3gpp2"

    :goto_1
    invoke-static {v6, v4}, Landroid/telephony/SmsMessage;->createFromPdu([BLjava/lang/String;)Landroid/telephony/SmsMessage;

    move-result-object v3

    .line 1368
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1369
    :cond_0
    const-string v4, "3gpp"

    goto :goto_1

    .line 1372
    :cond_1
    if-nez v3, :cond_2

    .line 1373
    const-string v4, "[sms.mt.legacyVVM] sms is null"

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 1374
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v4, v6}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 1375
    const/4 v4, 0x3

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    move v4, v5

    .line 1399
    :goto_2
    return v4

    .line 1379
    :cond_2
    const/4 v2, 0x0

    .line 1381
    .local v2, "legacyVoiceMailNumber":Ljava/lang/String;
    invoke-virtual {v3}, Landroid/telephony/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v2

    .line 1382
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[sms.mt.legacyVVM] processLegacyVVM legacyVoiceMailNumber is =["

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1384
    if-nez v2, :cond_3

    .line 1385
    const-string v4, "[sms.mt.legacyVVM] processLegacyVVM legacyVoiceMailNumber is null"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    move v4, v5

    .line 1386
    goto :goto_2

    .line 1389
    :cond_3
    const-string v4, "900080002021"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 1390
    const-string v4, "[sms.mt.legacyVVM] processLegacyVVM legacyVoiceMailNumber is 900080002021"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1392
    new-instance v1, Landroid/content/Intent;

    const-string v4, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v1, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1393
    .local v1, "intent":Landroid/content/Intent;
    const/4 v4, 0x0

    invoke-virtual {v1, v4}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 1394
    const-string v4, "pdus"

    invoke-virtual {v1, v4, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 1395
    const-string v4, "android.permission.RECEIVE_SMS"

    invoke-virtual {p0, v1, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchEx(Landroid/content/Intent;Ljava/lang/String;)V

    .line 1396
    const/4 v4, 0x1

    goto :goto_2

    .line 1399
    .end local v1    # "intent":Landroid/content/Intent;
    :cond_4
    const/16 v4, 0xb

    goto :goto_2
.end method

.method private processMobileboxProDirectedSMS(Lcom/android/internal/telephony/InboundSmsTracker;I[[BLandroid/content/BroadcastReceiver;)I
    .locals 11
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "messageCount"    # I
    .param p3, "pdus"    # [[B
    .param p4, "resultReceiver"    # Landroid/content/BroadcastReceiver;

    .prologue
    .line 2601
    const/4 v6, 0x0

    .line 2602
    .local v6, "bIsDTAG":Z
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getSimOperator()Ljava/lang/String;

    move-result-object v8

    .line 2604
    .local v8, "mccmnc":Ljava/lang/String;
    const-string v0, "26201"

    invoke-virtual {v0, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    .line 2606
    if-nez v6, :cond_0

    .line 2607
    const/16 v0, 0xb

    .line 2653
    :goto_0
    return v0

    .line 2610
    :cond_0
    const/4 v10, 0x0

    .line 2611
    .local v10, "msg":Landroid/telephony/SmsMessage;
    const-string v9, ""

    .line 2612
    .local v9, "messageBody":Ljava/lang/String;
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_1
    if-ge v7, p2, :cond_4

    .line 2613
    aget-object v2, p3, v7

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->is3gpp2()Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "3gpp2"

    :goto_2
    invoke-static {v2, v0}, Landroid/telephony/SmsMessage;->createFromPdu([BLjava/lang/String;)Landroid/telephony/SmsMessage;

    move-result-object v10

    .line 2615
    if-nez v10, :cond_2

    .line 2612
    :goto_3
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .line 2613
    :cond_1
    const-string v0, "3gpp"

    goto :goto_2

    .line 2619
    :cond_2
    if-nez v7, :cond_3

    .line 2620
    invoke-virtual {v10}, Landroid/telephony/SmsMessage;->getMessageBody()Ljava/lang/String;

    move-result-object v9

    goto :goto_3

    .line 2622
    :cond_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v10}, Landroid/telephony/SmsMessage;->getMessageBody()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    goto :goto_3

    .line 2626
    :cond_4
    if-nez v10, :cond_5

    .line 2627
    const-string v0, "[sms.mbp] application directed sms null"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 2628
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 2629
    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    .line 2630
    const/4 v0, 0x2

    goto :goto_0

    .line 2633
    :cond_5
    iget-object v0, v10, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    iput-object v9, v0, Lcom/android/internal/telephony/SmsMessageBase;->mMessageBody:Ljava/lang/String;

    .line 2637
    iget-object v0, v10, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    if-eqz v0, :cond_6

    .line 2638
    iget-object v0, v10, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/SmsMessageBase;->getMessageBody()Ljava/lang/String;

    move-result-object v0

    iget-object v2, v10, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/SmsMessageBase;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->isDirectedToMailboxPro(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 2639
    new-instance v1, Landroid/content/Intent;

    const-string v0, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 2641
    .local v1, "mMBPintent":Landroid/content/Intent;
    const-string v0, "de.telekom.mds.mbp"

    invoke-virtual {v1, v0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 2642
    const-string v0, "pdus"

    invoke-virtual {v1, v0, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 2644
    const-string v2, "android.permission.RECEIVE_SMS"

    const/16 v3, 0x10

    const/4 v4, 0x0

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 2647
    const-string v0, "[processMessagePart] return processMobileboxProDirectedSMS = true"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 2648
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 2649
    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    .line 2650
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 2653
    .end local v1    # "mMBPintent":Landroid/content/Intent;
    :cond_6
    const/16 v0, 0xb

    goto/16 :goto_0
.end method

.method private seperateSmsUicc(Lcom/android/internal/telephony/SmsMessageBase;Lcom/android/internal/telephony/SmsHeader;)Lcom/android/internal/telephony/InboundSmsTracker;
    .locals 16
    .param p1, "sms"    # Lcom/android/internal/telephony/SmsMessageBase;
    .param p2, "smsHeader"    # Lcom/android/internal/telephony/SmsHeader;

    .prologue
    .line 2385
    move-object/from16 v0, p2

    iget-object v14, v0, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    .line 2386
    .local v14, "concatRef":Lcom/android/internal/telephony/SmsHeader$ConcatRef;
    move-object/from16 v0, p2

    iget-object v15, v0, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    .line 2387
    .local v15, "portAddrs":Lcom/android/internal/telephony/SmsHeader$PortAddrs;
    if-eqz v15, :cond_0

    iget v6, v15, Lcom/android/internal/telephony/SmsHeader$PortAddrs;->destPort:I

    .line 2395
    .local v6, "destPort":I
    :goto_0
    new-instance v2, Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/SmsMessageBase;->getPdu()[B

    move-result-object v3

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/SmsMessageBase;->getTimestampMillis()J

    move-result-wide v4

    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->is3gpp2()Z

    move-result v7

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/SmsMessageBase;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v8

    iget v9, v14, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->refNumber:I

    iget v10, v14, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->seqNumber:I

    iget v11, v14, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->msgCount:I

    const/4 v12, 0x0

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/SmsMessageBase;->getIndexOnIcc()I

    move-result v13

    invoke-direct/range {v2 .. v13}, Lcom/android/internal/telephony/InboundSmsTracker;-><init>([BJIZLjava/lang/String;IIIZI)V

    .line 2399
    .local v2, "tracker":Lcom/android/internal/telephony/InboundSmsTracker;
    return-object v2

    .line 2387
    .end local v2    # "tracker":Lcom/android/internal/telephony/InboundSmsTracker;
    .end local v6    # "destPort":I
    :cond_0
    const/4 v6, -0x1

    goto :goto_0
.end method

.method private storeMsgInDB(ILjava/lang/Long;Ljava/lang/String;Ljava/lang/String;)Landroid/content/ContentValues;
    .locals 6
    .param p1, "messageId"    # I
    .param p2, "sent_date"    # Ljava/lang/Long;
    .param p3, "addr"    # Ljava/lang/String;
    .param p4, "body"    # Ljava/lang/String;

    .prologue
    .line 2510
    new-instance v0, Landroid/content/ContentValues;

    invoke-direct {v0}, Landroid/content/ContentValues;-><init>()V

    .line 2511
    .local v0, "vals":Landroid/content/ContentValues;
    const-string v1, "address"

    invoke-virtual {v0, v1, p3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 2512
    const-string v1, "date_sent"

    new-instance v2, Ljava/lang/Long;

    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    invoke-direct {v2, v4, v5}, Ljava/lang/Long;-><init>(J)V

    invoke-virtual {v0, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    .line 2513
    const-string v1, "body"

    invoke-virtual {v0, v1, p4}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 2514
    const-string v1, "person"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 2515
    const-string v1, "thread_id"

    const/4 v2, -0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 2516
    const-string v1, "read"

    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 2517
    return-object v0
.end method

.method private supportWifiOffEmergency(Lcom/android/internal/telephony/SmsMessageBase;)V
    .locals 5
    .param p1, "sms"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    .line 2323
    instance-of v3, p1, Lcom/android/internal/telephony/cdma/SmsMessage;

    if-eqz v3, :cond_1

    .line 2324
    const-string v3, "dispatchNormalMessage(), [KDDI] WIFI OFF SmsMessage is cdma instance "

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    move-object v2, p1

    .line 2325
    check-cast v2, Lcom/android/internal/telephony/cdma/SmsMessage;

    .line 2326
    .local v2, "wifi_off_sms":Lcom/android/internal/telephony/cdma/SmsMessage;
    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/SmsMessage;->getSmsEnvelope()Lcom/android/internal/telephony/cdma/sms/SmsEnvelope;

    move-result-object v3

    iget v1, v3, Lcom/android/internal/telephony/cdma/sms/SmsEnvelope;->serviceCategory:I

    .line 2327
    .local v1, "serviceCategory":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "dispatchNormalMessage(), [KDDI] Service category is : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2328
    const/4 v3, 0x1

    if-eq v1, v3, :cond_0

    const/16 v3, 0x26

    if-eq v1, v3, :cond_0

    const/16 v3, 0x28

    if-ne v1, v3, :cond_1

    .line 2329
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "dispatchNormalMessage(), [KDDI] Service category  "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " broadcast to WIFI!! "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2330
    new-instance v0, Landroid/content/Intent;

    const-string v3, "android.intent.action.SMS_WIFI_OFF"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 2331
    .local v0, "intent":Landroid/content/Intent;
    const/4 v3, 0x0

    invoke-virtual {p0, v0, v3}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchEx(Landroid/content/Intent;Ljava/lang/String;)V

    .line 2334
    .end local v0    # "intent":Landroid/content/Intent;
    .end local v1    # "serviceCategory":I
    .end local v2    # "wifi_off_sms":Lcom/android/internal/telephony/cdma/SmsMessage;
    :cond_1
    return-void
.end method


# virtual methods
.method protected abstract acknowledgeLastIncomingSms(ZILandroid/os/Message;)V
.end method

.method addTrackerToRawTable(Lcom/android/internal/telephony/InboundSmsTracker;)I
    .locals 32
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;

    .prologue
    .line 794
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getContentValues()Landroid/content/ContentValues;

    move-result-object v31

    .line 795
    .local v31, "values":Landroid/content/ContentValues;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v12

    .line 799
    .local v12, "firstTime":J
    const/4 v14, 0x0

    .line 802
    .local v14, "isFirtMTconcat":Z
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v4

    const/4 v5, 0x1

    if-eq v4, v5, :cond_7

    .line 804
    const/16 v18, 0x0

    .line 807
    .local v18, "cursor":Landroid/database/Cursor;
    :try_start_0
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getSequenceNumber()I

    move-result v29

    .line 810
    .local v29, "sequence":I
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getAddress()Ljava/lang/String;

    move-result-object v16

    .line 811
    .local v16, "address":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getReferenceNumber()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v25

    .line 812
    .local v25, "refNumber":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v17

    .line 814
    .local v17, "count":Ljava/lang/String;
    invoke-static/range {v29 .. v29}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v28

    .line 817
    .local v28, "seqNumber":Ljava/lang/String;
    const/4 v4, 0x3

    new-array v0, v4, [Ljava/lang/String;

    move-object/from16 v19, v0

    const/4 v4, 0x0

    aput-object v16, v19, v4

    const/4 v4, 0x1

    aput-object v25, v19, v4

    const/4 v4, 0x2

    aput-object v17, v19, v4

    .line 818
    .local v19, "deleteWhereArgs":[Ljava/lang/String;
    const-string v4, "address=? AND reference_number=? AND count=?"

    move-object/from16 v0, p1

    move-object/from16 v1, v19

    invoke-virtual {v0, v4, v1}, Lcom/android/internal/telephony/InboundSmsTracker;->setDeleteWhere(Ljava/lang/String;[Ljava/lang/String;)V

    .line 822
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "ConcatMTCheckTimestamp_kddi"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 823
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v25

    invoke-direct {v0, v1, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->checkKDDIConcatTimeStamp(Lcom/android/internal/telephony/InboundSmsTracker;Ljava/lang/String;)V

    .line 829
    :cond_0
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "ConcatMTCheckTimestamp"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 830
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v16

    move-object/from16 v3, v25

    invoke-direct {v0, v1, v2, v3}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->checkKRConcatTimeStamp(Lcom/android/internal/telephony/InboundSmsTracker;Ljava/lang/String;Ljava/lang/String;)V

    .line 835
    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sRawUri:Landroid/net/Uri;

    sget-object v6, Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_PROJECTION:[Ljava/lang/String;

    const-string v7, "address=? AND reference_number=? AND count=? AND sequence=?"

    const/4 v9, 0x4

    new-array v8, v9, [Ljava/lang/String;

    const/4 v9, 0x0

    aput-object v16, v8, v9

    const/4 v9, 0x1

    aput-object v25, v8, v9

    const/4 v9, 0x2

    aput-object v17, v8, v9

    const/4 v9, 0x3

    aput-object v28, v8, v9

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v18

    .line 840
    invoke-interface/range {v18 .. v18}, Landroid/database/Cursor;->moveToNext()Z

    move-result v4

    if-eqz v4, :cond_4

    .line 841
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Discarding duplicate message segment, refNumber="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, v25

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " seqNumber="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, v28

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->loge(Ljava/lang/String;)V

    .line 843
    const/4 v4, 0x0

    move-object/from16 v0, v18

    invoke-interface {v0, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v23

    .line 844
    .local v23, "oldPduString":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getPdu()[B

    move-result-object v24

    .line 845
    .local v24, "pdu":[B
    invoke-static/range {v23 .. v23}, Lcom/android/internal/util/HexDump;->hexStringToByteArray(Ljava/lang/String;)[B

    move-result-object v22

    .line 846
    .local v22, "oldPdu":[B
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getPdu()[B

    move-result-object v4

    move-object/from16 v0, v22

    invoke-static {v0, v4}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v4

    if-nez v4, :cond_2

    .line 847
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Warning: dup message segment PDU of length "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, v24

    array-length v5, v0

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " is different from existing PDU of length "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, v22

    array-length v5, v0

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->loge(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/database/SQLException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 850
    :cond_2
    const/4 v4, 0x5

    .line 884
    if-eqz v18, :cond_3

    .line 885
    invoke-interface/range {v18 .. v18}, Landroid/database/Cursor;->close()V

    .line 910
    .end local v16    # "address":Ljava/lang/String;
    .end local v17    # "count":Ljava/lang/String;
    .end local v18    # "cursor":Landroid/database/Cursor;
    .end local v19    # "deleteWhereArgs":[Ljava/lang/String;
    .end local v22    # "oldPdu":[B
    .end local v23    # "oldPduString":Ljava/lang/String;
    .end local v24    # "pdu":[B
    .end local v25    # "refNumber":Ljava/lang/String;
    .end local v28    # "seqNumber":Ljava/lang/String;
    .end local v29    # "sequence":I
    :cond_3
    :goto_0
    return v4

    .line 852
    .restart local v16    # "address":Ljava/lang/String;
    .restart local v17    # "count":Ljava/lang/String;
    .restart local v18    # "cursor":Landroid/database/Cursor;
    .restart local v19    # "deleteWhereArgs":[Ljava/lang/String;
    .restart local v25    # "refNumber":Ljava/lang/String;
    .restart local v28    # "seqNumber":Ljava/lang/String;
    .restart local v29    # "sequence":I
    :cond_4
    :try_start_1
    invoke-interface/range {v18 .. v18}, Landroid/database/Cursor;->close()V

    .line 854
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "ems_segment_timer"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 857
    const/4 v4, 0x3

    new-array v8, v4, [Ljava/lang/String;

    const/4 v4, 0x0

    aput-object v16, v8, v4

    const/4 v4, 0x1

    aput-object v25, v8, v4

    const/4 v4, 0x2

    aput-object v17, v8, v4

    .line 858
    .local v8, "whereArgs":[Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "addTrackerToRawTable, [RED] refNumber = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, v25

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 860
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sRawUri:Landroid/net/Uri;

    sget-object v6, Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_SEQUENCE_PORT_ICC_TIME_PROJECTION:[Ljava/lang/String;

    const-string v7, "address=? AND reference_number=? AND count=?"

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v18

    .line 863
    if-eqz v18, :cond_a

    invoke-interface/range {v18 .. v18}, Landroid/database/Cursor;->getCount()I

    move-result v4

    if-lez v4, :cond_a

    .line 864
    invoke-interface/range {v18 .. v18}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v4

    if-eqz v4, :cond_5

    .line 865
    const-string v4, "time"

    move-object/from16 v0, v18

    invoke-interface {v0, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v30

    .line 866
    .local v30, "timeColumn":I
    move-object/from16 v0, v18

    move/from16 v1, v30

    invoke-interface {v0, v1}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v12

    .line 868
    .end local v30    # "timeColumn":I
    :cond_5
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "addTrackerToRawTable, [RED] NOT new mt seg firstTime = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 877
    :goto_1
    const-string v4, "time"

    new-instance v5, Ljava/lang/Long;

    invoke-direct {v5, v12, v13}, Ljava/lang/Long;-><init>(J)V

    move-object/from16 v0, v31

    invoke-virtual {v0, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V
    :try_end_1
    .catch Landroid/database/SQLException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 884
    .end local v8    # "whereArgs":[Ljava/lang/String;
    :cond_6
    if-eqz v18, :cond_7

    .line 885
    invoke-interface/range {v18 .. v18}, Landroid/database/Cursor;->close()V

    .line 891
    .end local v16    # "address":Ljava/lang/String;
    .end local v17    # "count":Ljava/lang/String;
    .end local v18    # "cursor":Landroid/database/Cursor;
    .end local v19    # "deleteWhereArgs":[Ljava/lang/String;
    .end local v25    # "refNumber":Ljava/lang/String;
    .end local v28    # "seqNumber":Ljava/lang/String;
    .end local v29    # "sequence":I
    :cond_7
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sRawUri:Landroid/net/Uri;

    move-object/from16 v0, v31

    invoke-virtual {v4, v5, v0}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v21

    .line 892
    .local v21, "newUri":Landroid/net/Uri;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "URI of new row -> "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 894
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v15

    .line 897
    .local v15, "mMessageCount":I
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "ems_segment_timer"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_8

    move-object/from16 v10, p0

    move-object/from16 v11, p1

    .line 898
    invoke-direct/range {v10 .. v15}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->handleEmsSegTimer(Lcom/android/internal/telephony/InboundSmsTracker;JZI)V

    .line 902
    :cond_8
    :try_start_2
    invoke-static/range {v21 .. v21}, Landroid/content/ContentUris;->parseId(Landroid/net/Uri;)J

    move-result-wide v26

    .line 903
    .local v26, "rowId":J
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_9

    .line 905
    const-string v4, "_id=?"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/String;

    const/4 v6, 0x0

    invoke-static/range {v26 .. v27}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v6

    move-object/from16 v0, p1

    invoke-virtual {v0, v4, v5}, Lcom/android/internal/telephony/InboundSmsTracker;->setDeleteWhere(Ljava/lang/String;[Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 907
    :cond_9
    const/4 v4, 0x1

    goto/16 :goto_0

    .line 873
    .end local v15    # "mMessageCount":I
    .end local v21    # "newUri":Landroid/net/Uri;
    .end local v26    # "rowId":J
    .restart local v8    # "whereArgs":[Ljava/lang/String;
    .restart local v16    # "address":Ljava/lang/String;
    .restart local v17    # "count":Ljava/lang/String;
    .restart local v18    # "cursor":Landroid/database/Cursor;
    .restart local v19    # "deleteWhereArgs":[Ljava/lang/String;
    .restart local v25    # "refNumber":Ljava/lang/String;
    .restart local v28    # "seqNumber":Ljava/lang/String;
    .restart local v29    # "sequence":I
    :cond_a
    const/4 v14, 0x1

    .line 874
    :try_start_3
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "addTrackerToRawTable, [RED] new mt seg. firstTime = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I
    :try_end_3
    .catch Landroid/database/SQLException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto/16 :goto_1

    .line 880
    .end local v8    # "whereArgs":[Ljava/lang/String;
    .end local v16    # "address":Ljava/lang/String;
    .end local v17    # "count":Ljava/lang/String;
    .end local v19    # "deleteWhereArgs":[Ljava/lang/String;
    .end local v25    # "refNumber":Ljava/lang/String;
    .end local v28    # "seqNumber":Ljava/lang/String;
    .end local v29    # "sequence":I
    :catch_0
    move-exception v20

    .line 881
    .local v20, "e":Landroid/database/SQLException;
    :try_start_4
    const-string v4, "Can\'t access multipart SMS database"

    move-object/from16 v0, p0

    move-object/from16 v1, v20

    invoke-virtual {v0, v4, v1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->loge(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 882
    const/4 v4, 0x2

    .line 884
    if-eqz v18, :cond_3

    .line 885
    invoke-interface/range {v18 .. v18}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 884
    .end local v20    # "e":Landroid/database/SQLException;
    :catchall_0
    move-exception v4

    if-eqz v18, :cond_b

    .line 885
    invoke-interface/range {v18 .. v18}, Landroid/database/Cursor;->close()V

    :cond_b
    throw v4

    .line 908
    .end local v18    # "cursor":Landroid/database/Cursor;
    .restart local v15    # "mMessageCount":I
    .restart local v21    # "newUri":Landroid/net/Uri;
    :catch_1
    move-exception v20

    .line 909
    .local v20, "e":Ljava/lang/Exception;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "error parsing URI for new row: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    move-object/from16 v1, v20

    invoke-virtual {v0, v4, v1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->loge(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 910
    const/4 v4, 0x2

    goto/16 :goto_0
.end method

.method public checkDuplicateKddiMessage(ILjava/lang/Long;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 12
    .param p1, "messageId"    # I
    .param p2, "sent_date"    # Ljava/lang/Long;
    .param p3, "addr"    # Ljava/lang/String;
    .param p4, "body"    # Ljava/lang/String;

    .prologue
    .line 2003
    const/4 v8, 0x0

    .line 2005
    .local v8, "isDuplicated":Z
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "checkDuplicateKddiMessage(), [KDDI] check duplicate ? : originAddr: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "// timeStamp: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " // Message ID : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2009
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v1, Landroid/provider/Telephony$Sms$Inbox;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lcom/android/internal/telephony/InboundSmsHandlerEx;->DUPLICATE_PROJECTION:[Ljava/lang/String;

    const-string v3, "address = ? AND date_sent = ? "

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    aput-object p3, v4, v5

    const/4 v5, 0x1

    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide v10

    invoke-static {v10, v11}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v4, v5

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 2013
    .local v6, "cursor":Landroid/database/Cursor;
    if-nez v6, :cond_0

    .line 2014
    const-string v0, "checkDuplicateKddiMessage(), [KDDI] Duplicate Error"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 2015
    const/4 v8, 0x0

    move v0, v8

    .line 2061
    :goto_0
    return v0

    .line 2019
    :cond_0
    invoke-direct {p0, v6}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->checkDuplicateMsg(Landroid/database/Cursor;)Z

    move-result v8

    .line 2021
    if-eqz v6, :cond_1

    .line 2022
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    .line 2025
    :cond_1
    invoke-direct/range {p0 .. p4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->storeMsgInDB(ILjava/lang/Long;Ljava/lang/String;Ljava/lang/String;)Landroid/content/ContentValues;

    move-result-object v9

    .line 2028
    .local v9, "vals":Landroid/content/ContentValues;
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v1, Landroid/provider/Telephony$Sms$Inbox;->CONTENT_URI:Landroid/net/Uri;

    const/4 v2, 0x0

    const-string v3, "thread_id = ? "

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    const/4 v10, -0x1

    invoke-static {v10}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v4, v5

    const-string v5, "date_sent asc"

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 2031
    if-nez v6, :cond_2

    .line 2032
    const-string v0, "checkDuplicateKddiMessage(), [KDDI] Duplicate.. Delete Error"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 2033
    const/4 v8, 0x0

    move v0, v8

    .line 2034
    goto :goto_0

    .line 2037
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "checkDuplicateKddiMessage(), [KDDI] getCount(), before delete the Message "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-interface {v6}, Landroid/database/Cursor;->getCount()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 2039
    invoke-direct {p0, v6}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteDuplicateSMSKDDI(Landroid/database/Cursor;)Z

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_3

    .line 2040
    const/4 v0, 0x0

    goto :goto_0

    .line 2042
    :cond_3
    if-eqz v6, :cond_4

    .line 2043
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    .line 2047
    :cond_4
    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v1, Landroid/provider/Telephony$Sms$Inbox;->CONTENT_URI:Landroid/net/Uri;

    invoke-virtual {v0, v1, v9}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    :try_end_0
    .catch Landroid/database/sqlite/SQLiteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2059
    :cond_5
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "checkDuplicateKddiMessage(), [KDDI] is duplicate Message? : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->i(Ljava/lang/String;)I

    move v0, v8

    .line 2061
    goto :goto_0

    .line 2048
    :catch_0
    move-exception v7

    .line 2049
    .local v7, "e":Landroid/database/sqlite/SQLiteException;
    :try_start_1
    invoke-direct {p0, v7}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->isLowMemory(Landroid/database/sqlite/SQLiteException;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 2050
    const-string v0, "checkDuplicateKddiMessage(), [KDDI] Can\'t access duplicate SMS database"

    invoke-static {v0, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2051
    const/4 v0, 0x0

    goto/16 :goto_0

    .line 2053
    .end local v7    # "e":Landroid/database/sqlite/SQLiteException;
    :catch_1
    move-exception v7

    .line 2054
    .local v7, "e":Ljava/lang/IllegalArgumentException;
    const-string v0, "checkDuplicateKddiMessage(), [KDDI] Fail to duplicate SMS"

    invoke-static {v0, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2055
    const/4 v0, 0x0

    goto/16 :goto_0

    .line 2056
    .end local v7    # "e":Ljava/lang/IllegalArgumentException;
    :catchall_0
    move-exception v0

    throw v0
.end method

.method protected dispatchDirectedSms(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/BroadcastReceiver;)V
    .locals 6
    .param p1, "packageName"    # Ljava/lang/String;
    .param p2, "parameters"    # Ljava/lang/String;
    .param p3, "originatingAddress"    # Ljava/lang/String;
    .param p4, "applicationPrefix"    # Ljava/lang/String;
    .param p5, "receiver"    # Landroid/content/BroadcastReceiver;

    .prologue
    .line 1006
    new-instance v1, Landroid/content/Intent;

    const-string v0, "verizon.intent.action.DIRECTED_SMS_RECEIVED"

    invoke-direct {v1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1007
    .local v1, "intent":Landroid/content/Intent;
    invoke-virtual {v1, p1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 1008
    const-string v0, "parameters"

    invoke-virtual {v1, v0, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1010
    const-string v0, "originator"

    invoke-virtual {v1, v0, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1012
    const-string v0, "prefix"

    invoke-virtual {v1, v0, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1013
    const-string v2, "android.permission.RECEIVE_SMS"

    const/16 v3, 0x10

    const/4 v4, 0x0

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 1015
    return-void
.end method

.method protected dispatchDirectedVVM([[B)V
    .locals 7
    .param p1, "pdus"    # [[B

    .prologue
    .line 1938
    new-instance v1, Landroid/content/Intent;

    const-string v0, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1940
    .local v1, "intent":Landroid/content/Intent;
    const-string v6, "3gpp2"

    .line 1941
    .local v6, "strFormat":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->is3gpp2()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1942
    const-string v6, "3gpp"

    .line 1944
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "dispatchDirectedVVM(), strFormat : "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1946
    const-string v0, "com.coremobility.app.vnotes"

    invoke-virtual {v1, v0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 1947
    const-string v0, "pdus"

    invoke-virtual {v1, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 1948
    const-string v0, "format"

    invoke-virtual {v1, v0, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1949
    const-string v2, "android.permission.RECEIVE_SMS"

    const/16 v3, 0x10

    const/4 v4, 0x0

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 1951
    return-void
.end method

.method public dispatchEx(Landroid/content/Intent;Ljava/lang/String;)V
    .locals 6
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "permission"    # Ljava/lang/String;

    .prologue
    .line 1562
    const/16 v3, 0x10

    const/4 v4, 0x0

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 1563
    return-void
.end method

.method public dispatchEx(Landroid/content/Intent;Ljava/lang/String;Landroid/content/BroadcastReceiver;)V
    .locals 6
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "permission"    # Ljava/lang/String;
    .param p3, "receiver"    # Landroid/content/BroadcastReceiver;

    .prologue
    .line 1567
    const-string v1, "format"

    move-object v0, p3

    check-cast v0, Lcom/android/internal/telephony/InboundSmsHandler$SmsBroadcastReceiver;

    invoke-virtual {v0}, Lcom/android/internal/telephony/InboundSmsHandler$SmsBroadcastReceiver;->getFormat()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1570
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->setDeliverIntentIfNeeded(Landroid/content/Intent;)V

    .line 1572
    const/16 v3, 0x10

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, p3

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 1573
    return-void
.end method

.method public dispatchMessage(Lcom/android/internal/telephony/SmsMessageBase;)I
    .locals 3
    .param p1, "smsb"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    const/4 v1, 0x2

    .line 294
    const-string v2, "[sms.mt] dispatchMessage start ["

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 296
    if-nez p1, :cond_0

    .line 297
    const-string v2, "dispatchSmsMessage: message is null"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->loge(Ljava/lang/String;)V

    .line 314
    :goto_0
    return v1

    .line 301
    :cond_0
    iget-boolean v2, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mSmsReceiveDisabled:Z

    if-eqz v2, :cond_1

    .line 303
    const-string v1, "Received short message on device which doesn\'t support receiving SMS. Ignored."

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 305
    const/4 v1, 0x1

    goto :goto_0

    .line 308
    :cond_1
    const-string v2, "vold.decrypt"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 309
    .local v0, "cryptState":Ljava/lang/String;
    const-string v2, "trigger_restart_min_framework"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 310
    const-string v2, "Detected encryption in progress - only parsing core apps"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0

    .line 314
    :cond_2
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchMessageRadioSpecific(Lcom/android/internal/telephony/SmsMessageBase;)I

    move-result v1

    goto :goto_0
.end method

.method protected abstract dispatchMessageRadioSpecific(Lcom/android/internal/telephony/SmsMessageBase;)I
.end method

.method protected dispatchNormalMessage(Lcom/android/internal/telephony/SmsMessageBase;)I
    .locals 11
    .param p1, "sms"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    const/4 v5, 0x0

    const/4 v3, 0x1

    .line 328
    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v10

    .line 331
    .local v10, "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    const-string v1, "[sms.mt] dispatchNormalMessage start ["

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 332
    if-eqz v10, :cond_0

    iget-object v1, v10, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    if-nez v1, :cond_7

    .line 334
    :cond_0
    const/4 v4, -0x1

    .line 335
    .local v4, "destPort":I
    if-eqz v10, :cond_3

    iget-object v1, v10, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    if-eqz v1, :cond_3

    .line 337
    iget-object v1, v10, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    iget v4, v1, Lcom/android/internal/telephony/SmsHeader$PortAddrs;->destPort:I

    .line 338
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "destination port: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 379
    :cond_1
    new-instance v0, Lcom/android/internal/telephony/InboundSmsTracker;

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getPdu()[B

    move-result-object v1

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getTimestampMillis()J

    move-result-wide v2

    invoke-virtual {p0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->is3gpp2()Z

    move-result v5

    const/4 v6, 0x0

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getIndexOnIcc()I

    move-result v7

    invoke-direct/range {v0 .. v7}, Lcom/android/internal/telephony/InboundSmsTracker;-><init>([BJIZZI)V

    .line 387
    .end local v4    # "destPort":I
    .local v0, "tracker":Lcom/android/internal/telephony/InboundSmsTracker;
    :goto_0
    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->addTrackerToRawTableAndSendMessage(Lcom/android/internal/telephony/InboundSmsTracker;)I

    move-result v8

    .end local v0    # "tracker":Lcom/android/internal/telephony/InboundSmsTracker;
    :cond_2
    :goto_1
    return v8

    .line 342
    .restart local v4    # "destPort":I
    :cond_3
    const-string v1, "wifi_off_emergency_received"

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-ne v1, v3, :cond_4

    .line 343
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->supportWifiOffEmergency(Lcom/android/internal/telephony/SmsMessageBase;)V

    .line 348
    :cond_4
    iget-object v1, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v2, "support_sprint_vvm"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    const-string v1, "1"

    const-string v2, "ro.chameleon.vvm"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 350
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->parseDirectedVVM(Lcom/android/internal/telephony/SmsMessageBase;)I

    move-result v8

    .line 351
    .local v8, "directedVvmApp":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "dispatchNormalMessage(), directedVvmApp result = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 352
    if-eq v8, v3, :cond_2

    .line 359
    .end local v8    # "directedVvmApp":I
    :cond_5
    iget-object v1, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v2, "sprint_reassembly_sms"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 360
    iget-object v1, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sprintReassemblySms:Lcom/android/internal/telephony/LGSprintReassemblySms;

    invoke-virtual {v1, p1}, Lcom/android/internal/telephony/LGSprintReassemblySms;->supportSmsReassembly(Lcom/android/internal/telephony/SmsMessageBase;)I

    move-result v9

    .line 361
    .local v9, "result":I
    const/16 v1, 0xb

    if-eq v9, v1, :cond_6

    move v8, v9

    .line 362
    goto :goto_1

    .line 367
    .end local v9    # "result":I
    :cond_6
    const-string v1, "kddi_message_duplicate_check"

    invoke-static {v5, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-ne v1, v3, :cond_1

    .line 369
    invoke-direct {p0, p1, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->checkKDDIDuplicateMsg(Lcom/android/internal/telephony/SmsMessageBase;I)I

    move-result v8

    goto :goto_1

    .line 383
    .end local v4    # "destPort":I
    :cond_7
    invoke-direct {p0, p1, v10}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->seperateSmsUicc(Lcom/android/internal/telephony/SmsMessageBase;Lcom/android/internal/telephony/SmsHeader;)Lcom/android/internal/telephony/InboundSmsTracker;

    move-result-object v0

    .restart local v0    # "tracker":Lcom/android/internal/telephony/InboundSmsTracker;
    goto :goto_0
.end method

.method protected dispatchOperatorMessage(Lcom/android/internal/telephony/InboundSmsTracker;Lcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;)I
    .locals 10
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "sms"    # Lcom/android/internal/telephony/SmsMessageBase;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/android/internal/telephony/InboundSmsTracker;",
            "Lcom/android/internal/telephony/SmsMessageBase;",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/telephony/SmsOperatorBasicMessage;",
            ">;)I"
        }
    .end annotation

    .prologue
    .local p3, "operatorMessageList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/telephony/SmsOperatorBasicMessage;>;"
    const/4 v9, 0x3

    const/4 v6, 0x1

    .line 1496
    const-string v7, "dispatchOperatorMessage"

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1497
    if-nez p2, :cond_1

    .line 1498
    const-string v6, "dispatchOperatorMessage sms null"

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1499
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v6, v7}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 1500
    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    .line 1501
    const/4 v6, 0x2

    .line 1558
    :cond_0
    :goto_0
    return v6

    .line 1504
    :cond_1
    invoke-virtual {p3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_5

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lge/telephony/SmsOperatorBasicMessage;

    .line 1505
    .local v2, "operatorMessage":Lcom/lge/telephony/SmsOperatorBasicMessage;
    if-eqz v2, :cond_2

    .line 1508
    invoke-interface {v2}, Lcom/lge/telephony/SmsOperatorBasicMessage;->getInformation()Landroid/os/Bundle;

    move-result-object v5

    .line 1509
    .local v5, "value":Landroid/os/Bundle;
    if-eqz v5, :cond_2

    .line 1512
    const-string v7, "valid"

    invoke-virtual {v5, v7}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v7

    if-ne v7, v6, :cond_4

    .line 1513
    invoke-interface {v2, p0}, Lcom/lge/telephony/SmsOperatorBasicMessage;->dispatch(Lcom/android/internal/telephony/InboundSmsHandler;)I

    move-result v0

    .line 1514
    .local v0, "dispatchResult":I
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "dispatchResult = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1515
    if-eqz v0, :cond_2

    .line 1517
    if-ne v0, v6, :cond_3

    .line 1518
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v7, v8}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 1519
    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    goto :goto_0

    .line 1523
    :cond_3
    invoke-virtual {p2}, Lcom/android/internal/telephony/SmsMessageBase;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v4

    .line 1524
    .local v4, "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    if-eqz v4, :cond_0

    iget-object v7, v4, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    if-eqz v7, :cond_0

    iget-object v7, v4, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    iget v7, v7, Lcom/android/internal/telephony/SmsHeader$PortAddrs;->destPort:I

    const v8, 0xf180

    if-ne v7, v8, :cond_0

    .line 1525
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v7, v8}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 1526
    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    goto :goto_0

    .line 1532
    .end local v0    # "dispatchResult":I
    .end local v4    # "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    :cond_4
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "dispatchOperatorMessage OPERATE_MESSAGE_VALID: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "valid"

    invoke-virtual {v5, v8}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1533
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v7, v8}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 1534
    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    goto/16 :goto_0

    .line 1544
    .end local v2    # "operatorMessage":Lcom/lge/telephony/SmsOperatorBasicMessage;
    .end local v5    # "value":Landroid/os/Bundle;
    :cond_5
    invoke-virtual {p2}, Lcom/android/internal/telephony/SmsMessageBase;->getProtocolIdentifier()I

    move-result v7

    and-int/lit16 v3, v7, 0xff

    .line 1545
    .local v3, "pid_byte":I
    const/16 v7, 0x49

    if-lt v3, v7, :cond_6

    const/16 v7, 0x5d

    if-le v3, v7, :cond_9

    :cond_6
    const/16 v7, 0x60

    if-lt v3, v7, :cond_7

    const/16 v7, 0x7b

    if-le v3, v7, :cond_9

    :cond_7
    const/16 v7, 0x80

    if-lt v3, v7, :cond_8

    const/16 v7, 0xbf

    if-le v3, v7, :cond_9

    :cond_8
    const/16 v7, 0x7d

    if-ne v3, v7, :cond_a

    const-string v7, "KT"

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v7

    if-ne v7, v6, :cond_a

    iget-object v7, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v8, "KTFotaMessage"

    invoke-static {v7, v8}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v7

    if-eq v7, v6, :cond_a

    .line 1552
    :cond_9
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "dispatchOperatorMessage(), message discard : [reserved] "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1553
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v7, v8}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 1554
    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    goto/16 :goto_0

    .line 1558
    :cond_a
    const/16 v6, 0xb

    goto/16 :goto_0
.end method

.method protected dispatchPdus([[B)V
    .locals 6
    .param p1, "pdus"    # [[B

    .prologue
    .line 1029
    new-instance v1, Landroid/content/Intent;

    const-string v0, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1030
    .local v1, "intent":Landroid/content/Intent;
    const-string v0, "pdus"

    invoke-virtual {v1, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 1031
    const-string v0, "format"

    const-string v2, "3gpp2"

    invoke-virtual {v1, v0, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1032
    const-string v2, "android.permission.RECEIVE_SMS"

    const/16 v3, 0x10

    const/4 v4, 0x0

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 1034
    return-void
.end method

.method protected dispatchPortAddressedPdus([[BI)V
    .locals 7
    .param p1, "pdus"    # [[B
    .param p2, "port"    # I

    .prologue
    .line 1019
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "sms://localhost:"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v6

    .line 1020
    .local v6, "uri":Landroid/net/Uri;
    new-instance v1, Landroid/content/Intent;

    const-string v0, "android.intent.action.DATA_SMS_RECEIVED"

    invoke-direct {v1, v0, v6}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 1021
    .local v1, "intent":Landroid/content/Intent;
    const-string v0, "pdus"

    invoke-virtual {v1, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 1022
    const-string v0, "format"

    const-string v2, "3gpp2"

    invoke-virtual {v1, v0, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1023
    const/high16 v0, 0x10000000

    invoke-virtual {v1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1024
    const-string v2, "android.permission.RECEIVE_SMS"

    const/16 v3, 0x10

    const/4 v4, 0x0

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 1026
    return-void
.end method

.method protected getStrMsgWhat(I)Ljava/lang/String;
    .locals 3
    .param p1, "nMsg"    # I

    .prologue
    .line 2226
    const/4 v0, 0x0

    .line 2227
    .local v0, "strRet":Ljava/lang/String;
    packed-switch p1, :pswitch_data_0

    .line 2255
    :pswitch_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid msg.what: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 2258
    :goto_0
    return-object v0

    .line 2229
    :pswitch_1
    const-string v0, "EVENT_NEW_SMS"

    .line 2230
    goto :goto_0

    .line 2232
    :pswitch_2
    const-string v0, "EVENT_BROADCAST_SMS"

    .line 2233
    goto :goto_0

    .line 2235
    :pswitch_3
    const-string v0, "EVENT_BROADCAST_COMPLETE"

    .line 2236
    goto :goto_0

    .line 2238
    :pswitch_4
    const-string v0, "EVENT_RETURN_TO_IDLE"

    .line 2239
    goto :goto_0

    .line 2241
    :pswitch_5
    const-string v0, "EVENT_RELEASE_WAKELOCK"

    .line 2242
    goto :goto_0

    .line 2244
    :pswitch_6
    const-string v0, "EVENT_START_ACCEPTING_SMS"

    .line 2245
    goto :goto_0

    .line 2247
    :pswitch_7
    const-string v0, "EVENT_UPDATE_PHONE_OBJECT"

    .line 2248
    goto :goto_0

    .line 2251
    :pswitch_8
    const-string v0, "EVENT_DAN_SMS_COMPLETE"

    .line 2252
    goto :goto_0

    .line 2227
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_8
    .end packed-switch
.end method

.method handleNewSms(Landroid/os/AsyncResult;)V
    .locals 6
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const/4 v1, 0x1

    .line 250
    iget-object v4, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v4, :cond_1

    .line 251
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Exception processing incoming SMS: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->loge(Ljava/lang/String;)V

    .line 281
    :cond_0
    :goto_0
    return-void

    .line 256
    :cond_1
    iget-object v4, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "sms_permission_tracking"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 257
    invoke-direct {p0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->addSMSPermissionTracking()V

    .line 263
    :cond_2
    :try_start_0
    iget-object v3, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v3, Landroid/telephony/SmsMessage;

    .line 265
    .local v3, "sms":Landroid/telephony/SmsMessage;
    iget-object v4, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "cdma_sms_cdg2"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 266
    invoke-direct {p0, v3}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->handleCdmaSmsCDG2(Landroid/telephony/SmsMessage;)V

    .line 269
    :cond_3
    iget-object v4, v3, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchMessage(Lcom/android/internal/telephony/SmsMessageBase;)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 277
    .end local v3    # "sms":Landroid/telephony/SmsMessage;
    .local v2, "result":I
    :goto_1
    const/4 v4, -0x1

    if-eq v2, v4, :cond_0

    .line 278
    if-ne v2, v1, :cond_4

    .line 279
    .local v1, "handled":Z
    :goto_2
    const/4 v4, 0x0

    invoke-virtual {p0, v1, v2, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->notifyAndAcknowledgeLastIncomingSms(ZILandroid/os/Message;)V

    goto :goto_0

    .line 270
    .end local v1    # "handled":Z
    .end local v2    # "result":I
    :catch_0
    move-exception v0

    .line 271
    .local v0, "ex":Ljava/lang/RuntimeException;
    const-string v4, "Exception dispatching message"

    invoke-virtual {p0, v4, v0}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->loge(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 272
    const/4 v2, 0x2

    .restart local v2    # "result":I
    goto :goto_1

    .line 278
    .end local v0    # "ex":Ljava/lang/RuntimeException;
    :cond_4
    const/4 v1, 0x0

    goto :goto_2
.end method

.method protected abstract is3gpp2()Z
.end method

.method protected parseDirectedSMS(Lcom/android/internal/telephony/SmsMessageBase;Landroid/content/BroadcastReceiver;)I
    .locals 32
    .param p1, "sms"    # Lcom/android/internal/telephony/SmsMessageBase;
    .param p2, "receiver"    # Landroid/content/BroadcastReceiver;

    .prologue
    .line 1104
    const/16 v27, 0x0

    .line 1105
    .local v27, "processStatus":I
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/SmsMessageBase;->getMessageBody()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_0

    .line 1106
    const-string v2, "[sms.mt.parseDirectedSMS] sms.getMessageBody() is NULL "

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1107
    const/16 v27, -0x1

    move/from16 v28, v27

    .line 1284
    .end local v27    # "processStatus":I
    .local v28, "processStatus":I
    :goto_0
    return v28

    .line 1109
    .end local v28    # "processStatus":I
    .restart local v27    # "processStatus":I
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] sms.getMessageBody() = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/SmsMessageBase;->getMessageBody()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1112
    const/16 v24, 0x0

    .line 1115
    .local v24, "packageIndex":I
    const/4 v15, 0x1

    .line 1119
    .local v15, "bIsSeparator":Z
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/SmsMessageBase;->getMessageBody()Ljava/lang/String;

    move-result-object v2

    const-string v3, "//VZW"

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 1120
    const-string v2, "[sms.mt.parseDirectedSMS] not startsWith //VZW "

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1121
    const/16 v16, 0x0

    .line 1129
    .local v16, "bStartWithVZW":Z
    :goto_1
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/SmsMessageBase;->getMessageBody()Ljava/lang/String;

    move-result-object v9

    .line 1130
    .local v9, "appDirectedSMS":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] parseDirectedSMS / appDirectedSMS : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1133
    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v2

    const/16 v3, 0xe

    if-le v2, v3, :cond_2

    const/4 v2, 0x0

    const/16 v3, 0xd

    invoke-virtual {v9, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    const-string v3, "//VZWLBSROVER"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1134
    const-string v2, "[sms.mt.parseDirectedSMS] //VZWLBSROVER"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1137
    const/16 v27, -0x2

    move/from16 v28, v27

    .end local v27    # "processStatus":I
    .restart local v28    # "processStatus":I
    goto :goto_0

    .line 1124
    .end local v9    # "appDirectedSMS":Ljava/lang/String;
    .end local v16    # "bStartWithVZW":Z
    .end local v28    # "processStatus":I
    .restart local v27    # "processStatus":I
    :cond_1
    const-string v2, "[sms.mt.parseDirectedSMS] startsWith //VZW "

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1125
    const/16 v16, 0x1

    .restart local v16    # "bStartWithVZW":Z
    goto :goto_1

    .line 1144
    .restart local v9    # "appDirectedSMS":Ljava/lang/String;
    :cond_2
    if-eqz v16, :cond_6

    const-string v2, "//VZW"

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v9, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v31

    .line 1148
    .local v31, "tempSMS":Ljava/lang/String;
    :goto_2
    const-string v2, ":"

    move-object/from16 v0, v31

    invoke-virtual {v0, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    const/4 v3, -0x1

    if-ne v2, v3, :cond_3

    .line 1149
    const-string v2, "[sms.mt.parseDirectedSMS] check separator"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1150
    const/4 v15, 0x0

    .line 1156
    :cond_3
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v26

    .line 1157
    .local v26, "pkgManager":Landroid/content/pm/PackageManager;
    const/16 v2, 0x80

    move-object/from16 v0, v26

    invoke-virtual {v0, v2}, Landroid/content/pm/PackageManager;->getInstalledApplications(I)Ljava/util/List;

    move-result-object v20

    .line 1160
    .local v20, "installedAppList":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ApplicationInfo;>;"
    move-object/from16 v0, p0

    move-object/from16 v1, v26

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->getVZWSignatures(Landroid/content/pm/PackageManager;)Z

    .line 1162
    invoke-interface/range {v20 .. v20}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v18

    :goto_3
    invoke-interface/range {v18 .. v18}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_15

    invoke-interface/range {v18 .. v18}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Landroid/content/pm/ApplicationInfo;

    .line 1163
    .local v10, "appInfo":Landroid/content/pm/ApplicationInfo;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v24

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " appInfo.packageName: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v10, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1164
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    iget-object v3, v10, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-static {v2, v3}, Lcom/android/internal/telephony/LGVerizonBranded;->isSystemApplication(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_4

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    iget-object v3, v10, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const-string v5, "VZWSMS"

    invoke-static {v2, v3, v5}, Lcom/android/internal/telephony/LGVerizonBranded;->isAVSPackageAuthorized(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_4

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    iget-object v3, v10, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-static {v2, v3}, Lcom/android/internal/telephony/LGVerizonBranded;->isItSignedByVZW(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_c

    .line 1172
    :cond_4
    const/16 v29, 0x0

    .line 1173
    .local v29, "receiverCount":I
    const/16 v21, 0x0

    .line 1174
    .local v21, "isReceiverMatched":Z
    new-instance v13, Ljava/util/ArrayList;

    invoke-direct {v13}, Ljava/util/ArrayList;-><init>()V

    .line 1177
    .local v13, "applicationPrefixList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :try_start_0
    iget-object v2, v10, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    const/4 v3, 0x2

    move-object/from16 v0, v26

    invoke-virtual {v0, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v25

    .line 1186
    .local v25, "pkgInfo":Landroid/content/pm/PackageInfo;
    move-object/from16 v0, v25

    iget-object v0, v0, Landroid/content/pm/PackageInfo;->receivers:[Landroid/content/pm/ActivityInfo;

    move-object/from16 v30, v0

    .line 1187
    .local v30, "receivers":[Landroid/content/pm/ActivityInfo;
    if-eqz v30, :cond_8

    .line 1188
    move-object/from16 v14, v30

    .local v14, "arr$":[Landroid/content/pm/ActivityInfo;
    array-length v0, v14

    move/from16 v22, v0

    .local v22, "len$":I
    const/16 v19, 0x0

    .local v19, "i$":I
    :goto_4
    move/from16 v0, v19

    move/from16 v1, v22

    if-ge v0, v1, :cond_8

    aget-object v8, v14, v19

    .line 1189
    .local v8, "actInfo":Landroid/content/pm/ActivityInfo;
    add-int/lit8 v29, v29, 0x1

    .line 1193
    :try_start_1
    new-instance v2, Landroid/content/ComponentName;

    iget-object v3, v10, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    iget-object v5, v8, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;

    invoke-direct {v2, v3, v5}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const/16 v3, 0x80

    move-object/from16 v0, v26

    invoke-virtual {v0, v2, v3}, Landroid/content/pm/PackageManager;->getReceiverInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ActivityInfo;
    :try_end_1
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v8

    .line 1200
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] receiver = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v8, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " actInfo.metaData = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v8, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " receiverCount: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v29

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1201
    iget-object v0, v8, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    move-object/from16 v23, v0

    .line 1202
    .local v23, "metaData":Landroid/os/Bundle;
    if-nez v23, :cond_7

    .line 1203
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] metaData is null. Unable to get meta data for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v8, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1188
    .end local v23    # "metaData":Landroid/os/Bundle;
    :cond_5
    :goto_5
    add-int/lit8 v19, v19, 0x1

    goto :goto_4

    .end local v8    # "actInfo":Landroid/content/pm/ActivityInfo;
    .end local v10    # "appInfo":Landroid/content/pm/ApplicationInfo;
    .end local v13    # "applicationPrefixList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v14    # "arr$":[Landroid/content/pm/ActivityInfo;
    .end local v19    # "i$":I
    .end local v20    # "installedAppList":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ApplicationInfo;>;"
    .end local v21    # "isReceiverMatched":Z
    .end local v22    # "len$":I
    .end local v25    # "pkgInfo":Landroid/content/pm/PackageInfo;
    .end local v26    # "pkgManager":Landroid/content/pm/PackageManager;
    .end local v29    # "receiverCount":I
    .end local v30    # "receivers":[Landroid/content/pm/ActivityInfo;
    .end local v31    # "tempSMS":Ljava/lang/String;
    :cond_6
    move-object/from16 v31, v9

    .line 1144
    goto/16 :goto_2

    .line 1178
    .restart local v10    # "appInfo":Landroid/content/pm/ApplicationInfo;
    .restart local v13    # "applicationPrefixList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .restart local v20    # "installedAppList":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ApplicationInfo;>;"
    .restart local v21    # "isReceiverMatched":Z
    .restart local v26    # "pkgManager":Landroid/content/pm/PackageManager;
    .restart local v29    # "receiverCount":I
    .restart local v31    # "tempSMS":Ljava/lang/String;
    :catch_0
    move-exception v17

    .line 1179
    .local v17, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] Can\'t find package: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v10, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1180
    add-int/lit8 v24, v24, 0x1

    .line 1181
    goto/16 :goto_3

    .line 1194
    .end local v17    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    .restart local v8    # "actInfo":Landroid/content/pm/ActivityInfo;
    .restart local v14    # "arr$":[Landroid/content/pm/ActivityInfo;
    .restart local v19    # "i$":I
    .restart local v22    # "len$":I
    .restart local v25    # "pkgInfo":Landroid/content/pm/PackageInfo;
    .restart local v30    # "receivers":[Landroid/content/pm/ActivityInfo;
    :catch_1
    move-exception v17

    .line 1195
    .restart local v17    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] Can\'t find receivers: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v8, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " appInfo.packageName "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v10, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1196
    add-int/lit8 v24, v24, 0x1

    .line 1197
    goto :goto_5

    .line 1205
    .end local v17    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    .restart local v23    # "metaData":Landroid/os/Bundle;
    :cond_7
    const-string v2, "com.verizon.directedAppSMS"

    move-object/from16 v0, v23

    invoke-virtual {v0, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_5

    const-string v2, "com.verizon.directedAppSMS"

    move-object/from16 v0, v23

    invoke-virtual {v0, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_5

    .line 1206
    const-string v2, "com.verizon.directedAppSMS"

    move-object/from16 v0, v23

    invoke-virtual {v0, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v13, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1207
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] applicationPrefix = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "com.verizon.directedAppSMS"

    move-object/from16 v0, v23

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " applicationPrefixList.size() ="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v13}, Ljava/util/ArrayList;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1208
    const/16 v21, 0x1

    .line 1209
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] matched !! receiver = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v8, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " actInfo.metaData = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v8, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto/16 :goto_5

    .line 1216
    .end local v8    # "actInfo":Landroid/content/pm/ActivityInfo;
    .end local v14    # "arr$":[Landroid/content/pm/ActivityInfo;
    .end local v19    # "i$":I
    .end local v22    # "len$":I
    .end local v23    # "metaData":Landroid/os/Bundle;
    :cond_8
    if-nez v21, :cond_b

    .line 1218
    iget-object v2, v10, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    if-eqz v2, :cond_9

    iget-object v2, v10, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v3, "com.verizon.directedAppSMS"

    invoke-virtual {v2, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_a

    .line 1219
    :cond_9
    const-string v2, "[sms.mt.parseDirectedSMS] appInfo.metaData == null"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1220
    add-int/lit8 v24, v24, 0x1

    .line 1221
    goto/16 :goto_3

    .line 1224
    :cond_a
    iget-object v2, v10, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v3, "com.verizon.directedAppSMS"

    invoke-virtual {v2, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v13, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1226
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] appInfo = ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "] appInfo.metaData = ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v10, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "] appInfo.metaData.getString(METADATA_NAME) = ["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v10, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v5, "com.verizon.directedAppSMS"

    invoke-virtual {v3, v5}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1229
    :cond_b
    invoke-virtual {v13}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-nez v2, :cond_d

    .line 1231
    const-string v2, "[sms.mt.parseDirectedSMS] applicationPrefixList is Empty"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1276
    .end local v13    # "applicationPrefixList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v21    # "isReceiverMatched":Z
    .end local v25    # "pkgInfo":Landroid/content/pm/PackageInfo;
    .end local v29    # "receiverCount":I
    .end local v30    # "receivers":[Landroid/content/pm/ActivityInfo;
    :cond_c
    add-int/lit8 v24, v24, 0x1

    .line 1277
    goto/16 :goto_3

    .line 1233
    .restart local v13    # "applicationPrefixList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .restart local v21    # "isReceiverMatched":Z
    .restart local v25    # "pkgInfo":Landroid/content/pm/PackageInfo;
    .restart local v29    # "receiverCount":I
    .restart local v30    # "receivers":[Landroid/content/pm/ActivityInfo;
    :cond_d
    const/4 v11, 0x0

    .local v11, "appPrefixCount":I
    :goto_6
    invoke-virtual {v13}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v11, v2, :cond_c

    .line 1234
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] applicationPrefix: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v13, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1239
    const/4 v2, 0x1

    if-ne v15, v2, :cond_12

    .line 1240
    const/4 v2, 0x0

    const-string v3, ":"

    move-object/from16 v0, v31

    invoke-virtual {v0, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    move-object/from16 v0, v31

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v12

    .line 1241
    .local v12, "applicationPrefixFromSMSBody":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] SMS contain a separator(:), applicationPrefixFromSMSBody: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1251
    :cond_e
    if-eqz v15, :cond_f

    invoke-virtual {v13, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_10

    :cond_f
    if-nez v15, :cond_11

    invoke-virtual {v13, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v12, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_11

    .line 1256
    :cond_10
    if-eqz v15, :cond_13

    .line 1257
    invoke-virtual {v12}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, 0x1

    invoke-virtual/range {v31 .. v31}, Ljava/lang/String;->length()I

    move-result v3

    move-object/from16 v0, v31

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    .line 1261
    .local v4, "parameters":Ljava/lang/String;
    :goto_7
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] parameters : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1264
    if-lez v29, :cond_14

    .line 1265
    iget-object v3, v10, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/SmsMessageBase;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v13, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    move-object/from16 v2, p0

    move-object/from16 v7, p2

    invoke-virtual/range {v2 .. v7}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchDirectedSms(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/BroadcastReceiver;)V

    .line 1271
    :goto_8
    const/16 v27, 0x1

    .line 1233
    .end local v4    # "parameters":Ljava/lang/String;
    :cond_11
    :goto_9
    add-int/lit8 v11, v11, 0x1

    goto/16 :goto_6

    .line 1243
    .end local v12    # "applicationPrefixFromSMSBody":Ljava/lang/String;
    :cond_12
    move-object/from16 v12, v31

    .line 1244
    .restart local v12    # "applicationPrefixFromSMSBody":Ljava/lang/String;
    invoke-virtual/range {v31 .. v31}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v13, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-gt v3, v2, :cond_e

    .line 1245
    const-string v2, "[sms.mt.parseDirectedSMS] SMS length is too short to compare !"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_9

    .line 1259
    :cond_13
    invoke-virtual {v13, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual/range {v31 .. v31}, Ljava/lang/String;->length()I

    move-result v3

    move-object/from16 v0, v31

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    .restart local v4    # "parameters":Ljava/lang/String;
    goto :goto_7

    .line 1267
    :cond_14
    const-string v2, "[sms.mt.parseDirectedSMS] There is not a receiver. No run dispatchDirectedSms !!"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_8

    .line 1279
    .end local v4    # "parameters":Ljava/lang/String;
    .end local v10    # "appInfo":Landroid/content/pm/ApplicationInfo;
    .end local v11    # "appPrefixCount":I
    .end local v12    # "applicationPrefixFromSMSBody":Ljava/lang/String;
    .end local v13    # "applicationPrefixList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v21    # "isReceiverMatched":Z
    .end local v25    # "pkgInfo":Landroid/content/pm/PackageInfo;
    .end local v29    # "receiverCount":I
    .end local v30    # "receivers":[Landroid/content/pm/ActivityInfo;
    :cond_15
    const/4 v2, 0x1

    move/from16 v0, v27

    if-eq v0, v2, :cond_16

    .line 1281
    if-eqz v16, :cond_17

    const/16 v27, 0x0

    .line 1283
    :cond_16
    :goto_a
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[sms.mt.parseDirectedSMS] processStatus=("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v27

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    move/from16 v28, v27

    .line 1284
    .end local v27    # "processStatus":I
    .restart local v28    # "processStatus":I
    goto/16 :goto_0

    .line 1281
    .end local v28    # "processStatus":I
    .restart local v27    # "processStatus":I
    :cond_17
    const/16 v27, -0x1

    goto :goto_a
.end method

.method protected parseDirectedVVM(Lcom/android/internal/telephony/SmsMessageBase;)I
    .locals 10
    .param p1, "smsb"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    const/16 v6, 0xb

    const/4 v7, 0x1

    .line 1954
    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getMessageBody()Ljava/lang/String;

    move-result-object v8

    if-nez v8, :cond_0

    .line 1955
    const-string v7, "parseDirectedVVM(), sms.getMessageBody() is NULL."

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1993
    :goto_0
    return v6

    .line 1959
    :cond_0
    new-array v4, v7, [[B

    .line 1960
    .local v4, "pdus":[[B
    const/4 v8, 0x0

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getPdu()[B

    move-result-object v9

    aput-object v9, v4, v8

    .line 1965
    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getMessageBody()Ljava/lang/String;

    move-result-object v8

    const-string v9, "//ANDROID"

    invoke-virtual {v8, v9}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_1

    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getMessageBody()Ljava/lang/String;

    move-result-object v8

    const-string v9, "//CM"

    invoke-virtual {v8, v9}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_2

    .line 1966
    :cond_1
    const-string v7, "parseDirectedVVM(), No matching string."

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0

    .line 1972
    :cond_2
    :try_start_0
    iget-object v8, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v5

    .line 1973
    .local v5, "pkgManager":Landroid/content/pm/PackageManager;
    const/16 v8, 0x80

    invoke-virtual {v5, v8}, Landroid/content/pm/PackageManager;->getInstalledApplications(I)Ljava/util/List;

    move-result-object v3

    .line 1975
    .local v3, "installedAppList":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ApplicationInfo;>;"
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :cond_3
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ApplicationInfo;

    .line 1976
    .local v0, "appInfo":Landroid/content/pm/ApplicationInfo;
    const-string v8, "com.coremobility.app.vnotes"

    iget-object v9, v0, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_3

    .line 1978
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "parseDirectedVVM(), appInfo.packageName: "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v8, v0, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1979
    const-string v6, "parseDirectedVVM(), VVM App is installed."

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1980
    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchDirectedVVM([[B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move v6, v7

    .line 1981
    goto :goto_0

    .line 1984
    .end local v0    # "appInfo":Landroid/content/pm/ApplicationInfo;
    .end local v2    # "i$":Ljava/util/Iterator;
    .end local v3    # "installedAppList":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ApplicationInfo;>;"
    .end local v5    # "pkgManager":Landroid/content/pm/PackageManager;
    :catch_0
    move-exception v1

    .line 1985
    .local v1, "e":Ljava/lang/Exception;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "parseDirectedVVM(), Exception : "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1988
    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchDirectedVVM([[B)V

    move v6, v7

    .line 1989
    goto/16 :goto_0

    .line 1992
    .end local v1    # "e":Ljava/lang/Exception;
    .restart local v2    # "i$":Ljava/util/Iterator;
    .restart local v3    # "installedAppList":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ApplicationInfo;>;"
    .restart local v5    # "pkgManager":Landroid/content/pm/PackageManager;
    :cond_4
    const-string v7, "parseDirectedVVM(), VVM Control message is received. But VVM App is not installed."

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto/16 :goto_0
.end method

.method protected processKizONMessage(Lcom/android/internal/telephony/InboundSmsTracker;[[BLandroid/content/BroadcastReceiver;)Z
    .locals 12
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "pdus"    # [[B
    .param p3, "receiver"    # Landroid/content/BroadcastReceiver;

    .prologue
    const/4 v2, 0x0

    .line 1690
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v11

    .line 1691
    .local v11, "pm":Landroid/content/pm/PackageManager;
    const/4 v10, 0x0

    .line 1694
    .local v10, "pi":Landroid/content/pm/PackageInfo;
    :try_start_0
    const-string v0, "com.lge.band"

    const/4 v3, 0x0

    invoke-virtual {v11, v0, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v10

    .line 1699
    :goto_0
    if-eqz v10, :cond_0

    const-string v0, "com.lge.band"

    iget-object v3, v10, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget-object v3, v3, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    move v0, v2

    .line 1721
    :goto_1
    return v0

    .line 1695
    :catch_0
    move-exception v6

    .line 1696
    .local v6, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    const-string v0, "processKizONMessage(), KizON package doesn\'t existed."

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0

    .line 1703
    .end local v6    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :cond_1
    aget-object v3, p2, v2

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->is3gpp2()Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "3gpp2"

    :goto_2
    invoke-static {v3, v0}, Landroid/telephony/SmsMessage;->createFromPdu([BLjava/lang/String;)Landroid/telephony/SmsMessage;

    move-result-object v9

    .line 1704
    .local v9, "msg":Landroid/telephony/SmsMessage;
    if-eqz v9, :cond_3

    .line 1705
    invoke-virtual {v9}, Landroid/telephony/SmsMessage;->getMessageBody()Ljava/lang/String;

    move-result-object v8

    .line 1706
    .local v8, "messageBody":Ljava/lang/String;
    if-eqz v8, :cond_3

    .line 1707
    sget-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->KIZON_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, v8}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v7

    .line 1709
    .local v7, "m":Ljava/util/regex/Matcher;
    invoke-virtual {v7}, Ljava/util/regex/Matcher;->find()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1710
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "processKizONMessage(), Found pattern : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v7, v2}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1711
    new-instance v1, Landroid/content/Intent;

    const-string v0, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1712
    .local v1, "intent":Landroid/content/Intent;
    const-string v0, "com.lge.band"

    invoke-virtual {v1, v0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 1713
    const-string v0, "processKizONMessage(), Delivering SMS to : com.lge.band"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1714
    const-string v0, "pdus"

    invoke-virtual {v1, v0, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 1715
    const-string v0, "format"

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getFormat()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1716
    const-string v2, "android.permission.RECEIVE_SMS"

    const/16 v3, 0x10

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object v0, p0

    move-object v4, p3

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 1717
    const/4 v0, 0x1

    goto :goto_1

    .line 1703
    .end local v1    # "intent":Landroid/content/Intent;
    .end local v7    # "m":Ljava/util/regex/Matcher;
    .end local v8    # "messageBody":Ljava/lang/String;
    .end local v9    # "msg":Landroid/telephony/SmsMessage;
    :cond_2
    const-string v0, "3gpp"

    goto :goto_2

    .restart local v9    # "msg":Landroid/telephony/SmsMessage;
    :cond_3
    move v0, v2

    .line 1721
    goto :goto_1
.end method

.method protected processMcAfeeMessage(Lcom/android/internal/telephony/InboundSmsTracker;[[BLandroid/content/BroadcastReceiver;)Z
    .locals 11
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "pdus"    # [[B
    .param p3, "receiver"    # Landroid/content/BroadcastReceiver;

    .prologue
    const/4 v2, 0x0

    .line 1655
    const-string v0, "service.wsandroid.lge.token"

    const-string v3, ""

    invoke-static {v0, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 1656
    .local v9, "token":Ljava/lang/String;
    const-string v10, ""

    .line 1657
    .local v10, "web_token":Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "processMcAfeeMessage(), McAfee token : "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1659
    const-string v0, ""

    invoke-virtual {v9, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v2

    .line 1685
    :goto_0
    return v0

    .line 1663
    :cond_0
    aget-object v3, p2, v2

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->is3gpp2()Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "3gpp2"

    :goto_1
    invoke-static {v3, v0}, Landroid/telephony/SmsMessage;->createFromPdu([BLjava/lang/String;)Landroid/telephony/SmsMessage;

    move-result-object v8

    .line 1664
    .local v8, "msg":Landroid/telephony/SmsMessage;
    if-eqz v8, :cond_3

    .line 1665
    invoke-virtual {v8}, Landroid/telephony/SmsMessage;->getMessageBody()Ljava/lang/String;

    move-result-object v7

    .line 1666
    .local v7, "messageBody":Ljava/lang/String;
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v3, "kr_operator_web_send"

    invoke-static {v0, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1667
    sget-object v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->MCAFEE_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, v7}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v6

    .line 1668
    .local v6, "m":Ljava/util/regex/Matcher;
    invoke-virtual {v6}, Ljava/util/regex/Matcher;->find()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1669
    invoke-virtual {v6, v2}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v10

    .line 1673
    .end local v6    # "m":Ljava/util/regex/Matcher;
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 1674
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "processMcAfeeMessage(), token = "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ", web_token = "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1675
    invoke-virtual {v7, v9}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1676
    new-instance v1, Landroid/content/Intent;

    const-string v0, "android.provider.Telephony.SMS_RECEIVED"

    invoke-direct {v1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1677
    .local v1, "intent":Landroid/content/Intent;
    const-string v0, "com.wsandroid.suite.lge"

    invoke-virtual {v1, v0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 1678
    const-string v0, "processMcAfeeMessage(), Delivering SMS to : com.wsandroid.suite.lge"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1679
    const-string v0, "pdus"

    invoke-virtual {v1, v0, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 1680
    const-string v0, "format"

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getFormat()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1681
    const-string v2, "android.permission.RECEIVE_SMS"

    const/16 v3, 0x10

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object v0, p0

    move-object v4, p3

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 1682
    const/4 v0, 0x1

    goto/16 :goto_0

    .line 1663
    .end local v1    # "intent":Landroid/content/Intent;
    .end local v7    # "messageBody":Ljava/lang/String;
    .end local v8    # "msg":Landroid/telephony/SmsMessage;
    :cond_2
    const-string v0, "3gpp"

    goto/16 :goto_1

    .restart local v8    # "msg":Landroid/telephony/SmsMessage;
    :cond_3
    move v0, v2

    .line 1685
    goto/16 :goto_0
.end method

.method processMessagePart(Lcom/android/internal/telephony/InboundSmsTracker;)Z
    .locals 65
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;

    .prologue
    .line 392
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v11

    .line 394
    .local v11, "messageCount":I
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDestPort()I

    move-result v42

    .line 396
    .local v42, "destPort":I
    const/16 v51, 0x0

    .line 399
    .local v51, "iccSring":Ljava/lang/String;
    const/4 v13, 0x0

    .line 400
    .local v13, "exceedFirstTimePeriod":Z
    const/4 v14, 0x0

    .line 401
    .local v14, "exceedSecondTimePeriod":Z
    const/4 v15, 0x0

    .line 402
    .local v15, "allSegmentReceived":Z
    const/16 v16, 0x0

    .line 403
    .local v16, "missingSegIndex":Ljava/lang/String;
    const/16 v17, 0x0

    .line 406
    .local v17, "stitchRefMsg":Landroid/telephony/SmsMessage;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[sms.mt] processMessagePart messageCount = ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 408
    const/4 v4, 0x1

    if-ne v11, v4, :cond_2

    .line 410
    const-string v4, "[sms.mt] single-part message"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 411
    const/4 v4, 0x1

    new-array v12, v4, [[B

    const/4 v4, 0x0

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getPdu()[B

    move-result-object v5

    aput-object v5, v12, v4

    .line 593
    .local v12, "pdus":[[B
    :cond_0
    :goto_0
    new-instance v22, Lcom/android/internal/telephony/InboundSmsHandler$SmsBroadcastReceiver;

    move-object/from16 v0, v22

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    invoke-direct {v0, v1, v2}, Lcom/android/internal/telephony/InboundSmsHandler$SmsBroadcastReceiver;-><init>(Lcom/android/internal/telephony/InboundSmsHandler;Lcom/android/internal/telephony/InboundSmsTracker;)V

    .line 595
    .local v22, "resultReceiver":Landroid/content/BroadcastReceiver;
    const/16 v4, 0xb84

    move/from16 v0, v42

    if-ne v0, v4, :cond_22

    .line 597
    const-string v24, ""

    .line 598
    .local v24, "smscAddress":Ljava/lang/String;
    const-string v25, ""

    .line 599
    .local v25, "originatingAddress":Ljava/lang/String;
    const/16 v62, -0x1

    .line 603
    .local v62, "result":I
    const/16 v53, 0x0

    .line 607
    .local v53, "isSafeSMSCheck":Z
    new-instance v57, Ljava/io/ByteArrayOutputStream;

    invoke-direct/range {v57 .. v57}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 608
    .local v57, "output":Ljava/io/ByteArrayOutputStream;
    move-object/from16 v35, v12

    .local v35, "arr$":[[B
    move-object/from16 v0, v35

    array-length v0, v0

    move/from16 v54, v0

    .local v54, "len$":I
    const/16 v50, 0x0

    .local v50, "i$":I
    :goto_1
    move/from16 v0, v50

    move/from16 v1, v54

    if-ge v0, v1, :cond_1f

    aget-object v58, v35, v50

    .line 610
    .local v58, "pdu":[B
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "kddi_cdma_wap_push"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1b

    .line 611
    const-string v4, "[sms.mt] cdma wap push) "

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 612
    invoke-static/range {v58 .. v58}, Landroid/telephony/SmsMessage;->createFromPdu([B)Landroid/telephony/SmsMessage;

    move-result-object v55

    .line 613
    .local v55, "msg":Landroid/telephony/SmsMessage;
    if-eqz v55, :cond_1

    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getUserData()[B

    move-result-object v4

    if-nez v4, :cond_19

    .line 608
    .end local v55    # "msg":Landroid/telephony/SmsMessage;
    :cond_1
    :goto_2
    add-int/lit8 v50, v50, 0x1

    goto :goto_1

    .line 413
    .end local v12    # "pdus":[[B
    .end local v22    # "resultReceiver":Landroid/content/BroadcastReceiver;
    .end local v24    # "smscAddress":Ljava/lang/String;
    .end local v25    # "originatingAddress":Ljava/lang/String;
    .end local v35    # "arr$":[[B
    .end local v50    # "i$":I
    .end local v53    # "isSafeSMSCheck":Z
    .end local v54    # "len$":I
    .end local v57    # "output":Ljava/io/ByteArrayOutputStream;
    .end local v58    # "pdu":[B
    .end local v62    # "result":I
    :cond_2
    const-string v4, "[sms.mt] not single-part message"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 415
    const/16 v40, 0x0

    .line 418
    .local v40, "cursor":Landroid/database/Cursor;
    :try_start_0
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getAddress()Ljava/lang/String;

    move-result-object v33

    .line 419
    .local v33, "address":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getReferenceNumber()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v61

    .line 420
    .local v61, "refNumber":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v37

    .line 423
    .local v37, "count":Ljava/lang/String;
    const/4 v4, 0x3

    new-array v8, v4, [Ljava/lang/String;

    const/4 v4, 0x0

    aput-object v33, v8, v4

    const/4 v4, 0x1

    aput-object v61, v8, v4

    const/4 v4, 0x2

    aput-object v37, v8, v4

    .line 427
    .local v8, "whereArgs":[Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "ems_segment_timer"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_7

    .line 428
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sRawUri:Landroid/net/Uri;

    sget-object v6, Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_SEQUENCE_PORT_ICC_TIME_PROJECTION:[Ljava/lang/String;

    const-string v7, "address=? AND reference_number=? AND count=?"

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v40

    .line 442
    :goto_3
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "concat_stitching"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 443
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v48

    .line 444
    .local v48, "firstTime":J
    invoke-interface/range {v40 .. v40}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 445
    const-string v4, "time"

    move-object/from16 v0, v40

    invoke-interface {v0, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v63

    .line 446
    .local v63, "timeColumn":I
    move-object/from16 v0, v40

    move/from16 v1, v63

    invoke-interface {v0, v1}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v48

    .line 448
    .end local v63    # "timeColumn":I
    :cond_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v38

    .line 449
    .local v38, "currentTime":J
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getMessageCount()I

    move-result v4

    add-int/lit8 v4, v4, -0x1

    mul-int/lit8 v4, v4, 0x14

    mul-int/lit16 v4, v4, 0x3e8

    int-to-long v0, v4

    move-wide/from16 v44, v0

    .line 451
    .local v44, "dispatchTime":J
    const-wide/32 v4, 0x2932e00

    add-long v4, v4, v48

    cmp-long v4, v38, v4

    if-lez v4, :cond_9

    .line 452
    const/4 v14, 0x1

    .line 456
    :cond_4
    :goto_4
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "processMessagePart, [RED] exceedSecondTimePeriod = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v14}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 457
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "processMessagePart, [RED] exceedFirstTimePeriod = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 461
    .end local v38    # "currentTime":J
    .end local v44    # "dispatchTime":J
    .end local v48    # "firstTime":J
    :cond_5
    invoke-interface/range {v40 .. v40}, Landroid/database/Cursor;->getCount()I

    move-result v41

    .line 462
    .local v41, "cursorCount":I
    move/from16 v0, v41

    if-ge v0, v11, :cond_10

    .line 470
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "concat_stitching"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_f

    .line 471
    if-nez v14, :cond_a

    if-nez v13, :cond_a

    .line 472
    const-string v4, "processMessagePart, [RED] short return"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/database/SQLException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 473
    const/4 v4, 0x0

    .line 587
    if-eqz v40, :cond_6

    .line 588
    invoke-interface/range {v40 .. v40}, Landroid/database/Cursor;->close()V

    .line 787
    .end local v8    # "whereArgs":[Ljava/lang/String;
    .end local v33    # "address":Ljava/lang/String;
    .end local v37    # "count":Ljava/lang/String;
    .end local v40    # "cursor":Landroid/database/Cursor;
    .end local v41    # "cursorCount":I
    .end local v61    # "refNumber":Ljava/lang/String;
    :cond_6
    :goto_5
    return v4

    .line 430
    .restart local v8    # "whereArgs":[Ljava/lang/String;
    .restart local v33    # "address":Ljava/lang/String;
    .restart local v37    # "count":Ljava/lang/String;
    .restart local v40    # "cursor":Landroid/database/Cursor;
    .restart local v61    # "refNumber":Ljava/lang/String;
    :cond_7
    :try_start_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "use_original_telephony_provider"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_8

    .line 433
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sRawUri:Landroid/net/Uri;

    sget-object v6, Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_SEQUENCE_PORT_PROJECTION:[Ljava/lang/String;

    const-string v7, "address=? AND reference_number=? AND count=?"

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v40

    goto/16 :goto_3

    .line 437
    :cond_8
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sRawUri:Landroid/net/Uri;

    sget-object v6, Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_SEQUENCE_PORT_ICC_PROJECTION:[Ljava/lang/String;

    const-string v7, "address=? AND reference_number=? AND count=?"

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v40

    goto/16 :goto_3

    .line 453
    .restart local v38    # "currentTime":J
    .restart local v44    # "dispatchTime":J
    .restart local v48    # "firstTime":J
    :cond_9
    add-long v4, v48, v44

    cmp-long v4, v38, v4

    if-lez v4, :cond_4

    .line 454
    const/4 v13, 0x1

    goto/16 :goto_4

    .line 475
    .end local v38    # "currentTime":J
    .end local v44    # "dispatchTime":J
    .end local v48    # "firstTime":J
    .restart local v41    # "cursorCount":I
    :cond_a
    const-string v4, "processMessagePart, do not return. It\'s exceeded waiting dispatching time"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 489
    :goto_6
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "seperate_processing_sms_uicc"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_b

    .line 490
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v40

    invoke-direct {v0, v1, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->controlSeperateSmsUicc(Lcom/android/internal/telephony/InboundSmsTracker;Landroid/database/Cursor;)Ljava/lang/String;

    move-result-object v51

    .line 495
    :cond_b
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "concat_stitching"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_12

    .line 496
    if-eqz v14, :cond_11

    .line 497
    const/4 v4, 0x1

    new-array v12, v4, [[B

    const/4 v4, 0x0

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getPdu()[B

    move-result-object v5

    aput-object v5, v12, v4

    .line 508
    .restart local v12    # "pdus":[[B
    :goto_7
    new-array v12, v11, [[B

    .line 509
    :cond_c
    :goto_8
    invoke-interface/range {v40 .. v40}, Landroid/database/Cursor;->moveToNext()Z

    move-result v4

    if-eqz v4, :cond_d

    .line 511
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "concat_stitching"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_13

    .line 512
    if-eqz v14, :cond_13

    .line 513
    const-string v4, "processMessagePart, [RED] exceedSecondTimePeriod! Do not get pdus from db"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 544
    :cond_d
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "concat_stitching"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_e

    move-object/from16 v9, p0

    move-object/from16 v10, p1

    .line 545
    invoke-direct/range {v9 .. v17}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->handleConcatStitching(Lcom/android/internal/telephony/InboundSmsTracker;I[[BZZZLjava/lang/String;Landroid/telephony/SmsMessage;)Ljava/lang/String;

    move-result-object v16

    .line 550
    :cond_e
    new-instance v22, Lcom/android/internal/telephony/InboundSmsHandler$SmsBroadcastReceiver;

    move-object/from16 v0, v22

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    invoke-direct {v0, v1, v2}, Lcom/android/internal/telephony/InboundSmsHandler$SmsBroadcastReceiver;-><init>(Lcom/android/internal/telephony/InboundSmsHandler;Lcom/android/internal/telephony/InboundSmsTracker;)V

    .line 551
    .restart local v22    # "resultReceiver":Landroid/content/BroadcastReceiver;
    new-instance v19, Landroid/content/Intent;

    const-string v4, "android.provider.Telephony.SMS_DELIVER"

    move-object/from16 v0, v19

    invoke-direct {v0, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 553
    .local v19, "intent":Landroid/content/Intent;
    const/4 v4, 0x0

    const-string v5, "kddi_message_duplicate_check"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_17

    const/4 v4, 0x1

    if-eq v11, v4, :cond_17

    .line 555
    array-length v0, v12

    move/from16 v59, v0

    .line 556
    .local v59, "pduCount":I
    move/from16 v0, v59

    new-array v0, v0, [Landroid/telephony/SmsMessage;

    move-object/from16 v56, v0

    .line 557
    .local v56, "msgs":[Landroid/telephony/SmsMessage;
    const/16 v47, 0x0

    .local v47, "i":I
    :goto_9
    move/from16 v0, v47

    move/from16 v1, v59

    if-ge v0, v1, :cond_15

    .line 558
    aget-object v4, v12, v47

    invoke-static {v4}, Landroid/telephony/SmsMessage;->createFromPdu([B)Landroid/telephony/SmsMessage;

    move-result-object v4

    aput-object v4, v56, v47
    :try_end_1
    .catch Landroid/database/SQLException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 557
    add-int/lit8 v47, v47, 0x1

    goto :goto_9

    .line 478
    .end local v12    # "pdus":[[B
    .end local v19    # "intent":Landroid/content/Intent;
    .end local v22    # "resultReceiver":Landroid/content/BroadcastReceiver;
    .end local v47    # "i":I
    .end local v56    # "msgs":[Landroid/telephony/SmsMessage;
    .end local v59    # "pduCount":I
    :cond_f
    const/4 v4, 0x0

    .line 587
    if-eqz v40, :cond_6

    .line 588
    invoke-interface/range {v40 .. v40}, Landroid/database/Cursor;->close()V

    goto/16 :goto_5

    .line 483
    :cond_10
    const/4 v15, 0x1

    .line 484
    :try_start_2
    const-string v4, "processMessagePart, [RED] allSegmentReceived"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I
    :try_end_2
    .catch Landroid/database/SQLException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto/16 :goto_6

    .line 583
    .end local v8    # "whereArgs":[Ljava/lang/String;
    .end local v33    # "address":Ljava/lang/String;
    .end local v37    # "count":Ljava/lang/String;
    .end local v41    # "cursorCount":I
    .end local v61    # "refNumber":Ljava/lang/String;
    :catch_0
    move-exception v46

    .line 584
    .local v46, "e":Landroid/database/SQLException;
    :try_start_3
    const-string v4, "Can\'t access multipart SMS database"

    move-object/from16 v0, p0

    move-object/from16 v1, v46

    invoke-virtual {v0, v4, v1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->loge(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 585
    const/4 v4, 0x0

    .line 587
    if-eqz v40, :cond_6

    .line 588
    invoke-interface/range {v40 .. v40}, Landroid/database/Cursor;->close()V

    goto/16 :goto_5

    .line 499
    .end local v46    # "e":Landroid/database/SQLException;
    .restart local v8    # "whereArgs":[Ljava/lang/String;
    .restart local v33    # "address":Ljava/lang/String;
    .restart local v37    # "count":Ljava/lang/String;
    .restart local v41    # "cursorCount":I
    .restart local v61    # "refNumber":Ljava/lang/String;
    :cond_11
    :try_start_4
    new-array v12, v11, [[B

    .restart local v12    # "pdus":[[B
    goto/16 :goto_7

    .line 504
    .end local v12    # "pdus":[[B
    :cond_12
    new-array v12, v11, [[B

    .restart local v12    # "pdus":[[B
    goto/16 :goto_7

    .line 519
    :cond_13
    const/4 v4, 0x1

    move-object/from16 v0, v40

    invoke-interface {v0, v4}, Landroid/database/Cursor;->getInt(I)I

    move-result v4

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getIndexOffset()I

    move-result v5

    sub-int v52, v4, v5

    .line 521
    .local v52, "index":I
    const/4 v4, 0x0

    move-object/from16 v0, v40

    invoke-interface {v0, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/util/HexDump;->hexStringToByteArray(Ljava/lang/String;)[B

    move-result-object v4

    aput-object v4, v12, v52

    .line 523
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "concat_stitching"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_14

    .line 524
    if-nez v17, :cond_14

    .line 525
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "processMessagePart, [RED] createFromPdu for stitchRefMsg index = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v52

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 526
    aget-object v4, v12, v52

    invoke-static {v4}, Landroid/telephony/SmsMessage;->createFromPdu([B)Landroid/telephony/SmsMessage;

    move-result-object v17

    .line 533
    :cond_14
    if-nez v52, :cond_c

    const/4 v4, 0x2

    move-object/from16 v0, v40

    invoke-interface {v0, v4}, Landroid/database/Cursor;->isNull(I)Z

    move-result v4

    if-nez v4, :cond_c

    .line 534
    const/4 v4, 0x2

    move-object/from16 v0, v40

    invoke-interface {v0, v4}, Landroid/database/Cursor;->getInt(I)I

    move-result v60

    .line 536
    .local v60, "port":I
    invoke-static/range {v60 .. v60}, Lcom/android/internal/telephony/InboundSmsTracker;->getRealDestPort(I)I

    move-result v60

    .line 537
    const/4 v4, -0x1

    move/from16 v0, v60

    if-eq v0, v4, :cond_c

    .line 538
    move/from16 v42, v60

    goto/16 :goto_8

    .line 561
    .end local v52    # "index":I
    .end local v60    # "port":I
    .restart local v19    # "intent":Landroid/content/Intent;
    .restart local v22    # "resultReceiver":Landroid/content/BroadcastReceiver;
    .restart local v47    # "i":I
    .restart local v56    # "msgs":[Landroid/telephony/SmsMessage;
    .restart local v59    # "pduCount":I
    :cond_15
    const/4 v4, 0x0

    aget-object v4, v56, v4

    iget-object v4, v4, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    instance-of v4, v4, Lcom/android/internal/telephony/cdma/SmsMessage;

    if-eqz v4, :cond_16

    .line 562
    const/4 v4, 0x0

    aget-object v4, v56, v4

    iget-object v4, v4, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    check-cast v4, Lcom/android/internal/telephony/cdma/SmsMessage;

    invoke-virtual {v4}, Lcom/android/internal/telephony/cdma/SmsMessage;->getSmsEnvelope()Lcom/android/internal/telephony/cdma/sms/SmsEnvelope;

    move-result-object v4

    iget v4, v4, Lcom/android/internal/telephony/cdma/sms/SmsEnvelope;->messageType:I

    const/4 v5, 0x1

    if-ne v4, v5, :cond_16

    .line 564
    const-string v4, "processMessagePart(), [KDDI] Broadcast Message!!, No duplicate check"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 565
    const-string v20, "android.permission.RECEIVE_SMS"

    const/16 v21, 0x10

    sget-object v23, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object/from16 v18, p0

    invoke-virtual/range {v18 .. v23}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V
    :try_end_4
    .catch Landroid/database/SQLException; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 567
    const/4 v4, 0x1

    .line 587
    if-eqz v40, :cond_6

    .line 588
    invoke-interface/range {v40 .. v40}, Landroid/database/Cursor;->close()V

    goto/16 :goto_5

    .line 572
    :cond_16
    const/4 v4, 0x0

    :try_start_5
    aget-object v4, v56, v4

    iget-object v4, v4, Landroid/telephony/SmsMessage;->mWrappedSmsMessage:Lcom/android/internal/telephony/SmsMessageBase;

    iget v4, v4, Lcom/android/internal/telephony/SmsMessageBase;->mMessageRef:I

    const/4 v5, 0x0

    aget-object v5, v56, v5

    invoke-virtual {v5}, Landroid/telephony/SmsMessage;->getTimestampMillis()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    const/4 v6, 0x0

    aget-object v6, v56, v6

    invoke-virtual {v6}, Landroid/telephony/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x0

    aget-object v7, v56, v7

    invoke-virtual {v7}, Landroid/telephony/SmsMessage;->getMessageBody()Ljava/lang/String;

    move-result-object v7

    move-object/from16 v0, p0

    invoke-virtual {v0, v4, v5, v6, v7}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->checkDuplicateKddiMessage(ILjava/lang/Long;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v43

    .line 574
    .local v43, "discard":Z
    if-eqz v43, :cond_17

    .line 576
    const-string v4, "processMessagePart(), [KDDI] discard duplicate Message "

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_5
    .catch Landroid/database/SQLException; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 577
    const/4 v4, 0x0

    .line 587
    if-eqz v40, :cond_6

    .line 588
    invoke-interface/range {v40 .. v40}, Landroid/database/Cursor;->close()V

    goto/16 :goto_5

    .line 587
    .end local v43    # "discard":Z
    .end local v47    # "i":I
    .end local v56    # "msgs":[Landroid/telephony/SmsMessage;
    .end local v59    # "pduCount":I
    :cond_17
    if-eqz v40, :cond_0

    .line 588
    invoke-interface/range {v40 .. v40}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 587
    .end local v8    # "whereArgs":[Ljava/lang/String;
    .end local v12    # "pdus":[[B
    .end local v19    # "intent":Landroid/content/Intent;
    .end local v22    # "resultReceiver":Landroid/content/BroadcastReceiver;
    .end local v33    # "address":Ljava/lang/String;
    .end local v37    # "count":Ljava/lang/String;
    .end local v41    # "cursorCount":I
    .end local v61    # "refNumber":Ljava/lang/String;
    :catchall_0
    move-exception v4

    if-eqz v40, :cond_18

    .line 588
    invoke-interface/range {v40 .. v40}, Landroid/database/Cursor;->close()V

    :cond_18
    throw v4

    .line 616
    .end local v40    # "cursor":Landroid/database/Cursor;
    .restart local v12    # "pdus":[[B
    .restart local v22    # "resultReceiver":Landroid/content/BroadcastReceiver;
    .restart local v24    # "smscAddress":Ljava/lang/String;
    .restart local v25    # "originatingAddress":Ljava/lang/String;
    .restart local v35    # "arr$":[[B
    .restart local v50    # "i$":I
    .restart local v53    # "isSafeSMSCheck":Z
    .restart local v54    # "len$":I
    .restart local v55    # "msg":Landroid/telephony/SmsMessage;
    .restart local v57    # "output":Ljava/io/ByteArrayOutputStream;
    .restart local v58    # "pdu":[B
    .restart local v62    # "result":I
    :cond_19
    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getUserData()[B

    move-result-object v58

    .line 655
    .end local v55    # "msg":Landroid/telephony/SmsMessage;
    :cond_1a
    :goto_a
    const/4 v4, 0x0

    move-object/from16 v0, v58

    array-length v5, v0

    move-object/from16 v0, v57

    move-object/from16 v1, v58

    invoke-virtual {v0, v1, v4, v5}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto/16 :goto_2

    .line 620
    :cond_1b
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->is3gpp2()Z

    move-result v4

    if-nez v4, :cond_1a

    .line 621
    const-string v4, "3gpp"

    move-object/from16 v0, v58

    invoke-static {v0, v4}, Landroid/telephony/SmsMessage;->createFromPdu([BLjava/lang/String;)Landroid/telephony/SmsMessage;

    move-result-object v55

    .line 623
    .restart local v55    # "msg":Landroid/telephony/SmsMessage;
    if-eqz v55, :cond_1a

    .line 624
    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getServiceCenterAddress()Ljava/lang/String;

    move-result-object v24

    .line 625
    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v25

    .line 628
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "SafeSMSforMMSNoti"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1e

    .line 629
    if-nez v53, :cond_1d

    .line 630
    const/16 v53, 0x1

    .line 632
    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v4

    if-eqz v4, :cond_1c

    .line 633
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "SAFE SMS isSafeSMSCheck = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v5

    iget-byte v5, v5, Lcom/android/internal/telephony/SmsHeader;->safeSMS:B

    and-int/lit8 v5, v5, 0x2

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 634
    const/4 v4, 0x0

    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v5

    iget-byte v5, v5, Lcom/android/internal/telephony/SmsHeader;->safeSMS:B

    aput-byte v5, v58, v4

    .line 635
    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getUserData()[B

    move-result-object v4

    const/4 v5, 0x0

    const/4 v6, 0x1

    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getUserData()[B

    move-result-object v7

    array-length v7, v7

    move-object/from16 v0, v58

    invoke-static {v4, v5, v0, v6, v7}, Ljava/lang/System;->arraycopy([BI[BII)V

    goto :goto_a

    .line 637
    :cond_1c
    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getUserData()[B

    move-result-object v58

    goto :goto_a

    .line 640
    :cond_1d
    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getUserData()[B

    move-result-object v58

    goto :goto_a

    .line 644
    :cond_1e
    invoke-virtual/range {v55 .. v55}, Landroid/telephony/SmsMessage;->getUserData()[B

    move-result-object v58

    goto/16 :goto_a

    .line 658
    .end local v55    # "msg":Landroid/telephony/SmsMessage;
    .end local v58    # "pdu":[B
    :cond_1f
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mWapPush:Lcom/android/internal/telephony/WapPushOverSmsEx;

    move-object/from16 v20, v0

    invoke-virtual/range {v57 .. v57}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v21

    move-object/from16 v23, p0

    invoke-virtual/range {v20 .. v25}, Lcom/android/internal/telephony/WapPushOverSmsEx;->dispatchWapPdu([BLandroid/content/BroadcastReceiver;Lcom/android/internal/telephony/InboundSmsHandler;Ljava/lang/String;Ljava/lang/String;)I

    move-result v62

    .line 663
    const/4 v4, -0x1

    move/from16 v0, v62

    if-eq v0, v4, :cond_20

    .line 664
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v4

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-virtual {v0, v4, v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 668
    :cond_20
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "dispatchWapPdu() returned "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v62

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 670
    const/4 v4, -0x1

    move/from16 v0, v62

    if-ne v0, v4, :cond_21

    const/4 v4, 0x1

    goto/16 :goto_5

    :cond_21
    const/4 v4, 0x0

    goto/16 :goto_5

    .line 673
    .end local v24    # "smscAddress":Ljava/lang/String;
    .end local v25    # "originatingAddress":Ljava/lang/String;
    .end local v35    # "arr$":[[B
    .end local v50    # "i$":I
    .end local v53    # "isSafeSMSCheck":Z
    .end local v54    # "len$":I
    .end local v57    # "output":Ljava/io/ByteArrayOutputStream;
    .end local v62    # "result":I
    :cond_22
    const/4 v4, -0x1

    move/from16 v0, v42

    if-ne v0, v4, :cond_25

    .line 675
    const/4 v4, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v22

    invoke-virtual {v0, v1, v12, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->processSPTSMessage(Lcom/android/internal/telephony/InboundSmsTracker;[[BLandroid/content/BroadcastReceiver;)Z

    move-result v5

    if-ne v4, v5, :cond_23

    .line 676
    const/4 v4, 0x1

    goto/16 :goto_5

    .line 680
    :cond_23
    const/4 v4, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v22

    invoke-virtual {v0, v1, v12, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->processMcAfeeMessage(Lcom/android/internal/telephony/InboundSmsTracker;[[BLandroid/content/BroadcastReceiver;)Z

    move-result v5

    if-ne v4, v5, :cond_24

    .line 681
    const/4 v4, 0x1

    goto/16 :goto_5

    .line 685
    :cond_24
    const/4 v4, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v22

    invoke-virtual {v0, v1, v12, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->processKizONMessage(Lcom/android/internal/telephony/InboundSmsTracker;[[BLandroid/content/BroadcastReceiver;)Z

    move-result v5

    if-ne v4, v5, :cond_25

    .line 686
    const/4 v4, 0x1

    goto/16 :goto_5

    .line 692
    :cond_25
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "OperatorMessage"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_26

    .line 693
    const-string v4, "operator message"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 694
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v22

    invoke-virtual {v0, v1, v12, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->processOperatorMessage(Lcom/android/internal/telephony/InboundSmsTracker;[[BLandroid/content/BroadcastReceiver;)I

    move-result v62

    .line 695
    .restart local v62    # "result":I
    const/16 v4, 0xb

    move/from16 v0, v62

    if-eq v0, v4, :cond_26

    .line 696
    const/4 v4, 0x1

    goto/16 :goto_5

    .line 702
    .end local v62    # "result":I
    :cond_26
    const/4 v4, -0x1

    move/from16 v0, v42

    if-ne v0, v4, :cond_2f

    .line 703
    const-string v4, "[sms.mt] processMessagePart destPort is not -1"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 706
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "allow_sending_MBP_directed_sms"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_28

    .line 707
    const/16 v62, 0xb

    .line 710
    .restart local v62    # "result":I
    :try_start_6
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    const-string v5, "de.telekom.mds.mbp"

    const/4 v6, 0x0

    invoke-virtual {v4, v5, v6}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v34

    .line 711
    .local v34, "ai":Landroid/content/pm/ApplicationInfo;
    move-object/from16 v0, v34

    iget-boolean v4, v0, Landroid/content/pm/ApplicationInfo;->enabled:Z

    if-eqz v4, :cond_27

    .line 712
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v22

    invoke-direct {v0, v1, v11, v12, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->processMobileboxProDirectedSMS(Lcom/android/internal/telephony/InboundSmsTracker;I[[BLandroid/content/BroadcastReceiver;)I
    :try_end_6
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_6 .. :try_end_6} :catch_1

    move-result v62

    .line 718
    .end local v34    # "ai":Landroid/content/pm/ApplicationInfo;
    :cond_27
    :goto_b
    const/16 v4, 0xb

    move/from16 v0, v62

    if-eq v0, v4, :cond_28

    .line 719
    const/4 v4, 0x1

    goto/16 :goto_5

    .line 714
    :catch_1
    move-exception v46

    .line 715
    .local v46, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    const-string v4, "[sms.mt] MobileboxPro is not installed"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_b

    .line 725
    .end local v46    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    .end local v62    # "result":I
    :cond_28
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "app_directed_sms"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_29

    .line 726
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v22

    invoke-direct {v0, v1, v11, v12, v2}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->processDirectedSMS(Lcom/android/internal/telephony/InboundSmsTracker;I[[BLandroid/content/BroadcastReceiver;)I

    move-result v62

    .line 727
    .restart local v62    # "result":I
    const/16 v4, 0xb

    move/from16 v0, v62

    if-eq v0, v4, :cond_29

    .line 728
    const/4 v4, 0x1

    goto/16 :goto_5

    .line 734
    .end local v62    # "result":I
    :cond_29
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "legacy_vvm_not_save"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2a

    .line 735
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-direct {v0, v1, v11, v12}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->processLegacyVVM(Lcom/android/internal/telephony/InboundSmsTracker;I[[B)I

    move-result v62

    .line 736
    .restart local v62    # "result":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[sms.mt.legacyVVM] processLegacyVVM result =["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v62

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 737
    const/4 v4, 0x1

    move/from16 v0, v62

    if-ne v0, v4, :cond_2a

    .line 738
    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhere()Ljava/lang/String;

    move-result-object v4

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getDeleteWhereArgs()[Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-virtual {v0, v4, v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->deleteFromRawTable(Ljava/lang/String;[Ljava/lang/String;)V

    .line 739
    const/4 v4, 0x3

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->sendMessage(I)V

    .line 740
    const/4 v4, 0x1

    goto/16 :goto_5

    .line 746
    .end local v62    # "result":I
    :cond_2a
    new-instance v19, Landroid/content/Intent;

    const-string v4, "android.provider.Telephony.SMS_DELIVER"

    move-object/from16 v0, v19

    invoke-direct {v0, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 750
    .restart local v19    # "intent":Landroid/content/Intent;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const/4 v5, 0x1

    invoke-static {v4, v5}, Lcom/android/internal/telephony/SmsApplication;->getDefaultSmsApplication(Landroid/content/Context;Z)Landroid/content/ComponentName;

    move-result-object v36

    .line 751
    .local v36, "componentName":Landroid/content/ComponentName;
    if-eqz v36, :cond_2b

    .line 753
    move-object/from16 v0, v19

    move-object/from16 v1, v36

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 754
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Delivering SMS to: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual/range {v36 .. v36}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual/range {v36 .. v36}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-virtual {v0, v4}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    .line 762
    .end local v36    # "componentName":Landroid/content/ComponentName;
    :cond_2b
    :goto_c
    const-string v4, "pdus"

    move-object/from16 v0, v19

    invoke-virtual {v0, v4, v12}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 763
    const-string v4, "format"

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->getFormat()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v19

    invoke-virtual {v0, v4, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 765
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "seperate_processing_sms_uicc"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2c

    .line 766
    const/4 v4, 0x1

    if-ne v11, v4, :cond_30

    .line 767
    const-string v4, "indexOnIcc"

    invoke-virtual/range {p1 .. p1}, Lcom/android/internal/telephony/InboundSmsTracker;->lgeGetIndexOnIcc()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v19

    invoke-virtual {v0, v4, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 774
    :cond_2c
    :goto_d
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "concat_stitching"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2d

    move-object/from16 v26, p0

    move/from16 v27, v11

    move/from16 v28, v13

    move/from16 v29, v14

    move/from16 v30, v15

    move-object/from16 v31, v16

    move-object/from16 v32, v19

    .line 775
    invoke-direct/range {v26 .. v32}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->handleConcatStitching2(IZZZLjava/lang/String;Landroid/content/Intent;)V

    .line 780
    :cond_2d
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "SafeSMS"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2e

    .line 781
    const/4 v4, 0x0

    aget-object v4, v12, v4

    move-object/from16 v0, v19

    invoke-static {v0, v4}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->makeSafeSmsField(Landroid/content/Intent;[B)V

    .line 785
    :cond_2e
    const-string v20, "android.permission.RECEIVE_SMS"

    const/16 v21, 0x10

    sget-object v23, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    move-object/from16 v18, p0

    invoke-virtual/range {v18 .. v23}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 787
    const/4 v4, 0x1

    goto/16 :goto_5

    .line 758
    .end local v19    # "intent":Landroid/content/Intent;
    :cond_2f
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "sms://localhost:"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v42

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v64

    .line 759
    .local v64, "uri":Landroid/net/Uri;
    new-instance v19, Landroid/content/Intent;

    const-string v4, "android.intent.action.DATA_SMS_RECEIVED"

    move-object/from16 v0, v19

    move-object/from16 v1, v64

    invoke-direct {v0, v4, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .restart local v19    # "intent":Landroid/content/Intent;
    goto/16 :goto_c

    .line 769
    .end local v64    # "uri":Landroid/net/Uri;
    :cond_30
    const-string v4, "indexOnIcc"

    move-object/from16 v0, v19

    move-object/from16 v1, v51

    invoke-virtual {v0, v4, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_d
.end method

.method protected processMessagePartKRTestBed([BLjava/lang/String;IIIJIZLjava/lang/String;Lcom/android/internal/telephony/InboundSmsTracker;)I
    .locals 38
    .param p1, "pdu"    # [B
    .param p2, "address"    # Ljava/lang/String;
    .param p3, "referenceNumber"    # I
    .param p4, "sequenceNumber"    # I
    .param p5, "messageCount"    # I
    .param p6, "timestamp"    # J
    .param p8, "destPort"    # I
    .param p9, "isCdmaWapPush"    # Z
    .param p10, "serviceCenter"    # Ljava/lang/String;
    .param p11, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;

    .prologue
    .line 1730
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v14

    .line 1733
    .local v14, "firstTime":J
    const/16 v31, 0x0

    check-cast v31, [[B

    .line 1734
    .local v31, "pdus":[[B
    const/16 v25, 0x0

    .line 1737
    .local v25, "cursor":Landroid/database/Cursor;
    :try_start_0
    invoke-static/range {p3 .. p3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v32

    .line 1738
    .local v32, "refNumber":Ljava/lang/String;
    invoke-static/range {p4 .. p4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v33

    .line 1741
    .local v33, "seqNumber":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mRawUri:Landroid/net/Uri;

    sget-object v6, Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_PROJECTION:[Ljava/lang/String;

    const-string v7, "address=? AND reference_number=? AND sequence=?"

    const/4 v8, 0x3

    new-array v8, v8, [Ljava/lang/String;

    const/4 v9, 0x0

    aput-object p2, v8, v9

    const/4 v9, 0x1

    aput-object v32, v8, v9

    const/4 v9, 0x2

    aput-object v33, v8, v9

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v25

    .line 1745
    if-eqz v25, :cond_9

    .line 1747
    invoke-interface/range {v25 .. v25}, Landroid/database/Cursor;->moveToNext()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 1748
    const-string v4, "Mms Testbed"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Discarding duplicate message segment from address="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, p2

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " refNumber="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, v32

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " seqNumber="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, v33

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1750
    const/4 v4, 0x0

    move-object/from16 v0, v25

    invoke-interface {v0, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v29

    .line 1751
    .local v29, "oldPduString":Ljava/lang/String;
    invoke-static/range {v29 .. v29}, Lcom/android/internal/util/HexDump;->hexStringToByteArray(Ljava/lang/String;)[B

    move-result-object v28

    .line 1752
    .local v28, "oldPdu":[B
    move-object/from16 v0, v28

    move-object/from16 v1, p1

    invoke-static {v0, v1}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v4

    if-nez v4, :cond_0

    .line 1753
    const-string v4, "Mms Testbed"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Warning: dup message segment PDU of length "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, p1

    array-length v6, v0

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " is different from existing PDU of length "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, v28

    array-length v6, v0

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/database/SQLException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1756
    :cond_0
    const/4 v4, 0x1

    .line 1849
    if-eqz v25, :cond_1

    invoke-interface/range {v25 .. v25}, Landroid/database/Cursor;->close()V

    :cond_1
    move-object/from16 v11, v31

    .line 1895
    .end local v28    # "oldPdu":[B
    .end local v29    # "oldPduString":Ljava/lang/String;
    .end local v31    # "pdus":[[B
    .end local v32    # "refNumber":Ljava/lang/String;
    .end local v33    # "seqNumber":Ljava/lang/String;
    .local v11, "pdus":[[B
    :cond_2
    :goto_0
    return v4

    .line 1758
    .end local v11    # "pdus":[[B
    .restart local v31    # "pdus":[[B
    .restart local v32    # "refNumber":Ljava/lang/String;
    .restart local v33    # "seqNumber":Ljava/lang/String;
    :cond_3
    :try_start_1
    invoke-interface/range {v25 .. v25}, Landroid/database/Cursor;->close()V

    .line 1765
    :goto_1
    const-string v7, ""

    .line 1766
    .local v7, "where":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "cdma_kr_testbed_mms_receive"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_a

    if-eqz p9, :cond_a

    .line 1767
    new-instance v37, Ljava/lang/StringBuilder;

    const-string v4, "reference_number ="

    move-object/from16 v0, v37

    invoke-direct {v0, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 1768
    .local v37, "whereTemp":Ljava/lang/StringBuilder;
    move-object/from16 v0, v37

    move-object/from16 v1, v32

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1769
    invoke-virtual/range {v37 .. v37}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 1774
    .end local v37    # "whereTemp":Ljava/lang/StringBuilder;
    :goto_2
    const/4 v4, 0x2

    new-array v0, v4, [Ljava/lang/String;

    move-object/from16 v36, v0

    const/4 v4, 0x0

    aput-object p2, v36, v4

    const/4 v4, 0x1

    aput-object v32, v36, v4

    .line 1775
    .local v36, "whereArgs":[Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "cdma_kr_testbed_mms_receive"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_b

    if-eqz p9, :cond_b

    .line 1776
    const-string v4, "Mms Testbed"

    const-string v5, "processMessagePart() - KEY_CDMA_MMS_RECEIVE and CDMA WAP PUSH - RawUri query"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1777
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mRawUri:Landroid/net/Uri;

    sget-object v6, Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_SEQUENCE_PORT_ICC_TIME_PROJECTION:[Ljava/lang/String;

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v25

    .line 1789
    :goto_3
    if-eqz v25, :cond_12

    .line 1790
    invoke-interface/range {v25 .. v25}, Landroid/database/Cursor;->getCount()I

    move-result v13

    .line 1791
    .local v13, "cursorCount":I
    add-int/lit8 v4, p5, -0x1

    if-eq v13, v4, :cond_d

    .line 1793
    new-instance v35, Landroid/content/ContentValues;

    invoke-direct/range {v35 .. v35}, Landroid/content/ContentValues;-><init>()V

    .line 1794
    .local v35, "values":Landroid/content/ContentValues;
    const-string v4, "date"

    invoke-static/range {p6 .. p7}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    move-object/from16 v0, v35

    invoke-virtual {v0, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    .line 1795
    const-string v4, "pdu"

    invoke-static/range {p1 .. p1}, Lcom/android/internal/util/HexDump;->toHexString([B)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v35

    invoke-virtual {v0, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1796
    const-string v4, "address"

    move-object/from16 v0, v35

    move-object/from16 v1, p2

    invoke-virtual {v0, v4, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 1797
    const-string v4, "reference_number"

    invoke-static/range {p3 .. p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    move-object/from16 v0, v35

    invoke-virtual {v0, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 1798
    const-string v4, "count"

    invoke-static/range {p5 .. p5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    move-object/from16 v0, v35

    invoke-virtual {v0, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 1799
    const-string v4, "sequence"

    invoke-static/range {p4 .. p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    move-object/from16 v0, v35

    invoke-virtual {v0, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 1800
    const/4 v4, -0x1

    move/from16 v0, p8

    if-eq v0, v4, :cond_4

    .line 1801
    const-string v4, "destination_port"

    invoke-static/range {p8 .. p8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    move-object/from16 v0, v35

    invoke-virtual {v0, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 1804
    :cond_4
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "ems_segment_timer"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 1805
    invoke-interface/range {v25 .. v25}, Landroid/database/Cursor;->getCount()I

    move-result v4

    if-lez v4, :cond_5

    .line 1806
    invoke-interface/range {v25 .. v25}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v4

    if-eqz v4, :cond_5

    .line 1807
    const-string v4, "time"

    move-object/from16 v0, v25

    invoke-interface {v0, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v34

    .line 1808
    .local v34, "timeColumn":I
    move-object/from16 v0, v25

    move/from16 v1, v34

    invoke-interface {v0, v1}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v14

    .line 1811
    .end local v34    # "timeColumn":I
    :cond_5
    const-string v4, "time"

    new-instance v5, Ljava/lang/Long;

    invoke-direct {v5, v14, v15}, Ljava/lang/Long;-><init>(J)V

    move-object/from16 v0, v35

    invoke-virtual {v0, v4, v5}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    .line 1814
    :cond_6
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mRawUri:Landroid/net/Uri;

    move-object/from16 v0, v35

    invoke-virtual {v4, v5, v0}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    .line 1816
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "ems_segment_timer"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_7

    .line 1817
    new-instance v4, Ljava/lang/Thread;

    new-instance v9, Lcom/android/internal/telephony/InboundSmsHandlerEx$EMSSegmentExpirationRunnable;

    move-object/from16 v10, p0

    move-object/from16 v11, p2

    move/from16 v12, p3

    move/from16 v13, p5

    invoke-direct/range {v9 .. v15}, Lcom/android/internal/telephony/InboundSmsHandlerEx$EMSSegmentExpirationRunnable;-><init>(Lcom/android/internal/telephony/InboundSmsHandlerEx;Ljava/lang/String;IIJ)V

    .end local v13    # "cursorCount":I
    invoke-direct {v4, v9}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v4}, Ljava/lang/Thread;->start()V
    :try_end_1
    .catch Landroid/database/SQLException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1820
    :cond_7
    const/4 v4, 0x1

    .line 1849
    if-eqz v25, :cond_8

    invoke-interface/range {v25 .. v25}, Landroid/database/Cursor;->close()V

    :cond_8
    move-object/from16 v11, v31

    .end local v31    # "pdus":[[B
    .restart local v11    # "pdus":[[B
    goto/16 :goto_0

    .line 1760
    .end local v7    # "where":Ljava/lang/String;
    .end local v11    # "pdus":[[B
    .end local v35    # "values":Landroid/content/ContentValues;
    .end local v36    # "whereArgs":[Ljava/lang/String;
    .restart local v31    # "pdus":[[B
    :cond_9
    :try_start_2
    const-string v4, "Mms Testbed"

    const-string v5, "SMSDispatcher.processMessagePartKRTestBed(): mResolver.query() returned null"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Landroid/database/SQLException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto/16 :goto_1

    .line 1845
    .end local v32    # "refNumber":Ljava/lang/String;
    .end local v33    # "seqNumber":Ljava/lang/String;
    :catch_0
    move-exception v26

    move-object/from16 v11, v31

    .line 1846
    .end local v31    # "pdus":[[B
    .restart local v11    # "pdus":[[B
    .local v26, "e":Landroid/database/SQLException;
    :goto_4
    :try_start_3
    const-string v4, "Mms Testbed"

    const-string v5, "Can\'t access multipart SMS database"

    move-object/from16 v0, v26

    invoke-static {v4, v5, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1847
    const/4 v4, 0x2

    .line 1849
    if-eqz v25, :cond_2

    invoke-interface/range {v25 .. v25}, Landroid/database/Cursor;->close()V

    goto/16 :goto_0

    .line 1771
    .end local v11    # "pdus":[[B
    .end local v26    # "e":Landroid/database/SQLException;
    .restart local v7    # "where":Ljava/lang/String;
    .restart local v31    # "pdus":[[B
    .restart local v32    # "refNumber":Ljava/lang/String;
    .restart local v33    # "seqNumber":Ljava/lang/String;
    :cond_a
    :try_start_4
    const-string v7, "address=? AND reference_number=?"

    goto/16 :goto_2

    .line 1781
    .restart local v36    # "whereArgs":[Ljava/lang/String;
    :cond_b
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "ems_segment_timer"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_c

    .line 1782
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mRawUri:Landroid/net/Uri;

    sget-object v6, Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_SEQUENCE_PORT_ICC_TIME_PROJECTION:[Ljava/lang/String;

    const/4 v9, 0x0

    move-object/from16 v8, v36

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v25

    goto/16 :goto_3

    .line 1784
    :cond_c
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mRawUri:Landroid/net/Uri;

    sget-object v6, Lcom/android/internal/telephony/InboundSmsHandlerEx;->PDU_SEQUENCE_PORT_ICC_PROJECTION:[Ljava/lang/String;

    const/4 v9, 0x0

    move-object/from16 v8, v36

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v25

    goto/16 :goto_3

    .line 1824
    .restart local v13    # "cursorCount":I
    :cond_d
    move/from16 v0, p5

    new-array v11, v0, [[B
    :try_end_4
    .catch Landroid/database/SQLException; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .end local v31    # "pdus":[[B
    .restart local v11    # "pdus":[[B
    move-object/from16 v8, p0

    move/from16 v9, p8

    move/from16 v10, p9

    move-object/from16 v12, v25

    .line 1825
    :try_start_5
    invoke-direct/range {v8 .. v13}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->handleMsgKRTestbed(IZ[[BLandroid/database/Cursor;I)I

    move-result p8

    .line 1829
    if-eqz p9, :cond_f

    .line 1830
    aput-object p1, v11, p4

    .line 1836
    :goto_5
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v5, "cdma_kr_testbed_mms_receive"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_10

    if-eqz p9, :cond_10

    .line 1837
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mRawUri:Landroid/net/Uri;

    const/4 v6, 0x0

    invoke-virtual {v4, v5, v7, v6}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    :try_end_5
    .catch Landroid/database/SQLException; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 1849
    .end local v13    # "cursorCount":I
    :goto_6
    if-eqz v25, :cond_e

    invoke-interface/range {v25 .. v25}, Landroid/database/Cursor;->close()V

    .line 1853
    :cond_e
    if-nez v11, :cond_13

    .line 1854
    const/4 v4, -0x1

    goto/16 :goto_0

    .line 1832
    .restart local v13    # "cursorCount":I
    :cond_f
    add-int/lit8 v4, p4, -0x1

    :try_start_6
    aput-object p1, v11, v4

    goto :goto_5

    .line 1845
    :catch_1
    move-exception v26

    goto :goto_4

    .line 1839
    :cond_10
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mResolver:Landroid/content/ContentResolver;

    sget-object v5, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mRawUri:Landroid/net/Uri;

    move-object/from16 v0, v36

    invoke-virtual {v4, v5, v7, v0}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    :try_end_6
    .catch Landroid/database/SQLException; {:try_start_6 .. :try_end_6} :catch_1
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_6

    .line 1849
    .end local v7    # "where":Ljava/lang/String;
    .end local v13    # "cursorCount":I
    .end local v32    # "refNumber":Ljava/lang/String;
    .end local v33    # "seqNumber":Ljava/lang/String;
    .end local v36    # "whereArgs":[Ljava/lang/String;
    :catchall_0
    move-exception v4

    :goto_7
    if-eqz v25, :cond_11

    invoke-interface/range {v25 .. v25}, Landroid/database/Cursor;->close()V

    :cond_11
    throw v4

    .line 1842
    .end local v11    # "pdus":[[B
    .restart local v7    # "where":Ljava/lang/String;
    .restart local v31    # "pdus":[[B
    .restart local v32    # "refNumber":Ljava/lang/String;
    .restart local v33    # "seqNumber":Ljava/lang/String;
    .restart local v36    # "whereArgs":[Ljava/lang/String;
    :cond_12
    :try_start_7
    const-string v4, "Mms Testbed"

    const-string v5, "SMSDispatcher.processMessagePartKRTestBed(): mResolver.query() returned null"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_7
    .catch Landroid/database/SQLException; {:try_start_7 .. :try_end_7} :catch_0
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    move-object/from16 v11, v31

    .end local v31    # "pdus":[[B
    .restart local v11    # "pdus":[[B
    goto :goto_6

    .line 1857
    :cond_13
    new-instance v18, Lcom/android/internal/telephony/InboundSmsHandler$SmsBroadcastReceiver;

    move-object/from16 v0, v18

    move-object/from16 v1, p0

    move-object/from16 v2, p11

    invoke-direct {v0, v1, v2}, Lcom/android/internal/telephony/InboundSmsHandler$SmsBroadcastReceiver;-><init>(Lcom/android/internal/telephony/InboundSmsHandler;Lcom/android/internal/telephony/InboundSmsTracker;)V

    .line 1860
    .local v18, "resultReceiver":Landroid/content/BroadcastReceiver;
    if-eqz p9, :cond_16

    .line 1862
    new-instance v30, Ljava/io/ByteArrayOutputStream;

    invoke-direct/range {v30 .. v30}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 1863
    .local v30, "output":Ljava/io/ByteArrayOutputStream;
    const/16 v27, 0x0

    .local v27, "i":I
    :goto_8
    move/from16 v0, v27

    move/from16 v1, p5

    if-ge v0, v1, :cond_14

    .line 1865
    aget-object v4, v11, v27

    const/4 v5, 0x0

    aget-object v6, v11, v27

    array-length v6, v6

    move-object/from16 v0, v30

    invoke-virtual {v0, v4, v5, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 1863
    add-int/lit8 v27, v27, 0x1

    goto :goto_8

    .line 1867
    :cond_14
    invoke-virtual/range {v30 .. v30}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v17

    .line 1870
    .local v17, "datagram":[B
    const/16 v4, 0xb84

    move/from16 v0, p8

    if-ne v0, v4, :cond_15

    .line 1872
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mWapPush:Lcom/android/internal/telephony/WapPushOverSmsEx;

    move-object/from16 v16, v0

    const-string v20, ""

    const-string v21, ""

    move-object/from16 v19, p0

    invoke-virtual/range {v16 .. v21}, Lcom/android/internal/telephony/WapPushOverSmsEx;->dispatchWapPdu([BLandroid/content/BroadcastReceiver;Lcom/android/internal/telephony/InboundSmsHandler;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    goto/16 :goto_0

    .line 1874
    :cond_15
    const/4 v4, 0x1

    new-array v11, v4, [[B

    .line 1875
    const/4 v4, 0x0

    aput-object v17, v11, v4

    .line 1877
    move-object/from16 v0, p0

    move/from16 v1, p8

    invoke-virtual {v0, v11, v1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchPortAddressedPdus([[BI)V

    .line 1878
    const/4 v4, -0x1

    goto/16 :goto_0

    .line 1883
    .end local v17    # "datagram":[B
    .end local v27    # "i":I
    .end local v30    # "output":Ljava/io/ByteArrayOutputStream;
    :cond_16
    const/4 v4, -0x1

    move/from16 v0, p8

    if-eq v0, v4, :cond_18

    .line 1884
    const/16 v4, 0xb84

    move/from16 v0, p8

    if-ne v0, v4, :cond_17

    move-object/from16 v19, p0

    move-object/from16 v20, p2

    move/from16 v21, p5

    move-object/from16 v22, p10

    move-object/from16 v23, v11

    move-object/from16 v24, v18

    .line 1885
    invoke-direct/range {v19 .. v24}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchPduKRTestbed(Ljava/lang/String;ILjava/lang/String;[[BLandroid/content/BroadcastReceiver;)I

    move-result v4

    goto/16 :goto_0

    .line 1888
    :cond_17
    move-object/from16 v0, p0

    move/from16 v1, p8

    invoke-virtual {v0, v11, v1}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchPortAddressedPdus([[BI)V

    .line 1895
    :goto_9
    const/4 v4, -0x1

    goto/16 :goto_0

    .line 1893
    :cond_18
    move-object/from16 v0, p0

    invoke-virtual {v0, v11}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchPdus([[B)V

    goto :goto_9

    .line 1849
    .end local v7    # "where":Ljava/lang/String;
    .end local v11    # "pdus":[[B
    .end local v18    # "resultReceiver":Landroid/content/BroadcastReceiver;
    .end local v32    # "refNumber":Ljava/lang/String;
    .end local v33    # "seqNumber":Ljava/lang/String;
    .end local v36    # "whereArgs":[Ljava/lang/String;
    .restart local v31    # "pdus":[[B
    :catchall_1
    move-exception v4

    move-object/from16 v11, v31

    .end local v31    # "pdus":[[B
    .restart local v11    # "pdus":[[B
    goto/16 :goto_7
.end method

.method protected processOperatorMessage(Lcom/android/internal/telephony/InboundSmsTracker;[[BLandroid/content/BroadcastReceiver;)I
    .locals 11
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "pdus"    # [[B
    .param p3, "receiver"    # Landroid/content/BroadcastReceiver;

    .prologue
    const/4 v0, 0x0

    const/4 v8, 0x1

    .line 1405
    const/4 v4, 0x0

    .line 1406
    .local v4, "isConcat":Z
    const/4 v5, 0x0

    .line 1407
    .local v5, "existsPortAddrs":Z
    const/4 v9, 0x0

    .line 1409
    .local v9, "isGsm":Z
    const/4 v6, 0x0

    .line 1410
    .local v6, "sms":Lcom/android/internal/telephony/SmsMessageBase;
    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->is3gpp2()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 1411
    aget-object v2, p2, v0

    invoke-static {v2}, Lcom/android/internal/telephony/cdma/SmsMessage;->createFromPdu([B)Lcom/android/internal/telephony/cdma/SmsMessage;

    move-result-object v6

    .line 1412
    const/4 v9, 0x0

    .line 1418
    :goto_0
    iget-object v2, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v3, "ctc_spam_msg"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-ne v2, v8, :cond_0

    .line 1419
    const/4 v9, 0x1

    .line 1423
    :cond_0
    invoke-virtual {v6}, Lcom/android/internal/telephony/SmsMessageBase;->getUserDataHeader()Lcom/android/internal/telephony/SmsHeader;

    move-result-object v10

    .line 1425
    .local v10, "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    if-eqz v10, :cond_1

    iget-object v2, v10, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    if-eqz v2, :cond_1

    .line 1426
    const/4 v4, 0x1

    .line 1429
    :cond_1
    if-eqz v10, :cond_2

    .line 1430
    iget-object v2, v10, Lcom/android/internal/telephony/SmsHeader;->portAddrs:Lcom/android/internal/telephony/SmsHeader$PortAddrs;

    if-nez v2, :cond_4

    move v5, v0

    .line 1434
    :cond_2
    :goto_1
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v2, "KT_LBS"

    invoke-static {v0, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-ne v0, v8, :cond_5

    .line 1435
    invoke-virtual {v6}, Lcom/android/internal/telephony/SmsMessageBase;->getProtocolIdentifier()I

    move-result v0

    const/16 v2, 0x51

    if-ne v0, v2, :cond_5

    .line 1436
    new-instance v1, Landroid/content/Intent;

    const-string v0, "com.kt.location.action.KTLBS_DATA_SMS_RECEIVED"

    invoke-direct {v1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1437
    .local v1, "intent":Landroid/content/Intent;
    const-string v0, "pdus"

    invoke-virtual {v1, v0, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 1438
    const/16 v0, 0x20

    invoke-virtual {v1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1439
    const-string v2, "android.permission.RECEIVE_SMS"

    const/16 v3, 0x10

    sget-object v5, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    .end local v5    # "existsPortAddrs":Z
    move-object v0, p0

    move-object v4, p3

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchIntent(Landroid/content/Intent;Ljava/lang/String;ILandroid/content/BroadcastReceiver;Landroid/os/UserHandle;)V

    .line 1455
    .end local v1    # "intent":Landroid/content/Intent;
    .end local v4    # "isConcat":Z
    :goto_2
    return v8

    .line 1414
    .end local v10    # "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    .restart local v4    # "isConcat":Z
    .restart local v5    # "existsPortAddrs":Z
    :cond_3
    aget-object v2, p2, v0

    invoke-static {v2}, Lcom/android/internal/telephony/gsm/SmsMessage;->createFromPdu([B)Lcom/android/internal/telephony/gsm/SmsMessage;

    move-result-object v6

    .line 1415
    const/4 v9, 0x1

    goto :goto_0

    .restart local v10    # "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    :cond_4
    move v5, v8

    .line 1430
    goto :goto_1

    .line 1447
    :cond_5
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    .line 1448
    .local v7, "operatorMessageList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/telephony/SmsOperatorBasicMessage;>;"
    if-ne v9, v8, :cond_7

    move-object v2, p0

    move-object v3, p2

    move-object v8, p3

    .line 1449
    invoke-direct/range {v2 .. v8}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->addGsmOperatorMessages([[BZZLcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;Landroid/content/BroadcastReceiver;)V

    .line 1455
    :cond_6
    :goto_3
    invoke-virtual {p0, p1, v6, v7}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchOperatorMessage(Lcom/android/internal/telephony/InboundSmsTracker;Lcom/android/internal/telephony/SmsMessageBase;Ljava/util/ArrayList;)I

    move-result v8

    goto :goto_2

    .line 1451
    :cond_7
    iget-object v0, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v2, "lgu_dispatch"

    invoke-static {v0, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-ne v0, v8, :cond_6

    .line 1452
    const-string v0, "CdmaSmsLGUMessage"

    iget-object v2, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-static {v0, v2, v6, p2, p3}, Lcom/android/internal/telephony/LGSmsTelephonyManager;->getOperatorMessage(Ljava/lang/String;Landroid/content/Context;Lcom/android/internal/telephony/SmsMessageBase;[[BLandroid/content/BroadcastReceiver;)Lcom/lge/telephony/SmsOperatorBasicMessage;

    move-result-object v0

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_3
.end method

.method protected processSPTSMessage(Lcom/android/internal/telephony/InboundSmsTracker;[[BLandroid/content/BroadcastReceiver;)Z
    .locals 8
    .param p1, "tracker"    # Lcom/android/internal/telephony/InboundSmsTracker;
    .param p2, "pdus"    # [[B
    .param p3, "receiver"    # Landroid/content/BroadcastReceiver;

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x1

    .line 1633
    iget-object v4, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const-string v7, "spts_msg"

    invoke-static {v4, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-ne v4, v5, :cond_1

    .line 1634
    iget-object v4, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    .line 1635
    .local v3, "pm":Landroid/content/pm/PackageManager;
    if-eqz v3, :cond_1

    const-string v4, "com.lge.software.infocollector"

    invoke-virtual {v3, v4}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v4

    if-ne v4, v5, :cond_1

    .line 1636
    const/4 v2, 0x0

    .line 1637
    .local v2, "msg":Landroid/telephony/SmsMessage;
    aget-object v7, p2, v6

    invoke-virtual {p1}, Lcom/android/internal/telephony/InboundSmsTracker;->is3gpp2()Z

    move-result v4

    if-eqz v4, :cond_0

    const-string v4, "3gpp2"

    :goto_0
    invoke-static {v7, v4}, Landroid/telephony/SmsMessage;->createFromPdu([BLjava/lang/String;)Landroid/telephony/SmsMessage;

    move-result-object v2

    .line 1638
    if-eqz v2, :cond_1

    .line 1639
    invoke-virtual {v2}, Landroid/telephony/SmsMessage;->getOriginatingAddress()Ljava/lang/String;

    move-result-object v0

    .line 1640
    .local v0, "address":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "processSPTSMessage(), SPTSAddress : "

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1641
    if-eqz v0, :cond_1

    const-string v4, "00000000000"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1642
    new-instance v1, Landroid/content/Intent;

    const-string v4, "com.lge.spts.SMS_RECEIVED"

    invoke-direct {v1, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1643
    .local v1, "intent":Landroid/content/Intent;
    const-string v4, "pdus"

    invoke-virtual {v1, v4, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 1644
    const-string v4, "android.permission.RECEIVE_SMS"

    invoke-virtual {p0, v1, v4, p3}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchEx(Landroid/content/Intent;Ljava/lang/String;Landroid/content/BroadcastReceiver;)V

    move v4, v5

    .line 1650
    .end local v0    # "address":Ljava/lang/String;
    .end local v1    # "intent":Landroid/content/Intent;
    .end local v2    # "msg":Landroid/telephony/SmsMessage;
    .end local v3    # "pm":Landroid/content/pm/PackageManager;
    :goto_1
    return v4

    .line 1637
    .restart local v2    # "msg":Landroid/telephony/SmsMessage;
    .restart local v3    # "pm":Landroid/content/pm/PackageManager;
    :cond_0
    const-string v4, "3gpp"

    goto :goto_0

    .end local v2    # "msg":Landroid/telephony/SmsMessage;
    .end local v3    # "pm":Landroid/content/pm/PackageManager;
    :cond_1
    move v4, v6

    .line 1650
    goto :goto_1
.end method

.method protected processVVM3Pdu(Lcom/android/internal/telephony/SmsMessageBase;)Z
    .locals 8
    .param p1, "sms"    # Lcom/android/internal/telephony/SmsMessageBase;

    .prologue
    const/16 v6, 0x8

    const/4 v7, 0x7

    const/4 v4, 0x0

    .line 1910
    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getMessageBody()Ljava/lang/String;

    move-result-object v0

    .line 1911
    .local v0, "messageBody":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/android/internal/telephony/SmsMessageBase;->getUserData()[B

    move-result-object v2

    .line 1913
    .local v2, "vvm3pdu":[B
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    if-lt v5, v6, :cond_0

    if-eqz v2, :cond_0

    array-length v5, v2

    if-ge v5, v6, :cond_2

    .line 1914
    :cond_0
    const-string v5, "[sms.mt.vvm3] messageBody length or vvm3pdu length is short. return"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1932
    :cond_1
    :goto_0
    return v4

    .line 1918
    :cond_2
    invoke-virtual {v0, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    .line 1919
    .local v1, "vvm3Str":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[sms.mt.vvm3] messageBody = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1920
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[sms.mt.vvm3] vvm3Str = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1921
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[sms.mt.vvm3] vvm3pdu = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {v2}, Lcom/android/internal/util/HexDump;->toHexString([B)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1923
    array-length v5, v2

    add-int/lit8 v5, v5, -0x7

    new-array v3, v5, [B

    .line 1924
    .local v3, "vvm3pduToDispatch":[B
    array-length v5, v2

    add-int/lit8 v5, v5, -0x7

    invoke-static {v2, v7, v3, v4, v5}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 1925
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[sms.mt.vvm3] vvm3pduToDispatch = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {v3}, Lcom/android/internal/util/HexDump;->toHexString([B)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1927
    const-string v5, "UNRECOGNIZED?cmd=STATUS"

    invoke-virtual {v1, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_3

    const-string v5, "MBOXUPDATE?"

    invoke-virtual {v1, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 1928
    :cond_3
    const-string v4, "[sms.mt.vvm3] string match"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->p(Ljava/lang/String;)I

    .line 1929
    invoke-direct {p0, v3}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->dispatchVVM3Pdu([B)V

    .line 1930
    const/4 v4, 0x1

    goto/16 :goto_0
.end method

.method public setDeliverIntentIfNeeded(Landroid/content/Intent;)V
    .locals 9
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 1595
    iget-object v7, p0, Lcom/android/internal/telephony/InboundSmsHandlerEx;->mContext:Landroid/content/Context;

    const/4 v8, 0x1

    invoke-static {v7, v8}, Lcom/android/internal/telephony/SmsApplication;->getDefaultSmsApplication(Landroid/content/Context;Z)Landroid/content/ComponentName;

    move-result-object v2

    .line 1597
    .local v2, "componentName":Landroid/content/ComponentName;
    if-nez p1, :cond_1

    .line 1629
    :cond_0
    :goto_0
    return-void

    .line 1601
    :cond_1
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v7

    if-eqz v7, :cond_2

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v7

    const-string v8, "android.provider.Telephony.SMS_DELIVER"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 1602
    if-eqz v2, :cond_0

    .line 1604
    invoke-virtual {p1, v2}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 1605
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Delivering SMS to: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v2}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v2}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v7}, Lcom/android/internal/telephony/InboundSmsHandlerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1611
    :cond_2
    if-eqz v2, :cond_0

    .line 1613
    invoke-virtual {v2}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v6

    .line 1614
    .local v6, "smsPackage":Ljava/lang/String;
    if-eqz v6, :cond_0

    const-string v7, "com.android.mms"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_0

    .line 1615
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 1616
    .local v0, "action":Ljava/lang/String;
    sget-object v1, Lcom/android/internal/telephony/InboundSmsHandlerEx;->NEED_TO_CHANGE_DELIVER_ACTION:[Ljava/lang/String;

    .local v1, "arr$":[Ljava/lang/String;
    array-length v5, v1

    .local v5, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_1
    if-ge v3, v5, :cond_0

    aget-object v4, v1, v3

    .line 1617
    .local v4, "intentAction":Ljava/lang/String;
    if-eqz v0, :cond_3

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_3

    .line 1620
    const-string v7, "android.provider.Telephony.SMS_DELIVER"

    invoke-virtual {p1, v7}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 1621
    invoke-virtual {p1, v2}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 1622
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setDeliverIntentIfNeeded(), "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " >>>  SMS_DELIVER_ACTION"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1623
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setDeliverIntentIfNeeded(), Delivering SMS to: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v2}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v2}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1616
    :cond_3
    add-int/lit8 v3, v3, 0x1

    goto :goto_1
.end method
