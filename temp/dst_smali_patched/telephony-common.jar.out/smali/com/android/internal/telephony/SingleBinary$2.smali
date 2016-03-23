.class Lcom/android/internal/telephony/SingleBinary$2;
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
    iput-object p1, p0, Lcom/android/internal/telephony/SingleBinary$2;->this$0:Lcom/android/internal/telephony/SingleBinary;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v5, 0x1

    const/4 v0, 0x0

    .local v0, "appIndex":I
    :try_start_0
    invoke-virtual {p2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v2

    const-string v3, "appIndex"

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    packed-switch v0, :pswitch_data_0

    :goto_0
    const-string v2, "GSM"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[LGE][SBP] LGHOME: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    # getter for: Lcom/android/internal/telephony/SingleBinary;->isLGHomedbDeleted:Z
    invoke-static {}, Lcom/android/internal/telephony/SingleBinary;->access$200()Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", BROWSER: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    # getter for: Lcom/android/internal/telephony/SingleBinary;->isBrowserdbDeleted:Z
    invoke-static {}, Lcom/android/internal/telephony/SingleBinary;->access$300()Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", TELEPHONY_PROVIDER: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    # getter for: Lcom/android/internal/telephony/SingleBinary;->isTelephonydbDeleted:Z
    invoke-static {}, Lcom/android/internal/telephony/SingleBinary;->access$400()Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    # getter for: Lcom/android/internal/telephony/SingleBinary;->isTelephonydbDeleted:Z
    invoke-static {}, Lcom/android/internal/telephony/SingleBinary;->access$400()Z

    move-result v2

    if-eqz v2, :cond_0

    # getter for: Lcom/android/internal/telephony/SingleBinary;->isLGHomedbDeleted:Z
    invoke-static {}, Lcom/android/internal/telephony/SingleBinary;->access$200()Z

    move-result v2

    if-eqz v2, :cond_0

    # getter for: Lcom/android/internal/telephony/SingleBinary;->isBrowserdbDeleted:Z
    invoke-static {}, Lcom/android/internal/telephony/SingleBinary;->access$300()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/android/internal/telephony/SingleBinary$2;->this$0:Lcom/android/internal/telephony/SingleBinary;

    # getter for: Lcom/android/internal/telephony/SingleBinary;->handler:Landroid/os/Handler;
    invoke-static {v2}, Lcom/android/internal/telephony/SingleBinary;->access$600(Lcom/android/internal/telephony/SingleBinary;)Landroid/os/Handler;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/SingleBinary$2;->this$0:Lcom/android/internal/telephony/SingleBinary;

    # getter for: Lcom/android/internal/telephony/SingleBinary;->runnable:Ljava/lang/Runnable;
    invoke-static {v3}, Lcom/android/internal/telephony/SingleBinary;->access$500(Lcom/android/internal/telephony/SingleBinary;)Ljava/lang/Runnable;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v2, p0, Lcom/android/internal/telephony/SingleBinary$2;->this$0:Lcom/android/internal/telephony/SingleBinary;

    # invokes: Lcom/android/internal/telephony/SingleBinary;->rebootSystem()V
    invoke-static {v2}, Lcom/android/internal/telephony/SingleBinary;->access$100(Lcom/android/internal/telephony/SingleBinary;)V

    :cond_0
    :goto_1
    return-void

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1

    .end local v1    # "e":Ljava/lang/Exception;
    :pswitch_0
    # setter for: Lcom/android/internal/telephony/SingleBinary;->isLGHomedbDeleted:Z
    invoke-static {v5}, Lcom/android/internal/telephony/SingleBinary;->access$202(Z)Z

    goto :goto_0

    :pswitch_1
    # setter for: Lcom/android/internal/telephony/SingleBinary;->isBrowserdbDeleted:Z
    invoke-static {v5}, Lcom/android/internal/telephony/SingleBinary;->access$302(Z)Z

    goto :goto_0

    :pswitch_2
    # setter for: Lcom/android/internal/telephony/SingleBinary;->isTelephonydbDeleted:Z
    invoke-static {v5}, Lcom/android/internal/telephony/SingleBinary;->access$402(Z)Z

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method
