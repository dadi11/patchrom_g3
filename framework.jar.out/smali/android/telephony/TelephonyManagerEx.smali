.class public Landroid/telephony/TelephonyManagerEx;
.super Ljava/lang/Object;
.source "TelephonyManagerEx.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "TelephonyManagerEx"

.field private static sInstance:Landroid/telephony/TelephonyManagerEx;


# instance fields
.field private mContext:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 16
    new-instance v0, Landroid/telephony/TelephonyManagerEx;

    invoke-direct {v0}, Landroid/telephony/TelephonyManagerEx;-><init>()V

    sput-object v0, Landroid/telephony/TelephonyManagerEx;->sInstance:Landroid/telephony/TelephonyManagerEx;

    return-void
.end method

.method protected constructor <init>()V
    .locals 1

    .prologue
    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    const/4 v0, 0x0

    iput-object v0, p0, Landroid/telephony/TelephonyManagerEx;->mContext:Landroid/content/Context;

    .line 23
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    iput-object p1, p0, Landroid/telephony/TelephonyManagerEx;->mContext:Landroid/content/Context;

    .line 31
    return-void
.end method

.method public static getDefault()Landroid/telephony/TelephonyManagerEx;
    .locals 1

    .prologue
    .line 38
    sget-object v0, Landroid/telephony/TelephonyManagerEx;->sInstance:Landroid/telephony/TelephonyManagerEx;

    return-object v0
.end method

.method private getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;
    .locals 1

    .prologue
    .line 42
    const-string/jumbo v0, "phone"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/internal/telephony/ITelephonyEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v0

    return-object v0
.end method

.method private getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;
    .locals 1

    .prologue
    .line 47
    const-string v0, "iphonesubinfo"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/internal/telephony/IPhoneSubInfoEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v0

    return-object v0
.end method

