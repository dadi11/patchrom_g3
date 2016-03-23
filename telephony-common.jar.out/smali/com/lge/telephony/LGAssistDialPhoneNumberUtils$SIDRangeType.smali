.class public Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;
.super Ljava/lang/Object;
.source "LGAssistDialPhoneNumberUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "SIDRangeType"
.end annotation


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
    .line 1902
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1903
    iput p1, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->index:I

    .line 1904
    iput p2, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->countryIndex:I

    .line 1905
    iput p3, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->start:I

    .line 1906
    iput p4, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->end:I

    .line 1907
    return-void
.end method


# virtual methods
.method public getCountryIndex()I
    .locals 1

    .prologue
    .line 1895
    iget v0, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->countryIndex:I

    return v0
.end method

.method public getEnd()I
    .locals 1

    .prologue
    .line 1899
    iget v0, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->end:I

    return v0
.end method

.method public getStart()I
    .locals 1

    .prologue
    .line 1891
    iget v0, p0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils$SIDRangeType;->start:I

    return v0
.end method
