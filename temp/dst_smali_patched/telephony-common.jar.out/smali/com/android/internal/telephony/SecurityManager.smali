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

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "SECURITY"

    iput-object v0, p0, Lcom/android/internal/telephony/SecurityManager;->mOemIdentifier:Ljava/lang/String;

    const/16 v0, 0x8

    iput-byte v0, p0, Lcom/android/internal/telephony/SecurityManager;->mHeaderSize:B

    iput-byte v1, p0, Lcom/android/internal/telephony/SecurityManager;->tag:B

    iput-byte v1, p0, Lcom/android/internal/telephony/SecurityManager;->length:B

    const/16 v0, 0x10

    iput v0, p0, Lcom/android/internal/telephony/SecurityManager;->mNtcodeSize:I

    const/16 v0, 0x281

    iput v0, p0, Lcom/android/internal/telephony/SecurityManager;->mTotalNtcodes:I

    return-void
.end method

.method private SecurityCommandSender(I[B[B)I
    .locals 9
    .param p1, "command"    # I
    .param p2, "request"    # [B
    .param p3, "response"    # [B

    .prologue
    const/4 v5, 0x0

    .local v5, "returnValue":I
    const-string v6, "SecurityCommandSender Start!"

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    :try_start_0
    new-instance v1, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;

    invoke-direct {v1}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;-><init>()V

    .local v1, "Thread":Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;
    invoke-virtual {v1}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->start()V

    # invokes: Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->SecurityCommand(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    invoke-static {v1, p1, p2, p3}, Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;->access$200(Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

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

    if-eqz v4, :cond_2

    check-cast v4, [B

    .end local v4    # "result":Ljava/lang/Object;
    move-object v0, v4

    check-cast v0, [B

    move-object v3, v0

    .local v3, "responseData":[B
    array-length v6, v3

    array-length v7, p3

    if-le v6, v7, :cond_0

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

    :cond_0
    const/4 v6, 0x0

    const/4 v7, 0x0

    array-length v8, v3

    invoke-static {v3, v6, p3, v7, v8}, Ljava/lang/System;->arraycopy([BI[BII)V

    array-length v5, v3
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

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

    const-string v6, "SecurityCommandSender End!"

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    return v5

    .restart local v1    # "Thread":Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;
    .restart local v4    # "result":Ljava/lang/Object;
    :cond_2
    const/4 v5, 0x0

    goto :goto_0

    .end local v1    # "Thread":Lcom/android/internal/telephony/SecurityManager$SecurityCommandThread;
    .end local v4    # "result":Ljava/lang/Object;
    :catch_0
    move-exception v2

    .local v2, "e":Ljava/lang/RuntimeException;
    const-string v6, "SecurityManager"

    const-string v7, "SecurityCommandSender: Runtime Exception"

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v6, Lcom/android/internal/telephony/CommandException$Error;->GENERIC_FAILURE:Lcom/android/internal/telephony/CommandException$Error;

    invoke-virtual {v6}, Lcom/android/internal/telephony/CommandException$Error;->ordinal()I

    move-result v5

    if-lez v5, :cond_1

    mul-int/lit8 v5, v5, -0x1

    goto :goto_0
.end method

.method private static SecurityManagerLog(Ljava/lang/String;)V
    .locals 1
    .param p0, "logString"    # Ljava/lang/String;

    .prologue
    const-string v0, "SecurityManager"

    invoke-static {v0, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
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

    const/16 v6, 0x19

    .local v6, "velueSize":B
    const/4 v5, 0x0

    .local v5, "termChar":B
    const/16 v9, 0x29

    new-array v2, v9, [B

    .local v2, "request":[B
    const/16 v9, 0x800

    new-array v3, v9, [B

    .local v3, "response":[B
    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v1

    .local v1, "reqBuffer":Ljava/nio/ByteBuffer;
    int-to-byte v0, p1

    .local v0, "lock_type":B
    const-string v9, "depersonalization Start!"

    invoke-static {v9}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

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

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    const-string v9, "SECURITY"

    invoke-virtual {v9}, Ljava/lang/String;->getBytes()[B

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v11}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v6}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    const/16 v9, 0x10

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-virtual {p2}, Ljava/lang/String;->getBytes()[B

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v5}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    invoke-direct {p0, v11, v2, v3}, Lcom/android/internal/telephony/SecurityManager;->SecurityCommandSender(I[B[B)I

    move-result v4

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

    aget-byte v9, v3, v7

    if-ne v9, v8, :cond_0

    if-lez v4, :cond_0

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

    const/4 v4, 0x0

    .local v4, "termChar":B
    const/16 v5, 0x10

    new-array v1, v5, [B

    .local v1, "request":[B
    const/16 v5, 0x800

    new-array v2, v5, [B

    .local v2, "response":[B
    invoke-static {v1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .local v0, "reqBuffer":Ljava/nio/ByteBuffer;
    const-string v5, "enableRootPermission --- "

    invoke-static {v5}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    const-string v5, "SECURITY"

    invoke-virtual {v5}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v6}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    const/4 v5, 0x1

    invoke-virtual {v0, v5}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-direct {p0, v6, v1, v2}, Lcom/android/internal/telephony/SecurityManager;->SecurityCommandSender(I[B[B)I

    move-result v3

    .local v3, "result":I
    const/4 v5, 0x0

    aget-byte v5, v2, v5

    return v5
.end method

.method public getSIMLockLeftCntWithIndex(I)B
    .locals 3
    .param p1, "type"    # I

    .prologue
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

    packed-switch p1, :pswitch_data_0

    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

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

    const-string v1, "getSIMLockLeftCntWithIndex End!"

    invoke-static {v1}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    return v0

    .end local v0    # "curSimLockLeftCnt":B
    :pswitch_0
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .restart local v0    # "curSimLockLeftCnt":B
    goto :goto_0

    .end local v0    # "curSimLockLeftCnt":B
    :pswitch_1
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .restart local v0    # "curSimLockLeftCnt":B
    goto :goto_0

    .end local v0    # "curSimLockLeftCnt":B
    :pswitch_2
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .restart local v0    # "curSimLockLeftCnt":B
    goto :goto_0

    .end local v0    # "curSimLockLeftCnt":B
    :pswitch_3
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    .restart local v0    # "curSimLockLeftCnt":B
    goto :goto_0

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
    packed-switch p1, :pswitch_data_0

    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

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

    const-string v1, "getSIMLockRetryCntMaxWithIndex End!"

    invoke-static {v1}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    return v0

    .end local v0    # "curSimLockRetryCntMax":B
    :pswitch_0
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .restart local v0    # "curSimLockRetryCntMax":B
    goto :goto_0

    .end local v0    # "curSimLockRetryCntMax":B
    :pswitch_1
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .restart local v0    # "curSimLockRetryCntMax":B
    goto :goto_0

    .end local v0    # "curSimLockRetryCntMax":B
    :pswitch_2
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .restart local v0    # "curSimLockRetryCntMax":B
    goto :goto_0

    .end local v0    # "curSimLockRetryCntMax":B
    :pswitch_3
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget-byte v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    .restart local v0    # "curSimLockRetryCntMax":B
    goto :goto_0

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

    packed-switch p1, :pswitch_data_0

    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

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

    const-string v1, "getSIMLockflagWithIndex End!"

    invoke-static {v1}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    return v0

    .end local v0    # "curSimLockflag":I
    :pswitch_0
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .restart local v0    # "curSimLockflag":I
    goto :goto_0

    .end local v0    # "curSimLockflag":I
    :pswitch_1
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .restart local v0    # "curSimLockflag":I
    goto :goto_0

    .end local v0    # "curSimLockflag":I
    :pswitch_2
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .restart local v0    # "curSimLockflag":I
    goto :goto_0

    .end local v0    # "curSimLockflag":I
    :pswitch_3
    iget-object v1, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v1, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    iget v0, v1, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    .restart local v0    # "curSimLockflag":I
    goto :goto_0

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

    const/16 v6, 0x19

    .local v6, "velueSize":B
    const/4 v5, 0x0

    .local v5, "termChar":B
    const/16 v9, 0x29

    new-array v2, v9, [B

    .local v2, "request":[B
    const/16 v9, 0x800

    new-array v3, v9, [B

    .local v3, "response":[B
    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v1

    .local v1, "reqBuffer":Ljava/nio/ByteBuffer;
    int-to-byte v0, p1

    .local v0, "lock_type":B
    const-string v9, "personalization Start!"

    invoke-static {v9}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

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

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    const-string v9, "SECURITY"

    invoke-virtual {v9}, Ljava/lang/String;->getBytes()[B

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v11}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v6}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    const/16 v9, 0x10

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-virtual {p2}, Ljava/lang/String;->getBytes()[B

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v5}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    invoke-direct {p0, v11, v2, v3}, Lcom/android/internal/telephony/SecurityManager;->SecurityCommandSender(I[B[B)I

    move-result v4

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

    aget-byte v9, v3, v7

    if-ne v9, v8, :cond_0

    if-lez v4, :cond_0

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

    const/4 v4, 0x0

    .local v4, "velueSize":B
    const/16 v7, 0x10

    new-array v1, v7, [B

    .local v1, "request":[B
    const/16 v7, 0x800

    new-array v2, v7, [B

    .local v2, "response":[B
    const-string v7, "simlockinformation Start!"

    invoke-static {v7}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    new-instance v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    invoke-direct {v7, p0}, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;-><init>(Lcom/android/internal/telephony/SecurityManager;)V

    iput-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    invoke-static {v1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .local v0, "reqBuffer":Ljava/nio/ByteBuffer;
    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    const-string v7, "SECURITY"

    invoke-virtual {v7}, Ljava/lang/String;->getBytes()[B

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v6}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    invoke-direct {p0, v6, v1, v2}, Lcom/android/internal/telephony/SecurityManager;->SecurityCommandSender(I[B[B)I

    move-result v3

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

    if-lez v3, :cond_0

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    aget-byte v8, v2, v5

    iput-byte v8, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    iget-object v7, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v7, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    aget-byte v6, v2, v6

    iput v6, v7, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->network:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x2

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x3

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x4

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->networksubset:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x5

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x6

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/4 v7, 0x7

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->serviceprovider:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0x8

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0x9

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0xa

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->corporate:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0xb

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0xc

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->attemptsLeft:B

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0xd

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->flag:I

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    iget-object v6, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->sim:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;

    const/16 v7, 0xe

    aget-byte v7, v2, v7

    iput-byte v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion$SIMLock;->retry_count_max:B

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    const/16 v7, 0xf

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->country:I

    iget-object v6, p0, Lcom/android/internal/telephony/SecurityManager;->info:Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;

    const/16 v7, 0x13

    aget-byte v7, v2, v7

    iput v7, v6, Lcom/android/internal/telephony/SecurityManager$SIMLockInformtion;->operator:I

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

    const-string v6, "simlockinformation End!"

    invoke-static {v6}, Lcom/android/internal/telephony/SecurityManager;->SecurityManagerLog(Ljava/lang/String;)V

    :goto_0
    return v5

    :cond_0
    move v5, v6

    goto :goto_0
.end method
