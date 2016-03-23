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
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;
    .locals 1

    .prologue
    .line 48
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
    .line 53
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

    .line 173
    if-nez p1, :cond_0

    .line 174
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

    .line 200
    :goto_0
    return-object v2

    .line 179
    :cond_0
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v4

    const v5, 0xffff

    invoke-interface {v4, v5}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightGetData(I)Lcom/lge/internal/telephony/KNDataResponse;

    move-result-object v1

    .line 180
    .local v1, "knDataResp":Lcom/lge/internal/telephony/KNDataResponse;
    if-nez v1, :cond_1

    .line 181
    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "Internal Start ERROR : KNDataResponse is NULL"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v2, v3

    .line 182
    goto :goto_0

    .line 185
    :cond_1
    array-length v4, p2

    if-ge p1, v4, :cond_2

    .line 186
    new-array v2, p1, [B

    .line 187
    .local v2, "logDataResult":[B
    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {p2, v4, v2, v5, p1}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 188
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

    .line 194
    .end local v1    # "knDataResp":Lcom/lge/internal/telephony/KNDataResponse;
    .end local v2    # "logDataResult":[B
    :catch_0
    move-exception v0

    .line 195
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    move-object v2, v3

    .line 200
    goto :goto_0

    .line 191
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

    .line 192
    goto :goto_0

    .line 196
    .end local v1    # "knDataResp":Lcom/lge/internal/telephony/KNDataResponse;
    :catch_1
    move-exception v0

    .line 197
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method


# virtual methods
.method public getCallState()I
    .locals 1

    .prologue
    .line 423
    const/4 v0, 0x0

    return v0
.end method

.method public getCompleteVoiceMailNumber()Ljava/lang/String;
    .locals 1

    .prologue
    .line 404
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDeviceIdForVZW(I)Ljava/lang/String;
    .locals 3
    .param p1, "type"    # I

    .prologue
    const/4 v1, 0x0

    .line 261
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/internal/telephony/IPhoneSubInfoEx;->getDeviceIdForVZW(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 266
    :goto_0
    return-object v1

    .line 262
    :catch_0
    move-exception v0

    .line 263
    .local v0, "ex":Landroid/os/RemoteException;
    goto :goto_0

    .line 264
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 266
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

    .line 275
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v2

    invoke-interface {v2, p1, p2, p3}, Lcom/lge/internal/telephony/IPhoneSubInfoEx;->getDmNodeHandlerDiagMonNetwork(ZII)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 280
    :goto_0
    return-object v1

    .line 276
    :catch_0
    move-exception v0

    .line 277
    .local v0, "ex":Landroid/os/RemoteException;
    goto :goto_0

    .line 278
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 280
    .local v0, "ex":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getLteOnCdmaPhoneType()I
    .locals 2

    .prologue
    .line 289
    const-string v1, "KDDI"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 290
    sget v0, Lcom/android/internal/telephony/RILConstants;->PREFERRED_NETWORK_MODE:I

    .line 291
    .local v0, "mode":I
    const/16 v1, 0x9

    if-eq v0, v1, :cond_0

    const/16 v1, 0xa

    if-eq v0, v1, :cond_0

    const/16 v1, 0xb

    if-eq v0, v1, :cond_0

    const/16 v1, 0xc

    if-ne v0, v1, :cond_1

    .line 295
    :cond_0
    const/4 v1, 0x1

    .line 299
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

    .line 249
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->getMobileQualityInformation()Ljava/util/Map;

    move-result-object v1

    check-cast v1, Ljava/util/HashMap;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    .line 253
    :goto_0
    return-object v1

    .line 250
    :catch_0
    move-exception v0

    .local v0, "ex":Landroid/os/RemoteException;
    move-object v1, v2

    .line 251
    goto :goto_0

    .line 252
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .local v0, "ex":Ljava/lang/NullPointerException;
    move-object v1, v2

    .line 253
    goto :goto_0
.end method

.method public getNetworkCountryIso(I)Ljava/lang/String;
    .locals 2
    .param p1, "currentPhoneType"    # I

    .prologue
    .line 330
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 331
    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    .line 332
    const-string v0, "us"

    .line 335
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
    .line 317
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 318
    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    .line 319
    const-string v0, "ro.cdma.home.operator.numeric"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 322
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
    .line 305
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 306
    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    .line 307
    const-string v0, "ro.cdma.home.operator.alpha"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 310
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
    .line 368
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 369
    const-string v0, "ril.card_operator"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "SPR"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    .line 371
    :cond_0
    const-string v0, "us"

    .line 374
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
    .line 342
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 343
    const-string v0, "ril.card_operator"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "SPR"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    .line 345
    :cond_0
    const-string v0, "ro.cdma.home.operator.numeric"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 348
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
    .line 355
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 356
    const-string v0, "ril.card_operator"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "SPR"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    .line 358
    :cond_0
    const-string v0, "ro.cdma.home.operator.alpha"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 361
    :goto_0
    return-object v0

    :cond_1
    const-string v0, ""

    goto :goto_0
.end method

.method public getVoiceMailNumber()Ljava/lang/String;
    .locals 1

    .prologue
    .line 389
    const/4 v0, 0x0

    return-object v0
.end method

.method public moca_alarm_event([B)[B
    .locals 7
    .param p1, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    .line 773
    if-nez p1, :cond_1

    .line 774
    :try_start_0
    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "moca_alarm_event:: reset"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 775
    const/4 v4, 0x1

    new-array v2, v4, [B

    .line 776
    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    .line 777
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 778
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_0

    .line 779
    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 798
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :goto_0
    return-object v3

    .line 782
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_0
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaAlarmEvent([B)[B

    move-result-object v3

    goto :goto_0

    .line 785
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

    .line 786
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 787
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_2

    .line 788
    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 793
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 794
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 791
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

    .line 795
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v0

    .line 796
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public moca_alarm_event_reg(I)Z
    .locals 6
    .param p1, "event"    # I

    .prologue
    const/4 v2, 0x0

    .line 753
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

    .line 755
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 756
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_0

    .line 757
    const-string v3, "LGTelephonyManagerImpl"

    const-string v4, "telephony is null"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 766
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return v2

    .line 760
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaAlarmEventReg(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v2

    goto :goto_0

    .line 761
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 762
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 763
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 764
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public moca_check_mem()[I
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 1061
    const-string v3, "LGTelephonyManagerImpl"

    const-string v4, "moca_check_mem"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1064
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 1065
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_0

    .line 1066
    const-string v3, "LGTelephonyManagerImpl"

    const-string v4, "telephony is null"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1075
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v2

    .line 1069
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaCheckMem()[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    goto :goto_0

    .line 1070
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 1071
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 1072
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 1073
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public moca_get_RFParameter(I)[B
    .locals 12
    .param p1, "kindOfData"    # I

    .prologue
    const/4 v8, 0x0

    .line 880
    const/4 v4, 0x0

    .line 881
    .local v4, "logDataTemp":[B
    const/4 v3, 0x0

    .line 882
    .local v3, "logDataResult":[B
    const/4 v5, 0x0

    .line 883
    .local v5, "mocaDataResp":Lcom/lge/internal/telephony/MOCARFParameterResponse;
    const/4 v7, 0x0

    .line 884
    .local v7, "totBufNum":I
    const/4 v1, 0x0

    .line 885
    .local v1, "curBufNum":I
    const/4 v0, 0x0

    .line 886
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

    .line 888
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v6

    .line 889
    .local v6, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v6, :cond_0

    .line 890
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "telephony is null"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 950
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v8

    .line 893
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v6, p1, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetRFParameter(II)Lcom/lge/internal/telephony/MOCARFParameterResponse;

    move-result-object v5

    .line 894
    if-nez v5, :cond_1

    .line 895
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCARFParameterResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 945
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v2

    .line 946
    .local v2, "ex":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 898
    .end local v2    # "ex":Landroid/os/RemoteException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_1
    :try_start_1
    iget v7, v5, Lcom/lge/internal/telephony/MOCARFParameterResponse;->send_buf_num:I

    .line 899
    if-lez v7, :cond_3

    const/16 v9, 0x1000

    if-ge v7, v9, :cond_3

    .line 900
    mul-int/lit16 v9, v7, 0x7f8

    new-array v4, v9, [B

    .line 901
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

    .line 909
    :cond_2
    :goto_1
    if-ge v1, v7, :cond_6

    .line 910
    add-int/lit8 v1, v1, 0x1

    .line 911
    invoke-interface {v6, p1, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetRFParameter(II)Lcom/lge/internal/telephony/MOCARFParameterResponse;

    move-result-object v5

    .line 912
    if-nez v5, :cond_4

    .line 913
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : MOCARFParameterResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 947
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v2

    .line 948
    .local v2, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v2}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0

    .line 904
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

    .line 905
    if-eqz v7, :cond_2

    .line 906
    const/4 v7, 0x0

    goto :goto_1

    .line 916
    :cond_4
    iget v9, v5, Lcom/lge/internal/telephony/MOCARFParameterResponse;->data_len:I

    add-int/2addr v9, v0

    array-length v10, v4

    if-le v9, v10, :cond_5

    .line 917
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : TOO Large data"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 920
    :cond_5
    iget-object v9, v5, Lcom/lge/internal/telephony/MOCARFParameterResponse;->data:[B

    const/4 v10, 0x0

    iget v11, v5, Lcom/lge/internal/telephony/MOCARFParameterResponse;->data_len:I

    invoke-static {v9, v10, v4, v0, v11}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 921
    iget v9, v5, Lcom/lge/internal/telephony/MOCARFParameterResponse;->data_len:I

    add-int/2addr v0, v9

    goto :goto_1

    .line 926
    :cond_6
    const v9, 0xffff

    invoke-interface {v6, p1, v9}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetRFParameter(II)Lcom/lge/internal/telephony/MOCARFParameterResponse;

    move-result-object v5

    .line 927
    if-nez v5, :cond_7

    .line 928
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCARFParameterResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 931
    :cond_7
    if-nez v0, :cond_8

    .line 932
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

    .line 935
    :cond_8
    array-length v9, v4

    if-ge v0, v9, :cond_9

    .line 936
    new-array v3, v0, [B

    .line 937
    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static {v4, v9, v3, v10, v0}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 938
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

    .line 939
    goto/16 :goto_0

    .line 942
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

    .line 943
    goto/16 :goto_0
.end method

.method public moca_get_data()[B
    .locals 12

    .prologue
    const/4 v8, 0x0

    .line 804
    const/4 v4, 0x0

    .line 805
    .local v4, "logDataTemp":[B
    const/4 v3, 0x0

    .line 806
    .local v3, "logDataResult":[B
    const/4 v5, 0x0

    .line 807
    .local v5, "mocaDataResp":Lcom/lge/internal/telephony/MOCADataResponse;
    const/4 v7, 0x0

    .line 808
    .local v7, "totBufNum":I
    const/4 v1, 0x0

    .line 809
    .local v1, "curBufNum":I
    const/4 v0, 0x0

    .line 810
    .local v0, "cumuDataSize":I
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "mocaGetData()++"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 812
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v6

    .line 813
    .local v6, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v6, :cond_0

    .line 814
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "telephony is null"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 874
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v8

    .line 817
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v6, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetData(I)Lcom/lge/internal/telephony/MOCADataResponse;

    move-result-object v5

    .line 818
    if-nez v5, :cond_1

    .line 819
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 869
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v2

    .line 870
    .local v2, "ex":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 822
    .end local v2    # "ex":Landroid/os/RemoteException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_1
    :try_start_1
    iget v7, v5, Lcom/lge/internal/telephony/MOCADataResponse;->send_buf_num:I

    .line 823
    if-lez v7, :cond_3

    const/16 v9, 0x1000

    if-ge v7, v9, :cond_3

    .line 824
    mul-int/lit16 v9, v7, 0x7f8

    new-array v4, v9, [B

    .line 825
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

    .line 833
    :cond_2
    :goto_1
    if-ge v1, v7, :cond_6

    .line 834
    add-int/lit8 v1, v1, 0x1

    .line 835
    invoke-interface {v6, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetData(I)Lcom/lge/internal/telephony/MOCADataResponse;

    move-result-object v5

    .line 836
    if-nez v5, :cond_4

    .line 837
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : MOCADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 871
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v2

    .line 872
    .local v2, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v2}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0

    .line 828
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

    .line 829
    if-eqz v7, :cond_2

    .line 830
    const/4 v7, 0x0

    goto :goto_1

    .line 840
    :cond_4
    iget v9, v5, Lcom/lge/internal/telephony/MOCADataResponse;->data_len:I

    add-int/2addr v9, v0

    array-length v10, v4

    if-le v9, v10, :cond_5

    .line 841
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : TOO Large data"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 844
    :cond_5
    iget-object v9, v5, Lcom/lge/internal/telephony/MOCADataResponse;->data:[B

    const/4 v10, 0x0

    iget v11, v5, Lcom/lge/internal/telephony/MOCADataResponse;->data_len:I

    invoke-static {v9, v10, v4, v0, v11}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 845
    iget v9, v5, Lcom/lge/internal/telephony/MOCADataResponse;->data_len:I

    add-int/2addr v0, v9

    goto :goto_1

    .line 850
    :cond_6
    const v9, 0xffff

    invoke-interface {v6, v9}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetData(I)Lcom/lge/internal/telephony/MOCADataResponse;

    move-result-object v5

    .line 851
    if-nez v5, :cond_7

    .line 852
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 855
    :cond_7
    if-nez v0, :cond_8

    .line 856
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

    .line 859
    :cond_8
    array-length v9, v4

    if-ge v0, v9, :cond_9

    .line 860
    new-array v3, v0, [B

    .line 861
    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static {v4, v9, v3, v10, v0}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 862
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

    .line 863
    goto/16 :goto_0

    .line 866
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

    .line 867
    goto/16 :goto_0
.end method

.method public moca_get_misc(I)[B
    .locals 12
    .param p1, "kindOfData"    # I

    .prologue
    const/4 v8, 0x0

    .line 956
    const/4 v4, 0x0

    .line 957
    .local v4, "logDataTemp":[B
    const/4 v3, 0x0

    .line 958
    .local v3, "logDataResult":[B
    const/4 v5, 0x0

    .line 959
    .local v5, "mocaDataResp":Lcom/lge/internal/telephony/MOCAMiscResponse;
    const/4 v7, 0x0

    .line 960
    .local v7, "totBufNum":I
    const/4 v1, 0x0

    .line 961
    .local v1, "curBufNum":I
    const/4 v0, 0x0

    .line 962
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

    .line 964
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v6

    .line 965
    .local v6, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v6, :cond_0

    .line 966
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "telephony is null"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1026
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v8

    .line 969
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v6, p1, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetMisc(II)Lcom/lge/internal/telephony/MOCAMiscResponse;

    move-result-object v5

    .line 970
    if-nez v5, :cond_1

    .line 971
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCAMiscResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 1021
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v2

    .line 1022
    .local v2, "ex":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 974
    .end local v2    # "ex":Landroid/os/RemoteException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_1
    :try_start_1
    iget v7, v5, Lcom/lge/internal/telephony/MOCAMiscResponse;->send_buf_num:I

    .line 975
    if-lez v7, :cond_3

    const/16 v9, 0x1000

    if-ge v7, v9, :cond_3

    .line 976
    mul-int/lit16 v9, v7, 0x7f8

    new-array v4, v9, [B

    .line 977
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

    .line 985
    :cond_2
    :goto_1
    if-ge v1, v7, :cond_6

    .line 986
    add-int/lit8 v1, v1, 0x1

    .line 987
    invoke-interface {v6, p1, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetMisc(II)Lcom/lge/internal/telephony/MOCAMiscResponse;

    move-result-object v5

    .line 988
    if-nez v5, :cond_4

    .line 989
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : MOCAMiscResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 1023
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v2

    .line 1024
    .local v2, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v2}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0

    .line 980
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

    .line 981
    if-eqz v7, :cond_2

    .line 982
    const/4 v7, 0x0

    goto :goto_1

    .line 992
    :cond_4
    iget v9, v5, Lcom/lge/internal/telephony/MOCAMiscResponse;->data_len:I

    add-int/2addr v9, v0

    array-length v10, v4

    if-le v9, v10, :cond_5

    .line 993
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : TOO Large data"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 996
    :cond_5
    iget-object v9, v5, Lcom/lge/internal/telephony/MOCAMiscResponse;->data:[B

    const/4 v10, 0x0

    iget v11, v5, Lcom/lge/internal/telephony/MOCAMiscResponse;->data_len:I

    invoke-static {v9, v10, v4, v0, v11}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 997
    iget v9, v5, Lcom/lge/internal/telephony/MOCAMiscResponse;->data_len:I

    add-int/2addr v0, v9

    goto :goto_1

    .line 1002
    :cond_6
    const v9, 0xffff

    invoke-interface {v6, p1, v9}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaGetMisc(II)Lcom/lge/internal/telephony/MOCAMiscResponse;

    move-result-object v5

    .line 1003
    if-nez v5, :cond_7

    .line 1004
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : MOCAMiscResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 1007
    :cond_7
    if-nez v0, :cond_8

    .line 1008
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

    .line 1011
    :cond_8
    array-length v9, v4

    if-ge v0, v9, :cond_9

    .line 1012
    new-array v3, v0, [B

    .line 1013
    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static {v4, v9, v3, v10, v0}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 1014
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

    .line 1015
    goto/16 :goto_0

    .line 1018
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

    .line 1019
    goto/16 :goto_0
.end method

.method public moca_set_event([B)[B
    .locals 7
    .param p1, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    .line 725
    if-nez p1, :cond_2

    .line 726
    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .line 727
    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    .line 728
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 729
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .line 730
    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 748
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_0
    :goto_0
    return-object v3

    .line 733
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetEvent([B)[B

    move-result-object v3

    goto :goto_0

    .line 736
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

    .line 737
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 738
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    .line 741
    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetEvent([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    goto :goto_0

    .line 743
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 744
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 745
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 746
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

    .line 695
    if-nez p2, :cond_1

    .line 696
    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .line 697
    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    .line 698
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 699
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_0

    .line 700
    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 719
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :goto_0
    return-object v3

    .line 703
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_0
    invoke-interface {v1, p1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetLog([B[B)[B

    move-result-object v3

    goto :goto_0

    .line 706
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

    .line 707
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 708
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_2

    .line 709
    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 714
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 715
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 712
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

    .line 716
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v0

    .line 717
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public moca_set_mem(I)Z
    .locals 7
    .param p1, "percent"    # I

    .prologue
    const/4 v3, 0x0

    .line 1033
    const/4 v4, -0x1

    if-ne p1, v4, :cond_2

    .line 1034
    const/4 v2, 0x0

    .line 1035
    .local v2, "unset":I
    move v2, p1

    .line 1036
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 1037
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .line 1038
    const-string v4, "LGTelephonyManagerImpl"

    const-string v5, "telephony is null"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1056
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":I
    :cond_0
    :goto_0
    return v3

    .line 1041
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":I
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetMem(I)Z

    move-result v3

    goto :goto_0

    .line 1044
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

    .line 1045
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 1046
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    .line 1049
    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->mocaSetMem(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v3

    goto :goto_0

    .line 1051
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 1052
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 1053
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 1054
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public oem_ssa_alarm_event([B)[B
    .locals 7
    .param p1, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    .line 542
    if-nez p1, :cond_2

    .line 543
    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .line 544
    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    .line 545
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 546
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .line 564
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_0
    :goto_0
    return-object v3

    .line 549
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaAlarmEvent([B)[B

    move-result-object v3

    goto :goto_0

    .line 552
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

    .line 553
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 554
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    .line 557
    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaAlarmEvent([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    goto :goto_0

    .line 559
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 560
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 561
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 562
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public oem_ssa_check_mem()[I
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 673
    const-string v3, "LGTelephonyManagerImpl"

    const-string v4, "oem_ssa_check_mem"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 676
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 677
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_0

    .line 686
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v2

    .line 680
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaCheckMem()[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    goto :goto_0

    .line 681
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 682
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 683
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 684
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public oem_ssa_get_data()[B
    .locals 12

    .prologue
    const/4 v8, 0x0

    .line 570
    const/4 v4, 0x0

    .line 571
    .local v4, "logDataTemp":[B
    const/4 v3, 0x0

    .line 572
    .local v3, "logDataResult":[B
    const/4 v5, 0x0

    .line 573
    .local v5, "oemSsaDataResp":Lcom/lge/internal/telephony/OEMSSADataResponse;
    const/4 v7, 0x0

    .line 574
    .local v7, "totBufNum":I
    const/4 v1, 0x0

    .line 575
    .local v1, "curBufNum":I
    const/4 v0, 0x0

    .line 576
    .local v0, "cumuDataSize":I
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "oemSsaGetData()++"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 578
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v6

    .line 579
    .local v6, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v6, :cond_0

    .line 639
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :goto_0
    return-object v8

    .line 582
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    invoke-interface {v6, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaGetData(I)Lcom/lge/internal/telephony/OEMSSADataResponse;

    move-result-object v5

    .line 583
    if-nez v5, :cond_1

    .line 584
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : OEMSSADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 634
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v2

    .line 635
    .local v2, "ex":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 587
    .end local v2    # "ex":Landroid/os/RemoteException;
    .restart local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_1
    :try_start_1
    iget v7, v5, Lcom/lge/internal/telephony/OEMSSADataResponse;->send_buf_num:I

    .line 588
    if-lez v7, :cond_3

    const/16 v9, 0x1000

    if-ge v7, v9, :cond_3

    .line 589
    mul-int/lit16 v9, v7, 0x7f8

    new-array v4, v9, [B

    .line 590
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

    .line 598
    :cond_2
    :goto_1
    if-ge v1, v7, :cond_6

    .line 599
    add-int/lit8 v1, v1, 0x1

    .line 600
    invoke-interface {v6, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaGetData(I)Lcom/lge/internal/telephony/OEMSSADataResponse;

    move-result-object v5

    .line 601
    if-nez v5, :cond_4

    .line 602
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : OEMSSADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 636
    .end local v6    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_1
    move-exception v2

    .line 637
    .local v2, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v2}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0

    .line 593
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

    .line 594
    if-eqz v7, :cond_2

    .line 595
    const/4 v7, 0x0

    goto :goto_1

    .line 605
    :cond_4
    iget v9, v5, Lcom/lge/internal/telephony/OEMSSADataResponse;->data_len:I

    add-int/2addr v9, v0

    array-length v10, v4

    if-le v9, v10, :cond_5

    .line 606
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Loop ERROR  : TOO Large data"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 609
    :cond_5
    iget-object v9, v5, Lcom/lge/internal/telephony/OEMSSADataResponse;->data:[B

    const/4 v10, 0x0

    iget v11, v5, Lcom/lge/internal/telephony/OEMSSADataResponse;->data_len:I

    invoke-static {v9, v10, v4, v0, v11}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 610
    iget v9, v5, Lcom/lge/internal/telephony/OEMSSADataResponse;->data_len:I

    add-int/2addr v0, v9

    goto :goto_1

    .line 615
    :cond_6
    const v9, 0xffff

    invoke-interface {v6, v9}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaGetData(I)Lcom/lge/internal/telephony/OEMSSADataResponse;

    move-result-object v5

    .line 616
    if-nez v5, :cond_7

    .line 617
    const-string v9, "LGTelephonyManagerImpl"

    const-string v10, "Internal Start ERROR : OEMSSADataResponse is NULL"

    invoke-static {v9, v10}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 620
    :cond_7
    if-nez v0, :cond_8

    .line 621
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

    .line 624
    :cond_8
    array-length v9, v4

    if-ge v0, v9, :cond_9

    .line 625
    new-array v3, v0, [B

    .line 626
    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static {v4, v9, v3, v10, v0}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 627
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

    .line 628
    goto/16 :goto_0

    .line 631
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

    .line 632
    goto/16 :goto_0
.end method

.method public oem_ssa_hdv_alarm_event([B)[B
    .locals 7
    .param p1, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    .line 512
    if-nez p1, :cond_2

    .line 513
    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .line 514
    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    .line 515
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 516
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .line 534
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_0
    :goto_0
    return-object v3

    .line 519
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaHdvAlarmEvent([B)[B

    move-result-object v3

    goto :goto_0

    .line 522
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

    .line 523
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 524
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    .line 527
    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaHdvAlarmEvent([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    goto :goto_0

    .line 529
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 530
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 531
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 532
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public oem_ssa_set_event([B)[B
    .locals 7
    .param p1, "mask"    # [B

    .prologue
    const/4 v3, 0x0

    .line 483
    if-nez p1, :cond_2

    .line 484
    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .line 485
    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    .line 486
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 487
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .line 505
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_0
    :goto_0
    return-object v3

    .line 490
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetEvent([B)[B

    move-result-object v3

    goto :goto_0

    .line 493
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

    .line 494
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 495
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    .line 498
    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetEvent([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    goto :goto_0

    .line 500
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 501
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 502
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 503
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

    .line 455
    if-nez p2, :cond_2

    .line 456
    const/4 v4, 0x1

    :try_start_0
    new-array v2, v4, [B

    .line 457
    .local v2, "unset":[B
    const/4 v4, 0x0

    const/4 v5, -0x1

    aput-byte v5, v2, v4

    .line 458
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 459
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .line 477
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":[B
    :cond_0
    :goto_0
    return-object v3

    .line 462
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":[B
    :cond_1
    invoke-interface {v1, p1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetLog([B[B)[B

    move-result-object v3

    goto :goto_0

    .line 465
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

    .line 466
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 467
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    .line 470
    invoke-interface {v1, p1, p2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetLog([B[B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    goto :goto_0

    .line 472
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 473
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 474
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 475
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public oem_ssa_set_mem(I)Z
    .locals 7
    .param p1, "percent"    # I

    .prologue
    const/4 v3, 0x0

    .line 645
    const/4 v4, -0x1

    if-ne p1, v4, :cond_2

    .line 646
    const/4 v2, 0x0

    .line 647
    .local v2, "unset":I
    move v2, p1

    .line 648
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 649
    .local v1, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v1, :cond_1

    .line 667
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v2    # "unset":I
    :cond_0
    :goto_0
    return v3

    .line 652
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v2    # "unset":I
    :cond_1
    invoke-interface {v1, v2}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetMem(I)Z

    move-result v3

    goto :goto_0

    .line 655
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

    .line 656
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 657
    .restart local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    .line 660
    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->oemSsaSetMem(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v3

    goto :goto_0

    .line 662
    .end local v1    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :catch_0
    move-exception v0

    .line 663
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 664
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 665
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public resetVoiceMessageCount()V
    .locals 2

    .prologue
    .line 438
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v0

    .line 439
    .local v0, "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v0, :cond_0

    .line 440
    invoke-interface {v0}, Lcom/lge/internal/telephony/ITelephonyEx;->resetVoiceMessageCount()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    .line 447
    .end local v0    # "telephony":Lcom/lge/internal/telephony/ITelephonyEx;
    :cond_0
    :goto_0
    return-void

    .line 444
    :catch_0
    move-exception v1

    goto :goto_0

    .line 442
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method public startMobileQualityInformation()V
    .locals 2

    .prologue
    .line 227
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->startMobileQualityInformation()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    .line 233
    :goto_0
    return-void

    .line 228
    :catch_0
    move-exception v0

    .line 229
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 230
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 231
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public stopMobileQualityInformation()V
    .locals 2

    .prologue
    .line 238
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->stopMobileQualityInformation()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    .line 244
    :goto_0
    return-void

    .line 239
    :catch_0
    move-exception v0

    .line 240
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .line 241
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 242
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_0
.end method

.method public uknight_event_set([B)[B
    .locals 4
    .param p1, "mask"    # [B

    .prologue
    .line 79
    if-nez p1, :cond_0

    .line 80
    const/4 v2, 0x1

    :try_start_0
    new-array v1, v2, [B

    .line 81
    .local v1, "unset":[B
    const/4 v2, 0x0

    const/4 v3, -0x1

    aput-byte v3, v1, v2

    .line 82
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightEventSet([B)[B

    move-result-object v2

    .line 92
    .end local v1    # "unset":[B
    :goto_0
    return-object v2

    .line 85
    :cond_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightEventSet([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    goto :goto_0

    .line 87
    :catch_0
    move-exception v0

    .line 88
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 92
    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    const/4 v2, 0x0

    goto :goto_0

    .line 89
    :catch_1
    move-exception v0

    .line 90
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method

.method public uknight_get_data()[B
    .locals 11

    .prologue
    const/4 v7, 0x0

    .line 118
    const/4 v5, 0x0

    .line 119
    .local v5, "logDataTemp":[B
    const/4 v4, 0x0

    .line 120
    .local v4, "logDataResult":[B
    const/4 v3, 0x0

    .line 121
    .local v3, "knDataResp":Lcom/lge/internal/telephony/KNDataResponse;
    const/4 v6, 0x0

    .line 122
    .local v6, "totBufNum":I
    const/4 v1, 0x0

    .line 123
    .local v1, "curBufNum":I
    const/4 v0, 0x0

    .line 125
    .local v0, "cumuDataSize":I
    const-string v8, "LGTelephonyManagerImpl"

    const-string v9, "uknightGetData()++"

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 127
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v8

    invoke-interface {v8, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightGetData(I)Lcom/lge/internal/telephony/KNDataResponse;

    move-result-object v3

    .line 128
    if-nez v3, :cond_0

    .line 129
    const-string v8, "LGTelephonyManagerImpl"

    const-string v9, "Internal Start ERROR : KNDataResponse is NULL"

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 170
    :goto_0
    return-object v7

    .line 133
    :cond_0
    iget v6, v3, Lcom/lge/internal/telephony/KNDataResponse;->send_buf_num:I

    .line 134
    if-lez v6, :cond_1

    const/16 v8, 0x1000

    if-ge v6, v8, :cond_1

    .line 136
    mul-int/lit16 v8, v6, 0x7f8

    new-array v5, v8, [B

    .line 137
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

    .line 143
    :goto_1
    if-ge v1, v6, :cond_4

    .line 144
    add-int/lit8 v1, v1, 0x1

    .line 145
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v8

    invoke-interface {v8, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightGetData(I)Lcom/lge/internal/telephony/KNDataResponse;

    move-result-object v3

    .line 146
    if-nez v3, :cond_2

    .line 147
    const-string v8, "LGTelephonyManagerImpl"

    const-string v9, "Internal Loop ERROR  : KNDataResponse is NULL"

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 164
    :catch_0
    move-exception v2

    .line 165
    .local v2, "ex":Landroid/os/RemoteException;
    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    .end local v2    # "ex":Landroid/os/RemoteException;
    :goto_2
    move-object v7, v4

    .line 170
    goto :goto_0

    .line 139
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

    .line 140
    const/4 v6, 0x0

    goto :goto_1

    .line 151
    :cond_2
    iget v8, v3, Lcom/lge/internal/telephony/KNDataResponse;->data_len:I

    add-int/2addr v8, v0

    array-length v9, v5

    if-le v8, v9, :cond_3

    .line 152
    const-string v8, "LGTelephonyManagerImpl"

    const-string v9, "Internal Loop ERROR  : TOO Large data"

    invoke-static {v8, v9}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 166
    :catch_1
    move-exception v2

    .line 167
    .local v2, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v2}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_2

    .line 157
    .end local v2    # "ex":Ljava/lang/NullPointerException;
    :cond_3
    :try_start_2
    iget-object v8, v3, Lcom/lge/internal/telephony/KNDataResponse;->data:[B

    const/4 v9, 0x0

    iget v10, v3, Lcom/lge/internal/telephony/KNDataResponse;->data_len:I

    invoke-static {v8, v9, v5, v0, v10}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 158
    iget v8, v3, Lcom/lge/internal/telephony/KNDataResponse;->data_len:I

    add-int/2addr v0, v8

    goto :goto_1

    .line 163
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
    .line 60
    if-nez p1, :cond_0

    .line 61
    const/4 v2, 0x1

    :try_start_0
    new-array v1, v2, [B

    .line 62
    .local v1, "unset":[B
    const/4 v2, 0x0

    const/4 v3, -0x1

    aput-byte v3, v1, v2

    .line 63
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightLogSet([B)[B

    move-result-object v2

    .line 74
    .end local v1    # "unset":[B
    :goto_0
    return-object v2

    .line 66
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

    .line 67
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightLogSet([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v2

    goto :goto_0

    .line 69
    :catch_0
    move-exception v0

    .line 70
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 74
    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    const/4 v2, 0x0

    goto :goto_0

    .line 71
    :catch_1
    move-exception v0

    .line 72
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method

.method public uknight_mem_check()[I
    .locals 2

    .prologue
    .line 206
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightMemCheck()[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 212
    :goto_0
    return-object v1

    .line 207
    :catch_0
    move-exception v0

    .line 208
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 212
    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    .line 209
    :catch_1
    move-exception v0

    .line 210
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method

.method public uknight_mem_set(I)Z
    .locals 2
    .param p1, "persent"    # I

    .prologue
    .line 108
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightMemSet(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    .line 114
    :goto_0
    return v1

    .line 109
    :catch_0
    move-exception v0

    .line 110
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 114
    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    .line 111
    :catch_1
    move-exception v0

    .line 112
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method

.method public uknight_state_change_set(I)Z
    .locals 2
    .param p1, "event"    # I

    .prologue
    .line 97
    :try_start_0
    invoke-direct {p0}, Lcom/lge/telephony/LGTelephonyManagerImpl;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    invoke-interface {v1, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->uknightStateChangeSet(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    .line 103
    :goto_0
    return v1

    .line 98
    :catch_0
    move-exception v0

    .line 99
    .local v0, "ex":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 103
    .end local v0    # "ex":Landroid/os/RemoteException;
    :goto_1
    const/4 v1, 0x0

    goto :goto_0

    .line 100
    :catch_1
    move-exception v0

    .line 101
    .local v0, "ex":Ljava/lang/NullPointerException;
    invoke-virtual {v0}, Ljava/lang/NullPointerException;->printStackTrace()V

    goto :goto_1
.end method
