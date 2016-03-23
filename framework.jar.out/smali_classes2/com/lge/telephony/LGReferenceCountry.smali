.class public Lcom/lge/telephony/LGReferenceCountry;
.super Ljava/lang/Object;
.source "LGReferenceCountry.java"


# instance fields
.field private areaCode:Ljava/lang/String;

.field private countryCode:Ljava/lang/String;

.field private countryName:Ljava/lang/String;

.field private iddPrefix:Ljava/lang/String;

.field private index:I

.field private mccCode:Ljava/lang/String;

.field private nanp:Ljava/lang/String;

.field private nddPrefix:Ljava/lang/String;

.field private numLength:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "index"    # I
    .param p2, "countryName"    # Ljava/lang/String;
    .param p3, "mccCode"    # Ljava/lang/String;
    .param p4, "countryCode"    # Ljava/lang/String;
    .param p5, "iddPrefix"    # Ljava/lang/String;
    .param p6, "nddPrefix"    # Ljava/lang/String;
    .param p7, "nanp"    # Ljava/lang/String;
    .param p8, "areaCode"    # Ljava/lang/String;
    .param p9, "numLength"    # Ljava/lang/String;

    .prologue
    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    iput p1, p0, Lcom/lge/telephony/LGReferenceCountry;->index:I

    .line 46
    iput-object p2, p0, Lcom/lge/telephony/LGReferenceCountry;->countryName:Ljava/lang/String;

    .line 47
    iput-object p3, p0, Lcom/lge/telephony/LGReferenceCountry;->mccCode:Ljava/lang/String;

    .line 48
    iput-object p4, p0, Lcom/lge/telephony/LGReferenceCountry;->countryCode:Ljava/lang/String;

    .line 49
    iput-object p5, p0, Lcom/lge/telephony/LGReferenceCountry;->iddPrefix:Ljava/lang/String;

    .line 50
    iput-object p6, p0, Lcom/lge/telephony/LGReferenceCountry;->nddPrefix:Ljava/lang/String;

    .line 51
    iput-object p7, p0, Lcom/lge/telephony/LGReferenceCountry;->nanp:Ljava/lang/String;

    .line 52
    iput-object p8, p0, Lcom/lge/telephony/LGReferenceCountry;->areaCode:Ljava/lang/String;

    .line 53
    iput-object p9, p0, Lcom/lge/telephony/LGReferenceCountry;->numLength:Ljava/lang/String;

    .line 54
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "countryName"    # Ljava/lang/String;
    .param p2, "mccCode"    # Ljava/lang/String;
    .param p3, "countryCode"    # Ljava/lang/String;
    .param p4, "iddPrefix"    # Ljava/lang/String;
    .param p5, "nddPrefix"    # Ljava/lang/String;
    .param p6, "nanp"    # Ljava/lang/String;
    .param p7, "areaCode"    # Ljava/lang/String;
    .param p8, "numLength"    # Ljava/lang/String;

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 29
    iput-object p1, p0, Lcom/lge/telephony/LGReferenceCountry;->countryName:Ljava/lang/String;

    .line 30
    iput-object p2, p0, Lcom/lge/telephony/LGReferenceCountry;->mccCode:Ljava/lang/String;

    .line 31
    iput-object p3, p0, Lcom/lge/telephony/LGReferenceCountry;->countryCode:Ljava/lang/String;

    .line 32
    iput-object p4, p0, Lcom/lge/telephony/LGReferenceCountry;->iddPrefix:Ljava/lang/String;

    .line 33
    iput-object p5, p0, Lcom/lge/telephony/LGReferenceCountry;->nddPrefix:Ljava/lang/String;

    .line 34
    iput-object p6, p0, Lcom/lge/telephony/LGReferenceCountry;->nanp:Ljava/lang/String;

    .line 35
    iput-object p7, p0, Lcom/lge/telephony/LGReferenceCountry;->areaCode:Ljava/lang/String;

    .line 36
    iput-object p8, p0, Lcom/lge/telephony/LGReferenceCountry;->numLength:Ljava/lang/String;

    .line 37
    return-void
.end method


# virtual methods
.method public getAreaCode()Ljava/lang/String;
    .locals 1

    .prologue
    .line 210
    iget-object v0, p0, Lcom/lge/telephony/LGReferenceCountry;->areaCode:Ljava/lang/String;

    return-object v0
.end method

.method public getCountryCode()Ljava/lang/String;
    .locals 1

    .prologue
    .line 125
    iget-object v0, p0, Lcom/lge/telephony/LGReferenceCountry;->countryCode:Ljava/lang/String;

    return-object v0
