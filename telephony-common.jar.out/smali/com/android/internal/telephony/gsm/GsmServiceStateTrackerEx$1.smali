.class Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$1;
.super Landroid/content/BroadcastReceiver;
.source "GsmServiceStateTrackerEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;)V
    .locals 0

    .prologue
    .line 142
    iput-object p1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v7, 0x0

    const/4 v5, -0x1

    const/4 v6, 0x1

    .line 145
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;

    iget-object v3, v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    iget-boolean v3, v3, Lcom/android/internal/telephony/gsm/GSMPhone;->mIsTheCurrentActivePhone:Z

    if-nez v3, :cond_1

    .line 146
    const-string v3, "GsmSST"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Received Intent "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " while being destroyed. Ignoring."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 193
    :cond_0
    :goto_0
    return-void

    .line 150
    :cond_1
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    const-string v4, "android.intent.action.MASTER_CLEAR_NOTIFICATION"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 151
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getPhoneCount()I

    move-result v2

    .line 152
    .local v2, "numPhones":I
    new-array v1, v2, [I

    .line 154
    .local v1, "networkModes":[I
    const-string v3, "GsmSST"

    const-string v4, "Receive MASTER_CLEAR_NOTIFICATION"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 155
    if-le v2, v6, :cond_0

    .line 156
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    if-ge v0, v2, :cond_0

    .line 157
    if-nez v0, :cond_2

    .line 158
    const/4 v3, 0x3

    aput v3, v1, v0

    .line 162
    :goto_2
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;

    iget-object v3, v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "preferred_network_mode"

    aget v5, v1, v0

    invoke-static {v3, v4, v0, v5}, Landroid/telephony/TelephonyManager;->putIntAtIndex(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    .line 156
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 160
    :cond_2
    aput v6, v1, v0

    goto :goto_2

    .line 168
    .end local v0    # "i":I
    .end local v1    # "networkModes":[I
    .end local v2    # "numPhones":I
    :cond_3
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    const-string v4, "com.lge.android.intent.action.SPN_UPDATE_REQUEST"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 169
    const-string v3, "GsmSST"

    const-string v4, "Receive ACTION_SPN_UPDATE_REQUEST"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 170
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->isMultiSimEnabled()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 171
    const-string v3, "GsmSST"

    const-string v4, "polling service state"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 172
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;

    iput-boolean v6, v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSpndisplay:Z

    .line 173
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->updateSpnDisplay()V

    goto :goto_0

    .line 178
    :cond_4
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    const-string v4, "android.intent.action.AIRPLANE_MODE"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 180
    const-string v3, "state"

    invoke-virtual {p2, v3, v7}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 183
    sput v5, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mLAC:I

    .line 184
    sput v5, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mRAC:I

    .line 186
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;

    iput-boolean v6, v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mAirplaneMode:Z

    goto/16 :goto_0

    .line 189
    :cond_5
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;

    iput-boolean v7, v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mAirplaneMode:Z

    goto/16 :goto_0
.end method
