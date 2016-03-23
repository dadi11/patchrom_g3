.class Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;
.super Ljava/lang/Thread;
.source "VZWAggregation.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wifi/impl/aggregation/VZWAggregation;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "AggregationSubThread"
.end annotation


# instance fields
.field isComplete:Z

.field mainURL:Ljava/lang/String;

.field param_deviceModel_Name:Ljava/lang/String;

.field param_deviceModel_Value:Ljava/lang/String;

.field param_deviceType_Name:Ljava/lang/String;

.field param_deviceType_Value:Ljava/lang/String;

.field param_password_Name:Ljava/lang/String;

.field param_password_Value:Ljava/lang/String;

.field param_stationId_Name:Ljava/lang/String;

.field param_stationId_Value:Ljava/lang/String;

.field param_userName_Name:Ljava/lang/String;

.field param_userName_Value:Ljava/lang/String;

.field redirectMaxCount:I

.field final synthetic this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;


# direct methods
.method constructor <init>(Lcom/lge/wifi/impl/aggregation/VZWAggregation;)V
    .locals 1

    .prologue
    .line 152
    iput-object p1, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 155
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->isComplete:Z

    .line 156
    const/4 v0, 0x3

    iput v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->redirectMaxCount:I

    .line 159
    const-string/jumbo v0, "www.verizon.com"

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->mainURL:Ljava/lang/String;

    .line 160
    const-string v0, "device-type"

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_deviceType_Name:Ljava/lang/String;

    .line 161
    const-string v0, "3"

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_deviceType_Value:Ljava/lang/String;

    .line 162
    const-string v0, "device-model-number"

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_deviceModel_Name:Ljava/lang/String;

    .line 164
    const-string v0, "ro.product.model"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_deviceModel_Value:Ljava/lang/String;

    .line 165
    const-string v0, "calling-station-id"

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_stationId_Name:Ljava/lang/String;

    .line 166
    const-string v0, ""

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_stationId_Value:Ljava/lang/String;

    .line 167
    const-string v0, "UserName"

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_userName_Name:Ljava/lang/String;

    .line 168
    const-string v0, ""

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_userName_Value:Ljava/lang/String;

    .line 169
    const-string v0, "Password"

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_password_Name:Ljava/lang/String;

    .line 170
    const-string v0, ""

    iput-object v0, p0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_password_Value:Ljava/lang/String;

    return-void
.end method

