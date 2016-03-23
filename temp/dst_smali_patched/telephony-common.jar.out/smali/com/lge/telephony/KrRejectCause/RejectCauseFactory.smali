.class public Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;
.super Ljava/lang/Object;
.source "RejectCauseFactory.java"


# static fields
.field static final DBG:Z = true

.field static final LOG_TAG:Ljava/lang/String; = "RejectCauseFactory"

.field static sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static dispose()V
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    invoke-interface {v0}, Lcom/lge/telephony/KrRejectCause/RejectCause;->initialize()V

    const/4 v0, 0x0

    sput-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    :cond_0
    return-void
.end method

.method public static getDefaultRejectCause(Lcom/android/internal/telephony/gsm/GSMPhone;)Lcom/lge/telephony/KrRejectCause/RejectCause;
    .locals 2
    .param p0, "p"    # Lcom/android/internal/telephony/gsm/GSMPhone;

    .prologue
    sget-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    :goto_0
    return-object v0

    :cond_0
    const-string v0, "KR"

    const-string v1, "SKT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {}, Lcom/android/internal/telephony/TelephonyUtils;->isQCRIL()Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance v0, Lcom/lge/telephony/KrRejectCause/QcrilSKTRejectCause;

    invoke-direct {v0, p0}, Lcom/lge/telephony/KrRejectCause/QcrilSKTRejectCause;-><init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V

    sput-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    :cond_1
    :goto_1
    sget-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    goto :goto_0

    :cond_2
    new-instance v0, Lcom/lge/telephony/KrRejectCause/InfineonSKTRejectCause;

    invoke-direct {v0, p0}, Lcom/lge/telephony/KrRejectCause/InfineonSKTRejectCause;-><init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V

    sput-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    goto :goto_1

    :cond_3
    const-string v0, "KR"

    const-string v1, "KT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-static {}, Lcom/android/internal/telephony/TelephonyUtils;->isQCRIL()Z

    move-result v0

    if-eqz v0, :cond_4

    new-instance v0, Lcom/lge/telephony/KrRejectCause/QcrilKTRejectCause;

    invoke-direct {v0, p0}, Lcom/lge/telephony/KrRejectCause/QcrilKTRejectCause;-><init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V

    sput-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    goto :goto_1

    :cond_4
    new-instance v0, Lcom/lge/telephony/KrRejectCause/InfineonKTRejectCause;

    invoke-direct {v0, p0}, Lcom/lge/telephony/KrRejectCause/InfineonKTRejectCause;-><init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V

    sput-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    goto :goto_1

    :cond_5
    const-string v0, "KR"

    const-string v1, "LGU"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;

    invoke-direct {v0, p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;-><init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V

    sput-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseFactory;->sProxyRejectCause:Lcom/lge/telephony/KrRejectCause/RejectCause;

    goto :goto_1
.end method
