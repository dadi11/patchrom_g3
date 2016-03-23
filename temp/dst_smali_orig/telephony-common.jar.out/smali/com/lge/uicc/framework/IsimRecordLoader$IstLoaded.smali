.class Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;
.super Lcom/lge/uicc/framework/IccHandler$RecordLoaded;
.source "IsimRecordLoader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/uicc/framework/IsimRecordLoader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "IstLoaded"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/uicc/framework/IsimRecordLoader;


# direct methods
.method private constructor <init>(Lcom/lge/uicc/framework/IsimRecordLoader;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    invoke-direct {p0, p1}, Lcom/lge/uicc/framework/IccHandler$RecordLoaded;-><init>(Lcom/lge/uicc/framework/IccHandler;)V

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/uicc/framework/IsimRecordLoader;Lcom/lge/uicc/framework/IsimRecordLoader$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/uicc/framework/IsimRecordLoader;
    .param p2, "x1"    # Lcom/lge/uicc/framework/IsimRecordLoader$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;-><init>(Lcom/lge/uicc/framework/IsimRecordLoader;)V

    return-void
.end method


# virtual methods
.method onLoadCompleted(Ljava/lang/Object;)V
    .locals 9
    .param p1, "result"    # Ljava/lang/Object;

    .prologue
    const/4 v8, 0x0

    const/4 v2, 0x0

    iget-object v1, p0, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    const-string v3, "EF_IST loaded"

    invoke-virtual {v1, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    check-cast p1, [B

    .end local p1    # "result":Ljava/lang/Object;
    move-object v0, p1

    check-cast v0, [B

    .local v0, "data":[B
    iget-object v1, p0, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    invoke-static {v0}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v1, Lcom/lge/uicc/framework/IsimRecordLoader;->mIsimIst:Ljava/lang/String;

    if-eqz v0, :cond_0

    aget-byte v1, v0, v2

    and-int/lit8 v1, v1, 0x2

    if-eqz v1, :cond_1

    const/4 v1, 0x1

    :goto_0
    sput-boolean v1, Lcom/lge/uicc/framework/IsimRecordLoader;->mIsGbaSupported:Z

    :cond_0
    sget-boolean v1, Lcom/lge/uicc/framework/IsimRecordLoader;->mIsGbaSupported:Z

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    const-string v3, "fetch EF_ISIM_GBABP"

    invoke-virtual {v1, v3}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    const/4 v3, 0x3

    const/16 v4, 0x6fd5

    iget-object v5, p0, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    new-instance v6, Lcom/lge/uicc/framework/IsimRecordLoader$GbabpLoaded;

    iget-object v7, p0, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    invoke-direct {v6, v7, v8}, Lcom/lge/uicc/framework/IsimRecordLoader$GbabpLoaded;-><init>(Lcom/lge/uicc/framework/IsimRecordLoader;Lcom/lge/uicc/framework/IsimRecordLoader$1;)V

    invoke-virtual {v5, v6}, Lcom/lge/uicc/framework/IsimRecordLoader;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordLoaded;)Landroid/os/Message;

    move-result-object v5

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/lge/uicc/framework/IsimRecordLoader;->loadEFTransparent(IIILandroid/os/Message;)V

    iget-object v1, p0, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    # operator++ for: Lcom/lge/uicc/framework/IsimRecordLoader;->recordsToIsimLoad:I
    invoke-static {v1}, Lcom/lge/uicc/framework/IsimRecordLoader;->access$308(Lcom/lge/uicc/framework/IsimRecordLoader;)I

    :goto_1
    iget-object v1, p0, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "EF_IST="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-byte v2, v0, v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/lge/uicc/framework/IsimRecordLoader;->logp(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EF_IST="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/uicc/framework/IsimRecordLoader$IstLoaded;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    iget-object v3, v3, Lcom/lge/uicc/framework/IsimRecordLoader;->mIsimIst:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/lge/uicc/framework/IsimRecordLoader;->logp(Ljava/lang/String;)V

    return-void

    :cond_1
    move v1, v2

    goto :goto_0

    :cond_2
    sput-object v8, Lcom/lge/uicc/framework/IsimRecordLoader;->mRand:[B

    sput-object v8, Lcom/lge/uicc/framework/IsimRecordLoader;->mBtid:Ljava/lang/String;

    sput-object v8, Lcom/lge/uicc/framework/IsimRecordLoader;->mKeyLifetime:Ljava/lang/String;

    goto :goto_1
.end method