.method private getTagContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "page"    # Ljava/lang/String;
    .param p2, "parentTag"    # Ljava/lang/String;
    .param p3, "parentEndTag"    # Ljava/lang/String;
    .param p4, "targetTag"    # Ljava/lang/String;
    .param p5, "targetEndTag"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    const/4 v7, -0x1

    .line 356
    invoke-virtual {p1, p2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    .line 357
    .local v2, "parentStartIndex":I
    invoke-virtual {p1, p3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    .line 359
    .local v1, "parentEndIndex":I
    if-eqz p2, :cond_0

    if-eqz p3, :cond_0

    if-eqz p4, :cond_0

    if-nez p5, :cond_1

    .line 375
    :cond_0
    :goto_0
    return-object v3

    .line 362
    :cond_1
    if-eq v2, v7, :cond_0

    if-eq v1, v7, :cond_0

    .line 365
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v6

    add-int/2addr v6, v2

    invoke-virtual {p1, v6, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 367
    .local v0, "parentContent":Ljava/lang/String;
    invoke-virtual {v0, p4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v5

    .line 368
    .local v5, "targetStartIndex":I
    invoke-virtual {v0, p5}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    .line 370
    .local v4, "targetEndIndex":I
    if-eq v5, v7, :cond_0

    if-eq v4, v7, :cond_0

    .line 373
    invoke-virtual {p4}, Ljava/lang/String;->length()I

    move-result v6

    add-int/2addr v6, v5

    invoke-virtual {v0, v6, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    .line 375
    .local v3, "resultContent":Ljava/lang/String;
    goto :goto_0
.end method


# virtual methods
.method public run()V
    .locals 21

    .prologue
    .line 174
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "http://"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->mainURL:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 175
    .local v1, "lastUrl":Ljava/lang/String;
    const/16 v17, 0x0

    .line 178
    .local v17, "redirectUrl":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    # getter for: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->context:Landroid/content/Context;
    invoke-static {v2}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$200(Lcom/lge/wifi/impl/aggregation/VZWAggregation;)Landroid/content/Context;

    move-result-object v2

    const-string/jumbo v6, "wifi"

    invoke-virtual {v2, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/net/wifi/WifiManager;

    iput-object v2, v3, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->mWifiManager:Landroid/net/wifi/WifiManager;

    .line 179
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    # getter for: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->context:Landroid/content/Context;
    invoke-static {v2}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$200(Lcom/lge/wifi/impl/aggregation/VZWAggregation;)Landroid/content/Context;

    move-result-object v2

    const-string v6, "phone"

    invoke-virtual {v2, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/telephony/TelephonyManagerEx;

    iput-object v2, v3, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->mTelephonyMgrEx:Landroid/telephony/TelephonyManagerEx;

    .line 184
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "VzW3652987!"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    iget-object v3, v3, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->mTelephonyMgrEx:Landroid/telephony/TelephonyManagerEx;

    invoke-virtual {v3}, Landroid/telephony/TelephonyManagerEx;->getLine1Number()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "@hds.vzw3g.com"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_userName_Value:Ljava/lang/String;

    .line 185
    const-string v2, "WiFiAggregation"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " Parameter : "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_userName_Name:Ljava/lang/String;

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " = ["

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_userName_Value:Ljava/lang/String;

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "]"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 189
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v14

    .line 190
    .local v14, "cal":Ljava/util/Calendar;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "%02d"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    const/4 v8, 0x2

    invoke-virtual {v14, v8}, Ljava/util/Calendar;->get(I)I

    move-result v8

    add-int/lit8 v8, v8, 0x1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v6, v7

    invoke-static {v3, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "%02d"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    const/4 v8, 0x5

    invoke-virtual {v14, v8}, Ljava/util/Calendar;->get(I)I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v6, v7

    invoke-static {v3, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "%04d"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    const/4 v8, 0x1

    invoke-virtual {v14, v8}, Ljava/util/Calendar;->get(I)I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v6, v7

    invoke-static {v3, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    .line 191
    .local v15, "curDate":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    iget-object v2, v2, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->mTelephonyMgrEx:Landroid/telephony/TelephonyManagerEx;

    invoke-virtual {v2}, Landroid/telephony/TelephonyManagerEx;->getLine1Number()Ljava/lang/String;

    move-result-object v13

    .line 192
    .local v13, "MDN":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->getEQIMID()Ljava/lang/String;
    invoke-static {v2}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$300(Lcom/lge/wifi/impl/aggregation/VZWAggregation;)Ljava/lang/String;

    move-result-object v12

    .line 194
    .local v12, "EQIMID":Ljava/lang/String;
    if-eqz v12, :cond_0

    invoke-virtual {v12}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x1

    if-lt v2, v3, :cond_0

    if-eqz v13, :cond_0

    invoke-virtual {v13}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x1

    if-ge v2, v3, :cond_1

    .line 196
    :cond_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "SIM DATA ERROR"

    const/4 v7, 0x0

    const/4 v8, 0x0

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 197
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->isComplete:Z

    .line 351
    :goto_0
    return-void

    .line 201
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    .line 202
    .local v16, "hashInput":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    move-object/from16 v0, v16

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->getHashString(Ljava/lang/String;)Ljava/lang/String;
    invoke-static {v2, v0}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$500(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_password_Value:Ljava/lang/String;

    .line 203
    const-string v2, "WiFiAggregation"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " Parameter : "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_password_Name:Ljava/lang/String;

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " = ["

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_password_Value:Ljava/lang/String;

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "] before hash = ["

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, v16

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "]"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 207
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    iget-object v2, v2, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->mWifiManager:Landroid/net/wifi/WifiManager;

    invoke-virtual {v2}, Landroid/net/wifi/WifiManager;->getWifiState()I

    move-result v2

    const/4 v3, 0x3

    if-eq v2, v3, :cond_2

    .line 209
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "WIFI NETWORK UNAVAILABLE"

    const/4 v7, 0x0

    const/4 v8, 0x0

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 210
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->isComplete:Z

    goto :goto_0

    .line 213
    :cond_2
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    iget-object v2, v2, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->mWifiManager:Landroid/net/wifi/WifiManager;

    invoke-virtual {v2}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v20

    .line 214
    .local v20, "wifiInfo":Landroid/net/wifi/WifiInfo;
    if-eqz v20, :cond_4

    .line 215
    invoke-virtual/range {v20 .. v20}, Landroid/net/wifi/WifiInfo;->getSSID()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_3

    invoke-virtual/range {v20 .. v20}, Landroid/net/wifi/WifiInfo;->getSSID()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x1

    if-lt v2, v3, :cond_3

    invoke-virtual/range {v20 .. v20}, Landroid/net/wifi/WifiInfo;->getMacAddress()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_3

    invoke-virtual/range {v20 .. v20}, Landroid/net/wifi/WifiInfo;->getMacAddress()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const/16 v3, 0xc

    if-ge v2, v3, :cond_5

    .line 218
    :cond_3
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "WIFI NETWORK UNAVAILABLE"

    const/4 v7, 0x0

    const/4 v8, 0x0

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 219
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->isComplete:Z

    goto/16 :goto_0

    .line 224
    :cond_4
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "mWifiManager getConnectionInfo is null"

    const/4 v7, 0x0

    const/4 v8, 0x0

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 225
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->isComplete:Z

    goto/16 :goto_0

    .line 228
    :cond_5
    invoke-virtual/range {v20 .. v20}, Landroid/net/wifi/WifiInfo;->getMacAddress()Ljava/lang/String;

    move-result-object v2

    const-string v3, ":"

    const-string v6, ""

    invoke-virtual {v2, v3, v6}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    move-object/from16 v0, p0

    iput-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_stationId_Value:Ljava/lang/String;

    .line 229
    const-string v2, "WiFiAggregation"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " Parameter : "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_stationId_Name:Ljava/lang/String;

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " = ["

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_stationId_Value:Ljava/lang/String;

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "]"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 235
    const-string v2, "WiFiAggregation"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[Sub Thread] Step1 - connected URL:["

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "]"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 237
    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v1 .. v7}, Lcom/lge/wifi/impl/aggregation/HttpConnectionHelper;->httpRequest(Ljava/lang/String;ILjava/lang/String;[Ljava/lang/String;[Ljava/lang/String;Ljava/util/List;Ljavax/net/ssl/HostnameVerifier;)Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;

    move-result-object v18

    .line 240
    .local v18, "result":Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;
    move-object/from16 v0, v18

    iget v2, v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->resultCode:I

    sget v3, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->RESULT_CODE_NORMAL:I

    if-eq v2, v3, :cond_6

    .line 242
    const-string v2, "WiFiAggregation"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[Sub Thread] Step1 - Can\'t connect URL:["

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "]"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 243
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "CAN\'T CONNET WEB PAGE"

    const/4 v7, 0x0

    const/4 v8, 0x0

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 247
    :cond_6
    const-string v2, "WiFiAggregation"

    move-object/from16 v0, v18

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->responsePage:Ljava/lang/String;

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 249
    move-object/from16 v0, v18

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->responsePage:Ljava/lang/String;

    const-string v4, "<Redirect>"

    const-string v5, "</Redirect>"

    const-string v6, "<LoginURL>"

    const-string v7, "</LoginURL>"

    move-object/from16 v2, p0

    invoke-direct/range {v2 .. v7}, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->getTagContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17

    .line 251
    if-nez v17, :cond_7

    .line 253
    const-string v2, "WiFiAggregation"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[Sub Thread] Step1 - Can\'t connect URL:["

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "]"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 254
    const-string v2, "WiFiAggregation"

    const-string v3, "[Sub Thread] Step1 - May be already logined"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 256
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "SUCCESS"

    const-string v6, " "

    const-string v7, " "

    const-string v8, " "

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 257
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->isComplete:Z

    goto/16 :goto_0

    .line 261
    :cond_7
    move-object/from16 v1, v17

    .line 268
    const-string v2, "https:"

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_8

    .line 270
    const-string v2, "WiFiAggregation"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[Sub Thread] Step2 - Something wrong.. Login informations are sent to URL:["

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "]"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 273
    :cond_8
    const/4 v2, 0x5

    new-array v4, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_deviceType_Name:Ljava/lang/String;

    aput-object v3, v4, v2

    const/4 v2, 0x1

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_deviceModel_Name:Ljava/lang/String;

    aput-object v3, v4, v2

    const/4 v2, 0x2

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_stationId_Name:Ljava/lang/String;

    aput-object v3, v4, v2

    const/4 v2, 0x3

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_userName_Name:Ljava/lang/String;

    aput-object v3, v4, v2

    const/4 v2, 0x4

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_password_Name:Ljava/lang/String;

    aput-object v3, v4, v2

    .line 275
    .local v4, "parameterName":[Ljava/lang/String;
    const/4 v2, 0x5

    new-array v5, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_deviceType_Value:Ljava/lang/String;

    aput-object v3, v5, v2

    const/4 v2, 0x1

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_deviceModel_Value:Ljava/lang/String;

    aput-object v3, v5, v2

    const/4 v2, 0x2

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_stationId_Value:Ljava/lang/String;

    aput-object v3, v5, v2

    const/4 v2, 0x3

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_userName_Value:Ljava/lang/String;

    aput-object v3, v5, v2

    const/4 v2, 0x4

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->param_password_Value:Ljava/lang/String;

    aput-object v3, v5, v2

    .line 279
    .local v5, "parameterValue":[Ljava/lang/String;
    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v1 .. v7}, Lcom/lge/wifi/impl/aggregation/HttpConnectionHelper;->httpRequest(Ljava/lang/String;ILjava/lang/String;[Ljava/lang/String;[Ljava/lang/String;Ljava/util/List;Ljavax/net/ssl/HostnameVerifier;)Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;

    move-result-object v18

    .line 282
    move-object/from16 v0, v18

    iget v2, v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->resultCode:I

    sget v3, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->RESULT_CODE_NORMAL:I

    if-eq v2, v3, :cond_9

    .line 284
    const-string v2, "WiFiAggregation"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[Sub Thread] Step2 - Can\'t connect URL:["

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "]"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 285
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "CAN\'T CONNET WEB PAGE"

    const/4 v7, 0x0

    const/4 v8, 0x0

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 289
    :cond_9
    const-string v2, "WiFiAggregation"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[Sub Thread] Step2 - connected URL:["

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, "]"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 290
    const-string v2, "WiFiAggregation"

    move-object/from16 v0, v18

    iget-object v3, v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->responsePage:Ljava/lang/String;

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 296
    move-object/from16 v0, v18

    iget-object v7, v0, Lcom/lge/wifi/impl/aggregation/HttpConnectionResult;->responsePage:Ljava/lang/String;

    const-string v8, "<AuthenticationReply>"

    const-string v9, "</AuthenticationReply>"

    const-string v10, "<ResponseCode>"

    const-string v11, "</ResponseCode>"

    move-object/from16 v6, p0

    invoke-direct/range {v6 .. v11}, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->getTagContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v19

    .line 299
    .local v19, "resultCode":Ljava/lang/String;
    if-nez v19, :cond_a

    .line 301
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "Invalid Response"

    const-string v7, " "

    const-string v8, " "

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 305
    :cond_a
    invoke-virtual/range {v19 .. v19}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    const-string v3, "50"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 307
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "SUCCESS"

    const-string v6, " "

    const-string v7, " "

    const-string v8, " "

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 308
    const/4 v2, 0x1

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->isComplete:Z

    .line 350
    :goto_1
    const-string v2, "WiFiAggregation"

    const-string v3, "[Sub Thread] Now exit"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 310
    :cond_b
    invoke-virtual/range {v19 .. v19}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    const-string v3, "100"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_c

    .line 313
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "Login failed (Access REJECT)"

    const-string v7, " "

    const-string v8, " "

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 315
    :cond_c
    invoke-virtual/range {v19 .. v19}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    const-string v3, "102"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_d

    .line 318
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "RADIUS server error/timeout"

    const-string v7, " "

    const-string v8, " "

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 320
    :cond_d
    invoke-virtual/range {v19 .. v19}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    const-string v3, "105"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_e

    .line 323
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "Network Administrator Error: Does not have RADIUS enabled"

    const-string v7, " "

    const-string v8, " "

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 325
    :cond_e
    invoke-virtual/range {v19 .. v19}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    const-string v3, "151"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_f

    .line 328
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "Login aborted"

    const-string v7, " "

    const-string v8, " "

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 330
    :cond_f
    invoke-virtual/range {v19 .. v19}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    const-string v3, "200"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_10

    .line 333
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "Proxy detection/repeat operation"

    const-string v7, " "

    const-string v8, " "

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_1

    .line 335
    :cond_10
    invoke-virtual/range {v19 .. v19}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    const-string v3, "201"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_11

    .line 338
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "Authentication pending"

    const-string v7, " "

    const-string v8, " "

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_1

    .line 340
    :cond_11
    invoke-virtual/range {v19 .. v19}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    const-string v3, "255"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_12

    .line 343
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "Access gateway internal error"

    const-string v7, " "

    const-string v8, " "

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_1

    .line 347
    :cond_12
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/lge/wifi/impl/aggregation/VZWAggregation$AggregationSubThread;->this$0:Lcom/lge/wifi/impl/aggregation/VZWAggregation;

    const-string v3, "FAIL"

    const-string v6, "Not defined response code"

    const-string v7, "A-GROUP"

    const-string v8, "SEOUL"

    # invokes: Lcom/lge/wifi/impl/aggregation/VZWAggregation;->sendResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-static {v2, v3, v6, v7, v8}, Lcom/lge/wifi/impl/aggregation/VZWAggregation;->access$400(Lcom/lge/wifi/impl/aggregation/VZWAggregation;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_1
.end method