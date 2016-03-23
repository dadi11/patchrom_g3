.class public Lcom/android/internal/telephony/SecurityManager;
.super Ljava/lang/Object;
.source "SecurityManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;,
        Lcom/android/internal/telephony/SecurityManager$Depersonalization;,
        Lcom/android/internal/telephony/SecurityManager$Personalization;,
        Lcom/android/internal/telephony/SecurityManager$PersonalizationCheck;,
        Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;
    }
.end annotation


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "SecurityManager"

.field private static final SECURITY_PROCESS_COMMAND_ANTI_ROLLBACK:I = 0xb

.field private static final SECURITY_PROCESS_COMMAND_APP_IMGAE_INTEGRITY:I = 0x9

.field private static final SECURITY_PROCESS_COMMAND_AT_COMMAND:I = 0xc

.field private static final SECURITY_PROCESS_COMMAND_BOOT_CODE_INTEGRITY:I = 0x7

.field private static final SECURITY_PROCESS_COMMAND_BOOT_CODE_PROTECTION:I = 0x5

.field private static final SECURITY_PROCESS_COMMAND_CHECK_APP_INTEGRITY:I = 0xa

.field private static final SECURITY_PROCESS_COMMAND_DEBUG_ENABLE:I = 0xe

.field private static final SECURITY_PROCESS_COMMAND_DEPERSONALIZATION:I = 0x2

.field private static final SECURITY_PROCESS_COMMAND_PERSONALIZATION:I = 0x3

.field private static final SECURITY_PROCESS_COMMAND_PERSONALIZATION_CHECK:I = 0x0

.field private static final SECURITY_PROCESS_COMMAND_PERSONALIZATION_INFORMATION:I = 0x1

.field private static final SECURITY_PROCESS_COMMAND_SECURITY_HEADER_INTEGRITY:I = 0x8

.field private static final SECURITY_PROCESS_COMMAND_SENSITIVE_DATA_INTEGRITY:I = 0x6

.field private static final SECURITY_PROCESS_COMMAND_SENSITIVE_DATA_PROTECTION:I = 0x4

.field private static final SECURITY_PROCESS_COMMAND_SW_VERSION:I = 0xd

.field private static final enableVLog:Z = true


# instance fields
.field public info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

.field private final length:B

.field private final mHeaderSize:B

.field public final mNtcodeSize:I

.field private final mOemIdentifier:Ljava/lang/String;

.field public final mTotalNtcodes:I

.field private final tag:B


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x4

    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    const-string v0, "SECURITY"

    iput-object v0, p0, Lcom/android/internal/telephony/SecurityManager;->mOemIdentifier:Ljava/lang/String;

    .line 38
    const/16 v0, 0x8

    iput-byte v0, p0, Lcom/android/internal/telephony/SecurityManager;->mHeaderSize:B

    .line 39
    iput-byte v1, p0, Lcom/android/internal/telephony/SecurityManager;->tag:B

    .line 40
    iput-byte v1, p0, Lcom/android/internal/telephony/SecurityManager;->length:B

    .line 44
    const/16 v0, 0x10

    iput v0, p0, Lcom/android/internal/telephony/SecurityManager;->mNtcodeSize:I

    .line 45
    const/16 v0, 0x281

    iput v0, p0, Lcom/android/internal/telephony/SecurityManager;->mTotalNtcodes:I

    .line 66
    return-void
.end method

