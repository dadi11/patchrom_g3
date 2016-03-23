.class public Lcom/android/internal/telephony/gfit/GfitUtils;
.super Landroid/os/Handler;
.source "GfitUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;
    }
.end annotation


# static fields
.field static final DBG:Z = true

.field public static final EVENT_CHANGED_PREFERRED_NETWORK_TYPE:I = 0x72

.field public static final EVENT_END_QUERY_AVAILABLE_NETWORKS:I = 0x71

.field public static final EVENT_GFIT_NO_SERVICE_CHANGED:I = 0x64

.field public static final EVENT_GFIT_POPUP_SWITCH_TO_GLOBAL_MODE:I = 0x67

.field public static final EVENT_GFIT_QUERY_AVAILABLE_NETWORKS:I = 0x6c

.field public static final EVENT_GFIT_QUERY_NETWORK_SELECTION_MODE_AFTER_BOOT:I = 0x69

.field public static final EVENT_GFIT_REGISTERED_TO_NETWORK:I = 0x65

.field public static final EVENT_GFIT_RETRY_QUERY_AVAILABLE_NETWORKS:I = 0x6f

.field public static final EVENT_GFIT_RETRY_SET_PREFERRED_NETWORK_TYPE:I = 0x6e

.field public static final EVENT_GFIT_SET_NETWORK_SELECTION_AUTOMATIC:I = 0x6a

.field public static final EVENT_GFIT_SET_NETWORK_SELECTION_MANUAL:I = 0x6b

.field public static final EVENT_GFIT_SET_PREFERRED_NETWORK_TYPE:I = 0x68

.field public static final EVENT_GFIT_SWITCH_TO_NETWORK_SELECTION_MODE_AUTOMATIC:I = 0x6d

.field public static final EVENT_GFIT_TRIGGER_NO_SERVICE_CHANGED:I = 0x66

.field public static final EVENT_START_QUERY_AVAILABLE_NETWORKS:I = 0x70

.field private static final LGE_FTM_OFF:I = 0x2

.field private static final LGE_FTM_ON:I = 0x1

.field public static final NETWORK_SELECTION_KEY:Ljava/lang/String; = "network_selection_key"

.field public static final NETWORK_SELECTION_NAME_KEY:Ljava/lang/String; = "network_selection_name_key"

.field private static final NT_MODE_CDMA_ONLY:I = 0x0

.field private static final NT_MODE_GLOBAL:I = 0x3

.field private static final NT_MODE_LTE_CDMA:I = 0x2

.field private static final NT_MODE_LTE_GSM_UMTS:I = 0x1

.field private static final PLMN_MAX:I = 0x14

.field private static final PROPERTY_FACTORY_TEST:Ljava/lang/String; = "ro.factorytest"

.field private static final PROPERTY_GFIT_POPUP_ON:Ljava/lang/String; = "persist.service.gfit.popup_on"

.field public static final RETRY_TO_QUERY_AVAILABLE_NETWORKS:I = 0xa

.field public static final RETRY_TO_SET_PREFFERED_NETWORK_TYPE:I = 0x5

.field private static final TIMEOUT_NO_SERVICE:I = 0x7530

.field private static final TIMEOUT_REMOVE_SWITCH_TO_AUTOMATIC_MODE:I = 0x1388

.field private static final TIMEOUT_RETRY_QUERY_AVAILABLE_NETWORKS:I = 0x2710

.field private static final TIMEOUT_RETRY_SET_PREFERRED_NETWORK_TYPE:I = 0x1388

.field private static final UNKNOWN_MODE:I = -0x1

.field private static final VZW_GFIT_ICC_ABSENT:I = 0x0

.field private static final VZW_GFIT_ICC_READY:I = 0x1

.field private static isFirstDisplay:Z

.field private static isNoGlobalPopupNeeded:Z

.field private static final preferredNetworkMode:I


# instance fields
.field private isManualMode:Z

.field private isManualSearching:Z

.field private mCi:Lcom/android/internal/telephony/CommandsInterface;

.field private mFTMFlag:I

.field private mGfitIntentReceiver:Landroid/content/BroadcastReceiver;

.field private mIntentReceiver:Landroid/content/BroadcastReceiver;

.field private mNetworkMode:I

.field private mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

.field mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

.field private mProcessingNoService:Z

.field private mSST:Lcom/android/internal/telephony/ServiceStateTracker;

.field private mServiceState:I

.field private nRetryPrefferedNetworkType:I

.field private nRetryQuertyAvailablenetworks:I

.field onClickCancelButton:Landroid/content/DialogInterface$OnClickListener;

.field onClickPlmnList:Landroid/content/DialogInterface$OnClickListener;

.field plmnListDialog:Landroid/app/AlertDialog;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    sget v0, Lcom/android/internal/telephony/RILConstants;->PREFERRED_NETWORK_MODE:I

    sput v0, Lcom/android/internal/telephony/gfit/GfitUtils;->preferredNetworkMode:I

    const/4 v0, 0x1

    sput-boolean v0, Lcom/android/internal/telephony/gfit/GfitUtils;->isFirstDisplay:Z

    const/4 v0, 0x0

    sput-boolean v0, Lcom/android/internal/telephony/gfit/GfitUtils;->isNoGlobalPopupNeeded:Z

    return-void
.end method

