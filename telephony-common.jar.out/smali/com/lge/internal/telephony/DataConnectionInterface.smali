.class public Lcom/lge/internal/telephony/DataConnectionInterface;
.super Ljava/lang/Object;
.source "DataConnectionInterface.java"


# static fields
.field private static final DBG:Z = true

.field private static final TAG:Ljava/lang/String; = "DataConnectionInterface "

.field private static sDataConnectionInterface:Lcom/lge/internal/telephony/DataConnectionInterface;


# instance fields
.field featureset:Ljava/lang/String;

.field private mContext:Landroid/content/Context;

.field private mPhoneBase:Lcom/android/internal/telephony/PhoneBase;

.field private mPhoneMgr:Lcom/android/internal/telephony/ITelephony;

.field private mPhoneProxy:Lcom/android/internal/telephony/PhoneProxy;


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "c"    # Landroid/content/Context;

    .prologue
    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    const-string v0, "DataConnectionInterface "

    const-string v1, "DataConnectionInterface() has created"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 48
    iput-object p1, p0, Lcom/lge/internal/telephony/DataConnectionInterface;->mContext:Landroid/content/Context;

    .line 50
    const-string v0, "phone"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/ITelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephony;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/internal/telephony/DataConnectionInterface;->mPhoneMgr:Lcom/android/internal/telephony/ITelephony;

    .line 54
    const-string v0, "ro.afwdata.LGfeatureset"

    const-string v1, "none"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/internal/telephony/DataConnectionInterface;->featureset:Ljava/lang/String;

    .line 55
    return-void
.end method

.method public static getInstance(Landroid/content/Context;)Lcom/lge/internal/telephony/DataConnectionInterface;
    .locals 1
    .param p0, "c"    # Landroid/content/Context;

    .prologue
    .line 68
    sget-object v0, Lcom/lge/internal/telephony/DataConnectionInterface;->sDataConnectionInterface:Lcom/lge/internal/telephony/DataConnectionInterface;

    if-nez v0, :cond_0

    .line 70
    new-instance v0, Lcom/lge/internal/telephony/DataConnectionInterface;

    invoke-direct {v0, p0}, Lcom/lge/internal/telephony/DataConnectionInterface;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/lge/internal/telephony/DataConnectionInterface;->sDataConnectionInterface:Lcom/lge/internal/telephony/DataConnectionInterface;

    .line 72
    :cond_0
    sget-object v0, Lcom/lge/internal/telephony/DataConnectionInterface;->sDataConnectionInterface:Lcom/lge/internal/telephony/DataConnectionInterface;

    return-object v0
.end method


