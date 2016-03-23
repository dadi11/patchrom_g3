.class public Lcom/android/internal/telephony/SingleBinary;
.super Ljava/lang/Object;
.source "SingleBinary.java"


# static fields
.field private static final ACTION_SIM_STATE_CHANGED:Ljava/lang/String; = "android.intent.action.SIM_STATE_CHANGED"

.field private static final BROWSER_INDEX:I = 0x1

.field private static final INTENT_KEY_ICC_STATE:Ljava/lang/String; = "ss"

.field private static final LGHOME_INDEX:I = 0x0

.field private static final LOG_TAG:Ljava/lang/String; = "GSM"

.field private static final SIM_CHANGED:Ljava/lang/String; = "com.lge.intent.action.SIM_CHANGED_INFO"

.field private static final TELEPHONY_PROVIDER_INDEX:I = 0x2

.field private static isBrowserdbDeleted:Z

.field private static isLGHomedbDeleted:Z

.field private static isMatchedStatus:Z

.field private static isTelephonydbDeleted:Z

.field private static mContext:Landroid/content/Context;

.field private static mSingleBinary:Lcom/android/internal/telephony/SingleBinary;

.field private static mTryToSwitch:Z


# instance fields
.field private final CONFIG_MAP_FILE:Ljava/lang/String;

.field private final DATA_OPERATOR_FILE:Ljava/lang/String;

.field private final OPERATOR_DELETE_COMPLETE_INTENT:Ljava/lang/String;

.field OPERATOR_DELETE_FILTER:Landroid/content/IntentFilter;

.field OPERATOR_SWICHING_FILTER:Landroid/content/IntentFilter;

.field SIM_CHANGED_FILTER:Landroid/content/IntentFilter;

.field SIM_STATE_CHANGED_FILTER:Landroid/content/IntentFilter;

.field private dialogProgress:Landroid/app/AlertDialog;

.field private final handler:Landroid/os/Handler;

.field private mEnableSBP:Ljava/lang/String;

.field private mEnableUI:Ljava/lang/String;

.field private mFlexText:Landroid/widget/TextView;

.field private mImsi:Ljava/lang/String;

.field private mMncLength:I

.field private mNTCodeChanged:Ljava/lang/String;

.field private mNTcodeMcc:Ljava/lang/String;

.field private mSIMChanged:Ljava/lang/String;

.field private mSIMChecked:Ljava/lang/String;

.field private mSIMMcc:Ljava/lang/String;

.field private operatorSwitchReceiver:Landroid/content/BroadcastReceiver;

.field private final runnable:Ljava/lang/Runnable;

.field private setupWizardStartReceiver:Landroid/content/BroadcastReceiver;

