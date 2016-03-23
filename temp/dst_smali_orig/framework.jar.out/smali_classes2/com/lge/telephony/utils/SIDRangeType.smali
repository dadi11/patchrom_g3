.class public Lcom/lge/telephony/utils/SIDRangeType;
.super Ljava/lang/Object;
.source "SIDRangeType.java"


# instance fields
.field private countryIndex:I

.field private end:I

.field private index:I

.field private start:I


# direct methods
.method constructor <init>(IIII)V
    .locals 0
    .param p1, "index"    # I
    .param p2, "countryIndex"    # I
    .param p3, "start"    # I
    .param p4, "end"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/lge/telephony/utils/SIDRangeType;->index:I

    iput p2, p0, Lcom/lge/telephony/utils/SIDRangeType;->countryIndex:I

    iput p3, p0, Lcom/lge/telephony/utils/SIDRangeType;->start:I

    iput p4, p0, Lcom/lge/telephony/utils/SIDRangeType;->end:I

    return-void
.end method


# virtual methods
.method public getCountryIndex()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/telephony/utils/SIDRangeType;->countryIndex:I

    return v0
.end method

.method public getEnd()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/telephony/utils/SIDRangeType;->end:I

    return v0
.end method

.method public getIndex()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/telephony/utils/SIDRangeType;->index:I

    return v0
.end method

.method public getStart()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/telephony/utils/SIDRangeType;->start:I

    return v0
.end method