.end method

.method public getCountryName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 64
    iget-object v0, p0, Lcom/lge/telephony/LGReferenceCountry;->countryName:Ljava/lang/String;

    return-object v0
.end method

.method public getIddPrefix()Ljava/lang/String;
    .locals 1

    .prologue
    .line 146
    iget-object v0, p0, Lcom/lge/telephony/LGReferenceCountry;->iddPrefix:Ljava/lang/String;

    return-object v0
.end method

.method public getIndex()I
    .locals 1

    .prologue
    .line 91
    iget v0, p0, Lcom/lge/telephony/LGReferenceCountry;->index:I

    return v0
.end method

.method public getMccCode()Ljava/lang/String;
    .locals 1

    .prologue
    .line 83
    iget-object v0, p0, Lcom/lge/telephony/LGReferenceCountry;->mccCode:Ljava/lang/String;

    return-object v0
.end method

.method public getNanp()Ljava/lang/String;
    .locals 1

    .prologue
    .line 194
    iget-object v0, p0, Lcom/lge/telephony/LGReferenceCountry;->nanp:Ljava/lang/String;

    return-object v0
.end method

.method public getNddPrefix()Ljava/lang/String;
    .locals 1

    .prologue
    .line 170
    iget-object v0, p0, Lcom/lge/telephony/LGReferenceCountry;->nddPrefix:Ljava/lang/String;

    return-object v0
.end method

.method public getNumLength()Ljava/lang/String;
    .locals 1

    .prologue
    .line 231
    iget-object v0, p0, Lcom/lge/telephony/LGReferenceCountry;->numLength:Ljava/lang/String;

    return-object v0
.end method

.method public setAreaCode(Ljava/lang/String;)V
    .locals 0
    .param p1, "areaCode"    # Ljava/lang/String;

    .prologue
    .line 222
    iput-object p1, p0, Lcom/lge/telephony/LGReferenceCountry;->areaCode:Ljava/lang/String;

    .line 223
    return-void
.end method

.method public setCountryCode(Ljava/lang/String;)V
    .locals 0
    .param p1, "countryCode"    # Ljava/lang/String;

    .prologue
    .line 137
    iput-object p1, p0, Lcom/lge/telephony/LGReferenceCountry;->countryCode:Ljava/lang/String;

    .line 138
    return-void
.end method

.method public setCountryName(Ljava/lang/String;)V
    .locals 0
    .param p1, "countryName"    # Ljava/lang/String;

    .prologue
    .line 76
    iput-object p1, p0, Lcom/lge/telephony/LGReferenceCountry;->countryName:Ljava/lang/String;

    .line 77
    return-void
.end method

.method public setIddPrefix(Ljava/lang/String;)V
    .locals 0
    .param p1, "iddPrefix"    # Ljava/lang/String;

    .prologue
    .line 158
    iput-object p1, p0, Lcom/lge/telephony/LGReferenceCountry;->iddPrefix:Ljava/lang/String;

    .line 159
    return-void
.end method

.method public setIndex(I)V
    .locals 0
    .param p1, "index"    # I

    .prologue
    .line 102
    iput p1, p0, Lcom/lge/telephony/LGReferenceCountry;->index:I

    .line 103
    return-void
.end method

.method public setMccCode(Ljava/lang/String;)V
    .locals 0
    .param p1, "mccCode"    # Ljava/lang/String;

    .prologue
    .line 113
    iput-object p1, p0, Lcom/lge/telephony/LGReferenceCountry;->mccCode:Ljava/lang/String;

    .line 114
    return-void
.end method

.method public setNanp(Ljava/lang/String;)V
    .locals 0
    .param p1, "nanp"    # Ljava/lang/String;

    .prologue
    .line 201
    iput-object p1, p0, Lcom/lge/telephony/LGReferenceCountry;->nanp:Ljava/lang/String;

    .line 202
    return-void
.end method

.method public setNddPrefix(Ljava/lang/String;)V
    .locals 0
    .param p1, "nddPrefix"    # Ljava/lang/String;

    .prologue
    .line 182
    iput-object p1, p0, Lcom/lge/telephony/LGReferenceCountry;->nddPrefix:Ljava/lang/String;

    .line 183
    return-void
.end method

.method public setNumLength(Ljava/lang/String;)V
    .locals 0
    .param p1, "numLength"    # Ljava/lang/String;

    .prologue
    .line 243
    iput-object p1, p0, Lcom/lge/telephony/LGReferenceCountry;->numLength:Ljava/lang/String;

    .line 244
    return-void
.end method