.field private simChangedReceiver:Landroid/content/BroadcastReceiver;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-boolean v0, Lcom/android/internal/telephony/SingleBinary;->mTryToSwitch:Z

    sput-boolean v0, Lcom/android/internal/telephony/SingleBinary;->isMatchedStatus:Z

    sput-boolean v0, Lcom/android/internal/telephony/SingleBinary;->isTelephonydbDeleted:Z

    sput-boolean v0, Lcom/android/internal/telephony/SingleBinary;->isLGHomedbDeleted:Z

    sput-boolean v0, Lcom/android/internal/telephony/SingleBinary;->isBrowserdbDeleted:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 3

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "F"

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMChanged:Ljava/lang/String;

    const-string v0, "0"

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mNTCodeChanged:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    const-string v0, "/cust/cust_path_mapping.cfg"

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->CONFIG_MAP_FILE:Ljava/lang/String;

    const-string v0, "/data/.OP"

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->DATA_OPERATOR_FILE:Ljava/lang/String;

    const-string v0, "com.lge.action.CUST_DELETE_COMPLETE"

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->OPERATOR_DELETE_COMPLETE_INTENT:Ljava/lang/String;

    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "com.lge.setupwizard.ACTION_START_DELETE_APK"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->OPERATOR_DELETE_FILTER:Landroid/content/IntentFilter;

    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "com.lge.action.CUST_COMPLETE_INFO"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->OPERATOR_SWICHING_FILTER:Landroid/content/IntentFilter;

    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "android.intent.action.SIM_STATE_CHANGED"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->SIM_STATE_CHANGED_FILTER:Landroid/content/IntentFilter;

    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "com.lge.intent.action.SIM_CHANGED_INFO"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->SIM_CHANGED_FILTER:Landroid/content/IntentFilter;

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->handler:Landroid/os/Handler;

    new-instance v0, Lcom/android/internal/telephony/SingleBinary$1;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SingleBinary$1;-><init>(Lcom/android/internal/telephony/SingleBinary;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->runnable:Ljava/lang/Runnable;

    new-instance v0, Lcom/android/internal/telephony/SingleBinary$2;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SingleBinary$2;-><init>(Lcom/android/internal/telephony/SingleBinary;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->operatorSwitchReceiver:Landroid/content/BroadcastReceiver;

    new-instance v0, Lcom/android/internal/telephony/SingleBinary$3;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SingleBinary$3;-><init>(Lcom/android/internal/telephony/SingleBinary;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->setupWizardStartReceiver:Landroid/content/BroadcastReceiver;

    new-instance v0, Lcom/android/internal/telephony/SingleBinary$4;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SingleBinary$4;-><init>(Lcom/android/internal/telephony/SingleBinary;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->simChangedReceiver:Landroid/content/BroadcastReceiver;

    const-string v0, "GSM"

    const-string v1, "[LGE][SBP] Create!"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "ro.build.sbp"

    const-string v1, "0"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mEnableSBP:Ljava/lang/String;

    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mEnableSBP:Ljava/lang/String;

    const-string v1, "1"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "persist.sys.sim-changed"

    const-string v1, "F"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMChanged:Ljava/lang/String;

    const-string v0, "persist.sys.ntcode-changed"

    const-string v1, "0"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mNTCodeChanged:Ljava/lang/String;

    const-string v0, "persist.sys.iccid-mcc"

    const-string v1, "FFF"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMMcc:Ljava/lang/String;

    const-string v0, "persist.sys.mcc-list"

    const-string v1, "FFF"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mNTcodeMcc:Ljava/lang/String;

    const-string v0, "ro.build.sbp.ui"

    const-string v1, "0"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mEnableUI:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/android/internal/telephony/SingleBinary;->notifyMappingPath()V

    sget-object v0, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/SingleBinary;->setupWizardStartReceiver:Landroid/content/BroadcastReceiver;

    iget-object v2, p0, Lcom/android/internal/telephony/SingleBinary;->OPERATOR_DELETE_FILTER:Landroid/content/IntentFilter;

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    sget-object v0, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/SingleBinary;->simChangedReceiver:Landroid/content/BroadcastReceiver;

    iget-object v2, p0, Lcom/android/internal/telephony/SingleBinary;->SIM_STATE_CHANGED_FILTER:Landroid/content/IntentFilter;

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    :cond_0
    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/SingleBinary;)Landroid/app/AlertDialog;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    return-object v0
.end method

.method static synthetic access$002(Lcom/android/internal/telephony/SingleBinary;Landroid/app/AlertDialog;)Landroid/app/AlertDialog;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;
    .param p1, "x1"    # Landroid/app/AlertDialog;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    return-object p1
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/SingleBinary;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/SingleBinary;->rebootSystem()V

    return-void
.end method

.method static synthetic access$1000()Landroid/content/Context;
    .locals 1

    .prologue
    sget-object v0, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/android/internal/telephony/SingleBinary;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/SingleBinary;->checkFlexEnableStatus()V

    return-void
.end method

.method static synthetic access$1200(Lcom/android/internal/telephony/SingleBinary;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;

    .prologue
    iget v0, p0, Lcom/android/internal/telephony/SingleBinary;->mMncLength:I

    return v0
.end method

.method static synthetic access$1300(Lcom/android/internal/telephony/SingleBinary;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mImsi:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1400(Lcom/android/internal/telephony/SingleBinary;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1402(Lcom/android/internal/telephony/SingleBinary;Landroid/widget/TextView;)Landroid/widget/TextView;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;
    .param p1, "x1"    # Landroid/widget/TextView;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    return-object p1
.end method

.method static synthetic access$200()Z
    .locals 1

    .prologue
    sget-boolean v0, Lcom/android/internal/telephony/SingleBinary;->isLGHomedbDeleted:Z

    return v0
.end method

.method static synthetic access$202(Z)Z
    .locals 0
    .param p0, "x0"    # Z

    .prologue
    sput-boolean p0, Lcom/android/internal/telephony/SingleBinary;->isLGHomedbDeleted:Z

    return p0
.end method

.method static synthetic access$300()Z
    .locals 1

    .prologue
    sget-boolean v0, Lcom/android/internal/telephony/SingleBinary;->isBrowserdbDeleted:Z

    return v0
.end method

.method static synthetic access$302(Z)Z
    .locals 0
    .param p0, "x0"    # Z

    .prologue
    sput-boolean p0, Lcom/android/internal/telephony/SingleBinary;->isBrowserdbDeleted:Z

    return p0
.end method

.method static synthetic access$400()Z
    .locals 1

    .prologue
    sget-boolean v0, Lcom/android/internal/telephony/SingleBinary;->isTelephonydbDeleted:Z

    return v0
.end method

.method static synthetic access$402(Z)Z
    .locals 0
    .param p0, "x0"    # Z

    .prologue
    sput-boolean p0, Lcom/android/internal/telephony/SingleBinary;->isTelephonydbDeleted:Z

    return p0
.end method

.method static synthetic access$500(Lcom/android/internal/telephony/SingleBinary;)Ljava/lang/Runnable;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->runnable:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$600(Lcom/android/internal/telephony/SingleBinary;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->handler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$700(Lcom/android/internal/telephony/SingleBinary;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMChecked:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$702(Lcom/android/internal/telephony/SingleBinary;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMChecked:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$800(Lcom/android/internal/telephony/SingleBinary;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/SingleBinary;->setClientIDBySIM(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$900(Lcom/android/internal/telephony/SingleBinary;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/SingleBinary;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mEnableSBP:Ljava/lang/String;

    return-object v0
.end method

.method private checkFlexEnableStatus()V
    .locals 5

    .prologue
    const-string v3, "GSM"

    const-string v4, "[Flex] Check Flex Enable Status"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v3, "persist.service.flex.enable"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "flexModeEnable":Ljava/lang/String;
    const-string v3, "1"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    sget-object v3, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    if-eqz v3, :cond_0

    sget-object v3, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/SingleBinary;->displayFlexInfo(Landroid/content/Context;)V

    :goto_0
    return-void

    :cond_0
    const-string v3, "GSM"

    const-string v4, "[Flex] updateOriginalValues entered..."

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/android/internal/telephony/SingleBinary;->updateOriginalSIMValues()Ljava/lang/String;

    move-result-object v1

    .local v1, "openVals":Ljava/lang/String;
    invoke-direct {p0}, Lcom/android/internal/telephony/SingleBinary;->updateOriginalSBPValues()Ljava/lang/String;

    move-result-object v2

    .local v2, "sbpVals":Ljava/lang/String;
    const-string v3, "persist.radio.flex.orgVals"

    invoke-static {v3, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "persist.radio.flex.orgSBPs"

    invoke-static {v3, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static deleteDummyResource(Ljava/io/File;I)Z
    .locals 17
    .param p0, "path"    # Ljava/io/File;
    .param p1, "multiSubset"    # I

    .prologue
    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->exists()Z

    move-result v14

    if-nez v14, :cond_0

    const/4 v14, 0x0

    :goto_0
    return v14

    :cond_0
    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v6

    .local v6, "files":[Ljava/io/File;
    const-string v14, "ro.lge.capp_cupss.rootdir"

    const-string v15, "/cust"

    invoke-static {v14, v15}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .local v3, "custCurrentPath":Ljava/lang/String;
    const-string v4, "/cust"

    .local v4, "custDefaultPath":Ljava/lang/String;
    if-nez v6, :cond_1

    const-string v14, "GSM"

    const-string v15, "[LGE][SBP] No Files"

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v14, 0x0

    goto :goto_0

    :cond_1
    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_2

    const-string v14, "GSM"

    const-string v15, "[LGE][SBP] Skip to delete!"

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v14, 0x0

    goto :goto_0

    :cond_2
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v14

    add-int/lit8 v14, v14, 0x1

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v15

    invoke-virtual {v3, v14, v15}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    .local v10, "operatorPath":Ljava/lang/String;
    const-string v14, "/"

    invoke-virtual {v10, v14}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v12

    .local v12, "subCA":[Ljava/lang/String;
    const/4 v9, 0x0

    .local v9, "multiSubCA":I
    array-length v13, v12

    .local v13, "subCASize":I
    move/from16 v0, p1

    .local v0, "MultiSubDepth":I
    const/4 v11, 0x0

    .local v11, "protectMultiSub":I
    const/4 v14, 0x1

    const-string v15, "ro.build.sbp.ui"

    const/16 v16, 0x0

    invoke-static/range {v15 .. v16}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v15

    if-ne v14, v15, :cond_3

    const/4 v11, 0x1

    :cond_3
    const/4 v14, 0x1

    if-le v13, v14, :cond_5

    const/4 v2, 0x0

    .local v2, "count":I
    :goto_1
    if-ge v2, v13, :cond_4

    const-string v14, "GSM"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[LGE][SBP] SUBCA_"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, " :"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    aget-object v16, v12, v2

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_4
    const/4 v9, 0x1

    .end local v2    # "count":I
    :cond_5
    move-object v1, v6

    .local v1, "arr$":[Ljava/io/File;
    array-length v8, v1

    .local v8, "len$":I
    const/4 v7, 0x0

    .local v7, "i$":I
    :goto_2
    if-ge v7, v8, :cond_f

    aget-object v5, v1, v7

    .local v5, "f":Ljava/io/File;
    const/4 v14, 0x1

    if-ne v9, v14, :cond_b

    if-nez v11, :cond_b

    invoke-virtual {v5}, Ljava/io/File;->isDirectory()Z

    move-result v14

    if-eqz v14, :cond_9

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v14

    aget-object v15, v12, v0

    invoke-virtual {v14, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-nez v14, :cond_8

    const-string v14, "GSM"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[LGE][SBP] Directory: "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v5}, Ljava/io/File;->delete()Z

    move-result v14

    if-eqz v14, :cond_7

    const-string v14, "GSM"

    const-string v15, "[LGE][SBP] Delete Folder"

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_6
    :goto_3
    add-int/lit8 v7, v7, 0x1

    goto :goto_2

    :cond_7
    const/4 v14, 0x0

    invoke-static {v5, v14}, Lcom/android/internal/telephony/SingleBinary;->deleteDummyResource(Ljava/io/File;I)Z

    goto :goto_3

    :cond_8
    add-int/lit8 v14, v13, -0x1

    if-ge v0, v14, :cond_6

    add-int/lit8 v0, v0, 0x1

    invoke-static {v5, v0}, Lcom/android/internal/telephony/SingleBinary;->deleteDummyResource(Ljava/io/File;I)Z

    goto :goto_3

    :cond_9
    invoke-virtual {v5}, Ljava/io/File;->isFile()Z

    move-result v14

    if-eqz v14, :cond_a

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v14

    const-string v15, "userdata.ubid"

    invoke-virtual {v14, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-nez v14, :cond_a

    invoke-virtual {v5}, Ljava/io/File;->delete()Z

    move-result v14

    if-eqz v14, :cond_6

    const-string v14, "GSM"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[LGE][SBP] Delete File: "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_3

    :cond_a
    const-string v14, "GSM"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[LGE][SBP] Protect to delete: "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_3

    :cond_b
    invoke-virtual {v5}, Ljava/io/File;->isDirectory()Z

    move-result v14

    if-eqz v14, :cond_d

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v14

    const/4 v15, 0x0

    aget-object v15, v12, v15

    invoke-virtual {v14, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-nez v14, :cond_d

    const-string v14, "GSM"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[LGE][SBP] Directory: "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v5}, Ljava/io/File;->delete()Z

    move-result v14

    if-eqz v14, :cond_c

    const-string v14, "GSM"

    const-string v15, "[LGE][SBP] Delete Folder"

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_3

    :cond_c
    const/4 v14, 0x0

    invoke-static {v5, v14}, Lcom/android/internal/telephony/SingleBinary;->deleteDummyResource(Ljava/io/File;I)Z

    goto/16 :goto_3

    :cond_d
    invoke-virtual {v5}, Ljava/io/File;->isFile()Z

    move-result v14

    if-eqz v14, :cond_e

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v14

    const-string v15, "userdata.ubid"

    invoke-virtual {v14, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    if-nez v14, :cond_e

    invoke-virtual {v5}, Ljava/io/File;->delete()Z

    move-result v14

    if-eqz v14, :cond_6

    const-string v14, "GSM"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[LGE][SBP] Delete File: "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_3

    :cond_e
    const-string v14, "GSM"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "[LGE][SBP] Protect to delete: "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_3

    .end local v5    # "f":Ljava/io/File;
    :cond_f
    const/4 v14, 0x1

    goto/16 :goto_0
.end method

.method public static deleteEmptyFolder(Ljava/io/File;)V
    .locals 8
    .param p0, "path"    # Ljava/io/File;

    .prologue
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v5

    if-nez v5, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v2

    .local v2, "files":[Ljava/io/File;
    if-nez v2, :cond_2

    const-string v5, "GSM"

    const-string v6, "[LGE][SBP] No Empty folder"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_2
    move-object v0, v2

    .local v0, "arr$":[Ljava/io/File;
    array-length v4, v0

    .local v4, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_1
    if-ge v3, v4, :cond_0

    aget-object v1, v0, v3

    .local v1, "f":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    move-result v5

    if-eqz v5, :cond_4

    const-string v5, "GSM"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[LGE][SBP] Delete empty folder: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_3
    :goto_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_4
    invoke-static {v1}, Lcom/android/internal/telephony/SingleBinary;->deleteEmptyFolder(Ljava/io/File;)V

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    goto :goto_2
.end method

.method private displayFlexInfo(Landroid/content/Context;)V
    .locals 23
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const-string v2, "GSM"

    const-string v3, "[Flex] Display Flex Setting Info"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v2, "phone"

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/telephony/TelephonyManager;

    .local v7, "mTelephony":Landroid/telephony/TelephonyManager;
    const-string v2, "ro.build.target_operator"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v21

    .local v21, "targetOperator":Ljava/lang/String;
    const-string v2, "ro.build.target_country"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v20

    .local v20, "targetCountry":Ljava/lang/String;
    invoke-virtual {v7}, Landroid/telephony/TelephonyManager;->getSimSerialNumber()Ljava/lang/String;

    move-result-object v14

    .local v14, "szIccid":Ljava/lang/String;
    invoke-virtual {v7}, Landroid/telephony/TelephonyManager;->getSubscriberId()Ljava/lang/String;

    move-result-object v15

    .local v15, "szImsi":Ljava/lang/String;
    invoke-virtual {v7}, Landroid/telephony/TelephonyManager;->getSimOperatorName()Ljava/lang/String;

    move-result-object v19

    .local v19, "szSpn":Ljava/lang/String;
    invoke-virtual {v7}, Landroid/telephony/TelephonyManager;->getSimOperator()Ljava/lang/String;

    move-result-object v16

    .local v16, "szMccMnc":Ljava/lang/String;
    invoke-virtual {v7}, Landroid/telephony/TelephonyManager;->getGroupIdLevel1()Ljava/lang/String;

    move-result-object v13

    .local v13, "szGid1":Ljava/lang/String;
    const-string v2, "ro.lge.capp_cupss.rootdir"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .local v9, "szCustPath":Ljava/lang/String;
    const-string v2, "persist.sys.mccmnc-list"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17

    .local v17, "szNTCodeMccMnc":Ljava/lang/String;
    const-string v2, "persist.sys.subset-list"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v18

    .local v18, "szNTCodeSubset":Ljava/lang/String;
    const-string v2, "persist.sys.iccid"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .local v11, "szFastIccid":Ljava/lang/String;
    const-string v2, "persist.sys.iccid-mcc"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .local v12, "szFastMcc":Ljava/lang/String;
    const-string v2, "persist.service.flex.country"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .local v8, "szCountry":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[BUILD TARGET Info]\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, v21

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "-"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, v20

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "[OPEN API Info]\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "SIM ICCID : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "SIM IMSI : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "SIM MCC-MNC : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, v16

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "SIM SPN : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, v19

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "SIM GID1 : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "SIM (*)Country : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "[SBP Info]\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "CUPSS : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "NTCODE MCC-MNC : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, v17

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "NTCODE SUBSET : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, v18

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "ICCID : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "ICCID-MCC : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .local v10, "szDisplayInfo":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    if-nez v2, :cond_1

    new-instance v2, Landroid/widget/TextView;

    move-object/from16 v0, p1

    invoke-direct {v2, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    :goto_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    if-eqz v2, :cond_0

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    invoke-virtual {v2, v10}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    const v3, -0xff0001

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    const/high16 v3, -0x1000000

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setBackgroundColor(I)V

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    new-instance v3, Lcom/android/internal/telephony/SingleBinary$6;

    move-object/from16 v0, p0

    invoke-direct {v3, v0}, Lcom/android/internal/telephony/SingleBinary$6;-><init>(Lcom/android/internal/telephony/SingleBinary;)V

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    new-instance v3, Lcom/android/internal/telephony/SingleBinary$7;

    move-object/from16 v0, p0

    invoke-direct {v3, v0}, Lcom/android/internal/telephony/SingleBinary$7;-><init>(Lcom/android/internal/telephony/SingleBinary;)V

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    new-instance v1, Landroid/view/WindowManager$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x1

    const/16 v4, 0x7d8

    const v5, 0x40020

    const/4 v6, -0x3

    invoke-direct/range {v1 .. v6}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    .local v1, "params":Landroid/view/WindowManager$LayoutParams;
    const v2, 0x800033

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I

    const-string v2, "Flex Validatation Info"

    invoke-virtual {v1, v2}, Landroid/view/WindowManager$LayoutParams;->setTitle(Ljava/lang/CharSequence;)V

    const-string v2, "window"

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v22

    check-cast v22, Landroid/view/WindowManager;

    .local v22, "wm":Landroid/view/WindowManager;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    move-object/from16 v0, v22

    invoke-interface {v0, v2, v1}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .end local v1    # "params":Landroid/view/WindowManager$LayoutParams;
    .end local v22    # "wm":Landroid/view/WindowManager;
    :cond_0
    return-void

    :cond_1
    sget-object v2, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v0, v2, v3}, Lcom/android/internal/telephony/SingleBinary;->removeFlexView(Landroid/content/Context;Landroid/widget/TextView;)V

    new-instance v2, Landroid/widget/TextView;

    move-object/from16 v0, p1

    invoke-direct {v2, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/android/internal/telephony/SingleBinary;->mFlexText:Landroid/widget/TextView;

    goto :goto_0
.end method

.method public static getInstance(Landroid/content/Context;)Lcom/android/internal/telephony/SingleBinary;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const-class v1, Lcom/android/internal/telephony/SingleBinary;

    monitor-enter v1

    if-eqz p0, :cond_0

    :try_start_0
    sput-object p0, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    :cond_0
    sget-object v0, Lcom/android/internal/telephony/SingleBinary;->mSingleBinary:Lcom/android/internal/telephony/SingleBinary;

    if-nez v0, :cond_1

    new-instance v0, Lcom/android/internal/telephony/SingleBinary;

    invoke-direct {v0}, Lcom/android/internal/telephony/SingleBinary;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/SingleBinary;->mSingleBinary:Lcom/android/internal/telephony/SingleBinary;

    :cond_1
    sget-object v0, Lcom/android/internal/telephony/SingleBinary;->mSingleBinary:Lcom/android/internal/telephony/SingleBinary;

    monitor-exit v1

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private imsiMatches(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 5
    .param p1, "imsiDB"    # Ljava/lang/String;
    .param p2, "imsiSIM"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    .local v2, "len":I
    if-gtz v2, :cond_1

    :cond_0
    :goto_0
    return v3

    :cond_1
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v4

    if-gt v2, v4, :cond_0

    const/4 v1, 0x0

    .local v1, "idx":I
    :goto_1
    if-ge v1, v2, :cond_3

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .local v0, "c":C
    const/16 v4, 0x78

    if-eq v0, v4, :cond_2

    const/16 v4, 0x58

    if-eq v0, v4, :cond_2

    invoke-virtual {p2, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-ne v0, v4, :cond_0

    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .end local v0    # "c":C
    :cond_3
    const/4 v3, 0x1

    goto :goto_0
.end method

.method private mvnoMatches(Lcom/android/internal/telephony/ClientIdItem;Lcom/android/internal/telephony/ClientIdItem;)Z
    .locals 10
    .param p1, "simItem"    # Lcom/android/internal/telephony/ClientIdItem;
    .param p2, "xmlItem"    # Lcom/android/internal/telephony/ClientIdItem;

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x1

    invoke-virtual {p1}, Lcom/android/internal/telephony/ClientIdItem;->getMvno_type()Ljava/lang/String;

    move-result-object v3

    .local v3, "mvno_type":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/android/internal/telephony/ClientIdItem;->getMvno_match_data()Ljava/lang/String;

    move-result-object v4

    .local v4, "sim_mvno_match_data":Ljava/lang/String;
    invoke-virtual {p2}, Lcom/android/internal/telephony/ClientIdItem;->getMvno_match_data()Ljava/lang/String;

    move-result-object v5

    .local v5, "xml_mvno_match_data":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/android/internal/telephony/ClientIdItem;->getMvno_type()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p2}, Lcom/android/internal/telephony/ClientIdItem;->getMvno_type()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_3

    const-string v8, "spn"

    invoke-virtual {v3, v8}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_0

    if-eqz v4, :cond_4

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    const-string v7, "GSM"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE][SBP] Match [SIM spn]:["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "] == [XML spn]:["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p2}, Lcom/android/internal/telephony/ClientIdItem;->getMvno_match_data()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "]"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v6

    :cond_0
    const-string v8, "imsi"

    invoke-virtual {v3, v8}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_1

    move-object v1, v4

    .local v1, "imsiSIM":Ljava/lang/String;
    if-eqz v1, :cond_4

    invoke-direct {p0, v5, v1}, Lcom/android/internal/telephony/SingleBinary;->imsiMatches(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    const-string v7, "GSM"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE][SBP] Match [SIM imsi]:["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "] == [XML imsi]:["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p2}, Lcom/android/internal/telephony/ClientIdItem;->getMvno_match_data()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "]"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v1    # "imsiSIM":Ljava/lang/String;
    :cond_1
    const-string v8, "gid"

    invoke-virtual {v3, v8}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_2

    move-object v0, v4

    .local v0, "gid1":Ljava/lang/String;
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v2

    .local v2, "mvno_match_data_length":I
    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v8

    if-lt v8, v2, :cond_4

    invoke-virtual {v0, v7, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    const-string v7, "GSM"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE][SBP] Match [SIM gid]:["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "] == [XML gid]:["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p2}, Lcom/android/internal/telephony/ClientIdItem;->getMvno_match_data()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "]"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .end local v0    # "gid1":Ljava/lang/String;
    .end local v2    # "mvno_match_data_length":I
    :cond_2
    const-string v8, ""

    if-ne v4, v8, :cond_4

    const-string v8, ""

    if-ne v5, v8, :cond_4

    const-string v7, "GSM"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE][SBP] Match [SIM]:["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "] == [XML]:["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "]"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_3
    move v6, v7

    goto/16 :goto_0

    :cond_4
    move v6, v7

    goto/16 :goto_0
.end method

.method private notRevenueShareClientId()V
    .locals 2

    .prologue
    const-string v0, "ro.com.google.clientidbase.am"

    const-string v1, "android-lge"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ro.com.google.clientidbase.gmm"

    const-string v1, "android-lge"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ro.com.google.clientidbase.ms"

    const-string v1, "android-lge"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ro.com.google.clientidbase.yt"

    const-string v1, "android-lge"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ro.com.google.clientidbase"

    const-string v1, "android-lge"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private nullChange(Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p1, "str"    # Ljava/lang/String;

    .prologue
    if-nez p1, :cond_0

    const-string p1, ""

    .end local p1    # "str":Ljava/lang/String;
    :cond_0
    return-object p1
.end method

.method private rebootSystem()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    iget-object v1, p0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    invoke-virtual {v1}, Landroid/app/AlertDialog;->dismiss()V

    :cond_0
    sput-boolean v2, Lcom/android/internal/telephony/SingleBinary;->isTelephonydbDeleted:Z

    sput-boolean v2, Lcom/android/internal/telephony/SingleBinary;->isLGHomedbDeleted:Z

    sput-boolean v2, Lcom/android/internal/telephony/SingleBinary;->isBrowserdbDeleted:Z

    sget-object v1, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    const-string v2, "power"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/PowerManager;

    .local v0, "pm":Landroid/os/PowerManager;
    const-string v1, "CUST Changed"

    invoke-virtual {v0, v1}, Landroid/os/PowerManager;->reboot(Ljava/lang/String;)V

    return-void
.end method

.method private removeFlexView(Landroid/content/Context;Landroid/widget/TextView;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "tv"    # Landroid/widget/TextView;

    .prologue
    if-eqz p1, :cond_0

    const-string v0, "window"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0, p2}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    const/4 p2, 0x0

    :cond_0
    return-void
.end method

.method private revenueShareClientID()V
    .locals 2

    .prologue
    const-string v0, "com.android.chrome"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/SingleBinary;->setPreferredBrowser(Ljava/lang/String;)V

    const-string v0, "ro.com.google.clientidbase.am"

    const-string v1, "android-om-lge"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ro.com.google.clientidbase.gmm"

    const-string v1, "android-om-lge"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ro.com.google.clientidbase.ms"

    const-string v1, "android-om-lge"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ro.com.google.clientidbase.yt"

    const-string v1, "android-om-lge"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ro.com.google.clientidbase"

    const-string v1, "android-om-lge"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private setClientIDBySIM(Ljava/lang/String;)V
    .locals 33
    .param p1, "mccmnc"    # Ljava/lang/String;

    .prologue
    const/4 v11, 0x0

    .local v11, "factory":Lorg/xmlpull/v1/XmlPullParserFactory;
    const/16 v29, 0x0

    .local v29, "xpp":Lorg/xmlpull/v1/XmlPullParser;
    const/4 v4, 0x0

    .local v4, "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    const/16 v22, 0x0

    .local v22, "reader":Ljava/io/BufferedReader;
    const/4 v10, 0x0

    .local v10, "eventType":I
    :try_start_0
    new-instance v23, Ljava/io/BufferedReader;

    new-instance v30, Ljava/io/FileReader;

    const-string v31, "/cust/client_id.xml"

    invoke-direct/range {v30 .. v31}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    move-object/from16 v0, v23

    move-object/from16 v1, v30

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v22    # "reader":Ljava/io/BufferedReader;
    .local v23, "reader":Ljava/io/BufferedReader;
    const/4 v10, 0x0

    move-object/from16 v22, v23

    .end local v23    # "reader":Ljava/io/BufferedReader;
    .restart local v22    # "reader":Ljava/io/BufferedReader;
    :goto_0
    :try_start_1
    invoke-static {}, Lorg/xmlpull/v1/XmlPullParserFactory;->newInstance()Lorg/xmlpull/v1/XmlPullParserFactory;

    move-result-object v11

    invoke-virtual {v11}, Lorg/xmlpull/v1/XmlPullParserFactory;->newPullParser()Lorg/xmlpull/v1/XmlPullParser;

    move-result-object v29

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V
    :try_end_1
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_1 .. :try_end_1} :catch_4
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_3

    .end local v4    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .local v5, "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    :try_start_2
    move-object/from16 v0, v29

    move-object/from16 v1, v22

    invoke-interface {v0, v1}, Lorg/xmlpull/v1/XmlPullParser;->setInput(Ljava/io/Reader;)V

    invoke-interface/range {v29 .. v29}, Lorg/xmlpull/v1/XmlPullParser;->getEventType()I

    move-result v10

    const/4 v15, 0x0

    .local v15, "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    const/4 v6, 0x0

    .local v6, "clientid":Lcom/android/internal/telephony/ClientIdInfo;
    const/16 v24, 0x0

    .local v24, "simBasedParsing":Z
    :goto_1
    const/16 v30, 0x1

    move/from16 v0, v30

    if-eq v10, v0, :cond_a

    invoke-interface/range {v29 .. v29}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v21

    .local v21, "name":Ljava/lang/String;
    packed-switch v10, :pswitch_data_0

    :cond_0
    :goto_2
    invoke-interface/range {v29 .. v29}, Lorg/xmlpull/v1/XmlPullParser;->next()I
    :try_end_2
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    move-result v10

    goto :goto_1

    .end local v5    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .end local v6    # "clientid":Lcom/android/internal/telephony/ClientIdInfo;
    .end local v15    # "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .end local v21    # "name":Ljava/lang/String;
    .end local v24    # "simBasedParsing":Z
    .restart local v4    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    :catch_0
    move-exception v7

    .local v7, "e":Ljava/io/FileNotFoundException;
    const-string v30, "GSM"

    new-instance v31, Ljava/lang/StringBuilder;

    invoke-direct/range {v31 .. v31}, Ljava/lang/StringBuilder;-><init>()V

    const-string v32, "[LGE][SBP] FileNotFoundException Exception"

    invoke-virtual/range {v31 .. v32}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    invoke-virtual {v7}, Ljava/io/FileNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object v32

    invoke-virtual/range {v31 .. v32}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    invoke-virtual/range {v31 .. v31}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v31

    invoke-static/range {v30 .. v31}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v4    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .end local v7    # "e":Ljava/io/FileNotFoundException;
    .restart local v5    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .restart local v6    # "clientid":Lcom/android/internal/telephony/ClientIdInfo;
    .restart local v15    # "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .restart local v21    # "name":Ljava/lang/String;
    .restart local v24    # "simBasedParsing":Z
    :pswitch_0
    if-eqz v21, :cond_1

    :try_start_3
    const-string v30, "clientid_sim"

    move-object/from16 v0, v21

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v30

    if-eqz v30, :cond_1

    new-instance v15, Ljava/util/ArrayList;

    .end local v15    # "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    invoke-direct {v15}, Ljava/util/ArrayList;-><init>()V

    .restart local v15    # "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    new-instance v6, Lcom/android/internal/telephony/ClientIdInfo;

    .end local v6    # "clientid":Lcom/android/internal/telephony/ClientIdInfo;
    invoke-direct {v6}, Lcom/android/internal/telephony/ClientIdInfo;-><init>()V

    .restart local v6    # "clientid":Lcom/android/internal/telephony/ClientIdInfo;
    const/16 v24, 0x1

    goto :goto_2

    :cond_1
    if-eqz v24, :cond_8

    if-eqz v21, :cond_8

    const-string v30, "info"

    move-object/from16 v0, v21

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v30

    if-eqz v30, :cond_8

    const/16 v30, 0x0

    const-string v31, "mcc"

    invoke-interface/range {v29 .. v31}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->nullChange(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17

    .local v17, "mcc":Ljava/lang/String;
    const/16 v30, 0x0

    const-string v31, "mnc"

    invoke-interface/range {v29 .. v31}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->nullChange(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v18

    .local v18, "mnc":Ljava/lang/String;
    const-string v30, ""

    move-object/from16 v0, v17

    move-object/from16 v1, v30

    if-ne v0, v1, :cond_7

    const-string v30, ""

    move-object/from16 v0, v18

    move-object/from16 v1, v30

    if-ne v0, v1, :cond_7

    const-string v3, ""

    .local v3, "MergedMccMnc":Ljava/lang/String;
    :goto_3
    const/16 v30, 0x0

    const-string v31, "mvno_type"

    invoke-interface/range {v29 .. v31}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->nullChange(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v20

    .local v20, "mvno_type":Ljava/lang/String;
    const/16 v30, 0x0

    const-string v31, "mvno_match_data"

    invoke-interface/range {v29 .. v31}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->nullChange(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v19

    .local v19, "mvno_match_data":Ljava/lang/String;
    new-instance v14, Lcom/android/internal/telephony/ClientIdItem;

    const/16 v30, 0x0

    move-object/from16 v0, v20

    move-object/from16 v1, v19

    move-object/from16 v2, v30

    invoke-direct {v14, v3, v0, v1, v2}, Lcom/android/internal/telephony/ClientIdItem;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/android/internal/telephony/ClientIdInfo;)V

    .local v14, "info":Lcom/android/internal/telephony/ClientIdItem;
    invoke-virtual {v15, v14}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_3
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    goto/16 :goto_2

    .end local v3    # "MergedMccMnc":Ljava/lang/String;
    .end local v6    # "clientid":Lcom/android/internal/telephony/ClientIdInfo;
    .end local v14    # "info":Lcom/android/internal/telephony/ClientIdItem;
    .end local v15    # "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .end local v17    # "mcc":Ljava/lang/String;
    .end local v18    # "mnc":Ljava/lang/String;
    .end local v19    # "mvno_match_data":Ljava/lang/String;
    .end local v20    # "mvno_type":Ljava/lang/String;
    .end local v21    # "name":Ljava/lang/String;
    .end local v24    # "simBasedParsing":Z
    :catch_1
    move-exception v8

    move-object v4, v5

    .end local v5    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .restart local v4    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .local v8, "e1":Lorg/xmlpull/v1/XmlPullParserException;
    :goto_4
    const-string v30, "GSM"

    new-instance v31, Ljava/lang/StringBuilder;

    invoke-direct/range {v31 .. v31}, Ljava/lang/StringBuilder;-><init>()V

    const-string v32, "[LGE][SBP] Main Parser Exception"

    invoke-virtual/range {v31 .. v32}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    invoke-virtual {v8}, Lorg/xmlpull/v1/XmlPullParserException;->getMessage()Ljava/lang/String;

    move-result-object v32

    invoke-virtual/range {v31 .. v32}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    invoke-virtual/range {v31 .. v31}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v31

    invoke-static/range {v30 .. v31}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v8    # "e1":Lorg/xmlpull/v1/XmlPullParserException;
    :goto_5
    const-string v30, "gsm.apn.sim.operator.mvno.type"

    const-string v31, ""

    invoke-static/range {v30 .. v31}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v27

    .local v27, "sim_mvno_type":Ljava/lang/String;
    const-string v30, "gsm.apn.sim.operator.mvno.data"

    const-string v31, ""

    invoke-static/range {v30 .. v31}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v26

    .local v26, "sim_mvno_match_data":Ljava/lang/String;
    const-string v30, "GSM"

    new-instance v31, Ljava/lang/StringBuilder;

    invoke-direct/range {v31 .. v31}, Ljava/lang/StringBuilder;-><init>()V

    const-string v32, "[LGE][SBP] Main Parser MCCMNC : "

    invoke-virtual/range {v31 .. v32}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    move-object/from16 v0, v31

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    invoke-virtual/range {v31 .. v31}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v31

    invoke-static/range {v30 .. v31}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v30, "GSM"

    new-instance v31, Ljava/lang/StringBuilder;

    invoke-direct/range {v31 .. v31}, Ljava/lang/StringBuilder;-><init>()V

    const-string v32, "[LGE][SBP] Main Parser MVNO_TYPE : "

    invoke-virtual/range {v31 .. v32}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    move-object/from16 v0, v31

    move-object/from16 v1, v27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    invoke-virtual/range {v31 .. v31}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v31

    invoke-static/range {v30 .. v31}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v30, "GSM"

    new-instance v31, Ljava/lang/StringBuilder;

    invoke-direct/range {v31 .. v31}, Ljava/lang/StringBuilder;-><init>()V

    const-string v32, "[LGE][SBP] Main Parser MVNO_DATA : "

    invoke-virtual/range {v31 .. v32}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    move-object/from16 v0, v31

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    invoke-virtual/range {v31 .. v31}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v31

    invoke-static/range {v30 .. v31}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v25, Lcom/android/internal/telephony/ClientIdItem;

    invoke-direct/range {v25 .. v25}, Lcom/android/internal/telephony/ClientIdItem;-><init>()V

    .local v25, "sim_item":Lcom/android/internal/telephony/ClientIdItem;
    move-object/from16 v0, v25

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/ClientIdItem;->setMccmnc(Ljava/lang/String;)V

    move-object/from16 v0, p0

    move-object/from16 v1, v27

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->nullChange(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, v25

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/ClientIdItem;->setMvno_type(Ljava/lang/String;)V

    move-object/from16 v0, p0

    move-object/from16 v1, v26

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->nullChange(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, v25

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/ClientIdItem;->setMvno_match_data(Ljava/lang/String;)V

    const-string v30, ""

    move-object/from16 v0, v27

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v30

    if-nez v30, :cond_2

    const-string v30, ""

    move-object/from16 v0, v26

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v30

    if-eqz v30, :cond_3

    :cond_2
    const-string v30, "GSM"

    const-string v31, "[LGE][SBP] MVNO_TYPE or DATA is NULL!"

    invoke-static/range {v30 .. v31}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_3
    const/16 v16, 0x0

    .local v16, "matched":Z
    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v13

    .local v13, "i$":Ljava/util/Iterator;
    :cond_4
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v30

    if-eqz v30, :cond_5

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v28

    check-cast v28, Lcom/android/internal/telephony/ClientIdItem;

    .local v28, "xmlItem":Lcom/android/internal/telephony/ClientIdItem;
    invoke-virtual/range {v25 .. v25}, Lcom/android/internal/telephony/ClientIdItem;->getMccmnc()Ljava/lang/String;

    move-result-object v30

    invoke-virtual/range {v28 .. v28}, Lcom/android/internal/telephony/ClientIdItem;->getMccmnc()Ljava/lang/String;

    move-result-object v31

    invoke-virtual/range {v30 .. v31}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v30

    if-eqz v30, :cond_4

    move-object/from16 v0, p0

    move-object/from16 v1, v25

    move-object/from16 v2, v28

    invoke-direct {v0, v1, v2}, Lcom/android/internal/telephony/SingleBinary;->mvnoMatches(Lcom/android/internal/telephony/ClientIdItem;Lcom/android/internal/telephony/ClientIdItem;)Z

    move-result v30

    if-eqz v30, :cond_4

    invoke-direct/range {p0 .. p0}, Lcom/android/internal/telephony/SingleBinary;->notRevenueShareClientId()V

    const-string v30, "persist.radio.sim-fixed"

    const-string v31, "not_rev_share"

    invoke-static/range {v30 .. v31}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v30, "GSM"

    const-string v31, "[LGE][SBP] Set as android-lge. Client ID fixed"

    invoke-static/range {v30 .. v31}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v16, 0x1

    .end local v28    # "xmlItem":Lcom/android/internal/telephony/ClientIdItem;
    :cond_5
    if-nez v16, :cond_6

    invoke-direct/range {p0 .. p0}, Lcom/android/internal/telephony/SingleBinary;->revenueShareClientID()V

    const-string v30, "persist.radio.sim-fixed"

    const-string v31, "rev_share"

    invoke-static/range {v30 .. v31}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v30, "GSM"

    const-string v31, "[LGE][SBP] Set as android-om-lge. Client-ID fixed"

    invoke-static/range {v30 .. v31}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_6
    const/4 v12, 0x0

    .local v12, "i":I
    :goto_6
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v30

    move/from16 v0, v30

    if-ge v12, v0, :cond_b

    invoke-virtual {v4, v12}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v30

    check-cast v30, Lcom/android/internal/telephony/ClientIdItem;

    const/16 v31, 0x0

    invoke-virtual/range {v30 .. v31}, Lcom/android/internal/telephony/ClientIdItem;->setClientid(Lcom/android/internal/telephony/ClientIdInfo;)V

    invoke-virtual {v4, v12}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    add-int/lit8 v12, v12, 0x1

    goto :goto_6

    .end local v4    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .end local v12    # "i":I
    .end local v13    # "i$":Ljava/util/Iterator;
    .end local v16    # "matched":Z
    .end local v25    # "sim_item":Lcom/android/internal/telephony/ClientIdItem;
    .end local v26    # "sim_mvno_match_data":Ljava/lang/String;
    .end local v27    # "sim_mvno_type":Ljava/lang/String;
    .restart local v5    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .restart local v6    # "clientid":Lcom/android/internal/telephony/ClientIdInfo;
    .restart local v15    # "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .restart local v17    # "mcc":Ljava/lang/String;
    .restart local v18    # "mnc":Ljava/lang/String;
    .restart local v21    # "name":Ljava/lang/String;
    .restart local v24    # "simBasedParsing":Z
    :cond_7
    :try_start_4
    new-instance v30, Ljava/lang/StringBuilder;

    invoke-direct/range {v30 .. v30}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v30

    move-object/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v30

    move-object/from16 v0, v30

    move-object/from16 v1, v18

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v30

    invoke-virtual/range {v30 .. v30}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto/16 :goto_3

    .end local v17    # "mcc":Ljava/lang/String;
    .end local v18    # "mnc":Ljava/lang/String;
    :cond_8
    if-eqz v24, :cond_0

    if-eqz v21, :cond_0

    const-string v30, "prop"

    move-object/from16 v0, v21

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v30

    if-eqz v30, :cond_0

    const/16 v30, 0x0

    const-string v31, "clientidbase"

    invoke-interface/range {v29 .. v31}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->nullChange(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, v30

    invoke-virtual {v6, v0}, Lcom/android/internal/telephony/ClientIdInfo;->setClientidbase(Ljava/lang/String;)V

    const/16 v30, 0x0

    const-string v31, "clientidbase_ms"

    invoke-interface/range {v29 .. v31}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->nullChange(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, v30

    invoke-virtual {v6, v0}, Lcom/android/internal/telephony/ClientIdInfo;->setClientidbase_ms(Ljava/lang/String;)V

    const/16 v30, 0x0

    const-string v31, "clientidbase_am"

    invoke-interface/range {v29 .. v31}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->nullChange(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, v30

    invoke-virtual {v6, v0}, Lcom/android/internal/telephony/ClientIdInfo;->setClientidbase_am(Ljava/lang/String;)V

    const/16 v30, 0x0

    const-string v31, "clientidbase_gmm"

    invoke-interface/range {v29 .. v31}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->nullChange(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, v30

    invoke-virtual {v6, v0}, Lcom/android/internal/telephony/ClientIdInfo;->setClientidbase_gmm(Ljava/lang/String;)V

    const/16 v30, 0x0

    const-string v31, "clientidbase_yt"

    invoke-interface/range {v29 .. v31}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->nullChange(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v30

    move-object/from16 v0, v30

    invoke-virtual {v6, v0}, Lcom/android/internal/telephony/ClientIdInfo;->setClientidbase_yt(Ljava/lang/String;)V
    :try_end_4
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2

    goto/16 :goto_2

    .end local v6    # "clientid":Lcom/android/internal/telephony/ClientIdInfo;
    .end local v15    # "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .end local v21    # "name":Ljava/lang/String;
    .end local v24    # "simBasedParsing":Z
    :catch_2
    move-exception v9

    move-object v4, v5

    .end local v5    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .restart local v4    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .local v9, "e2":Ljava/lang/Exception;
    :goto_7
    const-string v30, "GSM"

    new-instance v31, Ljava/lang/StringBuilder;

    invoke-direct/range {v31 .. v31}, Ljava/lang/StringBuilder;-><init>()V

    const-string v32, "[LGE][SBP] Main Parser Exception"

    invoke-virtual/range {v31 .. v32}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    invoke-virtual {v9}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v32

    invoke-virtual/range {v31 .. v32}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v31

    invoke-virtual/range {v31 .. v31}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v31

    invoke-static/range {v30 .. v31}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_5

    .end local v4    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .end local v9    # "e2":Ljava/lang/Exception;
    .restart local v5    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .restart local v6    # "clientid":Lcom/android/internal/telephony/ClientIdInfo;
    .restart local v15    # "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .restart local v21    # "name":Ljava/lang/String;
    .restart local v24    # "simBasedParsing":Z
    :pswitch_1
    if-eqz v21, :cond_0

    :try_start_5
    const-string v30, "clientid_sim"

    move-object/from16 v0, v21

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v30

    if-eqz v30, :cond_0

    invoke-virtual {v15}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v13

    .restart local v13    # "i$":Ljava/util/Iterator;
    :goto_8
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v30

    if-eqz v30, :cond_9

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Lcom/android/internal/telephony/ClientIdItem;

    .restart local v14    # "info":Lcom/android/internal/telephony/ClientIdItem;
    invoke-virtual {v14, v6}, Lcom/android/internal/telephony/ClientIdItem;->setClientid(Lcom/android/internal/telephony/ClientIdInfo;)V

    invoke-virtual {v5, v14}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_5
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_8

    .end local v14    # "info":Lcom/android/internal/telephony/ClientIdItem;
    :cond_9
    const/16 v24, 0x0

    goto/16 :goto_2

    .end local v13    # "i$":Ljava/util/Iterator;
    .end local v21    # "name":Ljava/lang/String;
    :cond_a
    move-object v4, v5

    .end local v5    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .restart local v4    # "clientIdItemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    goto/16 :goto_5

    .end local v6    # "clientid":Lcom/android/internal/telephony/ClientIdInfo;
    .end local v15    # "list":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/ClientIdItem;>;"
    .end local v24    # "simBasedParsing":Z
    .restart local v12    # "i":I
    .restart local v13    # "i$":Ljava/util/Iterator;
    .restart local v16    # "matched":Z
    .restart local v25    # "sim_item":Lcom/android/internal/telephony/ClientIdItem;
    .restart local v26    # "sim_mvno_match_data":Ljava/lang/String;
    .restart local v27    # "sim_mvno_type":Ljava/lang/String;
    :cond_b
    const/4 v4, 0x0

    return-void

    .end local v12    # "i":I
    .end local v13    # "i$":Ljava/util/Iterator;
    .end local v16    # "matched":Z
    .end local v25    # "sim_item":Lcom/android/internal/telephony/ClientIdItem;
    .end local v26    # "sim_mvno_match_data":Ljava/lang/String;
    .end local v27    # "sim_mvno_type":Ljava/lang/String;
    :catch_3
    move-exception v9

    goto :goto_7

    :catch_4
    move-exception v8

    goto/16 :goto_4

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private setPreferredBrowser(Ljava/lang/String;)V
    .locals 14
    .param p1, "strDefaultBrowser"    # Ljava/lang/String;

    .prologue
    new-instance v10, Landroid/content/Intent;

    const-string v11, "android.intent.action.VIEW"

    const-string v12, "http://www.lge.com"

    invoke-static {v12}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v12

    invoke-direct {v10, v11, v12}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .local v10, "urlIntent":Landroid/content/Intent;
    sget-object v11, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    invoke-virtual {v11}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v5

    .local v5, "mPackageManager":Landroid/content/pm/PackageManager;
    const v11, 0x10040

    invoke-virtual {v5, v10, v11}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v8

    .local v8, "rList":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    if-nez v8, :cond_0

    const-string v11, "GSM"

    const-string v12, "setPreferredBrowser() rList is NULL error!!"

    invoke-static {v11, v12}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    invoke-interface {v8}, Ljava/util/List;->size()I

    move-result v4

    .local v4, "iSize":I
    const/4 v11, 0x2

    if-ge v4, v11, :cond_1

    const-string v11, "GSM"

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "setPreferredBrowser() rList size ="

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, " return"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v11, v12}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    .local v2, "filter":Landroid/content/IntentFilter;
    new-array v9, v4, [Landroid/content/ComponentName;

    .local v9, "set":[Landroid/content/ComponentName;
    const/4 v1, 0x0

    .local v1, "browser":Landroid/content/ComponentName;
    const/4 v6, 0x0

    .local v6, "match":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    if-ge v3, v4, :cond_3

    invoke-interface {v8, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/content/pm/ResolveInfo;

    .local v7, "r":Landroid/content/pm/ResolveInfo;
    iget-object v0, v7, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    .local v0, "ai":Landroid/content/pm/ActivityInfo;
    new-instance v11, Landroid/content/ComponentName;

    iget-object v12, v0, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;

    iget-object v13, v0, Landroid/content/pm/ActivityInfo;->name:Ljava/lang/String;

    invoke-direct {v11, v12, v13}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    aput-object v11, v9, v3

    iget-object v11, v0, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v11, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_2

    iget-object v2, v7, Landroid/content/pm/ResolveInfo;->filter:Landroid/content/IntentFilter;

    aget-object v1, v9, v3

    iget v6, v7, Landroid/content/pm/ResolveInfo;->match:I

    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .end local v0    # "ai":Landroid/content/pm/ActivityInfo;
    .end local v7    # "r":Landroid/content/pm/ResolveInfo;
    :cond_3
    if-nez v2, :cond_4

    const-string v11, "GSM"

    const-string v12, "setPreferredBrowser() cannot find filter error!!!"

    invoke-static {v11, v12}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_4
    invoke-virtual {v5, v2, v6, v9, v1}, Landroid/content/pm/PackageManager;->addPreferredActivity(Landroid/content/IntentFilter;I[Landroid/content/ComponentName;Landroid/content/ComponentName;)V

    const-string v11, "GSM"

    const-string v12, "setPreferredBrowser() OK"

    invoke-static {v11, v12}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private updateOriginalSBPValues()Ljava/lang/String;
    .locals 7

    .prologue
    const-string v5, "GSM"

    const-string v6, "[Flex] update Original PRI Values"

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, ""

    .local v0, "flexOrgSBPvalues":Ljava/lang/String;
    const-string v5, "ro.lge.capp_cupss.rootdir"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .local v1, "orgCustPath":Ljava/lang/String;
    const-string v5, "persist.sys.ntcode"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .local v4, "orgNTCode":Ljava/lang/String;
    const-string v5, "persist.sys.iccid"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .local v2, "orgFastIccid":Ljava/lang/String;
    const-string v5, "persist.sys.iccid-mcc"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .local v3, "orgFastMcc":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ","

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "_,"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ","

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private updateOriginalSIMValues()Ljava/lang/String;
    .locals 4

    .prologue
    const-string v2, "GSM"

    const-string v3, "[Flex] update Original PRI Values"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v2, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    sget-object v3, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    const-string v3, "phone"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/telephony/TelephonyManager;

    .local v1, "mTelephony":Landroid/telephony/TelephonyManager;
    const-string v0, ""

    .local v0, "flexOriginalValues":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimSerialNumber()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ","

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSubscriberId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ","

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimOperator()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ","

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimOperatorName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ","

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getGroupIdLevel1()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getGroupIdLevel1()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/2addr v2, v3

    const/16 v3, 0x5b

    if-ge v2, v3, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getGroupIdLevel1()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_0
    return-object v0
.end method


# virtual methods
.method public enableStatus()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/SingleBinary;->mEnableSBP:Ljava/lang/String;

    return-object v0
.end method

.method public getGid(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "defaultValue"    # Ljava/lang/String;

    .prologue
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x13

    if-ge v1, v2, :cond_1

    const-string v1, "gsm.sim.operator.gid"

    invoke-static {v1, p1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    new-instance v1, Lcom/lge/uicc/LGUiccCard;

    invoke-direct {v1}, Lcom/lge/uicc/LGUiccCard;-><init>()V

    invoke-virtual {v1}, Lcom/lge/uicc/LGUiccCard;->getGid1()Ljava/lang/String;

    move-result-object v0

    .local v0, "gid":Ljava/lang/String;
    if-nez v0, :cond_0

    move-object v0, p1

    goto :goto_0
.end method

.method public notifyMappingPath()V
    .locals 9

    .prologue
    const/4 v5, 0x0

    const/4 v8, 0x1

    const/4 v7, 0x0

    const-string v4, "persist.sys.mccmnc-list"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .local v2, "ntcodeMccMnc":Ljava/lang/String;
    const-string v4, "persist.sys.subset-list"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .local v3, "ntcodeSubset":Ljava/lang/String;
    if-eqz v2, :cond_0

    if-eqz v3, :cond_0

    const-string v4, ","

    invoke-virtual {v2, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    aget-object v4, v4, v7

    const-string v5, ","

    invoke-virtual {v3, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    aget-object v5, v5, v7

    invoke-virtual {p0, v4, v5}, Lcom/android/internal/telephony/SingleBinary;->readConfigMapFile(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    sget-boolean v4, Lcom/android/internal/telephony/SingleBinary;->isMatchedStatus:Z

    if-nez v4, :cond_0

    sget-object v4, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    const-string v5, "keyguard"

    invoke-virtual {v4, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/KeyguardManager;

    .local v1, "km":Landroid/app/KeyguardManager;
    const-string v4, "keyguard"

    invoke-virtual {v1, v4}, Landroid/app/KeyguardManager;->newKeyguardLock(Ljava/lang/String;)Landroid/app/KeyguardManager$KeyguardLock;

    move-result-object v0

    .local v0, "kl":Landroid/app/KeyguardManager$KeyguardLock;
    invoke-virtual {v0}, Landroid/app/KeyguardManager$KeyguardLock;->disableKeyguard()V

    new-instance v4, Landroid/app/AlertDialog$Builder;

    sget-object v5, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    const/4 v6, 0x2

    invoke-direct {v4, v5, v6}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    const-string v5, "WARNING!"

    invoke-virtual {v4, v5}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Current version is not avaiable for user. Can\'t find matched cust for NT-code mcc/mnc["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ","

    invoke-virtual {v2, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v6

    aget-object v6, v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "], subset["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ","

    invoke-virtual {v3, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v6

    aget-object v6, v6, v7

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "]"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    sget-object v5, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    const v6, 0x108008a

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/app/AlertDialog$Builder;->setIcon(Landroid/graphics/drawable/Drawable;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    invoke-virtual {v4}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v4

    iput-object v4, p0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    iget-object v4, p0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    invoke-virtual {v4}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v4

    const/16 v5, 0x7d3

    invoke-virtual {v4, v5}, Landroid/view/Window;->setType(I)V

    iget-object v4, p0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    invoke-virtual {v4, v8}, Landroid/app/AlertDialog;->setCanceledOnTouchOutside(Z)V

    iget-object v4, p0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    invoke-virtual {v4, v8}, Landroid/app/AlertDialog;->setCancelable(Z)V

    iget-object v4, p0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    invoke-virtual {v4}, Landroid/app/AlertDialog;->show()V

    .end local v0    # "kl":Landroid/app/KeyguardManager$KeyguardLock;
    .end local v1    # "km":Landroid/app/KeyguardManager;
    :cond_0
    return-void
.end method

.method public readConfigMapFile(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "mccmnc"    # Ljava/lang/String;

    .prologue
    const-string v2, "persist.radio.mvno.subset-list"

    const-string v3, ""

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "mvno_subset":Ljava/lang/String;
    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    move-object v1, v0

    .local v1, "ntCodeSubsetList":Ljava/lang/String;
    :goto_0
    invoke-virtual {p0, p1, v1}, Lcom/android/internal/telephony/SingleBinary;->readConfigMapFile(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .end local v1    # "ntCodeSubsetList":Ljava/lang/String;
    :cond_0
    const-string v2, "persist.sys.subset-list"

    const-string v3, "FF"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .restart local v1    # "ntCodeSubsetList":Ljava/lang/String;
    goto :goto_0
.end method

.method public readConfigMapFile(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 11
    .param p1, "mccmnc"    # Ljava/lang/String;
    .param p2, "ntCodeSubsetList"    # Ljava/lang/String;

    .prologue
    const/4 v10, 0x1

    const/4 v3, 0x0

    .local v3, "displayUI":Z
    const/4 v0, 0x0

    .local v0, "br":Ljava/io/BufferedReader;
    const-string v6, "/cust"

    .local v6, "matched_rootdir":Ljava/lang/String;
    new-instance v2, Ljava/io/File;

    const-string v8, "/cust/cust_path_mapping.cfg"

    invoke-direct {v2, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .local v2, "cupssPathFile":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v8

    if-eqz v8, :cond_2

    :try_start_0
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v8, Ljava/io/FileReader;

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v1, v8}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "br":Ljava/io/BufferedReader;
    .local v1, "br":Ljava/io/BufferedReader;
    :cond_0
    :try_start_1
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v5

    .local v5, "line":Ljava/lang/String;
    if-eqz v5, :cond_1

    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v8

    if-lez v8, :cond_0

    const-string v8, ","

    invoke-virtual {v5, v8}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .local v4, "keyValue":[Ljava/lang/String;
    array-length v8, v4

    if-le v8, v10, :cond_0

    const/4 v8, 0x0

    aget-object v8, v4, v8

    invoke-virtual {p1, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_0

    const/4 v8, 0x1

    aget-object v8, v4, v8

    const-string v9, "="

    invoke-virtual {v8, v9}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v7

    .local v7, "subset":[Ljava/lang/String;
    array-length v8, v7

    if-le v8, v10, :cond_0

    const/4 v8, 0x0

    aget-object v8, v7, v8

    invoke-virtual {p2, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_0

    const/4 v8, 0x1

    aget-object v6, v7, v8

    const/4 v8, 0x1

    sput-boolean v8, Lcom/android/internal/telephony/SingleBinary;->isMatchedStatus:Z

    .end local v4    # "keyValue":[Ljava/lang/String;
    .end local v7    # "subset":[Ljava/lang/String;
    :cond_1
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    move-object v0, v1

    .end local v1    # "br":Ljava/io/BufferedReader;
    .end local v5    # "line":Ljava/lang/String;
    .restart local v0    # "br":Ljava/io/BufferedReader;
    :cond_2
    :goto_0
    return-object v6

    :catch_0
    move-exception v8

    goto :goto_0

    .end local v0    # "br":Ljava/io/BufferedReader;
    .restart local v1    # "br":Ljava/io/BufferedReader;
    :catch_1
    move-exception v8

    move-object v0, v1

    .end local v1    # "br":Ljava/io/BufferedReader;
    .restart local v0    # "br":Ljava/io/BufferedReader;
    goto :goto_0
.end method

.method public switchCustBaseNTCode()V
    .locals 6

    .prologue
    const-string v3, "1"

    iget-object v4, p0, Lcom/android/internal/telephony/SingleBinary;->mEnableSBP:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "persist.sys.mccmnc-list"

    const-string v4, "FFFFF"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .local v2, "ntcode_mccmnc":Ljava/lang/String;
    const-string v1, "/cust"

    .local v1, "mapping_rootdir":Ljava/lang/String;
    const-string v3, "GSM"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[LGE][SBP] Try to Switch CUST based on NTCode: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/internal/telephony/SingleBinary;->mNTCodeChanged:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v3, "1"

    iget-object v4, p0, Lcom/android/internal/telephony/SingleBinary;->mNTCodeChanged:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    sget-boolean v3, Lcom/android/internal/telephony/SingleBinary;->mTryToSwitch:Z

    if-nez v3, :cond_2

    const/4 v3, 0x1

    sput-boolean v3, Lcom/android/internal/telephony/SingleBinary;->mTryToSwitch:Z

    const-string v3, "FFFFF"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x5

    if-ge v3, v4, :cond_1

    :cond_0
    const-string v3, "persist.radio.first-mccmnc"

    const-string v4, "FFFFF"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/SingleBinary;->readConfigMapFile(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    sget-boolean v3, Lcom/android/internal/telephony/SingleBinary;->isMatchedStatus:Z

    if-eqz v3, :cond_3

    const-string v3, "GSM"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[LGE][SBP] Mapping CUST Dir: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v3, "persist.radio.first-mccmnc"

    invoke-static {v3, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v3, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    iget-object v4, p0, Lcom/android/internal/telephony/SingleBinary;->operatorSwitchReceiver:Landroid/content/BroadcastReceiver;

    iget-object v5, p0, Lcom/android/internal/telephony/SingleBinary;->OPERATOR_SWICHING_FILTER:Landroid/content/IntentFilter;

    invoke-virtual {v3, v4, v5}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    new-instance v0, Landroid/content/Intent;

    const-string v3, "com.lge.action.CUST_CHANGED_INFO"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v3, "cust_old_path"

    const-string v4, "persist.sys.cupss.prev-rootdir"

    const-string v5, "/cust"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    sget-object v3, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    invoke-virtual {v3, v0}, Landroid/content/Context;->sendStickyBroadcast(Landroid/content/Intent;)V

    .end local v0    # "intent":Landroid/content/Intent;
    .end local v1    # "mapping_rootdir":Ljava/lang/String;
    .end local v2    # "ntcode_mccmnc":Ljava/lang/String;
    :cond_2
    :goto_0
    return-void

    .restart local v1    # "mapping_rootdir":Ljava/lang/String;
    .restart local v2    # "ntcode_mccmnc":Ljava/lang/String;
    :cond_3
    const-string v3, "persist.radio.first-mccmnc"

    const-string v4, "FFFFF"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public switchCustBaseUI(Ljava/lang/String;I)V
    .locals 42
    .param p1, "Imsi"    # Ljava/lang/String;
    .param p2, "mncLength"    # I

    .prologue
    move-object/from16 v0, p1

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/android/internal/telephony/SingleBinary;->mImsi:Ljava/lang/String;

    move/from16 v0, p2

    move-object/from16 v1, p0

    iput v0, v1, Lcom/android/internal/telephony/SingleBinary;->mMncLength:I

    const-string v38, "1"

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->mEnableUI:Ljava/lang/String;

    move-object/from16 v39, v0

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-eqz v38, :cond_b

    const-string v38, "1"

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->mNTCodeChanged:Ljava/lang/String;

    move-object/from16 v39, v0

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-nez v38, :cond_b

    const-string v38, "persist.radio.first-mccmnc"

    const-string v39, ""

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/String;->length()I

    move-result v38

    const/16 v39, 0x5

    move/from16 v0, v38

    move/from16 v1, v39

    if-ge v0, v1, :cond_b

    const-string v30, "FFFFF"

    .local v30, "sim_mccmnc":Ljava/lang/String;
    const-string v21, "/cust"

    .local v21, "mapping_rootdir":Ljava/lang/String;
    const-string v38, "ro.lge.capp_cupss.rootdir"

    const-string v39, "/cust"

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .local v6, "cupss_rootdir":Ljava/lang/String;
    const/4 v8, 0x1

    .local v8, "displayUI":Z
    const-string v38, "GSM"

    const-string v39, "[LGE][SBP] Try to Switch CUST based on the Cust confirmed UI"

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->mImsi:Ljava/lang/String;

    move-object/from16 v38, v0

    if-eqz v38, :cond_0

    const-string v38, "3"

    move-object/from16 v0, p0

    iget v0, v0, Lcom/android/internal/telephony/SingleBinary;->mMncLength:I

    move/from16 v39, v0

    invoke-static/range {v39 .. v39}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v39

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-eqz v38, :cond_c

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->mImsi:Ljava/lang/String;

    move-object/from16 v38, v0

    const/16 v39, 0x0

    const/16 v40, 0x6

    invoke-virtual/range {v38 .. v40}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v30

    :cond_0
    :goto_0
    const-string v38, "GSM"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "[LGE][SBP] sim_mccmnc: "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v38, "gsm.sim.operator.alpha"

    const-string v39, ""

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v31

    .local v31, "spn":Ljava/lang/String;
    const-string v38, "GSM"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "[LGE][SBP] spn: "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move-object/from16 v1, v31

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v38, "persist.sys.mccmnc-list"

    const-string v39, ""

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v24

    .local v24, "ntCodeMccMnc":Ljava/lang/String;
    const-string v38, "GSM"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "[LGE][SBP] ntCodeMccMnc: "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move-object/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v10, 0x0

    .local v10, "gidProperty":Ljava/lang/String;
    const/16 v17, 0x0

    .local v17, "isSpnMatched":Z
    const/16 v16, 0x0

    .local v16, "isSimMccMncInNTCode":Z
    if-eqz v24, :cond_3

    invoke-virtual/range {v24 .. v24}, Ljava/lang/String;->length()I

    move-result v38

    const/16 v39, 0x5

    move/from16 v0, v38

    move/from16 v1, v39

    if-lt v0, v1, :cond_3

    move-object/from16 v0, v24

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v38

    if-eqz v38, :cond_3

    new-instance v38, Ljava/lang/StringBuilder;

    invoke-direct/range {v38 .. v38}, Ljava/lang/StringBuilder;-><init>()V

    const-string v39, "ro.config.spnnamelist_"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v38

    const/16 v39, 0x0

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v33

    .local v33, "spnProperties":Ljava/lang/String;
    new-instance v38, Ljava/lang/StringBuilder;

    invoke-direct/range {v38 .. v38}, Ljava/lang/StringBuilder;-><init>()V

    const-string v39, "ro.config.spnsubsetlist_"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v38

    const/16 v39, 0x0

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v35

    .local v35, "spnSubsetProperties":Ljava/lang/String;
    new-instance v38, Ljava/lang/StringBuilder;

    invoke-direct/range {v38 .. v38}, Ljava/lang/StringBuilder;-><init>()V

    const-string v39, "ro.config.cupss_gid_"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v38

    const/16 v39, 0x0

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    const/16 v16, 0x1

    const-string v38, "GSM"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "[LGE][SBP] spnProperties: "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move-object/from16 v1, v33

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v38, "GSM"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "[LGE][SBP] spnSubsetProperties: "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move-object/from16 v1, v35

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v33, :cond_3

    const-string v38, ""

    move-object/from16 v0, v33

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-nez v38, :cond_3

    const-string v38, ","

    move-object/from16 v0, v33

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v32

    .local v32, "spnList":[Ljava/lang/String;
    const-string v38, ","

    move-object/from16 v0, v35

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v34

    .local v34, "spnSubsetList":[Ljava/lang/String;
    const/4 v12, 0x0

    .local v12, "i":I
    :goto_1
    move-object/from16 v0, v32

    array-length v0, v0

    move/from16 v38, v0

    move/from16 v0, v38

    if-ge v12, v0, :cond_2

    aget-object v38, v32, v12

    move-object/from16 v0, v31

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-eqz v38, :cond_d

    aget-object v38, v34, v12

    invoke-virtual/range {v38 .. v38}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v38

    const-string v39, "FF"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-nez v38, :cond_1

    const-string v38, "persist.radio.mvno.subset-list"

    aget-object v39, v34, v12

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v38, "GSM"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "[LGE][SBP] mvno set other sim: "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    aget-object v40, v34, v12

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    const/16 v17, 0x1

    :cond_2
    const-string v38, "GSM"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "[LGE][SBP] isSpnMatched : "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v17, :cond_3

    new-instance v38, Ljava/lang/StringBuilder;

    invoke-direct/range {v38 .. v38}, Ljava/lang/StringBuilder;-><init>()V

    const-string v39, "ro.config.spnopenui_"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v38

    const-string v39, "0"

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v38

    const-string v39, "1"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-eqz v38, :cond_3

    new-instance v38, Ljava/lang/StringBuilder;

    invoke-direct/range {v38 .. v38}, Ljava/lang/StringBuilder;-><init>()V

    const-string v39, "ro.config.spnopensubset_"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v38

    const-string v39, "01"

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v36

    .local v36, "spnopenuisubset":Ljava/lang/String;
    const-string v38, "persist.radio.mvno.subset-list"

    move-object/from16 v0, v38

    move-object/from16 v1, v36

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v38, "GSM"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "[LGE][SBP] mvno set open ui : "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move-object/from16 v1, v36

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v12    # "i":I
    .end local v32    # "spnList":[Ljava/lang/String;
    .end local v33    # "spnProperties":Ljava/lang/String;
    .end local v34    # "spnSubsetList":[Ljava/lang/String;
    .end local v35    # "spnSubsetProperties":Ljava/lang/String;
    .end local v36    # "spnopenuisubset":Ljava/lang/String;
    :cond_3
    const-string v38, "GSM"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "[LGE][SBP] isSimMccMncInNTCode : "

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v16, :cond_10

    if-eqz v10, :cond_e

    const-string v38, ""

    move-object/from16 v0, v38

    invoke-virtual {v10, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-nez v38, :cond_e

    const-string v38, ""

    move-object/from16 v0, p0

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->getGid(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v38

    move-object/from16 v0, v38

    invoke-virtual {v0, v10}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v38

    if-eqz v38, :cond_e

    new-instance v38, Ljava/lang/StringBuilder;

    invoke-direct/range {v38 .. v38}, Ljava/lang/StringBuilder;-><init>()V

    const-string v39, "ro.config.gidsubset_"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v38

    const-string v39, "FF"

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .local v11, "gidsubset":Ljava/lang/String;
    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-virtual {v0, v1, v11}, Lcom/android/internal/telephony/SingleBinary;->readConfigMapFile(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v21

    const-string v38, "/cust"

    move-object/from16 v0, v21

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-nez v38, :cond_4

    const-string v38, "persist.radio.mvno.subset-list"

    move-object/from16 v0, v38

    invoke-static {v0, v11}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .end local v11    # "gidsubset":Ljava/lang/String;
    :cond_4
    :goto_2
    const/16 v38, 0x0

    invoke-static/range {v38 .. v38}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v14

    .local v14, "isForceReboot":Ljava/lang/Boolean;
    const-string v38, "/cust"

    move-object/from16 v0, v21

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-eqz v38, :cond_12

    move-object/from16 v21, v6

    const-string v38, "ro.lge.supportvolte"

    const-string v39, "0"

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v38

    const-string v39, "1"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-eqz v38, :cond_5

    const-string v38, "GSM"

    const-string v39, "[LGE][SBP] set non-VoLTE"

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v38, 0x1

    invoke-static/range {v38 .. v38}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v14

    :cond_5
    :goto_3
    move-object/from16 v9, v21

    .local v9, "finalMapping_rootdir":Ljava/lang/String;
    const-string v38, "persist.sys.backup-status"

    const-string v39, "F"

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v38

    const-string v39, "1"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-eqz v38, :cond_6

    const-string v38, "GSM"

    const-string v39, "[LGE][SBP] RESTORE Mode support!!"

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v8, 0x0

    :cond_6
    const-string v38, "persist.radio.first-mccmnc"

    const-string v39, ""

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/String;->length()I

    move-result v38

    const/16 v39, 0x5

    move/from16 v0, v38

    move/from16 v1, v39

    if-lt v0, v1, :cond_13

    const-string v38, "GSM"

    const-string v39, "[LGE][SBP] CUST locked!!"

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v8, 0x0

    :goto_4
    const/16 v38, 0x1

    move/from16 v0, v38

    if-ne v8, v0, :cond_7

    move-object/from16 v0, v21

    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-eqz v38, :cond_8

    :cond_7
    invoke-virtual {v14}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v38

    if-eqz v38, :cond_b

    :cond_8
    const-string v38, "GSM"

    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V

    const-string v40, "[LGE][SBP] CUST setting MCC,MNC :"

    invoke-virtual/range {v39 .. v40}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    move-object/from16 v0, v39

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v39

    invoke-virtual/range {v39 .. v39}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v39

    invoke-static/range {v38 .. v39}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v38, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    const-string v39, "keyguard"

    invoke-virtual/range {v38 .. v39}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v19

    check-cast v19, Landroid/app/KeyguardManager;

    .local v19, "km":Landroid/app/KeyguardManager;
    const-string v38, "keyguard"

    move-object/from16 v0, v19

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Landroid/app/KeyguardManager;->newKeyguardLock(Ljava/lang/String;)Landroid/app/KeyguardManager$KeyguardLock;

    move-result-object v18

    .local v18, "kl":Landroid/app/KeyguardManager$KeyguardLock;
    invoke-virtual/range {v18 .. v18}, Landroid/app/KeyguardManager$KeyguardLock;->disableKeyguard()V

    sget-object v38, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->operatorSwitchReceiver:Landroid/content/BroadcastReceiver;

    move-object/from16 v39, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->OPERATOR_SWICHING_FILTER:Landroid/content/IntentFilter;

    move-object/from16 v40, v0

    invoke-virtual/range {v38 .. v40}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    new-instance v20, Lcom/android/internal/telephony/SingleBinary$5;

    move-object/from16 v0, v20

    move-object/from16 v1, p0

    invoke-direct {v0, v1, v9}, Lcom/android/internal/telephony/SingleBinary$5;-><init>(Lcom/android/internal/telephony/SingleBinary;Ljava/lang/String;)V

    .local v20, "listener":Landroid/content/DialogInterface$OnClickListener;
    const-string v38, "persist.radio.mvno.subset-list"

    const-string v39, ""

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v23

    .local v23, "mvno_subset":Ljava/lang/String;
    const-string v38, "ro.lge.sbp.block-popup"

    const/16 v39, 0x0

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v38

    invoke-static/range {v38 .. v38}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v15

    .local v15, "isOkCancelNotRequired":Ljava/lang/Boolean;
    const-string v38, ""

    move-object/from16 v0, v23

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-eqz v38, :cond_9

    if-nez v16, :cond_9

    invoke-virtual {v15}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v38

    if-eqz v38, :cond_17

    :cond_9
    invoke-virtual {v14}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v38

    if-eqz v38, :cond_14

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->handler:Landroid/os/Handler;

    move-object/from16 v38, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->runnable:Ljava/lang/Runnable;

    move-object/from16 v39, v0

    const-wide/16 v40, 0x2710

    invoke-virtual/range {v38 .. v41}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :goto_5
    const-string v38, "persist.radio.cupss.next-root"

    move-object/from16 v0, v38

    invoke-static {v0, v9}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    if-nez v16, :cond_a

    invoke-virtual {v15}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v38

    if-eqz v38, :cond_15

    :cond_a
    const-string v38, "persist.radio.first-mccmnc"

    move-object/from16 v0, v38

    move-object/from16 v1, v30

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :goto_6
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v27

    .local v27, "r":Landroid/content/res/Resources;
    sget v38, Lcom/lge/internal/R$string;->sim_change_please_wait:I

    move-object/from16 v0, v27

    move/from16 v1, v38

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v37

    .local v37, "title":Ljava/lang/String;
    sget v38, Lcom/lge/internal/R$string;->sim_change_automatically_update_settings:I

    move-object/from16 v0, v27

    move/from16 v1, v38

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v22

    .local v22, "message":Ljava/lang/String;
    new-instance v38, Landroid/app/AlertDialog$Builder;

    sget-object v39, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    invoke-direct/range {v38 .. v39}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, v38

    move-object/from16 v1, v37

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    move-object/from16 v38, v0

    invoke-virtual/range {v38 .. v38}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v38

    const/16 v39, 0x7d3

    invoke-virtual/range {v38 .. v39}, Landroid/view/Window;->setType(I)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    move-object/from16 v38, v0

    const/16 v39, 0x0

    invoke-virtual/range {v38 .. v39}, Landroid/app/AlertDialog;->setCanceledOnTouchOutside(Z)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    move-object/from16 v38, v0

    const/16 v39, 0x0

    invoke-virtual/range {v38 .. v39}, Landroid/app/AlertDialog;->setCancelable(Z)V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->dialogProgress:Landroid/app/AlertDialog;

    move-object/from16 v38, v0

    invoke-virtual/range {v38 .. v38}, Landroid/app/AlertDialog;->show()V

    .end local v6    # "cupss_rootdir":Ljava/lang/String;
    .end local v8    # "displayUI":Z
    .end local v9    # "finalMapping_rootdir":Ljava/lang/String;
    .end local v10    # "gidProperty":Ljava/lang/String;
    .end local v14    # "isForceReboot":Ljava/lang/Boolean;
    .end local v15    # "isOkCancelNotRequired":Ljava/lang/Boolean;
    .end local v16    # "isSimMccMncInNTCode":Z
    .end local v17    # "isSpnMatched":Z
    .end local v18    # "kl":Landroid/app/KeyguardManager$KeyguardLock;
    .end local v19    # "km":Landroid/app/KeyguardManager;
    .end local v20    # "listener":Landroid/content/DialogInterface$OnClickListener;
    .end local v21    # "mapping_rootdir":Ljava/lang/String;
    .end local v22    # "message":Ljava/lang/String;
    .end local v23    # "mvno_subset":Ljava/lang/String;
    .end local v24    # "ntCodeMccMnc":Ljava/lang/String;
    .end local v27    # "r":Landroid/content/res/Resources;
    .end local v30    # "sim_mccmnc":Ljava/lang/String;
    .end local v31    # "spn":Ljava/lang/String;
    .end local v37    # "title":Ljava/lang/String;
    :cond_b
    :goto_7
    return-void

    .restart local v6    # "cupss_rootdir":Ljava/lang/String;
    .restart local v8    # "displayUI":Z
    .restart local v21    # "mapping_rootdir":Ljava/lang/String;
    .restart local v30    # "sim_mccmnc":Ljava/lang/String;
    :cond_c
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/SingleBinary;->mImsi:Ljava/lang/String;

    move-object/from16 v38, v0

    const/16 v39, 0x0

    const/16 v40, 0x5

    invoke-virtual/range {v38 .. v40}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v30

    goto/16 :goto_0

    .restart local v10    # "gidProperty":Ljava/lang/String;
    .restart local v12    # "i":I
    .restart local v16    # "isSimMccMncInNTCode":Z
    .restart local v17    # "isSpnMatched":Z
    .restart local v24    # "ntCodeMccMnc":Ljava/lang/String;
    .restart local v31    # "spn":Ljava/lang/String;
    .restart local v32    # "spnList":[Ljava/lang/String;
    .restart local v33    # "spnProperties":Ljava/lang/String;
    .restart local v34    # "spnSubsetList":[Ljava/lang/String;
    .restart local v35    # "spnSubsetProperties":Ljava/lang/String;
    :cond_d
    add-int/lit8 v12, v12, 0x1

    goto/16 :goto_1

    .end local v12    # "i":I
    .end local v32    # "spnList":[Ljava/lang/String;
    .end local v33    # "spnProperties":Ljava/lang/String;
    .end local v34    # "spnSubsetList":[Ljava/lang/String;
    .end local v35    # "spnSubsetProperties":Ljava/lang/String;
    :cond_e
    if-nez v17, :cond_f

    const-string v38, ","

    move-object/from16 v0, v24

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v38

    if-eqz v38, :cond_f

    const/16 v38, 0x3

    move-object/from16 v0, v30

    move/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v29

    .local v29, "simMNC":Ljava/lang/String;
    move-object/from16 v0, p0

    move-object/from16 v1, v30

    move-object/from16 v2, v29

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/SingleBinary;->readConfigMapFile(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-nez v38, :cond_4

    const-string v38, "/cust"

    move-object/from16 v0, v21

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-nez v38, :cond_4

    const-string v38, "persist.radio.mvno.subset-list"

    move-object/from16 v0, v38

    move-object/from16 v1, v29

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_2

    .end local v29    # "simMNC":Ljava/lang/String;
    :cond_f
    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->readConfigMapFile(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v21

    goto/16 :goto_2

    :cond_10
    if-eqz v24, :cond_11

    invoke-virtual/range {v24 .. v24}, Ljava/lang/String;->length()I

    move-result v38

    const/16 v39, 0x5

    move/from16 v0, v38

    move/from16 v1, v39

    if-lt v0, v1, :cond_11

    const-string v38, "persist.sys.mcc-list"

    const-string v39, ""

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v38

    const-string v39, "FFF"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v38

    if-nez v38, :cond_11

    new-instance v38, Ljava/lang/StringBuilder;

    invoke-direct/range {v38 .. v38}, Ljava/lang/StringBuilder;-><init>()V

    const-string v39, "ro.config.spnopensubset_"

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    const-string v39, ","

    move-object/from16 v0, v24

    move-object/from16 v1, v39

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v39

    const/16 v40, 0x0

    aget-object v39, v39, v40

    invoke-virtual/range {v38 .. v39}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v38

    const-string v39, "FF"

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v26

    .local v26, "openSubset":Ljava/lang/String;
    const-string v38, "persist.radio.mvno.subset-list"

    move-object/from16 v0, v38

    move-object/from16 v1, v26

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v38, ","

    move-object/from16 v0, v24

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v38

    const/16 v39, 0x0

    aget-object v38, v38, v39

    move-object/from16 v0, p0

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->readConfigMapFile(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v21

    goto/16 :goto_2

    .end local v26    # "openSubset":Ljava/lang/String;
    :cond_11
    move-object/from16 v0, p0

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/SingleBinary;->readConfigMapFile(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v21

    goto/16 :goto_2

    .restart local v14    # "isForceReboot":Ljava/lang/Boolean;
    :cond_12
    move-object/from16 v0, v21

    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v38

    if-eqz v38, :cond_5

    const-string v38, "ro.lge.sbp.force-reboot_mccmnc"

    const-string v39, ""

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v28

    .local v28, "reboot_list":Ljava/lang/String;
    const-string v38, "persist.radio.first-mccmnc"

    move-object/from16 v0, v38

    move-object/from16 v1, v30

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, v28

    move-object/from16 v1, v30

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v38

    invoke-static/range {v38 .. v38}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v14

    goto/16 :goto_3

    .end local v28    # "reboot_list":Ljava/lang/String;
    .restart local v9    # "finalMapping_rootdir":Ljava/lang/String;
    :cond_13
    const-string v38, "persist.radio.first-mccmnc"

    const-string v39, ""

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_4

    .restart local v15    # "isOkCancelNotRequired":Ljava/lang/Boolean;
    .restart local v18    # "kl":Landroid/app/KeyguardManager$KeyguardLock;
    .restart local v19    # "km":Landroid/app/KeyguardManager;
    .restart local v20    # "listener":Landroid/content/DialogInterface$OnClickListener;
    .restart local v23    # "mvno_subset":Ljava/lang/String;
    :cond_14
    new-instance v13, Landroid/content/Intent;

    const-string v38, "com.lge.action.CUST_CHANGED_INFO"

    move-object/from16 v0, v38

    invoke-direct {v13, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v13, "intent":Landroid/content/Intent;
    const-string v38, "cust_old_path"

    const-string v39, "ro.lge.capp_cupss.rootdir"

    const-string v40, "/cust"

    invoke-static/range {v39 .. v40}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v39

    move-object/from16 v0, v38

    move-object/from16 v1, v39

    invoke-virtual {v13, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    sget-object v38, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    move-object/from16 v0, v38

    invoke-virtual {v0, v13}, Landroid/content/Context;->sendStickyBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_5

    .end local v13    # "intent":Landroid/content/Intent;
    :cond_15
    if-eqz v24, :cond_16

    invoke-virtual/range {v24 .. v24}, Ljava/lang/String;->length()I

    move-result v38

    const/16 v39, 0x5

    move/from16 v0, v38

    move/from16 v1, v39

    if-lt v0, v1, :cond_16

    const-string v38, "persist.radio.first-mccmnc"

    const-string v39, ","

    move-object/from16 v0, v24

    move-object/from16 v1, v39

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v39

    const/16 v40, 0x0

    aget-object v39, v39, v40

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_6

    :cond_16
    const-string v38, "persist.radio.first-mccmnc"

    const-string v39, "FFFFFF"

    invoke-static/range {v38 .. v39}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_6

    :cond_17
    const-string v37, "Warning"

    .restart local v37    # "title":Ljava/lang/String;
    const-string v22, "New SIM Detected. Need to apply new settings, require reboot. Do you want to reboot now?"

    .restart local v22    # "message":Ljava/lang/String;
    const-string v5, "Ok"

    .local v5, "buttonOkTxt":Ljava/lang/String;
    const-string v4, "Cancel"

    .local v4, "buttonCancelTxt":Ljava/lang/String;
    const-string v38, "gsm.sim.operator.numeric"

    invoke-static/range {v38 .. v38}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v25

    .local v25, "numeric":Ljava/lang/String;
    const-string v38, "52501"

    move-object/from16 v0, v25

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v38

    if-nez v38, :cond_18

    const-string v38, "52502"

    move-object/from16 v0, v25

    move-object/from16 v1, v38

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v38

    if-eqz v38, :cond_19

    :cond_18
    new-instance v38, Landroid/app/AlertDialog$Builder;

    sget-object v39, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    invoke-direct/range {v38 .. v39}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, v38

    move-object/from16 v1, v37

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v20

    invoke-virtual {v0, v5, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v7

    .local v7, "dialog":Landroid/app/AlertDialog;
    invoke-virtual {v7}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v38

    const/16 v39, 0x7d3

    invoke-virtual/range {v38 .. v39}, Landroid/view/Window;->setType(I)V

    const/16 v38, 0x0

    move/from16 v0, v38

    invoke-virtual {v7, v0}, Landroid/app/AlertDialog;->setCanceledOnTouchOutside(Z)V

    const/16 v38, 0x0

    move/from16 v0, v38

    invoke-virtual {v7, v0}, Landroid/app/AlertDialog;->setCancelable(Z)V

    invoke-virtual {v7}, Landroid/app/AlertDialog;->show()V

    goto/16 :goto_7

    .end local v7    # "dialog":Landroid/app/AlertDialog;
    :cond_19
    new-instance v38, Landroid/app/AlertDialog$Builder;

    sget-object v39, Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;

    invoke-direct/range {v38 .. v39}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, v38

    move-object/from16 v1, v37

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v20

    invoke-virtual {v0, v5, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v38

    move-object/from16 v0, v38

    move-object/from16 v1, v20

    invoke-virtual {v0, v4, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v38

    invoke-virtual/range {v38 .. v38}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v7

    .restart local v7    # "dialog":Landroid/app/AlertDialog;
    invoke-virtual {v7}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v38

    const/16 v39, 0x7d3

    invoke-virtual/range {v38 .. v39}, Landroid/view/Window;->setType(I)V

    const/16 v38, 0x0

    move/from16 v0, v38

    invoke-virtual {v7, v0}, Landroid/app/AlertDialog;->setCanceledOnTouchOutside(Z)V

    const/16 v38, 0x0

    move/from16 v0, v38

    invoke-virtual {v7, v0}, Landroid/app/AlertDialog;->setCancelable(Z)V

    invoke-virtual {v7}, Landroid/app/AlertDialog;->show()V

    goto/16 :goto_7
.end method

.method public updateSystemLanguage()V
    .locals 13

    .prologue
    const/4 v12, 0x1

    const/4 v11, 0x0

    const/4 v10, 0x3

    const-string v7, "1"

    iget-object v8, p0, Lcom/android/internal/telephony/SingleBinary;->mEnableSBP:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_5

    const-string v7, "persist.sys.cust.iccid_lang"

    invoke-static {v7, v12}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v7

    if-eqz v7, :cond_5

    const-string v5, ""

    .local v5, "language":Ljava/lang/String;
    const-string v2, ""

    .local v2, "country":Ljava/lang/String;
    const-string v7, "persist.radio.first-set"

    const-string v8, "0"

    invoke-static {v7, v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .local v4, "firstSetLang":Ljava/lang/String;
    const-string v7, "GSM"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE][SBP] SIM Changed status: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMChanged:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v7, "1"

    iget-object v8, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMChanged:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_6

    const-string v7, "GSM"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE][SBP] ICCID-MCC: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMMcc:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v7, "persist.radio.first-mccmnc"

    const-string v8, ""

    invoke-static {v7, v8}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v7, "FFF"

    iget-object v8, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMMcc:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_5

    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMMcc:Ljava/lang/String;

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v7

    if-ne v7, v10, :cond_5

    const-string v7, "ro.build.default_country"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "ZA"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_0

    const-string v7, "ro.build.target_country"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "ZA"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    :cond_0
    const-string v7, "655"

    iput-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMMcc:Ljava/lang/String;

    :cond_1
    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMMcc:Ljava/lang/String;

    invoke-virtual {v7, v11, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7

    invoke-static {v7}, Lcom/android/internal/telephony/MccTable;->defaultLanguageForMcc(I)Ljava/lang/String;

    move-result-object v5

    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMMcc:Ljava/lang/String;

    invoke-virtual {v7, v11, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7

    invoke-static {v7}, Lcom/android/internal/telephony/MccTable;->countryCodeForMcc(I)Ljava/lang/String;

    move-result-object v2

    if-nez v5, :cond_3

    const-string v7, "GSM"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE][SBP] No match language: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v2    # "country":Ljava/lang/String;
    .end local v4    # "firstSetLang":Ljava/lang/String;
    .end local v5    # "language":Ljava/lang/String;
    :cond_2
    :goto_0
    return-void

    .restart local v2    # "country":Ljava/lang/String;
    .restart local v4    # "firstSetLang":Ljava/lang/String;
    .restart local v5    # "language":Ljava/lang/String;
    :cond_3
    invoke-virtual {v5}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v5

    if-nez v2, :cond_4

    const-string v2, ""

    :cond_4
    invoke-virtual {v2}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v2

    :try_start_0
    invoke-static {}, Landroid/app/ActivityManagerNative;->getDefault()Landroid/app/IActivityManager;

    move-result-object v0

    .local v0, "am":Landroid/app/IActivityManager;
    invoke-interface {v0}, Landroid/app/IActivityManager;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    .local v1, "config":Landroid/content/res/Configuration;
    new-instance v7, Ljava/util/Locale;

    invoke-direct {v7, v5, v2}, Ljava/util/Locale;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v7, v1, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    const/4 v7, 0x1

    iput-boolean v7, v1, Landroid/content/res/Configuration;->userSetLocale:Z

    invoke-interface {v0, v1}, Landroid/app/IActivityManager;->updateConfiguration(Landroid/content/res/Configuration;)V

    const-string v7, "GSM"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE][SBP] PhoneBase locale set to "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "_"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " base SIM"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v7, "1"

    invoke-virtual {v4, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_5

    const-string v7, "persist.radio.first-set"

    const-string v8, "1"

    invoke-static {v7, v8}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .end local v0    # "am":Landroid/app/IActivityManager;
    .end local v1    # "config":Landroid/content/res/Configuration;
    .end local v2    # "country":Ljava/lang/String;
    .end local v4    # "firstSetLang":Ljava/lang/String;
    .end local v5    # "language":Ljava/lang/String;
    :cond_5
    :goto_1
    const-string v7, "ro.build.target_country"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "IL"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_2

    :try_start_1
    invoke-static {}, Landroid/app/ActivityManagerNative;->getDefault()Landroid/app/IActivityManager;

    move-result-object v0

    .restart local v0    # "am":Landroid/app/IActivityManager;
    invoke-interface {v0}, Landroid/app/IActivityManager;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    .restart local v1    # "config":Landroid/content/res/Configuration;
    iget-object v7, v1, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v7

    invoke-virtual {v7}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v7

    const-string v8, "iw_IL"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    const-string v7, "GSM"

    const-string v8, "[LGE][SBP] iw_IL case and change locale to en_GB"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v6, Ljava/util/Locale;

    const-string v7, "en"

    const-string v8, "GB"

    invoke-direct {v6, v7, v8}, Ljava/util/Locale;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .local v6, "locale":Ljava/util/Locale;
    invoke-virtual {v1, v6}, Landroid/content/res/Configuration;->setLocale(Ljava/util/Locale;)V

    invoke-interface {v0, v1}, Landroid/app/IActivityManager;->updateConfiguration(Landroid/content/res/Configuration;)V
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .end local v0    # "am":Landroid/app/IActivityManager;
    .end local v1    # "config":Landroid/content/res/Configuration;
    .end local v6    # "locale":Ljava/util/Locale;
    :catch_0
    move-exception v7

    goto/16 :goto_0

    .restart local v2    # "country":Ljava/lang/String;
    .restart local v4    # "firstSetLang":Ljava/lang/String;
    .restart local v5    # "language":Ljava/lang/String;
    :catch_1
    move-exception v3

    .local v3, "e":Ljava/lang/Exception;
    const-string v7, "GSM"

    const-string v8, "[LGE][SBP] Can\'t update system language base on SIM-ICCID MCC"

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .end local v3    # "e":Ljava/lang/Exception;
    :cond_6
    const-string v7, "F"

    iget-object v8, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMChanged:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_7

    const-string v7, "2"

    iget-object v8, p0, Lcom/android/internal/telephony/SingleBinary;->mSIMChanged:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_c

    :cond_7
    const-string v7, "persist.sys.ntcode_lang"

    invoke-static {v7, v12}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v7

    if-eqz v7, :cond_c

    const-string v7, "1"

    invoke-virtual {v4, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_8

    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mNTCodeChanged:Ljava/lang/String;

    const-string v8, "1"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_8

    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mNTCodeChanged:Ljava/lang/String;

    const-string v8, "F"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_5

    :cond_8
    const-string v7, "GSM"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE][SBP] NTCODE-MCC: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/android/internal/telephony/SingleBinary;->mNTcodeMcc:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mNTcodeMcc:Ljava/lang/String;

    if-eqz v7, :cond_9

    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mNTcodeMcc:Ljava/lang/String;

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v7

    if-lt v7, v10, :cond_9

    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mNTcodeMcc:Ljava/lang/String;

    invoke-virtual {v7, v11, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    iput-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mNTcodeMcc:Ljava/lang/String;

    :cond_9
    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mNTcodeMcc:Ljava/lang/String;

    if-eqz v7, :cond_5

    const-string v7, "FFF"

    iget-object v8, p0, Lcom/android/internal/telephony/SingleBinary;->mNTcodeMcc:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_5

    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mNTcodeMcc:Ljava/lang/String;

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v7

    if-lt v7, v10, :cond_5

    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mNTcodeMcc:Ljava/lang/String;

    invoke-virtual {v7, v11, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7

    invoke-static {v7}, Lcom/android/internal/telephony/MccTable;->defaultLanguageForMcc(I)Ljava/lang/String;

    move-result-object v5

    iget-object v7, p0, Lcom/android/internal/telephony/SingleBinary;->mNTcodeMcc:Ljava/lang/String;

    invoke-virtual {v7, v11, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7

    invoke-static {v7}, Lcom/android/internal/telephony/MccTable;->countryCodeForMcc(I)Ljava/lang/String;

    move-result-object v2

    if-nez v5, :cond_a

    const-string v7, "GSM"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE][SBP] No match language: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_a
    invoke-virtual {v5}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v5

    if-nez v2, :cond_b

    const-string v2, ""

    :cond_b
    :try_start_2
    invoke-static {}, Landroid/app/ActivityManagerNative;->getDefault()Landroid/app/IActivityManager;

    move-result-object v0

    .restart local v0    # "am":Landroid/app/IActivityManager;
    invoke-interface {v0}, Landroid/app/IActivityManager;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    .restart local v1    # "config":Landroid/content/res/Configuration;
    new-instance v7, Ljava/util/Locale;

    invoke-direct {v7, v5, v2}, Ljava/util/Locale;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v7, v1, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    const/4 v7, 0x1

    iput-boolean v7, v1, Landroid/content/res/Configuration;->userSetLocale:Z

    invoke-interface {v0, v1}, Landroid/app/IActivityManager;->updateConfiguration(Landroid/content/res/Configuration;)V

    const-string v7, "persist.radio.first-set"

    const-string v8, "1"

    invoke-static {v7, v8}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v7, "GSM"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[LGE][SBP] Just 1-time update to "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "_"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " base on NT-Code"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    goto/16 :goto_1

    .end local v0    # "am":Landroid/app/IActivityManager;
    .end local v1    # "config":Landroid/content/res/Configuration;
    :catch_2
    move-exception v3

    .restart local v3    # "e":Ljava/lang/Exception;
    const-string v7, "GSM"

    const-string v8, "[LGE][SBP] Can\'t update system lang base on NT-Code MCC"

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .end local v3    # "e":Ljava/lang/Exception;
    :cond_c
    const-string v7, "GSM"

    const-string v8, "[LGE][SBP] The inserted SIM is same!!"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1
.end method
