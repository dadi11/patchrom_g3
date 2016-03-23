.class public Lcom/lge/internal/telephony/LGPhone;
.super Ljava/lang/Object;
.source "LGPhone.java"


# static fields
.field public static final TAG:Ljava/lang/String; = "LGPhone"

.field private static final TYPE_EUIMID:I = 0x3

.field private static final TYPE_IMEI:I = 0x2

.field private static final TYPE_MEID:I = 0x1

.field private static sInstance:Lcom/lge/internal/telephony/LGPhone;


# instance fields
.field private mPhone:Lcom/android/internal/telephony/Phone;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized getDefault(Lcom/android/internal/telephony/Phone;)Lcom/lge/internal/telephony/LGPhone;
    .locals 3
    .param p0, "phone"    # Lcom/android/internal/telephony/Phone;

    .prologue
    const-class v1, Lcom/lge/internal/telephony/LGPhone;

    monitor-enter v1

    :try_start_0
    const-string v0, "LGPhone"

    const-string v2, "You are using Phone for LG API"

    invoke-static {v0, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Lcom/lge/internal/telephony/LGPhone;->sInstance:Lcom/lge/internal/telephony/LGPhone;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/internal/telephony/LGPhone;

    invoke-direct {v0}, Lcom/lge/internal/telephony/LGPhone;-><init>()V

    sput-object v0, Lcom/lge/internal/telephony/LGPhone;->sInstance:Lcom/lge/internal/telephony/LGPhone;

    :cond_0
    sget-object v0, Lcom/lge/internal/telephony/LGPhone;->sInstance:Lcom/lge/internal/telephony/LGPhone;

    invoke-virtual {v0, p0}, Lcom/lge/internal/telephony/LGPhone;->setPhone(Lcom/android/internal/telephony/Phone;)V

    sget-object v0, Lcom/lge/internal/telephony/LGPhone;->sInstance:Lcom/lge/internal/telephony/LGPhone;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method


# virtual methods
.method public getCLIRSettingValue()I
    .locals 2

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "dummy! getCLIRSettingValue"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return v0
.end method

.method public getCurrentLine()I
    .locals 2

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "getCurrentLine is not support!!"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x2

    return v0
.end method

.method public getCurrentVoiceClass()I
    .locals 2

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "getCurrentVoiceClass is not support!!"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    return v0
.end method

.method public getDeviceIdForVZW(I)Ljava/lang/String;
    .locals 11
    .param p1, "type"    # I

    .prologue
    const/16 v10, 0xe

    const/4 v2, 0x0

    .local v2, "mDeviceId":Ljava/lang/String;
    const-string v7, "gsm.sim.state"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .local v6, "prop":Ljava/lang/String;
    const-string v7, "READY"

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .local v1, "isSIMReady":Z
    iget-object v7, p0, Lcom/lge/internal/telephony/LGPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v7}, Lcom/android/internal/telephony/Phone;->getImei()Ljava/lang/String;

    move-result-object v4

    .local v4, "mImei":Ljava/lang/String;
    iget-object v7, p0, Lcom/lge/internal/telephony/LGPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v7}, Lcom/android/internal/telephony/Phone;->getEsn()Ljava/lang/String;

    move-result-object v3

    .local v3, "mEsn":Ljava/lang/String;
    iget-object v7, p0, Lcom/lge/internal/telephony/LGPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v7}, Lcom/android/internal/telephony/Phone;->getMeid()Ljava/lang/String;

    move-result-object v5

    .local v5, "mMeid":Ljava/lang/String;
    const-string v7, "ro.debuggable"

    const-string v8, "0"

    invoke-static {v7, v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "1"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    .local v0, "DBG":Z
    if-eqz v0, :cond_0

    const-string v7, "LGPhone"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "mImei = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "   mEsn = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "   mMeid = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    packed-switch p1, :pswitch_data_0

    const-string v7, "LGPhone"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "invalid type in getDeviceId("

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ")"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    if-eqz v0, :cond_1

    const-string v7, "LGPhone"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "getDeviceIdForVZW("

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ") = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    return-object v2

    :pswitch_0
    iget-object v7, p0, Lcom/lge/internal/telephony/LGPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v7}, Lcom/android/internal/telephony/Phone;->getDeviceId()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :pswitch_1
    move-object v2, v4

    goto :goto_0

    :pswitch_2
    if-nez v1, :cond_2

    const/4 v2, 0x0

    goto :goto_0

    :cond_2
    if-eqz v4, :cond_3

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v7

    if-lt v7, v10, :cond_3

    const/4 v7, 0x0

    invoke-virtual {v4, v7, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_3

    move-object v2, v5

    goto :goto_0

    :cond_3
    const/4 v2, 0x0

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public getVoiceCallForwardingFlag()Z
    .locals 2

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "dummy! getVoiceCallForwardingFlag"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return v0
.end method

.method public getVoiceCallForwardingFlagLine2()Z
    .locals 2

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "dummy! getVoiceCallForwardingFlagLine2"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return v0
.end method

.method public getVoiceMailAlphaTagForALS(I)Ljava/lang/String;
    .locals 2
    .param p1, "line"    # I

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "dummy! getVoiceMailAlphaTagForALS"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return-object v0
.end method

.method public getVoiceMailNumberForALS(I)Ljava/lang/String;
    .locals 2
    .param p1, "line"    # I

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "dummy! getVoiceMailNumberForALS"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return-object v0
.end method

.method public isTwoLineSupported()Z
    .locals 2

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "dummy! isTwoLineSupported"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return v0
.end method

.method public setPhone(Lcom/android/internal/telephony/Phone;)V
    .locals 0
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;

    .prologue
    iput-object p1, p0, Lcom/lge/internal/telephony/LGPhone;->mPhone:Lcom/android/internal/telephony/Phone;

    return-void
.end method

.method public setServiceLine(ILandroid/os/Message;)V
    .locals 2
    .param p1, "line"    # I
    .param p2, "onComplete"    # Landroid/os/Message;

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "dummy! setServiceLine"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public setVoiceMailNumberForALS(ILjava/lang/String;Ljava/lang/String;Landroid/os/Message;)V
    .locals 2
    .param p1, "line"    # I
    .param p2, "alphaTag"    # Ljava/lang/String;
    .param p3, "voiceMailNumber"    # Ljava/lang/String;
    .param p4, "onComplete"    # Landroid/os/Message;

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "dummy! setVoiceMailNumberForALS"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public storeALSSettingValue(I)V
    .locals 2
    .param p1, "value"    # I

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "dummy! storeALSSettingValue"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public storeCLIRSettingValue(I)V
    .locals 2
    .param p1, "value"    # I

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "dummy! storeCLIRSettingValue"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public toggleCurrentLine()I
    .locals 2

    .prologue
    const-string v0, "LGPhone"

    const-string v1, "toggleCurrentLine is not support!!"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x2

    return v0
.end method
