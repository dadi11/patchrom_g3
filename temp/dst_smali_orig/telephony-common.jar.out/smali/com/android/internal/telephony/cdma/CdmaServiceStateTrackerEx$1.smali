.class Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;
.super Landroid/content/BroadcastReceiver;
.source "CdmaServiceStateTrackerEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-boolean v2, v2, Lcom/android/internal/telephony/cdma/CDMAPhone;->mIsTheCurrentActivePhone:Z

    if-nez v2, :cond_1

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Received Intent "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " while being destroyed. Ignoring."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->log(Ljava/lang/String;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    const-string v3, "android.intent.action.LOCALE_CHANGED"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getState()I

    move-result v2

    if-nez v2, :cond_2

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getCdmaEriText()Ljava/lang/String;

    move-result-object v1

    .local v1, "eriText":Ljava/lang/String;
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    invoke-virtual {v2, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->getEriTextForOperator(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_1
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2, v1}, Landroid/telephony/ServiceState;->setOperatorAlphaLong(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->updateSpnDisplay()V

    goto :goto_0

    .end local v1    # "eriText":Ljava/lang/String;
    :cond_2
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getState()I

    move-result v2

    const/4 v3, 0x3

    if-ne v2, v3, :cond_3

    const/4 v1, 0x0

    .restart local v1    # "eriText":Ljava/lang/String;
    goto :goto_1

    .end local v1    # "eriText":Ljava/lang/String;
    :cond_3
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    const v3, 0x10400cd

    invoke-virtual {v2, v3}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    .restart local v1    # "eriText":Ljava/lang/String;
    goto :goto_1

    .end local v1    # "eriText":Ljava/lang/String;
    :cond_4
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    const-string v3, "android.intent.action.ACTION_RADIO_OFF"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    const/4 v3, 0x0

    # setter for: Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mAlarmSwitch:Z
    invoke-static {v2, v3}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->access$002(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;Z)Z

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    iget-object v2, v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-object v0, v2, Lcom/android/internal/telephony/cdma/CDMAPhone;->mDcTracker:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    .local v0, "dcTracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    invoke-virtual {v2, v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->powerOffRadioSafely(Lcom/android/internal/telephony/dataconnection/DcTrackerBase;)V

    goto :goto_0

    .end local v0    # "dcTracker":Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    :cond_5
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    const-string v3, "android.intent.action.ACTION_SHUTDOWN"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    const-string v2, "CdmaSST"

    const-string v3, "get ACTION SHUTDOWN!!"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    const/4 v3, 0x1

    iput-boolean v3, v2, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->isInShutDown:Z

    goto/16 :goto_0

    :cond_6
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    const-string v3, "com.lge.vzwnetworktest"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    # invokes: Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->setFakeNetworkValues(Landroid/content/Intent;)V
    invoke-static {v2, p2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->access$100(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;Landroid/content/Intent;)V

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    # getter for: Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->mFakeRI:I
    invoke-static {v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->access$200(Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;)I

    move-result v2

    if-lez v2, :cond_0

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx$1;->this$0:Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;->pollState()V

    goto/16 :goto_0
.end method
