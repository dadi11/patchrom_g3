.class public Lcom/itsoninc/android/ItsOnPhoneClient;
.super Ljava/lang/Object;
.source "ItsOnPhoneClient.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/itsoninc/android/ItsOnPhoneClient$2;,
        Lcom/itsoninc/android/ItsOnPhoneClient$AndroidFramework;
    }
.end annotation


# static fields
.field protected static final EVENT_POLL_CALLS_RESULT:I = 0x1

.field static final IOPC_LOGD:Z


# instance fields
.field LOG_TAG:Ljava/lang/String;

.field mApi:Lcom/itsoninc/android/ItsOnOemApi;

.field public mHandler:Landroid/os/Handler;

.field mRil:Lcom/android/internal/telephony/RIL;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/RIL;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ril"    # Lcom/android/internal/telephony/RIL;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "IOPC"

    iput-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->LOG_TAG:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-static {}, Lcom/itsoninc/android/ItsOnOemApi;->getInstance()Lcom/itsoninc/android/ItsOnOemApi;

    move-result-object v0

    iput-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1}, Lcom/itsoninc/android/ItsOnOemApi;->initTelephony(Landroid/content/Context;)V

    iput-object p2, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mRil:Lcom/android/internal/telephony/RIL;

    new-instance v0, Lcom/itsoninc/android/ItsOnPhoneClient$1;

    invoke-direct {v0, p0}, Lcom/itsoninc/android/ItsOnPhoneClient$1;-><init>(Lcom/itsoninc/android/ItsOnPhoneClient;)V

    iput-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mHandler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    new-instance v1, Lcom/itsoninc/android/ItsOnPhoneClient$AndroidFramework;

    iget-object v2, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mRil:Lcom/android/internal/telephony/RIL;

    iget-object v3, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mHandler:Landroid/os/Handler;

    invoke-direct {v1, p0, v2, v3}, Lcom/itsoninc/android/ItsOnPhoneClient$AndroidFramework;-><init>(Lcom/itsoninc/android/ItsOnPhoneClient;Lcom/android/internal/telephony/RIL;Landroid/os/Handler;)V

    invoke-virtual {v0, v1}, Lcom/itsoninc/android/ItsOnOemApi;->setFrameworkInterface(Lcom/itsoninc/android/ItsOnFrameworkInterface;)V

    return-void
.end method

.method private adaptCallList(Ljava/util/List;)Ljava/util/List;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/DriverCall;",
            ">;)",
            "Ljava/util/List",
            "<",
            "Lcom/itsoninc/android/DeviceCall;",
            ">;"
        }
    .end annotation

    .prologue
    .local p1, "callList":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/DriverCall;>;"
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .local v2, "deviceCalls":Ljava/util/List;, "Ljava/util/List<Lcom/itsoninc/android/DeviceCall;>;"
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .local v3, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/DriverCall;

    .local v0, "call":Lcom/android/internal/telephony/DriverCall;
    const/4 v4, 0x0

    .local v4, "state":Lcom/itsoninc/android/DeviceCall$CallState;
    sget-object v5, Lcom/itsoninc/android/ItsOnPhoneClient$2;->$SwitchMap$com$android$internal$telephony$DriverCall$State:[I

    iget-object v6, v0, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    invoke-virtual {v6}, Lcom/android/internal/telephony/DriverCall$State;->ordinal()I

    move-result v6

    aget v5, v5, v6

    packed-switch v5, :pswitch_data_0

    :goto_1
    new-instance v1, Lcom/itsoninc/android/DeviceCall;

    iget-boolean v5, v0, Lcom/android/internal/telephony/DriverCall;->isVoice:Z

    iget-object v6, v0, Lcom/android/internal/telephony/DriverCall;->number:Ljava/lang/String;

    invoke-direct {v1, v5, v4, v6}, Lcom/itsoninc/android/DeviceCall;-><init>(ZLcom/itsoninc/android/DeviceCall$CallState;Ljava/lang/String;)V

    .local v1, "d":Lcom/itsoninc/android/DeviceCall;
    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .end local v1    # "d":Lcom/itsoninc/android/DeviceCall;
    :pswitch_0
    sget-object v4, Lcom/itsoninc/android/DeviceCall$CallState;->ACTIVE:Lcom/itsoninc/android/DeviceCall$CallState;

    goto :goto_1

    :pswitch_1
    sget-object v4, Lcom/itsoninc/android/DeviceCall$CallState;->ALERTING:Lcom/itsoninc/android/DeviceCall$CallState;

    goto :goto_1

    :pswitch_2
    sget-object v4, Lcom/itsoninc/android/DeviceCall$CallState;->DIALING:Lcom/itsoninc/android/DeviceCall$CallState;

    goto :goto_1

    :pswitch_3
    sget-object v4, Lcom/itsoninc/android/DeviceCall$CallState;->HOLDING:Lcom/itsoninc/android/DeviceCall$CallState;

    goto :goto_1

    :pswitch_4
    sget-object v4, Lcom/itsoninc/android/DeviceCall$CallState;->INCOMING:Lcom/itsoninc/android/DeviceCall$CallState;

    goto :goto_1

    :pswitch_5
    sget-object v4, Lcom/itsoninc/android/DeviceCall$CallState;->WAITING:Lcom/itsoninc/android/DeviceCall$CallState;

    goto :goto_1

    .end local v0    # "call":Lcom/android/internal/telephony/DriverCall;
    .end local v4    # "state":Lcom/itsoninc/android/DeviceCall$CallState;
    :cond_0
    return-object v2

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method


# virtual methods
.method public acceptCall()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0}, Lcom/itsoninc/android/ItsOnOemApi;->acceptCall()V

    return-void
