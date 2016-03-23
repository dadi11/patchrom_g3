.class public Lcom/lge/internal/telephony/NetworkManagementServiceProxy;
.super Ljava/lang/Object;
.source "NetworkManagementServiceProxy.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "NetworkManagementServiceProxy"

.field private static acceptPacketMethod:Ljava/lang/reflect/Method;

.field private static dropPacketMethod:Ljava/lang/reflect/Method;

.field private static registerObserverExMethod:Ljava/lang/reflect/Method;

.field private static runShellCommandMethod:Ljava/lang/reflect/Method;

.field private static setMdmIptablesFileMethod:Ljava/lang/reflect/Method;

.field private static setMdmIptablesMethod:Ljava/lang/reflect/Method;

.field private static unregisterObserverExMethod:Ljava/lang/reflect/Method;


# instance fields
.field private mNetworkService:Landroid/os/INetworkManagementService;


# direct methods
.method static constructor <clinit>()V
    .locals 12

    .prologue
    const/4 v11, 0x1

    const/4 v10, 0x0

    .line 32
    new-array v6, v11, [Ljava/lang/Class;

    const-class v9, Ljava/lang/String;

    aput-object v9, v6, v10

    .line 33
    .local v6, "setMdmIptablesParamType":[Ljava/lang/Class;
    new-array v5, v11, [Ljava/lang/Class;

    const-class v9, Ljava/lang/String;

    aput-object v9, v5, v10

    .line 34
    .local v5, "setMdmIptablesFileParamType":[Ljava/lang/Class;
    new-array v1, v11, [Ljava/lang/Class;

    const-class v9, Ljava/lang/String;

    aput-object v9, v1, v10

    .line 35
    .local v1, "dropPacketParamType":[Ljava/lang/Class;
    new-array v0, v11, [Ljava/lang/Class;

    const-class v9, Ljava/lang/String;

    aput-object v9, v0, v10

    .line 36
    .local v0, "acceptPacketParamType":[Ljava/lang/Class;
    new-array v4, v11, [Ljava/lang/Class;

    const-class v9, Ljava/lang/String;

    aput-object v9, v4, v10

    .line 37
    .local v4, "runShellCommandParamType":[Ljava/lang/Class;
    new-array v3, v11, [Ljava/lang/Class;

    const-class v9, Ljava/lang/String;

    aput-object v9, v3, v10

    .line 38
    .local v3, "registerObserverExParamType":[Ljava/lang/Class;
    new-array v8, v11, [Ljava/lang/Class;

    const-class v9, Ljava/lang/String;

    aput-object v9, v8, v10

    .line 41
    .local v8, "unregisterObserverExParamType":[Ljava/lang/Class;
    :try_start_0
    const-class v9, Landroid/os/INetworkManagementService;

    const-string v10, "setMdmIptables"

    invoke-virtual {v9, v10, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v9

    sput-object v9, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->setMdmIptablesMethod:Ljava/lang/reflect/Method;

    .line 43
    const-class v9, Landroid/os/INetworkManagementService;

    const-string v10, "setMdmIptablesFile"

    invoke-virtual {v9, v10, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v9

    sput-object v9, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->setMdmIptablesFileMethod:Ljava/lang/reflect/Method;

    .line 45
    const-class v9, Landroid/os/INetworkManagementService;

    const-string v10, "dropPacket"

    invoke-virtual {v9, v10, v1}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v9

    sput-object v9, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->dropPacketMethod:Ljava/lang/reflect/Method;

    .line 47
    const-class v9, Landroid/os/INetworkManagementService;

    const-string v10, "acceptPacket"

    invoke-virtual {v9, v10, v0}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v9

    sput-object v9, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->acceptPacketMethod:Ljava/lang/reflect/Method;

    .line 49
    const-class v9, Landroid/os/INetworkManagementService;

    const-string v10, "runShellCommand"

    invoke-virtual {v9, v10, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v9

    sput-object v9, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->runShellCommandMethod:Ljava/lang/reflect/Method;

    .line 51
    const-class v9, Landroid/os/INetworkManagementService;

    const-string v10, "registerObserverEx"

    invoke-virtual {v9, v10, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v9

    sput-object v9, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->registerObserverExMethod:Ljava/lang/reflect/Method;

    .line 53
    const-class v9, Landroid/os/INetworkManagementService;

    const-string v10, "unregisterObserverEx"

    invoke-virtual {v9, v10, v8}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v9

    sput-object v9, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->unregisterObserverExMethod:Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    .line 62
    :goto_0
    return-void

    .line 56
    :catch_0
    move-exception v2

    .line 57
    .local v2, "e":Ljava/lang/NoSuchMethodException;
    const-string v9, "NetworkManagementServiceProxy"

    const-string v10, "No Such Method Exception"

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 58
    .end local v2    # "e":Ljava/lang/NoSuchMethodException;
    :catch_1
    move-exception v7

    .line 59
    .local v7, "t":Ljava/lang/Throwable;
    const-string v9, "NetworkManagementServiceProxy"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Throwable "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    const-string v0, "network_management"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Landroid/os/INetworkManagementService$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/INetworkManagementService;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->mNetworkService:Landroid/os/INetworkManagementService;

    .line 66
    iget-object v0, p0, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->mNetworkService:Landroid/os/INetworkManagementService;

    if-nez v0, :cond_0

    .line 67
    const-string v0, "NetworkManagementServiceProxy"

    const-string v1, "Unable to connect to network management service"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 70
    :cond_0
    return-void
.end method


# virtual methods
.method public registerObserverEx(Landroid/net/INetworkManagementEventObserverEx;)V
    .locals 4
    .param p1, "observer"    # Landroid/net/INetworkManagementEventObserverEx;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    .line 162
    sget-object v2, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->registerObserverExMethod:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_0

    .line 163
    const/4 v2, 0x1

    new-array v0, v2, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v0, v2

    .line 166
    .local v0, "args":[Ljava/lang/Object;
    :try_start_0
    sget-object v2, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->registerObserverExMethod:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->mNetworkService:Landroid/os/INetworkManagementService;

    invoke-virtual {v2, v3, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_2

    .line 178
    :goto_0
    return-void

    .line 167
    :catch_0
    move-exception v1

    .line 168
    .local v1, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v1}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_0

    .line 169
    .end local v1    # "e":Ljava/lang/IllegalArgumentException;
    :catch_1
    move-exception v1

    .line 170
    .local v1, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v1}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    .line 171
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catch_2
    move-exception v1

    .line 172
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v1}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_0

    .line 176
    .end local v0    # "args":[Ljava/lang/Object;
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_0
    new-instance v2, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v2}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v2
.end method

.method public runShellCommand(Ljava/lang/String;)V
    .locals 4
    .param p1, "cmd"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    .line 134
    sget-object v2, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->runShellCommandMethod:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_0

    .line 135
    const/4 v2, 0x1

    new-array v0, v2, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v0, v2

    .line 138
    .local v0, "args":[Ljava/lang/Object;
    :try_start_0
    sget-object v2, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->runShellCommandMethod:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->mNetworkService:Landroid/os/INetworkManagementService;

    invoke-virtual {v2, v3, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_2

    .line 150
    :goto_0
    return-void

    .line 139
    :catch_0
    move-exception v1

    .line 140
    .local v1, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v1}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_0

    .line 141
    .end local v1    # "e":Ljava/lang/IllegalArgumentException;
    :catch_1
    move-exception v1

    .line 142
    .local v1, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v1}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    .line 143
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catch_2
    move-exception v1

    .line 144
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v1}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_0

    .line 148
    .end local v0    # "args":[Ljava/lang/Object;
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_0
    new-instance v2, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v2}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v2
.end method

.method public setMdmIptables(Ljava/lang/String;)V
    .locals 4
    .param p1, "command"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    .line 81
    sget-object v2, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->setMdmIptablesMethod:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_0

    .line 82
    const/4 v2, 0x1

    new-array v0, v2, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v0, v2

    .line 85
    .local v0, "args":[Ljava/lang/Object;
    :try_start_0
    sget-object v2, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->setMdmIptablesMethod:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->mNetworkService:Landroid/os/INetworkManagementService;

    invoke-virtual {v2, v3, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_2

    .line 96
    :goto_0
    return-void

    .line 86
    :catch_0
    move-exception v1

    .line 87
    .local v1, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v1}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_0

    .line 88
    .end local v1    # "e":Ljava/lang/IllegalArgumentException;
    :catch_1
    move-exception v1

    .line 89
    .local v1, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v1}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    .line 90
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catch_2
    move-exception v1

    .line 91
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v1}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_0

    .line 94
    .end local v0    # "args":[Ljava/lang/Object;
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_0
    new-instance v2, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v2}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v2
.end method

.method public setMdmIptablesFile(Ljava/lang/String;)V
    .locals 4
    .param p1, "path"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    .line 107
    sget-object v2, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->setMdmIptablesFileMethod:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_0

    .line 108
    const/4 v2, 0x1

    new-array v0, v2, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v0, v2

    .line 111
    .local v0, "args":[Ljava/lang/Object;
    :try_start_0
    sget-object v2, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->setMdmIptablesFileMethod:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->mNetworkService:Landroid/os/INetworkManagementService;

    invoke-virtual {v2, v3, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_2

    .line 123
    :goto_0
    return-void

    .line 112
    :catch_0
    move-exception v1

    .line 113
    .local v1, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v1}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_0

    .line 114
    .end local v1    # "e":Ljava/lang/IllegalArgumentException;
    :catch_1
    move-exception v1

    .line 115
    .local v1, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v1}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    .line 116
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catch_2
    move-exception v1

    .line 117
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v1}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_0

    .line 121
    .end local v0    # "args":[Ljava/lang/Object;
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_0
    new-instance v2, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v2}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v2
.end method

.method public unregisterObserverEx(Landroid/net/INetworkManagementEventObserverEx;)V
    .locals 4
    .param p1, "observer"    # Landroid/net/INetworkManagementEventObserverEx;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    .line 190
    sget-object v2, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->unregisterObserverExMethod:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_0

    .line 191
    const/4 v2, 0x1

    new-array v0, v2, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v0, v2

    .line 194
    .local v0, "args":[Ljava/lang/Object;
    :try_start_0
    sget-object v2, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->unregisterObserverExMethod:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/lge/internal/telephony/NetworkManagementServiceProxy;->mNetworkService:Landroid/os/INetworkManagementService;

    invoke-virtual {v2, v3, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_2

    .line 206
    :goto_0
    return-void

    .line 195
    :catch_0
    move-exception v1

    .line 196
    .local v1, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v1}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_0

    .line 197
    .end local v1    # "e":Ljava/lang/IllegalArgumentException;
    :catch_1
    move-exception v1

    .line 198
    .local v1, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v1}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    .line 199
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catch_2
    move-exception v1

    .line 200
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v1}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_0

    .line 204
    .end local v0    # "args":[Ljava/lang/Object;
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_0
    new-instance v2, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v2}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v2
.end method
