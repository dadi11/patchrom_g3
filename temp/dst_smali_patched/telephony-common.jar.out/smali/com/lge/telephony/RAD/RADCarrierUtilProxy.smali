.class public Lcom/lge/telephony/RAD/RADCarrierUtilProxy;
.super Ljava/lang/Object;
.source "RADCarrierUtilProxy.java"

# interfaces
.implements Lcom/lge/telephony/RAD/RADCarrierUtil;


# instance fields
.field private mRADCarrierUtil:Lcom/lge/telephony/RAD/RADCarrierUtil;


# direct methods
.method public constructor <init>(Lcom/lge/telephony/RAD/RADCarrierUtil;)V
    .locals 1
    .param p1, "rcu"    # Lcom/lge/telephony/RAD/RADCarrierUtil;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/telephony/RAD/RADCarrierUtilProxy;->mRADCarrierUtil:Lcom/lge/telephony/RAD/RADCarrierUtil;

    iput-object p1, p0, Lcom/lge/telephony/RAD/RADCarrierUtilProxy;->mRADCarrierUtil:Lcom/lge/telephony/RAD/RADCarrierUtil;

    return-void
.end method


# virtual methods
.method public isRoamingPrefixAdded(Ljava/lang/String;)Z
    .locals 1
    .param p1, "number"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/RAD/RADCarrierUtilProxy;->mRADCarrierUtil:Lcom/lge/telephony/RAD/RADCarrierUtil;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/RAD/RADCarrierUtilProxy;->mRADCarrierUtil:Lcom/lge/telephony/RAD/RADCarrierUtil;

    invoke-interface {v0, p1}, Lcom/lge/telephony/RAD/RADCarrierUtil;->isRoamingPrefixAdded(Ljava/lang/String;)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public removeRoamingPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "number"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/RAD/RADCarrierUtilProxy;->mRADCarrierUtil:Lcom/lge/telephony/RAD/RADCarrierUtil;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/RAD/RADCarrierUtilProxy;->mRADCarrierUtil:Lcom/lge/telephony/RAD/RADCarrierUtil;

    invoke-interface {v0, p1}, Lcom/lge/telephony/RAD/RADCarrierUtil;->removeRoamingPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .end local p1    # "number":Ljava/lang/String;
    :cond_0
    return-object p1
.end method
