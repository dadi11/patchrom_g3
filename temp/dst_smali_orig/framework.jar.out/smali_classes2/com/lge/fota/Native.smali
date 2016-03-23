.class Lcom/lge/fota/Native;
.super Ljava/lang/Object;
.source "Native.java"


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "Native.java"

.field private static m_FotaInterface:Lcom/lge/fota/DmcFotaNativeInterface;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-string v0, "fotajni"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void
.end method

.method constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static native ClearUsd()I
.end method

.method static native DoAutotest(II)I
.end method

.method static native DoUpdate(II)I
.end method

.method static native DumpImage(II)I
.end method

.method static native GetResult(I)I
.end method

.method static native GetUsd(II)I
.end method

.method static native PrepareUpdate(Ljava/lang/String;)I
.end method

.method static Progress(I)I
    .locals 1
    .param p0, "iProgress"    # I

    .prologue
    sget-object v0, Lcom/lge/fota/Native;->m_FotaInterface:Lcom/lge/fota/DmcFotaNativeInterface;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/lge/fota/Native;->m_FotaInterface:Lcom/lge/fota/DmcFotaNativeInterface;

    invoke-interface {v0, p0}, Lcom/lge/fota/DmcFotaNativeInterface;->Progress(I)V

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method static RemoveCallback()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/fota/Native;->m_FotaInterface:Lcom/lge/fota/DmcFotaNativeInterface;

    return-void
.end method

.method static SetCallback(Lcom/lge/fota/DmcFotaNativeInterface;)V
    .locals 0
    .param p0, "FotaInterface"    # Lcom/lge/fota/DmcFotaNativeInterface;

    .prologue
    sput-object p0, Lcom/lge/fota/Native;->m_FotaInterface:Lcom/lge/fota/DmcFotaNativeInterface;

    return-void
.end method

.method static native UpdateAgentV()Ljava/lang/String;
.end method

.method static native ValidatePackage()I
.end method
