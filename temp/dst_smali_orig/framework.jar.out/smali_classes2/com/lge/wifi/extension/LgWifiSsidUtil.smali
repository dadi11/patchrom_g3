.class public Lcom/lge/wifi/extension/LgWifiSsidUtil;
.super Ljava/lang/Object;
.source "LgWifiSsidUtil.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "LgWifiSsidUtil"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static containsHangul(Ljava/lang/String;)Z
    .locals 5
    .param p0, "str"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    if-nez p0, :cond_1

    :cond_0
    :goto_0
    return v3

    :cond_1
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v1, v4, :cond_0

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .local v0, "ch":C
    invoke-static {v0}, Ljava/lang/Character$UnicodeBlock;->of(C)Ljava/lang/Character$UnicodeBlock;

    move-result-object v2

    .local v2, "unicodeBlock":Ljava/lang/Character$UnicodeBlock;
    sget-object v4, Ljava/lang/Character$UnicodeBlock;->HANGUL_SYLLABLES:Ljava/lang/Character$UnicodeBlock;

    invoke-virtual {v4, v2}, Ljava/lang/Character$UnicodeBlock;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    sget-object v4, Ljava/lang/Character$UnicodeBlock;->HANGUL_COMPATIBILITY_JAMO:Ljava/lang/Character$UnicodeBlock;

    invoke-virtual {v4, v2}, Ljava/lang/Character$UnicodeBlock;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    sget-object v4, Ljava/lang/Character$UnicodeBlock;->HANGUL_JAMO:Ljava/lang/Character$UnicodeBlock;

    invoke-virtual {v4, v2}, Ljava/lang/Character$UnicodeBlock;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    :cond_2
    const/4 v3, 0x1

    goto :goto_0

    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1
.end method

