.class Lcom/android/server/ePDGDualTypeConn$DcDefaultState;
.super Lcom/android/internal/util/State;
.source "ePDGDualTypeConn.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/ePDGDualTypeConn;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DcDefaultState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/ePDGDualTypeConn;


# direct methods
.method private constructor <init>(Lcom/android/server/ePDGDualTypeConn;)V
    .locals 0

    .prologue
    .line 2193
    iput-object p1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p2, "x1"    # Lcom/android/server/ePDGDualTypeConn$1;

    .prologue
    .line 2193
    invoke-direct {p0, p1}, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;-><init>(Lcom/android/server/ePDGDualTypeConn;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 2

    .prologue
    .line 2197
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "Defatult state enter"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2199
    return-void
.end method

.method public exit()V
    .locals 2

    .prologue
    .line 2204
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "Defatult state exit"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2207
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 7
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v6, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x1

    .line 2212
    iget v1, p1, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_0

    .line 2396
    :pswitch_0
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcDefaultState: shouldn\'t happen but ignore msg.what=0x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-static {v3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2402
    :goto_0
    return v5

    .line 2216
    :pswitch_1
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcDefaultState state : EVENT_ROAM_IMFO, we block tech if value is 1 : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2217
    iget v1, p1, Landroid/os/Message;->arg1:I

    if-ne v1, v5, :cond_0

    .line 2219
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v5, v1, Lcom/android/server/ePDGDualTypeConn;->isRoaming:Z

    .line 2220
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, v1, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v1, v5, v6}, Lcom/android/server/ePDGFixedInfo;->setBlockinfo(II)V

    .line 2227
    :goto_1
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto :goto_0

    .line 2224
    :cond_0
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v4, v1, Lcom/android/server/ePDGDualTypeConn;->isRoaming:Z

    .line 2225
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, v1, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v1, v5, v6}, Lcom/android/server/ePDGFixedInfo;->releaseBlockinfo(II)V

    goto :goto_1

    .line 2232
    :pswitch_2
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcDefaultState state : EVENT_WFC_PREFER_CH "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2233
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v2, p1, Landroid/os/Message;->arg1:I

    iput v2, v1, Lcom/android/server/ePDGDualTypeConn;->WFCPrefer:I

    .line 2234
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto :goto_0

    .line 2238
    :pswitch_3
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcDefaultState state : EVENT_CALLSTATUS_CH "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2239
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v2, p1, Landroid/os/Message;->arg1:I

    iput v2, v1, Lcom/android/server/ePDGDualTypeConn;->CallState:I

    goto/16 :goto_0

    .line 2244
    :pswitch_4
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcDefaultState state : EVENT_WFCSETTING_CH "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2245
    iget v1, p1, Landroid/os/Message;->arg1:I

    if-eq v1, v5, :cond_1

    .line 2247
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v4, v1, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    .line 2254
    :goto_2
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto/16 :goto_0

    .line 2251
    :cond_1
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v5, v1, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    goto :goto_2

    .line 2258
    :pswitch_5
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcDefaultState state : just set network state"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " tech"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg2:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2259
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v2, v2, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget v3, p1, Landroid/os/Message;->arg1:I

    iget v4, p1, Landroid/os/Message;->arg2:I

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/server/ePDGDualTypeConn;->onNetworkupdate(ZII)Z

    .line 2260
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto/16 :goto_0

    .line 2264
    :pswitch_6
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState state : we get EVENT_WIFI_CONNECT_DETAIL!!"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2265
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v5, v1, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    .line 2268
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v2, p1, Landroid/os/Message;->arg1:I

    iput v2, v1, Lcom/android/server/ePDGDualTypeConn;->wifiDetailedState:I

    .line 2269
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->checkwifidetailstatus()V

    .line 2270
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto/16 :goto_0

    .line 2274
    :pswitch_7
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState: msg.what=EVENT_WIFI_DISCONNECT"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2275
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, v1, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v1}, Lcom/android/server/ePDGFixedInfo;->resetePDGBlock()V

    .line 2276
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v4, v1, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    .line 2277
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto/16 :goto_0

    .line 2281
    :pswitch_8
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState: EVENT_PCSCF_CH?!! What happen??!"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 2287
    :pswitch_9
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState: EVENT_USER_DISCONNECT?!! What happen??!"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2289
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v4, v1, Lcom/android/server/ePDGDualTypeConn;->isDCwaiting:Z

    goto/16 :goto_0

    .line 2296
    :pswitch_a
    iget v0, p1, Landroid/os/Message;->arg1:I

    .line 2297
    .local v0, "tech":I
    if-ne v0, v5, :cond_2

    .line 2299
    const/4 v0, 0x2

    .line 2301
    :cond_2
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcDefaultState: EVENT_PDN_PRI_CH , "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2302
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/android/server/ePDGDualTypeConn;->setePDGsetprefTest(Ljava/lang/String;I)V

    goto/16 :goto_0

    .line 2306
    .end local v0    # "tech":I
    :pswitch_b
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState: EVENT_APN_CHANGED, ignore!! "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 2310
    :pswitch_c
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState: EVENT_APN_DISCONNECT_NOW, ignore!! "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 2314
    :pswitch_d
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState: EVENT_DELAYED_DISCONNECT, ignore!! "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 2318
    :pswitch_e
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState: EVENT_RADIO_OFF, ignore!! "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 2323
    :pswitch_f
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState : EVENT_EPDG_TIME, ignore!! "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 2337
    :pswitch_10
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcDefaultState: EVENT_LTEREGI_FAIL detail=,!! "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2339
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, v1, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v1, v5, v5}, Lcom/android/server/ePDGFixedInfo;->setBlockinfo(II)V

    .line 2340
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto/16 :goto_0

    .line 2345
    :pswitch_11
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcePDGConnectedState: EVENT_ePDGREGI_FAIL detail=,!! "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2346
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, v1, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v1, v4, v5}, Lcom/android/server/ePDGFixedInfo;->setBlockinfo(II)V

    .line 2347
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto/16 :goto_0

    .line 2352
    :pswitch_12
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState: EVENT_ePDGRTP_FAIL so tech will be fixed to LTE "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2353
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, v1, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    const/4 v2, 0x4

    invoke-virtual {v1, v4, v2}, Lcom/android/server/ePDGFixedInfo;->setBlockinfo(II)V

    .line 2354
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const/16 v2, 0x8

    const/16 v3, 0x1390

    invoke-virtual {v1, v2, v3}, Lcom/android/server/ePDGDualTypeConn;->notifyePDGCompleted(II)V

    .line 2355
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto/16 :goto_0

    .line 2359
    :pswitch_13
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState  : EVENT_SET_INIT_VALUE "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 2364
    :pswitch_14
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState  : EVENT_DELAYED_TEMP_COMPLETE "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2365
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v4, v1, Lcom/android/server/ePDGDualTypeConn;->isChangingRAT:Z

    goto/16 :goto_0

    .line 2369
    :pswitch_15
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState, EVENT_UNKNOWN_TECH"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 2373
    :pswitch_16
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcDefaultState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcDefaultState get EPDG req, so what?"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 2212
    :pswitch_data_0
    .packed-switch 0x40001
        :pswitch_7
        :pswitch_16
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_9
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_8
        :pswitch_0
        :pswitch_a
        :pswitch_5
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_11
        :pswitch_10
        :pswitch_12
        :pswitch_0
        :pswitch_b
        :pswitch_d
        :pswitch_c
        :pswitch_e
        :pswitch_f
        :pswitch_13
        :pswitch_14
        :pswitch_15
        :pswitch_1
        :pswitch_6
    .end packed-switch
.end method