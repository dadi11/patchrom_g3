.class public Lcom/android/internal/telephony/LGImsIsimHandler;
.super Landroid/os/Handler;
.source "LGImsIsimHandler.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/LGImsIsimHandler$SimStateReceiver;
    }
.end annotation


# static fields
.field public static final ACTION_ISIM_STATE_CHANGED:Ljava/lang/String; = "com.lge.ims.ISIM_STATE_CHANGED"

.field private static final EVENT_ISIM_RECORDS_LOADED:I = 0x1

.field public static final EXTRA_ISIM_STATE:Ljava/lang/String; = "isimState"

.field public static final ISIM_STATE_LOADED:Ljava/lang/String; = "LOADED"

.field public static final ISIM_STATE_NOT_PRESENT:Ljava/lang/String; = "NOT_PRESENT"

.field public static final ISIM_STATE_NOT_READY:Ljava/lang/String; = "NOT_READY"

.field public static final ISIM_STATE_REFRESH_COMPLETED:Ljava/lang/String; = "REFRESH_COMPLETED"

.field public static final ISIM_STATE_REFRESH_STARTED:Ljava/lang/String; = "REFRESH_STARTED"

.field private static final STATE_IDLE:I = 0x0

.field private static final STATE_LOADED:I = 0x1

.field private static final STATE_REFRESHING:I = 0x2

.field private static final TAG:Ljava/lang/String; = "LGImsIsimHandler"


# instance fields
.field private mContext:Landroid/content/Context;

.field private mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

.field private mIsimState:I

.field private mSimLoaded:Z