# virtual methods
.method public functionForPacketDrop(Z)V
    .locals 5
    .param p1, "ok"    # Z

    .prologue
    .line 193
    const-string v2, "DataConnectionInterface "

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "functionForPacketDrop ok."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 194
    iget-object v2, p0, Lcom/lge/internal/telephony/DataConnectionInterface;->mContext:Landroid/content/Context;

    invoke-static {v2}, Lcom/android/internal/telephony/lgdata/DataConnectionManager;->getInstance(Landroid/content/Context;)Lcom/android/internal/telephony/lgdata/DataConnectionManager;

    move-result-object v0

    .line 198
    .local v0, "dcm":Lcom/android/internal/telephony/lgdata/DataConnectionManager;
    if-eqz v0, :cond_0

    .line 200
    :try_start_0
    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/lgdata/DataConnectionManager;->functionForPacketDrop(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 207
    :cond_0
    :goto_0
    return-void

    .line 203
    :catch_0
    move-exception v1

    .line 205
    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "DataConnectionInterface "

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "functionForPacketDrop exception"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getDataOnRoamingEnabled()Z
    .locals 8

    .prologue
    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 237
    const/4 v3, 0x0

    .line 238
    .local v3, "tm":Landroid/telephony/TelephonyManager;
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    .line 239
    const-string v6, "phone"

    invoke-static {v6}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v6

    invoke-static {v6}, Lcom/lge/internal/telephony/ITelephonyEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 242
    .local v1, "mPhoneServiceEx":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_1

    .line 244
    :try_start_0
    const-string v6, "getDataOnRoamingEnabled"

    invoke-interface {v1, v6}, Lcom/lge/internal/telephony/ITelephonyEx;->handleDataInterface(Ljava/lang/String;)I

    move-result v2

    .line 245
    .local v2, "result":I
    if-ne v2, v4, :cond_0

    .line 246
    const-string v6, "DataConnectionInterface "

    const-string v7, "getDataOnRoamingEnabled true!!"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 259
    .end local v2    # "result":I
    :goto_0
    return v4

    .line 250
    .restart local v2    # "result":I
    :cond_0
    const-string v4, "DataConnectionInterface "

    const-string v6, "getDataOnRoamingEnabled false!!"

    invoke-static {v4, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v4, v5

    .line 251
    goto :goto_0

    .line 254
    .end local v2    # "result":I
    :cond_1
    const-string v4, "DataConnectionInterface "

    const-string v6, "getDataOnRoamingEnabled Error!!"

    invoke-static {v4, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move v4, v5

    .line 255
    goto :goto_0

    .line 257
    :catch_0
    move-exception v0

    .line 258
    .local v0, "ex":Landroid/os/RemoteException;
    const-string v4, "DataConnectionInterface "

    const-string v6, "getDataOnRoamingEnabled RemoteException Error!!"

    invoke-static {v4, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v4, v5

    .line 259
    goto :goto_0
.end method

.method public handleConnectMobile()V
    .locals 5

    .prologue
    .line 86
    iget-object v3, p0, Lcom/lge/internal/telephony/DataConnectionInterface;->mContext:Landroid/content/Context;

    const-string v4, "connectivity"

    invoke-virtual {v3, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 88
    .local v0, "cm":Landroid/net/ConnectivityManager;
    const-string v3, "phone"

    invoke-static {v3}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/ITelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephony;

    move-result-object v1

    .line 89
    .local v1, "mPhoneService":Lcom/android/internal/telephony/ITelephony;
    const-string v3, "phone"

    invoke-static {v3}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v3

    invoke-static {v3}, Lcom/lge/internal/telephony/ITelephonyEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    .line 93
    .local v2, "mPhoneServiceEx":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v2, :cond_0

    .line 95
    :try_start_0
    const-string v3, "enable_mUserDataEnabled"

    invoke-interface {v2, v3}, Lcom/lge/internal/telephony/ITelephonyEx;->handleDataInterface(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 101
    :cond_0
    :goto_0
    return-void

    .line 98
    :catch_0
    move-exception v3

    goto :goto_0
.end method

.method public handleDisconnectMobile()V
    .locals 3

    .prologue
    .line 119
    const-string v1, "phone"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/internal/telephony/ITelephonyEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v0

    .line 120
    .local v0, "mPhoneServiceEx":Lcom/lge/internal/telephony/ITelephonyEx;
    const-string v1, "DataConnectionInterface "

    const-string v2, "handleDisconnectMobile !!"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 124
    if-eqz v0, :cond_0

    .line 127
    :try_start_0
    const-string v1, "disable_mUserDataEnabled"

    invoke-interface {v0, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->handleDataInterface(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1

    .line 136
    :cond_0
    :goto_0
    if-eqz v0, :cond_1

    .line 139
    :try_start_1
    const-string v1, "mobileData_PdpReset"

    invoke-interface {v0, v1}, Lcom/lge/internal/telephony/ITelephonyEx;->handleDataInterface(Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0

    .line 145
    :cond_1
    :goto_1
    return-void

    .line 143
    :catch_0
    move-exception v1

    goto :goto_1

    .line 131
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method public isDataPossible(I)Z
    .locals 9
    .param p1, "type"    # I

    .prologue
    const/4 v5, 0x1

    const/4 v6, 0x0

    .line 266
    sparse-switch p1, :sswitch_data_0

    .line 303
    :cond_0
    :goto_0
    return v5

    .line 268
    :sswitch_0
    const-string v0, "mms"

    .line 276
    .local v0, "apntype":Ljava/lang/String;
    :goto_1
    const/4 v4, 0x0

    .line 277
    .local v4, "tm":Landroid/telephony/TelephonyManager;
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v4

    .line 278
    const-string v7, "phone"

    invoke-static {v7}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v7

    invoke-static {v7}, Lcom/lge/internal/telephony/ITelephonyEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v2

    .line 279
    .local v2, "mPhoneServiceEx":Lcom/lge/internal/telephony/ITelephonyEx;
    if-nez v0, :cond_1

    .line 280
    const-string v5, "DataConnectionInterface "

    const-string v7, "[LGE_DATA] apntype null!!"

    invoke-static {v5, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v5, v6

    .line 281
    goto :goto_0

    .line 271
    .end local v0    # "apntype":Ljava/lang/String;
    .end local v2    # "mPhoneServiceEx":Lcom/lge/internal/telephony/ITelephonyEx;
    .end local v4    # "tm":Landroid/telephony/TelephonyManager;
    :sswitch_1
    const-string v0, "ims"

    .line 272
    .restart local v0    # "apntype":Ljava/lang/String;
    goto :goto_1

    .line 283
    .restart local v2    # "mPhoneServiceEx":Lcom/lge/internal/telephony/ITelephonyEx;
    .restart local v4    # "tm":Landroid/telephony/TelephonyManager;
    :cond_1
    if-nez v2, :cond_2

    .line 284
    const-string v5, "DataConnectionInterface "

    const-string v7, "[LGE_DATA] mPhoneServiceEx null!!"

    invoke-static {v5, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v5, v6

    .line 285
    goto :goto_0

    .line 290
    :cond_2
    :try_start_0
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "isDataPossible,"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v2, v7}, Lcom/lge/internal/telephony/ITelephonyEx;->handleDataInterface(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 292
    .local v3, "result":I
    if-eq v3, v5, :cond_0

    move v5, v6

    .line 298
    goto :goto_0

    .line 301
    .end local v3    # "result":I
    :catch_0
    move-exception v1

    .line 302
    .local v1, "ex":Landroid/os/RemoteException;
    const-string v5, "DataConnectionInterface "

    const-string v7, "isDataPossible RemoteException Error!!"

    invoke-static {v5, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v5, v6

    .line 303
    goto :goto_0

    .line 266
    nop

    :sswitch_data_0
    .sparse-switch
        0x2 -> :sswitch_0
        0xb -> :sswitch_1
    .end sparse-switch
.end method

.method public mobileDataPdpReset()V
    .locals 5

    .prologue
    .line 157
    const/4 v2, 0x0

    .line 158
    .local v2, "tm":Landroid/telephony/TelephonyManager;
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v2

    .line 159
    const-string v3, "phone"

    invoke-static {v3}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v3

    invoke-static {v3}, Lcom/lge/internal/telephony/ITelephonyEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 162
    .local v1, "mPhoneServiceEx":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_0

    .line 165
    :try_start_0
    const-string v3, "isRoamingOOS"

    invoke-interface {v1, v3}, Lcom/lge/internal/telephony/ITelephonyEx;->handleDataInterface(Ljava/lang/String;)I

    move-result v0

    .line 167
    .local v0, "isRoaming":I
    if-nez v0, :cond_1

    .line 170
    const-string v3, "DataConnectionInterface "

    const-string v4, "mobileDataPdpReset is not allowed when it is not in network roaming."

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 181
    .end local v0    # "isRoaming":I
    :cond_0
    :goto_0
    return-void

    .line 173
    .restart local v0    # "isRoaming":I
    :cond_1
    const-string v3, "DataConnectionInterface "

    const-string v4, "mobileDataPdpReset !!"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 175
    const-string v3, "mobileData_PdpReset"

    invoke-interface {v1, v3}, Lcom/lge/internal/telephony/ITelephonyEx;->handleDataInterface(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 179
    .end local v0    # "isRoaming":I
    :catch_0
    move-exception v3

    goto :goto_0
.end method

.method public setDataOnRoamingEnabled(Z)V
    .locals 5
    .param p1, "flag"    # Z

    .prologue
    .line 210
    const/4 v2, 0x0

    .line 211
    .local v2, "tm":Landroid/telephony/TelephonyManager;
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v2

    .line 212
    const-string v3, "phone"

    invoke-static {v3}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v3

    invoke-static {v3}, Lcom/lge/internal/telephony/ITelephonyEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/internal/telephony/ITelephonyEx;

    move-result-object v1

    .line 215
    .local v1, "mPhoneServiceEx":Lcom/lge/internal/telephony/ITelephonyEx;
    if-eqz v1, :cond_1

    .line 217
    if-eqz p1, :cond_0

    .line 218
    :try_start_0
    const-string v3, "setDataOnRoamingEnabled"

    invoke-interface {v1, v3}, Lcom/lge/internal/telephony/ITelephonyEx;->handleDataInterface(Ljava/lang/String;)I

    .line 219
    const-string v3, "DataConnectionInterface "

    const-string v4, "setDataOnRoamingEnabled true !!"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 233
    :goto_0
    return-void

    .line 222
    :cond_0
    const-string v3, "setDataOnRoamingDisabled"

    invoke-interface {v1, v3}, Lcom/lge/internal/telephony/ITelephonyEx;->handleDataInterface(Ljava/lang/String;)I

    .line 223
    const-string v3, "DataConnectionInterface "

    const-string v4, "setDataOnRoamingEnabled false !!"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 230
    :catch_0
    move-exception v0

    .line 231
    .local v0, "ex":Landroid/os/RemoteException;
    const-string v3, "DataConnectionInterface "

    const-string v4, "setDataOnRoamingEnabled RemoteException Error!!"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 227
    .end local v0    # "ex":Landroid/os/RemoteException;
    :cond_1
    :try_start_1
    const-string v3, "DataConnectionInterface "

    const-string v4, "setDataOnRoamingEnabled Error!!"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method
