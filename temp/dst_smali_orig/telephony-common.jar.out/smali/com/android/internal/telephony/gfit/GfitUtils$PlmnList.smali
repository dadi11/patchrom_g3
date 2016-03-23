.class public Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;
.super Ljava/lang/Object;
.source "GfitUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/gfit/GfitUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "PlmnList"
.end annotation


# instance fields
.field private RAT:Ljava/lang/String;

.field private nMCC:I

.field private nMNC:I

.field private operatorAlphaLong:Ljava/lang/String;

.field private operatorNumeric:Ljava/lang/String;

.field final synthetic this$0:Lcom/android/internal/telephony/gfit/GfitUtils;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/gfit/GfitUtils;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->this$0:Lcom/android/internal/telephony/gfit/GfitUtils;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method getMCC()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->nMCC:I

    return v0
.end method

.method getMNC()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->nMNC:I

    return v0
.end method

.method getOperatorAlphaLong()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->operatorAlphaLong:Ljava/lang/String;

    return-object v0
.end method

.method getOperatorNumeric()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->operatorNumeric:Ljava/lang/String;

    return-object v0
.end method

.method getRAT()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->RAT:Ljava/lang/String;

    return-object v0
.end method

.method setMCC(I)V
    .locals 0
    .param p1, "nMCC"    # I

    .prologue
    iput p1, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->nMCC:I

    return-void
.end method

.method setMNC(I)V
    .locals 0
    .param p1, "nMNC"    # I

    .prologue
    iput p1, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->nMNC:I

    return-void
.end method

.method setOperatorAlphaLong(Ljava/lang/String;)V
    .locals 0
    .param p1, "operatorAlphaLong"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->operatorAlphaLong:Ljava/lang/String;

    return-void
.end method

.method setOperatorNumeric(Ljava/lang/String;)V
    .locals 0
    .param p1, "operatorNumeric"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->operatorNumeric:Ljava/lang/String;

    return-void
.end method

.method setRAT(Ljava/lang/String;)V
    .locals 4
    .param p1, "RAT"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    const/4 v0, 0x0

    .local v0, "tempRAT":Ljava/lang/String;
    if-eqz p1, :cond_1

    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x57

    if-eq v1, v2, :cond_0

    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x47

    if-eq v1, v2, :cond_0

    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x4c

    if-ne v1, v2, :cond_2

    :cond_0
    move-object v0, p1

    :cond_1
    :goto_0
    iput-object v0, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->RAT:Ljava/lang/String;

    return-void

    :cond_2
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    packed-switch v1, :pswitch_data_0

    :pswitch_0
    goto :goto_0

    :pswitch_1
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->this$0:Lcom/android/internal/telephony/gfit/GfitUtils;

    const-string v2, "setRAT - GSM"

    # invokes: Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V
    invoke-static {v1, v2}, Lcom/android/internal/telephony/gfit/GfitUtils;->access$000(Lcom/android/internal/telephony/gfit/GfitUtils;Ljava/lang/String;)V

    const-string v0, "GSM"

    goto :goto_0

    :pswitch_2
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->this$0:Lcom/android/internal/telephony/gfit/GfitUtils;

    const-string v2, "setRAT - WCDMA"

    # invokes: Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V
    invoke-static {v1, v2}, Lcom/android/internal/telephony/gfit/GfitUtils;->access$000(Lcom/android/internal/telephony/gfit/GfitUtils;Ljava/lang/String;)V

    const-string v0, "WCDMA"

    goto :goto_0

    :pswitch_3
    iget-object v1, p0, Lcom/android/internal/telephony/gfit/GfitUtils$PlmnList;->this$0:Lcom/android/internal/telephony/gfit/GfitUtils;

    const-string v2, "setRAT - LTE"

    # invokes: Lcom/android/internal/telephony/gfit/GfitUtils;->log(Ljava/lang/String;)V
    invoke-static {v1, v2}, Lcom/android/internal/telephony/gfit/GfitUtils;->access$000(Lcom/android/internal/telephony/gfit/GfitUtils;Ljava/lang/String;)V

    const-string v0, "LTE"

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
