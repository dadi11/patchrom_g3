.class Lcom/lge/telephony/utils/PatternPair;
.super Ljava/lang/Object;
.source "PatternPair.java"


# instance fields
.field msFormat:Ljava/lang/String;

.field msPattern:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "sPattern"    # Ljava/lang/String;
    .param p2, "sFormat"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/telephony/utils/PatternPair;->msPattern:Ljava/lang/String;

    iput-object p2, p0, Lcom/lge/telephony/utils/PatternPair;->msFormat:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method getFormat()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/PatternPair;->msFormat:Ljava/lang/String;

    return-object v0
.end method

.method getPattern()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/PatternPair;->msPattern:Ljava/lang/String;

    return-object v0
.end method
