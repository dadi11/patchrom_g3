.class Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthNafTest;
.super Lcom/lge/uicc/framework/IsimRecordLoader$IsimTest;
.source "IsimRecordLoader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/uicc/framework/IsimRecordLoader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "GbaAuthNafTest"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/uicc/framework/IsimRecordLoader;


# direct methods
.method private constructor <init>(Lcom/lge/uicc/framework/IsimRecordLoader;)V
    .locals 1

    .prologue
    iput-object p1, p0, Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthNafTest;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/lge/uicc/framework/IsimRecordLoader$IsimTest;-><init>(Lcom/lge/uicc/framework/IsimRecordLoader;Lcom/lge/uicc/framework/IsimRecordLoader$1;)V

    return-void
.end method

.method synthetic constructor <init>(Lcom/lge/uicc/framework/IsimRecordLoader;Lcom/lge/uicc/framework/IsimRecordLoader$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/lge/uicc/framework/IsimRecordLoader;
    .param p2, "x1"    # Lcom/lge/uicc/framework/IsimRecordLoader$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthNafTest;-><init>(Lcom/lge/uicc/framework/IsimRecordLoader;)V

    return-void
.end method


# virtual methods
.method getTestName()Ljava/lang/String;
    .locals 1

    .prologue
    const-string v0, "GBA_AUTHENTICATE_NAF"

    return-object v0
.end method

.method onTestCompleted(Ljava/lang/Object;)V
    .locals 10
    .param p1, "result"    # Ljava/lang/Object;

    .prologue
    :try_start_0
    check-cast p1, [B

    .end local p1    # "result":Ljava/lang/Object;
    move-object v0, p1

    check-cast v0, [B

    move-object v2, v0

    .local v2, "ks_ext_naf":[B
    iget-object v3, p0, Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthNafTest;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "ISIM GBA NAF: ks_ext_naf = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {v2}, Lcom/android/internal/telephony/uicc/IccUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/lge/uicc/framework/IsimRecordLoader;->logp(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v2    # "ks_ext_naf":[B
    :goto_0
    iget-object v3, p0, Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthNafTest;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    const-string v4, "De-selecting ISIM Application"

    invoke-virtual {v3, v4}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthNafTest;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "int_session_id="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget v5, Lcom/lge/uicc/framework/IsimRecordLoader;->isim_session_id:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/lge/uicc/framework/IsimRecordLoader;->logd(Ljava/lang/String;)V

    # getter for: Lcom/lge/uicc/framework/IsimRecordLoader;->mRil:Lcom/android/internal/telephony/RIL;
    invoke-static {}, Lcom/lge/uicc/framework/IsimRecordLoader;->access$600()Lcom/android/internal/telephony/RIL;

    move-result-object v3

    sget v4, Lcom/lge/uicc/framework/IsimRecordLoader;->isim_session_id:I

    iget-object v5, p0, Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthNafTest;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    const/4 v6, 0x2

    new-instance v7, Lcom/lge/uicc/framework/IsimRecordLoader$DeactivateAppTest;

    iget-object v8, p0, Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthNafTest;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    const/4 v9, 0x0

    invoke-direct {v7, v8, v9}, Lcom/lge/uicc/framework/IsimRecordLoader$DeactivateAppTest;-><init>(Lcom/lge/uicc/framework/IsimRecordLoader;Lcom/lge/uicc/framework/IsimRecordLoader$1;)V

    invoke-virtual {v5, v6, v7}, Lcom/lge/uicc/framework/IsimRecordLoader;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Lcom/android/internal/telephony/RIL;->uiccDeactivateApplication(ILandroid/os/Message;)V

    return-void

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    iget-object v3, p0, Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthNafTest;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Failed to parse ISIM GBA NAF contents: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/lge/uicc/framework/IsimRecordLoader;->loge(Ljava/lang/String;)V

    goto :goto_0
.end method

.method onTestException(Ljava/lang/Throwable;)V
    .locals 3
    .param p1, "exception"    # Ljava/lang/Throwable;

    .prologue
    iget-object v0, p0, Lcom/lge/uicc/framework/IsimRecordLoader$GbaAuthNafTest;->this$0:Lcom/lge/uicc/framework/IsimRecordLoader;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Exception ISIM GBA NAF: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/uicc/framework/IsimRecordLoader;->loge(Ljava/lang/String;)V

    return-void
.end method
