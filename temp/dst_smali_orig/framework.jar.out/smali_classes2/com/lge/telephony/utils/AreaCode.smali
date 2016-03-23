.class public Lcom/lge/telephony/utils/AreaCode;
.super Ljava/lang/Object;
.source "AreaCode.java"


# instance fields
.field private areacode:Ljava/lang/String;

.field private cityname:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "areacode"    # Ljava/lang/String;
    .param p2, "cityname"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/telephony/utils/AreaCode;->areacode:Ljava/lang/String;

    iput-object p2, p0, Lcom/lge/telephony/utils/AreaCode;->cityname:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public getAreacode()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/AreaCode;->areacode:Ljava/lang/String;

    return-object v0
.end method

.method public getCityname()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/utils/AreaCode;->cityname:Ljava/lang/String;

    return-object v0
.end method
