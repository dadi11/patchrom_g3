.class public Lcom/android/internal/telephony/SubscriptionController;
.super Lcom/android/internal/telephony/ISub$Stub;
.source "SubscriptionController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/SubscriptionController$OnDemandDdsLockNotifier;,
        Lcom/android/internal/telephony/SubscriptionController$DataConnectionHandler;,
        Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;
    }
.end annotation


# static fields
.field static final DBG:Z = true

.field private static final EVENT_SET_DEFAULT_DATA_DONE:I = 0x1

.field private static final EVENT_WRITE_MSISDN_DONE:I = 0x1

.field static final LOG_TAG:Ljava/lang/String; = "SubController"

.field static final MAX_LOCAL_LOG_LINES:I = 0x1f4

.field private static final RES_TYPE_BACKGROUND_DARK:I = 0x0

.field private static final RES_TYPE_BACKGROUND_LIGHT:I = 0x1

.field static final VDBG:Z

.field private static mDefaultPhoneId:I

.field private static mDefaultVoiceSubId:J

.field private static mSimInfo:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field private static sInstance:Lcom/android/internal/telephony/SubscriptionController;

.field protected static sProxyPhones:[Lcom/android/internal/telephony/PhoneProxy;

.field private static final sSimBackgroundDarkRes:[I

.field private static final sSimBackgroundLightRes:[I


# instance fields
.field protected mCM:Lcom/android/internal/telephony/CallManager;

.field protected mContext:Landroid/content/Context;

.field private mDataConnectionHandler:Lcom/android/internal/telephony/SubscriptionController$DataConnectionHandler;

.field private mDctController:Lcom/android/internal/telephony/dataconnection/DctController;

.field protected mHandler:Landroid/os/Handler;

.field private mLocalLog:Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;

.field protected final mLock:Ljava/lang/Object;

.field private mOnDemandDdsLockNotificationRegistrants:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Long;",
            "Lcom/android/internal/telephony/SubscriptionController$OnDemandDdsLockNotifier;",
            ">;"
        }
    .end annotation
.end field

.field private mScheduler:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

.field private mSchedulerAc:Lcom/android/internal/telephony/dataconnection/DdsSchedulerAc;

.field protected mSuccess:Z


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 129
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/SubscriptionController;->sInstance:Lcom/android/internal/telephony/SubscriptionController;

    .line 137
    invoke-static {v2}, Lcom/android/internal/telephony/SubscriptionController;->setSimResource(I)[I

    move-result-object v0

    sput-object v0, Lcom/android/internal/telephony/SubscriptionController;->sSimBackgroundDarkRes:[I

    .line 138
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/android/internal/telephony/SubscriptionController;->setSimResource(I)[I

    move-result-object v0

    sput-object v0, Lcom/android/internal/telephony/SubscriptionController;->sSimBackgroundLightRes:[I

    .line 141
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    .line 142
    const-wide v0, 0x7fffffffffffffffL

    sput-wide v0, Lcom/android/internal/telephony/SubscriptionController;->mDefaultVoiceSubId:J

    .line 143
    sput v2, Lcom/android/internal/telephony/SubscriptionController;->mDefaultPhoneId:I

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 4
    .param p1, "c"    # Landroid/content/Context;

    .prologue
    .line 206
    invoke-direct {p0}, Lcom/android/internal/telephony/ISub$Stub;-><init>()V

    .line 85
    new-instance v0, Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;

    const/16 v1, 0x1f4

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;-><init>(I)V

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mLocalLog:Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;

    .line 125
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mLock:Ljava/lang/Object;

    .line 147
    new-instance v0, Lcom/android/internal/telephony/SubscriptionController$1;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SubscriptionController$1;-><init>(Lcom/android/internal/telephony/SubscriptionController;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mHandler:Landroid/os/Handler;

    .line 169
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mOnDemandDdsLockNotificationRegistrants:Ljava/util/HashMap;

    .line 207
    const-string v0, "SubscriptionController init by Context"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 208
    iput-object p1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    .line 209
    invoke-static {}, Lcom/android/internal/telephony/CallManager;->getInstance()Lcom/android/internal/telephony/CallManager;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mCM:Lcom/android/internal/telephony/CallManager;

    .line 211
    const-string v0, "isub"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    if-nez v0, :cond_0

    .line 212
    const-string v0, "isub"

    invoke-static {v0, p0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 215
    :cond_0
    const-string v0, "[SubscriptionController] init by Context"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 216
    new-instance v0, Lcom/android/internal/telephony/SubscriptionController$DataConnectionHandler;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/android/internal/telephony/SubscriptionController$DataConnectionHandler;-><init>(Lcom/android/internal/telephony/SubscriptionController;Lcom/android/internal/telephony/SubscriptionController$1;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mDataConnectionHandler:Lcom/android/internal/telephony/SubscriptionController$DataConnectionHandler;

    .line 218
    invoke-static {}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->makeDdsScheduler()Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mScheduler:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    .line 219
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mScheduler:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v0}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->start()V

    .line 221
    new-instance v0, Lcom/android/internal/telephony/dataconnection/DdsSchedulerAc;

    invoke-direct {v0}, Lcom/android/internal/telephony/dataconnection/DdsSchedulerAc;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mSchedulerAc:Lcom/android/internal/telephony/dataconnection/DdsSchedulerAc;

    .line 222
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mSchedulerAc:Lcom/android/internal/telephony/dataconnection/DdsSchedulerAc;

    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/android/internal/telephony/SubscriptionController;->mDataConnectionHandler:Lcom/android/internal/telephony/SubscriptionController$DataConnectionHandler;

    iget-object v3, p0, Lcom/android/internal/telephony/SubscriptionController;->mScheduler:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v3}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->getHandler()Landroid/os/Handler;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/internal/telephony/dataconnection/DdsSchedulerAc;->connect(Landroid/content/Context;Landroid/os/Handler;Landroid/os/Handler;)V

    .line 224
    return-void
.end method

.method private constructor <init>(Lcom/android/internal/telephony/Phone;)V
    .locals 2
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;

    .prologue
    .line 257
    invoke-direct {p0}, Lcom/android/internal/telephony/ISub$Stub;-><init>()V

    .line 85
    new-instance v0, Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;

    const/16 v1, 0x1f4

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;-><init>(I)V

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mLocalLog:Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;

    .line 125
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mLock:Ljava/lang/Object;

    .line 147
    new-instance v0, Lcom/android/internal/telephony/SubscriptionController$1;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SubscriptionController$1;-><init>(Lcom/android/internal/telephony/SubscriptionController;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mHandler:Landroid/os/Handler;

    .line 169
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mOnDemandDdsLockNotificationRegistrants:Ljava/util/HashMap;

    .line 258
    invoke-interface {p1}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    .line 259
    invoke-static {}, Lcom/android/internal/telephony/CallManager;->getInstance()Lcom/android/internal/telephony/CallManager;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mCM:Lcom/android/internal/telephony/CallManager;

    .line 261
    const-string v0, "isub"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    if-nez v0, :cond_0

    .line 262
    const-string v0, "isub"

    invoke-static {v0, p0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 265
    :cond_0
    const-string v0, "[SubscriptionController] init by Phone"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 266
    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/SubscriptionController;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/SubscriptionController;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 80
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/SubscriptionController;J)V
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/SubscriptionController;
    .param p1, "x1"    # J

    .prologue
    .line 80
    invoke-direct {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->updateDataSubId(J)V

    return-void
.end method

.method private broadcastDefaultDataSubIdChanged(J)V
    .locals 3
    .param p1, "subId"    # J

    .prologue
    .line 1286
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[broadcastDefaultDataSubIdChanged] subId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1287
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.ACTION_DEFAULT_DATA_SUBSCRIPTION_CHANGED"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1288
    .local v0, "intent":Landroid/content/Intent;
    const/high16 v1, 0x20000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1289
    const-string v1, "subscription"

    invoke-virtual {v0, v1, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    .line 1290
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 1291
    return-void
.end method

.method private broadcastDefaultSmsSubIdChanged(J)V
    .locals 3
    .param p1, "subId"    # J

    .prologue
    .line 1159
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[broadcastDefaultSmsSubIdChanged] subId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1160
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.ACTION_DEFAULT_SMS_SUBSCRIPTION_CHANGED"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1161
    .local v0, "intent":Landroid/content/Intent;
    const/high16 v1, 0x20000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1162
    const-string v1, "subscription"

    invoke-virtual {v0, v1, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    .line 1163
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 1164
    return-void
.end method

.method private broadcastDefaultVoiceSubIdChanged(J)V
    .locals 3
    .param p1, "subId"    # J

    .prologue
    .line 1188
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[broadcastDefaultVoiceSubIdChanged] subId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1189
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.ACTION_DEFAULT_VOICE_SUBSCRIPTION_CHANGED"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1190
    .local v0, "intent":Landroid/content/Intent;
    const/high16 v1, 0x20000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1191
    const-string v1, "subscription"

    invoke-virtual {v0, v1, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    .line 1192
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 1193
    return-void
.end method

.method private broadcastSimInfoContentChanged(JLjava/lang/String;ILjava/lang/String;)V
    .locals 3
    .param p1, "subId"    # J
    .param p3, "columnName"    # Ljava/lang/String;
    .param p4, "intContent"    # I
    .param p5, "stringContent"    # Ljava/lang/String;

    .prologue
    .line 288
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.ACTION_SUBINFO_CONTENT_CHANGE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 289
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "_id"

    invoke-virtual {v0, v1, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    .line 290
    const-string v1, "columnName"

    invoke-virtual {v0, v1, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 291
    const-string v1, "intContent"

    invoke-virtual {v0, v1, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 292
    const-string v1, "stringContent"

    invoke-virtual {v0, v1, p5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 293
    const/16 v1, -0x64

    if-eq p4, v1, :cond_0

    .line 294
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[broadcastSimInfoContentChanged] subId"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " changed, "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " -> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 300
    :goto_0
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    .line 301
    return-void

    .line 297
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[broadcastSimInfoContentChanged] subId"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " changed, "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " -> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private enforceSubscriptionPermission()V
    .locals 3

    .prologue
    .line 274
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    const-string v1, "android.permission.READ_PHONE_STATE"

    const-string v2, "Requires READ_PHONE_STATE"

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 276
    return-void
.end method

.method public static getInstance()Lcom/android/internal/telephony/SubscriptionController;
    .locals 2

    .prologue
    .line 198
    sget-object v0, Lcom/android/internal/telephony/SubscriptionController;->sInstance:Lcom/android/internal/telephony/SubscriptionController;

    if-nez v0, :cond_0

    .line 200
    const-string v0, "SubController"

    const-string v1, "getInstance null"

    invoke-static {v0, v1}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I

    .line 203
    :cond_0
    sget-object v0, Lcom/android/internal/telephony/SubscriptionController;->sInstance:Lcom/android/internal/telephony/SubscriptionController;

    return-object v0
.end method

.method private getSubInfo(Ljava/lang/String;Ljava/lang/Object;)Ljava/util/List;
    .locals 10
    .param p1, "selection"    # Ljava/lang/String;
    .param p2, "queryKey"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ")",
            "Ljava/util/List",
            "<",
            "Landroid/telephony/SubInfoRecord;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 358
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "selection:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 359
    const/4 v4, 0x0

    .line 360
    .local v4, "selectionArgs":[Ljava/lang/String;
    if-eqz p2, :cond_0

    .line 361
    const/4 v0, 0x1

    new-array v4, v0, [Ljava/lang/String;

    .end local v4    # "selectionArgs":[Ljava/lang/String;
    const/4 v0, 0x0

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v4, v0

    .line 363
    .restart local v4    # "selectionArgs":[Ljava/lang/String;
    :cond_0
    const/4 v8, 0x0

    .line 364
    .local v8, "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    move-object v3, p1

    move-object v5, v2

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 367
    .local v6, "cursor":Landroid/database/Cursor;
    if-eqz v6, :cond_1

    move-object v9, v8

    .line 368
    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .local v9, "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :goto_0
    :try_start_0
    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 369
    invoke-direct {p0, v6}, Lcom/android/internal/telephony/SubscriptionController;->getSubInfoRecord(Landroid/database/Cursor;)Landroid/telephony/SubInfoRecord;

    move-result-object v7

    .line 370
    .local v7, "subInfo":Landroid/telephony/SubInfoRecord;
    if-eqz v7, :cond_5

    .line 372
    if-nez v9, :cond_4

    .line 374
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 376
    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :goto_1
    :try_start_1
    invoke-virtual {v8, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_2
    move-object v9, v8

    .line 378
    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_0

    .line 380
    .end local v7    # "subInfo":Landroid/telephony/SubInfoRecord;
    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :cond_1
    const-string v0, "Query fail"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 383
    :goto_3
    if-eqz v6, :cond_2

    .line 384
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    .line 388
    :cond_2
    return-object v8

    .line 383
    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :catchall_0
    move-exception v0

    move-object v8, v9

    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :goto_4
    if-eqz v6, :cond_3

    .line 384
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_3
    throw v0

    .line 383
    :catchall_1
    move-exception v0

    goto :goto_4

    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v7    # "subInfo":Landroid/telephony/SubInfoRecord;
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :cond_4
    move-object v8, v9

    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_1

    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :cond_5
    move-object v8, v9

    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_2

    .end local v7    # "subInfo":Landroid/telephony/SubInfoRecord;
    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :cond_6
    move-object v8, v9

    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_3
.end method

.method private getSubInfoRecord(Landroid/database/Cursor;)Landroid/telephony/SubInfoRecord;
    .locals 6
    .param p1, "cursor"    # Landroid/database/Cursor;

    .prologue
    .line 310
    new-instance v0, Landroid/telephony/SubInfoRecord;

    invoke-direct {v0}, Landroid/telephony/SubInfoRecord;-><init>()V

    .line 311
    .local v0, "info":Landroid/telephony/SubInfoRecord;
    const-string v2, "_id"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v2

    iput-wide v2, v0, Landroid/telephony/SubInfoRecord;->subId:J

    .line 312
    const-string v2, "icc_id"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Landroid/telephony/SubInfoRecord;->iccId:Ljava/lang/String;

    .line 314
    const-string v2, "sim_id"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    iput v2, v0, Landroid/telephony/SubInfoRecord;->slotId:I

    .line 316
    const-string v2, "display_name"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Landroid/telephony/SubInfoRecord;->displayName:Ljava/lang/String;

    .line 318
    const-string v2, "name_source"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    iput v2, v0, Landroid/telephony/SubInfoRecord;->nameSource:I

    .line 320
    const-string v2, "color"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    iput v2, v0, Landroid/telephony/SubInfoRecord;->color:I

    .line 322
    const-string v2, "number"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Landroid/telephony/SubInfoRecord;->number:Ljava/lang/String;

    .line 324
    const-string v2, "display_number_format"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    iput v2, v0, Landroid/telephony/SubInfoRecord;->displayNumberFormat:I

    .line 326
    const-string v2, "data_roaming"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    iput v2, v0, Landroid/telephony/SubInfoRecord;->dataRoaming:I

    .line 329
    sget-object v2, Lcom/android/internal/telephony/SubscriptionController;->sSimBackgroundDarkRes:[I

    array-length v1, v2

    .line 330
    .local v1, "size":I
    iget v2, v0, Landroid/telephony/SubInfoRecord;->color:I

    if-ltz v2, :cond_0

    iget v2, v0, Landroid/telephony/SubInfoRecord;->color:I

    if-ge v2, v1, :cond_0

    .line 331
    iget-object v2, v0, Landroid/telephony/SubInfoRecord;->simIconRes:[I

    const/4 v3, 0x0

    sget-object v4, Lcom/android/internal/telephony/SubscriptionController;->sSimBackgroundDarkRes:[I

    iget v5, v0, Landroid/telephony/SubInfoRecord;->color:I

    aget v4, v4, v5

    aput v4, v2, v3

    .line 332
    iget-object v2, v0, Landroid/telephony/SubInfoRecord;->simIconRes:[I

    const/4 v3, 0x1

    sget-object v4, Lcom/android/internal/telephony/SubscriptionController;->sSimBackgroundLightRes:[I

    iget v5, v0, Landroid/telephony/SubInfoRecord;->color:I

    aget v4, v4, v5

    aput v4, v2, v3

    .line 334
    :cond_0
    const-string v2, "mcc"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    iput v2, v0, Landroid/telephony/SubInfoRecord;->mcc:I

    .line 336
    const-string v2, "mnc"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    iput v2, v0, Landroid/telephony/SubInfoRecord;->mnc:I

    .line 338
    const-string v2, "sub_state"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    iput v2, v0, Landroid/telephony/SubInfoRecord;->mStatus:I

    .line 340
    const-string v2, "network_mode"

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v2

    invoke-interface {p1, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    iput v2, v0, Landroid/telephony/SubInfoRecord;->mNwMode:I

    .line 343
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[getSubInfoRecord] SubId:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v4, v0, Landroid/telephony/SubInfoRecord;->subId:J

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " iccid:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Landroid/telephony/SubInfoRecord;->iccId:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " slotId:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Landroid/telephony/SubInfoRecord;->slotId:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " displayName:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Landroid/telephony/SubInfoRecord;->displayName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " color:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Landroid/telephony/SubInfoRecord;->color:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " mcc/mnc:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Landroid/telephony/SubInfoRecord;->mcc:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Landroid/telephony/SubInfoRecord;->mnc:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " subStatus: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Landroid/telephony/SubInfoRecord;->mStatus:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " Nwmode: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v0, Landroid/telephony/SubInfoRecord;->mNwMode:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 348
    return-object v0
.end method

.method public static init(Landroid/content/Context;[Lcom/android/internal/telephony/CommandsInterface;)Lcom/android/internal/telephony/SubscriptionController;
    .locals 4
    .param p0, "c"    # Landroid/content/Context;
    .param p1, "ci"    # [Lcom/android/internal/telephony/CommandsInterface;

    .prologue
    .line 187
    const-class v1, Lcom/android/internal/telephony/SubscriptionController;

    monitor-enter v1

    .line 188
    :try_start_0
    sget-object v0, Lcom/android/internal/telephony/SubscriptionController;->sInstance:Lcom/android/internal/telephony/SubscriptionController;

    if-nez v0, :cond_0

    .line 189
    new-instance v0, Lcom/android/internal/telephony/SubscriptionController;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SubscriptionController;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/android/internal/telephony/SubscriptionController;->sInstance:Lcom/android/internal/telephony/SubscriptionController;

    .line 193
    :goto_0
    sget-object v0, Lcom/android/internal/telephony/SubscriptionController;->sInstance:Lcom/android/internal/telephony/SubscriptionController;

    monitor-exit v1

    return-object v0

    .line 191
    :cond_0
    const-string v0, "SubController"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "init() called multiple times!  sInstance = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/SubscriptionController;->sInstance:Lcom/android/internal/telephony/SubscriptionController;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 194
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public static init(Lcom/android/internal/telephony/Phone;)Lcom/android/internal/telephony/SubscriptionController;
    .locals 4
    .param p0, "phone"    # Lcom/android/internal/telephony/Phone;

    .prologue
    .line 176
    const-class v1, Lcom/android/internal/telephony/SubscriptionController;

    monitor-enter v1

    .line 177
    :try_start_0
    sget-object v0, Lcom/android/internal/telephony/SubscriptionController;->sInstance:Lcom/android/internal/telephony/SubscriptionController;

    if-nez v0, :cond_0

    .line 178
    new-instance v0, Lcom/android/internal/telephony/SubscriptionController;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SubscriptionController;-><init>(Lcom/android/internal/telephony/Phone;)V

    sput-object v0, Lcom/android/internal/telephony/SubscriptionController;->sInstance:Lcom/android/internal/telephony/SubscriptionController;

    .line 182
    :goto_0
    sget-object v0, Lcom/android/internal/telephony/SubscriptionController;->sInstance:Lcom/android/internal/telephony/SubscriptionController;

    monitor-exit v1

    return-object v0

    .line 180
    :cond_0
    const-string v0, "SubController"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "init() called multiple times!  sInstance = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/SubscriptionController;->sInstance:Lcom/android/internal/telephony/SubscriptionController;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 183
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private isSubInfoReady()Z
    .locals 1

    .prologue
    .line 254
    sget-object v0, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->size()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private logd(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 1125
    const-string v0, "SubController"

    invoke-static {v0, p1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1126
    return-void
.end method

.method private logdl(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 1116
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1117
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mLocalLog:Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;->log(Ljava/lang/String;)V

    .line 1118
    return-void
.end method

.method private loge(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 1134
    const-string v0, "SubController"

    invoke-static {v0, p1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1135
    return-void
.end method

.method private logel(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 1129
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/SubscriptionController;->loge(Ljava/lang/String;)V

    .line 1130
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mLocalLog:Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;->log(Ljava/lang/String;)V

    .line 1131
    return-void
.end method

.method private logv(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 1112
    const-string v0, "SubController"

    invoke-static {v0, p1}, Landroid/telephony/Rlog;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 1113
    return-void
.end method

.method private logvl(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 1107
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/SubscriptionController;->logv(Ljava/lang/String;)V

    .line 1108
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mLocalLog:Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;->log(Ljava/lang/String;)V

    .line 1109
    return-void
.end method

.method private static printStackTrace(Ljava/lang/String;)V
    .locals 9
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    .line 1483
    new-instance v4, Ljava/lang/RuntimeException;

    invoke-direct {v4}, Ljava/lang/RuntimeException;-><init>()V

    .line 1484
    .local v4, "re":Ljava/lang/RuntimeException;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "StackTrace - "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/SubscriptionController;->slogd(Ljava/lang/String;)V

    .line 1485
    invoke-virtual {v4}, Ljava/lang/RuntimeException;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v5

    .line 1486
    .local v5, "st":[Ljava/lang/StackTraceElement;
    const/4 v1, 0x1

    .line 1487
    .local v1, "first":Z
    move-object v0, v5

    .local v0, "arr$":[Ljava/lang/StackTraceElement;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_0
    if-ge v2, v3, :cond_1

    aget-object v6, v0, v2

    .line 1488
    .local v6, "ste":Ljava/lang/StackTraceElement;
    if-eqz v1, :cond_0

    .line 1489
    const/4 v1, 0x0

    .line 1487
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1491
    :cond_0
    invoke-virtual {v6}, Ljava/lang/StackTraceElement;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/android/internal/telephony/SubscriptionController;->slogd(Ljava/lang/String;)V

    goto :goto_1

    .line 1494
    .end local v6    # "ste":Ljava/lang/StackTraceElement;
    :cond_1
    return-void
.end method

.method private static setSimResource(I)[I
    .locals 2
    .param p0, "type"    # I

    .prologue
    const/4 v1, 0x4

    .line 1082
    const/4 v0, 0x0

    .line 1084
    .local v0, "simResource":[I
    packed-switch p0, :pswitch_data_0

    .line 1103
    :goto_0
    return-object v0

    .line 1086
    :pswitch_0
    new-array v0, v1, [I

    .end local v0    # "simResource":[I
    fill-array-data v0, :array_0

    .line 1092
    .restart local v0    # "simResource":[I
    goto :goto_0

    .line 1094
    :pswitch_1
    new-array v0, v1, [I

    .end local v0    # "simResource":[I
    fill-array-data v0, :array_1

    .restart local v0    # "simResource":[I
    goto :goto_0

    .line 1084
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
    .end packed-switch

    .line 1086
    :array_0
    .array-data 4
        0x1080614
        0x1080616
        0x1080615
        0x1080617
    .end array-data

    .line 1094
    :array_1
    .array-data 4
        0x1080618
        0x108061a
        0x1080619
        0x108061b
    .end array-data
.end method

.method private shouldDefaultBeCleared(Ljava/util/List;J)Z
    .locals 8
    .param p2, "subId"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Landroid/telephony/SubInfoRecord;",
            ">;J)Z"
        }
    .end annotation

    .prologue
    .local p1, "records":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    const/4 v3, 0x0

    const/4 v2, 0x1

    .line 1353
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[shouldDefaultBeCleared: subId] "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1354
    if-nez p1, :cond_0

    .line 1355
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[shouldDefaultBeCleared] return true no records subId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1371
    :goto_0
    return v2

    .line 1358
    :cond_0
    const-wide/16 v4, -0x3e9

    cmp-long v4, p2, v4

    if-nez v4, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v4

    if-le v4, v2, :cond_1

    .line 1360
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[shouldDefaultBeCleared] return false only one subId, subId="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    move v2, v3

    .line 1361
    goto :goto_0

    .line 1363
    :cond_1
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/telephony/SubInfoRecord;

    .line 1364
    .local v1, "record":Landroid/telephony/SubInfoRecord;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[shouldDefaultBeCleared] Record.subId: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-wide v6, v1, Landroid/telephony/SubInfoRecord;->subId:J

    invoke-virtual {v4, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1365
    iget-wide v4, v1, Landroid/telephony/SubInfoRecord;->subId:J

    cmp-long v4, v4, p2

    if-nez v4, :cond_2

    .line 1366
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[shouldDefaultBeCleared] return false subId is active, subId="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    move v2, v3

    .line 1367
    goto :goto_0

    .line 1370
    .end local v1    # "record":Landroid/telephony/SubInfoRecord;
    :cond_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[shouldDefaultBeCleared] return true not active subId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method private static slogd(Ljava/lang/String;)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;

    .prologue
    .line 1121
    const-string v0, "SubController"

    invoke-static {v0, p0}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1122
    return-void
.end method

.method private updateAllDataConnectionTrackers()V
    .locals 4

    .prologue
    .line 1276
    sget-object v2, Lcom/android/internal/telephony/SubscriptionController;->sProxyPhones:[Lcom/android/internal/telephony/PhoneProxy;

    array-length v0, v2

    .line 1277
    .local v0, "len":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[updateAllDataConnectionTrackers] sProxyPhones.length="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1278
    const/4 v1, 0x0

    .local v1, "phoneId":I
    :goto_0
    if-ge v1, v0, :cond_0

    .line 1279
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[updateAllDataConnectionTrackers] phoneId="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1280
    sget-object v2, Lcom/android/internal/telephony/SubscriptionController;->sProxyPhones:[Lcom/android/internal/telephony/PhoneProxy;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneProxy;->updateDataConnectionTracker()V

    .line 1278
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1282
    :cond_0
    return-void
.end method

.method private updateDataSubId(J)V
    .locals 3
    .param p1, "subId"    # J

    .prologue
    .line 1264
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " updateDataSubId,  subId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1265
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "multi_sim_data_call"

    invoke-static {v0, v1, p1, p2}, Landroid/provider/Settings$Global;->putLong(Landroid/content/ContentResolver;Ljava/lang/String;J)Z

    .line 1267
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mScheduler:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->updateCurrentDds(Landroid/net/NetworkRequest;)V

    .line 1268
    invoke-direct {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->broadcastDefaultDataSubIdChanged(J)V

    .line 1271
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->updateAllDataConnectionTrackers()V

    .line 1272
    return-void
.end method

.method private validateSubId(J)V
    .locals 3
    .param p1, "subId"    # J

    .prologue
    .line 1450
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "validateSubId subId: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1451
    invoke-static {p1, p2}, Landroid/telephony/SubscriptionManager;->isValidSubId(J)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1452
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Invalid sub id passed as parameter"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1453
    :cond_0
    const-wide v0, 0x7fffffffffffffffL

    cmp-long v0, p1, v0

    if-nez v0, :cond_1

    .line 1454
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Default sub id passed as parameter"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1456
    :cond_1
    return-void
.end method


# virtual methods
.method public activateSubId(J)V
    .locals 3
    .param p1, "subId"    # J

    .prologue
    const/4 v2, 0x1

    .line 1549
    invoke-virtual {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->getSubState(J)I

    move-result v1

    if-ne v1, v2, :cond_0

    .line 1550
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "activateSubId: subscription already active, subId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1556
    :goto_0
    return-void

    .line 1554
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->getSlotId(J)I

    move-result v0

    .line 1555
    .local v0, "slotId":I
    invoke-static {}, Lcom/android/internal/telephony/SubscriptionHelper;->getInstance()Lcom/android/internal/telephony/SubscriptionHelper;

    move-result-object v1

    invoke-virtual {v1, v0, v2}, Lcom/android/internal/telephony/SubscriptionHelper;->setUiccSubscription(II)V

    goto :goto_0
.end method

.method public addSubInfoRecord(Ljava/lang/String;I)I
    .locals 27
    .param p1, "iccId"    # Ljava/lang/String;
    .param p2, "slotId"    # I

    .prologue
    .line 579
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[addSubInfoRecord]+ iccId:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, p1

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " slotId:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move/from16 v0, p2

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 580
    invoke-direct/range {p0 .. p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 582
    if-nez p1, :cond_0

    .line 583
    const-string v5, "[addSubInfoRecord]- null iccId"

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 586
    :cond_0
    move-object/from16 v0, p0

    move/from16 v1, p2

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/SubscriptionController;->getSubId(I)[J

    move-result-object v21

    .line 587
    .local v21, "subIds":[J
    if-eqz v21, :cond_1

    move-object/from16 v0, v21

    array-length v5, v0

    if-nez v5, :cond_2

    .line 588
    :cond_1
    const-string v5, "[addSubInfoRecord]- getSubId fail"

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 589
    const/4 v5, 0x0

    .line 703
    :goto_0
    return v5

    .line 593
    :cond_2
    new-instance v13, Lcom/android/internal/telephony/uicc/SpnOverride;

    invoke-direct {v13}, Lcom/android/internal/telephony/uicc/SpnOverride;-><init>()V

    .line 595
    .local v13, "mSpnOverride":Lcom/android/internal/telephony/uicc/SpnOverride;
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    const/4 v6, 0x0

    aget-wide v6, v21, v6

    invoke-virtual {v5, v6, v7}, Landroid/telephony/TelephonyManager;->getSimOperator(J)Ljava/lang/String;

    move-result-object v10

    .line 596
    .local v10, "CarrierName":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[addSubInfoRecord] CarrierName = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 598
    invoke-virtual {v13, v10}, Lcom/android/internal/telephony/uicc/SpnOverride;->containsCarrier(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_c

    .line 599
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v10}, Lcom/android/internal/telephony/uicc/SpnOverride;->getSpn(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " 0"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    add-int/lit8 v6, p2, 0x1

    invoke-static {v6}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v17

    .line 600
    .local v17, "nameToSet":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[addSubInfoRecord] Found, name = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, v17

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 606
    :goto_1
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    .line 607
    .local v4, "resolver":Landroid/content/ContentResolver;
    sget-object v5, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    const/4 v6, 0x3

    new-array v6, v6, [Ljava/lang/String;

    const/4 v7, 0x0

    const-string v8, "_id"

    aput-object v8, v6, v7

    const/4 v7, 0x1

    const-string v8, "sim_id"

    aput-object v8, v6, v7

    const/4 v7, 0x2

    const-string v8, "name_source"

    aput-object v8, v6, v7

    const-string v7, "icc_id=?"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/String;

    const/4 v9, 0x0

    aput-object p1, v8, v9

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v12

    .line 613
    .local v12, "cursor":Landroid/database/Cursor;
    if-eqz v12, :cond_3

    :try_start_0
    invoke-interface {v12}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v5

    if-nez v5, :cond_d

    .line 614
    :cond_3
    new-instance v25, Landroid/content/ContentValues;

    invoke-direct/range {v25 .. v25}, Landroid/content/ContentValues;-><init>()V

    .line 615
    .local v25, "value":Landroid/content/ContentValues;
    const-string v5, "icc_id"

    move-object/from16 v0, v25

    move-object/from16 v1, p1

    invoke-virtual {v0, v5, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 617
    const-string v5, "color"

    invoke-static/range {p2 .. p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    move-object/from16 v0, v25

    invoke-virtual {v0, v5, v6}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 618
    const-string v5, "sim_id"

    invoke-static/range {p2 .. p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    move-object/from16 v0, v25

    invoke-virtual {v0, v5, v6}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 619
    const-string v5, "display_name"

    move-object/from16 v0, v25

    move-object/from16 v1, v17

    invoke-virtual {v0, v5, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 620
    sget-object v5, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    move-object/from16 v0, v25

    invoke-virtual {v4, v5, v0}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v24

    .line 621
    .local v24, "uri":Landroid/net/Uri;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[addSubInfoRecord]- New record created: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, v24

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 644
    .end local v24    # "uri":Landroid/net/Uri;
    :goto_2
    if-eqz v12, :cond_4

    .line 645
    invoke-interface {v12}, Landroid/database/Cursor;->close()V

    .line 649
    :cond_4
    sget-object v5, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    const/4 v6, 0x0

    const-string v7, "sim_id=?"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/String;

    const/4 v9, 0x0

    invoke-static/range {p2 .. p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v26

    aput-object v26, v8, v9

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v12

    .line 653
    if-eqz v12, :cond_a

    :try_start_1
    invoke-interface {v12}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v5

    if-eqz v5, :cond_a

    .line 655
    :cond_5
    const-string v5, "_id"

    invoke-interface {v12, v5}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v5

    invoke-interface {v12, v5}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v22

    .line 658
    .local v22, "subId":J
    sget-object v5, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-static/range {p2 .. p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Long;

    .line 659
    .local v11, "currentSubId":Ljava/lang/Long;
    if-eqz v11, :cond_6

    invoke-virtual {v11}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    invoke-static {v6, v7}, Landroid/telephony/SubscriptionManager;->isValidSubId(J)Z

    move-result v5

    if-nez v5, :cond_12

    .line 666
    :cond_6
    sget-object v5, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-static/range {p2 .. p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-static/range {v22 .. v23}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    invoke-virtual {v5, v6, v7}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 667
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getSimCount()I

    move-result v19

    .line 668
    .local v19, "simCount":I
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSubId()J

    move-result-wide v14

    .line 669
    .local v14, "defaultSubId":J
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[addSubInfoRecord] mSimInfo.size="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v6}, Ljava/util/HashMap;->size()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " slotId="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move/from16 v0, p2

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " subId="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-wide/from16 v0, v22

    invoke-virtual {v5, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " defaultSubId="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " simCount="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move/from16 v0, v19

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 674
    invoke-static {v14, v15}, Landroid/telephony/SubscriptionManager;->isValidSubId(J)Z

    move-result v5

    if-eqz v5, :cond_7

    const/4 v5, 0x1

    move/from16 v0, v19

    if-ne v0, v5, :cond_8

    .line 675
    :cond_7
    move-object/from16 v0, p0

    move-wide/from16 v1, v22

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultSubId(J)V

    .line 678
    :cond_8
    const/4 v5, 0x1

    move/from16 v0, v19

    if-ne v0, v5, :cond_9

    .line 679
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[addSubInfoRecord] one sim set defaults to subId="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-wide/from16 v0, v22

    invoke-virtual {v5, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 680
    move-object/from16 v0, p0

    move-wide/from16 v1, v22

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultDataSubId(J)V

    .line 681
    move-object/from16 v0, p0

    move-wide/from16 v1, v22

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultSmsSubId(J)V

    .line 682
    move-object/from16 v0, p0

    move-wide/from16 v1, v22

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultVoiceSubId(J)V

    .line 687
    .end local v14    # "defaultSubId":J
    .end local v19    # "simCount":I
    :cond_9
    :goto_3
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[addSubInfoRecord]- hashmap("

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move/from16 v0, p2

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ","

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-wide/from16 v0, v22

    invoke-virtual {v5, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ")"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 688
    invoke-interface {v12}, Landroid/database/Cursor;->moveToNext()Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v5

    if-nez v5, :cond_5

    .line 691
    .end local v11    # "currentSubId":Ljava/lang/Long;
    .end local v22    # "subId":J
    :cond_a
    if-eqz v12, :cond_b

    .line 692
    invoke-interface {v12}, Landroid/database/Cursor;->close()V

    .line 696
    :cond_b
    sget-object v5, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v5}, Ljava/util/HashMap;->size()I

    move-result v20

    .line 697
    .local v20, "size":I
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[addSubInfoRecord]- info size="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move/from16 v0, v20

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 700
    invoke-direct/range {p0 .. p0}, Lcom/android/internal/telephony/SubscriptionController;->updateAllDataConnectionTrackers()V

    .line 703
    const/4 v5, 0x1

    goto/16 :goto_0

    .line 602
    .end local v4    # "resolver":Landroid/content/ContentResolver;
    .end local v12    # "cursor":Landroid/database/Cursor;
    .end local v17    # "nameToSet":Ljava/lang/String;
    .end local v20    # "size":I
    .end local v25    # "value":Landroid/content/ContentValues;
    :cond_c
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "SUB 0"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    add-int/lit8 v6, p2, 0x1

    invoke-static {v6}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v17

    .line 603
    .restart local v17    # "nameToSet":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[addSubInfoRecord] Not found, name = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, v17

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    goto/16 :goto_1

    .line 623
    .restart local v4    # "resolver":Landroid/content/ContentResolver;
    .restart local v12    # "cursor":Landroid/database/Cursor;
    :cond_d
    const/4 v5, 0x0

    :try_start_2
    invoke-interface {v12, v5}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v22

    .line 624
    .restart local v22    # "subId":J
    const/4 v5, 0x1

    invoke-interface {v12, v5}, Landroid/database/Cursor;->getInt(I)I

    move-result v18

    .line 625
    .local v18, "oldSimInfoId":I
    const/4 v5, 0x2

    invoke-interface {v12, v5}, Landroid/database/Cursor;->getInt(I)I

    move-result v16

    .line 626
    .local v16, "nameSource":I
    new-instance v25, Landroid/content/ContentValues;

    invoke-direct/range {v25 .. v25}, Landroid/content/ContentValues;-><init>()V

    .line 628
    .restart local v25    # "value":Landroid/content/ContentValues;
    move/from16 v0, p2

    move/from16 v1, v18

    if-eq v0, v1, :cond_e

    .line 629
    const-string v5, "sim_id"

    invoke-static/range {p2 .. p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    move-object/from16 v0, v25

    invoke-virtual {v0, v5, v6}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 632
    :cond_e
    const/4 v5, 0x2

    move/from16 v0, v16

    if-eq v0, v5, :cond_f

    .line 633
    const-string v5, "display_name"

    move-object/from16 v0, v25

    move-object/from16 v1, v17

    invoke-virtual {v0, v5, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 636
    :cond_f
    invoke-virtual/range {v25 .. v25}, Landroid/content/ContentValues;->size()I

    move-result v5

    if-lez v5, :cond_10

    .line 637
    sget-object v5, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "_id="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static/range {v22 .. v23}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x0

    move-object/from16 v0, v25

    invoke-virtual {v4, v5, v0, v6, v7}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    .line 641
    :cond_10
    const-string v5, "[addSubInfoRecord]- Record already exist"

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto/16 :goto_2

    .line 644
    .end local v16    # "nameSource":I
    .end local v18    # "oldSimInfoId":I
    .end local v22    # "subId":J
    .end local v25    # "value":Landroid/content/ContentValues;
    :catchall_0
    move-exception v5

    if-eqz v12, :cond_11

    .line 645
    invoke-interface {v12}, Landroid/database/Cursor;->close()V

    :cond_11
    throw v5

    .line 685
    .restart local v11    # "currentSubId":Ljava/lang/Long;
    .restart local v22    # "subId":J
    .restart local v25    # "value":Landroid/content/ContentValues;
    :cond_12
    :try_start_3
    const-string v5, "[addSubInfoRecord] currentSubId != null && currentSubId is valid, IGNORE"

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto/16 :goto_3

    .line 691
    .end local v11    # "currentSubId":Ljava/lang/Long;
    .end local v22    # "subId":J
    :catchall_1
    move-exception v5

    if-eqz v12, :cond_13

    .line 692
    invoke-interface {v12}, Landroid/database/Cursor;->close()V

    :cond_13
    throw v5
.end method

.method public clearDefaultsForInactiveSubIds()V
    .locals 6

    .prologue
    const-wide/16 v4, -0x3e8

    .line 1336
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getActiveSubInfoList()Ljava/util/List;

    move-result-object v0

    .line 1337
    .local v0, "records":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[clearDefaultsForInactiveSubIds] records: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1338
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultDataSubId()J

    move-result-wide v2

    invoke-direct {p0, v0, v2, v3}, Lcom/android/internal/telephony/SubscriptionController;->shouldDefaultBeCleared(Ljava/util/List;J)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1339
    const-string v1, "[clearDefaultsForInactiveSubIds] clearing default data sub id"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1340
    invoke-virtual {p0, v4, v5}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultDataSubId(J)V

    .line 1342
    :cond_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSmsSubId()J

    move-result-wide v2

    invoke-direct {p0, v0, v2, v3}, Lcom/android/internal/telephony/SubscriptionController;->shouldDefaultBeCleared(Ljava/util/List;J)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1343
    const-string v1, "[clearDefaultsForInactiveSubIds] clearing default sms sub id"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1344
    invoke-virtual {p0, v4, v5}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultSmsSubId(J)V

    .line 1346
    :cond_1
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultVoiceSubId()J

    move-result-wide v2

    invoke-direct {p0, v0, v2, v3}, Lcom/android/internal/telephony/SubscriptionController;->shouldDefaultBeCleared(Ljava/util/List;J)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1347
    const-string v1, "[clearDefaultsForInactiveSubIds] clearing default voice sub id"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1348
    invoke-virtual {p0, v4, v5}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultVoiceSubId(J)V

    .line 1350
    :cond_2
    return-void
.end method

.method public clearSubInfo()I
    .locals 3

    .prologue
    .line 1066
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 1067
    const-string v1, "[clearSubInfo]+"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1069
    sget-object v1, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v1}, Ljava/util/HashMap;->size()I

    move-result v0

    .line 1071
    .local v0, "size":I
    if-nez v0, :cond_0

    .line 1072
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[clearSubInfo]- no simInfo size="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1073
    const/4 v0, 0x0

    .line 1078
    .end local v0    # "size":I
    :goto_0
    return v0

    .line 1076
    .restart local v0    # "size":I
    :cond_0
    sget-object v1, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v1}, Ljava/util/HashMap;->clear()V

    .line 1077
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[clearSubInfo]- clear size="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public deactivateSubId(J)V
    .locals 3
    .param p1, "subId"    # J

    .prologue
    .line 1560
    invoke-virtual {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->getSubState(J)I

    move-result v1

    if-nez v1, :cond_0

    .line 1561
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "activateSubId: subscription already deactivated, subId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1567
    :goto_0
    return-void

    .line 1565
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->getSlotId(J)I

    move-result v0

    .line 1566
    .local v0, "slotId":I
    invoke-static {}, Lcom/android/internal/telephony/SubscriptionHelper;->getInstance()Lcom/android/internal/telephony/SubscriptionHelper;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Lcom/android/internal/telephony/SubscriptionHelper;->setUiccSubscription(II)V

    goto :goto_0
.end method

.method public dump(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V
    .locals 8
    .param p1, "fd"    # Ljava/io/FileDescriptor;
    .param p2, "pw"    # Ljava/io/PrintWriter;
    .param p3, "args"    # [Ljava/lang/String;

    .prologue
    .line 1498
    iget-object v4, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    const-string v5, "android.permission.DUMP"

    const-string v6, "Requires DUMP"

    invoke-virtual {v4, v5, v6}, Landroid/content/Context;->enforceCallingOrSelfPermission(Ljava/lang/String;Ljava/lang/String;)V

    .line 1500
    const-string v4, "SubscriptionController:"

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1501
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " defaultSubId="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSubId()J

    move-result-wide v6

    invoke-virtual {v4, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1502
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " defaultDataSubId="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultDataSubId()J

    move-result-wide v6

    invoke-virtual {v4, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1503
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " defaultVoiceSubId="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultVoiceSubId()J

    move-result-wide v6

    invoke-virtual {v4, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1504
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " defaultSmsSubId="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSmsSubId()J

    move-result-wide v6

    invoke-virtual {v4, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1506
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " defaultDataPhoneId="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {}, Landroid/telephony/SubscriptionManager;->getDefaultDataPhoneId()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1507
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " defaultVoicePhoneId="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {}, Landroid/telephony/SubscriptionManager;->getDefaultVoicePhoneId()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1508
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " defaultSmsPhoneId="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {}, Landroid/telephony/SubscriptionManager;->getDefaultSmsPhoneId()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1509
    invoke-virtual {p2}, Ljava/io/PrintWriter;->flush()V

    .line 1511
    sget-object v4, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v4}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 1512
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/Long;>;"
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " mSimInfo["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]: subId="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    goto :goto_0

    .line 1514
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/Long;>;"
    :cond_0
    invoke-virtual {p2}, Ljava/io/PrintWriter;->flush()V

    .line 1515
    const-string v4, "++++++++++++++++++++++++++++++++"

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1517
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getActiveSubInfoList()Ljava/util/List;

    move-result-object v3

    .line 1518
    .local v3, "sirl":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    if-eqz v3, :cond_1

    .line 1519
    const-string v4, " ActiveSubInfoList:"

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1520
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/SubInfoRecord;

    .line 1521
    .local v0, "entry":Landroid/telephony/SubInfoRecord;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "  "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Landroid/telephony/SubInfoRecord;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    goto :goto_1

    .line 1524
    .end local v0    # "entry":Landroid/telephony/SubInfoRecord;
    :cond_1
    const-string v4, " ActiveSubInfoList: is null"

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1526
    :cond_2
    invoke-virtual {p2}, Ljava/io/PrintWriter;->flush()V

    .line 1527
    const-string v4, "++++++++++++++++++++++++++++++++"

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1529
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getAllSubInfoList()Ljava/util/List;

    move-result-object v3

    .line 1530
    if-eqz v3, :cond_3

    .line 1531
    const-string v4, " AllSubInfoList:"

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1532
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/SubInfoRecord;

    .line 1533
    .restart local v0    # "entry":Landroid/telephony/SubInfoRecord;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "  "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Landroid/telephony/SubInfoRecord;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    goto :goto_2

    .line 1536
    .end local v0    # "entry":Landroid/telephony/SubInfoRecord;
    :cond_3
    const-string v4, " AllSubInfoList: is null"

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1538
    :cond_4
    invoke-virtual {p2}, Ljava/io/PrintWriter;->flush()V

    .line 1539
    const-string v4, "++++++++++++++++++++++++++++++++"

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1541
    iget-object v4, p0, Lcom/android/internal/telephony/SubscriptionController;->mLocalLog:Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;

    invoke-virtual {v4, p1, p2, p3}, Lcom/android/internal/telephony/SubscriptionController$ScLocalLog;->dump(Ljava/io/FileDescriptor;Ljava/io/PrintWriter;[Ljava/lang/String;)V

    .line 1542
    invoke-virtual {p2}, Ljava/io/PrintWriter;->flush()V

    .line 1543
    const-string v4, "++++++++++++++++++++++++++++++++"

    invoke-virtual {p2, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1544
    invoke-virtual {p2}, Ljava/io/PrintWriter;->flush()V

    .line 1545
    return-void
.end method

.method public getActiveSubIdList()[J
    .locals 9

    .prologue
    .line 1467
    sget-object v7, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v7}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v3

    .line 1468
    .local v3, "simInfoSet":Ljava/util/Set;, "Ljava/util/Set<Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/Long;>;>;"
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[getActiveSubIdList] simInfoSet="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {p0, v7}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1470
    invoke-interface {v3}, Ljava/util/Set;->size()I

    move-result v7

    new-array v6, v7, [J

    .line 1471
    .local v6, "subIdArr":[J
    const/4 v1, 0x0

    .line 1472
    .local v1, "i":I
    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 1473
    .local v0, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/Long;>;"
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Long;

    invoke-virtual {v7}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    .line 1474
    .local v4, "sub":J
    aput-wide v4, v6, v1

    .line 1475
    add-int/lit8 v1, v1, 0x1

    .line 1476
    goto :goto_0

    .line 1478
    .end local v0    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v4    # "sub":J
    :cond_0
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[getActiveSubIdList] X subIdArr.length="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    array-length v8, v6

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {p0, v7}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1479
    return-object v6
.end method

.method public getActiveSubInfoCount()I
    .locals 3

    .prologue
    .line 534
    const-string v1, "[getActiveSubInfoCount]+"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 535
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getActiveSubInfoList()Ljava/util/List;

    move-result-object v0

    .line 536
    .local v0, "records":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    if-nez v0, :cond_0

    .line 537
    const-string v1, "[getActiveSubInfoCount] records null"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 538
    const/4 v1, 0x0

    .line 541
    :goto_0
    return v1

    .line 540
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[getActiveSubInfoCount]- count: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 541
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    goto :goto_0
.end method

.method public getActiveSubInfoList()Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Landroid/telephony/SubInfoRecord;",
            ">;"
        }
    .end annotation

    .prologue
    .line 507
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 508
    const-string v2, "[getActiveSubInfoList]+"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 510
    const/4 v0, 0x0

    .line 512
    .local v0, "subList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->isSubInfoReady()Z

    move-result v2

    if-nez v2, :cond_0

    .line 513
    const-string v2, "[getActiveSubInfoList] Sub Controller not ready"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    move-object v1, v0

    .line 525
    .end local v0    # "subList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    .local v1, "subList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    :goto_0
    return-object v1

    .line 517
    .end local v1    # "subList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    .restart local v0    # "subList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    :cond_0
    const-string v2, "sim_id!=-1000"

    const/4 v3, 0x0

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/SubscriptionController;->getSubInfo(Ljava/lang/String;Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 519
    if-eqz v0, :cond_1

    .line 520
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[getActiveSubInfoList]- "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " infos return"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    :goto_1
    move-object v1, v0

    .line 525
    .end local v0    # "subList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    .restart local v1    # "subList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_0

    .line 522
    .end local v1    # "subList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    .restart local v0    # "subList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    :cond_1
    const-string v2, "[getActiveSubInfoList]- no info return"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    goto :goto_1
.end method

.method public getAllSubInfoCount()I
    .locals 8

    .prologue
    const/4 v2, 0x0

    .line 550
    const-string v0, "[getAllSubInfoCount]+"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 551
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 553
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    move-object v3, v2

    move-object v4, v2

    move-object v5, v2

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v7

    .line 556
    .local v7, "cursor":Landroid/database/Cursor;
    if-eqz v7, :cond_1

    .line 557
    :try_start_0
    invoke-interface {v7}, Landroid/database/Cursor;->getCount()I

    move-result v6

    .line 558
    .local v6, "count":I
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[getAllSubInfoCount]- "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " SUB(s) in DB"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 562
    if-eqz v7, :cond_0

    .line 563
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    .line 568
    .end local v6    # "count":I
    :cond_0
    :goto_0
    return v6

    .line 562
    :cond_1
    if-eqz v7, :cond_2

    .line 563
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    .line 566
    :cond_2
    const-string v0, "[getAllSubInfoCount]- no SUB in DB"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 568
    const/4 v6, 0x0

    goto :goto_0

    .line 562
    :catchall_0
    move-exception v0

    if-eqz v7, :cond_3

    .line 563
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    :cond_3
    throw v0
.end method

.method public getAllSubInfoList()Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Landroid/telephony/SubInfoRecord;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 487
    const-string v1, "[getAllSubInfoList]+"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 488
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 490
    const/4 v0, 0x0

    .line 491
    .local v0, "subList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    invoke-direct {p0, v2, v2}, Lcom/android/internal/telephony/SubscriptionController;->getSubInfo(Ljava/lang/String;Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 492
    if-eqz v0, :cond_0

    .line 493
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[getAllSubInfoList]- "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " infos return"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 498
    :goto_0
    return-object v0

    .line 495
    :cond_0
    const-string v1, "[getAllSubInfoList]- no info return"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public getCurrentDds()J
    .locals 2

    .prologue
    .line 1259
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mScheduler:Lcom/android/internal/telephony/dataconnection/DdsScheduler;

    invoke-virtual {v0}, Lcom/android/internal/telephony/dataconnection/DdsScheduler;->getCurrentDds()J

    move-result-wide v0

    return-wide v0
.end method

.method public getDefaultDataSubId()J
    .locals 5

    .prologue
    .line 1233
    const-wide/16 v2, -0x3e8

    .line 1235
    .local v2, "subId":J
    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v4, "multi_sim_data_call"

    invoke-static {v1, v4}, Landroid/provider/Settings$Global;->getLong(Landroid/content/ContentResolver;Ljava/lang/String;)J
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v2

    .line 1242
    :goto_0
    return-wide v2

    .line 1237
    :catch_0
    move-exception v0

    .line 1238
    .local v0, "snfe":Landroid/provider/Settings$SettingNotFoundException;
    const-string v1, "Settings Exception Reading Dual Sim Data Call Values"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->loge(Ljava/lang/String;)V

    .line 1239
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSubId()J

    move-result-wide v2

    goto :goto_0
.end method

.method public getDefaultSmsSubId()J
    .locals 6

    .prologue
    .line 1168
    iget-object v2, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "multi_sim_sms"

    const-wide/16 v4, -0x3e8

    invoke-static {v2, v3, v4, v5}, Landroid/provider/Settings$Global;->getLong(Landroid/content/ContentResolver;Ljava/lang/String;J)J

    move-result-wide v0

    .line 1172
    .local v0, "subId":J
    return-wide v0
.end method

.method public getDefaultSubId()J
    .locals 2
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    .line 1141
    sget-wide v0, Lcom/android/internal/telephony/SubscriptionController;->mDefaultVoiceSubId:J

    .line 1143
    .local v0, "subId":J
    return-wide v0
.end method

.method public getDefaultVoiceSubId()J
    .locals 6

    .prologue
    .line 1197
    iget-object v2, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "multi_sim_voice_call"

    const-wide/16 v4, -0x3e8

    invoke-static {v2, v3, v4, v5}, Landroid/provider/Settings$Global;->getLong(Landroid/content/ContentResolver;Ljava/lang/String;J)J

    move-result-wide v0

    .line 1201
    .local v0, "subId":J
    return-wide v0
.end method

.method public getNwMode(J)I
    .locals 3
    .param p1, "subId"    # J

    .prologue
    .line 1578
    invoke-virtual {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->getSubInfoForSubscriber(J)Landroid/telephony/SubInfoRecord;

    move-result-object v0

    .line 1579
    .local v0, "subInfo":Landroid/telephony/SubInfoRecord;
    if-eqz v0, :cond_0

    .line 1580
    iget v1, v0, Landroid/telephony/SubInfoRecord;->mNwMode:I

    .line 1583
    :goto_0
    return v1

    .line 1582
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getSubState: invalid subId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->loge(Ljava/lang/String;)V

    .line 1583
    const/4 v1, -0x1

    goto :goto_0
.end method

.method public getOnDemandDataSubId()J
    .locals 2

    .prologue
    .line 1701
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getCurrentDds()J

    move-result-wide v0

    return-wide v0
.end method

.method public getPhoneId(J)I
    .locals 11
    .param p1, "subId"    # J

    .prologue
    .line 1019
    const-wide v8, 0x7fffffffffffffffL

    cmp-long v5, p1, v8

    if-nez v5, :cond_0

    .line 1020
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSubId()J

    move-result-wide p1

    .line 1021
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[getPhoneId] asked for default subId="

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1024
    :cond_0
    invoke-static {p1, p2}, Landroid/telephony/SubscriptionManager;->isValidSubId(J)Z

    move-result v5

    if-nez v5, :cond_1

    .line 1025
    const-string v5, "[getPhoneId]- invalid subId return=-1000"

    invoke-direct {p0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1026
    const/16 v2, -0x3e8

    .line 1057
    :goto_0
    return v2

    .line 1030
    :cond_1
    const-wide/16 v8, 0x0

    cmp-long v5, p1, v8

    if-gez v5, :cond_2

    .line 1031
    const-wide/16 v8, -0x1

    sub-long/2addr v8, p1

    long-to-int v2, v8

    .line 1033
    .local v2, "phoneId":I
    goto :goto_0

    .line 1036
    .end local v2    # "phoneId":I
    :cond_2
    sget-object v5, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v5}, Ljava/util/HashMap;->size()I

    move-result v4

    .line 1038
    .local v4, "size":I
    if-nez v4, :cond_3

    .line 1039
    sget v2, Lcom/android/internal/telephony/SubscriptionController;->mDefaultPhoneId:I

    .line 1040
    .restart local v2    # "phoneId":I
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[getPhoneId]- no sims, returning default phoneId="

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    goto :goto_0

    .line 1045
    .end local v2    # "phoneId":I
    :cond_3
    sget-object v5, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v5}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_4
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 1046
    .local v0, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/Long;>;"
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v3

    .line 1047
    .local v3, "sim":I
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Long;

    invoke-virtual {v5}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    .line 1049
    .local v6, "sub":J
    cmp-long v5, p1, v6

    if-nez v5, :cond_4

    move v2, v3

    .line 1051
    goto :goto_0

    .line 1055
    .end local v0    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v3    # "sim":I
    .end local v6    # "sub":J
    :cond_5
    sget v2, Lcom/android/internal/telephony/SubscriptionController;->mDefaultPhoneId:I

    .line 1056
    .restart local v2    # "phoneId":I
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[getPhoneId]- subId="

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v8, " not found return default phoneId="

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public getSlotId(J)I
    .locals 11
    .param p1, "subId"    # J

    .prologue
    const/16 v7, -0x3e8

    .line 922
    const-wide v8, 0x7fffffffffffffffL

    cmp-long v6, p1, v8

    if-nez v6, :cond_0

    .line 923
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSubId()J

    move-result-wide p1

    .line 925
    :cond_0
    invoke-static {p1, p2}, Landroid/telephony/SubscriptionManager;->isValidSubId(J)Z

    move-result v6

    if-nez v6, :cond_1

    .line 926
    const-string v6, "[getSlotId]- subId invalid"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    move v2, v7

    .line 950
    :goto_0
    return v2

    .line 930
    :cond_1
    sget-object v6, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v6}, Ljava/util/HashMap;->size()I

    move-result v3

    .line 932
    .local v3, "size":I
    if-nez v3, :cond_2

    .line 934
    const-string v6, "[getSlotId]- size == 0, return SIM_NOT_INSERTED instead"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 935
    const/4 v2, -0x1

    goto :goto_0

    .line 938
    :cond_2
    sget-object v6, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v6}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :cond_3
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 939
    .local v0, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/Long;>;"
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v2

    .line 940
    .local v2, "sim":I
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Long;

    invoke-virtual {v6}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    .line 942
    .local v4, "sub":J
    cmp-long v6, p1, v4

    if-nez v6, :cond_3

    goto :goto_0

    .line 949
    .end local v0    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v2    # "sim":I
    .end local v4    # "sub":J
    :cond_4
    const-string v6, "[getSlotId]- return fail"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    move v2, v7

    .line 950
    goto :goto_0
.end method

.method public getSubId(I)[J
    .locals 14
    .param p1, "slotId"    # I
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    .line 962
    const v11, 0x7fffffff

    if-ne p1, v11, :cond_0

    .line 963
    const-string v11, "[getSubId]- default slotId"

    invoke-direct {p0, v11}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 964
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSubId()J

    move-result-wide v12

    invoke-virtual {p0, v12, v13}, Lcom/android/internal/telephony/SubscriptionController;->getSlotId(J)I

    move-result p1

    .line 968
    :cond_0
    const/4 v11, 0x2

    new-array v0, v11, [J

    const/4 v11, 0x0

    rsub-int/lit8 v12, p1, -0x1

    int-to-long v12, v12

    aput-wide v12, v0, v11

    const/4 v11, 0x1

    rsub-int/lit8 v12, p1, -0x1

    int-to-long v12, v12

    aput-wide v12, v0, v11

    .line 970
    .local v0, "DUMMY_VALUES":[J
    invoke-static {p1}, Landroid/telephony/SubscriptionManager;->isValidSlotId(I)Z

    move-result v11

    if-nez v11, :cond_1

    .line 971
    const-string v11, "[getSubId]- invalid slotId"

    invoke-direct {p0, v11}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 972
    const/4 v0, 0x0

    .line 1011
    .end local v0    # "DUMMY_VALUES":[J
    :goto_0
    return-object v0

    .line 976
    .restart local v0    # "DUMMY_VALUES":[J
    :cond_1
    if-gez p1, :cond_2

    .line 977
    const-string v11, "[getSubId]- slotId < 0, return dummy instead"

    invoke-direct {p0, v11}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    goto :goto_0

    .line 981
    :cond_2
    sget-object v11, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v11}, Ljava/util/HashMap;->size()I

    move-result v5

    .line 983
    .local v5, "size":I
    if-nez v5, :cond_3

    .line 984
    const-string v11, "[getSubId]- size == 0, return dummy instead"

    invoke-direct {p0, v11}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    goto :goto_0

    .line 989
    :cond_3
    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    .line 990
    .local v10, "subIds":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Long;>;"
    sget-object v11, Lcom/android/internal/telephony/SubscriptionController;->mSimInfo:Ljava/util/HashMap;

    invoke-virtual {v11}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v11

    invoke-interface {v11}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :cond_4
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 991
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/Long;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Integer;

    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v6

    .line 992
    .local v6, "slot":I
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Long;

    invoke-virtual {v11}, Ljava/lang/Long;->longValue()J

    move-result-wide v8

    .line 993
    .local v8, "sub":J
    if-ne p1, v6, :cond_4

    .line 994
    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 999
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/Long;>;"
    .end local v6    # "slot":I
    .end local v8    # "sub":J
    :cond_5
    invoke-virtual {v10}, Ljava/util/ArrayList;->size()I

    move-result v4

    .line 1001
    .local v4, "numSubIds":I
    if-nez v4, :cond_6

    .line 1002
    const-string v11, "[getSubId]- numSubIds == 0, return dummy instead"

    invoke-direct {p0, v11}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    goto :goto_0

    .line 1006
    :cond_6
    new-array v7, v4, [J

    .line 1007
    .local v7, "subIdArr":[J
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_2
    if-ge v2, v4, :cond_7

    .line 1008
    invoke-virtual {v10, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/Long;

    invoke-virtual {v11}, Ljava/lang/Long;->longValue()J

    move-result-wide v12

    aput-wide v12, v7, v2

    .line 1007
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_7
    move-object v0, v7

    .line 1011
    goto :goto_0
.end method

.method public getSubIdFromNetworkRequest(Landroid/net/NetworkRequest;)J
    .locals 6
    .param p1, "n"    # Landroid/net/NetworkRequest;

    .prologue
    .line 228
    if-nez p1, :cond_0

    .line 229
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultDataSubId()J

    move-result-wide v2

    .line 240
    :goto_0
    return-wide v2

    .line 232
    :cond_0
    iget-object v4, p1, Landroid/net/NetworkRequest;->networkCapabilities:Landroid/net/NetworkCapabilities;

    invoke-virtual {v4}, Landroid/net/NetworkCapabilities;->getNetworkSpecifier()Ljava/lang/String;

    move-result-object v1

    .line 234
    .local v1, "str":Ljava/lang/String;
    :try_start_0
    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v2

    .local v2, "subId":J
    goto :goto_0

    .line 235
    .end local v2    # "subId":J
    :catch_0
    move-exception v0

    .line 236
    .local v0, "e":Ljava/lang/NumberFormatException;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Exception e = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/SubscriptionController;->loge(Ljava/lang/String;)V

    .line 237
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultDataSubId()J

    move-result-wide v2

    .restart local v2    # "subId":J
    goto :goto_0
.end method

.method public getSubIdUsingPhoneId(I)J
    .locals 4
    .param p1, "phoneId"    # I

    .prologue
    .line 1396
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/SubscriptionController;->getSubId(I)[J

    move-result-object v0

    .line 1397
    .local v0, "subIds":[J
    if-eqz v0, :cond_0

    array-length v1, v0

    if-nez v1, :cond_1

    .line 1398
    :cond_0
    const-wide/16 v2, -0x3e8

    .line 1400
    :goto_0
    return-wide v2

    :cond_1
    const/4 v1, 0x0

    aget-wide v2, v0, v1

    goto :goto_0
.end method

.method public getSubIdUsingSlotId(I)[J
    .locals 1
    .param p1, "slotId"    # I

    .prologue
    .line 1404
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/SubscriptionController;->getSubId(I)[J

    move-result-object v0

    return-object v0
.end method

.method public getSubInfoForSubscriber(J)Landroid/telephony/SubInfoRecord;
    .locals 9
    .param p1, "subId"    # J

    .prologue
    const/4 v2, 0x0

    .line 400
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[getSubInfoForSubscriberx]+ subId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 401
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 403
    const-wide v0, 0x7fffffffffffffffL

    cmp-long v0, p1, v0

    if-nez v0, :cond_0

    .line 404
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSubId()J

    move-result-wide p1

    .line 406
    :cond_0
    invoke-static {p1, p2}, Landroid/telephony/SubscriptionManager;->isValidSubId(J)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->isSubInfoReady()Z

    move-result v0

    if-nez v0, :cond_3

    .line 407
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[getSubInfoForSubscriberx]- invalid subId or not ready, subId = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 426
    :cond_2
    :goto_0
    return-object v2

    .line 410
    :cond_3
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    const-string v3, "_id=?"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    invoke-static {p1, p2}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v7

    aput-object v7, v4, v5

    move-object v5, v2

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 413
    .local v6, "cursor":Landroid/database/Cursor;
    if-eqz v6, :cond_4

    .line 414
    :try_start_0
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 415
    const-string v0, "[getSubInfoForSubscriberx]- Info detail:"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 416
    invoke-direct {p0, v6}, Lcom/android/internal/telephony/SubscriptionController;->getSubInfoRecord(Landroid/database/Cursor;)Landroid/telephony/SubInfoRecord;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v2

    .line 420
    if-eqz v6, :cond_2

    .line 421
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    goto :goto_0

    .line 420
    :cond_4
    if-eqz v6, :cond_5

    .line 421
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    .line 424
    :cond_5
    const-string v0, "[getSubInfoForSubscriber]- null info return"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    goto :goto_0

    .line 420
    :catchall_0
    move-exception v0

    if-eqz v6, :cond_6

    .line 421
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_6
    throw v0
.end method

.method public getSubInfoUsingIccId(Ljava/lang/String;)Ljava/util/List;
    .locals 10
    .param p1, "iccId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Landroid/telephony/SubInfoRecord;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 436
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[getSubInfoUsingIccId]+ iccId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 437
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 439
    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->isSubInfoReady()Z

    move-result v0

    if-nez v0, :cond_2

    .line 440
    :cond_0
    const-string v0, "[getSubInfoUsingIccId]- null iccid or not ready"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    move-object v8, v2

    .line 468
    :cond_1
    :goto_0
    return-object v8

    .line 443
    :cond_2
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    const-string v3, "icc_id=?"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    aput-object p1, v4, v5

    move-object v5, v2

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 445
    .local v6, "cursor":Landroid/database/Cursor;
    const/4 v8, 0x0

    .line 447
    .local v8, "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    if-eqz v6, :cond_3

    move-object v9, v8

    .line 448
    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .local v9, "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :goto_1
    :try_start_0
    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 449
    invoke-direct {p0, v6}, Lcom/android/internal/telephony/SubscriptionController;->getSubInfoRecord(Landroid/database/Cursor;)Landroid/telephony/SubInfoRecord;

    move-result-object v7

    .line 450
    .local v7, "subInfo":Landroid/telephony/SubInfoRecord;
    if-eqz v7, :cond_6

    .line 452
    if-nez v9, :cond_5

    .line 454
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 456
    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :goto_2
    :try_start_1
    invoke-virtual {v8, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_3
    move-object v9, v8

    .line 458
    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_1

    .line 460
    .end local v7    # "subInfo":Landroid/telephony/SubInfoRecord;
    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :cond_3
    const-string v0, "Query fail"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 463
    :goto_4
    if-eqz v6, :cond_1

    .line 464
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    goto :goto_0

    .line 463
    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :catchall_0
    move-exception v0

    move-object v8, v9

    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :goto_5
    if-eqz v6, :cond_4

    .line 464
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_4
    throw v0

    .line 463
    :catchall_1
    move-exception v0

    goto :goto_5

    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v7    # "subInfo":Landroid/telephony/SubInfoRecord;
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :cond_5
    move-object v8, v9

    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_2

    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :cond_6
    move-object v8, v9

    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_3

    .end local v7    # "subInfo":Landroid/telephony/SubInfoRecord;
    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :cond_7
    move-object v8, v9

    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_4
.end method

.method public getSubInfoUsingSlotId(I)Ljava/util/List;
    .locals 1
    .param p1, "slotId"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Ljava/util/List",
            "<",
            "Landroid/telephony/SubInfoRecord;",
            ">;"
        }
    .end annotation

    .prologue
    .line 478
    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/android/internal/telephony/SubscriptionController;->getSubInfoUsingSlotIdWithCheck(IZ)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getSubInfoUsingSlotIdWithCheck(IZ)Ljava/util/List;
    .locals 11
    .param p1, "slotId"    # I
    .param p2, "needCheck"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(IZ)",
            "Ljava/util/List",
            "<",
            "Landroid/telephony/SubInfoRecord;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 1408
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[getSubInfoUsingSlotIdWithCheck]+ slotId:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1409
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 1411
    const v0, 0x7fffffff

    if-ne p1, v0, :cond_0

    .line 1412
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSubId()J

    move-result-wide v0

    invoke-virtual {p0, v0, v1}, Lcom/android/internal/telephony/SubscriptionController;->getSlotId(J)I

    move-result p1

    .line 1414
    :cond_0
    invoke-static {p1}, Landroid/telephony/SubscriptionManager;->isValidSlotId(I)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1415
    const-string v0, "[getSubInfoUsingSlotIdWithCheck]- invalid slotId"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1446
    :goto_0
    return-object v2

    .line 1419
    :cond_1
    if-eqz p2, :cond_2

    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->isSubInfoReady()Z

    move-result v0

    if-nez v0, :cond_2

    .line 1420
    const-string v0, "[getSubInfoUsingSlotIdWithCheck]- not ready"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    goto :goto_0

    .line 1424
    :cond_2
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    const-string v3, "sim_id=?"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/String;

    const/4 v5, 0x0

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v4, v5

    move-object v5, v2

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 1426
    .local v6, "cursor":Landroid/database/Cursor;
    const/4 v8, 0x0

    .line 1428
    .local v8, "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    if-eqz v6, :cond_4

    :try_start_0
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-eqz v0, :cond_4

    :cond_3
    move-object v9, v8

    .line 1430
    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .local v9, "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :try_start_1
    invoke-direct {p0, v6}, Lcom/android/internal/telephony/SubscriptionController;->getSubInfoRecord(Landroid/database/Cursor;)Landroid/telephony/SubInfoRecord;

    move-result-object v7

    .line 1431
    .local v7, "subInfo":Landroid/telephony/SubInfoRecord;
    if-eqz v7, :cond_8

    .line 1432
    if-nez v9, :cond_7

    .line 1433
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1435
    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :goto_1
    :try_start_2
    invoke-virtual {v8, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1437
    :goto_2
    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result v0

    if-nez v0, :cond_3

    .line 1440
    .end local v7    # "subInfo":Landroid/telephony/SubInfoRecord;
    :cond_4
    if-eqz v6, :cond_5

    .line 1441
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    .line 1444
    :cond_5
    const-string v0, "[getSubInfoUsingSlotId]- null info return"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    move-object v2, v8

    .line 1446
    goto :goto_0

    .line 1440
    :catchall_0
    move-exception v0

    :goto_3
    if-eqz v6, :cond_6

    .line 1441
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_6
    throw v0

    .line 1440
    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :catchall_1
    move-exception v0

    move-object v8, v9

    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_3

    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v7    # "subInfo":Landroid/telephony/SubInfoRecord;
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :cond_7
    move-object v8, v9

    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_1

    .end local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    :cond_8
    move-object v8, v9

    .end local v9    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    .restart local v8    # "subList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/telephony/SubInfoRecord;>;"
    goto :goto_2
.end method

.method public getSubState(J)I
    .locals 3
    .param p1, "subId"    # J

    .prologue
    .line 1605
    invoke-virtual {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->getSubInfoForSubscriber(J)Landroid/telephony/SubInfoRecord;

    move-result-object v0

    .line 1606
    .local v0, "subInfo":Landroid/telephony/SubInfoRecord;
    const/4 v1, 0x0

    .line 1610
    .local v1, "subStatus":I
    if-eqz v0, :cond_0

    iget v2, v0, Landroid/telephony/SubInfoRecord;->slotId:I

    if-ltz v2, :cond_0

    .line 1611
    iget v1, v0, Landroid/telephony/SubInfoRecord;->mStatus:I

    .line 1613
    :cond_0
    return v1
.end method

.method public isSMSPromptEnabled()Z
    .locals 5

    .prologue
    .line 1207
    const/4 v0, 0x0

    .line 1208
    .local v0, "prompt":Z
    const/4 v2, 0x0

    .line 1210
    .local v2, "value":I
    :try_start_0
    iget-object v3, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "multi_sim_sms_prompt"

    invoke-static {v3, v4}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 1215
    :goto_0
    if-nez v2, :cond_0

    const/4 v0, 0x0

    .line 1218
    :goto_1
    return v0

    .line 1212
    :catch_0
    move-exception v1

    .line 1213
    .local v1, "snfe":Landroid/provider/Settings$SettingNotFoundException;
    const-string v3, "Settings Exception Reading Dual Sim SMS Prompt Values"

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/SubscriptionController;->loge(Ljava/lang/String;)V

    goto :goto_0

    .line 1215
    .end local v1    # "snfe":Landroid/provider/Settings$SettingNotFoundException;
    :cond_0
    const/4 v0, 0x1

    goto :goto_1
.end method

.method public isVoicePromptEnabled()Z
    .locals 5

    .prologue
    .line 1676
    const/4 v0, 0x0

    .line 1677
    .local v0, "prompt":Z
    const/4 v2, 0x0

    .line 1679
    .local v2, "value":I
    :try_start_0
    iget-object v3, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "multi_sim_voice_prompt"

    invoke-static {v3, v4}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    .line 1684
    :goto_0
    if-nez v2, :cond_0

    const/4 v0, 0x0

    .line 1687
    :goto_1
    return v0

    .line 1681
    :catch_0
    move-exception v1

    .line 1682
    .local v1, "snfe":Landroid/provider/Settings$SettingNotFoundException;
    const-string v3, "Settings Exception Reading Dual Sim Voice Prompt Values"

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/SubscriptionController;->loge(Ljava/lang/String;)V

    goto :goto_0

    .line 1684
    .end local v1    # "snfe":Landroid/provider/Settings$SettingNotFoundException;
    :cond_0
    const/4 v0, 0x1

    goto :goto_1
.end method

.method public notifyOnDemandDataSubIdChanged(Landroid/net/NetworkRequest;)V
    .locals 4
    .param p1, "n"    # Landroid/net/NetworkRequest;

    .prologue
    .line 1713
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mOnDemandDdsLockNotificationRegistrants:Ljava/util/HashMap;

    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/SubscriptionController;->getSubIdFromNetworkRequest(Landroid/net/NetworkRequest;)J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/SubscriptionController$OnDemandDdsLockNotifier;

    .line 1715
    .local v0, "notifier":Lcom/android/internal/telephony/SubscriptionController$OnDemandDdsLockNotifier;
    if-eqz v0, :cond_0

    .line 1716
    invoke-interface {v0, p1}, Lcom/android/internal/telephony/SubscriptionController$OnDemandDdsLockNotifier;->notifyOnDemandDdsLockGranted(Landroid/net/NetworkRequest;)V

    .line 1720
    :goto_0
    return-void

    .line 1718
    :cond_0
    const-string v1, "No registrants for OnDemandDdsLockGranted event"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public registerForOnDemandDdsLockNotification(JLcom/android/internal/telephony/SubscriptionController$OnDemandDdsLockNotifier;)V
    .locals 3
    .param p1, "clientSubId"    # J
    .param p3, "callback"    # Lcom/android/internal/telephony/SubscriptionController$OnDemandDdsLockNotifier;

    .prologue
    .line 1706
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "registerForOnDemandDdsLockNotification for client="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1707
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mOnDemandDdsLockNotificationRegistrants:Ljava/util/HashMap;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1709
    return-void
.end method

.method public removeStaleSubPreferences(Ljava/lang/String;)V
    .locals 8
    .param p1, "prefKey"    # Ljava/lang/String;

    .prologue
    .line 1726
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getAllSubInfoList()Ljava/util/List;

    move-result-object v3

    .line 1727
    .local v3, "subInfoList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    iget-object v4, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-static {v4}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 1728
    .local v1, "sp":Landroid/content/SharedPreferences;
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/telephony/SubInfoRecord;

    .line 1729
    .local v2, "subInfo":Landroid/telephony/SubInfoRecord;
    iget v4, v2, Landroid/telephony/SubInfoRecord;->slotId:I

    const/4 v5, -0x1

    if-ne v4, v5, :cond_0

    .line 1730
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-wide v6, v2, Landroid/telephony/SubInfoRecord;->subId:J

    invoke-virtual {v5, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    invoke-interface {v4}, Landroid/content/SharedPreferences$Editor;->commit()Z

    goto :goto_0

    .line 1733
    .end local v2    # "subInfo":Landroid/telephony/SubInfoRecord;
    :cond_1
    return-void
.end method

.method public setColor(IJ)I
    .locals 10
    .param p1, "color"    # I
    .param p2, "subId"    # J

    .prologue
    .line 714
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[setColor]+ color:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " subId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 715
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 717
    invoke-direct {p0, p2, p3}, Lcom/android/internal/telephony/SubscriptionController;->validateSubId(J)V

    .line 718
    sget-object v1, Lcom/android/internal/telephony/SubscriptionController;->sSimBackgroundDarkRes:[I

    array-length v7, v1

    .line 719
    .local v7, "size":I
    if-ltz p1, :cond_0

    if-lt p1, v7, :cond_1

    .line 720
    :cond_0
    const-string v1, "[setColor]- fail"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 721
    const/4 v0, -0x1

    .line 732
    :goto_0
    return v0

    .line 723
    :cond_1
    new-instance v8, Landroid/content/ContentValues;

    const/4 v1, 0x1

    invoke-direct {v8, v1}, Landroid/content/ContentValues;-><init>(I)V

    .line 724
    .local v8, "value":Landroid/content/ContentValues;
    const-string v1, "color"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v8, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 725
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[setColor]- color:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " set"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 727
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "_id="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {p2, p3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v8, v3, v4}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v0

    .line 729
    .local v0, "result":I
    const-string v4, "color"

    const-string v6, "N/A"

    move-object v1, p0

    move-wide v2, p2

    move v5, p1

    invoke-direct/range {v1 .. v6}, Lcom/android/internal/telephony/SubscriptionController;->broadcastSimInfoContentChanged(JLjava/lang/String;ILjava/lang/String;)V

    goto :goto_0
.end method

.method public setDataRoaming(IJ)I
    .locals 8
    .param p1, "roaming"    # I
    .param p2, "subId"    # J

    .prologue
    .line 870
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[setDataRoaming]+ roaming:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " subId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 871
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 873
    invoke-direct {p0, p2, p3}, Lcom/android/internal/telephony/SubscriptionController;->validateSubId(J)V

    .line 874
    if-gez p1, :cond_0

    .line 875
    const-string v1, "[setDataRoaming]- fail"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 876
    const/4 v0, -0x1

    .line 887
    :goto_0
    return v0

    .line 878
    :cond_0
    new-instance v7, Landroid/content/ContentValues;

    const/4 v1, 0x1

    invoke-direct {v7, v1}, Landroid/content/ContentValues;-><init>(I)V

    .line 879
    .local v7, "value":Landroid/content/ContentValues;
    const-string v1, "data_roaming"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v7, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 880
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[setDataRoaming]- roaming:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " set"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 882
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "_id="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {p2, p3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v7, v3, v4}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v0

    .line 884
    .local v0, "result":I
    const-string v4, "data_roaming"

    const-string v6, "N/A"

    move-object v1, p0

    move-wide v2, p2

    move v5, p1

    invoke-direct/range {v1 .. v6}, Lcom/android/internal/telephony/SubscriptionController;->broadcastSimInfoContentChanged(JLjava/lang/String;ILjava/lang/String;)V

    goto :goto_0
.end method

.method public setDefaultDataSubId(J)V
    .locals 5
    .param p1, "subId"    # J

    .prologue
    .line 1247
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[setDefaultDataSubId] subId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1249
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mDctController:Lcom/android/internal/telephony/dataconnection/DctController;

    if-nez v0, :cond_0

    .line 1250
    invoke-static {}, Lcom/android/internal/telephony/dataconnection/DctController;->getInstance()Lcom/android/internal/telephony/dataconnection/DctController;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mDctController:Lcom/android/internal/telephony/dataconnection/DctController;

    .line 1251
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mDctController:Lcom/android/internal/telephony/dataconnection/DctController;

    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mDataConnectionHandler:Lcom/android/internal/telephony/SubscriptionController$DataConnectionHandler;

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/internal/telephony/dataconnection/DctController;->registerForDefaultDataSwitchInfo(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 1254
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mDctController:Lcom/android/internal/telephony/dataconnection/DctController;

    invoke-virtual {v0, p1, p2}, Lcom/android/internal/telephony/dataconnection/DctController;->setDefaultDataSubId(J)V

    .line 1256
    return-void
.end method

.method public setDefaultSmsSubId(J)V
    .locals 3
    .param p1, "subId"    # J

    .prologue
    .line 1148
    const-wide v0, 0x7fffffffffffffffL

    cmp-long v0, p1, v0

    if-nez v0, :cond_0

    .line 1149
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "setDefaultSmsSubId called with DEFAULT_SUB_ID"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1151
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[setDefaultSmsSubId] subId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1152
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "multi_sim_sms"

    invoke-static {v0, v1, p1, p2}, Landroid/provider/Settings$Global;->putLong(Landroid/content/ContentResolver;Ljava/lang/String;J)Z

    .line 1154
    invoke-direct {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->broadcastDefaultSmsSubIdChanged(J)V

    .line 1155
    return-void
.end method

.method public setDefaultSubId(J)V
    .locals 7
    .param p1, "subId"    # J

    .prologue
    .line 1299
    const-wide v4, 0x7fffffffffffffffL

    cmp-long v3, p1, v4

    if-nez v3, :cond_0

    .line 1300
    new-instance v3, Ljava/lang/RuntimeException;

    const-string v4, "setDefaultSubId called with DEFAULT_SUB_ID"

    invoke-direct {v3, v4}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 1302
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[setDefaultSubId] subId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1303
    invoke-static {p1, p2}, Landroid/telephony/SubscriptionManager;->isValidSubId(J)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 1304
    invoke-virtual {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->getPhoneId(J)I

    move-result v2

    .line 1305
    .local v2, "phoneId":I
    if-ltz v2, :cond_2

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getPhoneCount()I

    move-result v3

    if-lt v2, v3, :cond_1

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getSimCount()I

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_2

    .line 1307
    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[setDefaultSubId] set mDefaultVoiceSubId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1308
    sput-wide p1, Lcom/android/internal/telephony/SubscriptionController;->mDefaultVoiceSubId:J

    .line 1310
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    int-to-long v4, v2

    invoke-virtual {v3, v4, v5}, Landroid/telephony/TelephonyManager;->getSimOperator(J)Ljava/lang/String;

    move-result-object v0

    .line 1311
    .local v0, "defaultMccMnc":Ljava/lang/String;
    iget-object v3, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    const/4 v4, 0x0

    invoke-static {v3, v0, v4}, Lcom/android/internal/telephony/MccTable;->updateMccMncConfiguration(Landroid/content/Context;Ljava/lang/String;Z)V

    .line 1314
    invoke-virtual {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultSmsSubId(J)V

    .line 1318
    new-instance v1, Landroid/content/Intent;

    const-string v3, "android.intent.action.ACTION_DEFAULT_SUBSCRIPTION_CHANGED"

    invoke-direct {v1, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1319
    .local v1, "intent":Landroid/content/Intent;
    const/high16 v3, 0x20000000

    invoke-virtual {v1, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1320
    invoke-static {v1, v2, p1, p2}, Landroid/telephony/SubscriptionManager;->putPhoneIdAndSubIdExtra(Landroid/content/Intent;IJ)V

    .line 1325
    iget-object v3, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    sget-object v4, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v3, v1, v4}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 1332
    .end local v0    # "defaultMccMnc":Ljava/lang/String;
    .end local v1    # "intent":Landroid/content/Intent;
    .end local v2    # "phoneId":I
    :cond_2
    return-void
.end method

.method public setDefaultVoiceSubId(J)V
    .locals 3
    .param p1, "subId"    # J

    .prologue
    .line 1177
    const-wide v0, 0x7fffffffffffffffL

    cmp-long v0, p1, v0

    if-nez v0, :cond_0

    .line 1178
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "setDefaultVoiceSubId called with DEFAULT_SUB_ID"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1180
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[setDefaultVoiceSubId] subId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logdl(Ljava/lang/String;)V

    .line 1181
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "multi_sim_voice_call"

    invoke-static {v0, v1, p1, p2}, Landroid/provider/Settings$Global;->putLong(Landroid/content/ContentResolver;Ljava/lang/String;J)Z

    .line 1183
    invoke-direct {p0, p1, p2}, Lcom/android/internal/telephony/SubscriptionController;->broadcastDefaultVoiceSubIdChanged(J)V

    .line 1184
    return-void
.end method

.method public setDisplayName(Ljava/lang/String;J)I
    .locals 6
    .param p1, "displayName"    # Ljava/lang/String;
    .param p2, "subId"    # J

    .prologue
    .line 743
    const-wide/16 v4, -0x1

    move-object v0, p0

    move-object v1, p1

    move-wide v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/android/internal/telephony/SubscriptionController;->setDisplayNameUsingSrc(Ljava/lang/String;JJ)I

    move-result v0

    return v0
.end method

.method public setDisplayNameUsingSrc(Ljava/lang/String;JJ)I
    .locals 8
    .param p1, "displayName"    # Ljava/lang/String;
    .param p2, "subId"    # J
    .param p4, "nameSource"    # J

    .prologue
    .line 756
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[setDisplayName]+  displayName:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " subId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " nameSource:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 758
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 760
    invoke-direct {p0, p2, p3}, Lcom/android/internal/telephony/SubscriptionController;->validateSubId(J)V

    .line 762
    if-nez p1, :cond_1

    .line 763
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    const v2, 0x104000e

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v6

    .line 767
    .local v6, "nameToSet":Ljava/lang/String;
    :goto_0
    new-instance v7, Landroid/content/ContentValues;

    const/4 v1, 0x1

    invoke-direct {v7, v1}, Landroid/content/ContentValues;-><init>(I)V

    .line 768
    .local v7, "value":Landroid/content/ContentValues;
    const-string v1, "display_name"

    invoke-virtual {v7, v1, v6}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 769
    const-wide/16 v2, 0x0

    cmp-long v1, p4, v2

    if-ltz v1, :cond_0

    .line 770
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Set nameSource="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 771
    const-string v1, "name_source"

    invoke-static {p4, p5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v7, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    .line 773
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[setDisplayName]- mDisplayName:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " set"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 775
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "_id="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {p2, p3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v7, v3, v4}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v0

    .line 777
    .local v0, "result":I
    const-string v4, "display_name"

    const/16 v5, -0x64

    move-object v1, p0

    move-wide v2, p2

    invoke-direct/range {v1 .. v6}, Lcom/android/internal/telephony/SubscriptionController;->broadcastSimInfoContentChanged(JLjava/lang/String;ILjava/lang/String;)V

    .line 780
    return v0

    .line 765
    .end local v0    # "result":I
    .end local v6    # "nameToSet":Ljava/lang/String;
    .end local v7    # "value":Landroid/content/ContentValues;
    :cond_1
    move-object v6, p1

    .restart local v6    # "nameToSet":Ljava/lang/String;
    goto :goto_0
.end method

.method public setDisplayNumber(Ljava/lang/String;J)I
    .locals 18
    .param p1, "number"    # Ljava/lang/String;
    .param p2, "subId"    # J

    .prologue
    .line 791
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[setDisplayNumber]+ number:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, p1

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " subId:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-wide/from16 v0, p2

    invoke-virtual {v5, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 792
    invoke-direct/range {p0 .. p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 794
    move-object/from16 v0, p0

    move-wide/from16 v1, p2

    invoke-direct {v0, v1, v2}, Lcom/android/internal/telephony/SubscriptionController;->validateSubId(J)V

    .line 795
    const/4 v15, 0x0

    .line 796
    .local v15, "result":I
    move-object/from16 v0, p0

    move-wide/from16 v1, p2

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/SubscriptionController;->getPhoneId(J)I

    move-result v13

    .line 798
    .local v13, "phoneId":I
    if-eqz p1, :cond_0

    if-ltz v13, :cond_0

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getPhoneCount()I

    move-result v5

    if-lt v13, v5, :cond_1

    .line 800
    :cond_0
    const-string v5, "[setDispalyNumber]- fail"

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 801
    const/4 v5, -0x1

    .line 831
    :goto_0
    return v5

    .line 803
    :cond_1
    new-instance v16, Landroid/content/ContentValues;

    const/4 v5, 0x1

    move-object/from16 v0, v16

    invoke-direct {v0, v5}, Landroid/content/ContentValues;-><init>(I)V

    .line 804
    .local v16, "value":Landroid/content/ContentValues;
    const-string v5, "number"

    move-object/from16 v0, v16

    move-object/from16 v1, p1

    invoke-virtual {v0, v5, v1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 805
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[setDisplayNumber]- number:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    move-object/from16 v0, p1

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " set"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 807
    sget-object v5, Lcom/android/internal/telephony/SubscriptionController;->sProxyPhones:[Lcom/android/internal/telephony/PhoneProxy;

    aget-object v12, v5, v13

    .line 808
    .local v12, "phone":Lcom/android/internal/telephony/Phone;
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v5

    move-wide/from16 v0, p2

    invoke-virtual {v5, v0, v1}, Landroid/telephony/TelephonyManager;->getLine1AlphaTagForSubscriber(J)Ljava/lang/String;

    move-result-object v4

    .line 810
    .local v4, "alphaTag":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/android/internal/telephony/SubscriptionController;->mLock:Ljava/lang/Object;

    monitor-enter v6

    .line 811
    const/4 v5, 0x0

    :try_start_0
    move-object/from16 v0, p0

    iput-boolean v5, v0, Lcom/android/internal/telephony/SubscriptionController;->mSuccess:Z

    .line 812
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/SubscriptionController;->mHandler:Landroid/os/Handler;

    const/4 v7, 0x1

    invoke-virtual {v5, v7}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v14

    .line 814
    .local v14, "response":Landroid/os/Message;
    move-object/from16 v0, p1

    invoke-interface {v12, v4, v0, v14}, Lcom/android/internal/telephony/Phone;->setLine1Number(Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 817
    :try_start_1
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/SubscriptionController;->mLock:Ljava/lang/Object;

    invoke-virtual {v5}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 821
    :goto_1
    :try_start_2
    monitor-exit v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 823
    move-object/from16 v0, p0

    iget-boolean v5, v0, Lcom/android/internal/telephony/SubscriptionController;->mSuccess:Z

    if-eqz v5, :cond_2

    .line 824
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    sget-object v6, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "_id="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-static/range {p2 .. p3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    const/4 v8, 0x0

    move-object/from16 v0, v16

    invoke-virtual {v5, v6, v0, v7, v8}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v15

    .line 826
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[setDisplayNumber]- update result :"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 827
    const-string v8, "number"

    const/16 v9, -0x64

    move-object/from16 v5, p0

    move-wide/from16 v6, p2

    move-object/from16 v10, p1

    invoke-direct/range {v5 .. v10}, Lcom/android/internal/telephony/SubscriptionController;->broadcastSimInfoContentChanged(JLjava/lang/String;ILjava/lang/String;)V

    :cond_2
    move v5, v15

    .line 831
    goto/16 :goto_0

    .line 818
    :catch_0
    move-exception v11

    .line 819
    .local v11, "e":Ljava/lang/InterruptedException;
    :try_start_3
    const-string v5, "interrupted while trying to write MSISDN"

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/android/internal/telephony/SubscriptionController;->loge(Ljava/lang/String;)V

    goto :goto_1

    .line 821
    .end local v11    # "e":Ljava/lang/InterruptedException;
    .end local v14    # "response":Landroid/os/Message;
    :catchall_0
    move-exception v5

    monitor-exit v6
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v5
.end method

.method public setDisplayNumberFormat(IJ)I
    .locals 8
    .param p1, "format"    # I
    .param p2, "subId"    # J

    .prologue
    .line 842
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[setDisplayNumberFormat]+ format:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " subId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 843
    invoke-direct {p0}, Lcom/android/internal/telephony/SubscriptionController;->enforceSubscriptionPermission()V

    .line 845
    invoke-direct {p0, p2, p3}, Lcom/android/internal/telephony/SubscriptionController;->validateSubId(J)V

    .line 846
    if-gez p1, :cond_0

    .line 847
    const-string v1, "[setDisplayNumberFormat]- fail, return -1"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 848
    const/4 v0, -0x1

    .line 859
    :goto_0
    return v0

    .line 850
    :cond_0
    new-instance v7, Landroid/content/ContentValues;

    const/4 v1, 0x1

    invoke-direct {v7, v1}, Landroid/content/ContentValues;-><init>(I)V

    .line 851
    .local v7, "value":Landroid/content/ContentValues;
    const-string v1, "display_number_format"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v7, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 852
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[setDisplayNumberFormat]- format:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " set"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 854
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "_id="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {p2, p3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v7, v3, v4}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v0

    .line 856
    .local v0, "result":I
    const-string v4, "display_number_format"

    const-string v6, "N/A"

    move-object v1, p0

    move-wide v2, p2

    move v5, p1

    invoke-direct/range {v1 .. v6}, Lcom/android/internal/telephony/SubscriptionController;->broadcastSimInfoContentChanged(JLjava/lang/String;ILjava/lang/String;)V

    goto :goto_0
.end method

.method public setMccMnc(Ljava/lang/String;J)I
    .locals 10
    .param p1, "mccMnc"    # Ljava/lang/String;
    .param p2, "subId"    # J

    .prologue
    const/4 v6, 0x0

    .line 897
    const/4 v5, 0x0

    .line 898
    .local v5, "mcc":I
    const/4 v7, 0x0

    .line 900
    .local v7, "mnc":I
    const/4 v1, 0x0

    const/4 v2, 0x3

    :try_start_0
    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v5

    .line 901
    const/4 v1, 0x3

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v7

    .line 905
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[setMccMnc]+ mcc/mnc:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " subId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 906
    new-instance v9, Landroid/content/ContentValues;

    const/4 v1, 0x2

    invoke-direct {v9, v1}, Landroid/content/ContentValues;-><init>(I)V

    .line 907
    .local v9, "value":Landroid/content/ContentValues;
    const-string v1, "mcc"

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v9, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 908
    const-string v1, "mnc"

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v9, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 910
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "_id="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {p2, p3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v9, v3, v6}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v8

    .line 912
    .local v8, "result":I
    const-string v4, "mcc"

    move-object v1, p0

    move-wide v2, p2

    invoke-direct/range {v1 .. v6}, Lcom/android/internal/telephony/SubscriptionController;->broadcastSimInfoContentChanged(JLjava/lang/String;ILjava/lang/String;)V

    .line 914
    return v8

    .line 902
    .end local v8    # "result":I
    .end local v9    # "value":Landroid/content/ContentValues;
    :catch_0
    move-exception v0

    .line 903
    .local v0, "e":Ljava/lang/NumberFormatException;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[setMccMnc] - couldn\'t parse mcc/mnc: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method public setNwMode(JI)V
    .locals 5
    .param p1, "subId"    # J
    .param p3, "nwMode"    # I

    .prologue
    .line 1570
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setNwMode, nwMode: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " subId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1571
    new-instance v0, Landroid/content/ContentValues;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/content/ContentValues;-><init>(I)V

    .line 1572
    .local v0, "value":Landroid/content/ContentValues;
    const-string v1, "network_mode"

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 1573
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "_id="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {p1, p2}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v0, v3, v4}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    .line 1575
    return-void
.end method

.method public setSMSPromptEnabled(Z)V
    .locals 3
    .param p1, "enabled"    # Z

    .prologue
    .line 1224
    if-nez p1, :cond_0

    const/4 v0, 0x0

    .line 1225
    .local v0, "value":I
    :goto_0
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "multi_sim_sms_prompt"

    invoke-static {v1, v2, v0}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 1227
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setSMSPromptOption to "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1228
    return-void

    .line 1224
    .end local v0    # "value":I
    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public setSubState(JI)I
    .locals 9
    .param p1, "subId"    # J
    .param p3, "subStatus"    # I

    .prologue
    .line 1589
    const/4 v0, 0x0

    .line 1590
    .local v0, "result":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setSubState, subStatus: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " subId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1591
    invoke-static {}, Lcom/android/internal/telephony/ModemStackController;->getInstance()Lcom/android/internal/telephony/ModemStackController;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/ModemStackController;->isStackReady()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1592
    new-instance v7, Landroid/content/ContentValues;

    const/4 v1, 0x1

    invoke-direct {v7, v1}, Landroid/content/ContentValues;-><init>(I)V

    .line 1593
    .local v7, "value":Landroid/content/ContentValues;
    const-string v1, "sub_state"

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v7, v1, v2}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 1594
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v2, Landroid/telephony/SubscriptionManager;->CONTENT_URI:Landroid/net/Uri;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "_id="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {p1, p2}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v7, v3, v4}, Landroid/content/ContentResolver;->update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v0

    .line 1598
    .end local v7    # "value":Landroid/content/ContentValues;
    :cond_0
    const-string v4, "sub_state"

    const-string v6, "N/A"

    move-object v1, p0

    move-wide v2, p1

    move v5, p3

    invoke-direct/range {v1 .. v6}, Lcom/android/internal/telephony/SubscriptionController;->broadcastSimInfoContentChanged(JLjava/lang/String;ILjava/lang/String;)V

    .line 1600
    return v0
.end method

.method public setVoicePromptEnabled(Z)V
    .locals 3
    .param p1, "enabled"    # Z

    .prologue
    .line 1693
    if-nez p1, :cond_0

    const/4 v0, 0x0

    .line 1694
    .local v0, "value":I
    :goto_0
    iget-object v1, p0, Lcom/android/internal/telephony/SubscriptionController;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "multi_sim_voice_prompt"

    invoke-static {v1, v2, v0}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 1696
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setVoicePromptOption to "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1697
    return-void

    .line 1693
    .end local v0    # "value":I
    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public startOnDemandDataSubscriptionRequest(Landroid/net/NetworkRequest;)V
    .locals 2
    .param p1, "n"    # Landroid/net/NetworkRequest;

    .prologue
    .line 244
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "startOnDemandDataSubscriptionRequest = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 245
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mSchedulerAc:Lcom/android/internal/telephony/dataconnection/DdsSchedulerAc;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/dataconnection/DdsSchedulerAc;->allocateDds(Landroid/net/NetworkRequest;)V

    .line 246
    return-void
.end method

.method public stopOnDemandDataSubscriptionRequest(Landroid/net/NetworkRequest;)V
    .locals 2
    .param p1, "n"    # Landroid/net/NetworkRequest;

    .prologue
    .line 249
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "stopOnDemandDataSubscriptionRequest = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 250
    iget-object v0, p0, Lcom/android/internal/telephony/SubscriptionController;->mSchedulerAc:Lcom/android/internal/telephony/dataconnection/DdsSchedulerAc;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/dataconnection/DdsSchedulerAc;->freeDds(Landroid/net/NetworkRequest;)V

    .line 251
    return-void
.end method

.method public updatePhonesAvailability([Lcom/android/internal/telephony/PhoneProxy;)V
    .locals 0
    .param p1, "phones"    # [Lcom/android/internal/telephony/PhoneProxy;

    .prologue
    .line 1459
    sput-object p1, Lcom/android/internal/telephony/SubscriptionController;->sProxyPhones:[Lcom/android/internal/telephony/PhoneProxy;

    .line 1460
    return-void
.end method

.method public updateUserPrefs(Z)V
    .locals 13
    .param p1, "setDds"    # Z

    .prologue
    const/4 v12, 0x0

    .line 1619
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getActiveSubInfoList()Ljava/util/List;

    move-result-object v7

    .line 1620
    .local v7, "subInfoList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    const/4 v4, 0x0

    .line 1621
    .local v4, "mActCount":I
    const/4 v5, 0x0

    .line 1623
    .local v5, "mNextActivatedSub":Landroid/telephony/SubInfoRecord;
    if-nez v7, :cond_1

    .line 1624
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "updateUserPrefs: subscription are not avaiable dds = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultDataSubId()J

    move-result-wide v10

    invoke-virtual {v8, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " voice = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultVoiceSubId()J

    move-result-wide v10

    invoke-virtual {v8, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " sms = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSmsSubId()J

    move-result-wide v10

    invoke-virtual {v8, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " setDDs = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {p0, v8}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1671
    :cond_0
    :goto_0
    return-void

    .line 1631
    :cond_1
    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :cond_2
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/telephony/SubInfoRecord;

    .line 1632
    .local v6, "subInfo":Landroid/telephony/SubInfoRecord;
    iget-wide v8, v6, Landroid/telephony/SubInfoRecord;->subId:J

    invoke-virtual {p0, v8, v9}, Lcom/android/internal/telephony/SubscriptionController;->getSubState(J)I

    move-result v8

    const/4 v9, 0x1

    if-ne v8, v9, :cond_2

    .line 1633
    add-int/lit8 v4, v4, 0x1

    .line 1634
    if-nez v5, :cond_2

    move-object v5, v6

    goto :goto_1

    .line 1638
    .end local v6    # "subInfo":Landroid/telephony/SubInfoRecord;
    :cond_3
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "updateUserPrefs: active sub count = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " dds = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultDataSubId()J

    move-result-wide v10

    invoke-virtual {v8, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " voice = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultVoiceSubId()J

    move-result-wide v10

    invoke-virtual {v8, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " sms = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSmsSubId()J

    move-result-wide v10

    invoke-virtual {v8, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " setDDs = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {p0, v8}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    .line 1642
    const/4 v8, 0x2

    if-ge v4, v8, :cond_4

    .line 1643
    invoke-virtual {p0, v12}, Lcom/android/internal/telephony/SubscriptionController;->setSMSPromptEnabled(Z)V

    .line 1644
    invoke-virtual {p0, v12}, Lcom/android/internal/telephony/SubscriptionController;->setVoicePromptEnabled(Z)V

    .line 1648
    :cond_4
    if-eqz v5, :cond_0

    .line 1650
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultDataSubId()J

    move-result-wide v0

    .line 1651
    .local v0, "ddsSubId":J
    invoke-virtual {p0, v0, v1}, Lcom/android/internal/telephony/SubscriptionController;->getSubState(J)I

    move-result v2

    .line 1653
    .local v2, "ddsSubState":I
    if-nez p1, :cond_5

    if-nez v2, :cond_7

    .line 1654
    :cond_5
    if-nez v2, :cond_6

    iget-wide v0, v5, Landroid/telephony/SubInfoRecord;->subId:J

    .line 1655
    :cond_6
    invoke-virtual {p0, v0, v1}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultDataSubId(J)V

    .line 1658
    :cond_7
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultVoiceSubId()J

    move-result-wide v8

    invoke-virtual {p0, v8, v9}, Lcom/android/internal/telephony/SubscriptionController;->getSubState(J)I

    move-result v8

    if-nez v8, :cond_8

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->isVoicePromptEnabled()Z

    move-result v8

    if-nez v8, :cond_8

    .line 1660
    iget-wide v8, v5, Landroid/telephony/SubInfoRecord;->subId:J

    invoke-virtual {p0, v8, v9}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultVoiceSubId(J)V

    .line 1663
    :cond_8
    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSmsSubId()J

    move-result-wide v8

    invoke-virtual {p0, v8, v9}, Lcom/android/internal/telephony/SubscriptionController;->getSubState(J)I

    move-result v8

    if-nez v8, :cond_9

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->isSMSPromptEnabled()Z

    move-result v8

    if-nez v8, :cond_9

    .line 1665
    iget-wide v8, v5, Landroid/telephony/SubInfoRecord;->subId:J

    invoke-virtual {p0, v8, v9}, Lcom/android/internal/telephony/SubscriptionController;->setDefaultSmsSubId(J)V

    .line 1667
    :cond_9
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "updateUserPrefs: after currentDds = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultDataSubId()J

    move-result-wide v10

    invoke-virtual {v8, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " voice = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultVoiceSubId()J

    move-result-wide v10

    invoke-virtual {v8, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " sms = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p0}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSmsSubId()J

    move-result-wide v10

    invoke-virtual {v8, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " newDds = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {p0, v8}, Lcom/android/internal/telephony/SubscriptionController;->logd(Ljava/lang/String;)V

    goto/16 :goto_0
.end method
