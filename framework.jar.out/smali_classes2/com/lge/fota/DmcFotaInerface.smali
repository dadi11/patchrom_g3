.class public Lcom/lge/fota/DmcFotaInerface;
.super Ljava/lang/Object;
.source "DmcFotaInerface.java"


# static fields
.field static final FOTA_TEST_MODE_DEBUG_MODE:I = 0x100000

.field static final FOTA_TEST_MODE_DISPLAY_LOG:I = 0x1000

.field static final FOTA_TEST_MODE_NONE:I = 0x0

.field static final FOTA_TEST_MODE_PRINT_LOG:I = 0x100

.field static final FOTA_TEST_MODE_SAVE_LOG:I = 0x1

.field static final FOTA_TEST_MODE_SAVE_USD:I = 0x10

.field static final FOTA_TEST_MODE_VERIFY_TARGET:I = 0x10000

.field private static final TAG:Ljava/lang/String; = "LGE_FOTA"

.field static final UI_BULGARIAN_LANG:I = 0x12

.field static final UI_CATALAN_LANG:I = 0x1e

.field static final UI_CROATIAN_LANG:I = 0x6

.field static final UI_CZECH_LANG:I = 0x4

.field static final UI_DANISH_LANG:I = 0xe

.field static final UI_DUTCH_LANG:I = 0x3

.field static final UI_ENGLISH_LANG:I = 0x0

.field static final UI_ESTONIAN_LANG:I = 0x1c

.field static final UI_FINNISH_LANG:I = 0x15

.field static final UI_FRENCH_LANG:I = 0xa

.field static final UI_GERMAN_LANG:I = 0x2

.field static final UI_GREEK_LANG:I = 0x10

.field static final UI_HUNGARIAN_LANG:I = 0x5

.field static final UI_ITALIAN_LANG:I = 0xb

.field static final UI_JAPANESE_LANG:I = 0x1f

.field static final UI_KAZAKH_LANG:I = 0x19

.field static final UI_KOREA_LANG:I = 0x1

.field static final UI_LATVIAN_LANG:I = 0x1a

.field static final UI_LITHUANIAN_LANG:I = 0x1b

.field static final UI_NORVEGIAN_LANG:I = 0x16

.field static final UI_POLISH_LANG:I = 0x7

.field static final UI_PORTUGUESE_BR_LANG:I = 0x20

.field static final UI_PORTUGUESE_LANG:I = 0x11

.field static final UI_ROMANIAN_LANG:I = 0xf

.field static final UI_RUSSIAN_LANG:I = 0x17

.field static final UI_SIMPLIFIEDCHINESE_LANG:I = 0x14

.field static final UI_SLOVAK_LANG:I = 0x8

.field static final UI_SLOVENIAN_LANG:I = 0x1d

.field static final UI_SPANISH_LANG:I = 0xc

.field static final UI_SWEDISH_LANG:I = 0xd

.field static final UI_TRADCHINESE_LANG:I = 0x13

.field static final UI_TURKISH_LANG:I = 0x9

.field static final UI_UKRAINIAN_LANG:I = 0x18

.field private static final m_DefaultPackagePath:Ljava/lang/String; = "/cache/fota/dlpkgfile"

.field private static final m_UserDataPackagePath:Ljava/lang/String; = "/data/fota/dlpkgfile"


# instance fields
.field private m_PackagePath:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 299
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/fota/DmcFotaInerface;->m_PackagePath:Ljava/lang/String;

    return-void
.end method