.method public constructor <init>(Lcom/android/internal/telephony/ServiceStateTracker;Lcom/android/internal/telephony/PhoneBaseEx;)V
    .locals 4
    .param p1, "sst"    # Lcom/android/internal/telephony/ServiceStateTracker;
    .param p2, "phone"    # Lcom/android/internal/telephony/PhoneBaseEx;

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    iput v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryQuertyAvailablenetworks:I

    iput v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryPrefferedNetworkType:I

    iput-boolean v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualMode:Z

    iput-boolean v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSearching:Z

    iput-boolean v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mProcessingNoService:Z

    const/4 v0, 0x3

    iput v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mServiceState:I

    iput v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mFTMFlag:I

    const/16 v0, 0x14

    new-array v0, v0, [Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    iput-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    new-instance v0, Lcom/android/internal/telephony/gfit/GfitUtils$1;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/gfit/GfitUtils$1;-><init>(Lcom/android/internal/telephony/gfit/GfitUtils;)V

    iput-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mGfitIntentReceiver:Landroid/content/BroadcastReceiver;

    new-instance v0, Lcom/android/internal/telephony/gfit/GfitUtils$2;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/gfit/GfitUtils$2;-><init>(Lcom/android/internal/telephony/gfit/GfitUtils;)V

    iput-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    new-instance v0, Lcom/android/internal/telephony/gfit/GfitUtils$6;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/gfit/GfitUtils$6;-><init>(Lcom/android/internal/telephony/gfit/GfitUtils;)V

    iput-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->onClickCancelButton:Landroid/content/DialogInterface$OnClickListener;

    new-instance v0, Lcom/android/internal/telephony/gfit/GfitUtils$7;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/gfit/GfitUtils$7;-><init>(Lcom/android/internal/telephony/gfit/GfitUtils;)V

    iput-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->onClickPlmnList:Landroid/content/DialogInterface$OnClickListener;

    iput-object p2, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    iget-object v0, p2, Lcom/android/internal/telephony/PhoneBaseEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    iput-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    iput-object p1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mSST:Lcom/android/internal/telephony/ServiceStateTracker;

    const-string v0, "create GfitUtils..."

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mSST:Lcom/android/internal/telephony/ServiceStateTracker;

    const/16 v1, 0x64

    invoke-virtual {v0, p0, v1, v2}, Lcom/android/internal/telephony/ServiceStateTracker;->registerForNoServiceChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mSST:Lcom/android/internal/telephony/ServiceStateTracker;

    const/16 v1, 0x65

    invoke-virtual {v0, p0, v1, v2}, Lcom/android/internal/telephony/ServiceStateTracker;->registerForNetworkAttached(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0x70

    invoke-interface {v0, p0, v1, v2}, Lcom/android/internal/telephony/CommandsInterface;->registerForStartQueryAvailableNetwork(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0x71

    invoke-interface {v0, p0, v1, v2}, Lcom/android/internal/telephony/CommandsInterface;->registerForEndQueryAvailableNetwork(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    const/16 v1, 0x72

    invoke-virtual {v0, p0, v1, v2}, Lcom/android/internal/telephony/PhoneBaseEx;->registerForSetPreferredNetworkType(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "android.intent.action.AIRPLANE_MODE"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mGfitIntentReceiver:Landroid/content/BroadcastReceiver;

    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "android.intent.action.SIM_STATE_CHANGED"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/gfit/GfitUtils;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/gfit/GfitUtils;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/gfit/GfitUtils;I)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/gfit/GfitUtils;
    .param p1, "x1"    # I

    .prologue
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendQuerySystemModeAfterBoot(I)V

    return-void
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/gfit/GfitUtils;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/gfit/GfitUtils;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->cancelSwitchToGlobalModePopupEvent()V

    return-void
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/gfit/GfitUtils;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/gfit/GfitUtils;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->getNetworkMode()I

    move-result v0

    return v0
.end method

.method static synthetic access$400(Lcom/android/internal/telephony/gfit/GfitUtils;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/gfit/GfitUtils;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSelection()Z

    move-result v0

    return v0
.end method

.method static synthetic access$500(Lcom/android/internal/telephony/gfit/GfitUtils;)Lcom/android/internal/telephony/PhoneBaseEx;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/gfit/GfitUtils;

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    return-object v0
.end method

.method static synthetic access$602(Lcom/android/internal/telephony/gfit/GfitUtils;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/gfit/GfitUtils;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mProcessingNoService:Z

    return p1
.end method

.method static synthetic access$700(Lcom/android/internal/telephony/gfit/GfitUtils;IIII)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/gfit/GfitUtils;
    .param p1, "x1"    # I
    .param p2, "x2"    # I
    .param p3, "x3"    # I
    .param p4, "x4"    # I

    .prologue
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/android/internal/telephony/gfit/GfitUtils;->triggerEventAfterTimeout(IIII)V

    return-void
.end method

.method static synthetic access$800()Z
    .locals 1

    .prologue
    sget-boolean v0, Lcom/android/internal/telephony/gfit/GfitUtils;->isNoGlobalPopupNeeded:Z

    return v0
.end method

.method static synthetic access$802(Z)Z
    .locals 0
    .param p0, "x0"    # Z

    .prologue
    sput-boolean p0, Lcom/android/internal/telephony/gfit/GfitUtils;->isNoGlobalPopupNeeded:Z

    return p0
.end method

.method private cancelSwitchToGlobalModePopupEvent()V
    .locals 2

    .prologue
    const/16 v1, 0x67

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->hasMessages(I)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "remove EVENT_GFIT_POPUP_SWITCH_TO_GLOBAL_MODE from MSG queue"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->removeMessages(I)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mProcessingNoService:Z

    :cond_0
    return-void
.end method

.method private closeSystemDialogs()V
    .locals 2

    .prologue
    const-string v1, "close system dialogs"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.CLOSE_SYSTEM_DIALOGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "closeDialogs":Landroid/content/Intent;
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    return-void
.end method

.method private createNotePopupGlobal()V
    .locals 6

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isPopupAllowed()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSearchingInSystemSelect()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->getIsNoGlobalPopupNeeded()Z

    move-result v3

    if-eqz v3, :cond_1

    :cond_0
    const-string v3, "Don\'t display popup"

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_1
    const-string v3, "Display Global popup"

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->closeSystemDialogs()V

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v2

    .local v2, "r":Landroid/content/res/Resources;
    iget-object v3, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v3

    sget v4, Lcom/lge/internal/R$layout;->alert_dialog_checkbox:I

    const/4 v5, 0x0

    invoke-static {v3, v4, v5}, Landroid/view/View;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .local v0, "linear":Landroid/widget/LinearLayout;
    new-instance v3, Landroid/app/AlertDialog$Builder;

    iget-object v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v4

    sget v5, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_Alert:I

    invoke-direct {v3, v4, v5}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    sget v4, Lcom/lge/internal/R$string;->sp_dlg_networkmode_NORMAL:I

    invoke-virtual {v2, v4}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    invoke-virtual {v3, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    sget v4, Lcom/lge/internal/R$string;->dlg_ok:I

    invoke-virtual {v2, v4}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lcom/android/internal/telephony/gfit/GfitUtils$5;

    invoke-direct {v5, p0, v0}, Lcom/android/internal/telephony/gfit/GfitUtils$5;-><init>(Lcom/android/internal/telephony/gfit/GfitUtils;Landroid/widget/LinearLayout;)V

    invoke-virtual {v3, v4, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    sget v4, Lcom/lge/internal/R$string;->cancel:I

    invoke-virtual {v2, v4}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lcom/android/internal/telephony/gfit/GfitUtils$4;

    invoke-direct {v5, p0}, Lcom/android/internal/telephony/gfit/GfitUtils$4;-><init>(Lcom/android/internal/telephony/gfit/GfitUtils;)V

    invoke-virtual {v3, v4, v5}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    invoke-virtual {v3}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    .local v1, "notePopup":Landroid/app/AlertDialog;
    invoke-virtual {v1}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    const/16 v4, 0x7d3

    invoke-virtual {v3, v4}, Landroid/view/Window;->setType(I)V

    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    goto :goto_0
.end method

.method private createPlmnListDialog([Ljava/lang/CharSequence;)V
    .locals 4
    .param p1, "plmnList"    # [Ljava/lang/CharSequence;

    .prologue
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "createPlmnListDialog(): networkMode = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->getNetworkMode()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isPopupAllowed()Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "Don\'t display popup"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    .local v0, "r":Landroid/content/res/Resources;
    new-instance v1, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_Alert:I

    invoke-direct {v1, v2, v3}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    sget v2, Lcom/lge/internal/R$string;->sp_dlg_Available_networks_NORMAL:I

    invoke-virtual {v0, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const/4 v2, -0x1

    iget-object v3, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->onClickPlmnList:Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {v1, p1, v2, v3}, Landroid/app/AlertDialog$Builder;->setSingleChoiceItems([Ljava/lang/CharSequence;ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    sget v2, Lcom/lge/internal/R$string;->cancel:I

    invoke-virtual {v0, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->onClickCancelButton:Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->plmnListDialog:Landroid/app/AlertDialog;

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->plmnListDialog:Landroid/app/AlertDialog;

    invoke-virtual {v1}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    const/16 v2, 0x7d3

    invoke-virtual {v1, v2}, Landroid/view/Window;->setType(I)V

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->plmnListDialog:Landroid/app/AlertDialog;

    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    const/16 v1, 0x1388

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendSwitchToNetworkSelectionModeAutomaticAfterTimeout(I)V

    goto :goto_0
.end method

.method private createUiccDetectedNotePopup()V
    .locals 6

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isPopupAllowed()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isSetupWizard()Z

    move-result v3

    if-eqz v3, :cond_1

    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Don\'t display user pop-up : isPopupAllowed = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isPopupAllowed()Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " isSetupWizard = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isSetupWizard()Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_1
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v2

    .local v2, "r":Landroid/content/res/Resources;
    sget v3, Lcom/lge/internal/R$string;->sp_dlg_detectsim_NORMAL:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    .local v1, "popupText":Ljava/lang/String;
    new-instance v3, Landroid/app/AlertDialog$Builder;

    iget-object v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v4

    sget v5, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_Alert:I

    invoke-direct {v3, v4, v5}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    sget v4, Lcom/lge/internal/R$string;->sp_dlg_networkmode_NORMAL:I

    invoke-virtual {v2, v4}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    invoke-virtual {v3, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    sget v4, Lcom/lge/internal/R$string;->dlg_ok:I

    invoke-virtual {v2, v4}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lcom/android/internal/telephony/gfit/GfitUtils$3;

    invoke-direct {v5, p0}, Lcom/android/internal/telephony/gfit/GfitUtils$3;-><init>(Lcom/android/internal/telephony/gfit/GfitUtils;)V

    invoke-virtual {v3, v4, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    invoke-virtual {v3}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .local v0, "notePopup":Landroid/app/AlertDialog;
    invoke-virtual {v0}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    const/16 v4, 0x7d3

    invoke-virtual {v3, v4}, Landroid/view/Window;->setType(I)V

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    goto :goto_0
.end method

.method private eventToString(I)Ljava/lang/String;
    .locals 1
    .param p1, "event"    # I

    .prologue
    packed-switch p1, :pswitch_data_0

    const-string v0, "Not supported Event"

    :goto_0
    return-object v0

    :pswitch_0
    const-string v0, "EVENT_GFIT_NO_SERVICE_CHANGED"

    goto :goto_0

    :pswitch_1
    const-string v0, "EVENT_GFIT_REGISTERED_TO_NETWORK"

    goto :goto_0

    :pswitch_2
    const-string v0, "EVENT_GFIT_TRIGGER_NO_SERVICE_CHANGED"

    goto :goto_0

    :pswitch_3
    const-string v0, "EVENT_GFIT_POPUP_SWITCH_TO_GLOBAL_MODE"

    goto :goto_0

    :pswitch_4
    const-string v0, "EVENT_GFIT_SET_PREFERRED_NETWORK_TYPE"

    goto :goto_0

    :pswitch_5
    const-string v0, "EVENT_GFIT_QUERY_NETWORK_SELECTION_MODE_AFTER_BOOT"

    goto :goto_0

    :pswitch_6
    const-string v0, "EVENT_GFIT_SET_NETWORK_SELECTION_AUTOMATIC"

    goto :goto_0

    :pswitch_7
    const-string v0, "EVENT_GFIT_SET_NETWORK_SELECTION_MANUAL"

    goto :goto_0

    :pswitch_8
    const-string v0, "EVENT_GFIT_QUERY_AVAILABLE_NETWORKS"

    goto :goto_0

    :pswitch_9
    const-string v0, "EVENT_GFIT_SWITCH_TO_NETWORK_SELECTION_MODE_AUTOMATIC"

    goto :goto_0

    :pswitch_a
    const-string v0, "EVENT_GFIT_RETRY_SET_PREFERRED_NETWORK_TYPE"

    goto :goto_0

    :pswitch_b
    const-string v0, "EVENT_GFIT_RETRY_QUERY_AVAILABLE_NETWORKS"

    goto :goto_0

    :pswitch_c
    const-string v0, "EVENT_START_QUERY_AVAILABLE_NETWORKS"

    goto :goto_0

    :pswitch_d
    const-string v0, "EVENT_END_QUERY_AVAILABLE_NETWORKS"

    goto :goto_0

    :pswitch_e
    const-string v0, "EVENT_CHANGED_PREFERRED_NETWORK_TYPE"

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x64
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_9
        :pswitch_a
        :pswitch_b
        :pswitch_c
        :pswitch_d
        :pswitch_e
    .end packed-switch
.end method

.method private getIsNoGlobalPopupNeeded()Z
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "isNoGlobalPopupNeeded = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-boolean v1, Lcom/android/internal/telephony/gfit/GfitUtils;->isNoGlobalPopupNeeded:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    sget-boolean v0, Lcom/android/internal/telephony/gfit/GfitUtils;->isNoGlobalPopupNeeded:Z

    return v0
.end method

.method private getNetworkMode()I
    .locals 4

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "preferred_network_mode"

    sget v3, Lcom/android/internal/telephony/gfit/GfitUtils;->preferredNetworkMode:I

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .local v0, "networkMode":I
    iput v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mNetworkMode:I

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getNetworkMode() : networkMode = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    const-string v1, "Not Supported system selection mode"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->loge(Ljava/lang/String;)V

    const/4 v1, -0x1

    :goto_0
    return v1

    :pswitch_1
    const/4 v1, 0x3

    goto :goto_0

    :pswitch_2
    const/4 v1, 0x1

    goto :goto_0

    :pswitch_3
    const/4 v1, 0x0

    goto :goto_0

    :pswitch_4
    const/4 v1, 0x2

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_3
        :pswitch_3
        :pswitch_3
        :pswitch_0
        :pswitch_4
        :pswitch_2
        :pswitch_1
        :pswitch_2
        :pswitch_2
    .end packed-switch
.end method

.method private getServiceState()I
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mSST:Lcom/android/internal/telephony/ServiceStateTracker;

    iget-object v1, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getState()I

    move-result v0

    .local v0, "state":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "service state = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    return v0
.end method

.method private handleChangedPreferredNetworkType()V
    .locals 7

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    const-string v4, "Preferred network type is changed"

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "preferred_network_mode"

    sget v6, Lcom/android/internal/telephony/gfit/GfitUtils;->preferredNetworkMode:I

    invoke-static {v4, v5, v6}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .local v0, "NetworkModeChange":I
    iget v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mNetworkMode:I

    if-eq v4, v0, :cond_1

    move v1, v2

    .local v1, "isNetworkModeChanged":Z
    :goto_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "isNetworkModeChanged = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " NetworkModeChange = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " mNetworkMode = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mNetworkMode:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    if-eqz v1, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->cancelSwitchToGlobalModePopupEvent()V

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->getNetworkMode()I

    move-result v4

    const/4 v5, 0x3

    if-eq v4, v5, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSelection()Z

    move-result v4

    if-nez v4, :cond_0

    iget-object v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "airplane_mode_on"

    invoke-static {v4, v5, v3}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v4

    if-nez v4, :cond_0

    const-string v4, "Switch to Global Mode after 30 secs"

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iput-boolean v2, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mProcessingNoService:Z

    const/16 v2, 0x67

    const/16 v4, 0x7530

    invoke-direct {p0, v2, v3, v3, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->triggerEventAfterTimeout(IIII)V

    :cond_0
    return-void

    .end local v1    # "isNetworkModeChanged":Z
    :cond_1
    move v1, v3

    goto :goto_0
.end method

.method private handleNetworkMode(I)V
    .locals 8
    .param p1, "newUicc"    # I

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    iget-object v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v6}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v6

    const-string v7, "old_uicc_state"

    invoke-static {v6, v7, v5}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    .local v2, "oldUicc":I
    if-ne v2, v4, :cond_1

    move v3, v4

    .local v3, "oldUiccState":Z
    :goto_0
    if-ne p1, v4, :cond_2

    move v1, v4

    .local v1, "newUiccState":Z
    :goto_1
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->getNetworkMode()I

    move-result v0

    .local v0, "networkMode":I
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "handleNetworkMode() : oldUiccState = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " newUiccState = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " networkMode = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    if-nez v3, :cond_3

    if-ne v1, v4, :cond_3

    sget-boolean v4, Lcom/android/internal/telephony/gfit/GfitUtils;->isFirstDisplay:Z

    if-eqz v4, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->createUiccDetectedNotePopup()V

    invoke-virtual {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->switchToGlobalMode()V

    sput-boolean v5, Lcom/android/internal/telephony/gfit/GfitUtils;->isFirstDisplay:Z

    :cond_0
    :goto_2
    iget-object v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "old_uicc_state"

    invoke-static {v4, v5, p1}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    return-void

    .end local v0    # "networkMode":I
    .end local v1    # "newUiccState":Z
    .end local v3    # "oldUiccState":Z
    :cond_1
    move v3, v5

    goto :goto_0

    .restart local v3    # "oldUiccState":Z
    :cond_2
    move v1, v5

    goto :goto_1

    .restart local v0    # "networkMode":I
    .restart local v1    # "newUiccState":Z
    :cond_3
    if-ne v3, v4, :cond_0

    if-ne v1, v4, :cond_0

    if-ne v0, v4, :cond_5

    iget-boolean v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualMode:Z

    if-nez v4, :cond_4

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSelection()Z

    move-result v4

    if-eqz v4, :cond_5

    :cond_4
    invoke-virtual {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendQueryAvailableNetworks()V

    goto :goto_2

    :cond_5
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->getServiceState()I

    move-result v4

    if-eqz v4, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendTriggerNoServiceChanged()V

    goto :goto_2
.end method

.method private handleNoServiceChanged()V
    .locals 6

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    const-string v4, "handleNoServiceChanged"

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->getServiceState()I

    move-result v1

    .local v1, "newServiceState":I
    iget v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mServiceState:I

    if-eq v4, v1, :cond_1

    move v0, v2

    .local v0, "hasChanged":Z
    :goto_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "hasChanged = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " mServiceState = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mServiceState:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " newServiceState = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iput v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mServiceState:I

    if-eqz v0, :cond_0

    iget-boolean v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mProcessingNoService:Z

    if-nez v4, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->getNetworkMode()I

    move-result v4

    const/4 v5, 0x3

    if-eq v4, v5, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSelection()Z

    move-result v4

    if-nez v4, :cond_0

    iget-object v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "airplane_mode_on"

    invoke-static {v4, v5, v3}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v4

    if-nez v4, :cond_0

    const-string v4, "Switch to Global Mode after 30 secs"

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iput-boolean v2, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mProcessingNoService:Z

    const/16 v2, 0x67

    const/16 v4, 0x7530

    invoke-direct {p0, v2, v3, v3, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->triggerEventAfterTimeout(IIII)V

    :cond_0
    return-void

    .end local v0    # "hasChanged":Z
    :cond_1
    move v0, v3

    goto :goto_0
.end method

.method private handleRegisteredToNetwork()V
    .locals 4

    .prologue
    const-string v2, "register to network"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->getServiceState()I

    move-result v1

    .local v1, "newServiceState":I
    iget v2, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mServiceState:I

    if-eq v2, v1, :cond_1

    const/4 v0, 0x1

    .local v0, "hasChanged":Z
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "hasChanged = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " mServiceState = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mServiceState:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " newServiceState = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iput v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mServiceState:I

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->cancelSwitchToGlobalModePopupEvent()V

    :cond_0
    return-void

    .end local v0    # "hasChanged":Z
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private handleSetPreferredNetworkType(Landroid/os/Message;)V
    .locals 5
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v4, 0x0

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v2, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v2, :cond_0

    const-string v2, "success to set preferred network type"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iput v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryPrefferedNetworkType:I

    :goto_0
    return-void

    :cond_0
    iget v2, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryPrefferedNetworkType:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryPrefferedNetworkType:I

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "fail to set preferred network type.. retry to set preffered network type ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryPrefferedNetworkType:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iget v2, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryPrefferedNetworkType:I

    const/4 v3, 0x5

    if-ge v2, v3, :cond_1

    iget v1, p1, Landroid/os/Message;->arg1:I

    .local v1, "preferredNetworkType":I
    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendPreferredNetworkType(I)V

    const/16 v2, 0x6e

    const/16 v3, 0x1388

    invoke-direct {p0, v2, v1, v4, v3}, Lcom/android/internal/telephony/gfit/GfitUtils;->triggerEventAfterTimeout(IIII)V

    goto :goto_0

    .end local v1    # "preferredNetworkType":I
    :cond_1
    iput v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryPrefferedNetworkType:I

    goto :goto_0
.end method

.method private handleSwitchToGlobalMode()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->getServiceState()I

    move-result v0

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSelection()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "airplane_mode_on"

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mProcessingNoService:Z

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->createNotePopupGlobal()V

    :cond_0
    :goto_0
    iput-boolean v2, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mProcessingNoService:Z

    return-void

    :cond_1
    const-string v0, "ignore EVENT_GFIT_POPUP_SWITCH_TO_GLOBAL_MODE"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private isEncryptionPswdScreen()Z
    .locals 2

    .prologue
    const-string v0, "encrypted"

    const-string v1, "ro.crypto.state"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "trigger_restart_min_framework"

    const-string v1, "vold.decrypt"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private isManualSearchingInSystemSelect()Z
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "isManualSearching = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSearching:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSearching:Z

    return v0
.end method

.method private isManualSelection()Z
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mSST:Lcom/android/internal/telephony/ServiceStateTracker;

    iget-object v1, v1, Lcom/android/internal/telephony/ServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getIsManualSelection()Z

    move-result v0

    .local v0, "isManual":Z
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "isManualSelection = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    return v0
.end method

.method private isPopupAllowed()Z
    .locals 6

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    iget v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mFTMFlag:I

    if-nez v4, :cond_3

    const-string v4, "ro.factorytest"

    invoke-static {v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "factoryTestStr":Ljava/lang/String;
    if-eqz v0, :cond_1

    const-string v4, "2"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    iput v3, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mFTMFlag:I

    .end local v0    # "factoryTestStr":Ljava/lang/String;
    :cond_0
    :goto_0
    return v2

    .restart local v0    # "factoryTestStr":Ljava/lang/String;
    :cond_1
    const/4 v4, 0x2

    iput v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mFTMFlag:I

    .end local v0    # "factoryTestStr":Ljava/lang/String;
    :cond_2
    const-string v4, "persist.service.gfit.popup_on"

    invoke-static {v4, v3}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    .local v1, "isGfitPopupEnabled":Z
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "isGfitPopupEnabled = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    if-eqz v1, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isEncryptionPswdScreen()Z

    move-result v4

    if-nez v4, :cond_0

    move v2, v3

    goto :goto_0

    .end local v1    # "isGfitPopupEnabled":Z
    :cond_3
    iget v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mFTMFlag:I

    if-ne v4, v3, :cond_2

    goto :goto_0
.end method

.method private isSetupWizard()Z
    .locals 6

    .prologue
    const/4 v3, 0x0

    iget-object v4, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .local v1, "pm":Landroid/content/pm/PackageManager;
    const-string v2, "com.android.LGSetupWizard"

    .local v2, "setupWizard":Ljava/lang/String;
    :try_start_0
    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->getApplicationEnabledSetting(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v4

    const/4 v5, 0x2

    if-eq v4, v5, :cond_0

    const/4 v3, 0x1

    :cond_0
    :goto_0
    return v3

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v4, "isSetupwizard"

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->loge(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private log(Ljava/lang/String;)V
    .locals 3
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    const-string v0, "GSMCDMA"

    .local v0, "TAG":Ljava/lang/String;
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBaseEx;->getPhoneName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "GSM"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v0, "GSM"

    :cond_0
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[GFIT] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_1
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBaseEx;->getPhoneName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "CDMA"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v0, "CDMA"

    goto :goto_0
.end method

.method private loge(Ljava/lang/String;)V
    .locals 3
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    const-string v0, "GSMCDMA"

    .local v0, "TAG":Ljava/lang/String;
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBaseEx;->getPhoneName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "GSM"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v0, "GSM"

    :cond_0
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[GFIT] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_1
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBaseEx;->getPhoneName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "CDMA"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v0, "CDMA"

    goto :goto_0
.end method

.method private selectPlmnDialog(Ljava/util/ArrayList;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/OperatorInfo;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "result":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/OperatorInfo;>;"
    const/4 v9, 0x3

    if-nez p1, :cond_0

    const-string v6, "Fail to display PLMN Dialog"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    const/4 v2, 0x0

    .local v2, "nPlmnListNum":I
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v6

    new-array v5, v6, [Ljava/lang/CharSequence;

    .local v5, "plmnDialog":[Ljava/lang/CharSequence;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "selectPlmnDialog : result = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " size = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    const/16 v6, 0x14

    if-ge v0, v6, :cond_1

    iget-object v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    new-instance v7, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    invoke-direct {v7, p0}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;-><init>(Lcom/android/internal/telephony/gfit/GfitUtils;)V

    aput-object v7, v6, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/internal/telephony/OperatorInfo;

    .local v3, "ni":Lcom/android/internal/telephony/OperatorInfo;
    iget-object v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v6, v6, v2

    invoke-virtual {v3}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v7

    const/4 v8, 0x0

    invoke-virtual {v7, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v6, v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->setMCC(I)V

    iget-object v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v6, v6, v2

    invoke-virtual {v3}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v8

    invoke-virtual {v7, v9, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v6, v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->setMNC(I)V

    iget-object v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v6, v6, v2

    invoke-virtual {v3}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorRAT()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->setRAT(Ljava/lang/String;)V

    iget-object v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v6, v6, v2

    invoke-virtual {v3}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->setOperatorNumeric(Ljava/lang/String;)V

    iget-object v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v6, v6, v2

    invoke-virtual {v3}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->setOperatorAlphaLong(Ljava/lang/String;)V

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "]"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " MCC = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v7, v7, v2

    invoke-virtual {v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->getMCC()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " MNC = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v7, v7, v2

    invoke-virtual {v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->getMNC()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " RAT = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v7, v7, v2

    invoke-virtual {v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->getRAT()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " OperatorNemeric = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v7, v7, v2

    invoke-virtual {v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " OperatorAlphaLong = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v7, v7, v2

    invoke-virtual {v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .local v4, "plmn":Ljava/lang/String;
    invoke-direct {p0, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    invoke-virtual {v3}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v6

    const-string v7, ""

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v7, v7, v2

    invoke-virtual {v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->getRAT()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ")"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v2

    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_2

    :cond_2
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Lcom/android/internal/telephony/OperatorInfo;->getOperatorAlphaLong()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPlmnList:[Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;

    aget-object v7, v7, v2

    invoke-virtual {v7}, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->getRAT()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ")"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v2

    goto :goto_3

    .end local v3    # "ni":Lcom/android/internal/telephony/OperatorInfo;
    .end local v4    # "plmn":Ljava/lang/String;
    :cond_3
    invoke-direct {p0, v5}, Lcom/android/internal/telephony/gfit/GfitUtils;->createPlmnListDialog([Ljava/lang/CharSequence;)V

    goto/16 :goto_0
.end method

.method private sendPreferredNetworkType(I)V
    .locals 3
    .param p1, "networkType"    # I

    .prologue
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "sendPreferredNetworkType() : networkType = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    const/16 v1, 0x68

    const/4 v2, 0x0

    invoke-virtual {p0, v1, p1, v2}, Lcom/android/internal/telephony/gfit/GfitUtils;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1, p1, v0}, Lcom/android/internal/telephony/CommandsInterface;->setPreferredNetworkType(ILandroid/os/Message;)V

    return-void
.end method

.method private sendQuerySystemModeAfterBoot(I)V
    .locals 3
    .param p1, "simState"    # I

    .prologue
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "sendQuerySystemModeAfterBoot(int simState), simState == "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    const/16 v1, 0x69

    const/4 v2, 0x0

    invoke-virtual {p0, v1, p1, v2}, Lcom/android/internal/telephony/gfit/GfitUtils;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1, v0}, Lcom/android/internal/telephony/CommandsInterface;->getNetworkSelectionMode(Landroid/os/Message;)V

    return-void
.end method

.method private sendTriggerNoServiceChanged()V
    .locals 1

    .prologue
    const-string v0, "sendTriggerNoServiceChanged()"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    const/16 v0, 0x66

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendEmptyMessage(I)Z

    return-void
.end method

.method private setPreferredNetworkMode(I)V
    .locals 4
    .param p1, "preferrdNetworkMode"    # I

    .prologue
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "preferred_network_mode"

    sget v3, Lcom/android/internal/telephony/gfit/GfitUtils;->preferredNetworkMode:I

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .local v0, "networkMode":I
    if-eq v0, p1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setPreferredNetworkMode(): preferrdNetworkMode= "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "preferred_network_mode"

    invoke-static {v1, v2, p1}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendPreferredNetworkType(I)V

    :goto_0
    return-void

    :cond_0
    const-string v1, "setPreferredNetowkrMode : Fail to set Preferred Network. "

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private triggerEventAfterTimeout(IIII)V
    .locals 4
    .param p1, "what"    # I
    .param p2, "arg1"    # I
    .param p3, "arg2"    # I
    .param p4, "timeout"    # I

    .prologue
    invoke-virtual {p0, p1, p2, p3}, Lcom/android/internal/telephony/gfit/GfitUtils;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    int-to-long v2, p4

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendMessageDelayed(Landroid/os/Message;J)Z

    return-void
.end method


# virtual methods
.method public dispose()V
    .locals 3

    .prologue
    const-string v1, "dispose GfitUtils..."

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mSST:Lcom/android/internal/telephony/ServiceStateTracker;

    invoke-virtual {v1, p0}, Lcom/android/internal/telephony/ServiceStateTracker;->unregisterForNoServiceChanged(Landroid/os/Handler;)V

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mSST:Lcom/android/internal/telephony/ServiceStateTracker;

    invoke-virtual {v1, p0}, Lcom/android/internal/telephony/ServiceStateTracker;->unregisterForNetworkAttached(Landroid/os/Handler;)V

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForStartQueryAvailableNetwork(Landroid/os/Handler;)V

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForEndQueryAvailableNetwork(Landroid/os/Handler;)V

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v1, p0}, Lcom/android/internal/telephony/PhoneBaseEx;->unregisterForSetPreferredNetworkType(Landroid/os/Handler;)V

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mGfitIntentReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mGfitIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    :goto_0
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->cancelSwitchToGlobalModePopupEvent()V

    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mGfitIntentReceiver unregisterReceiver - Exception Msg: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 10
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v7, 0x1

    const/4 v8, 0x0

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "receive "

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v9, p1, Landroid/os/Message;->what:I

    invoke-direct {p0, v9}, Lcom/android/internal/telephony/gfit/GfitUtils;->eventToString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iget v6, p1, Landroid/os/Message;->what:I

    packed-switch v6, :pswitch_data_0

    const-string v6, "Not supported"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->loge(Ljava/lang/String;)V

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->handleNoServiceChanged()V

    goto :goto_0

    :pswitch_1
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->handleRegisteredToNetwork()V

    goto :goto_0

    :pswitch_2
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->handleSwitchToGlobalMode()V

    goto :goto_0

    :pswitch_3
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gfit/GfitUtils;->handleSetPreferredNetworkType(Landroid/os/Message;)V

    goto :goto_0

    :pswitch_4
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    iget v5, p1, Landroid/os/Message;->arg1:I

    .local v5, "uiccState":I
    iget-object v6, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v6, :cond_3

    iget-object v6, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v6, [I

    move-object v2, v6

    check-cast v2, [I

    .local v2, "ints":[I
    aget v6, v2, v8

    if-ne v6, v7, :cond_2

    move v6, v7

    :goto_1
    iput-boolean v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualMode:Z

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "isManualMode = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-boolean v7, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualMode:Z

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    .end local v2    # "ints":[I
    :goto_2
    iget-object v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mGfitIntentReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v6, :cond_1

    :try_start_0
    iget-object v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v6}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mGfitIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v6, v7}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    :goto_3
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isEncryptionPswdScreen()Z

    move-result v6

    if-nez v6, :cond_0

    invoke-direct {p0, v5}, Lcom/android/internal/telephony/gfit/GfitUtils;->handleNetworkMode(I)V

    goto :goto_0

    .restart local v2    # "ints":[I
    :cond_2
    move v6, v8

    goto :goto_1

    .end local v2    # "ints":[I
    :cond_3
    const-string v6, "Fail to query network selection mode after boot : EVENT_GFIT_QUERY_NETWORK_SELECTION_MODE_AFTER_BOOT"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    goto :goto_2

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "mGfitIntentReceiver unregisterReceiver - Exception Msg: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    goto :goto_3

    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v1    # "e":Ljava/lang/Exception;
    .end local v5    # "uiccState":I
    :pswitch_5
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v6, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v6, :cond_4

    const-string v6, "success to set network selection automatic"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_4
    const-string v6, "Fail to set network selection automatic"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_6
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v6, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v6, :cond_5

    const-string v6, "success to set network selection manual"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_5
    const-string v6, "Fail to set network selection manual"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_7
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v6, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v6, :cond_6

    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v4, Ljava/util/ArrayList;

    .local v4, "ret":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/OperatorInfo;>;"
    invoke-direct {p0, v4}, Lcom/android/internal/telephony/gfit/GfitUtils;->selectPlmnDialog(Ljava/util/ArrayList;)V

    iput v8, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryQuertyAvailablenetworks:I

    goto/16 :goto_0

    .end local v4    # "ret":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/android/internal/telephony/OperatorInfo;>;"
    :cond_6
    iget v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryQuertyAvailablenetworks:I

    add-int/lit8 v6, v6, 0x1

    iput v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryQuertyAvailablenetworks:I

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Fail to query available networks.. retry to query avaialbe networks ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryQuertyAvailablenetworks:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ")"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iget v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryQuertyAvailablenetworks:I

    const/16 v7, 0xa

    if-ge v6, v7, :cond_7

    const/16 v6, 0x6f

    const/16 v7, 0x2710

    invoke-direct {p0, v6, v8, v8, v7}, Lcom/android/internal/telephony/gfit/GfitUtils;->triggerEventAfterTimeout(IIII)V

    goto/16 :goto_0

    :cond_7
    iput v8, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->nRetryQuertyAvailablenetworks:I

    goto/16 :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_8
    iget-object v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->plmnListDialog:Landroid/app/AlertDialog;

    if-eqz v6, :cond_0

    const-string v6, "set automatic mode"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendNetworkSelectionModeAutomatic()V

    iget-object v6, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->plmnListDialog:Landroid/app/AlertDialog;

    invoke-virtual {v6}, Landroid/app/AlertDialog;->dismiss()V

    goto/16 :goto_0

    :pswitch_9
    iget v3, p1, Landroid/os/Message;->arg1:I

    .local v3, "preferredNetworkType":I
    invoke-direct {p0, v3}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendPreferredNetworkType(I)V

    goto/16 :goto_0

    .end local v3    # "preferredNetworkType":I
    :pswitch_a
    invoke-virtual {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendQueryAvailableNetworks()V

    goto/16 :goto_0

    :pswitch_b
    const-string v6, "Start querying Available networks"

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iput-boolean v7, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSearching:Z

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->cancelSwitchToGlobalModePopupEvent()V

    goto/16 :goto_0

    :pswitch_c
    iput-boolean v8, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSearching:Z

    goto/16 :goto_0

    :pswitch_d
    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->handleChangedPreferredNetworkType()V

    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x64
        :pswitch_0
        :pswitch_1
        :pswitch_0
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_9
        :pswitch_a
        :pswitch_b
        :pswitch_c
        :pswitch_d
    .end packed-switch
.end method

.method public sendNetworkSelectionModeAutomatic()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const-string v3, "sendNetworkSelectionModeAutomatic()"

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .local v2, "sp":Landroid/content/SharedPreferences;
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .local v0, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v3, "network_selection_key"

    const-string v4, ""

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    const-string v3, "network_selection_name_key"

    const-string v4, ""

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    const/16 v3, 0x6a

    invoke-virtual {p0, v3, v5, v5}, Lcom/android/internal/telephony/gfit/GfitUtils;->obtainMessage(III)Landroid/os/Message;

    move-result-object v1

    .local v1, "msg":Landroid/os/Message;
    iget-object v3, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v3, v1}, Lcom/android/internal/telephony/CommandsInterface;->setNetworkSelectionModeAutomatic(Landroid/os/Message;)V

    return-void
.end method

.method public sendNetworkSelectionModeManual(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p1, "operatorNumeric"    # Ljava/lang/String;
    .param p2, "operatorRat"    # Ljava/lang/String;
    .param p3, "OperatorAlphaLong"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "sendNetworkSelectionModeManual() : operatorNumeric = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " operatorRat = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " operatorAlphaLong = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mPhone:Lcom/android/internal/telephony/PhoneBaseEx;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBaseEx;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .local v2, "sp":Landroid/content/SharedPreferences;
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .local v0, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v3, "network_selection_key"

    invoke-interface {v0, v3, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    const-string v3, "network_selection_name_key"

    invoke-interface {v0, v3, p3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    const/16 v3, 0x6b

    invoke-virtual {p0, v3, v5, v5}, Lcom/android/internal/telephony/gfit/GfitUtils;->obtainMessage(III)Landroid/os/Message;

    move-result-object v1

    .local v1, "msg":Landroid/os/Message;
    iget-object v3, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v3, p1, p2, v1}, Lcom/android/internal/telephony/CommandsInterface;->setNetworkSelectionModeManual(Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    return-void
.end method

.method public sendQueryAvailableNetworks()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const-string v1, "sendQueryAvailableNetworks()"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    const/16 v1, 0x6c

    invoke-virtual {p0, v1, v2, v2}, Lcom/android/internal/telephony/gfit/GfitUtils;->obtainMessage(III)Landroid/os/Message;

    move-result-object v0

    .local v0, "msg":Landroid/os/Message;
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1, v0}, Lcom/android/internal/telephony/CommandsInterface;->getAvailableNetworks(Landroid/os/Message;)V

    return-void
.end method

.method public sendSwitchToNetworkSelectionModeAutomaticAfterTimeout(I)V
    .locals 4
    .param p1, "timeout"    # I

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "sendSwitchToNetworkSelectionModeAutomaticAfterTimeout(timeout = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    const/16 v0, 0x6d

    int-to-long v2, p1

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendEmptyMessageDelayed(IJ)Z

    return-void
.end method

.method public switchToGlobalMode()V
    .locals 2

    .prologue
    const-string v0, "switchToGlobalMode()"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->isManualSelection()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/android/internal/telephony/gfit/GfitUtils;->sendNetworkSelectionModeAutomatic()V

    :cond_0
    iget v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils;->mNetworkMode:I

    const/4 v1, 0x3

    if-eq v0, v1, :cond_1

    const/16 v0, 0xa

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->setPreferredNetworkMode(I)V

    :cond_1
    return-void
.end method
