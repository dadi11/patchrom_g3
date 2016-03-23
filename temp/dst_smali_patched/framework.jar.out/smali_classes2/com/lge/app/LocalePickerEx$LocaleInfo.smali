.class public Lcom/lge/app/LocalePickerEx$LocaleInfo;
.super Ljava/lang/Object;
.source "LocalePickerEx.java"

# interfaces
.implements Ljava/lang/Comparable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/app/LocalePickerEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "LocaleInfo"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/lang/Comparable",
        "<",
        "Lcom/lge/app/LocalePickerEx$LocaleInfo;",
        ">;"
    }
.end annotation


# static fields
.field static final sCollator:Ljava/text/Collator;


# instance fields
.field label:Ljava/lang/String;

.field locale:Ljava/util/Locale;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    invoke-static {}, Ljava/text/Collator;->getInstance()Ljava/text/Collator;

    move-result-object v0

    sput-object v0, Lcom/lge/app/LocalePickerEx$LocaleInfo;->sCollator:Ljava/text/Collator;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/util/Locale;)V
    .locals 0
    .param p1, "label"    # Ljava/lang/String;
    .param p2, "locale"    # Ljava/util/Locale;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/app/LocalePickerEx$LocaleInfo;->label:Ljava/lang/String;

    iput-object p2, p0, Lcom/lge/app/LocalePickerEx$LocaleInfo;->locale:Ljava/util/Locale;

    return-void
.end method


# virtual methods
.method public compareTo(Lcom/lge/app/LocalePickerEx$LocaleInfo;)I
    .locals 12
    .param p1, "another"    # Lcom/lge/app/LocalePickerEx$LocaleInfo;

    .prologue
    const/4 v8, -0x1

    const/4 v9, 0x1

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v10

    invoke-virtual {v10}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v3

    .local v3, "curLocaleStr":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/lge/app/LocalePickerEx$LocaleInfo;->getLocale()Ljava/util/Locale;

    move-result-object v10

    invoke-virtual {v10}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v7

    .local v7, "thisLocaleStr":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/lge/app/LocalePickerEx$LocaleInfo;->getLocale()Ljava/util/Locale;

    move-result-object v10

    invoke-virtual {v10}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v1

    .local v1, "anotherLocaleStr":Ljava/lang/String;
    invoke-virtual {v7, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_1

    :cond_0
    :goto_0
    return v8

    :cond_1
    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_2

    move v8, v9

    goto :goto_0

    :cond_2
    # getter for: Lcom/lge/app/LocalePickerEx;->COUNTRY_CODE:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/LocalePickerEx;->access$000()Ljava/lang/String;

    move-result-object v10

    const-string v11, "KR"

    invoke-virtual {v10, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_4

    const/4 v10, 0x3

    new-array v0, v10, [Ljava/lang/String;

    const/4 v10, 0x0

    const-string v11, "ko"

    aput-object v11, v0, v10

    const-string v10, "en"

    aput-object v10, v0, v9

    const/4 v10, 0x2

    const-string v11, "zh"

    aput-object v11, v0, v10

    .local v0, "LANG_PREFIXS":[Ljava/lang/String;
    move-object v2, v0

    .local v2, "arr$":[Ljava/lang/String;
    array-length v6, v2

    .local v6, "len$":I
    const/4 v4, 0x0

    .local v4, "i$":I
    :goto_1
    if-ge v4, v6, :cond_5

    aget-object v5, v2, v4

    .local v5, "language":Ljava/lang/String;
    invoke-virtual {v7, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_0

    invoke-virtual {v1, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_3

    move v8, v9

    goto :goto_0

    :cond_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .end local v0    # "LANG_PREFIXS":[Ljava/lang/String;
    .end local v2    # "arr$":[Ljava/lang/String;
    .end local v4    # "i$":I
    .end local v5    # "language":Ljava/lang/String;
    .end local v6    # "len$":I
    :cond_4
    const-string v10, "en"

    invoke-virtual {v7, v10}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_0

    const-string v8, "en"

    invoke-virtual {v1, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_5

    move v8, v9

    goto :goto_0

    :cond_5
    sget-object v8, Lcom/lge/app/LocalePickerEx$LocaleInfo;->sCollator:Ljava/text/Collator;

    iget-object v9, p0, Lcom/lge/app/LocalePickerEx$LocaleInfo;->label:Ljava/lang/String;

    iget-object v10, p1, Lcom/lge/app/LocalePickerEx$LocaleInfo;->label:Ljava/lang/String;

    invoke-virtual {v8, v9, v10}, Ljava/text/Collator;->compare(Ljava/lang/String;Ljava/lang/String;)I

    move-result v8

    goto :goto_0
.end method

.method public bridge synthetic compareTo(Ljava/lang/Object;)I
    .locals 1
    .param p1, "x0"    # Ljava/lang/Object;

    .prologue
    check-cast p1, Lcom/lge/app/LocalePickerEx$LocaleInfo;

    .end local p1    # "x0":Ljava/lang/Object;
    invoke-virtual {p0, p1}, Lcom/lge/app/LocalePickerEx$LocaleInfo;->compareTo(Lcom/lge/app/LocalePickerEx$LocaleInfo;)I

    move-result v0

    return v0
.end method

.method public getLabel()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/app/LocalePickerEx$LocaleInfo;->label:Ljava/lang/String;

    return-object v0
.end method

.method public getLocale()Ljava/util/Locale;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/app/LocalePickerEx$LocaleInfo;->locale:Ljava/util/Locale;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/app/LocalePickerEx$LocaleInfo;->label:Ljava/lang/String;

    return-object v0
.end method
