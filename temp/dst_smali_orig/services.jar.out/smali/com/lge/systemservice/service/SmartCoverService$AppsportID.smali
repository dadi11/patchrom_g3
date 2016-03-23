.class Lcom/lge/systemservice/service/SmartCoverService$AppsportID;
.super Ljava/lang/Object;
.source "SmartCoverService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/systemservice/service/SmartCoverService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "AppsportID"
.end annotation


# static fields
.field private static final COLOR_BIT_SHIFT:I = 0x1a

.field private static final GPIO_BIT_MASK:I = 0x1000000

.field private static final ID_BIT_MASK:I = 0xffffff

.field private static final TYPE_BIT_SHIFT:I = 0x1d

.field private static final TYPE_COLOR_BIT_MASK:I = 0x7

.field private static final USB_BIT_MASK:I = 0x2000000


# instance fields
.field private AccessaryColor:I

.field private AccessaryType:I

.field private ID:I

.field private enableGPIO:Z

.field private enableUSB:Z

.field final synthetic this$0:Lcom/lge/systemservice/service/SmartCoverService;


# direct methods
.method constructor <init>(Lcom/lge/systemservice/service/SmartCoverService;I)V
    .locals 0
    .param p2, "value"    # I

    .prologue
    iput-object p1, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->this$0:Lcom/lge/systemservice/service/SmartCoverService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-direct {p0, p2}, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->parse(I)V

    return-void
.end method

.method static synthetic access$200(Lcom/lge/systemservice/service/SmartCoverService$AppsportID;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->ID:I

    return v0
.end method

.method static synthetic access$300(Lcom/lge/systemservice/service/SmartCoverService$AppsportID;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryType:I

    return v0
.end method

.method static synthetic access$400(Lcom/lge/systemservice/service/SmartCoverService$AppsportID;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    .prologue
    iget v0, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryColor:I

    return v0
.end method

.method static synthetic access$500(Lcom/lge/systemservice/service/SmartCoverService$AppsportID;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    .prologue
    iget-boolean v0, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableUSB:Z

    return v0
.end method

.method static synthetic access$600(Lcom/lge/systemservice/service/SmartCoverService$AppsportID;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    .prologue
    iget-boolean v0, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableGPIO:Z

    return v0
.end method

.method private parse(I)V
    .locals 3
    .param p1, "value"    # I

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    shr-int/lit8 v0, p1, 0x1d

    and-int/lit8 v0, v0, 0x7

    iput v0, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryType:I

    shr-int/lit8 v0, p1, 0x1a

    and-int/lit8 v0, v0, 0x7

    iput v0, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryColor:I

    const/high16 v0, 0x2000000

    and-int/2addr v0, p1

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    iput-boolean v0, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableUSB:Z

    const/high16 v0, 0x1000000

    and-int/2addr v0, p1

    if-eqz v0, :cond_1

    :goto_1
    iput-boolean v1, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableGPIO:Z

    const v0, 0xffffff

    and-int/2addr v0, p1

    iput v0, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->ID:I

    return-void

    :cond_0
    move v0, v2

    goto :goto_0

    :cond_1
    move v1, v2

    goto :goto_1
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4
    .param p1, "o"    # Ljava/lang/Object;

    .prologue
    const/4 v1, 0x0

    instance-of v2, p1, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    if-nez v2, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    move-object v0, p1

    check-cast v0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;

    .local v0, "a":Lcom/lge/systemservice/service/SmartCoverService$AppsportID;
    iget v2, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->ID:I

    iget v3, v0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->ID:I

    if-ne v2, v3, :cond_0

    iget v2, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryType:I

    iget v3, v0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryType:I

    if-ne v2, v3, :cond_0

    iget v2, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryColor:I

    iget v3, v0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryColor:I

    if-ne v2, v3, :cond_0

    iget-boolean v2, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableUSB:Z

    iget-boolean v3, v0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableUSB:Z

    if-ne v2, v3, :cond_0

    iget-boolean v2, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableGPIO:Z

    iget-boolean v3, v0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableGPIO:Z

    if-ne v2, v3, :cond_0

    const/4 v1, 0x1

    goto :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-super {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " - ID:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->ID:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " AccessaryType:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryType:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " AccessaryColor:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->AccessaryColor:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " enableUSB:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableUSB:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " enableGPIO:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/lge/systemservice/service/SmartCoverService$AppsportID;->enableGPIO:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
