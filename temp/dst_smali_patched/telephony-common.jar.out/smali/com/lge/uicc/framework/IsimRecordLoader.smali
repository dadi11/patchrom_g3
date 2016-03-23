.class public Lcom/lge/uicc/framework/IsimRecordLoader;
.super Lcom/lge/uicc/framework/IccHandler;
.source "IsimRecordLoader.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/uicc/framework/IsimRecordLoader$1;,
        Lcom/lge/uicc/framework/IsimRecordLoader$DeactivateAppTest;,
        Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthNafTest;,
        Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthBootstrapTest;,
        Lcom/lge/uicc/framework/IsimRecordLoader$AkaAuthTest;,
        Lcom/lge/uicc/framework/IsimRecordLoader$SelectAppTest;,
        Lcom/lge/uicc/framework/IsimRecordLoader$GbabpLoaded;,
        Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;,
        Lcom/lge/uicc/framework/IsimRecordLoader$IsimTest;
    }
.end annotation


# static fields
.field private static final ENABLE_ISIM_TEST:Z = false

.field private static final EVENT_ISIM_STATE_CHANGED:I = 0x1

.field private static final EVENT_ISIM_TEST_DONE:I = 0x2

.field private static final INTENT_GBA_INIT:Ljava/lang/String; = "com.movial.gba_initialized"

.field static isim_session_id:I

.field protected static mBtid:Ljava/lang/String;

.field private static mInstance:Lcom/lge/uicc/framework/IsimRecordLoader;

.field protected static mIsGbaSupported:Z

.field protected static mKeyLifetime:Ljava/lang/String;

.field protected static mRand:[B

.field private static mRil:Lcom/android/internal/telephony/RIL;


# instance fields
.field aka_autn:Ljava/lang/String;

.field aka_rand:Ljava/lang/String;

.field auts:Ljava/lang/String;

.field ck:Ljava/lang/String;

.field gba_autn:Ljava/lang/String;

.field gba_rand:Ljava/lang/String;

.field ik:Ljava/lang/String;

.field kc:Ljava/lang/String;

.field private mGbaRecordsRequested:Z

.field protected mIsimGbabp:Ljava/lang/String;

.field protected mIsimIst:Ljava/lang/String;

.field naf_id:Ljava/lang/String;

.field private recordsToIsimLoad:I

.field res:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput v0, Lcom/lge/uicc/framework/IsimRecordLoader;->isim_session_id:I

    return-void
.end method

.method private constructor <init>()V
    .locals 3

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Lcom/lge/uicc/framework/IccHandler;-><init>()V

    const-string v0, "651FC366CD44F4A71C8AFB1FFCAA0DAE"

    iput-object v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->aka_rand:Ljava/lang/String;

    const-string v0, "021CCAB40B9E0000799256368D4BBE31"

    iput-object v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->aka_autn:Ljava/lang/String;

    const-string v0, "6EEC6907BFEE16EC254C2DD1C9E186F9"

    iput-object v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->gba_rand:Ljava/lang/String;

    const-string v0, "70B4E32940B500002B63BEFB6EFDD5D2"

    iput-object v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->gba_autn:Ljava/lang/String;

    const-string v0, "70696D73796E632E6D73672E656E672E742D6D6F62696C652E636F6D0100000002"

    iput-object v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->naf_id:Ljava/lang/String;

    iput v1, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->recordsToIsimLoad:I

    iput-boolean v1, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->mGbaRecordsRequested:Z

    const-string v0, "proxy.isim_state"

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, p0, v1, v2}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    return-void
.end method

.method static synthetic access$308(Lcom/lge/uicc/framework/IsimRecordLoader;)I
    .locals 2
    .param p0, "x0"    # Lcom/lge/uicc/framework/IsimRecordLoader;

    .prologue
    iget v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->recordsToIsimLoad:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->recordsToIsimLoad:I

    return v0
.end method

.method static synthetic access$600()Lcom/android/internal/telephony/RIL;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mRil:Lcom/android/internal/telephony/RIL;

    return-object v0
.end method

.method protected static setup()V
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mInstance:Lcom/lge/uicc/framework/IsimRecordLoader;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/uicc/framework/IsimRecordLoader;

    invoke-direct {v0}, Lcom/lge/uicc/framework/IsimRecordLoader;-><init>()V

    sput-object v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mInstance:Lcom/lge/uicc/framework/IsimRecordLoader;

    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/lge/uicc/framework/IccTools;->getRIL(I)Lcom/android/internal/telephony/RIL;

    move-result-object v0

    sput-object v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mRil:Lcom/android/internal/telephony/RIL;

    return-void
.end method


