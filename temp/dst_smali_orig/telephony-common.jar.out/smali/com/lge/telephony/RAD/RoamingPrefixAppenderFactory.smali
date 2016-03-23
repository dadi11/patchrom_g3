.class public Lcom/lge/telephony/RAD/RoamingPrefixAppenderFactory;
.super Ljava/lang/Object;
.source "RoamingPrefixAppenderFactory.java"


# static fields
.field private static final TARGET_COUNTRY:Ljava/lang/String;

.field private static final TARGET_OPERATOR:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const-string v0, "ro.build.target_country"

    const-string v1, "none"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/telephony/RAD/RoamingPrefixAppenderFactory;->TARGET_COUNTRY:Ljava/lang/String;

    const-string v0, "ro.build.target_operator"

    const-string v1, "none"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/telephony/RAD/RoamingPrefixAppenderFactory;->TARGET_OPERATOR:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getDefaultRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .locals 5
    .param p0, "ctx"    # Landroid/content/Context;
    .param p1, "cr"    # Landroid/content/ContentResolver;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v0, 0x0

    .local v0, "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    const-string v3, "ro.telephony.service_provider"

    const-string v4, "null"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .local v2, "serviceProvider":Ljava/lang/String;
    sget-object v3, Lcom/lge/telephony/RAD/RoamingPrefixAppenderFactory;->TARGET_OPERATOR:Ljava/lang/String;

    const-string v4, "LGU"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-static {p0, p1, p2}, Lcom/lge/telephony/RAD/RoamingPrefixAppenderFactory;->getLGTGlobalRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    move-result-object v0

    move-object v1, v0

    .end local v0    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .local v1, "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    :goto_0
    if-eqz v1, :cond_2

    new-instance v0, Lcom/lge/telephony/RAD/RoamingPrefixAppenderProxy;

    invoke-direct {v0, v1}, Lcom/lge/telephony/RAD/RoamingPrefixAppenderProxy;-><init>(Lcom/lge/telephony/RAD/RoamingPrefixAppender;)V

    .end local v1    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .restart local v0    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    :goto_1
    return-object v0

    :cond_0
    sget-object v3, Lcom/lge/telephony/RAD/RoamingPrefixAppenderFactory;->TARGET_OPERATOR:Ljava/lang/String;

    const-string v4, "KT"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-static {p0, p1, p2}, Lcom/lge/telephony/RAD/RoamingPrefixAppenderFactory;->getKTRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    move-result-object v0

    move-object v1, v0

    .end local v0    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .restart local v1    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    goto :goto_0

    .end local v1    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .restart local v0    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    :cond_1
    sget-object v3, Lcom/lge/telephony/RAD/RoamingPrefixAppenderFactory;->TARGET_OPERATOR:Ljava/lang/String;

    const-string v4, "SKT"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-static {p0, p1, p2}, Lcom/lge/telephony/RAD/RoamingPrefixAppenderFactory;->getSKTRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    move-result-object v0

    move-object v1, v0

    .end local v0    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .restart local v1    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    goto :goto_0

    :cond_2
    move-object v0, v1

    .end local v1    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .restart local v0    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    goto :goto_1

    :cond_3
    move-object v1, v0

    .end local v0    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .restart local v1    # "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    goto :goto_0
.end method

.method private static getKTRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .locals 1
    .param p0, "ctx"    # Landroid/content/Context;
    .param p1, "cr"    # Landroid/content/ContentResolver;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    invoke-static {p0, p1, p2}, Lcom/lge/telephony/RAD/KT/KTRoamingPrefixAppender;->getRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    move-result-object v0

    .local v0, "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    return-object v0
.end method

.method private static getLGTGlobalRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .locals 1
    .param p0, "ctx"    # Landroid/content/Context;
    .param p1, "cr"    # Landroid/content/ContentResolver;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    invoke-static {p0, p1, p2}, Lcom/lge/telephony/RAD/LGT/LGTGlobalRoamingPrefixAppender;->getRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    move-result-object v0

    .local v0, "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    return-object v0
.end method

.method private static getLGTRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .locals 1
    .param p0, "ctx"    # Landroid/content/Context;
    .param p1, "cr"    # Landroid/content/ContentResolver;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    invoke-static {p0, p1, p2}, Lcom/lge/telephony/RAD/LGT/LGTRoamingPrefixAppender;->getRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    move-result-object v0

    .local v0, "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    return-object v0
.end method

.method private static getSKTRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    .locals 1
    .param p0, "ctx"    # Landroid/content/Context;
    .param p1, "cr"    # Landroid/content/ContentResolver;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    invoke-static {p0, p1, p2}, Lcom/lge/telephony/RAD/SKT/SKTRoamingPrefixAppender;->getRoamingPrefixAppender(Landroid/content/Context;Landroid/content/ContentResolver;Landroid/content/Intent;)Lcom/lge/telephony/RAD/RoamingPrefixAppender;

    move-result-object v0

    .local v0, "rpa":Lcom/lge/telephony/RAD/RoamingPrefixAppender;
    return-object v0
.end method
