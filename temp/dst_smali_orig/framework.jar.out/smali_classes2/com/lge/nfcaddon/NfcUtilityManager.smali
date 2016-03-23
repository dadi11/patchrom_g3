.class public final Lcom/lge/nfcaddon/NfcUtilityManager;
.super Lcom/lge/nfcaddon/INfcUtilityCallback$Stub;
.source "NfcUtilityManager.java"


# static fields
.field private static final DBG:Z = true

.field private static final TAG:Ljava/lang/String; = "NfcUtilityManager"

.field static nfcUtilityCallback:Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Lcom/lge/nfcaddon/INfcUtilityCallback$Stub;-><init>()V

    return-void
.end method

.method public constructor <init>(Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;)V
    .locals 0
    .param p1, "callback"    # Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;

    .prologue
    invoke-direct {p0}, Lcom/lge/nfcaddon/INfcUtilityCallback$Stub;-><init>()V

    sput-object p1, Lcom/lge/nfcaddon/NfcUtilityManager;->nfcUtilityCallback:Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;

    return-void
.end method


# virtual methods
.method public SimBootComplete()V
    .locals 2

    .prologue
    const-string v0, "NfcUtilityManager"

    const-string v1, "SimBootComplete()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Lcom/lge/nfcaddon/NfcUtilityManager;->nfcUtilityCallback:Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;

    if-eqz v0, :cond_0

    const-string v0, "NfcUtilityManager"

    const-string v1, "nfcUtilityCallback.SimBootComplete()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Lcom/lge/nfcaddon/NfcUtilityManager;->nfcUtilityCallback:Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;

    invoke-interface {v0}, Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;->SimBootComplete()V

    :goto_0
    return-void

    :cond_0
    const-string v0, "NfcUtilityManager"

    const-string v1, "nfcUtilityCallback is null"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public setNfcUtilityCallback(Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;)V
    .locals 0
    .param p1, "callback"    # Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;

    .prologue
    sput-object p1, Lcom/lge/nfcaddon/NfcUtilityManager;->nfcUtilityCallback:Lcom/lge/nfcaddon/NfcUtility$NfcUtilityCallback;

    return-void
.end method
