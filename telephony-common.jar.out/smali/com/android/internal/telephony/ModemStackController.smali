.class public Lcom/android/internal/telephony/ModemStackController;
.super Landroid/os/Handler;
.source "ModemStackController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;
    }
.end annotation


# static fields
.field private static final BIND_TO_STACK:I = 0x1

.field private static final CMD_DEACTIVATE_ALL_SUBS:I = 0x1

.field private static final CMD_TRIGGER_BIND:I = 0x5

.field private static final CMD_TRIGGER_UNBIND:I = 0x3

.field private static final EVENT_BIND_DONE:I = 0x6

.field private static final EVENT_GET_MODEM_CAPS_DONE:I = 0x2

.field private static final EVENT_MODEM_CAPABILITY_CHANGED:I = 0xa

.field private static final EVENT_RADIO_AVAILABLE:I = 0x9

.field private static final EVENT_SET_PREF_MODE_DONE:I = 0x7

.field private static final EVENT_SUB_DEACTIVATED:I = 0x8

.field private static final EVENT_UNBIND_DONE:I = 0x4

.field private static final FAILURE:I = 0x0

.field private static final GET_MODEM_CAPS_BUFFER_LEN:I = 0x7

.field static final LOG_TAG:Ljava/lang/String; = "ModemStackController"

.field private static final PRIMARY_STACK_ID:I = 0x0

.field private static final STATE_BIND:I = 0x5

.field private static final STATE_GOT_MODEM_CAPS:I = 0x2

.field private static final STATE_SET_PREF_MODE:I = 0x7

.field private static final STATE_SUB_ACT:I = 0x6

.field private static final STATE_SUB_DEACT:I = 0x3

.field private static final STATE_UNBIND:I = 0x4

.field private static final STATE_UNKNOWN:I = 0x1

.field private static final SUCCESS:I = 0x1

.field private static final UNBIND_TO_STACK:I

.field private static sModemStackController:Lcom/android/internal/telephony/ModemStackController;


# instance fields
.field private mActiveSubCount:I

