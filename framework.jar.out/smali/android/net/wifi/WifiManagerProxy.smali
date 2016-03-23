.class public Landroid/net/wifi/WifiManagerProxy;
.super Ljava/lang/Object;
.source "WifiManagerProxy.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "WifiManagerProxy"

.field private static getWifiNeedOnMethod:Ljava/lang/reflect/Method;

.field private static setVZWWifiApEnabledMethod:Ljava/lang/reflect/Method;

.field private static setWifiNeedOnMethod:Ljava/lang/reflect/Method;


# instance fields
.field private mWifiManager:Landroid/net/wifi/WifiManager;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 26
    const/4 v3, 0x2

    new-array v1, v3, [Ljava/lang/Class;

    const-class v3, Landroid/net/wifi/WifiConfiguration;

    aput-object v3, v1, v4

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v5

    .line 29
    .local v1, "setVZWWifiApEnabledParamType":[Ljava/lang/Class;
    new-array v2, v5, [Ljava/lang/Class;

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v2, v4

    .line 32
    .local v2, "setWifiNeedOnParamType":[Ljava/lang/Class;
    new-array v0, v4, [Ljava/lang/Class;

    .line 36
    .local v0, "getWifiNeedOnParamType":[Ljava/lang/Class;
    :try_start_0
    const-class v3, Landroid/net/wifi/WifiManager;

    const-string/jumbo v4, "setVZWWifiApEnabled"

    invoke-virtual {v3, v4, v1}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    sput-object v3, Landroid/net/wifi/WifiManagerProxy;->setVZWWifiApEnabledMethod:Ljava/lang/reflect/Method;

    .line 38
    const-class v3, Landroid/net/wifi/WifiManager;

    const-string v4, "getWifiNeedOn"

    invoke-virtual {v3, v4, v0}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    sput-object v3, Landroid/net/wifi/WifiManagerProxy;->getWifiNeedOnMethod:Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    .line 43
    :goto_0
    return-void

    .line 40
    :catch_0
    move-exception v3

    goto :goto_0
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 51
    if-eqz p1, :cond_0

    .line 52
    const-string/jumbo v0, "wifi"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    iput-object v0, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    .line 53
    const-string v0, "WifiManagerProxy"

    const-string v1, "WifiManagerProxy is created"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 58
    :goto_0
    return-void

    .line 56
    :cond_0
    const-string v0, "WifiManagerProxy"

    const-string v1, "WifiManagerProxy is created - fail"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method


# virtual methods
.method public getWifiNeedOn()Z
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    .line 142
    sget-object v3, Landroid/net/wifi/WifiManagerProxy;->getWifiNeedOnMethod:Ljava/lang/reflect/Method;

    if-eqz v3, :cond_1

    iget-object v3, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v3, :cond_1

    .line 143
    new-array v0, v4, [Ljava/lang/Object;

    .line 145
    .local v0, "args":[Ljava/lang/Object;
    :try_start_0
    sget-object v3, Landroid/net/wifi/WifiManagerProxy;->getWifiNeedOnMethod:Ljava/lang/reflect/Method;

    iget-object v5, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    invoke-virtual {v3, v5, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_2

    move-result v3

    .line 161
    .end local v0    # "args":[Ljava/lang/Object;
    :goto_0
    return v3

    .line 146
    .restart local v0    # "args":[Ljava/lang/Object;
    :catch_0
    move-exception v2

    .line 147
    .local v2, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v2}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    .end local v2    # "e":Ljava/lang/IllegalArgumentException;
    :cond_0
    :goto_1
    move v3, v4

    .line 156
    goto :goto_0

    .line 148
    :catch_1
    move-exception v2

    .line 149
    .local v2, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v2}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_1

    .line 150
    .end local v2    # "e":Ljava/lang/IllegalAccessException;
    :catch_2
    move-exception v2

    .line 151
    .local v2, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v2}, Ljava/lang/reflect/InvocationTargetException;->getCause()Ljava/lang/Throwable;

    move-result-object v1

    .line 152
    .local v1, "cause":Ljava/lang/Throwable;
    instance-of v3, v1, Landroid/os/RemoteException;

    if-eqz v3, :cond_0

    .line 153
    check-cast v1, Landroid/os/RemoteException;

    .end local v1    # "cause":Ljava/lang/Throwable;
    throw v1

    .line 160
    .end local v0    # "args":[Ljava/lang/Object;
    .end local v2    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_1
    const-string v3, "WifiManagerProxy"

    const-string v5, "getWifiNeedOn method isn\'t implemented yet"

    invoke-static {v3, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v3, v4

    .line 161
    goto :goto_0
.end method

.method public setVZWWifiApEnabled(Landroid/net/wifi/WifiConfiguration;Z)Z
    .locals 6
    .param p1, "wifiConfig"    # Landroid/net/wifi/WifiConfiguration;
    .param p2, "enabled"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    .line 70
    sget-object v3, Landroid/net/wifi/WifiManagerProxy;->setVZWWifiApEnabledMethod:Ljava/lang/reflect/Method;

    if-eqz v3, :cond_1

    iget-object v3, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v3, :cond_1

    .line 71
    const/4 v3, 0x2

    new-array v0, v3, [Ljava/lang/Object;

    aput-object p1, v0, v4

    const/4 v3, 0x1

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v0, v3

    .line 75
    .local v0, "args":[Ljava/lang/Object;
    :try_start_0
    sget-object v3, Landroid/net/wifi/WifiManagerProxy;->setVZWWifiApEnabledMethod:Ljava/lang/reflect/Method;

    iget-object v5, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    invoke-virtual {v3, v5, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_2

    move-result v3

    .line 91
    .end local v0    # "args":[Ljava/lang/Object;
    :goto_0
    return v3

    .line 76
    .restart local v0    # "args":[Ljava/lang/Object;
    :catch_0
    move-exception v2

    .line 77
    .local v2, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v2}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    .end local v2    # "e":Ljava/lang/IllegalArgumentException;
    :cond_0
    :goto_1
    move v3, v4

    .line 86
    goto :goto_0

    .line 78
    :catch_1
    move-exception v2

    .line 79
    .local v2, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v2}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_1

    .line 80
    .end local v2    # "e":Ljava/lang/IllegalAccessException;
    :catch_2
    move-exception v2

    .line 81
    .local v2, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v2}, Ljava/lang/reflect/InvocationTargetException;->getCause()Ljava/lang/Throwable;

    move-result-object v1

    .line 82
    .local v1, "cause":Ljava/lang/Throwable;
    instance-of v3, v1, Landroid/os/RemoteException;

    if-eqz v3, :cond_0

    .line 83
    check-cast v1, Landroid/os/RemoteException;

    .end local v1    # "cause":Ljava/lang/Throwable;
    throw v1

    .line 90
    .end local v0    # "args":[Ljava/lang/Object;
    .end local v2    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_1
    const-string v3, "WifiManagerProxy"

    const-string/jumbo v5, "setVZWWifiApEnabled method isn\'t implemented yet"

    invoke-static {v3, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v3, v4

    .line 91
    goto :goto_0
.end method

.method public setWifiApEnabled(Z)V
    .locals 4
    .param p1, "enabled"    # Z

    .prologue
    .line 169
    iget-object v1, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v1, :cond_0

    .line 171
    :try_start_0
    iget-object v1, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    const/4 v2, 0x0

    invoke-virtual {v1, v2, p1}, Landroid/net/wifi/WifiManager;->setWifiApEnabled(Landroid/net/wifi/WifiConfiguration;Z)Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 176
    :cond_0
    :goto_0
    return-void

    .line 172
    :catch_0
    move-exception v0

    .line 173
    .local v0, "se":Ljava/lang/SecurityException;
    const-string v1, "WifiManagerProxy"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SecurityException : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/SecurityException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setWifiEnabled(Z)V
    .locals 1
    .param p1, "enabled"    # Z

    .prologue
    .line 184
    iget-object v0, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 185
    iget-object v0, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    invoke-virtual {v0, p1}, Landroid/net/wifi/WifiManager;->setWifiEnabled(Z)Z

    .line 187
    :cond_0
    return-void
.end method

.method public setWifiNeedOn(Z)Z
    .locals 6
    .param p1, "enable"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    .line 107
    sget-object v3, Landroid/net/wifi/WifiManagerProxy;->setWifiNeedOnMethod:Ljava/lang/reflect/Method;

    if-eqz v3, :cond_1

    iget-object v3, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v3, :cond_1

    .line 108
    const/4 v3, 0x1

    new-array v0, v3, [Ljava/lang/Object;

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    aput-object v3, v0, v4

    .line 112
    .local v0, "args":[Ljava/lang/Object;
    :try_start_0
    sget-object v3, Landroid/net/wifi/WifiManagerProxy;->setWifiNeedOnMethod:Ljava/lang/reflect/Method;

    iget-object v5, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    invoke-virtual {v3, v5, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_2

    move-result v3

    .line 128
    .end local v0    # "args":[Ljava/lang/Object;
    :goto_0
    return v3

    .line 113
    .restart local v0    # "args":[Ljava/lang/Object;
    :catch_0
    move-exception v2

    .line 114
    .local v2, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v2}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    .end local v2    # "e":Ljava/lang/IllegalArgumentException;
    :cond_0
    :goto_1
    move v3, v4

    .line 123
    goto :goto_0

    .line 115
    :catch_1
    move-exception v2

    .line 116
    .local v2, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v2}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_1

    .line 117
    .end local v2    # "e":Ljava/lang/IllegalAccessException;
    :catch_2
    move-exception v2

    .line 118
    .local v2, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v2}, Ljava/lang/reflect/InvocationTargetException;->getCause()Ljava/lang/Throwable;

    move-result-object v1

    .line 119
    .local v1, "cause":Ljava/lang/Throwable;
    instance-of v3, v1, Landroid/os/RemoteException;

    if-eqz v3, :cond_0

    .line 120
    check-cast v1, Landroid/os/RemoteException;

    .end local v1    # "cause":Ljava/lang/Throwable;
    throw v1

    .line 127
    .end local v0    # "args":[Ljava/lang/Object;
    .end local v2    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_1
    const-string v3, "WifiManagerProxy"

    const-string/jumbo v5, "setWifiNeedOn method isn\'t implemented yet"

    invoke-static {v3, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v3, v4

    .line 128
    goto :goto_0
.end method

.method public startScan()Z
    .locals 1

    .prologue
    .line 195
    iget-object v0, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 196
    iget-object v0, p0, Landroid/net/wifi/WifiManagerProxy;->mWifiManager:Landroid/net/wifi/WifiManager;

    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->startScan()Z

    move-result v0

    .line 198
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method