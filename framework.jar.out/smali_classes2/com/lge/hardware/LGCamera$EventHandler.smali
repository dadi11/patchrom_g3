.class Lcom/lge/hardware/LGCamera$EventHandler;
.super Landroid/os/Handler;
.source "LGCamera.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/hardware/LGCamera;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "EventHandler"
.end annotation


# instance fields
.field private mLGCamera:Lcom/lge/hardware/LGCamera;

.field final synthetic this$0:Lcom/lge/hardware/LGCamera;


# direct methods
.method public constructor <init>(Lcom/lge/hardware/LGCamera;Lcom/lge/hardware/LGCamera;Landroid/os/Looper;)V
    .locals 0
    .param p2, "c"    # Lcom/lge/hardware/LGCamera;
    .param p3, "looper"    # Landroid/os/Looper;

    .prologue
    .line 805
    iput-object p1, p0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    .line 806
    invoke-direct {p0, p3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 807
    iput-object p2, p0, Lcom/lge/hardware/LGCamera$EventHandler;->mLGCamera:Lcom/lge/hardware/LGCamera;

    .line 808
    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 17
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 812
    move-object/from16 v0, p1

    iget v14, v0, Landroid/os/Message;->what:I

    sparse-switch v14, :sswitch_data_0

    .line 912
    const-string v14, "LGCamera"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v16, "Unknown message type "

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->what:I

    move/from16 v16, v0

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-static {v14, v15}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 913
    :cond_0
    :goto_0
    return-void

    .line 815
    :sswitch_0
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCameraDataCallback:Lcom/lge/hardware/LGCamera$CameraDataCallback;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$200(Lcom/lge/hardware/LGCamera;)Lcom/lge/hardware/LGCamera$CameraDataCallback;

    move-result-object v14

    if-eqz v14, :cond_0

    .line 818
    const/4 v14, 0x5

    new-array v9, v14, [S

    .line 819
    .local v9, "obt_data":[S
    move-object/from16 v0, p1

    iget-object v14, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v14, [B

    move-object v2, v14

    check-cast v2, [B

    .line 827
    .local v2, "byteData":[B
    const/4 v14, 0x0

    const/4 v15, 0x1

    aget-byte v15, v2, v15

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x8

    const/16 v16, 0x0

    aget-byte v16, v2, v16

    move/from16 v0, v16

    and-int/lit16 v0, v0, 0xff

    move/from16 v16, v0

    or-int v15, v15, v16

    int-to-short v15, v15

    aput-short v15, v9, v14

    .line 828
    const/4 v14, 0x1

    const/4 v15, 0x3

    aget-byte v15, v2, v15

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x8

    const/16 v16, 0x2

    aget-byte v16, v2, v16

    move/from16 v0, v16

    and-int/lit16 v0, v0, 0xff

    move/from16 v16, v0

    or-int v15, v15, v16

    int-to-short v15, v15

    aput-short v15, v9, v14

    .line 829
    const/4 v14, 0x2

    const/4 v15, 0x5

    aget-byte v15, v2, v15

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x8

    const/16 v16, 0x4

    aget-byte v16, v2, v16

    move/from16 v0, v16

    and-int/lit16 v0, v0, 0xff

    move/from16 v16, v0

    or-int v15, v15, v16

    int-to-short v15, v15

    aput-short v15, v9, v14

    .line 830
    const/4 v14, 0x3

    const/4 v15, 0x7

    aget-byte v15, v2, v15

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x8

    const/16 v16, 0x6

    aget-byte v16, v2, v16

    move/from16 v0, v16

    and-int/lit16 v0, v0, 0xff

    move/from16 v16, v0

    or-int v15, v15, v16

    int-to-short v15, v15

    aput-short v15, v9, v14

    .line 831
    const/4 v14, 0x4

    const/16 v15, 0x9

    aget-byte v15, v2, v15

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x8

    const/16 v16, 0x8

    aget-byte v16, v2, v16

    move/from16 v0, v16

    and-int/lit16 v0, v0, 0xff

    move/from16 v16, v0

    or-int v15, v15, v16

    int-to-short v15, v15

    aput-short v15, v9, v14

    .line 833
    const/4 v14, 0x5

    new-array v10, v14, [I

    .line 834
    .local v10, "obt_data_i":[I
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_1
    const/4 v14, 0x5

    if-ge v8, v14, :cond_1

    .line 835
    aget-short v14, v9, v8

    aput v14, v10, v8

    .line 834
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 839
    :cond_1
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCameraDataCallback:Lcom/lge/hardware/LGCamera$CameraDataCallback;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$200(Lcom/lge/hardware/LGCamera;)Lcom/lge/hardware/LGCamera$CameraDataCallback;

    move-result-object v14

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {v15}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v15

    invoke-interface {v14, v10, v15}, Lcom/lge/hardware/LGCamera$CameraDataCallback;->onCameraData([ILandroid/hardware/Camera;)V

    goto/16 :goto_0

    .line 845
    .end local v2    # "byteData":[B
    .end local v8    # "i":I
    .end local v9    # "obt_data":[S
    .end local v10    # "obt_data_i":[I
    :sswitch_1
    const/16 v14, 0x101

    new-array v13, v14, [I

    .line 846
    .local v13, "statsdata":[I
    const/4 v8, 0x0

    .restart local v8    # "i":I
    :goto_2
    const/16 v14, 0x101

    if-ge v8, v14, :cond_2

    .line 847
    move-object/from16 v0, p1

    iget-object v14, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v14, [B

    check-cast v14, [B

    mul-int/lit8 v15, v8, 0x4

    # invokes: Lcom/lge/hardware/LGCamera;->byteToInt([BI)I
    invoke-static {v14, v15}, Lcom/lge/hardware/LGCamera;->access$300([BI)I

    move-result v14

    aput v14, v13, v8

    .line 846
    add-int/lit8 v8, v8, 0x1

    goto :goto_2

    .line 849
    :cond_2
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCameraDataCallback:Lcom/lge/hardware/LGCamera$CameraDataCallback;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$200(Lcom/lge/hardware/LGCamera;)Lcom/lge/hardware/LGCamera$CameraDataCallback;

    move-result-object v14

    if-eqz v14, :cond_0

    .line 850
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCameraDataCallback:Lcom/lge/hardware/LGCamera$CameraDataCallback;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$200(Lcom/lge/hardware/LGCamera;)Lcom/lge/hardware/LGCamera$CameraDataCallback;

    move-result-object v14

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {v15}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v15

    invoke-interface {v14, v13, v15}, Lcom/lge/hardware/LGCamera$CameraDataCallback;->onCameraData([ILandroid/hardware/Camera;)V

    goto/16 :goto_0

    .line 856
    .end local v8    # "i":I
    .end local v13    # "statsdata":[I
    :sswitch_2
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mProxyDataListener:Lcom/lge/hardware/LGCamera$ProxyDataListener;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$400(Lcom/lge/hardware/LGCamera;)Lcom/lge/hardware/LGCamera$ProxyDataListener;

    move-result-object v14

    if-eqz v14, :cond_0

    .line 857
    new-instance v5, Lcom/lge/hardware/LGCamera$ProxyData;

    invoke-direct {v5}, Lcom/lge/hardware/LGCamera$ProxyData;-><init>()V

    .line 858
    .local v5, "data":Lcom/lge/hardware/LGCamera$ProxyData;
    move-object/from16 v0, p1

    iget-object v14, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v14, [B

    move-object v2, v14

    check-cast v2, [B

    .line 859
    .restart local v2    # "byteData":[B
    const/4 v11, 0x0

    .line 860
    .local v11, "ptr":I
    if-eqz v2, :cond_3

    .line 862
    add-int/lit8 v12, v11, 0x1

    .end local v11    # "ptr":I
    .local v12, "ptr":I
    aget-byte v14, v2, v11

    and-int/lit16 v14, v14, 0xff

    add-int/lit8 v11, v12, 0x1

    .end local v12    # "ptr":I
    .restart local v11    # "ptr":I
    aget-byte v15, v2, v12

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x8

    or-int/2addr v14, v15

    add-int/lit8 v12, v11, 0x1

    .end local v11    # "ptr":I
    .restart local v12    # "ptr":I
    aget-byte v15, v2, v11

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x10

    or-int/2addr v14, v15

    add-int/lit8 v11, v12, 0x1

    .end local v12    # "ptr":I
    .restart local v11    # "ptr":I
    aget-byte v15, v2, v12

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x18

    or-int/2addr v14, v15

    iput v14, v5, Lcom/lge/hardware/LGCamera$ProxyData;->val:I

    .line 864
    add-int/lit8 v12, v11, 0x1

    .end local v11    # "ptr":I
    .restart local v12    # "ptr":I
    aget-byte v14, v2, v11

    and-int/lit16 v14, v14, 0xff

    add-int/lit8 v11, v12, 0x1

    .end local v12    # "ptr":I
    .restart local v11    # "ptr":I
    aget-byte v15, v2, v12

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x8

    or-int/2addr v14, v15

    add-int/lit8 v12, v11, 0x1

    .end local v11    # "ptr":I
    .restart local v12    # "ptr":I
    aget-byte v15, v2, v11

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x10

    or-int/2addr v14, v15

    add-int/lit8 v11, v12, 0x1

    .end local v12    # "ptr":I
    .restart local v11    # "ptr":I
    aget-byte v15, v2, v12

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x18

    or-int/2addr v14, v15

    iput v14, v5, Lcom/lge/hardware/LGCamera$ProxyData;->conv:I

    .line 866
    add-int/lit8 v12, v11, 0x1

    .end local v11    # "ptr":I
    .restart local v12    # "ptr":I
    aget-byte v14, v2, v11

    and-int/lit16 v14, v14, 0xff

    add-int/lit8 v11, v12, 0x1

    .end local v12    # "ptr":I
    .restart local v11    # "ptr":I
    aget-byte v15, v2, v12

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x8

    or-int/2addr v14, v15

    add-int/lit8 v12, v11, 0x1

    .end local v11    # "ptr":I
    .restart local v12    # "ptr":I
    aget-byte v15, v2, v11

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x10

    or-int/2addr v14, v15

    add-int/lit8 v11, v12, 0x1

    .end local v12    # "ptr":I
    .restart local v11    # "ptr":I
    aget-byte v15, v2, v12

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x18

    or-int/2addr v14, v15

    iput v14, v5, Lcom/lge/hardware/LGCamera$ProxyData;->sig:I

    .line 868
    add-int/lit8 v12, v11, 0x1

    .end local v11    # "ptr":I
    .restart local v12    # "ptr":I
    aget-byte v14, v2, v11

    and-int/lit16 v14, v14, 0xff

    add-int/lit8 v11, v12, 0x1

    .end local v12    # "ptr":I
    .restart local v11    # "ptr":I
    aget-byte v15, v2, v12

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x8

    or-int/2addr v14, v15

    add-int/lit8 v12, v11, 0x1

    .end local v11    # "ptr":I
    .restart local v12    # "ptr":I
    aget-byte v15, v2, v11

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x10

    or-int/2addr v14, v15

    add-int/lit8 v11, v12, 0x1

    .end local v12    # "ptr":I
    .restart local v11    # "ptr":I
    aget-byte v15, v2, v12

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x18

    or-int/2addr v14, v15

    iput v14, v5, Lcom/lge/hardware/LGCamera$ProxyData;->amb:I

    .line 870
    add-int/lit8 v12, v11, 0x1

    .end local v11    # "ptr":I
    .restart local v12    # "ptr":I
    aget-byte v14, v2, v11

    and-int/lit16 v14, v14, 0xff

    add-int/lit8 v11, v12, 0x1

    .end local v12    # "ptr":I
    .restart local v11    # "ptr":I
    aget-byte v15, v2, v12

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x8

    or-int/2addr v14, v15

    add-int/lit8 v12, v11, 0x1

    .end local v11    # "ptr":I
    .restart local v12    # "ptr":I
    aget-byte v15, v2, v11

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x10

    or-int/2addr v14, v15

    add-int/lit8 v11, v12, 0x1

    .end local v12    # "ptr":I
    .restart local v11    # "ptr":I
    aget-byte v15, v2, v12

    and-int/lit16 v15, v15, 0xff

    shl-int/lit8 v15, v15, 0x18

    or-int/2addr v14, v15

    iput v14, v5, Lcom/lge/hardware/LGCamera$ProxyData;->raw:I

    .line 876
    :goto_3
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mProxyDataListener:Lcom/lge/hardware/LGCamera$ProxyDataListener;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$400(Lcom/lge/hardware/LGCamera;)Lcom/lge/hardware/LGCamera$ProxyDataListener;

    move-result-object v14

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {v15}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v15

    invoke-interface {v14, v5, v15}, Lcom/lge/hardware/LGCamera$ProxyDataListener;->onDataListen(Lcom/lge/hardware/LGCamera$ProxyData;Landroid/hardware/Camera;)V

    goto/16 :goto_0

    .line 874
    :cond_3
    const/4 v14, -0x1

    iput v14, v5, Lcom/lge/hardware/LGCamera$ProxyData;->val:I

    goto :goto_3

    .line 884
    .end local v2    # "byteData":[B
    .end local v5    # "data":Lcom/lge/hardware/LGCamera$ProxyData;
    .end local v11    # "ptr":I
    :sswitch_3
    move-object/from16 v0, p1

    iget-object v14, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v14, [B

    move-object v1, v14

    check-cast v1, [B

    .line 885
    .local v1, "buf":[B
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mEnabledMetaData:I
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$500(Lcom/lge/hardware/LGCamera;)I

    move-result v14

    if-lez v14, :cond_0

    if-eqz v1, :cond_0

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v14

    if-eqz v14, :cond_0

    .line 886
    const/4 v14, 0x1

    new-array v7, v14, [B

    .line 887
    .local v7, "hdr_data":[B
    const/4 v14, 0x1

    new-array v6, v14, [B

    .line 889
    .local v6, "flash_data":[B
    const/4 v14, 0x0

    const/4 v15, 0x4

    aget-byte v15, v1, v15

    aput-byte v15, v7, v14

    .line 890
    const/4 v14, 0x0

    const/16 v15, 0x8

    aget-byte v15, v1, v15

    aput-byte v15, v6, v14

    .line 893
    const/4 v3, 0x0

    .line 894
    .local v3, "cb1":Lcom/lge/hardware/LGCamera$CameraMetaDataCallback;
    const/4 v4, 0x0

    .line 895
    .local v4, "cb2":Lcom/lge/hardware/LGCamera$CameraMetaDataCallback;
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mMetaDataCallbackLock:Ljava/lang/Object;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$600(Lcom/lge/hardware/LGCamera;)Ljava/lang/Object;

    move-result-object v15

    monitor-enter v15

    .line 896
    :try_start_0
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mHdrMetaDataCallback:Lcom/lge/hardware/LGCamera$CameraMetaDataCallback;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$700(Lcom/lge/hardware/LGCamera;)Lcom/lge/hardware/LGCamera$CameraMetaDataCallback;

    move-result-object v3

    .line 897
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mFlashMetaDataCallback:Lcom/lge/hardware/LGCamera$CameraMetaDataCallback;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$800(Lcom/lge/hardware/LGCamera;)Lcom/lge/hardware/LGCamera$CameraMetaDataCallback;

    move-result-object v4

    .line 898
    monitor-exit v15
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 901
    const/4 v14, 0x0

    aget-byte v14, v1, v14

    and-int/lit8 v14, v14, 0x1

    if-eqz v14, :cond_4

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mEnabledMetaData:I
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$500(Lcom/lge/hardware/LGCamera;)I

    move-result v14

    and-int/lit8 v14, v14, 0x1

    if-eqz v14, :cond_4

    if-eqz v3, :cond_4

    .line 902
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v14

    invoke-interface {v3, v7, v14}, Lcom/lge/hardware/LGCamera$CameraMetaDataCallback;->onCameraMetaData([BLandroid/hardware/Camera;)V

    .line 905
    :cond_4
    const/4 v14, 0x0

    aget-byte v14, v1, v14

    and-int/lit8 v14, v14, 0x2

    if-eqz v14, :cond_0

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mEnabledMetaData:I
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$500(Lcom/lge/hardware/LGCamera;)I

    move-result v14

    and-int/lit8 v14, v14, 0x2

    if-eqz v14, :cond_0

    if-eqz v4, :cond_0

    .line 906
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/lge/hardware/LGCamera$EventHandler;->this$0:Lcom/lge/hardware/LGCamera;

    # getter for: Lcom/lge/hardware/LGCamera;->mCamera:Landroid/hardware/Camera;
    invoke-static {v14}, Lcom/lge/hardware/LGCamera;->access$000(Lcom/lge/hardware/LGCamera;)Landroid/hardware/Camera;

    move-result-object v14

    invoke-interface {v4, v6, v14}, Lcom/lge/hardware/LGCamera$CameraMetaDataCallback;->onCameraMetaData([BLandroid/hardware/Camera;)V

    goto/16 :goto_0

    .line 898
    :catchall_0
    move-exception v14

    :try_start_1
    monitor-exit v15
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v14

    .line 812
    :sswitch_data_0
    .sparse-switch
        0x1000 -> :sswitch_1
        0x2000 -> :sswitch_3
        0x5000 -> :sswitch_0
        0x8000 -> :sswitch_2
    .end sparse-switch
.end method
