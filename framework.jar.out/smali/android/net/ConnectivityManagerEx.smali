.class public Landroid/net/ConnectivityManagerEx;
.super Landroid/net/ConnectivityManager;
.source "ConnectivityManagerEx.java"


# static fields
.field public static final TYPE_MOBILE_ADMIN:I = 0x16

.field public static final TYPE_MOBILE_EMERGENCY:I = 0x14

.field public static final TYPE_MOBILE_VZW800:I = 0x11

.field public static final TYPE_MOBILE_VZWAPP:I = 0x10


# instance fields
.field private final mService:Landroid/net/IConnectivityManagerEx;


# direct methods
.method public constructor <init>(Landroid/net/IConnectivityManager;)V
    .locals 1
    .param p1, "service"    # Landroid/net/IConnectivityManager;

    .prologue
    .line 33
    invoke-direct {p0, p1}, Landroid/net/ConnectivityManager;-><init>(Landroid/net/IConnectivityManager;)V

    .line 34
    invoke-interface {p1}, Landroid/net/IConnectivityManager;->asBinder()Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Landroid/net/IConnectivityManagerEx$Stub;->asInterface(Landroid/os/IBinder;)Landroid/net/IConnectivityManagerEx;

    move-result-object v0

    iput-object v0, p0, Landroid/net/ConnectivityManagerEx;->mService:Landroid/net/IConnectivityManagerEx;

    .line 35
    return-void
.end method


# virtual methods
.method public getLteRssi()I
    .locals 2

    .prologue
    .line 42
    :try_start_0
    iget-object v1, p0, Landroid/net/ConnectivityManagerEx;->mService:Landroid/net/IConnectivityManagerEx;

    invoke-interface {v1}, Landroid/net/IConnectivityManagerEx;->getLteRssi()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 44
    :goto_0
    return v1

    .line 43
    :catch_0
    move-exception v0

    .line 44
    .local v0, "e":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getMobileDataEnabled()Z
    .locals 5

    .prologue
    const/4 v3, 0x0

    .line 52
    const-string/jumbo v4, "phone"

    invoke-static {v4}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .line 53
    .local v0, "b":Landroid/os/IBinder;
    if-eqz v0, :cond_0

    .line 55
    :try_start_0
    invoke-static {v0}, Lcom/android/internal/telephony/ITelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephony;

    move-result-object v2

    .line 56
    .local v2, "it":Lcom/android/internal/telephony/ITelephony;
    invoke-interface {v2}, Lcom/android/internal/telephony/ITelephony;->getDataEnabled()Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 61
    .end local v2    # "it":Lcom/android/internal/telephony/ITelephony;
    :cond_0
    :goto_0
    return v3

    .line 57
    :catch_0
    move-exception v1

    .line 58
    .local v1, "e":Landroid/os/RemoteException;
    goto :goto_0
.end method
