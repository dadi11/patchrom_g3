.class public Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;
.super Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTracker;
.source "CdmaLteServiceStateTrackerEx.java"


# static fields
.field private static final ACTION_CTC_TDD_CHECK:Ljava/lang/String; = "com.lge.CTC_TDD_CHECK"

.field protected static final EVENT_CT_SET_TDD_STATUS:I = 0x44d


# instance fields
.field private mConnMgr:Landroid/net/ConnectivityManager;

.field private mIntentReceiver:Landroid/content/BroadcastReceiver;

.field private mTddIntent:Landroid/app/PendingIntent;

.field private mTddNoSVCDialog:Landroid/app/AlertDialog;

.field private mTddNoSVCTimeout:I


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/cdma/CDMALTEPhone;)V
    .locals 3
    .param p1, "phone"    # Lcom/android/internal/telephony/cdma/CDMALTEPhone;

    .prologue
    .line 61
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTracker;-><init>(Lcom/android/internal/telephony/cdma/CDMALTEPhone;)V

    .line 45
    const v1, 0x2bf20

    iput v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCTimeout:I

    .line 46
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddIntent:Landroid/app/PendingIntent;

    .line 49
    new-instance v1, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx$1;

    invoke-direct {v1, p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx$1;-><init>(Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;)V

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    .line 64
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "connectivity"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/ConnectivityManager;

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mConnMgr:Landroid/net/ConnectivityManager;

    .line 65
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 66
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "com.lge.CTC_TDD_CHECK"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 67
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 69
    return-void
.end method

.method static synthetic access$002(Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;Landroid/app/PendingIntent;)Landroid/app/PendingIntent;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;
    .param p1, "x1"    # Landroid/app/PendingIntent;

    .prologue
    .line 38
    iput-object p1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddIntent:Landroid/app/PendingIntent;

    return-object p1
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;

    .prologue
    .line 38
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->displayTDDNoSVCDuring3min()V

    return-void
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;

    .prologue
    .line 38
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->setTddCheckAlarm()V

    return-void
.end method

.method static synthetic access$300(Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;)I
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;

    .prologue
    .line 38
    iget v0, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCTimeout:I

    return v0
.end method

.method static synthetic access$400(Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;)Landroid/app/AlertDialog;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCDialog:Landroid/app/AlertDialog;

    return-object v0
.end method

.method static synthetic access$402(Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;Landroid/app/AlertDialog;)Landroid/app/AlertDialog;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;
    .param p1, "x1"    # Landroid/app/AlertDialog;

    .prologue
    .line 38
    iput-object p1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCDialog:Landroid/app/AlertDialog;

    return-object p1
.end method

.method private cancelTddCheckAlarm()V
    .locals 3

    .prologue
    .line 178
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "alarm"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 179
    .local v0, "am":Landroid/app/AlarmManager;
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddIntent:Landroid/app/PendingIntent;

    invoke-virtual {v0, v1}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 180
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddIntent:Landroid/app/PendingIntent;

    .line 181
    return-void
.end method

.method private displayTDDNoSVCDuring3min()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 184
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "use_4g_single_data_network_onoff"

    invoke-static {v1, v2, v4}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 187
    .local v0, "tddStatus":I
    if-nez v0, :cond_1

    .line 220
    :cond_0
    :goto_0
    return-void

    .line 190
    :cond_1
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCDialog:Landroid/app/AlertDialog;

    if-nez v1, :cond_0

    .line 193
    const-string v1, "CTC : displayTDDNoSVCDuring3min "

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 194
    new-instance v1, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_Alert:I

    invoke-direct {v1, v2, v3}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    sget v2, Lcom/lge/internal/R$string;->tdd_nosvc_popup_title:I

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    sget v2, Lcom/lge/internal/R$string;->alert_dialog_yes:I

    new-instance v3, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx$3;

    invoke-direct {v3, p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx$3;-><init>(Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    sget v2, Lcom/lge/internal/R$string;->alert_dialog_no:I

    new-instance v3, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx$2;

    invoke-direct {v3, p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx$2;-><init>(Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const v2, 0x1010355

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setIconAttribute(I)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCDialog:Landroid/app/AlertDialog;

    .line 215
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCDialog:Landroid/app/AlertDialog;

    if-eqz v1, :cond_0

    .line 216
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCDialog:Landroid/app/AlertDialog;

    invoke-virtual {v1, v4}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 217
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCDialog:Landroid/app/AlertDialog;

    invoke-virtual {v1}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    const/16 v2, 0x7d3

    invoke-virtual {v1, v2}, Landroid/view/Window;->setType(I)V

    .line 218
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCDialog:Landroid/app/AlertDialog;

    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    goto :goto_0
.end method

.method private setTddCheckAlarm()V
    .locals 8

    .prologue
    const/4 v4, 0x0

    .line 171
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "alarm"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 172
    .local v0, "am":Landroid/app/AlarmManager;
    new-instance v1, Landroid/content/Intent;

    const-string v2, "com.lge.CTC_TDD_CHECK"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 173
    .local v1, "intent":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, v4, v1, v4}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v2

    iput-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddIntent:Landroid/app/PendingIntent;

    .line 174
    const/4 v2, 0x2

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    iget v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCTimeout:I

    int-to-long v6, v3

    add-long/2addr v4, v6

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddIntent:Landroid/app/PendingIntent;

    invoke-virtual {v0, v2, v4, v5, v3}, Landroid/app/AlarmManager;->setExact(IJLandroid/app/PendingIntent;)V

    .line 175
    return-void
.end method


# virtual methods
.method protected checkDataStateforTddPopup(I)V
    .locals 7
    .param p1, "dataRegState"    # I

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 145
    const-string v3, "CTC"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v3}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v3

    invoke-virtual {v3}, Lcom/android/internal/telephony/CommandsInterface$RadioState;->isOn()Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mConnMgr:Landroid/net/ConnectivityManager;

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mConnMgr:Landroid/net/ConnectivityManager;

    invoke-virtual {v3}, Landroid/net/ConnectivityManager;->getMobileDataEnabled()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 147
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "use_4g_single_data_network_onoff"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    .line 150
    .local v2, "tddStatus":I
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "use_4g_network_onoff"

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 153
    .local v0, "lteStatus":I
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3, v5}, Landroid/telephony/TelephonyManager;->getSimState(I)I

    move-result v1

    .line 154
    .local v1, "simState":I
    if-ne v2, v6, :cond_2

    if-ne v0, v6, :cond_2

    const/4 v3, 0x5

    if-ne v1, v3, :cond_2

    .line 155
    if-eqz p1, :cond_1

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddIntent:Landroid/app/PendingIntent;

    if-nez v3, :cond_1

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCDialog:Landroid/app/AlertDialog;

    if-nez v3, :cond_1

    .line 156
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->setTddCheckAlarm()V

    .line 157
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CTC : start TDD single lte no svc timer "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddNoSVCTimeout:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 168
    .end local v0    # "lteStatus":I
    .end local v1    # "simState":I
    .end local v2    # "tddStatus":I
    :cond_0
    :goto_0
    return-void

    .line 158
    .restart local v0    # "lteStatus":I
    .restart local v1    # "simState":I
    .restart local v2    # "tddStatus":I
    :cond_1
    if-nez p1, :cond_0

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddIntent:Landroid/app/PendingIntent;

    if-eqz v3, :cond_0

    .line 159
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->cancelTddCheckAlarm()V

    .line 160
    const-string v3, "CTC : stop TDD single lte no svc timer, now in svc"

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 162
    :cond_2
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mTddIntent:Landroid/app/PendingIntent;

    if-eqz v3, :cond_0

    .line 163
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->cancelTddCheckAlarm()V

    .line 164
    const-string v3, "CTC : stop TDD single lte no svc timer, now not TDD"

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method protected clearLteRejectCauseWithDataLGU(Z)V
    .locals 5
    .param p1, "hasCdmaDataConnectionAttached"    # Z

    .prologue
    .line 92
    const/4 v3, 0x0

    const-string v4, "lgu_global_roaming"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    if-eqz p1, :cond_0

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getRilDataRadioTechnology()I

    move-result v3

    const/16 v4, 0xe

    if-ne v3, v4, :cond_0

    .line 96
    const-string v3, "gsm.lge.lte_reject_cause"

    const-string v4, "0"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 99
    .local v1, "lteEmmRejectCause":Ljava/lang/String;
    const-string v3, "0"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 101
    const-string v3, "gsm.lge.lte_reject_cause"

    const-string v4, "0"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 102
    const-string v3, "LTE data in-service : set no U+ LTE reject cause "

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 104
    new-instance v0, Landroid/content/Intent;

    const-string v3, "com.lge.intent.action.LTE_EMM_REJECT"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 105
    .local v0, "intent":Landroid/content/Intent;
    const-string v3, "rejectCode"

    const/4 v4, 0x0

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 106
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3, v0}, Landroid/content/Context;->sendStickyBroadcast(Landroid/content/Intent;)V

    .line 107
    const-string v3, "persist.radio.last_ltereject"

    const-string v4, "0"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 110
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v3

    const-string v4, "notification"

    invoke-virtual {v3, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/NotificationManager;

    .line 111
    .local v2, "notificationManager":Landroid/app/NotificationManager;
    const v3, 0xc73b

    invoke-virtual {v2, v3}, Landroid/app/NotificationManager;->cancel(I)V

    .line 114
    .end local v0    # "intent":Landroid/content/Intent;
    .end local v1    # "lteEmmRejectCause":Ljava/lang/String;
    .end local v2    # "notificationManager":Landroid/app/NotificationManager;
    :cond_0
    return-void
.end method

.method public dispose()V
    .locals 2

    .prologue
    .line 74
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_0

    .line 75
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 77
    :cond_0
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTracker;->dispose()V

    .line 78
    return-void
.end method

.method protected firstUpdateSpnDisplyKR()V
    .locals 2

    .prologue
    .line 83
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mFirstUpdateSpn:Z

    if-nez v0, :cond_0

    const-string v0, "KR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 84
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mFirstUpdateSpn= "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mFirstUpdateSpn:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 85
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->updateSpnDisplay()V

    .line 87
    :cond_0
    return-void
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 228
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-boolean v1, v1, Lcom/android/internal/telephony/cdma/CDMAPhone;->mIsTheCurrentActivePhone:Z

    if-nez v1, :cond_2

    .line 229
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Received message "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " while being destroyed. Ignoring."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->loge(Ljava/lang/String;)V

    .line 232
    if-eqz p1, :cond_0

    iget v1, p1, Landroid/os/Message;->what:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_0

    .line 233
    invoke-super {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTracker;->handleMessage(Landroid/os/Message;)V

    .line 237
    :cond_0
    iget v1, p1, Landroid/os/Message;->what:I

    const/16 v2, 0x2b

    if-ne v1, v2, :cond_1

    .line 238
    invoke-super {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTracker;->handleMessage(Landroid/os/Message;)V

    .line 263
    :cond_1
    :goto_0
    return-void

    .line 244
    :cond_2
    iget v1, p1, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_0

    .line 260
    invoke-super {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTracker;->handleMessage(Landroid/os/Message;)V

    goto :goto_0

    .line 247
    :pswitch_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 248
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v1, :cond_3

    .line 249
    const-string v1, "CTC : received EVENT_CT_SET_TDD_STATUS error again popup"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 250
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->displayTDDNoSVCDuring3min()V

    goto :goto_0

    .line 253
    :cond_3
    const-string v1, "CTC : received EVENT_CT_SET_TDD_STATUS set db to 0"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 254
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "use_4g_single_data_network_onoff"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_0

    .line 244
    nop

    :pswitch_data_0
    .packed-switch 0x44d
        :pswitch_0
    .end packed-switch
.end method

.method protected setIsGsmValue(Z)Z
    .locals 2
    .param p1, "isGsm"    # Z

    .prologue
    .line 136
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "support_svlte"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 137
    const/4 p1, 0x0

    .line 139
    :cond_0
    return p1
.end method

.method protected setOperatorAlphaLongByServiceProviderName()Z
    .locals 5

    .prologue
    const/4 v0, 0x1

    .line 119
    const/4 v1, 0x0

    const-string v2, "vzw_eri"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 120
    const-string v1, "CdmaSST"

    const-string v2, "do not set the operator name from CSIM record..just set to the ERI text for VZW"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 130
    :goto_0
    return v0

    .line 124
    :cond_0
    const-string v1, "USC"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "ACG"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 125
    :cond_1
    const-string v1, "CdmaSST"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "do not set the operator name from CSIM record. - "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "ro.build.target_operator"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 130
    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method