.field private mSimStateReceiver:Lcom/android/internal/telephony/LGImsIsimHandler$SimStateReceiver;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    iput-object v2, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mContext:Landroid/content/Context;

    iput-object v2, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    iput-boolean v1, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mSimLoaded:Z

    iput v1, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimState:I

    new-instance v1, Lcom/android/internal/telephony/LGImsIsimHandler$SimStateReceiver;

    invoke-direct {v1, p0}, Lcom/android/internal/telephony/LGImsIsimHandler$SimStateReceiver;-><init>(Lcom/android/internal/telephony/LGImsIsimHandler;)V

    iput-object v1, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mSimStateReceiver:Lcom/android/internal/telephony/LGImsIsimHandler$SimStateReceiver;

    iput-object p1, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mContext:Landroid/content/Context;

    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "android.intent.action.SIM_STATE_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "com.android.intent.isim_refresh"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mSimStateReceiver:Lcom/android/internal/telephony/LGImsIsimHandler$SimStateReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    const-string v1, "NOT_READY"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/LGImsIsimHandler;->notifyIsimState(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
    invoke-static {p0}, Lcom/android/internal/telephony/LGImsIsimHandler;->log(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/LGImsIsimHandler;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/LGImsIsimHandler;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/LGImsIsimHandler;->handleSimReady()V

    return-void
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/LGImsIsimHandler;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/LGImsIsimHandler;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/LGImsIsimHandler;->handleSimLoaded()V

    return-void
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/LGImsIsimHandler;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/LGImsIsimHandler;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/LGImsIsimHandler;->handleIsimRefreshStarted()V

    return-void
.end method

.method private handleIsimRefreshStarted()V
    .locals 2

    .prologue
    const-string v0, "IMS-ISIM :: refresh started"

    invoke-static {v0}, Lcom/android/internal/telephony/LGImsIsimHandler;->log(Ljava/lang/String;)V

    iget v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimState:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/LGImsIsimHandler;->setIsimState(I)V

    const-string v0, "REFRESH_STARTED"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/LGImsIsimHandler;->notifyIsimState(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private handleSimLoaded()V
    .locals 1

    .prologue
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mSimLoaded:Z

    invoke-direct {p0}, Lcom/android/internal/telephony/LGImsIsimHandler;->isIsimPresent()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/LGImsIsimHandler;->setIsimRecordsAndRegisterEvent()V

    invoke-direct {p0}, Lcom/android/internal/telephony/LGImsIsimHandler;->isIsimPresent()Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "IMS-ISIM :: no ISIM application"

    invoke-static {v0}, Lcom/android/internal/telephony/LGImsIsimHandler;->log(Ljava/lang/String;)V

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/LGImsIsimHandler;->setIsimState(I)V

    const-string v0, "NOT_PRESENT"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/LGImsIsimHandler;->notifyIsimState(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private handleSimReady()V
    .locals 0

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/LGImsIsimHandler;->setIsimRecordsAndRegisterEvent()V

    return-void
.end method

.method private isIsimPresent()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private isSimLoaded()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mSimLoaded:Z

    return v0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 1
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    const-string v0, "LGImsIsimHandler"

    invoke-static {v0, p0}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private notifyIsimState(Ljava/lang/String;)V
    .locals 3
    .param p1, "state"    # Ljava/lang/String;

    .prologue
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.ims.ISIM_STATE_CHANGED"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const/high16 v1, 0x20000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    const-string v1, "isimState"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "android.permission.READ_PHONE_STATE"

    const/4 v2, -0x1

    invoke-static {v0, v1, v2}, Landroid/app/ActivityManagerNative;->broadcastStickyIntent(Landroid/content/Intent;Ljava/lang/String;I)V

    return-void
.end method

.method private setIsimRecordsAndRegisterEvent()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    invoke-static {}, Lcom/android/internal/telephony/SubscriptionController;->getInstance()Lcom/android/internal/telephony/SubscriptionController;

    move-result-object v1

    .local v1, "sc":Lcom/android/internal/telephony/SubscriptionController;
    invoke-static {}, Lcom/android/internal/telephony/uicc/UiccController;->getInstance()Lcom/android/internal/telephony/uicc/UiccController;

    move-result-object v2

    .local v2, "uc":Lcom/android/internal/telephony/uicc/UiccController;
    invoke-virtual {v1}, Lcom/android/internal/telephony/SubscriptionController;->getDefaultSubId()J

    move-result-wide v4

    invoke-virtual {v1, v4, v5}, Lcom/android/internal/telephony/SubscriptionController;->getPhoneId(J)I

    move-result v3

    const/4 v4, 0x3

    invoke-virtual {v2, v3, v4}, Lcom/android/internal/telephony/uicc/UiccController;->getIccRecords(II)Lcom/android/internal/telephony/uicc/IccRecords;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    .local v0, "isimRecords":Lcom/android/internal/telephony/uicc/IsimUiccRecords;
    iget-object v3, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    if-eq v3, v0, :cond_1

    const-string v3, "IMS-ISIM :: IsimRecord is changed"

    invoke-static {v3}, Lcom/android/internal/telephony/LGImsIsimHandler;->log(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    invoke-virtual {v3, p0}, Lcom/android/internal/telephony/uicc/IsimUiccRecords;->unregisterForRecordsLoaded(Landroid/os/Handler;)V

    iput-object v6, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    :cond_0
    iput-object v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    iget-object v3, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    if-eqz v3, :cond_1

    iget-object v3, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    const/4 v4, 0x1

    invoke-virtual {v3, p0, v4, v6}, Lcom/android/internal/telephony/uicc/IsimUiccRecords;->registerForRecordsLoaded(Landroid/os/Handler;ILjava/lang/Object;)V

    :cond_1
    return-void
.end method

.method private setIsimState(I)V
    .locals 2
    .param p1, "state"    # I

    .prologue
    iget v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimState:I

    if-eq v0, p1, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "IMS-ISIM :: state - "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimState:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " >> "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/LGImsIsimHandler;->log(Ljava/lang/String;)V

    iput p1, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimState:I

    :cond_0
    return-void
.end method


# virtual methods
.method public dispose()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mSimStateReceiver:Lcom/android/internal/telephony/LGImsIsimHandler$SimStateReceiver;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mSimStateReceiver:Lcom/android/internal/telephony/LGImsIsimHandler$SimStateReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimRecords:Lcom/android/internal/telephony/uicc/IsimUiccRecords;

    invoke-virtual {v0, p0}, Lcom/android/internal/telephony/uicc/IsimUiccRecords;->unregisterForRecordsLoaded(Landroid/os/Handler;)V

    :cond_1
    return-void
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v2, 0x1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "IMS-ISIM :: handleMessage - event="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p1, Landroid/os/Message;->what:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/LGImsIsimHandler;->log(Ljava/lang/String;)V

    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    iget v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimState:I

    if-nez v0, :cond_1

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/LGImsIsimHandler;->setIsimState(I)V

    const-string v0, "LOADED"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/LGImsIsimHandler;->notifyIsimState(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget v0, p0, Lcom/android/internal/telephony/LGImsIsimHandler;->mIsimState:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/LGImsIsimHandler;->setIsimState(I)V

    const-string v0, "REFRESH_COMPLETED"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/LGImsIsimHandler;->notifyIsimState(Ljava/lang/String;)V

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method
