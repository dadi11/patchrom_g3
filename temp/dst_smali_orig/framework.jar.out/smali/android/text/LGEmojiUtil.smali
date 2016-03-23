.class public Landroid/text/LGEmojiUtil;
.super Ljava/lang/Object;
.source "LGEmojiUtil.java"


# static fields
.field public static final NO_EMOJI_PRIVATE_IME_OPTION:Ljava/lang/String; = "com.lge.android.editmode.noEmoji"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addOffsetEmoji(I[CI)I
    .locals 3
    .param p0, "offset"    # I
    .param p1, "characters"    # [C
    .param p2, "length"    # I

    .prologue
    sget-boolean v1, Lcom/lge/config/ConfigBuildFlags;->CAPP_EMOJI:Z

    if-eqz v1, :cond_0

    if-eqz p1, :cond_0

    if-ltz p0, :cond_0

    if-ge p0, p2, :cond_0

    array-length v1, p1

    if-ge p0, v1, :cond_0

    add-int/lit8 v1, p0, -0x1

    if-ge v1, p2, :cond_1

    add-int/lit8 v1, p0, -0x1

    invoke-static {p1, v1}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable([CI)Z

    move-result v1

    if-eqz v1, :cond_1

    add-int/lit8 p0, p0, 0x3

    :cond_0
    :goto_0
    return p0

    :cond_1
    add-int/lit8 v1, p0, -0x2

    if-ge v1, p2, :cond_2

    add-int/lit8 v1, p0, -0x2

    invoke-static {p1, v1}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable([CI)Z

    move-result v1

    if-eqz v1, :cond_2

    add-int/lit8 p0, p0, 0x2

    goto :goto_0

    :cond_2
    add-int/lit8 v1, p0, -0x3

    if-ge v1, p2, :cond_3

    add-int/lit8 v1, p0, -0x3

    invoke-static {p1, v1}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable([CI)Z

    move-result v1

    if-eqz v1, :cond_3

    add-int/lit8 p0, p0, 0x1

    goto :goto_0

    :cond_3
    add-int/lit8 v1, p0, -0x1

    if-ltz v1, :cond_4

    add-int/lit8 v1, p0, -0x1

    invoke-static {p1, v1}, Lcom/lge/emoji/EmojiUtil;->isDiacriticalMark([CI)Z

    move-result v1

    if-eqz v1, :cond_4

    add-int/lit8 p0, p0, 0x1

    goto :goto_0

    :cond_4
    add-int/lit8 v1, p0, -0x1

    if-ltz v1, :cond_5

    aget-char v1, p1, p0

    const v2, 0xdc00

    if-lt v1, v2, :cond_5

    aget-char v1, p1, p0

    const v2, 0xdfff

    if-gt v1, v2, :cond_5

    add-int/lit8 v1, p0, -0x1

    invoke-static {p1, v1}, Ljava/lang/Character;->codePointAt([CI)I

    move-result v0

    .local v0, "codept":I
    invoke-static {v0}, Lcom/lge/emoji/EmojiUtil;->isInEmojiUnicodeTable(I)Z

    move-result v1

    if-eqz v1, :cond_0

    add-int/lit8 p0, p0, 0x1

    goto :goto_0

    .end local v0    # "codept":I
    :cond_5
    aget-char v1, p1, p0

    invoke-static {v1}, Lcom/lge/emoji/EmojiUtil;->isInEmojiUnicodeTable(C)Z

    move-result v1

    if-eqz v1, :cond_0

    add-int/lit8 p0, p0, 0x1

    goto :goto_0
.end method

.method public static adjustEllipsisOffset(I[CICI)V
    .locals 7
    .param p0, "start"    # I
    .param p1, "dest"    # [C
    .param p2, "destoff"    # I
    .param p3, "c"    # C
    .param p4, "a"    # I

    .prologue
    const v6, 0xfeff

    sget-boolean v3, Lcom/lge/config/ConfigBuildFlags;->CAPP_EMOJI:Z

    if-eqz v3, :cond_2

    add-int v3, p2, p4

    sub-int v2, v3, p0

    .local v2, "offset":I
    const/4 v1, 0x0

    .local v1, "isCountryCodeEmoji":Z
    const/4 v0, -0x3

    .local v0, "i":I
    :goto_0
    const/4 v3, 0x3

    if-gt v0, v3, :cond_0

    add-int v3, v2, v0

    if-ltz v3, :cond_3

    add-int v3, v2, v0

    add-int/lit8 v3, v3, 0x3

    array-length v4, p1

    if-ge v3, v4, :cond_3

    add-int v3, v2, v0

    invoke-static {p1, v3}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable([CI)Z

    move-result v3

    if-eqz v3, :cond_3

    const/4 v1, 0x1

    add-int v3, v2, v0

    aput-char p3, p1, v3

    add-int v3, v2, v0

    add-int/lit8 v3, v3, 0x1

    add-int v4, v2, v0

    add-int/lit8 v4, v4, 0x2

    add-int v5, v2, v0

    add-int/lit8 v5, v5, 0x3

    aput-char v6, p1, v5

    aput-char v6, p1, v4

    aput-char v6, p1, v3

    :cond_0
    if-nez v1, :cond_2

    if-lez v2, :cond_4

    add-int/lit8 v3, v2, -0x1

    invoke-static {p1, v3}, Lcom/lge/emoji/EmojiUtil;->isDiacriticalMark([CI)Z

    move-result v3

    if-nez v3, :cond_1

    add-int/lit8 v3, v2, -0x1

    aget-char v3, p1, v3

    aget-char v4, p1, v2

    invoke-static {v3, v4}, Ljava/lang/Character;->isSurrogatePair(CC)Z

    move-result v3

    if-eqz v3, :cond_4

    :cond_1
    add-int/lit8 v3, v2, -0x1

    aput-char p3, p1, v3

    aput-char v6, p1, v2

    .end local v0    # "i":I
    .end local v1    # "isCountryCodeEmoji":Z
    .end local v2    # "offset":I
    :cond_2
    :goto_1
    return-void

    .restart local v0    # "i":I
    .restart local v1    # "isCountryCodeEmoji":Z
    .restart local v2    # "offset":I
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_4
    if-ltz v2, :cond_6

    add-int/lit8 v3, v2, 0x1

    array-length v4, p1

    if-ge v3, v4, :cond_6

    invoke-static {p1, v2}, Lcom/lge/emoji/EmojiUtil;->isDiacriticalMark([CI)Z

    move-result v3

    if-nez v3, :cond_5

    aget-char v3, p1, v2

    add-int/lit8 v4, v2, 0x1

    aget-char v4, p1, v4

    invoke-static {v3, v4}, Ljava/lang/Character;->isSurrogatePair(CC)Z

    move-result v3

    if-eqz v3, :cond_6

    :cond_5
    aput-char p3, p1, v2

    add-int/lit8 v3, v2, 0x1

    aput-char v6, p1, v3

    goto :goto_1

    :cond_6
    add-int v3, p2, p4

    sub-int/2addr v3, p0

    aput-char p3, p1, v3

    goto :goto_1
.end method

.method public static adjustOffsetAfter(Ljava/lang/CharSequence;IC)I
    .locals 3
    .param p0, "text"    # Ljava/lang/CharSequence;
    .param p1, "offset"    # I
    .param p2, "c"    # C

    .prologue
    sget-boolean v2, Lcom/lge/config/ConfigBuildFlags;->CAPP_EMOJI:Z

    if-nez v2, :cond_0

    move v1, p1

    .end local p1    # "offset":I
    .local v1, "offset":I
    :goto_0
    return v1

    .end local v1    # "offset":I
    .restart local p1    # "offset":I
    :cond_0
    invoke-static {p0, p1}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v2

    if-eqz v2, :cond_1

    add-int/lit8 p1, p1, 0x4

    :goto_1
    move v1, p1

    .end local p1    # "offset":I
    .restart local v1    # "offset":I
    goto :goto_0

    .end local v1    # "offset":I
    .restart local p1    # "offset":I
    :cond_1
    add-int/lit8 v2, p1, -0x1

    invoke-static {p0, v2}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v2

    if-eqz v2, :cond_2

    add-int/lit8 p1, p1, 0x3

    goto :goto_1

    :cond_2
    add-int/lit8 v2, p1, -0x2

    invoke-static {p0, v2}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v2

    if-eqz v2, :cond_3

    add-int/lit8 p1, p1, 0x2

    goto :goto_1

    :cond_3
    add-int/lit8 v2, p1, -0x3

    invoke-static {p0, v2}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v2

    if-eqz v2, :cond_4

    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    :cond_4
    const v2, 0xd800

    if-lt p2, v2, :cond_6

    const v2, 0xdbff

    if-gt p2, v2, :cond_6

    add-int/lit8 v2, p1, 0x1

    invoke-interface {p0, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    .local v0, "c1":C
    const v2, 0xdc00

    if-lt v0, v2, :cond_5

    const v2, 0xdfff

    if-gt v0, v2, :cond_5

    add-int/lit8 p1, p1, 0x2

    goto :goto_1

    :cond_5
    add-int/lit8 p1, p1, 0x1

    goto :goto_1

    .end local v0    # "c1":C
    :cond_6
    invoke-static {p0, p1}, Lcom/lge/emoji/EmojiUtil;->isDiacriticalMark(Ljava/lang/CharSequence;I)Z

    move-result v2

    if-eqz v2, :cond_7

    add-int/lit8 p1, p1, 0x2

    goto :goto_1

    :cond_7
    add-int/lit8 p1, p1, 0x1

    goto :goto_1
.end method

.method public static adjustOffsetAtStartOf(ILjava/lang/CharSequence;C)I
    .locals 2
    .param p0, "offset"    # I
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "c"    # C

    .prologue
    sget-boolean v1, Lcom/lge/config/ConfigBuildFlags;->CAPP_EMOJI:Z

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return p0

    :cond_1
    add-int/lit8 v1, p0, -0x1

    invoke-static {p1, v1}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v1

    if-eqz v1, :cond_2

    add-int/lit8 p0, p0, -0x1

    goto :goto_0

    :cond_2
    add-int/lit8 v1, p0, -0x2

    invoke-static {p1, v1}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v1

    if-eqz v1, :cond_3

    add-int/lit8 p0, p0, -0x2

    goto :goto_0

    :cond_3
    add-int/lit8 v1, p0, -0x3

    invoke-static {p1, v1}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v1

    if-eqz v1, :cond_4

    add-int/lit8 p0, p0, -0x3

    goto :goto_0

    :cond_4
    add-int/lit8 v1, p0, -0x4

    invoke-static {p1, v1}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v1

    if-eqz v1, :cond_5

    add-int/lit8 p0, p0, -0x4

    goto :goto_0

    :cond_5
    const v1, 0xdc00

    if-lt p2, v1, :cond_6

    const v1, 0xdfff

    if-gt p2, v1, :cond_6

    add-int/lit8 v1, p0, -0x1

    invoke-interface {p1, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    .local v0, "c1":C
    const v1, 0xd800

    if-lt v0, v1, :cond_0

    const v1, 0xdbff

    if-gt v0, v1, :cond_0

    add-int/lit8 p0, p0, -0x1

    goto :goto_0

    .end local v0    # "c1":C
    :cond_6
    const/16 v1, 0x20e3

    if-ne p2, v1, :cond_0

    add-int/lit8 v1, p0, -0x1

    if-ltz v1, :cond_0

    add-int/lit8 v1, p0, -0x1

    invoke-static {p1, v1}, Lcom/lge/emoji/EmojiUtil;->isDiacriticalMark(Ljava/lang/CharSequence;I)Z

    move-result v1

    if-eqz v1, :cond_0

    add-int/lit8 p0, p0, -0x1

    goto :goto_0
.end method

.method public static adjustOffsetBefore(Ljava/lang/CharSequence;IC)I
    .locals 3
    .param p0, "text"    # Ljava/lang/CharSequence;
    .param p1, "offset"    # I
    .param p2, "c"    # C

    .prologue
    sget-boolean v2, Lcom/lge/config/ConfigBuildFlags;->CAPP_EMOJI:Z

    if-nez v2, :cond_0

    move v1, p1

    .end local p1    # "offset":I
    .local v1, "offset":I
    :goto_0
    return v1

    .end local v1    # "offset":I
    .restart local p1    # "offset":I
    :cond_0
    add-int/lit8 v2, p1, -0x1

    invoke-static {p0, v2}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v2

    if-eqz v2, :cond_1

    add-int/lit8 p1, p1, -0x1

    :goto_1
    move v1, p1

    .end local p1    # "offset":I
    .restart local v1    # "offset":I
    goto :goto_0

    .end local v1    # "offset":I
    .restart local p1    # "offset":I
    :cond_1
    add-int/lit8 v2, p1, -0x2

    invoke-static {p0, v2}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v2

    if-eqz v2, :cond_2

    add-int/lit8 p1, p1, -0x2

    goto :goto_1

    :cond_2
    add-int/lit8 v2, p1, -0x3

    invoke-static {p0, v2}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v2

    if-eqz v2, :cond_3

    add-int/lit8 p1, p1, -0x3

    goto :goto_1

    :cond_3
    add-int/lit8 v2, p1, -0x4

    invoke-static {p0, v2}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v2

    if-eqz v2, :cond_4

    add-int/lit8 p1, p1, -0x4

    goto :goto_1

    :cond_4
    const v2, 0xdc00

    if-lt p2, v2, :cond_6

    const v2, 0xdfff

    if-gt p2, v2, :cond_6

    add-int/lit8 v2, p1, -0x2

    invoke-interface {p0, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    .local v0, "c1":C
    const v2, 0xd800

    if-lt v0, v2, :cond_5

    const v2, 0xdbff

    if-gt v0, v2, :cond_5

    add-int/lit8 p1, p1, -0x2

    goto :goto_1

    :cond_5
    add-int/lit8 p1, p1, -0x1

    goto :goto_1

    .end local v0    # "c1":C
    :cond_6
    add-int/lit8 v2, p1, -0x2

    invoke-static {p0, v2}, Lcom/lge/emoji/EmojiUtil;->isDiacriticalMark(Ljava/lang/CharSequence;I)Z

    move-result v2

    if-eqz v2, :cond_7

    add-int/lit8 p1, p1, -0x2

    goto :goto_1

    :cond_7
    add-int/lit8 p1, p1, -0x1

    goto :goto_1
.end method

.method public static adjustTextRunCursor(Ljava/lang/CharSequence;IIII)I
    .locals 1
    .param p0, "text"    # Ljava/lang/CharSequence;
    .param p1, "start"    # I
    .param p2, "end"    # I
    .param p3, "offset"    # I
    .param p4, "cursorOpt"    # I

    .prologue
    sget-boolean v0, Lcom/lge/config/ConfigBuildFlags;->CAPP_EMOJI:Z

    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    const/4 v0, 0x2

    if-ne p4, v0, :cond_1

    add-int/lit8 v0, p3, -0x2

    if-lt v0, p1, :cond_1

    if-ge p3, p2, :cond_1

    add-int/lit8 v0, p3, -0x2

    invoke-static {p0, v0}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v0

    if-eqz v0, :cond_1

    add-int/lit8 p3, p3, -0x2

    :cond_0
    :goto_0
    return p3

    :cond_1
    if-nez p4, :cond_0

    if-lt p3, p1, :cond_0

    add-int/lit8 v0, p3, 0x2

    if-ge v0, p2, :cond_0

    add-int/lit8 v0, p3, 0x2

    invoke-static {p0, v0}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v0

    if-eqz v0, :cond_0

    add-int/lit8 p3, p3, 0x2

    goto :goto_0
.end method

.method public static adjustTextRunCursor([CIIII)I
    .locals 1
    .param p0, "text"    # [C
    .param p1, "start"    # I
    .param p2, "end"    # I
    .param p3, "offset"    # I
    .param p4, "cursorOpt"    # I

    .prologue
    sget-boolean v0, Lcom/lge/config/ConfigBuildFlags;->CAPP_EMOJI:Z

    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    const/4 v0, 0x2

    if-ne p4, v0, :cond_1

    add-int/lit8 v0, p3, -0x2

    if-lt v0, p1, :cond_1

    if-ge p3, p2, :cond_1

    add-int/lit8 v0, p3, -0x2

    invoke-static {p0, v0}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable([CI)Z

    move-result v0

    if-eqz v0, :cond_1

    add-int/lit8 p3, p3, -0x2

    :cond_0
    :goto_0
    return p3

    :cond_1
    if-nez p4, :cond_0

    if-lt p3, p1, :cond_0

    add-int/lit8 v0, p3, 0x2

    if-ge v0, p2, :cond_0

    add-int/lit8 v0, p3, 0x2

    invoke-static {p0, v0}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable([CI)Z

    move-result v0

    if-eqz v0, :cond_0

    add-int/lit8 p3, p3, 0x2

    goto :goto_0
.end method

.method public static filterEmojiIfNeeded(Ljava/lang/CharSequence;Z)Ljava/lang/CharSequence;
    .locals 1
    .param p0, "text"    # Ljava/lang/CharSequence;
    .param p1, "noEmojiEditMode"    # Z

    .prologue
    sget-boolean v0, Lcom/lge/config/ConfigBuildFlags;->CAPP_EMOJI:Z

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    invoke-static {p0}, Lcom/lge/emoji/EmojiUtil;->filterEmoji(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object p0

    .end local p0    # "text":Ljava/lang/CharSequence;
    :cond_0
    return-object p0
.end method

.method public static hasEmoji(Ljava/lang/CharSequence;)Z
    .locals 1
    .param p0, "str"    # Ljava/lang/CharSequence;

    .prologue
    invoke-static {p0}, Lcom/lge/emoji/EmojiUtil;->hasEmoji(Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method

.method public static hasNoEmojiEditModeOption(Ljava/lang/String;)Z
    .locals 1
    .param p0, "type"    # Ljava/lang/String;

    .prologue
    sget-boolean v0, Lcom/lge/config/ConfigBuildFlags;->CAPP_EMOJI:Z

    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    const-string v0, "com.lge.android.editmode.noEmoji"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isInCountryCodeTable(Ljava/lang/CharSequence;II)I
    .locals 1
    .param p0, "source"    # Ljava/lang/CharSequence;
    .param p1, "start"    # I
    .param p2, "keep"    # I

    .prologue
    sget-boolean v0, Lcom/lge/config/ConfigBuildFlags;->CAPP_EMOJI:Z

    if-eqz v0, :cond_0

    add-int/lit8 v0, p2, -0x2

    if-lt v0, p1, :cond_0

    add-int/lit8 v0, p2, -0x2

    invoke-static {p0, v0}, Lcom/lge/emoji/EmojiUtil;->isInCountryCodeTable(Ljava/lang/CharSequence;I)Z

    move-result v0

    if-eqz v0, :cond_0

    add-int/lit8 p2, p2, -0x2

    :cond_0
    return p2
.end method