.method private GetLanguage()I
    .locals 6

    .prologue
    .line 164
    const/4 v2, 0x0

    .line 165
    .local v2, "iLanguage":I
    const/4 v1, 0x0

    .line 166
    .local v1, "cstrLanguage":Ljava/lang/String;
    const/4 v0, 0x0

    .line 168
    .local v0, "cstrCountryCode":Ljava/lang/String;
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v1

    .line 169
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v0

    .line 171
    const-string v3, "LGE_FOTA"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Language : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 172
    const-string v3, "LGE_FOTA"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "CountryCode : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 174
    const-string v3, "en"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_0

    const/4 v2, 0x0

    .line 175
    :cond_0
    const-string v3, "ko"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_1

    const/4 v2, 0x1

    .line 176
    :cond_1
    const-string v3, "de"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_2

    const/4 v2, 0x2

    .line 177
    :cond_2
    const-string v3, "nl"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_3

    const/4 v2, 0x3

    .line 178
    :cond_3
    const-string v3, "cs"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_4

    const/4 v2, 0x4

    .line 179
    :cond_4
    const-string v3, "hu"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_5

    const/4 v2, 0x5

    .line 180
    :cond_5
    const-string v3, "hr"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_6

    const/4 v2, 0x6

    .line 181
    :cond_6
    const-string v3, "pl"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_7

    const/4 v2, 0x7

    .line 182
    :cond_7
    const-string v3, "sk"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_8

    const/16 v2, 0x8

    .line 183
    :cond_8
    const-string v3, "tr"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_9

    const/16 v2, 0x9

    .line 184
    :cond_9
    const-string v3, "fr"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_a

    const/16 v2, 0xa

    .line 185
    :cond_a
    const-string v3, "it"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_b

    const/16 v2, 0xb

    .line 186
    :cond_b
    const-string v3, "es"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_c

    const/16 v2, 0xc

    .line 187
    :cond_c
    const-string v3, "sv"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_d

    const/16 v2, 0xd

    .line 188
    :cond_d
    const-string v3, "da"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_e

    const/16 v2, 0xe

    .line 189
    :cond_e
    const-string v3, "ro"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_f

    const/16 v2, 0xf

    .line 190
    :cond_f
    const-string v3, "el"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_10

    const/16 v2, 0x10

    .line 192
    :cond_10
    const-string/jumbo v3, "zh"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_11

    .line 194
    const-string/jumbo v3, "zh_CN"

    invoke-virtual {v0, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_18

    .line 196
    const/16 v2, 0x14

    .line 204
    :cond_11
    :goto_0
    const-string v3, "fi"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_12

    const/16 v2, 0x15

    .line 205
    :cond_12
    const-string v3, "nb"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_13

    const/16 v2, 0x16

    .line 206
    :cond_13
    const-string v3, "ru"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_14

    const/16 v2, 0x17

    .line 207
    :cond_14
    const-string v3, "uk"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_15

    const/16 v2, 0x18

    .line 214
    :cond_15
    const-string v3, "ja"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_16

    const/16 v2, 0x1f

    .line 216
    :cond_16
    const-string v3, "pt"

    invoke-virtual {v1, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_17

    .line 218
    const-string v3, "pt_BR"

    invoke-virtual {v0, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_19

    .line 220
    const/16 v2, 0x20

    .line 228
    :cond_17
    :goto_1
    return v2

    .line 200
    :cond_18
    const/16 v2, 0x13

    goto :goto_0

    .line 224
    :cond_19
    const/16 v2, 0x11

    goto :goto_1
.end method


# virtual methods
.method public ClearUsd()I
    .locals 1

    .prologue
    .line 24
    const/4 v0, 0x0

    .line 26
    .local v0, "iResult":I
    invoke-static {}, Lcom/lge/fota/Native;->ClearUsd()I

    move-result v0

    .line 28
    return v0
.end method

.method public DoAutotest()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 233
    invoke-static {v0, v0}, Lcom/lge/fota/Native;->DoAutotest(II)I

    .line 235
    return v0
.end method

.method public DoDebugModeUpdate()I
    .locals 6

    .prologue
    .line 119
    const/4 v2, 0x0

    .line 120
    .local v2, "iResult":I
    const/4 v0, 0x0

    .line 121
    .local v0, "iLanguage":I
    const/4 v1, 0x0

    .line 123
    .local v1, "iOption":I
    const/high16 v1, 0x100000

    .line 124
    invoke-direct {p0}, Lcom/lge/fota/DmcFotaInerface;->GetLanguage()I

    move-result v0

    .line 126
    const-string v3, "LGE_FOTA"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "DoUpdate - language : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", Option : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 128
    invoke-static {v0, v1}, Lcom/lge/fota/Native;->DoUpdate(II)I

    move-result v2

    .line 130
    return v2
.end method

.method public DoTargetValidation()I
    .locals 5

    .prologue
    .line 135
    const/4 v1, 0x0

    .line 136
    .local v1, "iResult":I
    const/4 v0, 0x0

    .line 137
    .local v0, "iLanguage":I
    invoke-direct {p0}, Lcom/lge/fota/DmcFotaInerface;->GetLanguage()I

    move-result v0

    .line 139
    const-string v2, "LGE_FOTA"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "DoTargetValidation - language : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 141
    const/high16 v2, 0x10000

    invoke-static {v0, v2}, Lcom/lge/fota/Native;->DoUpdate(II)I

    move-result v1

    .line 143
    return v1
.end method

.method public DoUpdate()I
    .locals 6

    .prologue
    .line 102
    const/4 v2, 0x0

    .line 103
    .local v2, "iResult":I
    const/4 v0, 0x0

    .line 104
    .local v0, "iLanguage":I
    const/4 v1, 0x0

    .line 106
    .local v1, "iOption":I
    const/4 v1, 0x0

    .line 107
    invoke-direct {p0}, Lcom/lge/fota/DmcFotaInerface;->GetLanguage()I

    move-result v0

    .line 110
    const-string v3, "LGE_FOTA"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "DoUpdate - language : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", Option : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 112
    invoke-static {v0, v1}, Lcom/lge/fota/Native;->DoUpdate(II)I

    move-result v2

    .line 114
    return v2
.end method

.method public DumpImage(II)I
    .locals 1
    .param p1, "iOption"    # I
    .param p2, "iMode"    # I

    .prologue
    .line 240
    invoke-static {p1, p2}, Lcom/lge/fota/Native;->DumpImage(II)I

    .line 242
    const/4 v0, 0x0

    return v0
.end method

.method public GetResult()I
    .locals 2

    .prologue
    .line 44
    const/4 v0, 0x0

    .line 47
    .local v0, "iResult":I
    const/4 v1, 0x0

    invoke-static {v1}, Lcom/lge/fota/Native;->GetResult(I)I

    move-result v0

    .line 50
    return v0
.end method

.method public PrepareUpdate()I
    .locals 2

    .prologue
    .line 80
    const/4 v0, 0x0

    .line 82
    .local v0, "iResult":I
    iget-object v1, p0, Lcom/lge/fota/DmcFotaInerface;->m_PackagePath:Ljava/lang/String;

    if-nez v1, :cond_1

    .line 84
    const-string v1, "/cache/fota/dlpkgfile"

    invoke-static {v1}, Lcom/lge/fota/Native;->PrepareUpdate(Ljava/lang/String;)I

    move-result v0

    .line 86
    if-nez v0, :cond_0

    .line 88
    const-string v1, "/data/fota/dlpkgfile"

    invoke-static {v1}, Lcom/lge/fota/Native;->PrepareUpdate(Ljava/lang/String;)I

    move-result v0

    .line 96
    :cond_0
    :goto_0
    return v0

    .line 93
    :cond_1
    iget-object v1, p0, Lcom/lge/fota/DmcFotaInerface;->m_PackagePath:Ljava/lang/String;

    invoke-static {v1}, Lcom/lge/fota/Native;->PrepareUpdate(Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public ReadUsd()I
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 15
    const/4 v0, 0x0

    .line 17
    .local v0, "iResult":I
    invoke-static {v1, v1}, Lcom/lge/fota/Native;->GetUsd(II)I

    move-result v0

    .line 19
    return v0
.end method

.method public RemoveCallback()V
    .locals 0

    .prologue
    .line 153
    invoke-static {}, Lcom/lge/fota/Native;->RemoveCallback()V

    .line 154
    return-void
.end method

.method public RemovePackage()I
    .locals 4

    .prologue
    .line 55
    new-instance v0, Ljava/io/File;

    const-string v1, "/cache/fota/dlpkgfile"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 57
    .local v0, "targetFile":Ljava/io/File;
    const-string v1, "LGE_FOTA"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RemovePackage : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 59
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 60
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 63
    :cond_0
    new-instance v0, Ljava/io/File;

    .end local v0    # "targetFile":Ljava/io/File;
    const-string v1, "/data/fota/dlpkgfile"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 64
    .restart local v0    # "targetFile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 65
    const-string v1, "LGE_FOTA"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RemovePackage : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 66
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 69
    :cond_1
    new-instance v0, Ljava/io/File;

    .end local v0    # "targetFile":Ljava/io/File;
    const-string v1, "/cache/fota/package.map"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 70
    .restart local v0    # "targetFile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 71
    const-string v1, "LGE_FOTA"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RemovePackage : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 72
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 75
    :cond_2
    const/4 v1, 0x0

    return v1
.end method

.method public SetCallback(Lcom/lge/fota/DmcFotaNativeInterface;)V
    .locals 0
    .param p1, "pNativeInterface"    # Lcom/lge/fota/DmcFotaNativeInterface;

    .prologue
    .line 148
    invoke-static {p1}, Lcom/lge/fota/Native;->SetCallback(Lcom/lge/fota/DmcFotaNativeInterface;)V

    .line 149
    return-void
.end method

.method public SetPackagePath(Ljava/lang/String;)V
    .locals 0
    .param p1, "cPackagePath"    # Ljava/lang/String;

    .prologue
    .line 158
    iput-object p1, p0, Lcom/lge/fota/DmcFotaInerface;->m_PackagePath:Ljava/lang/String;

    .line 159
    return-void
.end method

.method public UpdateAgentV()Ljava/lang/String;
    .locals 1

    .prologue
    .line 247
    const/4 v0, 0x0

    .line 249
    .local v0, "UA_Version":Ljava/lang/String;
    invoke-static {}, Lcom/lge/fota/Native;->UpdateAgentV()Ljava/lang/String;

    move-result-object v0

    .line 251
    return-object v0
.end method

.method public Validation()I
    .locals 1

    .prologue
    .line 33
    const/4 v0, 0x0

    .line 35
    .local v0, "iResult":I
    invoke-static {}, Lcom/lge/fota/Native;->ValidatePackage()I

    move-result v0

    .line 37
    return v0
.end method
