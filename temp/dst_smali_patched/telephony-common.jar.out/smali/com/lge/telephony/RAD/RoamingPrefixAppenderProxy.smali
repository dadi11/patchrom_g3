.class public Lcom/lge/telephony/RAD/RoamingPrefixAppenderProxy;
.super Ljava/lang/Object;
.source "RoamingPrefixAppenderProxy.java"

# interfaces
.implements Lcom/lge/telephony/RAD/RoamingPrefixAppender;


# instance fields
.field private mRoamingPrefixAppender:Lcom/lge/telephony/RAD/RoamingPrefixAppender;


# direct methods
.method public constructor <init>(Lcom/lge/telephony/RAD/RoamingPrefixAppender;)V
    .locals 1
    .param p1, "rpa"    # Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/telephony/RAD/RoamingPrefixAppenderProxy;->mRoamingPrefixAppender:Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    iput-object p1, p0, Lcom/lge/telephony/RAD/RoamingPrefixAppenderProxy;->mRoamingPrefixAppender:Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    return-void
.end method


# virtual methods
.method public appendPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "pPhoneNum"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/RAD/RoamingPrefixAppenderProxy;->mRoamingPrefixAppender:Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/RAD/RoamingPrefixAppenderProxy;->mRoamingPrefixAppender:Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    invoke-interface {v0, p1}, Lcom/lge/telephony/RAD/RoamingPrefixAppender;->appendPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .end local p1    # "pPhoneNum":Ljava/lang/String;
    :cond_0
    return-object p1
.end method

.method public isNeededToAddPrefix(Ljava/lang/String;)Z
    .locals 1
    .param p1, "pPhoneNum"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/RAD/RoamingPrefixAppenderProxy;->mRoamingPrefixAppender:Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/RAD/RoamingPrefixAppenderProxy;->mRoamingPrefixAppender:Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    invoke-interface {v0, p1}, Lcom/lge/telephony/RAD/RoamingPrefixAppender;->isNeededToAddPrefix(Ljava/lang/String;)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isPrefixAddedNumber(Ljava/lang/String;)Z
    .locals 1
    .param p1, "pPhoneNum"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/RAD/RoamingPrefixAppenderProxy;->mRoamingPrefixAppender:Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/RAD/RoamingPrefixAppenderProxy;->mRoamingPrefixAppender:Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    invoke-interface {v0, p1}, Lcom/lge/telephony/RAD/RoamingPrefixAppender;->isPrefixAddedNumber(Ljava/lang/String;)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
