.class public final Lcom/lge/lgdrm/DrmContentMetaData;
.super Ljava/lang/Object;
.source "DrmContentMetaData.java"


# static fields
.field private static TAG:Ljava/lang/String;


# instance fields
.field private metaMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-string v0, "DrmCmtMeta"

    sput-object v0, Lcom/lge/lgdrm/DrmContentMetaData;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/lgdrm/DrmContentMetaData;->metaMap:Ljava/util/HashMap;

    return-void
.end method


# virtual methods
.method public getData(I)Ljava/lang/String;
    .locals 2
    .param p1, "type"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/lgdrm/DrmContentMetaData;->metaMap:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getDataList()[I
    .locals 8

    .prologue
    const/4 v7, 0x0

    const/4 v0, 0x0

    .local v0, "count":I
    const/16 v6, 0xe

    new-array v5, v6, [I

    .local v5, "tmp":[I
    iget-object v6, p0, Lcom/lge/lgdrm/DrmContentMetaData;->metaMap:Ljava/util/HashMap;

    invoke-virtual {v6}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v4

    .local v4, "set":Ljava/util/Set;, "Ljava/util/Set<Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;>;"
    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .local v2, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;>;"
    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .local v1, "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v6

    if-eqz v6, :cond_0

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    aput v6, v5, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .end local v1    # "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/Integer;Ljava/lang/String;>;"
    :cond_1
    if-nez v0, :cond_2

    const/4 v3, 0x0

    :goto_1
    return-object v3

    :cond_2
    new-array v3, v0, [I

    .local v3, "list":[I
    invoke-static {v5, v7, v3, v7, v0}, Ljava/lang/System;->arraycopy([II[III)V

    goto :goto_1
.end method

.method public setData(ILjava/lang/String;)I
    .locals 3
    .param p1, "type"    # I
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    const/4 v0, -0x1

    const/4 v1, 0x1

    if-lt p1, v1, :cond_0

    const/16 v1, 0xe

    if-lt p1, v1, :cond_1

    :cond_0
    sget-object v1, Lcom/lge/lgdrm/DrmContentMetaData;->TAG:Ljava/lang/String;

    const-string v2, "setData() : Type is invalid"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v0

    :cond_1
    if-nez p2, :cond_2

    sget-object v1, Lcom/lge/lgdrm/DrmContentMetaData;->TAG:Ljava/lang/String;

    const-string v2, "setData() : Value is null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/lge/lgdrm/DrmContentMetaData;->metaMap:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v0, 0x0

    goto :goto_0
.end method
