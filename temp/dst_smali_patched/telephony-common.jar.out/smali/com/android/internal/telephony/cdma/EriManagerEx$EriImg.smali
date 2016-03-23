.class Lcom/android/internal/telephony/cdma/EriManagerEx$EriImg;
.super Ljava/lang/Object;
.source "EriManagerEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/cdma/EriManagerEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "EriImg"
.end annotation


# instance fields
.field public mAmountOfTextData:I

.field public mIconFileName:Ljava/lang/String;

.field public mImageId:I

.field public mReservedBits:I

.field final synthetic this$0:Lcom/android/internal/telephony/cdma/EriManagerEx;


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/cdma/EriManagerEx;IIILjava/lang/String;)V
    .locals 0
    .param p2, "imageId"    # I
    .param p3, "reservedBits"    # I
    .param p4, "amountOfTextData"    # I
    .param p5, "iconFileName"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriImg;->this$0:Lcom/android/internal/telephony/cdma/EriManagerEx;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p2, p0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriImg;->mImageId:I

    iput p3, p0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriImg;->mReservedBits:I

    iput p4, p0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriImg;->mAmountOfTextData:I

    iput-object p5, p0, Lcom/android/internal/telephony/cdma/EriManagerEx$EriImg;->mIconFileName:Ljava/lang/String;

    return-void
.end method
