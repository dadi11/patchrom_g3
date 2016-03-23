.class public Lcom/lge/uicc/framework/SimPhonebookService;
.super Lcom/lge/uicc/ISimPhonebookService$Stub;
.source "SimPhonebookService.java"

# interfaces
.implements Lcom/lge/uicc/framework/PbmEnum;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/uicc/framework/SimPhonebookService$1;,
        Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;
    }
.end annotation


# static fields
.field private static final EVENT_GET_INIT_STATE_DONE:I = 0x2

.field private static final EVENT_PBREADY:I = 0x3

.field private static final EVENT_PROXY_SIM_READY:I = 0x1

.field private static final SUPPORT_GROUP:Z

.field private static mPbmService:Lcom/lge/uicc/framework/SimPhonebookService;


# instance fields
.field private mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmService:Lcom/lge/uicc/framework/SimPhonebookService;

    return-void
.end method

.method private constructor <init>()V
    .locals 4

    .prologue
    invoke-direct {p0}, Lcom/lge/uicc/ISimPhonebookService$Stub;-><init>()V

    new-instance v0, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;-><init>(Lcom/lge/uicc/framework/SimPhonebookService;Lcom/lge/uicc/framework/SimPhonebookService$1;)V

    iput-object v0, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    const-string v0, "proxy.sim_state"

    iget-object v1, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    const/4 v2, 0x1

    const-string v3, "READY"

    invoke-static {v0, v1, v2, v3}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    const-string v0, "pbm_state"

    iget-object v1, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    const/4 v2, 0x3

    const-string v3, "READY"

    invoke-static {v0, v1, v2, v3}, Lcom/lge/uicc/framework/LGUICC;->registerForConfig(Ljava/lang/String;Landroid/os/Handler;ILjava/lang/String;)V

    return-void
.end method