.end method

.method public authorizeIncomingSMS(Landroid/telephony/SmsMessage;)Z
    .locals 2
    .param p1, "sms"    # Landroid/telephony/SmsMessage;

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {p1}, Landroid/telephony/SmsMessage;->getPdu()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/itsoninc/android/ItsOnOemApi;->authorizeIncomingSms([B)Z

    move-result v0

    return v0
.end method

.method public authorizeIncomingVoice(Ljava/lang/String;)Z
    .locals 1
    .param p1, "address"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1}, Lcom/itsoninc/android/ItsOnOemApi;->authorizeIncomingVoice(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public authorizeOutgoingSMS(Ljava/lang/String;I)Z
    .locals 1
    .param p1, "address"    # Ljava/lang/String;
    .param p2, "serial"    # I

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1, p2}, Lcom/itsoninc/android/ItsOnOemApi;->authorizeOutgoingSms(Ljava/lang/String;I)Z

    move-result v0

    return v0
.end method

.method public authorizeOutgoingSMS([BI)Z
    .locals 1
    .param p1, "pdu"    # [B
    .param p2, "serial"    # I

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1, p2}, Lcom/itsoninc/android/ItsOnOemApi;->authorizeOutgoingSms([BI)Z

    move-result v0

    return v0
.end method

.method public authorizeOutgoingVoice(Ljava/lang/String;)Z
    .locals 1
    .param p1, "address"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1}, Lcom/itsoninc/android/ItsOnOemApi;->authorizeOutgoingVoice(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public callWaiting(Ljava/lang/String;)Z
    .locals 1
    .param p1, "number"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1}, Lcom/itsoninc/android/ItsOnOemApi;->callWaiting(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public dial(Ljava/lang/String;)Z
    .locals 1
    .param p1, "address"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1}, Lcom/itsoninc/android/ItsOnOemApi;->dial(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public flash(Ljava/lang/String;)Z
    .locals 1
    .param p1, "featureCode"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1}, Lcom/itsoninc/android/ItsOnOemApi;->flash(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public incomingCallReject()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0}, Lcom/itsoninc/android/ItsOnOemApi;->rejectCall()V

    return-void
.end method

.method public nitzTimeReceived(Ljava/lang/String;J)V
    .locals 2
    .param p1, "time"    # Ljava/lang/String;
    .param p2, "nitzReceiveTime"    # J

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1, p2, p3}, Lcom/itsoninc/android/ItsOnOemApi;->nitzTimeReceived(Ljava/lang/String;J)V

    return-void
.end method

.method public onNewDataSession(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "iface"    # Ljava/lang/String;
    .param p2, "apn"    # Ljava/lang/String;
    .param p3, "apnType"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1, p2, p3}, Lcom/itsoninc/android/ItsOnOemApi;->onNewDataSession(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public sendSMSDone(I)V
    .locals 1
    .param p1, "serial"    # I

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1}, Lcom/itsoninc/android/ItsOnOemApi;->smsDone(I)V

    return-void
.end method

.method public sendSMSError(I)V
    .locals 1
    .param p1, "serial"    # I

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1}, Lcom/itsoninc/android/ItsOnOemApi;->smsError(I)V

    return-void
.end method

.method public setEmergencyMode(Z)V
    .locals 1
    .param p1, "inEmergencyMode"    # Z

    .prologue
    iget-object v0, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v0, p1}, Lcom/itsoninc/android/ItsOnOemApi;->setEmergencyMode(Z)V

    return-void
.end method

.method public trackCalls(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/DriverCall;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "callList":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/DriverCall;>;"
    invoke-direct {p0, p1}, Lcom/itsoninc/android/ItsOnPhoneClient;->adaptCallList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .local v0, "deviceCalls":Ljava/util/List;, "Ljava/util/List<Lcom/itsoninc/android/DeviceCall;>;"
    iget-object v1, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v1, v0}, Lcom/itsoninc/android/ItsOnOemApi;->processCallList(Ljava/util/List;)V

    return-void
.end method

.method public trackCdmaCalls(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/DriverCall;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "callList":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/telephony/DriverCall;>;"
    invoke-direct {p0, p1}, Lcom/itsoninc/android/ItsOnPhoneClient;->adaptCallList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    .local v0, "deviceCalls":Ljava/util/List;, "Ljava/util/List<Lcom/itsoninc/android/DeviceCall;>;"
    iget-object v1, p0, Lcom/itsoninc/android/ItsOnPhoneClient;->mApi:Lcom/itsoninc/android/ItsOnOemApi;

    invoke-virtual {v1, v0}, Lcom/itsoninc/android/ItsOnOemApi;->processCDMACallList(Ljava/util/List;)V

    return-void
.end method
