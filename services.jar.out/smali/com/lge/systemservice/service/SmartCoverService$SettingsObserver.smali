.class Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;
.super Landroid/database/ContentObserver;
.source "SmartCoverService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/systemservice/service/SmartCoverService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "SettingsObserver"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/systemservice/service/SmartCoverService;


# direct methods
.method constructor <init>(Lcom/lge/systemservice/service/SmartCoverService;Landroid/os/Handler;)V
    .locals 0
    .param p2, "handler"    # Landroid/os/Handler;

    .prologue
    .line 911
    iput-object p1, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    .line 912
    invoke-direct {p0, p2}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V

    .line 913
    return-void
.end method


# virtual methods
.method observe()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 916
    iget-object v1, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # getter for: Lcom/lge/systemservice/service/SmartCoverService;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/lge/systemservice/service/SmartCoverService;->access$1500(Lcom/lge/systemservice/service/SmartCoverService;)Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 919
    .local v0, "resolver":Landroid/content/ContentResolver;
    const-string v1, "quick_cover_enable"

    invoke-static {v1}, Landroid/provider/Settings$Global;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1, v3, p0}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 921
    const-string v1, "quick_view_enable"

    invoke-static {v1}, Landroid/provider/Settings$Global;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1, v3, p0}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 925
    const-string v1, "accessibility_touch_control_areas_service_enable"

    invoke-static {v1}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const/4 v2, -0x1

    invoke-virtual {v0, v1, v3, p0, v2}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;I)V

    .line 928
    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->onChange(Z)V

    .line 929
    return-void
.end method