.method static synthetic access$100(Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
    invoke-static {p0}, Lcom/lge/uicc/framework/SimPhonebookService;->logd(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$200(Lcom/lge/uicc/framework/SimPhonebookService;)Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;
    .locals 1
    .param p0, "x0"    # Lcom/lge/uicc/framework/SimPhonebookService;

    .prologue
    iget-object v0, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    return-object v0
.end method

.method static synthetic access$300(Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
    invoke-static {p0}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    return-void
.end method

.method private static convertValidSeparators(Ljava/lang/String;IZ)Ljava/lang/String;
    .locals 6
    .param p0, "number"    # Ljava/lang/String;
    .param p1, "type"    # I
    .param p2, "inverse"    # Z

    .prologue
    const/16 v5, 0x2b

    if-nez p0, :cond_0

    const-string v4, ""

    :goto_0
    return-object v4

    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    .local v2, "len":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    .local v3, "ret":Ljava/lang/StringBuilder;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    if-ge v1, v2, :cond_3

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .local v0, "c":C
    if-eqz p2, :cond_2

    :cond_1
    :goto_2
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_2
    const/4 v4, 0x1

    if-ne p1, v4, :cond_1

    if-nez v1, :cond_1

    if-eq v0, v5, :cond_1

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_2

    .end local v0    # "c":C
    :cond_3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_0
.end method

.method private static detectType(Ljava/lang/String;)I
    .locals 3
    .param p0, "num"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x2b

    if-ne v1, v2, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method private dumpPbmInfo(Ljava/lang/String;Lcom/lge/uicc/framework/PbmInfo;)V
    .locals 5
    .param p1, "description"    # Ljava/lang/String;
    .param p2, "info"    # Lcom/lge/uicc/framework/PbmInfo;

    .prologue
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "|"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|device="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p2, Lcom/lge/uicc/framework/PbmInfo;->device:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|status="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p2, Lcom/lge/uicc/framework/PbmInfo;->status:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|file_type="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p2, Lcom/lge/uicc/framework/PbmInfo;->file_type:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|max_num_length="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p2, Lcom/lge/uicc/framework/PbmInfo;->max_num_length:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|max_text_length="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p2, Lcom/lge/uicc/framework/PbmInfo;->max_text_length:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|num_of_free_ext="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p2, Lcom/lge/uicc/framework/PbmInfo;->num_of_free_ext:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|num_of_tot_rec="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p2, Lcom/lge/uicc/framework/PbmInfo;->num_of_tot_rec:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|num_of_used_rec="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p2, Lcom/lge/uicc/framework/PbmInfo;->num_of_used_rec:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .local v1, "log1":Ljava/lang/String;
    const-string v2, ""

    .local v2, "log2":Ljava/lang/String;
    iget-object v3, p2, Lcom/lge/uicc/framework/PbmInfo;->records_in_pb_set:[I

    if-eqz v3, :cond_0

    const/4 v0, 0x0

    .local v0, "index":I
    :goto_0
    iget-object v3, p2, Lcom/lge/uicc/framework/PbmInfo;->records_in_pb_set:[I

    array-length v3, v3

    if-ge v0, v3, :cond_0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "| records_in_pb_set["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p2, Lcom/lge/uicc/framework/PbmInfo;->records_in_pb_set:[I

    aget v4, v4, v0

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "| used_records_in_pb_set["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p2, Lcom/lge/uicc/framework/PbmInfo;->used_records_in_pb_set:[I

    aget v4, v4, v0

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .end local v0    # "index":I
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/lge/uicc/framework/SimPhonebookService;->logd(Ljava/lang/String;)V

    return-void
.end method

.method private static logd(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[PbmService] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logd(Ljava/lang/String;)V

    return-void
.end method

.method private static loge(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[PbmService] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->loge(Ljava/lang/String;)V

    return-void
.end method

.method private static logp(Ljava/lang/String;)V
    .locals 2
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[PbmService] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logp(Ljava/lang/String;)V

    return-void
.end method

.method private newPbmGroupRecordWithoutGroupIndex(Lcom/lge/uicc/SimPhonebookBaseEntry;)Lcom/lge/uicc/framework/PbmRecord;
    .locals 3
    .param p1, "group"    # Lcom/lge/uicc/SimPhonebookBaseEntry;

    .prologue
    const/4 v2, 0x0

    new-instance v0, Lcom/lge/uicc/framework/PbmRecord;

    invoke-direct {v0}, Lcom/lge/uicc/framework/PbmRecord;-><init>()V

    .local v0, "record":Lcom/lge/uicc/framework/PbmRecord;
    const/16 v1, 0x20

    iput v1, v0, Lcom/lge/uicc/framework/PbmRecord;->device:I

    iput v2, v0, Lcom/lge/uicc/framework/PbmRecord;->sync_cnt:I

    iput v2, v0, Lcom/lge/uicc/framework/PbmRecord;->type:I

    iput v2, v0, Lcom/lge/uicc/framework/PbmRecord;->ad_type:I

    iput v2, v0, Lcom/lge/uicc/framework/PbmRecord;->gas_id:I

    iput v2, v0, Lcom/lge/uicc/framework/PbmRecord;->index:I

    iget-object v1, p1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mName:Ljava/lang/String;

    iput-object v1, v0, Lcom/lge/uicc/framework/PbmRecord;->name:Ljava/lang/String;

    iget-object v1, v0, Lcom/lge/uicc/framework/PbmRecord;->name:Ljava/lang/String;

    if-nez v1, :cond_0

    const-string v1, ""

    iput-object v1, v0, Lcom/lge/uicc/framework/PbmRecord;->name:Ljava/lang/String;

    :cond_0
    const-string v1, ""

    iput-object v1, v0, Lcom/lge/uicc/framework/PbmRecord;->number:Ljava/lang/String;

    const-string v1, ""

    iput-object v1, v0, Lcom/lge/uicc/framework/PbmRecord;->additional_number:Ljava/lang/String;

    const-string v1, ""

    iput-object v1, v0, Lcom/lge/uicc/framework/PbmRecord;->additional_number_a:Ljava/lang/String;

    const-string v1, ""

    iput-object v1, v0, Lcom/lge/uicc/framework/PbmRecord;->additional_number_b:Ljava/lang/String;

    const-string v1, ""

    iput-object v1, v0, Lcom/lge/uicc/framework/PbmRecord;->email_address:Ljava/lang/String;

    const-string v1, ""

    iput-object v1, v0, Lcom/lge/uicc/framework/PbmRecord;->second_name:Ljava/lang/String;

    return-object v0
.end method

.method private newPbmRecordWithoutSimIndex(Lcom/lge/uicc/SimPhonebookBaseEntry;)Lcom/lge/uicc/framework/PbmRecord;
    .locals 10
    .param p1, "entry"    # Lcom/lge/uicc/SimPhonebookBaseEntry;

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    new-instance v5, Lcom/lge/uicc/framework/PbmRecord;

    invoke-direct {v5}, Lcom/lge/uicc/framework/PbmRecord;-><init>()V

    .local v5, "records":Lcom/lge/uicc/framework/PbmRecord;
    iput v8, v5, Lcom/lge/uicc/framework/PbmRecord;->device:I

    iput v8, v5, Lcom/lge/uicc/framework/PbmRecord;->sync_cnt:I

    iput v8, v5, Lcom/lge/uicc/framework/PbmRecord;->type:I

    iput v8, v5, Lcom/lge/uicc/framework/PbmRecord;->ad_type:I

    iget-object v7, p1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mName:Ljava/lang/String;

    iput-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->name:Ljava/lang/String;

    iget-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->name:Ljava/lang/String;

    if-nez v7, :cond_0

    const-string v7, ""

    iput-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->name:Ljava/lang/String;

    :cond_0
    iget-object v4, p1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mNumbers:Landroid/util/SparseArray;

    .local v4, "numbers":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    invoke-virtual {v4, v8}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .local v3, "number":Ljava/lang/String;
    if-nez v3, :cond_2

    const-string v7, ""

    iput-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->number:Ljava/lang/String;

    :goto_0
    const-string v7, ""

    iput-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->additional_number:Ljava/lang/String;

    const-string v7, ""

    iput-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->additional_number_a:Ljava/lang/String;

    const-string v7, ""

    iput-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->additional_number_b:Ljava/lang/String;

    invoke-virtual {v4}, Landroid/util/SparseArray;->size()I

    move-result v7

    if-lez v7, :cond_3

    invoke-virtual {v4}, Landroid/util/SparseArray;->size()I

    move-result v2

    .local v2, "length":I
    const/4 v1, 0x1

    .local v1, "i":I
    :goto_1
    if-ge v1, v2, :cond_3

    invoke-virtual {v4, v1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v3

    .end local v3    # "number":Ljava/lang/String;
    check-cast v3, Ljava/lang/String;

    .restart local v3    # "number":Ljava/lang/String;
    if-eqz v3, :cond_1

    invoke-static {v3}, Lcom/lge/uicc/framework/SimPhonebookService;->detectType(Ljava/lang/String;)I

    move-result v7

    iput v7, v5, Lcom/lge/uicc/framework/PbmRecord;->ad_type:I

    iget v7, v5, Lcom/lge/uicc/framework/PbmRecord;->ad_type:I

    invoke-static {v3, v7, v9}, Lcom/lge/uicc/framework/SimPhonebookService;->convertValidSeparators(Ljava/lang/String;IZ)Ljava/lang/String;

    move-result-object v3

    packed-switch v1, :pswitch_data_0

    :cond_1
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .end local v1    # "i":I
    .end local v2    # "length":I
    :cond_2
    invoke-static {v3}, Lcom/lge/uicc/framework/SimPhonebookService;->detectType(Ljava/lang/String;)I

    move-result v7

    iput v7, v5, Lcom/lge/uicc/framework/PbmRecord;->type:I

    iget v7, v5, Lcom/lge/uicc/framework/PbmRecord;->type:I

    invoke-static {v3, v7, v9}, Lcom/lge/uicc/framework/SimPhonebookService;->convertValidSeparators(Ljava/lang/String;IZ)Ljava/lang/String;

    move-result-object v7

    iput-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->number:Ljava/lang/String;

    goto :goto_0

    .restart local v1    # "i":I
    .restart local v2    # "length":I
    :pswitch_0
    iput-object v3, v5, Lcom/lge/uicc/framework/PbmRecord;->additional_number:Ljava/lang/String;

    goto :goto_2

    :pswitch_1
    iput-object v3, v5, Lcom/lge/uicc/framework/PbmRecord;->additional_number_a:Ljava/lang/String;

    goto :goto_2

    :pswitch_2
    iput-object v3, v5, Lcom/lge/uicc/framework/PbmRecord;->additional_number_b:Ljava/lang/String;

    goto :goto_2

    .end local v1    # "i":I
    .end local v2    # "length":I
    :cond_3
    iget-object v0, p1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mEmails:Landroid/util/SparseArray;

    .local v0, "emails":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    invoke-virtual {v0, v8}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    iput-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->email_address:Ljava/lang/String;

    iget-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->email_address:Ljava/lang/String;

    if-nez v7, :cond_4

    const-string v7, ""

    iput-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->email_address:Ljava/lang/String;

    :cond_4
    iget-object v6, p1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mSecondName:Landroid/util/SparseArray;

    .local v6, "sne":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    invoke-virtual {v6, v8}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    iput-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->second_name:Ljava/lang/String;

    iget-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->second_name:Ljava/lang/String;

    if-nez v7, :cond_5

    const-string v7, ""

    iput-object v7, v5, Lcom/lge/uicc/framework/PbmRecord;->second_name:Ljava/lang/String;

    :cond_5
    iget v7, p1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mGroupId:I

    iput v7, v5, Lcom/lge/uicc/framework/PbmRecord;->gas_id:I

    return-object v5

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method protected static setup()V
    .locals 2

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmService:Lcom/lge/uicc/framework/SimPhonebookService;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/uicc/framework/SimPhonebookService;

    invoke-direct {v0}, Lcom/lge/uicc/framework/SimPhonebookService;-><init>()V

    sput-object v0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmService:Lcom/lge/uicc/framework/SimPhonebookService;

    :cond_0
    const-string v0, "lguiccpbm"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    if-nez v0, :cond_1

    const-string v0, "lguiccpbm"

    sget-object v1, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmService:Lcom/lge/uicc/framework/SimPhonebookService;

    invoke-static {v0, v1}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    :cond_1
    return-void
.end method


# virtual methods
.method public deleteEntry(II)I
    .locals 3
    .param p1, "slot"    # I
    .param p2, "simIndex"    # I

    .prologue
    const/4 v0, 0x0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v1

    const/16 v2, 0x7d0

    if-ne v1, v2, :cond_0

    :goto_0
    return v0

    :cond_0
    if-gtz p2, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "deleteEntry: invalid sim index="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->deleteRecord(III)I
    invoke-static {v1, p1, v0, p2}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$700(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;III)I

    move-result v0

    goto :goto_0
.end method

.method public deleteGroup(II)I
    .locals 3
    .param p1, "slot"    # I
    .param p2, "groupIndex"    # I

    .prologue
    const/4 v0, 0x0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v1

    const/16 v2, 0x7d0

    if-ne v1, v2, :cond_0

    :goto_0
    return v0

    :cond_0
    if-gtz p2, :cond_1

    const-string v1, "deleteGroup: gas_id MUST be greater than 0!"

    invoke-static {v1}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    const/16 v1, 0x20

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->deleteRecord(III)I
    invoke-static {v0, p1, v1, p2}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$700(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;III)I

    move-result v0

    goto :goto_0
.end method

.method public getSimPhonebookInfo(I)Lcom/lge/uicc/SimPhonebookBaseInfo;
    .locals 13
    .param p1, "slot"    # I

    .prologue
    const/4 v12, 0x1

    const/4 v11, 0x0

    const/4 v8, 0x0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v9

    const/16 v10, 0x7d0

    if-ne v9, v10, :cond_0

    move-object v1, v8

    :goto_0
    return-object v1

    :cond_0
    if-ltz p1, :cond_1

    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getSlots()I

    move-result v9

    if-lt p1, v9, :cond_2

    :cond_1
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "getSimPhonebookInfo: error: slot="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    move-object v1, v8

    goto :goto_0

    :cond_2
    new-instance v1, Lcom/lge/uicc/SimPhonebookBaseInfo;

    invoke-direct {v1}, Lcom/lge/uicc/SimPhonebookBaseInfo;-><init>()V

    .local v1, "globalInfo":Lcom/lge/uicc/SimPhonebookBaseInfo;
    new-instance v6, Landroid/util/SparseArray;

    invoke-direct {v6}, Landroid/util/SparseArray;-><init>()V

    .local v6, "sliceInfo":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;>;"
    const-string v9, "load ADN"

    invoke-static {v9}, Lcom/lge/uicc/framework/SimPhonebookService;->logd(Ljava/lang/String;)V

    iget-object v9, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->getInfo(II)Lcom/lge/uicc/framework/PbmInfo;
    invoke-static {v9, p1, v11}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$400(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;II)Lcom/lge/uicc/framework/PbmInfo;

    move-result-object v3

    .local v3, "info":Lcom/lge/uicc/framework/PbmInfo;
    if-nez v3, :cond_3

    const-string v9, "getSimPhonebookInfo: Fails to get ADN"

    invoke-static {v9}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    move-object v1, v8

    goto :goto_0

    :cond_3
    iget v9, v3, Lcom/lge/uicc/framework/PbmInfo;->status:I

    if-nez v9, :cond_4

    iget-object v9, v3, Lcom/lge/uicc/framework/PbmInfo;->records_in_pb_set:[I

    if-nez v9, :cond_5

    :cond_4
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "getSimPhonebookInfo: ADN: status="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget v10, v3, Lcom/lge/uicc/framework/PbmInfo;->status:I

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/lge/uicc/framework/SimPhonebookService;->logd(Ljava/lang/String;)V

    const-string v9, "ADN"

    invoke-direct {p0, v9, v3}, Lcom/lge/uicc/framework/SimPhonebookService;->dumpPbmInfo(Ljava/lang/String;Lcom/lge/uicc/framework/PbmInfo;)V

    move-object v1, v8

    goto :goto_0

    :cond_5
    iget v9, v3, Lcom/lge/uicc/framework/PbmInfo;->num_of_tot_rec:I

    if-nez v9, :cond_6

    const-string v9, "getSimPhonebookInfo: number of total record is 0!!!"

    invoke-static {v9}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    move-object v1, v8

    goto :goto_0

    :cond_6
    iget-object v8, v3, Lcom/lge/uicc/framework/PbmInfo;->records_in_pb_set:[I

    array-length v8, v8

    iput v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSliceCount:I

    iput v12, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableEmailount:I

    iput v12, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalSneCount:I

    iput v12, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableGroupCount:I

    const-string v8, "GSMAlpha"

    iput-object v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNameEncodingType:Ljava/lang/String;

    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->max_text_length:I

    iput v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNameMaxbyteLength:I

    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->max_num_length:I

    iput v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNumberMaxLength:I

    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->max_num_length:I

    iput v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mExternalNumberMaxLength:I

    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->num_of_free_ext:I

    iput v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mFreeExternalNumberCount:I

    const-string v8, ""

    iput-object v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mGroupNameEncodingType:Ljava/lang/String;

    iput v11, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalGroupCount:I

    iput v11, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mGroupNameMaxByteLength:I

    const/4 v7, 0x0

    .local v7, "totalAdn":I
    const/4 v2, 0x0

    .local v2, "index":I
    :goto_1
    iget-object v8, v3, Lcom/lge/uicc/framework/PbmInfo;->records_in_pb_set:[I

    array-length v8, v8

    if-ge v2, v8, :cond_7

    new-instance v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;

    invoke-direct {v5}, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;-><init>()V

    .local v5, "slice":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    iget-object v8, v3, Lcom/lge/uicc/framework/PbmInfo;->records_in_pb_set:[I

    aget v8, v8, v2

    iput v8, v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mAdnCount:I

    invoke-virtual {v6, v2, v5}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    iget-object v8, v3, Lcom/lge/uicc/framework/PbmInfo;->records_in_pb_set:[I

    aget v8, v8, v2

    add-int/2addr v7, v8

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .end local v5    # "slice":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    :cond_7
    iput v7, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalAdncount:I

    const-string v8, "onAdn"

    invoke-direct {p0, v8, v3}, Lcom/lge/uicc/framework/SimPhonebookService;->dumpPbmInfo(Ljava/lang/String;Lcom/lge/uicc/framework/PbmInfo;)V

    const-string v8, "load ANR"

    invoke-static {v8}, Lcom/lge/uicc/framework/SimPhonebookService;->logd(Ljava/lang/String;)V

    const/4 v4, 0x0

    .local v4, "key":I
    const/16 v0, 0xf

    .local v0, "efdev":I
    :goto_2
    const/16 v8, 0x16

    if-gt v0, v8, :cond_8

    iget-object v8, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->getInfo(II)Lcom/lge/uicc/framework/PbmInfo;
    invoke-static {v8, p1, v0}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$400(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;II)Lcom/lge/uicc/framework/PbmInfo;

    move-result-object v3

    invoke-virtual {v6, v4}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;

    .restart local v5    # "slice":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    if-eqz v3, :cond_8

    if-nez v5, :cond_b

    .end local v5    # "slice":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    :cond_8
    const-string v8, "load EMAIL"

    invoke-static {v8}, Lcom/lge/uicc/framework/SimPhonebookService;->logd(Ljava/lang/String;)V

    const/4 v4, 0x0

    const/4 v0, 0x7

    :goto_3
    const/16 v8, 0xe

    if-gt v0, v8, :cond_9

    iget-object v8, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->getInfo(II)Lcom/lge/uicc/framework/PbmInfo;
    invoke-static {v8, p1, v0}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$400(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;II)Lcom/lge/uicc/framework/PbmInfo;

    move-result-object v3

    invoke-virtual {v6, v4}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;

    .restart local v5    # "slice":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    if-eqz v3, :cond_9

    if-nez v5, :cond_d

    .end local v5    # "slice":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    :cond_9
    const-string v8, "load SNE"

    invoke-static {v8}, Lcom/lge/uicc/framework/SimPhonebookService;->logd(Ljava/lang/String;)V

    const/4 v4, 0x0

    const/16 v0, 0x24

    :goto_4
    const/16 v8, 0x2b

    if-gt v0, v8, :cond_a

    iget-object v8, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->getInfo(II)Lcom/lge/uicc/framework/PbmInfo;
    invoke-static {v8, p1, v0}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$400(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;II)Lcom/lge/uicc/framework/PbmInfo;

    move-result-object v3

    invoke-virtual {v6, v4}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;

    .restart local v5    # "slice":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    if-eqz v3, :cond_a

    if-nez v5, :cond_f

    .end local v5    # "slice":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    :cond_a
    const-string v8, "return SimPhonebookBaseInfo"

    invoke-static {v8}, Lcom/lge/uicc/framework/SimPhonebookService;->logd(Ljava/lang/String;)V

    iput-object v6, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSlices:Landroid/util/SparseArray;

    goto/16 :goto_0

    .restart local v5    # "slice":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    :cond_b
    const/16 v8, 0xf

    if-ne v0, v8, :cond_c

    const/16 v8, 0x14

    iput v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAnrMaxLength:I

    iget-object v8, v3, Lcom/lge/uicc/framework/PbmInfo;->records_in_pb_set:[I

    aget v8, v8, v11

    iput v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableAnrCount:I

    :cond_c
    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->file_type:I

    and-int/lit8 v8, v8, 0xf

    iput v8, v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mAnrType:I

    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->num_of_tot_rec:I

    iput v8, v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mAnrCount:I

    iget-object v8, v3, Lcom/lge/uicc/framework/PbmInfo;->used_records_in_pb_set:[I

    iput-object v8, v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mUsedAnrCount:[I

    invoke-virtual {v6, v4, v5}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "onAnr["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "]"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {p0, v8, v3}, Lcom/lge/uicc/framework/SimPhonebookService;->dumpPbmInfo(Ljava/lang/String;Lcom/lge/uicc/framework/PbmInfo;)V

    add-int/lit8 v0, v0, 0x1

    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_2

    :cond_d
    const/4 v8, 0x7

    if-ne v0, v8, :cond_e

    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->max_text_length:I

    iput v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mEmailMaxByteLength:I

    const-string v8, "GSM7"

    iput-object v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mEmailencodingType:Ljava/lang/String;

    :cond_e
    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->file_type:I

    and-int/lit8 v8, v8, 0xf

    iput v8, v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mEmailType:I

    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->num_of_tot_rec:I

    iput v8, v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mEmailCount:I

    iget-object v8, v3, Lcom/lge/uicc/framework/PbmInfo;->used_records_in_pb_set:[I

    iput-object v8, v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mUsedEmailCount:[I

    invoke-virtual {v6, v4, v5}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "onEmail["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "]"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {p0, v8, v3}, Lcom/lge/uicc/framework/SimPhonebookService;->dumpPbmInfo(Ljava/lang/String;Lcom/lge/uicc/framework/PbmInfo;)V

    add-int/lit8 v0, v0, 0x1

    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_3

    :cond_f
    const/16 v8, 0x24

    if-ne v0, v8, :cond_10

    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->max_text_length:I

    iput v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSneMaxByteLength:I

    const-string v8, "GSM7"

    iput-object v8, v1, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSneencodingType:Ljava/lang/String;

    :cond_10
    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->file_type:I

    and-int/lit8 v8, v8, 0xf

    iput v8, v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mSneType:I

    iget v8, v3, Lcom/lge/uicc/framework/PbmInfo;->num_of_tot_rec:I

    iput v8, v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mSneCount:I

    iget-object v8, v3, Lcom/lge/uicc/framework/PbmInfo;->used_records_in_pb_set:[I

    iput-object v8, v5, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mUsedSneCount:[I

    invoke-virtual {v6, v4, v5}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "onsne["

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "]"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {p0, v8, v3}, Lcom/lge/uicc/framework/SimPhonebookService;->dumpPbmInfo(Ljava/lang/String;Lcom/lge/uicc/framework/PbmInfo;)V

    add-int/lit8 v0, v0, 0x1

    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_4
.end method

.method public insertEntry(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    .locals 4
    .param p1, "slot"    # I
    .param p2, "simIndex"    # I
    .param p3, "entry"    # Lcom/lge/uicc/SimPhonebookBaseEntry;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v2

    const/16 v3, 0x7d0

    if-ne v2, v3, :cond_0

    :goto_0
    return v1

    :cond_0
    if-ltz p1, :cond_1

    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getSlots()I

    move-result v2

    if-lt p1, v2, :cond_2

    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "insertEntry: error: slot="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    if-gtz p2, :cond_3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "insertEntry: invalid sim index="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    invoke-direct {p0, p3}, Lcom/lge/uicc/framework/SimPhonebookService;->newPbmRecordWithoutSimIndex(Lcom/lge/uicc/SimPhonebookBaseEntry;)Lcom/lge/uicc/framework/PbmRecord;

    move-result-object v0

    .local v0, "record":Lcom/lge/uicc/framework/PbmRecord;
    iput p2, v0, Lcom/lge/uicc/framework/PbmRecord;->index:I

    iget-object v1, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->writeRecord(ILcom/lge/uicc/framework/PbmRecord;)I
    invoke-static {v1, p1, v0}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$600(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;ILcom/lge/uicc/framework/PbmRecord;)I

    move-result v1

    goto :goto_0
.end method

.method public insertGroup(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    .locals 4
    .param p1, "slot"    # I
    .param p2, "groupIndex"    # I
    .param p3, "group"    # Lcom/lge/uicc/SimPhonebookBaseEntry;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v2

    const/16 v3, 0x7d0

    if-ne v2, v3, :cond_0

    :goto_0
    return v1

    :cond_0
    if-ltz p1, :cond_1

    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getSlots()I

    move-result v2

    if-lt p1, v2, :cond_2

    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "insertGroup: error: slot="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    invoke-direct {p0, p3}, Lcom/lge/uicc/framework/SimPhonebookService;->newPbmGroupRecordWithoutGroupIndex(Lcom/lge/uicc/SimPhonebookBaseEntry;)Lcom/lge/uicc/framework/PbmRecord;

    move-result-object v0

    .local v0, "record":Lcom/lge/uicc/framework/PbmRecord;
    iput p2, v0, Lcom/lge/uicc/framework/PbmRecord;->index:I

    iget-object v1, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->writeRecord(ILcom/lge/uicc/framework/PbmRecord;)I
    invoke-static {v1, p1, v0}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$600(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;ILcom/lge/uicc/framework/PbmRecord;)I

    move-result v1

    goto :goto_0
.end method

.method public readEntry(II)Lcom/lge/uicc/SimPhonebookBaseEntry;
    .locals 9
    .param p1, "slot"    # I
    .param p2, "simIndex"    # I

    .prologue
    const/4 v5, 0x0

    const/4 v8, 0x0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v6

    const/16 v7, 0x7d0

    if-ne v6, v7, :cond_0

    move-object v1, v5

    :goto_0
    return-object v1

    :cond_0
    if-ltz p1, :cond_1

    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getSlots()I

    move-result v6

    if-lt p1, v6, :cond_2

    :cond_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "readEntry: error: slot="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    move-object v1, v5

    goto :goto_0

    :cond_2
    iget-object v6, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->readRecord(III)Lcom/lge/uicc/framework/PbmRecord;
    invoke-static {v6, p1, v8, p2}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$500(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;III)Lcom/lge/uicc/framework/PbmRecord;

    move-result-object v3

    .local v3, "record":Lcom/lge/uicc/framework/PbmRecord;
    new-instance v1, Lcom/lge/uicc/SimPhonebookBaseEntry;

    invoke-direct {v1}, Lcom/lge/uicc/SimPhonebookBaseEntry;-><init>()V

    .local v1, "entry":Lcom/lge/uicc/SimPhonebookBaseEntry;
    if-nez v3, :cond_3

    iput v8, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mIndex:I

    const-string v6, ""

    iput-object v6, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mName:Ljava/lang/String;

    iput-object v5, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mNumbers:Landroid/util/SparseArray;

    iput-object v5, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mEmails:Landroid/util/SparseArray;

    iput-object v5, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mSecondName:Landroid/util/SparseArray;

    iput v8, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mGroupId:I

    goto :goto_0

    :cond_3
    iget v5, v3, Lcom/lge/uicc/framework/PbmRecord;->index:I

    iput v5, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mIndex:I

    iget-object v5, v3, Lcom/lge/uicc/framework/PbmRecord;->name:Ljava/lang/String;

    if-nez v5, :cond_7

    const-string v5, ""

    :goto_1
    iput-object v5, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mName:Ljava/lang/String;

    new-instance v2, Landroid/util/SparseArray;

    invoke-direct {v2}, Landroid/util/SparseArray;-><init>()V

    .local v2, "numbers":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    iget-object v5, v3, Lcom/lge/uicc/framework/PbmRecord;->number:Ljava/lang/String;

    iget v6, v3, Lcom/lge/uicc/framework/PbmRecord;->type:I

    invoke-static {v5, v6, v8}, Lcom/lge/uicc/framework/SimPhonebookService;->convertValidSeparators(Ljava/lang/String;IZ)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v8, v5}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    const-string v5, ""

    iget-object v6, v3, Lcom/lge/uicc/framework/PbmRecord;->additional_number:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_4

    const/4 v5, 0x1

    iget-object v6, v3, Lcom/lge/uicc/framework/PbmRecord;->additional_number:Ljava/lang/String;

    iget v7, v3, Lcom/lge/uicc/framework/PbmRecord;->ad_type:I

    invoke-static {v6, v7, v8}, Lcom/lge/uicc/framework/SimPhonebookService;->convertValidSeparators(Ljava/lang/String;IZ)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v5, v6}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    :cond_4
    const-string v5, ""

    iget-object v6, v3, Lcom/lge/uicc/framework/PbmRecord;->additional_number_a:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_5

    const/4 v5, 0x2

    iget-object v6, v3, Lcom/lge/uicc/framework/PbmRecord;->additional_number_a:Ljava/lang/String;

    iget v7, v3, Lcom/lge/uicc/framework/PbmRecord;->ad_type:I

    invoke-static {v6, v7, v8}, Lcom/lge/uicc/framework/SimPhonebookService;->convertValidSeparators(Ljava/lang/String;IZ)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v5, v6}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    :cond_5
    const-string v5, ""

    iget-object v6, v3, Lcom/lge/uicc/framework/PbmRecord;->additional_number_b:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_6

    const/4 v5, 0x3

    iget-object v6, v3, Lcom/lge/uicc/framework/PbmRecord;->additional_number_b:Ljava/lang/String;

    iget v7, v3, Lcom/lge/uicc/framework/PbmRecord;->ad_type:I

    invoke-static {v6, v7, v8}, Lcom/lge/uicc/framework/SimPhonebookService;->convertValidSeparators(Ljava/lang/String;IZ)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v5, v6}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    :cond_6
    iput-object v2, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mNumbers:Landroid/util/SparseArray;

    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    .local v0, "emails":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    iget-object v5, v3, Lcom/lge/uicc/framework/PbmRecord;->email_address:Ljava/lang/String;

    if-nez v5, :cond_8

    const-string v5, ""

    :goto_2
    invoke-virtual {v0, v8, v5}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    iput-object v0, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mEmails:Landroid/util/SparseArray;

    new-instance v4, Landroid/util/SparseArray;

    invoke-direct {v4}, Landroid/util/SparseArray;-><init>()V

    .local v4, "sne":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    iget-object v5, v3, Lcom/lge/uicc/framework/PbmRecord;->second_name:Ljava/lang/String;

    if-nez v5, :cond_9

    const-string v5, ""

    :goto_3
    invoke-virtual {v4, v8, v5}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    iput-object v4, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mSecondName:Landroid/util/SparseArray;

    iget v5, v3, Lcom/lge/uicc/framework/PbmRecord;->gas_id:I

    iput v5, v1, Lcom/lge/uicc/SimPhonebookBaseEntry;->mGroupId:I

    goto/16 :goto_0

    .end local v0    # "emails":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    .end local v2    # "numbers":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    .end local v4    # "sne":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    :cond_7
    iget-object v5, v3, Lcom/lge/uicc/framework/PbmRecord;->name:Ljava/lang/String;

    goto :goto_1

    .restart local v0    # "emails":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    .restart local v2    # "numbers":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    :cond_8
    iget-object v5, v3, Lcom/lge/uicc/framework/PbmRecord;->email_address:Ljava/lang/String;

    goto :goto_2

    .restart local v4    # "sne":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/String;>;"
    :cond_9
    iget-object v5, v3, Lcom/lge/uicc/framework/PbmRecord;->second_name:Ljava/lang/String;

    goto :goto_3
.end method

.method public readGroup(II)Lcom/lge/uicc/SimPhonebookBaseEntry;
    .locals 4
    .param p1, "slot"    # I
    .param p2, "groupIndex"    # I

    .prologue
    const/4 v0, 0x0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v2

    const/16 v3, 0x7d0

    if-ne v2, v3, :cond_0

    :goto_0
    return-object v0

    :cond_0
    if-ltz p1, :cond_1

    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getSlots()I

    move-result v2

    if-lt p1, v2, :cond_2

    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "readGroup: error: slot="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iget-object v2, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    const/16 v3, 0x20

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->readRecord(III)Lcom/lge/uicc/framework/PbmRecord;
    invoke-static {v2, p1, v3, p2}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$500(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;III)Lcom/lge/uicc/framework/PbmRecord;

    move-result-object v1

    .local v1, "record":Lcom/lge/uicc/framework/PbmRecord;
    new-instance v0, Lcom/lge/uicc/SimPhonebookBaseEntry;

    invoke-direct {v0}, Lcom/lge/uicc/SimPhonebookBaseEntry;-><init>()V

    .local v0, "group":Lcom/lge/uicc/SimPhonebookBaseEntry;
    if-nez v1, :cond_3

    const/4 v2, 0x0

    iput v2, v0, Lcom/lge/uicc/SimPhonebookBaseEntry;->mIndex:I

    const-string v2, ""

    iput-object v2, v0, Lcom/lge/uicc/SimPhonebookBaseEntry;->mName:Ljava/lang/String;

    goto :goto_0

    :cond_3
    iget v2, v1, Lcom/lge/uicc/framework/PbmRecord;->index:I

    iput v2, v0, Lcom/lge/uicc/SimPhonebookBaseEntry;->mIndex:I

    iget-object v2, v1, Lcom/lge/uicc/framework/PbmRecord;->name:Ljava/lang/String;

    iput-object v2, v0, Lcom/lge/uicc/SimPhonebookBaseEntry;->mName:Ljava/lang/String;

    goto :goto_0
.end method

.method public updateEntry(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    .locals 4
    .param p1, "slot"    # I
    .param p2, "simIndex"    # I
    .param p3, "entry"    # Lcom/lge/uicc/SimPhonebookBaseEntry;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v2

    const/16 v3, 0x7d0

    if-ne v2, v3, :cond_0

    :goto_0
    return v1

    :cond_0
    if-ltz p1, :cond_1

    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getSlots()I

    move-result v2

    if-lt p1, v2, :cond_2

    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "updateEntry: error: slot="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    if-gtz p2, :cond_3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "updateEntry: invalid sim index="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    invoke-direct {p0, p3}, Lcom/lge/uicc/framework/SimPhonebookService;->newPbmRecordWithoutSimIndex(Lcom/lge/uicc/SimPhonebookBaseEntry;)Lcom/lge/uicc/framework/PbmRecord;

    move-result-object v0

    .local v0, "record":Lcom/lge/uicc/framework/PbmRecord;
    iput p2, v0, Lcom/lge/uicc/framework/PbmRecord;->index:I

    iget-object v1, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->writeRecord(ILcom/lge/uicc/framework/PbmRecord;)I
    invoke-static {v1, p1, v0}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$600(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;ILcom/lge/uicc/framework/PbmRecord;)I

    move-result v1

    goto :goto_0
.end method

.method public updateGroup(IILcom/lge/uicc/SimPhonebookBaseEntry;)I
    .locals 4
    .param p1, "slot"    # I
    .param p2, "groupIndex"    # I
    .param p3, "group"    # Lcom/lge/uicc/SimPhonebookBaseEntry;

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v2

    const/16 v3, 0x7d0

    if-ne v2, v3, :cond_0

    :goto_0
    return v1

    :cond_0
    if-ltz p1, :cond_1

    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getSlots()I

    move-result v2

    if-lt p1, v2, :cond_2

    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "updateGroup: error: slot="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    if-gtz p2, :cond_3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "updateGroup: invalid group index="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/uicc/framework/SimPhonebookService;->loge(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    invoke-direct {p0, p3}, Lcom/lge/uicc/framework/SimPhonebookService;->newPbmGroupRecordWithoutGroupIndex(Lcom/lge/uicc/SimPhonebookBaseEntry;)Lcom/lge/uicc/framework/PbmRecord;

    move-result-object v0

    .local v0, "record":Lcom/lge/uicc/framework/PbmRecord;
    iput p2, v0, Lcom/lge/uicc/framework/PbmRecord;->index:I

    iget-object v1, p0, Lcom/lge/uicc/framework/SimPhonebookService;->mPbmHandler:Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;

    # invokes: Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->writeRecord(ILcom/lge/uicc/framework/PbmRecord;)I
    invoke-static {v1, p1, v0}, Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;->access$600(Lcom/lge/uicc/framework/SimPhonebookService$PbmHandler;ILcom/lge/uicc/framework/PbmRecord;)I

    move-result v1

    goto :goto_0
.end method
