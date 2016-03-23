.class public Lcom/lge/wfds/send/WfdsSendReceiverFactory;
.super Ljava/lang/Object;
.source "WfdsSendReceiverFactory.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "WfdsSendReceiverFactory"

.field private static mWfdsSendReceiverClass:Ljava/lang/Class;

.field private static sWfdsSendReceiverIface:Lcom/lge/wfds/send/receiver/WfdsSendReceiverIface;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v2, 0x0

    const/4 v3, 0x1

    sput-object v2, Lcom/lge/wfds/send/WfdsSendReceiverFactory;->mWfdsSendReceiverClass:Ljava/lang/Class;

    sput-object v2, Lcom/lge/wfds/send/WfdsSendReceiverFactory;->sWfdsSendReceiverIface:Lcom/lge/wfds/send/receiver/WfdsSendReceiverIface;

    sget-boolean v2, Lcom/lge/config/ConfigBuildFlags;->CAPP_WFDS_SEND:Z

    if-ne v2, v3, :cond_1

    :try_start_0
    sget-object v2, Lcom/lge/wfds/send/WfdsSendReceiverFactory;->mWfdsSendReceiverClass:Ljava/lang/Class;

    if-nez v2, :cond_0

    const-string v2, "WfdsSendReceiverFactory"

    const-string v3, "Load Class"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Ldalvik/system/PathClassLoader;

    const-string v2, "/system/framework/com.lge.wfds.send.jar"

    const-class v3, Lcom/lge/wfds/send/WfdsSendIfaceManager;

    invoke-virtual {v3}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v3

    invoke-direct {v0, v2, v3}, Ldalvik/system/PathClassLoader;-><init>(Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .local v0, "cLoader":Ljava/lang/ClassLoader;
    const-string v2, "com.lge.wfds.send.receiver.WfdsSendReceiver"

    const/4 v3, 0x1

    invoke-static {v2, v3, v0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v2

    sput-object v2, Lcom/lge/wfds/send/WfdsSendReceiverFactory;->mWfdsSendReceiverClass:Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .local v1, "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    return-void

    .end local v1    # "e":Ljava/lang/Exception;
    :catch_0
    move-exception v1

    .restart local v1    # "e":Ljava/lang/Exception;
    const-string v2, "WfdsSendReceiverFactory"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Class not found: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "cLoader":Ljava/lang/ClassLoader;
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_1
    const-string v2, "WfdsSendReceiverFactory"

    const-string v3, "ConfigBuildFlags.CAPP_WFDS_SEND is not enabled!!!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getInstance()Lcom/lge/wfds/send/receiver/WfdsSendReceiverIface;
    .locals 2

    .prologue
    sget-boolean v0, Lcom/lge/config/ConfigBuildFlags;->CAPP_WFDS_SEND:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    sget-object v0, Lcom/lge/wfds/send/WfdsSendReceiverFactory;->sWfdsSendReceiverIface:Lcom/lge/wfds/send/receiver/WfdsSendReceiverIface;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/lge/wfds/send/WfdsSendReceiverFactory;->sWfdsSendReceiverIface:Lcom/lge/wfds/send/receiver/WfdsSendReceiverIface;

    :goto_0
    return-object v0

    :cond_0
    const-string v0, "WfdsSendReceiverFactory"

    const-string v1, "ConfigBuildFlags.CAPP_WFDS_SEND is not enabled!!!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static setInstance(Lcom/lge/wfds/send/receiver/WfdsSendReceiverIface;)V
    .locals 2
    .param p0, "sendReceiver"    # Lcom/lge/wfds/send/receiver/WfdsSendReceiverIface;

    .prologue
    sget-boolean v0, Lcom/lge/config/ConfigBuildFlags;->CAPP_WFDS_SEND:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    sget-object v0, Lcom/lge/wfds/send/WfdsSendReceiverFactory;->sWfdsSendReceiverIface:Lcom/lge/wfds/send/receiver/WfdsSendReceiverIface;

    if-nez v0, :cond_0

    sput-object p0, Lcom/lge/wfds/send/WfdsSendReceiverFactory;->sWfdsSendReceiverIface:Lcom/lge/wfds/send/receiver/WfdsSendReceiverIface;

    :goto_0
    return-void

    :cond_0
    const-string v0, "WfdsSendReceiverFactory"

    const-string v1, "can not set WfdsSendReceiverInstance Instance!!!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