.method public onChange(Z)V
    .locals 8
    .param p1, "selfChange"    # Z

    .prologue
    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 933
    iget-object v6, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # getter for: Lcom/lge/systemservice/service/SmartCoverService;->mContext:Landroid/content/Context;
    invoke-static {v6}, Lcom/lge/systemservice/service/SmartCoverService;->access$1500(Lcom/lge/systemservice/service/SmartCoverService;)Landroid/content/Context;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    .line 935
    .local v2, "resolver":Landroid/content/ContentResolver;
    const/4 v0, 0x5

    .line 937
    .local v0, "coverType":I
    const-string v6, "quick_cover_enable"

    invoke-static {v2, v6, v5}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v6

    if-eqz v6, :cond_3

    .line 938
    const/4 v0, 0x0

    .line 960
    :cond_0
    :goto_0
    const/4 v6, 0x5

    if-eq v0, v6, :cond_4

    .line 961
    iget-object v6, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # setter for: Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverEnabled:Z
    invoke-static {v6, v4}, Lcom/lge/systemservice/service/SmartCoverService;->access$2802(Lcom/lge/systemservice/service/SmartCoverService;Z)Z

    .line 962
    # getter for: Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/service/SmartCoverService;->access$000()Ljava/lang/String;

    move-result-object v6

    const-string v7, "onChange(), mSmartCoverEnabled=true"

    invoke-static {v6, v7}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 964
    iget-object v6, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # invokes: Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverType(I)V
    invoke-static {v6, v0}, Lcom/lge/systemservice/service/SmartCoverService;->access$2900(Lcom/lge/systemservice/service/SmartCoverService;I)V

    .line 965
    iget-object v6, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # invokes: Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverEvent()V
    invoke-static {v6}, Lcom/lge/systemservice/service/SmartCoverService;->access$3000(Lcom/lge/systemservice/service/SmartCoverService;)V

    .line 981
    :goto_1
    iget-object v6, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # setter for: Lcom/lge/systemservice/service/SmartCoverService;->mPenEnabled:Z
    invoke-static {v6, v4}, Lcom/lge/systemservice/service/SmartCoverService;->access$3102(Lcom/lge/systemservice/service/SmartCoverService;Z)Z

    .line 990
    iget-object v6, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # setter for: Lcom/lge/systemservice/service/SmartCoverService;->mSubCoverEnabled:Z
    invoke-static {v6, v4}, Lcom/lge/systemservice/service/SmartCoverService;->access$3202(Lcom/lge/systemservice/service/SmartCoverService;Z)Z

    .line 991
    const/4 v1, 0x0

    .line 992
    .local v1, "needToEnable":Z
    const-string v6, "accessibility_touch_control_areas_service_enable"

    const/4 v7, -0x2

    invoke-static {v2, v6, v5, v7}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v6

    if-nez v6, :cond_5

    move v1, v4

    .line 995
    :goto_2
    iget-object v4, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # getter for: Lcom/lge/systemservice/service/SmartCoverService;->mServiceEnabled:Z
    invoke-static {v4}, Lcom/lge/systemservice/service/SmartCoverService;->access$3300(Lcom/lge/systemservice/service/SmartCoverService;)Z

    move-result v4

    if-eq v1, v4, :cond_2

    .line 996
    if-nez v1, :cond_1

    .line 997
    iget-object v4, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # invokes: Lcom/lge/systemservice/service/SmartCoverService;->stopObserving()V
    invoke-static {v4}, Lcom/lge/systemservice/service/SmartCoverService;->access$3400(Lcom/lge/systemservice/service/SmartCoverService;)V

    .line 1000
    :cond_1
    iget-object v4, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # setter for: Lcom/lge/systemservice/service/SmartCoverService;->mServiceEnabled:Z
    invoke-static {v4, v1}, Lcom/lge/systemservice/service/SmartCoverService;->access$3302(Lcom/lge/systemservice/service/SmartCoverService;Z)Z

    .line 1001
    # getter for: Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/service/SmartCoverService;->access$000()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "onChange(), mServiceEnabled="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # getter for: Lcom/lge/systemservice/service/SmartCoverService;->mServiceEnabled:Z
    invoke-static {v6}, Lcom/lge/systemservice/service/SmartCoverService;->access$3300(Lcom/lge/systemservice/service/SmartCoverService;)Z

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1003
    iget-object v4, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # getter for: Lcom/lge/systemservice/service/SmartCoverService;->mServiceEnabled:Z
    invoke-static {v4}, Lcom/lge/systemservice/service/SmartCoverService;->access$3300(Lcom/lge/systemservice/service/SmartCoverService;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 1004
    iget-object v4, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # invokes: Lcom/lge/systemservice/service/SmartCoverService;->startService()V
    invoke-static {v4}, Lcom/lge/systemservice/service/SmartCoverService;->access$3500(Lcom/lge/systemservice/service/SmartCoverService;)V

    .line 1007
    :cond_2
    return-void

    .line 939
    .end local v1    # "needToEnable":Z
    :cond_3
    const-string v6, "quick_view_enable"

    invoke-static {v2, v6, v5}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v6

    if-eqz v6, :cond_0

    .line 940
    const-string v6, "cover_type"

    invoke-static {v2, v6, v5}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v3

    .line 941
    .local v3, "type":I
    packed-switch v3, :pswitch_data_0

    .line 956
    const/4 v0, 0x5

    goto/16 :goto_0

    .line 943
    :pswitch_0
    const/4 v0, 0x1

    .line 944
    goto/16 :goto_0

    .line 946
    :pswitch_1
    const/4 v0, 0x2

    .line 947
    goto/16 :goto_0

    .line 950
    :pswitch_2
    const/4 v0, 0x1

    .line 951
    goto/16 :goto_0

    .line 953
    :pswitch_3
    const/4 v0, 0x4

    .line 954
    goto/16 :goto_0

    .line 967
    .end local v3    # "type":I
    :cond_4
    iget-object v6, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # invokes: Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverEvent(I)V
    invoke-static {v6, v5}, Lcom/lge/systemservice/service/SmartCoverService;->access$700(Lcom/lge/systemservice/service/SmartCoverService;I)V

    .line 968
    iget-object v6, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # invokes: Lcom/lge/systemservice/service/SmartCoverService;->updateSmartCoverType(I)V
    invoke-static {v6, v0}, Lcom/lge/systemservice/service/SmartCoverService;->access$2900(Lcom/lge/systemservice/service/SmartCoverService;I)V

    .line 970
    iget-object v6, p0, Lcom/lge/systemservice/service/SmartCoverService$SettingsObserver;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    # setter for: Lcom/lge/systemservice/service/SmartCoverService;->mSmartCoverEnabled:Z
    invoke-static {v6, v5}, Lcom/lge/systemservice/service/SmartCoverService;->access$2802(Lcom/lge/systemservice/service/SmartCoverService;Z)Z

    .line 971
    # getter for: Lcom/lge/systemservice/service/SmartCoverService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/systemservice/service/SmartCoverService;->access$000()Ljava/lang/String;

    move-result-object v6

    const-string v7, "onChange(), mSmartCoverEnabled=false"

    invoke-static {v6, v7}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .restart local v1    # "needToEnable":Z
    :cond_5
    move v1, v5

    .line 992
    goto :goto_2

    .line 941
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method
