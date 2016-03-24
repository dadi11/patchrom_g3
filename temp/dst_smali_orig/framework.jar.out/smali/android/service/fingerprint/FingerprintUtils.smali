.class public Landroid/service/fingerprint/FingerprintUtils;
.super Ljava/lang/Object;
.source "FingerprintUtils.java"


# static fields
.field private static final DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "FingerprintUtils"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addFingerprintIdForUser(ILandroid/content/ContentResolver;I)V
    .locals 5
    .param p0, "fingerId"    # I
    .param p1, "res"    # Landroid/content/ContentResolver;
    .param p2, "userId"    # I

    .prologue
    invoke-static {p1, p2}, Landroid/service/fingerprint/FingerprintUtils;->getFingerprintIdsForUser(Landroid/content/ContentResolver;I)[I

    move-result-object v0

    .local v0, "fingerIds":[I
    if-nez p0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    array-length v3, v0

    if-ge v1, v3, :cond_2

    aget v3, v0, v1

    if-eq v3, p0, :cond_0

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_2
    array-length v3, v0

    add-int/lit8 v3, v3, 0x1

    invoke-static {v0, v3}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v2

    .local v2, "newList":[I
    array-length v3, v0

    aput p0, v2, v3

    const-string v3, "user_fingerprint_ids"

    invoke-static {v2}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v4

    invoke-static {p1, v3, v4, p2}, Landroid/provider/Settings$Secure;->putStringForUser(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;I)Z

    goto :goto_0
.end method

.method public static getFingerprintIdsForUser(Landroid/content/ContentResolver;I)[I
    .locals 7
    .param p0, "res"    # Landroid/content/ContentResolver;
    .param p1, "userId"    # I

    .prologue
    const-string v4, "user_fingerprint_ids"

    invoke-static {p0, v4, p1}, Landroid/provider/Settings$Secure;->getStringForUser(Landroid/content/ContentResolver;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .local v0, "fingerIdsRaw":Ljava/lang/String;
    const/4 v4, 0x0

    new-array v3, v4, [I

    .local v3, "result":[I
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_0

    const-string v4, "["

    const-string v5, ""

    invoke-virtual {v0, v4, v5}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "]"

    const-string v6, ""

    invoke-virtual {v4, v5, v6}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    const-string v5, ", "

    invoke-virtual {v4, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .local v1, "fingerStringIds":[Ljava/lang/String;
    array-length v4, v1

    new-array v3, v4, [I

    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    array-length v4, v3

    if-ge v2, v4, :cond_0

    :try_start_0
    aget-object v4, v1, v2

    invoke-static {v4}, Ljava/lang/Integer;->decode(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    aput v4, v3, v2
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .end local v1    # "fingerStringIds":[Ljava/lang/String;
    .end local v2    # "i":I
    :cond_0
    return-object v3

    .restart local v1    # "fingerStringIds":[Ljava/lang/String;
    .restart local v2    # "i":I
    :catch_0
    move-exception v4

    goto :goto_1
.end method

.method public static removeFingerprintIdForUser(ILandroid/content/ContentResolver;I)Z
    .locals 7
    .param p0, "fingerId"    # I
    .param p1, "res"    # Landroid/content/ContentResolver;
    .param p2, "userId"    # I

    .prologue
    if-nez p0, :cond_0

    new-instance v5, Ljava/lang/IllegalStateException;

    const-string v6, "Bad fingerId"

    invoke-direct {v5, v6}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v5

    :cond_0
    invoke-static {p1, p2}, Landroid/service/fingerprint/FingerprintUtils;->getFingerprintIdsForUser(Landroid/content/ContentResolver;I)[I

    move-result-object v0

    .local v0, "fingerIds":[I
    array-length v5, v0

    invoke-static {v0, v5}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v4

    .local v4, "resultIds":[I
    const/4 v2, 0x0

    .local v2, "resultCount":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v5, v0

    if-ge v1, v5, :cond_2

    aget v5, v0, v1

    if-eq p0, v5, :cond_1

    add-int/lit8 v3, v2, 0x1

    .end local v2    # "resultCount":I
    .local v3, "resultCount":I
    aget v5, v0, v1

    aput v5, v4, v2

    move v2, v3

    .end local v3    # "resultCount":I
    .restart local v2    # "resultCount":I
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    if-lez v2, :cond_3

    const-string v5, "user_fingerprint_ids"

    invoke-static {v4, v2}, Ljava/util/Arrays;->copyOf([II)[I

    move-result-object v6

    invoke-static {v6}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v6

    invoke-static {p1, v5, v6, p2}, Landroid/provider/Settings$Secure;->putStringForUser(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;I)Z

    const/4 v5, 0x1

    :goto_1
    return v5

    :cond_3
    const/4 v5, 0x0

    goto :goto_1
.end method