.method private handleDataInterface(Ljava/lang/String;)V
    .locals 1
    .param p1, "arg0"    # Ljava/lang/String;

    .prologue
    .line 245
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->handleDataInterface(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    .line 249
    :goto_0
    return-void

    .line 247
    :catch_0
    move-exception v0

    goto :goto_0

    .line 246
    :catch_1
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method public calculateAkaResponse([B[B)Landroid/os/Bundle;
    .locals 3
    .param p1, "arg0"    # [B
    .param p2, "arg1"    # [B

    .prologue
    const/4 v1, 0x0

    .line 59
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, p1, p2}, Lcom/lge/internal/telephony/ITelephonyEx;->calculateAkaResponse([B[B)Landroid/os/Bundle;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 63
    :goto_0
    return-object v1

    .line 60
    :catch_0
    move-exception v0

    .line 61
    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0

    .line 62
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 63
    .local v0, "e":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public calculateGbaBootstrappingResponse([B[B)Landroid/os/Bundle;
    .locals 3
    .param p1, "arg0"    # [B
    .param p2, "arg1"    # [B

    .prologue
    const/4 v1, 0x0

    .line 77
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, p1, p2}, Lcom/lge/internal/telephony/ITelephonyEx;->calculateGbaBootstrappingResponse([B[B)Landroid/os/Bundle;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 81
    :goto_0
    return-object v1

    .line 78
    :catch_0
    move-exception v0

    .line 79
    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0

    .line 80
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 81
    .local v0, "e":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public calculateNafExternalKey([B)[B
    .locals 3
    .param p1, "arg0"    # [B

    .prologue
    const/4 v1, 0x0

    .line 93
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->calculateNafExternalKey([B)[B
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 97
    :goto_0
    return-object v1

    .line 94
    :catch_0
    move-exception v0

    .line 95
    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0

    .line 96
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 97
    .local v0, "e":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public checkDataProfileEx(II)Z
    .locals 3
    .param p1, "arg0"    # I
    .param p2, "arg1"    # I

    .prologue
    const/4 v1, 0x0

    .line 110
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, p1, p2}, Lcom/lge/internal/telephony/ITelephonyEx;->checkDataProfileEx(II)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    .line 114
    :goto_0
    return v1

    .line 111
    :catch_0
    move-exception v0

    .line 112
    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0

    .line 113
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 114
    .local v0, "e":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public clearDataDisabledFlag(I)I
    .locals 3
    .param p1, "arg0"    # I

    .prologue
    const/4 v1, 0x0

    .line 126
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/internal/telephony/ITelephonyEx;->clearDataDisabledFlag(I)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    .line 130
    :goto_0
    return v1

    .line 127
    :catch_0
    move-exception v0

    .line 128
    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0

    .line 129
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 130
    .local v0, "e":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getAPNList()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 141
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/internal/telephony/ITelephonyEx;->getAPNList()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 145
    :goto_0
    return-object v1

    .line 142
    :catch_0
    move-exception v0

    .line 143
    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0

    .line 144
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 145
    .local v0, "e":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getDebugInfo(II)[I
    .locals 3
    .param p1, "arg0"    # I
    .param p2, "arg1"    # I

    .prologue
    const/4 v1, 0x0

    .line 158
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, p1, p2}, Lcom/lge/internal/telephony/ITelephonyEx;->getDebugInfo(II)[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 162
    :goto_0
    return-object v1

    .line 159
    :catch_0
    move-exception v0

    .line 160
    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0

    .line 161
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 162
    .local v0, "e":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getDeviceId(I)Ljava/lang/String;
    .locals 1
    .param p1, "slotId"    # I

    .prologue
    .line 368
    const-string v0, ""

    return-object v0
.end method

.method public getDeviceIdForVZW(I)Ljava/lang/String;
    .locals 3
    .param p1, "type"    # I

    .prologue
    const/4 v1, 0x0

    .line 305
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/lge/internal/telephony/IPhoneSubInfoEx;->getDeviceIdForVZW(I)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 312
    :goto_0
    return-object v1

    .line 306
    :catch_0
    move-exception v0

    .line 307
    .local v0, "ex":Landroid/os/RemoteException;
    goto :goto_0

    .line 308
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 312
    .local v0, "ex":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getEsn()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 351
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/internal/telephony/IPhoneSubInfoEx;->getEsn()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 355
    :goto_0
    return-object v1

    .line 352
    :catch_0
    move-exception v0

    .line 353
    .local v0, "ex":Landroid/os/RemoteException;
    goto :goto_0

    .line 354
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 355
    .local v0, "ex":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getIccFdnEnabled()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 173
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/internal/telephony/ITelephonyEx;->getIccFdnEnabled()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    .line 177
    :goto_0
    return v1

    .line 174
    :catch_0
    move-exception v0

    .line 175
    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0

    .line 176
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 177
    .local v0, "e":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getLine1Number()Ljava/lang/String;
    .locals 1

    .prologue
    .line 367
    const-string v0, ""

    return-object v0
.end method

.method public getMSIN()Ljava/lang/String;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 273
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/internal/telephony/IPhoneSubInfoEx;->getMSIN()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 280
    :goto_0
    return-object v1

    .line 274
    :catch_0
    move-exception v0

    .line 275
    .local v0, "ex":Landroid/os/RemoteException;
    goto :goto_0

    .line 276
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 280
    .local v0, "ex":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getMSIN(J)Ljava/lang/String;
    .locals 3
    .param p1, "subId"    # J

    .prologue
    const/4 v1, 0x0

    .line 285
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v2

    invoke-interface {v2, p1, p2}, Lcom/lge/internal/telephony/IPhoneSubInfoEx;->getMSINUsingSubId(J)Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 292
    :goto_0
    return-object v1

    .line 286
    :catch_0
    move-exception v0

    .line 287
    .local v0, "ex":Landroid/os/RemoteException;
    goto :goto_0

    .line 288
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 292
    .local v0, "ex":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getMipErrorCode()I
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 188
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/internal/telephony/ITelephonyEx;->getMipErrorCode()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    .line 192
    :goto_0
    return v1

    .line 189
    :catch_0
    move-exception v0

    .line 190
    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0

    .line 191
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 192
    .local v0, "e":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getSimState(I)I
    .locals 1
    .param p1, "slotId"    # I

    .prologue
    .line 363
    const/4 v0, 0x0

    return v0
.end method

.method public getTimeFromSIB16String()[J
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 333
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/internal/telephony/IPhoneSubInfoEx;->getTimeFromSIB16String()[J
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 338
    :goto_0
    return-object v1

    .line 334
    :catch_0
    move-exception v0

    .line 335
    .local v0, "ex":Landroid/os/RemoteException;
    goto :goto_0

    .line 336
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 338
    .local v0, "ex":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public getValueFromSIB16String()[I
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 321
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getSubscriberInfoEx()Lcom/lge/internal/telephony/IPhoneSubInfoEx;

    move-result-object v2

    invoke-interface {v2}, Lcom/lge/internal/telephony/IPhoneSubInfoEx;->getValueFromSIB16String()[I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v1

    .line 326
    :goto_0
    return-object v1

    .line 322
    :catch_0
    move-exception v0

    .line 323
    .local v0, "ex":Landroid/os/RemoteException;
    goto :goto_0

    .line 324
    .end local v0    # "ex":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 326
    .local v0, "ex":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public mobileDataPdpReset()V
    .locals 1

    .prologue
    .line 267
    const-string/jumbo v0, "mobileData_PdpReset"

    invoke-direct {p0, v0}, Landroid/telephony/TelephonyManagerEx;->handleDataInterface(Ljava/lang/String;)V

    .line 268
    return-void
.end method

.method public resetVoiceMessageCount()V
    .locals 1

    .prologue
    .line 202
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v0

    invoke-interface {v0}, Lcom/lge/internal/telephony/ITelephonyEx;->resetVoiceMessageCount()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    .line 206
    :goto_0
    return-void

    .line 204
    :catch_0
    move-exception v0

    goto :goto_0

    .line 203
    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method public setDataDisabledFlag(II)I
    .locals 3
    .param p1, "arg0"    # I
    .param p2, "arg1"    # I

    .prologue
    const/4 v1, 0x0

    .line 217
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    invoke-interface {v2, p1, p2}, Lcom/lge/internal/telephony/ITelephonyEx;->setDataDisabledFlag(II)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v1

    .line 221
    :goto_0
    return v1

    .line 218
    :catch_0
    move-exception v0

    .line 219
    .local v0, "e":Landroid/os/RemoteException;
    goto :goto_0

    .line 220
    .end local v0    # "e":Landroid/os/RemoteException;
    :catch_1
    move-exception v0

    .line 221
    .local v0, "e":Ljava/lang/NullPointerException;
    goto :goto_0
.end method

.method public setGbaBootstrappingParams([BLjava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "arg0"    # [B
    .param p2, "arg1"    # Ljava/lang/String;
    .param p3, "arg2"    # Ljava/lang/String;

    .prologue
    .line 234
    :try_start_0
    invoke-direct {p0}, Landroid/telephony/TelephonyManagerEx;->getITelephonyEx()Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v0

    invoke-interface {v0, p1, p2, p3}, Lcom/lge/internal/telephony/ITelephonyEx;->setGbaBootstrappingParams([BLjava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    .line 238
    :goto_0
    return-void

    .line 236
    :catch_0
    move-exception v0

    goto :goto_0

    .line 235
    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method public setRoamingDataEnabled_RILCMD(Z)V
    .locals 1
    .param p1, "enabled"    # Z

    .prologue
    .line 256
    if-eqz p1, :cond_0

    .line 257
    const-string/jumbo v0, "setDataRoamingEnabled"

    invoke-direct {p0, v0}, Landroid/telephony/TelephonyManagerEx;->handleDataInterface(Ljava/lang/String;)V

    .line 261
    :goto_0
    return-void

    .line 259
    :cond_0
    const-string/jumbo v0, "setDataRoamingDisabled"

    invoke-direct {p0, v0}, Landroid/telephony/TelephonyManagerEx;->handleDataInterface(Ljava/lang/String;)V

    goto :goto_0
.end method