.method public static getConfigForUtf8Hidden(Landroid/net/wifi/WifiConfiguration;)Landroid/net/wifi/WifiConfiguration;
    .locals 4
    .param p0, "config"    # Landroid/net/wifi/WifiConfiguration;

    .prologue
    const/4 v1, 0x0

    invoke-static {p0}, Lcom/lge/wifi/extension/LgWifiSsidUtil;->isConfigForUtf8Hidden(Landroid/net/wifi/WifiConfiguration;)Z

    move-result v2

    if-nez v2, :cond_1

    move-object v0, v1

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    new-instance v0, Landroid/net/wifi/WifiConfiguration;

    invoke-direct {v0, p0}, Landroid/net/wifi/WifiConfiguration;-><init>(Landroid/net/wifi/WifiConfiguration;)V

    .local v0, "configUtf8":Landroid/net/wifi/WifiConfiguration;
    iget-object v2, p0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    invoke-static {v2}, Lcom/lge/wifi/extension/LgWifiSsidUtil;->setSSIDcheckingUniCode([B)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    iget-object v2, v0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    if-nez v2, :cond_0

    const-string v2, "LgWifiSsidUtil"

    const-string v3, "getConfigForUtf8Hidden: UTF8 SSID is null"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v0, v1

    goto :goto_0
.end method

.method public static isConfigForUtf8Hidden(Landroid/net/wifi/WifiConfiguration;)Z
    .locals 5
    .param p0, "config"    # Landroid/net/wifi/WifiConfiguration;

    .prologue
    const/4 v2, 0x1

    const/4 v4, -0x1

    const/4 v1, 0x0

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->useLgeKtCm()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->useKoreanSsid()Z

    move-result v3

    if-nez v3, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    if-eqz p0, :cond_0

    iget v3, p0, Landroid/net/wifi/WifiConfiguration;->networkId:I

    if-ne v3, v4, :cond_2

    iget-object v3, p0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    if-eqz v3, :cond_0

    :cond_2
    iget-boolean v3, p0, Landroid/net/wifi/WifiConfiguration;->hiddenSSID:Z

    if-eqz v3, :cond_0

    iget v3, p0, Landroid/net/wifi/WifiConfiguration;->networkId:I

    if-ne v3, v4, :cond_3

    move v0, v2

    .local v0, "newNetwork":Z
    :goto_1
    if-eqz v0, :cond_0

    iget-object v3, p0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    invoke-static {v3}, Lcom/lge/wifi/extension/LgWifiSsidUtil;->isHangulSsid(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v1, "LgWifiSsidUtil"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "isConfigForUtf8Hidden ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "] is UTF8 Hidden"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v1, v2

    goto :goto_0

    .end local v0    # "newNetwork":Z
    :cond_3
    move v0, v1

    goto :goto_1
.end method

.method public static isHangulSsid(Ljava/lang/String;)Z
    .locals 5
    .param p0, "str"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    if-nez p0, :cond_1

    :cond_0
    :goto_0
    return v2

    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    .local v1, "maxLen":I
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v4

    array-length v0, v4

    .local v0, "bytelen":I
    if-eqz v1, :cond_0

    if-eq v0, v1, :cond_0

    invoke-static {p0}, Lcom/lge/wifi/extension/LgWifiSsidUtil;->containsHangul(Ljava/lang/String;)Z

    move-result v4

    if-ne v4, v3, :cond_0

    move v2, v3

    goto :goto_0
.end method

.method public static isSsidForUtf8Hidden(Landroid/net/wifi/WifiConfiguration;)Z
    .locals 3
    .param p0, "config"    # Landroid/net/wifi/WifiConfiguration;

    .prologue
    const/4 v0, 0x0

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->useLgeKtCm()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {}, Lcom/lge/wifi/config/LgeWifiConfig;->useKoreanSsid()Z

    move-result v1

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    if-eqz p0, :cond_0

    iget-object v1, p0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Landroid/net/wifi/WifiConfiguration;->hiddenSSID:Z

    if-eqz v1, :cond_0

    iget-object v1, p0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    invoke-static {v1}, Lcom/lge/wifi/extension/LgWifiSsidUtil;->isHangulSsid(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v0, "LgWifiSsidUtil"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "isSsidForUtf8Hidden ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Landroid/net/wifi/WifiConfiguration;->SSID:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] is Hangul Hidden"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public static isUniCodeSSID([B)Z
    .locals 8
    .param p0, "byte_array"    # [B

    .prologue
    const/16 v7, 0x80

    const/4 v3, 0x0

    .local v3, "unicodeSSID":Z
    const/4 v4, 0x0

    .local v4, "unicode_step":I
    if-nez p0, :cond_0

    const/4 v5, 0x0

    :goto_0
    return v5

    :cond_0
    const/4 v2, 0x0

    .local v2, "offset":I
    array-length v1, p0

    .local v1, "length":I
    move v0, v2

    .local v0, "i":I
    :goto_1
    if-ge v0, v1, :cond_3

    aget-byte v5, p0, v0

    const/16 v6, 0xa

    if-eq v5, v6, :cond_3

    if-lez v4, :cond_5

    aget-byte v5, p0, v0

    and-int/lit16 v5, v5, 0xc0

    if-ne v5, v7, :cond_2

    add-int/lit8 v4, v4, -0x1

    if-nez v4, :cond_1

    const/4 v3, 0x1

    :cond_1
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_2
    const/4 v3, 0x0

    :cond_3
    :goto_3
    if-eqz v4, :cond_4

    const/4 v3, 0x0

    :cond_4
    move v5, v3

    goto :goto_0

    :cond_5
    if-gez v4, :cond_7

    aget-byte v5, p0, v0

    and-int/lit16 v5, v5, 0xc0

    if-ne v5, v7, :cond_6

    const/4 v4, 0x0

    goto :goto_2

    :cond_6
    const/4 v3, 0x0

    goto :goto_3

    :cond_7
    aget-byte v5, p0, v0

    and-int/lit16 v5, v5, 0x80

    if-eqz v5, :cond_1

    aget-byte v5, p0, v0

    and-int/lit16 v5, v5, 0xf0

    const/16 v6, 0xe0

    if-ne v5, v6, :cond_8

    const/4 v4, 0x2

    goto :goto_2

    :cond_8
    aget-byte v5, p0, v0

    and-int/lit16 v5, v5, 0xe0

    const/16 v6, 0xc0

    if-ne v5, v6, :cond_9

    const/4 v4, 0x1

    goto :goto_2

    :cond_9
    aget-byte v5, p0, v0

    and-int/lit16 v5, v5, 0xf8

    const/16 v6, 0xf0

    if-ne v5, v6, :cond_a

    const/4 v4, 0x3

    goto :goto_2

    :cond_a
    aget-byte v5, p0, v0

    and-int/lit16 v5, v5, 0xfc

    const/16 v6, 0xf8

    if-ne v5, v6, :cond_b

    const/4 v4, 0x4

    goto :goto_2

    :cond_b
    aget-byte v5, p0, v0

    and-int/lit16 v5, v5, 0xfe

    const/16 v6, 0xfc

    if-ne v5, v6, :cond_c

    const/4 v4, 0x5

    goto :goto_2

    :cond_c
    const/4 v3, 0x0

    goto :goto_3
.end method

.method public static setSSIDcheckingUniCode([B)Ljava/lang/String;
    .locals 8
    .param p0, "ssid_byte"    # [B

    .prologue
    const/16 v7, 0x80

    const/4 v2, 0x0

    .local v2, "unicodeSSID":Z
    const/4 v4, 0x0

    .local v4, "unicode_step":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v5, p0

    if-ge v1, v5, :cond_2

    aget-byte v5, p0, v1

    if-eqz v5, :cond_2

    if-lez v4, :cond_4

    aget-byte v5, p0, v1

    and-int/lit16 v5, v5, 0xc0

    if-ne v5, v7, :cond_1

    add-int/lit8 v4, v4, -0x1

    if-nez v4, :cond_0

    const/4 v2, 0x1

    :cond_0
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    :cond_2
    :goto_2
    if-eqz v4, :cond_3

    const/4 v2, 0x0

    :cond_3
    const/4 v5, 0x1

    if-ne v2, v5, :cond_c

    new-instance v3, Ljava/lang/String;

    invoke-direct {v3, p0}, Ljava/lang/String;-><init>([B)V

    .local v3, "unicodeSsid":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v6, 0x0

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v7

    add-int/lit8 v7, v7, -0x1

    invoke-virtual {v3, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\u200b\""

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    :goto_3
    return-object v3

    .end local v3    # "unicodeSsid":Ljava/lang/String;
    :cond_4
    if-gez v4, :cond_6

    aget-byte v5, p0, v1

    and-int/lit16 v5, v5, 0xc0

    if-ne v5, v7, :cond_5

    const/4 v4, 0x0

    goto :goto_1

    :cond_5
    const/4 v2, 0x0

    goto :goto_2

    :cond_6
    aget-byte v5, p0, v1

    and-int/lit16 v5, v5, 0x80

    if-eqz v5, :cond_0

    aget-byte v5, p0, v1

    and-int/lit16 v5, v5, 0xf0

    const/16 v6, 0xe0

    if-ne v5, v6, :cond_7

    const/4 v4, 0x2

    goto :goto_1

    :cond_7
    aget-byte v5, p0, v1

    and-int/lit16 v5, v5, 0xe0

    const/16 v6, 0xc0

    if-ne v5, v6, :cond_8

    const/4 v4, 0x1

    goto :goto_1

    :cond_8
    aget-byte v5, p0, v1

    and-int/lit16 v5, v5, 0xf8

    const/16 v6, 0xf0

    if-ne v5, v6, :cond_9

    const/4 v4, 0x3

    goto :goto_1

    :cond_9
    aget-byte v5, p0, v1

    and-int/lit16 v5, v5, 0xfc

    const/16 v6, 0xf8

    if-ne v5, v6, :cond_a

    const/4 v4, 0x4

    goto :goto_1

    :cond_a
    aget-byte v5, p0, v1

    and-int/lit16 v5, v5, 0xfe

    const/16 v6, 0xfc

    if-ne v5, v6, :cond_b

    const/4 v4, 0x5

    goto :goto_1

    :cond_b
    const/4 v2, 0x0

    goto :goto_2

    :cond_c
    :try_start_0
    new-instance v3, Ljava/lang/String;

    const-string v5, "KSC5601"

    invoke-direct {v3, p0, v5}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .restart local v3    # "unicodeSsid":Ljava/lang/String;
    goto :goto_3

    .end local v3    # "unicodeSsid":Ljava/lang/String;
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    const/4 v3, 0x0

    .restart local v3    # "unicodeSsid":Ljava/lang/String;
    goto :goto_3
.end method