.method private SecurityCommandSender(I[B[B)I
    .locals 9
    .param p1, "command"    # I
    .param p2, "request"    # [B
    .param p3, "response"    # [B

    .prologue
    .line 275
    const/4 v5, 0x0

    .line 276
    .local v5, "returnValue":I
    const-string v6, "SecurityCommandSender Start!"

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 279
    :try_start_0
    new-instance v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    invoke-direct {v1}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;-><init>()V

    .line 280
    .local v1, "Thread":Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;
    invoke-virtual {v1}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->start()V

    .line 281
    # invokes: Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->SecurityCommand(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    invoke-static {v1, p1, p2, p3}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->access$200(Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 282
    .local v4, "result":Ljava/lang/Object;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "SecurityCommandSender result = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 284
    if-eqz v4, :cond_2

    .line 285
    check-cast v4, [B

    .end local v4    # "result":Ljava/lang/Object;
    move-object v0, v4

    check-cast v0, [B

    move-object v3, v0

    .line 286
    .local v3, "responseData":[B
    array-length v6, v3

    array-length v7, p3

    if-le v6, v7, :cond_0

    .line 287
    const-string v6, "SecurityManager"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Buffer to copy response too small: Response length is "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    array-length v8, v3

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "bytes. Buffer Size is "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    array-length v8, p3

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "bytes."

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 291
    :cond_0
    const/4 v6, 0x0

    const/4 v7, 0x0

    array-length v8, v3

    invoke-static {v3, v6, p3, v7, v8}, Ljava/lang/System;->arraycopy([BI[BII)V

    .line 292
    array-length v5, v3
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 303
    .end local v1    # "Thread":Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;
    .end local v3    # "responseData":[B
    :cond_1
    :goto_0
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "SecurityCommandSender returnValue = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 304
    const-string v6, "SecurityCommandSender End!"

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 306
    return v5

    .line 295
    .restart local v1    # "Thread":Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;
    .restart local v4    # "result":Ljava/lang/Object;
    :cond_2
    const/4 v5, 0x0

    goto :goto_0

    .line 297
    .end local v1    # "Thread":Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;
    .end local v4    # "result":Ljava/lang/Object;
    :catch_0
    move-exception v2

    .line 298
    .local v2, "e":Ljava/lang/RuntimeException;
    const-string v6, "SecurityManager"

    const-string v7, "SecurityCommandSender: Runtime Exception"

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 299
    sget-object v6, Lcom/android/internal/telephony/CommandException$Error;->GENERIC_FAILURE:Lcom/android/internal/telephony/CommandException$Error;

    invoke-virtual {v6}, Lcom/android/internal/telephony/CommandException$Error;->ordinal()I

    move-result v5

    .line 300
    if-lez v5, :cond_1

    mul-int/lit8 v5, v5, -0x1

    goto :goto_0
.end method

.method private static SecurityManagerLog(Ljava/lang/String;)V
    .locals 1
    .param p0, "logString"    # Ljava/lang/String;

    .prologue
    .line 70
    const-string v0, "SecurityManager"

    invoke-static {v0, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 72
    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
    .line 31
    invoke-static {p0}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public depersonalization(ILjava/lang/String;)I
    .locals 12
    .param p1, "type"    # I
    .param p2, "pin"    # Ljava/lang/String;

    .prologue
    const/4 v11, 0x2

    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 398
    const/16 v6, 0x19

    .line 399
    .local v6, "velueSize":B
    const/4 v5, 0x0

    .line 400
    .local v5, "termChar":B
    const/16 v9, 0x29

    new-array v2, v9, [B

    .line 401
    .local v2, "request":[B
    const/16 v9, 0x800

    new-array v3, v9, [B

    .line 402
    .local v3, "response":[B
    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 403
    .local v1, "reqBuffer":Ljava/nio/ByteBuffer;
    int-to-byte v0, p1

    .line 405
    .local v0, "lock_type":B
    const-string v9, "depersonalization Start!"

    invoke-static {v9}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 407
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "depersonalization: type("

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ")\t pin("

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ")"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 409
    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 412
    const-string v9, "SECURITY"

    invoke-virtual {v9}, Ljava/lang/String;->getBytes()[B

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 415
    invoke-virtual {v1, v11}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 418
    invoke-virtual {v1, v6}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 421
    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 422
    const/16 v9, 0x10

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 423
    invoke-virtual {p2}, Ljava/lang/String;->getBytes()[B

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 424
    invoke-virtual {v1, v5}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 426
    invoke-direct {p0, v11, v2, v3}, Lcom/android/internal/telephony/SecurityManager;->SecurityCommandSender(I[B[B)I

    move-result v4

    .line 428
    .local v4, "result":I
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "depersonalization: response ("

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ")"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 429
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Test_sch : depersonalization End!     response[0] : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    aget-byte v10, v3, v7

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "  ,  result : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 431
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[s9] response[0]="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    aget-byte v10, v3, v7

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ",result="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 432
    aget-byte v9, v3, v7

    if-ne v9, v8, :cond_0

    if-lez v4, :cond_0

    .line 435
    :goto_0
    return v7

    :cond_0
    move v7, v8

    goto :goto_0
.end method

.method public enableRootPermission()I
    .locals 7

    .prologue
    const/16 v6, 0xe

    .line 483
    const/4 v4, 0x0

    .line 484
    .local v4, "termChar":B
    const/16 v5, 0x10

    new-array v1, v5, [B

    .line 485
    .local v1, "request":[B
    const/16 v5, 0x800

    new-array v2, v5, [B

    .line 486
    .local v2, "response":[B
    invoke-static {v1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 488
    .local v0, "reqBuffer":Ljava/nio/ByteBuffer;
    const-string v5, "enableRootPermission --- "

    invoke-static {v5}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 490
    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 493
    const-string v5, "SECURITY"

    invoke-virtual {v5}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 496
    invoke-virtual {v0, v6}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 498
    const/4 v5, 0x1

    invoke-virtual {v0, v5}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 501
    invoke-direct {p0, v6, v1, v2}, Lcom/android/internal/telephony/SecurityManager;->SecurityCommandSender(I[B[B)I

    move-result v3

    .line 503
    .local v3, "result":I
    const/4 v5, 0x0

    aget-byte v5, v2, v5

    return v5
.end method

.method public getSIMLockLeftCntWithIndex(I)B
    .locals 3
    .param p1, "type"    # I

    .prologue
    .line 541
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getSIMLockLeftCntWithIndex Start!, type = ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 542
    packed-switch p1, :pswitch_data_0

    .line 557
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .line 561
    .local v0, "curSimLockLeftCnt":B
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getSIMLockLeftCntWithIndex!, curSimLockLeftCnt = ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 562
    const-string v1, "getSIMLockLeftCntWithIndex End!"

    invoke-static {v1}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 564
    return v0

    .line 545
    .end local v0    # "curSimLockLeftCnt":B
    :pswitch_0
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .line 546
    .restart local v0    # "curSimLockLeftCnt":B
    goto :goto_0

    .line 548
    .end local v0    # "curSimLockLeftCnt":B
    :pswitch_1
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .line 549
    .restart local v0    # "curSimLockLeftCnt":B
    goto :goto_0

    .line 551
    .end local v0    # "curSimLockLeftCnt":B
    :pswitch_2
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .line 552
    .restart local v0    # "curSimLockLeftCnt":B
    goto :goto_0

    .line 554
    .end local v0    # "curSimLockLeftCnt":B
    :pswitch_3
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .line 555
    .restart local v0    # "curSimLockLeftCnt":B
    goto :goto_0

    .line 542
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public getSIMLockRetryCntMaxWithIndex(I)B
    .locals 3
    .param p1, "type"    # I

    .prologue
    .line 570
    packed-switch p1, :pswitch_data_0

    .line 585
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .line 589
    .local v0, "curSimLockRetryCntMax":B
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getSIMLockRetryCntMaxWithIndex!, curSimLockRetryCntMax = ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 590
    const-string v1, "getSIMLockRetryCntMaxWithIndex End!"

    invoke-static {v1}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 592
    return v0

    .line 573
    .end local v0    # "curSimLockRetryCntMax":B
    :pswitch_0
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .line 574
    .restart local v0    # "curSimLockRetryCntMax":B
    goto :goto_0

    .line 576
    .end local v0    # "curSimLockRetryCntMax":B
    :pswitch_1
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .line 577
    .restart local v0    # "curSimLockRetryCntMax":B
    goto :goto_0

    .line 579
    .end local v0    # "curSimLockRetryCntMax":B
    :pswitch_2
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .line 580
    .restart local v0    # "curSimLockRetryCntMax":B
    goto :goto_0

    .line 582
    .end local v0    # "curSimLockRetryCntMax":B
    :pswitch_3
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .line 583
    .restart local v0    # "curSimLockRetryCntMax":B
    goto :goto_0

    .line 570
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public getSIMLockflagWithIndex(I)I
    .locals 3
    .param p1, "type"    # I

    .prologue
    .line 512
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getSIMLockflagWithIndex Start!, type = ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 513
    packed-switch p1, :pswitch_data_0

    .line 528
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .line 532
    .local v0, "curSimLockflag":I
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getSIMLockflagWithIndex!, curSimLockflag = ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 533
    const-string v1, "getSIMLockflagWithIndex End!"

    invoke-static {v1}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 535
    return v0

    .line 516
    .end local v0    # "curSimLockflag":I
    :pswitch_0
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .line 517
    .restart local v0    # "curSimLockflag":I
    goto :goto_0

    .line 519
    .end local v0    # "curSimLockflag":I
    :pswitch_1
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .line 520
    .restart local v0    # "curSimLockflag":I
    goto :goto_0

    .line 522
    .end local v0    # "curSimLockflag":I
    :pswitch_2
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .line 523
    .restart local v0    # "curSimLockflag":I
    goto :goto_0

    .line 525
    .end local v0    # "curSimLockflag":I
    :pswitch_3
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .line 526
    .restart local v0    # "curSimLockflag":I
    goto :goto_0

    .line 513
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public personalization(ILjava/lang/String;)I
    .locals 12
    .param p1, "type"    # I
    .param p2, "pin"    # Ljava/lang/String;

    .prologue
    const/4 v11, 0x3

    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 441
    const/16 v6, 0x19

    .line 442
    .local v6, "velueSize":B
    const/4 v5, 0x0

    .line 443
    .local v5, "termChar":B
    const/16 v9, 0x29

    new-array v2, v9, [B

    .line 444
    .local v2, "request":[B
    const/16 v9, 0x800

    new-array v3, v9, [B

    .line 445
    .local v3, "response":[B
    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 446
    .local v1, "reqBuffer":Ljava/nio/ByteBuffer;
    int-to-byte v0, p1

    .line 448
    .local v0, "lock_type":B
    const-string v9, "personalization Start!"

    invoke-static {v9}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 449
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "personalization: type("

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ")\t pin("

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ")"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 451
    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 454
    const-string v9, "SECURITY"

    invoke-virtual {v9}, Ljava/lang/String;->getBytes()[B

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 457
    invoke-virtual {v1, v11}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 460
    invoke-virtual {v1, v6}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 463
    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 464
    const/16 v9, 0x10

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 465
    invoke-virtual {p2}, Ljava/lang/String;->getBytes()[B

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 466
    invoke-virtual {v1, v5}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 468
    invoke-direct {p0, v11, v2, v3}, Lcom/android/internal/telephony/SecurityManager;->SecurityCommandSender(I[B[B)I

    move-result v4

    .line 470
    .local v4, "result":I
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "personalization: response ("

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ")"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 471
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Test_sch : personalization End!     response[0] : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    aget-byte v10, v3, v7

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "  ,  result : "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 473
    aget-byte v9, v3, v7

    if-ne v9, v8, :cond_0

    if-lez v4, :cond_0

    .line 476
    :goto_0
    return v7

    :cond_0
    move v7, v8

    goto :goto_0
.end method

.method public simlockinformation()I
    .locals 10

    .prologue
    const/4 v5, 0x0

    const/4 v6, 0x1

    .line 311
    const/4 v4, 0x0

    .line 312
    .local v4, "velueSize":B
    const/16 v7, 0x10

    new-array v1, v7, [B

    .line 313
    .local v1, "request":[B
    const/16 v7, 0x800

    new-array v2, v7, [B

    .line 317
    .local v2, "response":[B
    const-string v7, "simlockinformation Start!"

    invoke-static {v7}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 319
    new-instance v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    invoke-direct {v7, p0}, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;-><init>(Lcom/android/internal/telephony/SecurityManager;)V

    iput-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    .line 321
    invoke-static {v1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 322
    .local v0, "reqBuffer":Ljava/nio/ByteBuffer;
    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 325
    const-string v7, "SECURITY"

    invoke-virtual {v7}, Ljava/lang/String;->getBytes()[B

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 328
    invoke-virtual {v0, v6}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 331
    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 333
    invoke-direct {p0, v6, v1, v2}, Lcom/android/internal/telephony/SecurityManager;->SecurityCommandSender(I[B[B)I

    move-result v3

    .line 334
    .local v3, "result":I
    const-string v7, "SecurityManager"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "simlockinformation result: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 335
    const-string v7, "SecurityManager"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "simlockinformation response: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 337
    if-lez v3, :cond_0

    .line 339
    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    aget-byte v8, v2, v5

    iput-byte v8, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .line 340
    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    aget-byte v6, v2, v6

    iput v6, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .line 341
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x2

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .line 343
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x3

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .line 344
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x4

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .line 345
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x5

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .line 348
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x6

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .line 349
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x7

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .line 350
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0x8

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .line 353
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0x9

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .line 354
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0xa

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .line 355
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0xb

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .line 357
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0xc

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .line 358
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0xd

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .line 359
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0xe

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .line 362
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    const/16 v7, 0xf

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->country:I

    .line 363
    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    const/16 v7, 0x13

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->operator:I

    .line 365
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "network flag: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "  network attemptsLeft: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "  network retry_count_max: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 369
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "networksubset flag: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "  networksubset attemptsLeft: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "  networksubset retry_count_max: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 373
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "serviceprovider flag: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "  serviceprovider attemptsLeft: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "  serviceprovider retry_count_max: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 377
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "corporate flag: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "  corporate attemptsLeft: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "  corporate retry_count_max: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 381
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "sim flag: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "  sim attemptsLeft: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "  sim retry_count_max: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 385
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "country: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->country:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 386
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "operator: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->operator:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 388
    const-string v6, "simlockinformation End!"

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    .line 393
    :goto_0
    return v5

    :cond_0
    move v5, v6

    goto :goto_0
.end method
