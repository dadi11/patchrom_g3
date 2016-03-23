.class public Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameUtils;
.super Ljava/lang/Object;
.source "LgeNetworkNameUtils.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static matchData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "valueFromSystem"    # Ljava/lang/String;
    .param p2, "valueFromXml"    # Ljava/lang/String;

    .prologue
    .line 49
    const-string v0, "plmn"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "spn"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 51
    :cond_0
    const/4 v0, 0x1

    invoke-static {p1, p2, v0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameUtils;->matchData(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    .line 53
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    invoke-static {p1, p2, v0}, Lcom/lge/internal/telephony/lgenetworknamemanager/LgeNetworkNameUtils;->matchData(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    goto :goto_0
.end method

.method public static matchData(Ljava/lang/String;Ljava/lang/String;Z)Z
    .locals 3
    .param p0, "valueFromSystem"    # Ljava/lang/String;
    .param p1, "valueFromXml"    # Ljava/lang/String;
    .param p2, "ignoreCase"    # Z

    .prologue
    .line 24
    new-instance v1, Ljava/util/StringTokenizer;

    const-string v2, ";"

    invoke-direct {v1, p1, v2}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 27
    .local v1, "st":Ljava/util/StringTokenizer;
    :cond_0
    invoke-virtual {v1}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 28
    if-eqz p2, :cond_1

    invoke-virtual {v1}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    .line 31
    .local v0, "match":Z
    :goto_0
    if-eqz v0, :cond_0

    .line 32
    const/4 v2, 0x1

    .line 36
    .end local v0    # "match":Z
    :goto_1
    return v2

    .line 28
    :cond_1
    invoke-virtual {v1}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0

    .line 36
    :cond_2
    const/4 v2, 0x0

    goto :goto_1
.end method
