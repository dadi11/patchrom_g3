.class public Lcom/lge/telephony/LGTelephonyManagerImpl;
.super Ljava/lang/Object;
.source "LGTelephonyManagerImpl.java"

# interfaces
.implements Lcom/lge/telephony/ILGTelephonyManager;


# static fields
.field private static final TAG:Ljava/lang/String; = "LGTelephonyManagerImpl"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;
    .locals 1

    .prologue
    const-string v0, "phone"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/internal/telephony/ITelephonyEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v0

    return-object v0
.end method

.method private getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;
    .locals 1

    .prologue
    const-string v0, "iphonesubinfo"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/internal/telephony/IPhoneSubInfoEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v0

    return-object v0
.end method

.method private uknight_get_data_result(I[B)[B
    .locals 7
    .param p1, "cumuDataSize"    # I
    .param p2, "logDataTemp"    # [B

    .prologue
    const/4 v3, 0x0

    if-nez p1, :cond_0

    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "uknightGetData()-- cumuDataSize="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v2, v3

    :goto_0
    return-object v2

    :cond_0
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v4

    const v5, 0xffff

    invoke-interface {v4, v5}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightGetData(I)Lcom/lge/internal/telephony/KNDataResponse;

    move-result-object v1

    .local v1, "knDataResp":Lcom/lge/internal/telephony/KNDataResponse;
    if-nez v1, :cond_1

    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "Internal Start ERROR : KNDataResponse is NULL"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v2, v3

    goto :goto_0

    :cond_1
    array-length v4, p2

    if-ge p1, v4, :cond_2

    new-array v2, p1, [B

    .local v2, "logDataResult":[B
    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {p2, v4, v2, v5, p1}, Ljava/lang/System;->arraycopy([BI[BII)V

    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "uknightGetData()-- logDataResult.length="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, v2

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .end local v1    # "knDataResp":Lcom/lge/internal/telephony/KNDataResponse;
    .end local v2    # "logDataResult":[B
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    move-object v2, v3

    goto :goto_0

    .restart local v1    # "knDataResp":Lcom/lge/internal/telephony/KNDataResponse;
    :cond_2
    :try_start_1
    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "uknightGetData()-- logData.length="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, p2

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    move-object v2, p2

    goto :goto_0

    .end local v1    # "knDataResp":Lcom/lge/internal/telephony/KNDataResponse;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method


# virtual methods
.method public getCallState()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getCompleteVoiceMailNumber()Ljava/lang/String;
    .locals 1

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDeviceIdForVZW(I)Ljava/lang/String;
    .locals 3
    .param p1, "type"    # I

    .prologue
    const/4 v1, 0x0

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/internal/telephony/IPhoneSubInfoEx;->getDeviceIdForVZW(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getDmNodeHandlerDiagMonNetwork(ZII)Ljava/lang/String;
    .locals 3
    .param p1, "setpreferrednetworktype"    # Z
    .param p2, "preferrednetworktype"    # I
    .param p3, "networksignal"    # I

    .prologue
    const/4 v1, 0x0

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v2

    invoke-interface {v2, p1, p2, p3}, Lcom/lge/internal/telephony/IPhoneSubInfoEx;->getDmNodeHandlerDiagMonNetwork(ZII)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getLteOnCdmaPhoneType()I
    .locals 2

    .prologue
    const-string v1, "KDDI"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    sget v0, Lcom/android/internal/telephony/RILConstants;->PREFERRED_NETWORK_MODE:I

    .local v0, "mode":I
    const/16 v1, 0x9

    if-eq v0, v1, :cond_0

    const/16 v1, 0xa

    if-eq v0, v1, :cond_0

    const/16 v1, 0xb

    if-eq v0, v1, :cond_0

    const/16 v1, 0xc

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v1, 0x1

    .end local v0    # "mode":I
    :goto_0
    return v1

    :cond_1
    const/4 v1, 0x2

    goto :goto_0
.end method

.method public getMobileQualityInformation()Ljava/util/HashMap;
    .locals 3

    .prologue
    const/4 v2, 0x0

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->getMobileQualityInformation()Ljava/util/Map;

    move-result-object v1

    check-cast v1, Ljava/util/HashMap;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    move-object v1, v2

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    move-object v1, v2

    goto :goto_0
.end method

.method public getNetworkCountryIso(I)Ljava/lang/String;
    .locals 2
    .param p1, "currentPhoneType"    # I

    .prologue
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    const-string v0, "us"

    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method public getNetworkOperator(I)Ljava/lang/String;
    .locals 2
    .param p1, "currentPhoneType"    # I

    .prologue
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    const-string v0, "ro.cdma.home.operator.numeric"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method public getNetworkOperatorName(I)Ljava/lang/String;
    .locals 2
    .param p1, "currentPhoneType"    # I

    .prologue
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    const-string v0, "ro.cdma.home.operator.alpha"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_0
    const-string v0, ""

    goto :goto_0
.end method

.method public getSimCountryIso(I)Ljava/lang/String;
    .locals 2
    .param p1, "simState"    # I

    .prologue
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "ril.card_operator"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "SPR"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    :cond_0
    const-string v0, "us"

    :goto_0
    return-object v0

    :cond_1
    const-string v0, ""

    goto :goto_0
.end method

.method public getSimOperator(I)Ljava/lang/String;
    .locals 2
    .param p1, "simState"    # I

    .prologue
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "ril.card_operator"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "SPR"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    :cond_0
    const-string v0, "ro.cdma.home.operator.numeric"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_1
    const-string v0, ""

    goto :goto_0
.end method

.method public getSimOperatorName(I)Ljava/lang/String;
    .locals 2
    .param p1, "simState"    # I

    .prologue
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "ril.card_operator"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "SPR"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    :cond_0
    const-string v0, "ro.cdma.home.operator.alpha"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0

    :cond_1
    const-string v0, ""

    goto :goto_0
.end method

.method public getVoiceMailNumber()Ljava/lang/String;
    .locals 1

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public moca_alarm_event([B)[B
    .locals 7
    .param p1, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    if-nez p1, :cond_1

    :try_start_0
    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "moca_alarm_event:: reset"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v4, 0x1

    new-array v2, v4, [B

    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_0

    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :goto_0
    return-object v3

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_0
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaAlarmEvent([B)[B

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_1
    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "moca_alarm_event:: mask.length="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, p1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_2

    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_2
    :try_start_1
    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaAlarmEvent([B)[B
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public moca_alarm_event_reg(I)Z
    .locals 6
    .param p1, "event"    # I

    .prologue
    const/4 v2, 0x0

    const-string v3, "LGTelephonyManagerImpl"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "moca_alarm_event_reg event = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_0

    const-string v3, "LGTelephonyManagerImpl"

    const-string v4, "telephony is null"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return v2

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaAlarmEventReg(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public moca_check_mem()[I
    .locals 5

    .prologue
    const/4 v2, 0x0

    const-string v3, "LGTelephonyManagerImpl"

    const-string v4, "moca_check_mem"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_0

    const-string v3, "LGTelephonyManagerImpl"

    const-string v4, "telephony is null"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v2

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaCheckMem()[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public moca_get_RFParameter(I)[B
    .locals 12
    .param p1, "kindOfData"    # I

    .prologue
    const/4 v8, 0x0

    const/4 v4, 0x0

    .local v4, "logDataTemp":[B
    const/4 v3, 0x0

    .local v3, "logDataResult":[B
    const/4 v5, 0x0

    .local v5, "mocaDataResp":Lcom/lge/internal/telephony/MOCARFParameterResponse;
    const/4 v7, 0x0

    .local v7, "totBufNum":I
    const/4 v1, 0x0

    .local v1, "curBufNum":I
    const/4 v0, 0x0

    .local v0, "cumuDataSize":I
    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mocaGetRFParameter()++, kindOfData = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v6

    .local v6, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v6, :cond_0

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "telephony is null"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v8

    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v6, p1, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetRFParameter(II)Lcom/lge/internal/telephony/MOCARFParameterResponse;

    move-result-object v5

    if-nez v5, :cond_1

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCARFParameterResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v2

    .local v2, "ex":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "ex":Landroid/os/RemoteException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_1
    :try_start_1
    iget v7, v5, Lcom/lge/internal/telephony/MOCARFParameterResponse;->send_buf_num:I

    if-lez v7, :cond_3

    const/16 v9, 0x1000

    if-ge v7, v9, :cond_3

    mul-int/lit16 v9, v7, 0x7f8

    new-array v4, v9, [B

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "totBufNum="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", local buffer size = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v4

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    :goto_1
    if-ge v1, v7, :cond_6

    add-int/lit8 v1, v1, 0x1

    invoke-interface {v6, p1, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetRFParameter(II)Lcom/lge/internal/telephony/MOCARFParameterResponse;

    move-result-object v5

    if-nez v5, :cond_4

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : MOCARFParameterResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v2

    .local v2, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v2}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "ex":Ljava/lang/NullPointerException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_3
    :try_start_2
    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "totBufNum="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " is Invalid"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v7, :cond_2

    const/4 v7, 0x0

    goto :goto_1

    :cond_4
    iget v9, v5, Lcom/lge/internal/telephony/MOCARFParameterResponse;->data_len:I

    add-int/2addr v9, v0

    array-length v10, v4

    if-le v9, v10, :cond_5

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : TOO Large data"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_5
    iget-object v9, v5, Lcom/lge/internal/telephony/MOCARFParameterResponse;->data:[B

    const/4 v10, 0x0

    iget v11, v5, Lcom/lge/internal/telephony/MOCARFParameterResponse;->data_len:I

    invoke-static {v9, v10, v4, v0, v11}, Ljava/lang/System;->arraycopy([BI[BII)V

    iget v9, v5, Lcom/lge/internal/telephony/MOCARFParameterResponse;->data_len:I

    add-int/2addr v0, v9

    goto :goto_1

    :cond_6
    const v9, 0xffff

    invoke-interface {v6, p1, v9}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetRFParameter(II)Lcom/lge/internal/telephony/MOCARFParameterResponse;

    move-result-object v5

    if-nez v5, :cond_7

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCARFParameterResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_7
    if-nez v0, :cond_8

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mocaGetRFParameter()-- kindOfData = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "cumuDataSize="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_8
    array-length v9, v4

    if-ge v0, v9, :cond_9

    new-array v3, v0, [B

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static {v4, v9, v3, v10, v0}, Ljava/lang/System;->arraycopy([BI[BII)V

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mocaGetData()--, kindOfData = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", logDataResult.length="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v3

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v8, v3

    goto/16 :goto_0

    :cond_9
    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mocaGetData()--, kindOfData = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", logData.length="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v4

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_1

    move-object v8, v4

    goto/16 :goto_0
.end method

.method public moca_get_data()[B
    .locals 12

    .prologue
    const/4 v8, 0x0

    const/4 v4, 0x0

    .local v4, "logDataTemp":[B
    const/4 v3, 0x0

    .local v3, "logDataResult":[B
    const/4 v5, 0x0

    .local v5, "mocaDataResp":Lcom/lge/internal/telephony/MOCADataResponse;
    const/4 v7, 0x0

    .local v7, "totBufNum":I
    const/4 v1, 0x0

    .local v1, "curBufNum":I
    const/4 v0, 0x0

    .local v0, "cumuDataSize":I
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "mocaGetData()++"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v6

    .local v6, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v6, :cond_0

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "telephony is null"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v8

    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v6, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetData(I)Lcom/lge/internal/telephony/MOCADataResponse;

    move-result-object v5

    if-nez v5, :cond_1

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v2

    .local v2, "ex":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "ex":Landroid/os/RemoteException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_1
    :try_start_1
    iget v7, v5, Lcom/lge/internal/telephony/MOCADataResponse;->send_buf_num:I

    if-lez v7, :cond_3

    const/16 v9, 0x1000

    if-ge v7, v9, :cond_3

    mul-int/lit16 v9, v7, 0x7f8

    new-array v4, v9, [B

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "totBufNum="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", local buffer size = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v4

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    :goto_1
    if-ge v1, v7, :cond_6

    add-int/lit8 v1, v1, 0x1

    invoke-interface {v6, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetData(I)Lcom/lge/internal/telephony/MOCADataResponse;

    move-result-object v5

    if-nez v5, :cond_4

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : MOCADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v2

    .local v2, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v2}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "ex":Ljava/lang/NullPointerException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_3
    :try_start_2
    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "totBufNum="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " is Invalid"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v7, :cond_2

    const/4 v7, 0x0

    goto :goto_1

    :cond_4
    iget v9, v5, Lcom/lge/internal/telephony/MOCADataResponse;->data_len:I

    add-int/2addr v9, v0

    array-length v10, v4

    if-le v9, v10, :cond_5

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : TOO Large data"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_5
    iget-object v9, v5, Lcom/lge/internal/telephony/MOCADataResponse;->data:[B

    const/4 v10, 0x0

    iget v11, v5, Lcom/lge/internal/telephony/MOCADataResponse;->data_len:I

    invoke-static {v9, v10, v4, v0, v11}, Ljava/lang/System;->arraycopy([BI[BII)V

    iget v9, v5, Lcom/lge/internal/telephony/MOCADataResponse;->data_len:I

    add-int/2addr v0, v9

    goto :goto_1

    :cond_6
    const v9, 0xffff

    invoke-interface {v6, v9}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetData(I)Lcom/lge/internal/telephony/MOCADataResponse;

    move-result-object v5

    if-nez v5, :cond_7

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_7
    if-nez v0, :cond_8

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mocaGetData()-- cumuDataSize="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_8
    array-length v9, v4

    if-ge v0, v9, :cond_9

    new-array v3, v0, [B

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static {v4, v9, v3, v10, v0}, Ljava/lang/System;->arraycopy([BI[BII)V

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mocaGetData()-- logDataResult.length="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v3

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v8, v3

    goto/16 :goto_0

    :cond_9
    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mocaGetData()-- logData.length="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v4

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_1

    move-object v8, v4

    goto/16 :goto_0
.end method

.method public moca_get_misc(I)[B
    .locals 12
    .param p1, "kindOfData"    # I

    .prologue
    const/4 v8, 0x0

    const/4 v4, 0x0

    .local v4, "logDataTemp":[B
    const/4 v3, 0x0

    .local v3, "logDataResult":[B
    const/4 v5, 0x0

    .local v5, "mocaDataResp":Lcom/lge/internal/telephony/MOCAMiscResponse;
    const/4 v7, 0x0

    .local v7, "totBufNum":I
    const/4 v1, 0x0

    .local v1, "curBufNum":I
    const/4 v0, 0x0

    .local v0, "cumuDataSize":I
    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mocaGetMisc()++, kindOfData = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v6

    .local v6, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v6, :cond_0

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "telephony is null"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v8

    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v6, p1, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetMisc(II)Lcom/lge/internal/telephony/MOCAMiscResponse;

    move-result-object v5

    if-nez v5, :cond_1

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCAMiscResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v2

    .local v2, "ex":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "ex":Landroid/os/RemoteException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_1
    :try_start_1
    iget v7, v5, Lcom/lge/internal/telephony/MOCAMiscResponse;->send_buf_num:I

    if-lez v7, :cond_3

    const/16 v9, 0x1000

    if-ge v7, v9, :cond_3

    mul-int/lit16 v9, v7, 0x7f8

    new-array v4, v9, [B

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "totBufNum="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", local buffer size = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v4

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    :goto_1
    if-ge v1, v7, :cond_6

    add-int/lit8 v1, v1, 0x1

    invoke-interface {v6, p1, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetMisc(II)Lcom/lge/internal/telephony/MOCAMiscResponse;

    move-result-object v5

    if-nez v5, :cond_4

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : MOCAMiscResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v2

    .local v2, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v2}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "ex":Ljava/lang/NullPointerException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_3
    :try_start_2
    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "totBufNum="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " is Invalid"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v7, :cond_2

    const/4 v7, 0x0

    goto :goto_1

    :cond_4
    iget v9, v5, Lcom/lge/internal/telephony/MOCAMiscResponse;->data_len:I

    add-int/2addr v9, v0

    array-length v10, v4

    if-le v9, v10, :cond_5

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : TOO Large data"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_5
    iget-object v9, v5, Lcom/lge/internal/telephony/MOCAMiscResponse;->data:[B

    const/4 v10, 0x0

    iget v11, v5, Lcom/lge/internal/telephony/MOCAMiscResponse;->data_len:I

    invoke-static {v9, v10, v4, v0, v11}, Ljava/lang/System;->arraycopy([BI[BII)V

    iget v9, v5, Lcom/lge/internal/telephony/MOCAMiscResponse;->data_len:I

    add-int/2addr v0, v9

    goto :goto_1

    :cond_6
    const v9, 0xffff

    invoke-interface {v6, p1, v9}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetMisc(II)Lcom/lge/internal/telephony/MOCAMiscResponse;

    move-result-object v5

    if-nez v5, :cond_7

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCAMiscResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_7
    if-nez v0, :cond_8

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mocaGetMisc()-- kindOfData = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "cumuDataSize="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_8
    array-length v9, v4

    if-ge v0, v9, :cond_9

    new-array v3, v0, [B

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static {v4, v9, v3, v10, v0}, Ljava/lang/System;->arraycopy([BI[BII)V

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mocaGetData()--, kindOfData = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", logDataResult.length="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v3

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v8, v3

    goto/16 :goto_0

    :cond_9
    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "mocaGetData()--, kindOfData = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", logData.length="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v4

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_1

    move-object v8, v4

    goto/16 :goto_0
.end method

.method public moca_set_event([B)[B
    .locals 7
    .param p1, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    if-nez p1, :cond_2

    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_0
    :goto_0
    return-object v3

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetEvent([B)[B

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_2
    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "moca_set_event:: mask.length="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, p1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetEvent([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public moca_set_log([B[B)[B
    .locals 7
    .param p1, "startcode"    # [B
    .param p2, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    if-nez p2, :cond_1

    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_0

    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :goto_0
    return-object v3

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_0
    invoke-interface {v1, p1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetLog([B[B)[B

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_1
    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "moca_set_log:: mask.length="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, p2

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_2

    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_2
    :try_start_1
    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetLog([B[B)[B
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public moca_set_mem(I)Z
    .locals 7
    .param p1, "percent"    # I

    .prologue
    const/4 v3, 0x0

    const/4 v4, -0x1

    if-ne p1, v4, :cond_2

    const/4 v2, 0x0

    .local v2, "unset":I
    move v2, p1

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":I
    :cond_0
    :goto_0
    return v3

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":I
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetMem(I)Z

    move-result v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":I
    :cond_2
    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "moca_set_mem:: percent="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetMem(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public oem_ssa_alarm_event([B)[B
    .locals 7
    .param p1, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    if-nez p1, :cond_2

    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_0
    :goto_0
    return-object v3

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaAlarmEvent([B)[B

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_2
    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "oem_ssa_alarm_event:: mask.length="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, p1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaAlarmEvent([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public oem_ssa_check_mem()[I
    .locals 5

    .prologue
    const/4 v2, 0x0

    const-string v3, "LGTelephonyManagerImpl"

    const-string v4, "oem_ssa_check_mem"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v2

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaCheckMem()[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public oem_ssa_get_data()[B
    .locals 12

    .prologue
    const/4 v8, 0x0

    const/4 v4, 0x0

    .local v4, "logDataTemp":[B
    const/4 v3, 0x0

    .local v3, "logDataResult":[B
    const/4 v5, 0x0

    .local v5, "oemSsaDataResp":Lcom/lge/internal/telephony/OEMSSADataResponse;
    const/4 v7, 0x0

    .local v7, "totBufNum":I
    const/4 v1, 0x0

    .local v1, "curBufNum":I
    const/4 v0, 0x0

    .local v0, "cumuDataSize":I
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "oemSsaGetData()++"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v6

    .local v6, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v6, :cond_0

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v8

    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v6, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaGetData(I)Lcom/lge/internal/telephony/OEMSSADataResponse;

    move-result-object v5

    if-nez v5, :cond_1

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : OEMSSADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v2

    .local v2, "ex":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "ex":Landroid/os/RemoteException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_1
    :try_start_1
    iget v7, v5, Lcom/lge/internal/telephony/OEMSSADataResponse;->send_buf_num:I

    if-lez v7, :cond_3

    const/16 v9, 0x1000

    if-ge v7, v9, :cond_3

    mul-int/lit16 v9, v7, 0x7f8

    new-array v4, v9, [B

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "totBufNum="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", local buffer size = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v4

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    :goto_1
    if-ge v1, v7, :cond_6

    add-int/lit8 v1, v1, 0x1

    invoke-interface {v6, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaGetData(I)Lcom/lge/internal/telephony/OEMSSADataResponse;

    move-result-object v5

    if-nez v5, :cond_4

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : OEMSSADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v2

    .local v2, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v2}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0

    .end local v2    # "ex":Ljava/lang/NullPointerException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_3
    :try_start_2
    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "totBufNum="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " is Invalid"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v7, :cond_2

    const/4 v7, 0x0

    goto :goto_1

    :cond_4
    iget v9, v5, Lcom/lge/internal/telephony/OEMSSADataResponse;->data_len:I

    add-int/2addr v9, v0

    array-length v10, v4

    if-le v9, v10, :cond_5

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : TOO Large data"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_5
    iget-object v9, v5, Lcom/lge/internal/telephony/OEMSSADataResponse;->data:[B

    const/4 v10, 0x0

    iget v11, v5, Lcom/lge/internal/telephony/OEMSSADataResponse;->data_len:I

    invoke-static {v9, v10, v4, v0, v11}, Ljava/lang/System;->arraycopy([BI[BII)V

    iget v9, v5, Lcom/lge/internal/telephony/OEMSSADataResponse;->data_len:I

    add-int/2addr v0, v9

    goto :goto_1

    :cond_6
    const v9, 0xffff

    invoke-interface {v6, v9}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaGetData(I)Lcom/lge/internal/telephony/OEMSSADataResponse;

    move-result-object v5

    if-nez v5, :cond_7

    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : OEMSSADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_7
    if-nez v0, :cond_8

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "oemSsaGetData()-- cumuDataSize="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_8
    array-length v9, v4

    if-ge v0, v9, :cond_9

    new-array v3, v0, [B

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static {v4, v9, v3, v10, v0}, Ljava/lang/System;->arraycopy([BI[BII)V

    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "oemSsaGetData()-- logDataResult.length="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v3

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v8, v3

    goto/16 :goto_0

    :cond_9
    const-string v9, "LGTelephonyManagerImpl"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "oemSsaGetData()-- logData.length="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    array-length v11, v4

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_1

    move-object v8, v4

    goto/16 :goto_0
.end method

.method public oem_ssa_hdv_alarm_event([B)[B
    .locals 7
    .param p1, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    if-nez p1, :cond_2

    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_0
    :goto_0
    return-object v3

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaHdvAlarmEvent([B)[B

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_2
    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "oem_ssa_hdv_alarm_event:: mask.length="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, p1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaHdvAlarmEvent([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public oem_ssa_set_event([B)[B
    .locals 7
    .param p1, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    if-nez p1, :cond_2

    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_0
    :goto_0
    return-object v3

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetEvent([B)[B

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_2
    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "oem_ssa_set_event:: mask.length="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, p1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetEvent([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public oem_ssa_set_log([B[B)[B
    .locals 7
    .param p1, "startcode"    # [B
    .param p2, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    if-nez p2, :cond_2

    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_0
    :goto_0
    return-object v3

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_1
    invoke-interface {v1, p1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetLog([B[B)[B

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_2
    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "oem_ssa_set_log:: mask.length="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, p2

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetLog([B[B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public oem_ssa_set_mem(I)Z
    .locals 7
    .param p1, "percent"    # I

    .prologue
    const/4 v3, 0x0

    const/4 v4, -0x1

    if-ne p1, v4, :cond_2

    const/4 v2, 0x0

    .local v2, "unset":I
    move v2, p1

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":I
    :cond_0
    :goto_0
    return v3

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":I
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetMem(I)Z

    move-result v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":I
    :cond_2
    const-string v4, "LGTelephonyManagerImpl"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "oem_ssa_set_mem:: percent="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetMem(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v3

    goto :goto_0

    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public resetVoiceMessageCount()V
    .locals 2

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v0

    .local v0, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/lge/internal/telephony/ITelephonyEx;->resetVoiceMessageCount()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v1

    goto :goto_0

    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method public startMobileQualityInformation()V
    .locals 2

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->startMobileQualityInformation()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public stopMobileQualityInformation()V
    .locals 2

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->stopMobileQualityInformation()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public uknight_event_set([B)[B
    .locals 4
    .param p1, "mask"    # [B

    .prologue
    if-nez p1, :cond_0

    const/4 v2, 0x1

    :try_start_0
    new-array v1, v2, [B

    .local v1, "unset":[B
    const/4 v2, 0x0

    const/4 v3, -0x1

    aput-byte v3, v1, v2

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightEventSet([B)[B

    move-result-object v2

    .end local v1    # "unset":[B
    :goto_0
    return-object v2

    :cond_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightEventSet([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    const/4 v2, 0x0

    goto :goto_0

    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method

.method public uknight_get_data()[B
    .locals 11

    .prologue
    const/4 v7, 0x0

    const/4 v5, 0x0

    .local v5, "logDataTemp":[B
    const/4 v4, 0x0

    .local v4, "logDataResult":[B
    const/4 v3, 0x0

    .local v3, "knDataResp":Lcom/lge/internal/telephony/KNDataResponse;
    const/4 v6, 0x0

    .local v6, "totBufNum":I
    const/4 v1, 0x0

    .local v1, "curBufNum":I
    const/4 v0, 0x0

    .local v0, "cumuDataSize":I
    const-string v8, "LGTelephonyManagerImpl"

    const-string v9, "uknightGetData()++"

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v8

    invoke-interface {v8, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightGetData(I)Lcom/lge/internal/telephony/KNDataResponse;

    move-result-object v3

    if-nez v3, :cond_0

    const-string v8, "LGTelephonyManagerImpl"

    const-string v9, "Internal Start ERROR : KNDataResponse is NULL"

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-object v7

    :cond_0
    iget v6, v3, Lcom/lge/internal/telephony/KNDataResponse;->send_buf_num:I

    if-lez v6, :cond_1

    const/16 v8, 0x1000

    if-ge v6, v8, :cond_1

    mul-int/lit16 v8, v6, 0x7f8

    new-array v5, v8, [B

    const-string v8, "LGTelephonyManagerImpl"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "totBufNum="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", local buffer size="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    array-length v10, v5

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_1
    if-ge v1, v6, :cond_4

    add-int/lit8 v1, v1, 0x1

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v8

    invoke-interface {v8, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightGetData(I)Lcom/lge/internal/telephony/KNDataResponse;

    move-result-object v3

    if-nez v3, :cond_2

    const-string v8, "LGTelephonyManagerImpl"

    const-string v9, "Internal Loop ERROR  : KNDataResponse is NULL"

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    :catch_0
    move-exception v2

    .local v2, "ex":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v2    # "ex":Landroid/os/RemoteException;
    :goto_2
    move-object v7, v4

    goto :goto_0

    :cond_1
    :try_start_1
    const-string v8, "LGTelephonyManagerImpl"

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "totBufNum="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " is Invalid"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v6, 0x0

    goto :goto_1

    :cond_2
    iget v8, v3, Lcom/lge/internal/telephony/KNDataResponse;->data_len:I

    add-int/2addr v8, v0

    array-length v9, v5

    if-le v8, v9, :cond_3

    const-string v8, "LGTelephonyManagerImpl"

    const-string v9, "Internal Loop ERROR  : TOO Large data"

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_1
    move-exception v2

    .local v2, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v2}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_2

    .end local v2    # "ex":Ljava/lang/NullPointerException;
    :cond_3
    :try_start_2
    iget-object v8, v3, Lcom/lge/internal/telephony/KNDataResponse;->data:[B

    const/4 v9, 0x0

    iget v10, v3, Lcom/lge/internal/telephony/KNDataResponse;->data_len:I

    invoke-static {v8, v9, v5, v0, v10}, Ljava/lang/System;->arraycopy([BI[BII)V

    iget v8, v3, Lcom/lge/internal/telephony/KNDataResponse;->data_len:I

    add-int/2addr v0, v8

    goto :goto_1

    :cond_4
    invoke-direct {p0, v0, v5}, Lcom/lge/telephony/LGTelephonyManagerImpl;->uknight_get_data_result(I[B)[B
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_1

    move-result-object v4

    goto :goto_2
.end method

.method public uknight_log_set([B)[B
    .locals 5
    .param p1, "mask"    # [B

    .prologue
    if-nez p1, :cond_0

    const/4 v2, 0x1

    :try_start_0
    new-array v1, v2, [B

    .local v1, "unset":[B
    const/4 v2, 0x0

    const/4 v3, -0x1

    aput-byte v3, v1, v2

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightLogSet([B)[B

    move-result-object v2

    .end local v1    # "unset":[B
    :goto_0
    return-object v2

    :cond_0
    const-string v2, "LGTelephonyManagerImpl"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "uknight_log_set:: mask.length="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    array-length v4, p1

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightLogSet([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    const/4 v2, 0x0

    goto :goto_0

    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method

.method public uknight_mem_check()[I
    .locals 2

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightMemCheck()[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method

.method public uknight_mem_set(I)Z
    .locals 2
    .param p1, "persent"    # I

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightMemSet(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method

.method public uknight_state_change_set(I)Z
    .locals 2
    .param p1, "event"    # I

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightStateChangeSet(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method
