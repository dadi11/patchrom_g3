.class Lcom/android/internal/telephony/SingleBinary$4;
.super Landroid/content/BroadcastReceiver;
.source "SingleBinary.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/SingleBinary;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/SingleBinary;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/SingleBinary;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/SingleBinary$4;->this$0:Lcom/android/internal/telephony/SingleBinary;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const-string v3, "OPEN"

    const-string v4, "ro.build.target_operator"

    invoke-static {v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "EU"

    const-string v4, "ro.build.target_country"

    invoke-static {v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "1"

    const-string v4, "persist.sys.clientid-changed"

    const-string v5, "0"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    const-string v4, "android.intent.action.SIM_STATE_CHANGED"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "ss"

    invoke-virtual {p2, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .local v2, "stateExtra":Ljava/lang/String;
    if-eqz v2, :cond_2

    const-string v3, "LOADED"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "gsm.sim.operator.numeric"

    invoke-static {v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "numeric":Ljava/lang/String;
    new-instance v1, Ljava/util/StringTokenizer;

    const-string v3, ","

    invoke-direct {v1, v0, v3}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .local v1, "st":Ljava/util/StringTokenizer;
    iget-object v3, p0, Lcom/android/internal/telephony/SingleBinary$4;->this$0:Lcom/android/internal/telephony/SingleBinary;

    const-string v4, "persist.radio.sim-fixed"

    const-string v5, "yet_rev_share"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    # setter for: Lcom/android/internal/telephony/SingleBinary;->mSIMChecked:Ljava/lang/String;
    invoke-static {v3, v4}, Lcom/android/internal/telephony/SingleBinary;->access$702(Lcom/android/internal/telephony/SingleBinary;Ljava/lang/String;)Ljava/lang/String;

    invoke-virtual {v1}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v3

    if-eqz v3, :cond_2

    iget-object v3, p0, Lcom/android/internal/telephony/SingleBinary$4;->this$0:Lcom/android/internal/telephony/SingleBinary;

    # getter for: Lcom/android/internal/telephony/SingleBinary;->mSIMChecked:Ljava/lang/String;
    invoke-static {v3}, Lcom/android/internal/telephony/SingleBinary;->access$700(Lcom/android/internal/telephony/SingleBinary;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "yet_rev_share"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    iget-object v3, p0, Lcom/android/internal/telephony/SingleBinary$4;->this$0:Lcom/android/internal/telephony/SingleBinary;

    # invokes: Lcom/android/internal/telephony/SingleBinary;->setClientIDBySIM(Ljava/lang/String;)V
    invoke-static {v3, v0}, Lcom/android/internal/telephony/SingleBinary;->access$800(Lcom/android/internal/telephony/SingleBinary;Ljava/lang/String;)V

    .end local v0    # "numeric":Ljava/lang/String;
    .end local v1    # "st":Ljava/util/StringTokenizer;
    .end local v2    # "stateExtra":Ljava/lang/String;
    :cond_2
    iget-object v3, p0, Lcom/android/internal/telephony/SingleBinary$4;->this$0:Lcom/android/internal/telephony/SingleBinary;

    # getter for: Lcom/android/internal/telephony/SingleBinary;->mEnableSBP:Ljava/lang/String;
    invoke-static {v3}, Lcom/android/internal/telephony/SingleBinary;->access$900(Lcom/android/internal/telephony/SingleBinary;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "1"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    const-string v4, "android.intent.action.SIM_STATE_CHANGED"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    # getter for: Lcom/android/internal/telephony/SingleBinary;->mContext:Landroid/content/Context;
    invoke-static {}, Lcom/android/internal/telephony/SingleBinary;->access$1000()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/SingleBinary;->getInstance(Landroid/content/Context;)Lcom/android/internal/telephony/SingleBinary;

    move-result-object v3

    # invokes: Lcom/android/internal/telephony/SingleBinary;->checkFlexEnableStatus()V
    invoke-static {v3}, Lcom/android/internal/telephony/SingleBinary;->access$1100(Lcom/android/internal/telephony/SingleBinary;)V

    goto :goto_0
.end method