.field private mCi:[Lcom/android/internal/telephony/CommandsInterface;

.field private mCmdFailed:[Z

.field private mContext:Landroid/content/Context;

.field private mCurrentStackId:[I

.field private mDeactivationInProgress:Z

.field private mDeactivedSubCount:I

.field private mIsPhoneInEcbmMode:Z

.field private mIsRecoveryInProgress:Z

.field private mIsStackReady:Z

.field private mModemCapInfo:[Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;

.field private mModemDataCapsAvailableRegistrants:Landroid/os/RegistrantList;

.field private mModemRatCapabilitiesAvailable:Z

.field private mModemRatCapsAvailableRegistrants:Landroid/os/RegistrantList;

.field private mNumPhones:I

.field private mPrefNwMode:[I

.field private mPreferredStackId:[I

.field private mReceiver:Landroid/content/BroadcastReceiver;

.field private mStackReadyRegistrants:Landroid/os/RegistrantList;

.field private mSubState:[I

.field private mSubcriptionStatus:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private mUpdateStackMsg:Landroid/os/Message;


# direct methods
.method private constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/uicc/UiccController;[Lcom/android/internal/telephony/CommandsInterface;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "uiccManager"    # Lcom/android/internal/telephony/uicc/UiccController;
    .param p3, "ci"    # [Lcom/android/internal/telephony/CommandsInterface;

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 227
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 148
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v2

    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->getPhoneCount()I

    move-result v2

    iput v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    .line 149
    iput v5, p0, Lcom/android/internal/telephony/ModemStackController;->mActiveSubCount:I

    .line 150
    iput v5, p0, Lcom/android/internal/telephony/ModemStackController;->mDeactivedSubCount:I

    .line 151
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    new-array v2, v2, [I

    iput-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mPreferredStackId:[I

    .line 152
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    new-array v2, v2, [I

    iput-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    .line 153
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    new-array v2, v2, [I

    iput-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mPrefNwMode:[I

    .line 154
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    new-array v2, v2, [I

    iput-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mSubState:[I

    .line 155
    iput-boolean v5, p0, Lcom/android/internal/telephony/ModemStackController;->mIsStackReady:Z

    .line 156
    iput-boolean v5, p0, Lcom/android/internal/telephony/ModemStackController;->mIsRecoveryInProgress:Z

    .line 157
    iput-boolean v5, p0, Lcom/android/internal/telephony/ModemStackController;->mIsPhoneInEcbmMode:Z

    .line 158
    iput-boolean v5, p0, Lcom/android/internal/telephony/ModemStackController;->mModemRatCapabilitiesAvailable:Z

    .line 159
    iput-boolean v5, p0, Lcom/android/internal/telephony/ModemStackController;->mDeactivationInProgress:Z

    .line 160
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    new-array v2, v2, [Z

    iput-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCmdFailed:[Z

    .line 161
    new-instance v2, Landroid/os/RegistrantList;

    invoke-direct {v2}, Landroid/os/RegistrantList;-><init>()V

    iput-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mStackReadyRegistrants:Landroid/os/RegistrantList;

    .line 162
    new-instance v2, Landroid/os/RegistrantList;

    invoke-direct {v2}, Landroid/os/RegistrantList;-><init>()V

    iput-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mModemRatCapsAvailableRegistrants:Landroid/os/RegistrantList;

    .line 163
    new-instance v2, Landroid/os/RegistrantList;

    invoke-direct {v2}, Landroid/os/RegistrantList;-><init>()V

    iput-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mModemDataCapsAvailableRegistrants:Landroid/os/RegistrantList;

    .line 165
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    iput-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mSubcriptionStatus:Ljava/util/HashMap;

    .line 168
    iput-object v7, p0, Lcom/android/internal/telephony/ModemStackController;->mModemCapInfo:[Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;

    .line 170
    new-instance v2, Lcom/android/internal/telephony/ModemStackController$1;

    invoke-direct {v2, p0}, Lcom/android/internal/telephony/ModemStackController$1;-><init>(Lcom/android/internal/telephony/ModemStackController;)V

    iput-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mReceiver:Landroid/content/BroadcastReceiver;

    .line 228
    const-string v2, "Constructor - Enter"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 230
    iput-object p3, p0, Lcom/android/internal/telephony/ModemStackController;->mCi:[Lcom/android/internal/telephony/CommandsInterface;

    .line 231
    iput-object p1, p0, Lcom/android/internal/telephony/ModemStackController;->mContext:Landroid/content/Context;

    .line 232
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    new-array v2, v2, [Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;

    iput-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mModemCapInfo:[Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;

    .line 234
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCi:[Lcom/android/internal/telephony/CommandsInterface;

    array-length v2, v2

    if-ge v1, v2, :cond_0

    .line 235
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCi:[Lcom/android/internal/telephony/CommandsInterface;

    aget-object v2, v2, v1

    const/16 v3, 0x9

    new-instance v4, Ljava/lang/Integer;

    invoke-direct {v4, v1}, Ljava/lang/Integer;-><init>(I)V

    invoke-interface {v2, p0, v3, v4}, Lcom/android/internal/telephony/CommandsInterface;->registerForAvailable(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 236
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCi:[Lcom/android/internal/telephony/CommandsInterface;

    aget-object v2, v2, v1

    const/16 v3, 0xa

    invoke-interface {v2, p0, v3, v7}, Lcom/android/internal/telephony/CommandsInterface;->registerForModemCapEvent(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 234
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 239
    :cond_0
    const/4 v1, 0x0

    :goto_1
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v1, v2, :cond_1

    .line 240
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mPreferredStackId:[I

    aput v1, v2, v1

    .line 241
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    aput v1, v2, v1

    .line 242
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mSubState:[I

    aput v6, v2, v1

    .line 243
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCmdFailed:[Z

    aput-boolean v5, v2, v1

    .line 239
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 247
    :cond_1
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ne v2, v6, :cond_2

    iput-boolean v6, p0, Lcom/android/internal/telephony/ModemStackController;->mIsStackReady:Z

    .line 249
    :cond_2
    new-instance v0, Landroid/content/IntentFilter;

    const-string v2, "android.intent.action.EMERGENCY_CALLBACK_MODE_CHANGED"

    invoke-direct {v0, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 251
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v2, "android.intent.action.ACTION_SUBINFO_CONTENT_CHANGE"

    invoke-virtual {v0, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 252
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mContext:Landroid/content/Context;

    iget-object v3, p0, Lcom/android/internal/telephony/ModemStackController;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v2, v3, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 253
    const-string v2, "Constructor - Exit"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 254
    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/ModemStackController;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/ModemStackController;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 83
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$102(Lcom/android/internal/telephony/ModemStackController;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/ModemStackController;
    .param p1, "x1"    # Z

    .prologue
    .line 83
    iput-boolean p1, p0, Lcom/android/internal/telephony/ModemStackController;->mIsPhoneInEcbmMode:Z

    return p1
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/ModemStackController;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/ModemStackController;

    .prologue
    .line 83
    iget-boolean v0, p0, Lcom/android/internal/telephony/ModemStackController;->mDeactivationInProgress:Z

    return v0
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/ModemStackController;)Ljava/util/HashMap;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/ModemStackController;

    .prologue
    .line 83
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mSubcriptionStatus:Ljava/util/HashMap;

    return-object v0
.end method

.method private areAllSubsinSameState(I)Z
    .locals 6
    .param p1, "state"    # I

    .prologue
    .line 531
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mSubState:[I

    .local v0, "arr$":[I
    array-length v2, v0

    .local v2, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_0
    if-ge v1, v2, :cond_1

    aget v3, v0, v1

    .line 532
    .local v3, "subState":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "areAllSubsinSameState state= "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " substate="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 533
    if-eq v3, p1, :cond_0

    const/4 v4, 0x0

    .line 535
    .end local v3    # "subState":I
    :goto_1
    return v4

    .line 531
    .restart local v3    # "subState":I
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 535
    .end local v3    # "subState":I
    :cond_1
    const/4 v4, 0x1

    goto :goto_1
.end method

.method private bindStackOnSub(I)V
    .locals 4
    .param p1, "phoneId"    # I

    .prologue
    .line 425
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "bindStack "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mPreferredStackId:[I

    aget v2, v2, p1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " On phoneId["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 426
    const/4 v1, 0x6

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, p1}, Ljava/lang/Integer;-><init>(I)V

    invoke-static {p0, v1, v2}, Landroid/os/Message;->obtain(Landroid/os/Handler;ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .line 427
    .local v0, "msg":Landroid/os/Message;
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mCi:[Lcom/android/internal/telephony/CommandsInterface;

    aget-object v1, v1, p1

    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mPreferredStackId:[I

    aget v2, v2, p1

    const/4 v3, 0x1

    invoke-interface {v1, v2, v3, v0}, Lcom/android/internal/telephony/CommandsInterface;->updateStackBinding(IILandroid/os/Message;)V

    .line 428
    return-void
.end method

.method private deactivateAllSubscriptions()V
    .locals 10

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 708
    invoke-static {}, Lcom/android/internal/telephony/SubscriptionController;->getInstance()Lcom/android/internal/telephony/SubscriptionController;

    move-result-object v1

    .line 709
    .local v1, "subCtrlr":Lcom/android/internal/telephony/SubscriptionController;
    invoke-virtual {v1}, Lcom/android/internal/telephony/SubscriptionController;->getActiveSubInfoList()Ljava/util/List;

    move-result-object v3

    .line 710
    .local v3, "subInfoList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    iput v8, p0, Lcom/android/internal/telephony/ModemStackController;->mActiveSubCount:I

    .line 711
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/telephony/SubInfoRecord;

    .line 712
    .local v2, "subInfo":Landroid/telephony/SubInfoRecord;
    iget-wide v6, v2, Landroid/telephony/SubInfoRecord;->subId:J

    invoke-virtual {v1, v6, v7}, Lcom/android/internal/telephony/SubscriptionController;->getSubState(J)I

    move-result v4

    .line 713
    .local v4, "subStatus":I
    if-ne v4, v9, :cond_0

    .line 714
    iget v5, p0, Lcom/android/internal/telephony/ModemStackController;->mActiveSubCount:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/android/internal/telephony/ModemStackController;->mActiveSubCount:I

    .line 715
    iget-wide v6, v2, Landroid/telephony/SubInfoRecord;->subId:J

    invoke-virtual {v1, v6, v7}, Lcom/android/internal/telephony/SubscriptionController;->deactivateSubId(J)V

    .line 717
    :cond_0
    iget-object v5, p0, Lcom/android/internal/telephony/ModemStackController;->mSubcriptionStatus:Ljava/util/HashMap;

    iget v6, v2, Landroid/telephony/SubInfoRecord;->slotId:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v5, v6, v7}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 719
    .end local v2    # "subInfo":Landroid/telephony/SubInfoRecord;
    .end local v4    # "subStatus":I
    :cond_1
    iget v5, p0, Lcom/android/internal/telephony/ModemStackController;->mActiveSubCount:I

    if-lez v5, :cond_2

    .line 720
    iput v8, p0, Lcom/android/internal/telephony/ModemStackController;->mDeactivedSubCount:I

    .line 721
    iput-boolean v9, p0, Lcom/android/internal/telephony/ModemStackController;->mDeactivationInProgress:Z

    .line 726
    :goto_1
    return-void

    .line 723
    :cond_2
    iput-boolean v8, p0, Lcom/android/internal/telephony/ModemStackController;->mDeactivationInProgress:Z

    .line 724
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->triggerUnBindingOnAllSubs()V

    goto :goto_1
.end method

.method public static getInstance()Lcom/android/internal/telephony/ModemStackController;
    .locals 2

    .prologue
    .line 219
    sget-object v0, Lcom/android/internal/telephony/ModemStackController;->sModemStackController:Lcom/android/internal/telephony/ModemStackController;

    if-nez v0, :cond_0

    .line 220
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "ModemStackController.getInstance called before make()"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 222
    :cond_0
    sget-object v0, Lcom/android/internal/telephony/ModemStackController;->sModemStackController:Lcom/android/internal/telephony/ModemStackController;

    return-object v0
.end method

.method private isAnyCallsInProgress()Z
    .locals 6

    .prologue
    .line 610
    const/4 v1, 0x0

    .line 611
    .local v1, "isCallInProgress":Z
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v0, v2, :cond_0

    .line 612
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v2

    int-to-long v4, v0

    invoke-virtual {v2, v4, v5}, Landroid/telephony/TelephonyManager;->getCallState(J)I

    move-result v2

    if-eqz v2, :cond_1

    .line 614
    const/4 v1, 0x1

    .line 618
    :cond_0
    return v1

    .line 611
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private isAnyCmdFailed()Z
    .locals 3

    .prologue
    .line 546
    const/4 v1, 0x0

    .line 547
    .local v1, "result":Z
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v0, v2, :cond_1

    .line 548
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCmdFailed:[Z

    aget-boolean v2, v2, v0

    if-eqz v2, :cond_0

    .line 549
    const/4 v1, 0x1

    .line 547
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 552
    :cond_1
    return v1
.end method

.method private logd(Ljava/lang/String;)V
    .locals 1
    .param p1, "string"    # Ljava/lang/String;

    .prologue
    .line 815
    const-string v0, "ModemStackController"

    invoke-static {v0, p1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 816
    return-void
.end method

.method private loge(Ljava/lang/String;)V
    .locals 1
    .param p1, "string"    # Ljava/lang/String;

    .prologue
    .line 819
    const-string v0, "ModemStackController"

    invoke-static {v0, p1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 820
    return-void
.end method

.method public static make(Landroid/content/Context;Lcom/android/internal/telephony/uicc/UiccController;[Lcom/android/internal/telephony/CommandsInterface;)Lcom/android/internal/telephony/ModemStackController;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "uiccMgr"    # Lcom/android/internal/telephony/uicc/UiccController;
    .param p2, "ci"    # [Lcom/android/internal/telephony/CommandsInterface;

    .prologue
    .line 209
    const-string v0, "ModemStackController"

    const-string v1, "getInstance"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 210
    sget-object v0, Lcom/android/internal/telephony/ModemStackController;->sModemStackController:Lcom/android/internal/telephony/ModemStackController;

    if-nez v0, :cond_0

    .line 211
    new-instance v0, Lcom/android/internal/telephony/ModemStackController;

    invoke-direct {v0, p0, p1, p2}, Lcom/android/internal/telephony/ModemStackController;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/uicc/UiccController;[Lcom/android/internal/telephony/CommandsInterface;)V

    sput-object v0, Lcom/android/internal/telephony/ModemStackController;->sModemStackController:Lcom/android/internal/telephony/ModemStackController;

    .line 215
    sget-object v0, Lcom/android/internal/telephony/ModemStackController;->sModemStackController:Lcom/android/internal/telephony/ModemStackController;

    return-object v0

    .line 213
    :cond_0
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "ModemStackController.make() should only be called once"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private notifyModemDataCapabilitiesAvailable()V
    .locals 1

    .prologue
    .line 761
    const-string v0, "notifyGetDataCapabilitiesDone"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 762
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mModemDataCapsAvailableRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0}, Landroid/os/RegistrantList;->notifyRegistrants()V

    .line 763
    return-void
.end method

.method private notifyModemRatCapabilitiesAvailable()V
    .locals 1

    .prologue
    .line 755
    const-string v0, "notifyGetRatCapabilitiesDone: Got RAT capabilities for all Stacks!!!"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 756
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/ModemStackController;->mModemRatCapabilitiesAvailable:Z

    .line 757
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mModemRatCapsAvailableRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0}, Landroid/os/RegistrantList;->notifyRegistrants()V

    .line 758
    return-void
.end method

.method private notifyStackReady()V
    .locals 3

    .prologue
    .line 729
    const-string v1, "notifyStackReady: Stack is READY!!!"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 730
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/android/internal/telephony/ModemStackController;->mIsRecoveryInProgress:Z

    .line 731
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/android/internal/telephony/ModemStackController;->mIsStackReady:Z

    .line 732
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->resetSubStates()V

    .line 734
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v0, v1, :cond_0

    .line 736
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mPreferredStackId:[I

    aget v2, v2, v0

    aput v2, v1, v0

    .line 734
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 741
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mStackReadyRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1}, Landroid/os/RegistrantList;->notifyRegistrants()V

    .line 742
    return-void
.end method

.method private onBindComplete(Landroid/os/AsyncResult;I)V
    .locals 3
    .param p1, "ar"    # Landroid/os/AsyncResult;
    .param p2, "phoneId"    # I

    .prologue
    const/4 v2, 0x5

    .line 455
    iget-object v0, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    instance-of v0, v0, Lcom/android/internal/telephony/CommandException;

    if-eqz v0, :cond_0

    .line 456
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mCmdFailed:[Z

    const/4 v1, 0x1

    aput-boolean v1, v0, p2

    .line 457
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onBindComplete("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "): got Exception ="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    .line 460
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mSubState:[I

    aput v2, v0, p2

    .line 463
    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->areAllSubsinSameState(I)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 464
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->isAnyCmdFailed()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 465
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->recoverToPrevState()V

    .line 470
    :cond_1
    :goto_0
    return-void

    .line 468
    :cond_2
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->setPrefNwTypeOnAllSubs()V

    goto :goto_0
.end method

.method private onGetModemCapabilityDone(Landroid/os/AsyncResult;[BI)V
    .locals 3
    .param p1, "ar"    # Landroid/os/AsyncResult;
    .param p2, "result"    # [B
    .param p3, "phoneId"    # I

    .prologue
    const/4 v2, 0x2

    .line 349
    if-nez p2, :cond_1

    iget-object v0, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    instance-of v0, v0, Lcom/android/internal/telephony/CommandException;

    if-eqz v0, :cond_1

    .line 350
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onGetModemCapabilityDone: EXIT!, result null or Exception ="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    .line 353
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/ModemStackController;->mIsStackReady:Z

    .line 354
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mStackReadyRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v0}, Landroid/os/RegistrantList;->notifyRegistrants()V

    .line 372
    :cond_0
    :goto_0
    return-void

    .line 358
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onGetModemCapabilityDone on phoneId["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "] result = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 360
    if-ltz p3, :cond_2

    iget v0, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge p3, v0, :cond_2

    .line 362
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mSubState:[I

    aput v2, v0, p3

    .line 363
    invoke-direct {p0, p2, p3}, Lcom/android/internal/telephony/ModemStackController;->parseGetModemCapabilityResponse([BI)V

    .line 366
    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->areAllSubsinSameState(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 367
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->notifyModemRatCapabilitiesAvailable()V

    goto :goto_0

    .line 370
    :cond_2
    const-string v0, "Invalid Index!!!"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private onSetPrefNwModeDone(Landroid/os/AsyncResult;I)V
    .locals 3
    .param p1, "ar"    # Landroid/os/AsyncResult;
    .param p2, "phoneId"    # I

    .prologue
    const/4 v2, 0x7

    .line 473
    iget-object v0, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    instance-of v0, v0, Lcom/android/internal/telephony/CommandException;

    if-eqz v0, :cond_0

    .line 474
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mCmdFailed:[Z

    const/4 v1, 0x1

    aput-boolean v1, v0, p2

    .line 475
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onSetPrefNwModeDone(SUB:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "): got Exception ="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    .line 478
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mSubState:[I

    aput v2, v0, p2

    .line 481
    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->areAllSubsinSameState(I)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 482
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->isAnyCmdFailed()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 483
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->recoverToPrevState()V

    .line 494
    :cond_1
    :goto_0
    return-void

    .line 487
    :cond_2
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mUpdateStackMsg:Landroid/os/Message;

    if-eqz v0, :cond_3

    .line 488
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mUpdateStackMsg:Landroid/os/Message;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/android/internal/telephony/ModemStackController;->sendResponseToTarget(Landroid/os/Message;I)V

    .line 489
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mUpdateStackMsg:Landroid/os/Message;

    .line 491
    :cond_3
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->updateNetworkSelectionMode()V

    .line 492
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->notifyStackReady()V

    goto :goto_0
.end method

.method private onSubDeactivated(Landroid/os/AsyncResult;I)V
    .locals 6
    .param p1, "ar"    # Landroid/os/AsyncResult;
    .param p2, "phoneId"    # I

    .prologue
    const/4 v5, 0x3

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 394
    iget-object v0, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v0, Lcom/android/internal/telephony/Subscription$SubscriptionStatus;

    .line 395
    .local v0, "subStatus":Lcom/android/internal/telephony/Subscription$SubscriptionStatus;
    if-eqz v0, :cond_0

    if-eqz v0, :cond_1

    sget-object v1, Lcom/android/internal/telephony/Subscription$SubscriptionStatus;->SUB_DEACTIVATED:Lcom/android/internal/telephony/Subscription$SubscriptionStatus;

    if-eq v1, v0, :cond_1

    .line 397
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onSubDeactivated on phoneId["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] Failed!!!"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    .line 398
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mCmdFailed:[Z

    aput-boolean v4, v1, p2

    .line 401
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onSubDeactivated on phoneId["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] subStatus = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 404
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mSubState:[I

    aget v1, v1, p2

    if-ne v1, v5, :cond_3

    .line 422
    :cond_2
    :goto_0
    return-void

    .line 406
    :cond_3
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mSubState:[I

    aput v5, v1, p2

    .line 407
    iget v1, p0, Lcom/android/internal/telephony/ModemStackController;->mDeactivedSubCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/android/internal/telephony/ModemStackController;->mDeactivedSubCount:I

    .line 410
    iget v1, p0, Lcom/android/internal/telephony/ModemStackController;->mDeactivedSubCount:I

    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mActiveSubCount:I

    if-ne v1, v2, :cond_2

    .line 413
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->isAnyCmdFailed()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 414
    iput-boolean v3, p0, Lcom/android/internal/telephony/ModemStackController;->mIsRecoveryInProgress:Z

    .line 415
    iput-boolean v4, p0, Lcom/android/internal/telephony/ModemStackController;->mIsStackReady:Z

    .line 416
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mStackReadyRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1}, Landroid/os/RegistrantList;->notifyRegistrants()V

    goto :goto_0

    .line 418
    :cond_4
    iput-boolean v3, p0, Lcom/android/internal/telephony/ModemStackController;->mDeactivationInProgress:Z

    .line 419
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->triggerUnBindingOnAllSubs()V

    goto :goto_0
.end method

.method private onUnbindComplete(Landroid/os/AsyncResult;I)V
    .locals 3
    .param p1, "ar"    # Landroid/os/AsyncResult;
    .param p2, "phoneId"    # I

    .prologue
    const/4 v2, 0x4

    .line 437
    iget-object v0, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    instance-of v0, v0, Lcom/android/internal/telephony/CommandException;

    if-eqz v0, :cond_0

    .line 438
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mCmdFailed:[Z

    const/4 v1, 0x1

    aput-boolean v1, v0, p2

    .line 439
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onUnbindComplete("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "): got Exception ="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    .line 442
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mSubState:[I

    aput v2, v0, p2

    .line 445
    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->areAllSubsinSameState(I)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 446
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->isAnyCmdFailed()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 447
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->recoverToPrevState()V

    .line 452
    :cond_1
    :goto_0
    return-void

    .line 450
    :cond_2
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->triggerBindingOnAllSubs()V

    goto :goto_0
.end method

.method private onUnsolModemCapabilityChanged(Landroid/os/AsyncResult;)V
    .locals 5
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    .line 375
    const-string v3, "onUnsolModemCapabilityChanged"

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 376
    iget-object v2, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, Lcom/android/internal/telephony/RIL$UnsolOemHookBuffer;

    .line 378
    .local v2, "unsolOemHookBuffer":Lcom/android/internal/telephony/RIL$UnsolOemHookBuffer;
    if-nez v2, :cond_0

    iget-object v3, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    instance-of v3, v3, Lcom/android/internal/telephony/CommandException;

    if-eqz v3, :cond_0

    .line 379
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onUnsolModemCapabilityChanged: EXIT!, result null or Exception ="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    .line 391
    :goto_0
    return-void

    .line 383
    :cond_0
    invoke-virtual {v2}, Lcom/android/internal/telephony/RIL$UnsolOemHookBuffer;->getUnsolOemHookBuffer()[B

    move-result-object v0

    check-cast v0, [B

    .line 384
    .local v0, "data":[B
    invoke-virtual {v2}, Lcom/android/internal/telephony/RIL$UnsolOemHookBuffer;->getRilInstance()I

    move-result v1

    .line 386
    .local v1, "phoneId":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onUnsolModemCapabilityChanged on phoneId = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 388
    invoke-direct {p0, v0, v1}, Lcom/android/internal/telephony/ModemStackController;->parseGetModemCapabilityResponse([BI)V

    .line 389
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->notifyModemDataCapabilitiesAvailable()V

    goto :goto_0
.end method

.method private parseGetModemCapabilityResponse([BI)V
    .locals 8
    .param p1, "result"    # [B
    .param p2, "phoneId"    # I

    .prologue
    const/4 v7, 0x7

    .line 574
    array-length v0, p1

    if-eq v0, v7, :cond_0

    .line 575
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "parseGetModemCapabilityResponse: EXIT!, result length("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    array-length v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ") and Expected length("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ") not matching."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    .line 595
    :goto_0
    return-void

    .line 579
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "parseGetModemCapabilityResponse: buffer = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 580
    invoke-static {p1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v6

    .line 581
    .local v6, "respBuffer":Ljava/nio/ByteBuffer;
    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 583
    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->get()B

    move-result v2

    .line 585
    .local v2, "stackId":I
    if-ltz v2, :cond_1

    iget v0, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-lt v2, v0, :cond_2

    .line 586
    :cond_1
    const-string v0, "Invalid Index!!!"

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    goto :goto_0

    .line 589
    :cond_2
    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v3

    .line 590
    .local v3, "supportedRatBitMask":I
    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->get()B

    move-result v4

    .line 591
    .local v4, "voiceDataCap":I
    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->get()B

    move-result v5

    .local v5, "maxDataCap":I
    move-object v0, p0

    move v1, p2

    .line 593
    invoke-direct/range {v0 .. v5}, Lcom/android/internal/telephony/ModemStackController;->updateModemCapInfo(IIIII)V

    goto :goto_0
.end method

.method private processRadioAvailable(Landroid/os/AsyncResult;I)V
    .locals 3
    .param p1, "ar"    # Landroid/os/AsyncResult;
    .param p2, "phoneId"    # I

    .prologue
    .line 334
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "processRadioAvailable on phoneId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 336
    if-ltz p2, :cond_0

    iget v1, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge p2, v1, :cond_0

    .line 337
    const/4 v1, 0x2

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, p2}, Ljava/lang/Integer;-><init>(I)V

    invoke-static {p0, v1, v2}, Landroid/os/Message;->obtain(Landroid/os/Handler;ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .line 340
    .local v0, "getModemCapsMsg":Landroid/os/Message;
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mCi:[Lcom/android/internal/telephony/CommandsInterface;

    aget-object v1, v1, p2

    invoke-interface {v1, v0}, Lcom/android/internal/telephony/CommandsInterface;->getModemCapability(Landroid/os/Message;)V

    .line 345
    .end local v0    # "getModemCapsMsg":Landroid/os/Message;
    :goto_0
    return-void

    .line 343
    :cond_0
    const-string v1, "Invalid Index!!!"

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private recoverToPrevState()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 784
    iget-boolean v1, p0, Lcom/android/internal/telephony/ModemStackController;->mIsRecoveryInProgress:Z

    if-eqz v1, :cond_2

    .line 787
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mUpdateStackMsg:Landroid/os/Message;

    if-eqz v1, :cond_0

    .line 788
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mUpdateStackMsg:Landroid/os/Message;

    const/4 v2, 0x2

    invoke-direct {p0, v1, v2}, Lcom/android/internal/telephony/ModemStackController;->sendResponseToTarget(Landroid/os/Message;I)V

    .line 789
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mUpdateStackMsg:Landroid/os/Message;

    .line 791
    :cond_0
    iput-boolean v3, p0, Lcom/android/internal/telephony/ModemStackController;->mIsRecoveryInProgress:Z

    .line 792
    const/4 v1, 0x7

    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mSubState:[I

    aget v2, v2, v3

    if-ne v1, v2, :cond_1

    .line 795
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->notifyStackReady()V

    .line 806
    :cond_1
    :goto_0
    return-void

    .line 800
    :cond_2
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/android/internal/telephony/ModemStackController;->mIsRecoveryInProgress:Z

    .line 802
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    iget v1, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v0, v1, :cond_3

    .line 803
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mPreferredStackId:[I

    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    aget v2, v2, v0

    aput v2, v1, v0

    .line 802
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 805
    :cond_3
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->triggerUnBindingOnAllSubs()V

    goto :goto_0
.end method

.method private resetSubStates()V
    .locals 3

    .prologue
    .line 539
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v0, v1, :cond_0

    .line 540
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mSubState:[I

    const/4 v2, 0x1

    aput v2, v1, v0

    .line 541
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mCmdFailed:[Z

    const/4 v2, 0x0

    aput-boolean v2, v1, v0

    .line 539
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 543
    :cond_0
    return-void
.end method

.method private sendResponseToTarget(Landroid/os/Message;I)V
    .locals 2
    .param p1, "response"    # Landroid/os/Message;
    .param p2, "responseCode"    # I

    .prologue
    .line 809
    invoke-static {p2}, Lcom/android/internal/telephony/CommandException;->fromRilErrno(I)Lcom/android/internal/telephony/CommandException;

    move-result-object v0

    .line 810
    .local v0, "e":Ljava/lang/Exception;
    const/4 v1, 0x0

    invoke-static {p1, v1, v0}, Landroid/os/AsyncResult;->forMessage(Landroid/os/Message;Ljava/lang/Object;Ljava/lang/Throwable;)Landroid/os/AsyncResult;

    .line 811
    invoke-virtual {p1}, Landroid/os/Message;->sendToTarget()V

    .line 812
    return-void
.end method

.method private setPrefNwTypeOnAllSubs()V
    .locals 4

    .prologue
    .line 523
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->resetSubStates()V

    .line 524
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v0, v2, :cond_0

    .line 525
    const/4 v2, 0x7

    new-instance v3, Ljava/lang/Integer;

    invoke-direct {v3, v0}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {p0, v2, v3}, Lcom/android/internal/telephony/ModemStackController;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    .line 526
    .local v1, "resp":Landroid/os/Message;
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCi:[Lcom/android/internal/telephony/CommandsInterface;

    aget-object v2, v2, v0

    iget-object v3, p0, Lcom/android/internal/telephony/ModemStackController;->mPrefNwMode:[I

    aget v3, v3, v0

    invoke-interface {v2, v3, v1}, Lcom/android/internal/telephony/CommandsInterface;->setPreferredNetworkType(ILandroid/os/Message;)V

    .line 524
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 528
    .end local v1    # "resp":Landroid/os/Message;
    :cond_0
    return-void
.end method

.method private syncPreferredNwModeFromDB()V
    .locals 5

    .prologue
    .line 598
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v2, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v0, v2, :cond_0

    .line 600
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mPrefNwMode:[I

    iget-object v3, p0, Lcom/android/internal/telephony/ModemStackController;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "preferred_network_mode"

    invoke-static {v3, v4, v0}, Landroid/telephony/TelephonyManager;->getIntAtIndex(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v3

    aput v3, v2, v0
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 598
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 602
    :catch_0
    move-exception v1

    .line 603
    .local v1, "snfe":Landroid/provider/Settings$SettingNotFoundException;
    const-string v2, "getPreferredNetworkMode: Could not find PREFERRED_NETWORK_MODE!!!"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    .line 604
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mPrefNwMode:[I

    sget v3, Lcom/android/internal/telephony/Phone;->PREFERRED_NT_MODE:I

    aput v3, v2, v0

    goto :goto_1

    .line 607
    .end local v1    # "snfe":Landroid/provider/Settings$SettingNotFoundException;
    :cond_0
    return-void
.end method

.method private triggerBindingOnAllSubs()V
    .locals 3

    .prologue
    .line 510
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->resetSubStates()V

    .line 511
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v0, v1, :cond_0

    .line 512
    const/4 v1, 0x5

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, v0}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {p0, v1, v2}, Lcom/android/internal/telephony/ModemStackController;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ModemStackController;->sendMessage(Landroid/os/Message;)Z

    .line 511
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 514
    :cond_0
    return-void
.end method

.method private triggerDeactivationOnAllSubs()V
    .locals 1

    .prologue
    .line 517
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->resetSubStates()V

    .line 518
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->sendMessage(Landroid/os/Message;)Z

    .line 519
    return-void
.end method

.method private triggerUnBindingOnAllSubs()V
    .locals 3

    .prologue
    .line 503
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->resetSubStates()V

    .line 504
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v0, v1, :cond_0

    .line 505
    const/4 v1, 0x3

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, v0}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {p0, v1, v2}, Lcom/android/internal/telephony/ModemStackController;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/ModemStackController;->sendMessage(Landroid/os/Message;)Z

    .line 504
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 507
    :cond_0
    return-void
.end method

.method private unbindStackOnSub(I)V
    .locals 4
    .param p1, "phoneId"    # I

    .prologue
    .line 431
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unbindStack "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    aget v2, v2, p1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " On phoneId["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 432
    const/4 v1, 0x4

    new-instance v2, Ljava/lang/Integer;

    invoke-direct {v2, p1}, Ljava/lang/Integer;-><init>(I)V

    invoke-static {p0, v1, v2}, Landroid/os/Message;->obtain(Landroid/os/Handler;ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .line 433
    .local v0, "msg":Landroid/os/Message;
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mCi:[Lcom/android/internal/telephony/CommandsInterface;

    aget-object v1, v1, p1

    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    aget v2, v2, p1

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3, v0}, Lcom/android/internal/telephony/CommandsInterface;->updateStackBinding(IILandroid/os/Message;)V

    .line 434
    return-void
.end method

.method private updateModemCapInfo(IIIII)V
    .locals 8
    .param p1, "phoneId"    # I
    .param p2, "stackId"    # I
    .param p3, "supportedRatBitMask"    # I
    .param p4, "voiceDataCap"    # I
    .param p5, "maxDataCap"    # I

    .prologue
    .line 558
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    aput p2, v0, p1

    .line 560
    iget-object v6, p0, Lcom/android/internal/telephony/ModemStackController;->mModemCapInfo:[Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;

    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    aget v7, v0, p1

    new-instance v0, Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;

    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    aget v2, v1, p1

    move-object v1, p0

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-direct/range {v0 .. v5}, Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;-><init>(Lcom/android/internal/telephony/ModemStackController;IIII)V

    aput-object v0, v6, v7

    .line 562
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "updateModemCapInfo: ModemCaps["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mModemCapInfo:[Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;

    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    aget v2, v2, p1

    aget-object v1, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 566
    return-void
.end method

.method private updateNetworkSelectionMode()V
    .locals 3

    .prologue
    .line 497
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v0, v1, :cond_0

    .line 498
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mCi:[Lcom/android/internal/telephony/CommandsInterface;

    aget-object v1, v1, v0

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Lcom/android/internal/telephony/CommandsInterface;->setNetworkSelectionModeAutomatic(Landroid/os/Message;)V

    .line 497
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 500
    :cond_0
    return-void
.end method


# virtual methods
.method public getCurrentStackIdForPhoneId(I)I
    .locals 1
    .param p1, "phoneId"    # I

    .prologue
    .line 645
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    aget v0, v0, p1

    return v0
.end method

.method public getMaxDataAllowed()I
    .locals 5

    .prologue
    .line 626
    const-string v3, "getMaxDataAllowed"

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 629
    :try_start_0
    new-instance v2, Ljava/util/ArrayList;

    iget v3, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    .line 631
    .local v2, "unsortedList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget v3, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v1, v3, :cond_0

    .line 632
    iget-object v3, p0, Lcom/android/internal/telephony/ModemStackController;->mModemCapInfo:[Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;

    aget-object v3, v3, v1

    invoke-virtual {v3}, Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;->getMaxDataCap()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 631
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 634
    :cond_0
    invoke-static {v2}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    .line 636
    iget v3, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    add-int/lit8 v3, v3, -0x1

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 639
    .end local v1    # "i":I
    .end local v2    # "unsortedList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    :goto_1
    return v3

    .line 637
    :catch_0
    move-exception v0

    .line 638
    .local v0, "e":Ljava/lang/Exception;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getMaxDataAllowed e = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 639
    const/4 v3, -0x1

    goto :goto_1
.end method

.method public getModemRatCapsForPhoneId(I)Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;
    .locals 2
    .param p1, "phoneId"    # I

    .prologue
    .line 658
    iget-object v0, p0, Lcom/android/internal/telephony/ModemStackController;->mModemCapInfo:[Lcom/android/internal/telephony/ModemStackController$ModemCapabilityInfo;

    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    aget v1, v1, p1

    aget-object v0, v0, v1

    return-object v0
.end method

.method public getPrimarySub()I
    .locals 2

    .prologue
    .line 649
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v0, v1, :cond_1

    .line 650
    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->getCurrentStackIdForPhoneId(I)I

    move-result v1

    if-nez v1, :cond_0

    .line 654
    .end local v0    # "i":I
    :goto_1
    return v0

    .line 649
    .restart local v0    # "i":I
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 654
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 261
    iget v2, p1, Landroid/os/Message;->what:I

    packed-switch v2, :pswitch_data_0

    .line 331
    :goto_0
    return-void

    .line 263
    :pswitch_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 264
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Integer;

    .line 265
    .local v1, "phoneId":Ljava/lang/Integer;
    const-string v2, "EVENT_RADIO_AVAILABLE"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 266
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-direct {p0, v0, v2}, Lcom/android/internal/telephony/ModemStackController;->processRadioAvailable(Landroid/os/AsyncResult;I)V

    goto :goto_0

    .line 270
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v1    # "phoneId":Ljava/lang/Integer;
    :pswitch_1
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 271
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Integer;

    .line 272
    .restart local v1    # "phoneId":Ljava/lang/Integer;
    const-string v2, "EVENT_GET_MODEM_CAPS_DONE"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 273
    iget-object v2, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, [B

    check-cast v2, [B

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v3

    invoke-direct {p0, v0, v2, v3}, Lcom/android/internal/telephony/ModemStackController;->onGetModemCapabilityDone(Landroid/os/AsyncResult;[BI)V

    goto :goto_0

    .line 277
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v1    # "phoneId":Ljava/lang/Integer;
    :pswitch_2
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 278
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EVENT_MODEM_CAPABILITY_CHANGED ar ="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 279
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/ModemStackController;->onUnsolModemCapabilityChanged(Landroid/os/AsyncResult;)V

    goto :goto_0

    .line 283
    .end local v0    # "ar":Landroid/os/AsyncResult;
    :pswitch_3
    const-string v2, "CMD_DEACTIVATE_ALL_SUBS"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 284
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->deactivateAllSubscriptions()V

    goto :goto_0

    .line 288
    :pswitch_4
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 289
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Integer;

    .line 290
    .restart local v1    # "phoneId":Ljava/lang/Integer;
    const-string v2, "EVENT_SUB_DEACTIVATED"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 291
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-direct {p0, v0, v2}, Lcom/android/internal/telephony/ModemStackController;->onSubDeactivated(Landroid/os/AsyncResult;I)V

    goto :goto_0

    .line 295
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v1    # "phoneId":Ljava/lang/Integer;
    :pswitch_5
    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Integer;

    .line 296
    .restart local v1    # "phoneId":Ljava/lang/Integer;
    const-string v2, "CMD_TRIGGER_UNBIND"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 297
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->unbindStackOnSub(I)V

    goto :goto_0

    .line 301
    .end local v1    # "phoneId":Ljava/lang/Integer;
    :pswitch_6
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 302
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Integer;

    .line 303
    .restart local v1    # "phoneId":Ljava/lang/Integer;
    const-string v2, "EVENT_UNBIND_DONE"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 304
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-direct {p0, v0, v2}, Lcom/android/internal/telephony/ModemStackController;->onUnbindComplete(Landroid/os/AsyncResult;I)V

    goto/16 :goto_0

    .line 308
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v1    # "phoneId":Ljava/lang/Integer;
    :pswitch_7
    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Integer;

    .line 309
    .restart local v1    # "phoneId":Ljava/lang/Integer;
    const-string v2, "CMD_TRIGGER_BIND"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 310
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->bindStackOnSub(I)V

    goto/16 :goto_0

    .line 314
    .end local v1    # "phoneId":Ljava/lang/Integer;
    :pswitch_8
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 315
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Integer;

    .line 316
    .restart local v1    # "phoneId":Ljava/lang/Integer;
    const-string v2, "EVENT_BIND_DONE"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 317
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-direct {p0, v0, v2}, Lcom/android/internal/telephony/ModemStackController;->onBindComplete(Landroid/os/AsyncResult;I)V

    goto/16 :goto_0

    .line 321
    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v1    # "phoneId":Ljava/lang/Integer;
    :pswitch_9
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 322
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/Integer;

    .line 323
    .restart local v1    # "phoneId":Ljava/lang/Integer;
    const-string v2, "EVENT_SET_PREF_MODE_DONE"

    invoke-direct {p0, v2}, Lcom/android/internal/telephony/ModemStackController;->logd(Ljava/lang/String;)V

    .line 324
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-direct {p0, v0, v2}, Lcom/android/internal/telephony/ModemStackController;->onSetPrefNwModeDone(Landroid/os/AsyncResult;I)V

    goto/16 :goto_0

    .line 261
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_1
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_9
        :pswitch_4
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method public isStackReady()Z
    .locals 1

    .prologue
    .line 622
    iget-boolean v0, p0, Lcom/android/internal/telephony/ModemStackController;->mIsStackReady:Z

    return v0
.end method

.method public registerForModemDataCapsUpdate(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 3
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 776
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 778
    .local v0, "r":Landroid/os/Registrant;
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mModemDataCapsAvailableRegistrants:Landroid/os/RegistrantList;

    monitor-enter v2

    .line 779
    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mModemDataCapsAvailableRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 780
    monitor-exit v2

    .line 781
    return-void

    .line 780
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public registerForModemRatCapsAvailable(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 3
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 766
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 767
    .local v0, "r":Landroid/os/Registrant;
    iget-boolean v1, p0, Lcom/android/internal/telephony/ModemStackController;->mModemRatCapabilitiesAvailable:Z

    if-eqz v1, :cond_0

    .line 768
    invoke-virtual {v0}, Landroid/os/Registrant;->notifyRegistrant()V

    .line 770
    :cond_0
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mModemRatCapsAvailableRegistrants:Landroid/os/RegistrantList;

    monitor-enter v2

    .line 771
    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mModemRatCapsAvailableRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 772
    monitor-exit v2

    .line 773
    return-void

    .line 772
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public registerForStackReady(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 3
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    .line 745
    new-instance v0, Landroid/os/Registrant;

    invoke-direct {v0, p1, p2, p3}, Landroid/os/Registrant;-><init>(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 746
    .local v0, "r":Landroid/os/Registrant;
    iget-boolean v1, p0, Lcom/android/internal/telephony/ModemStackController;->mIsStackReady:Z

    if-eqz v1, :cond_0

    .line 747
    invoke-virtual {v0}, Landroid/os/Registrant;->notifyRegistrant()V

    .line 749
    :cond_0
    iget-object v2, p0, Lcom/android/internal/telephony/ModemStackController;->mStackReadyRegistrants:Landroid/os/RegistrantList;

    monitor-enter v2

    .line 750
    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/ModemStackController;->mStackReadyRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1, v0}, Landroid/os/RegistrantList;->add(Landroid/os/Registrant;)V

    .line 751
    monitor-exit v2

    .line 752
    return-void

    .line 751
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public updateStackBinding([IZLandroid/os/Message;)I
    .locals 7
    .param p1, "prefStackIds"    # [I
    .param p2, "isBootUp"    # Z
    .param p3, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 662
    const/4 v2, 0x0

    .line 663
    .local v2, "isUpdateRequired":Z
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->isAnyCallsInProgress()Z

    move-result v0

    .line 665
    .local v0, "callInProgress":Z
    iget v5, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ne v5, v4, :cond_1

    .line 666
    const-string v4, "No need to update Stack Binding in case of Single Sim."

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    .line 704
    :cond_0
    :goto_0
    return v3

    .line 670
    :cond_1
    if-nez v0, :cond_2

    iget-boolean v5, p0, Lcom/android/internal/telephony/ModemStackController;->mIsPhoneInEcbmMode:Z

    if-nez v5, :cond_2

    iget-boolean v5, p0, Lcom/android/internal/telephony/ModemStackController;->mIsStackReady:Z

    if-nez v5, :cond_3

    if-nez p2, :cond_3

    .line 671
    :cond_2
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "updateStackBinding: Calls is progress = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", mIsPhoneInEcbmMode = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-boolean v5, p0, Lcom/android/internal/telephony/ModemStackController;->mIsPhoneInEcbmMode:Z

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", mIsStackReady = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-boolean v5, p0, Lcom/android/internal/telephony/ModemStackController;->mIsStackReady:Z

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ". So EXITING!!!"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/ModemStackController;->loge(Ljava/lang/String;)V

    goto :goto_0

    .line 676
    :cond_3
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    iget v5, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v1, v5, :cond_4

    .line 677
    iget-object v5, p0, Lcom/android/internal/telephony/ModemStackController;->mPreferredStackId:[I

    aget v6, p1, v1

    aput v6, v5, v1

    .line 676
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 680
    :cond_4
    const/4 v1, 0x0

    :goto_2
    iget v5, p0, Lcom/android/internal/telephony/ModemStackController;->mNumPhones:I

    if-ge v1, v5, :cond_5

    .line 681
    iget-object v5, p0, Lcom/android/internal/telephony/ModemStackController;->mPreferredStackId:[I

    aget v5, v5, v1

    iget-object v6, p0, Lcom/android/internal/telephony/ModemStackController;->mCurrentStackId:[I

    aget v6, v6, v1

    if-eq v5, v6, :cond_6

    .line 683
    const/4 v2, 0x1

    .line 688
    :cond_5
    if-eqz v2, :cond_8

    .line 689
    iput-boolean v3, p0, Lcom/android/internal/telephony/ModemStackController;->mIsStackReady:Z

    .line 691
    iput-object p3, p0, Lcom/android/internal/telephony/ModemStackController;->mUpdateStackMsg:Landroid/os/Message;

    .line 693
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->syncPreferredNwModeFromDB()V

    .line 694
    if-eqz p2, :cond_7

    .line 695
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->triggerUnBindingOnAllSubs()V

    :goto_3
    move v3, v4

    .line 704
    goto :goto_0

    .line 680
    :cond_6
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 697
    :cond_7
    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->triggerDeactivationOnAllSubs()V

    goto :goto_3

    .line 701
    :cond_8
    if-eqz p2, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/ModemStackController;->notifyStackReady()V

    goto :goto_0
.end method