# virtual methods
.method public fetchIsimRecords()V
    .locals 5

    .prologue
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->mGbaRecordsRequested:Z

    const-string v0, "fetch EF_ISIM_IST"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    const/4 v0, 0x0

    const/4 v1, 0x3

    const/16 v2, 0x6f07

    new-instance v3, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;

    const/4 v4, 0x0

    invoke-direct {v3, p0, v4}, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;-><init>(Lcom/lge/uicc/framework/IsimRecordLoader;Lcom/lge/uicc/framework/IsimRecordLoader$1;)V

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordLoaded;)Landroid/os/Message;

    move-result-object v3

    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->loadEFTransparent(IIILandroid/os/Message;)V

    iget v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->recordsToIsimLoad:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->recordsToIsimLoad:I

    return-void
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v5, 0x0

    iget v3, p1, Landroid/os/Message;->what:I

    packed-switch v3, :pswitch_data_0

    invoke-super {p0, p1}, Lcom/lge/uicc/framework/IccHandler;->handleMessage(Landroid/os/Message;)V

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    const-string v3, "proxy.isim_state"

    invoke-static {v3, v5}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v3

    sget-object v4, Lcom/android/internal/telephony/IccCardConstants$State;->UNKNOWN:Lcom/android/internal/telephony/IccCardConstants$State;

    invoke-virtual {v4}, Lcom/android/internal/telephony/IccCardConstants$State;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const-string v3, "start reset isim records..."

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/uicc/framework/IsimRecordLoader;->resetIsimRecords()V

    const-string v3, "[ISIM] EVENT_ISIM_STATE_UNKNOWN"

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    const-string v3, "proxy.isim_state"

    invoke-static {v3, v5}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v3

    sget-object v4, Lcom/android/internal/telephony/IccCardConstants$State;->READY:Lcom/android/internal/telephony/IccCardConstants$State;

    invoke-virtual {v4}, Lcom/android/internal/telephony/IccCardConstants$State;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v3, "start loading isim records..."

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/uicc/framework/IsimRecordLoader;->fetchIsimRecords()V

    const-string v3, "[ISIM] EVENT_ISIM_STATE_READY"

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    goto :goto_0

    :pswitch_1
    :try_start_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v2, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v2, Lcom/lge/uicc/framework/IsimRecordLoader$IsimTest;

    .local v2, "testcase":Lcom/lge/uicc/framework/IsimRecordLoader$IsimTest;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Lcom/lge/uicc/framework/IsimRecordLoader$IsimTest;->getTestName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " DONE"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    iget-object v3, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v3, :cond_2

    iget-object v3, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v2, v3}, Lcom/lge/uicc/framework/IsimRecordLoader$IsimTest;->onTestException(Ljava/lang/Throwable;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v2    # "testcase":Lcom/lge/uicc/framework/IsimRecordLoader$IsimTest;
    :catch_0
    move-exception v1

    .local v1, "exc":Ljava/lang/RuntimeException;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Exception parsing record: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->loge(Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v1    # "exc":Ljava/lang/RuntimeException;
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    .restart local v2    # "testcase":Lcom/lge/uicc/framework/IsimRecordLoader$IsimTest;
    :cond_2
    :try_start_1
    iget-object v3, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v3, :cond_3

    iget-object v3, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    invoke-virtual {v2, v3}, Lcom/lge/uicc/framework/IsimRecordLoader$IsimTest;->onTestCompleted(Ljava/lang/Object;)V

    goto/16 :goto_0

    :cond_3
    const-string v3, "Invalid state"

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->loge(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method protected onRecordLoaded()V
    .locals 5

    .prologue
    const/4 v2, 0x0

    iget v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->recordsToIsimLoad:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->recordsToIsimLoad:I

    iget-boolean v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->mGbaRecordsRequested:Z

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->recordsToIsimLoad:I

    if-nez v0, :cond_1

    const-string v0, "GBA records loaded"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    const-string v0, "[ISIM] Send Intent - IPUtils.INTENT_GBA_INIT"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.movial.gba_initialized"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/lge/uicc/framework/IccTools;->broadcastIntent(Landroid/content/Intent;)V

    iput-boolean v2, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->mGbaRecordsRequested:Z

    const-string v0, "[ISIM] ENABLE_ISIM_TEST = false"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    const-string v0, "Selecting ISIM Application"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    sget-object v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mRil:Lcom/android/internal/telephony/RIL;

    const/4 v1, 0x3

    invoke-static {v2, v1}, Lcom/lge/uicc/framework/IccTools;->getApplication(II)Lcom/android/internal/telephony/uicc/UiccCardApplication;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/uicc/UiccCardApplication;->getAid()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x2

    new-instance v3, Lcom/lge/uicc/framework/IsimRecordLoader$SelectAppTest;

    const/4 v4, 0x0

    invoke-direct {v3, p0, v4}, Lcom/lge/uicc/framework/IsimRecordLoader$SelectAppTest;-><init>(Lcom/lge/uicc/framework/IsimRecordLoader;Lcom/lge/uicc/framework/IsimRecordLoader$1;)V

    invoke-virtual {p0, v2, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/RIL;->uiccSelectApplication(Ljava/lang/String;Landroid/os/Message;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->recordsToIsimLoad:I

    if-gez v0, :cond_0

    const-string v0, "recordsToIsimLoad < 0, programmer error suspected"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IsimRecordLoader;->loge(Ljava/lang/String;)V

    iput v2, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->recordsToIsimLoad:I

    goto :goto_0
.end method

.method public resetIsimRecords()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    iput-boolean v1, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->mGbaRecordsRequested:Z

    iput-object v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->mIsimIst:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader;->mIsimGbabp:Ljava/lang/String;

    sput-boolean v1, Lcom/lge/uicc/framework/IsimRecordLoader;->mIsGbaSupported:Z

    sput-object v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mRand:[B

    sput-object v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mBtid:Ljava/lang/String;

    sput-object v0, Lcom/lge/uicc/framework/IsimRecordLoader;->mKeyLifetime:Ljava/lang/String;

    return-void
.end method
