.class public Lcom/android/server/CCModeService;
.super Landroid/security/ICCModeService$Stub;
.source "CCModeService.java"


# static fields
.field public static final FAIL:I = -0x1

.field public static final FAIL_ALREADY_CC_MODE_ENABLED:I = -0x2

.field public static final FAIL_CC_MODE_ENABLE:I = -0x4

.field public static final FAIL_CC_MODE_IS_NOT_SUPPORTED:I = -0xa

.field public static final FAIL_DEVICE_IS_NOT_CC_MODE:I = -0x3

.field public static final FAIL_FIPS_MODE_SET:I = -0x9

.field public static final FAIL_FTM_READ:I = -0x7

.field public static final FAIL_FTM_WRITE:I = -0x8

.field public static final FAIL_INTERNAL_DEVICE_IS_NOT_ENCRYPTED:I = -0x5

.field public static final FAIL_SD_DEVICE_IS_NOT_ENCRYPTED:I = -0x6

.field private static final Reboot_Message:Ljava/lang/String; = "Device will be Rebooted!!!!"

.field public static final SUCCESS:I = 0x1

.field private static final TAG:Ljava/lang/String; = "CC_MODE"


# instance fields
.field public cc_mode:Lcom/android/server/CCMode;

.field private final mContext:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v3, 0x1

    invoke-direct {p0}, Landroid/security/ICCModeService$Stub;-><init>()V

    iput-object p1, p0, Lcom/android/server/CCModeService;->mContext:Landroid/content/Context;

    new-instance v1, Lcom/android/server/CCMode;

    invoke-direct {v1}, Lcom/android/server/CCMode;-><init>()V

    iput-object v1, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    invoke-direct {p0}, Lcom/android/server/CCModeService;->set_sw_version_info()V

    invoke-direct {p0}, Lcom/android/server/CCModeService;->check_ccmode()I

    move-result v1

    if-ne v1, v3, :cond_1

    const-string v1, "CC_MODE"

    const-string v2, "CCModeService: Openssl Self-test Started!!!!"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    invoke-virtual {v1}, Lcom/android/server/CCMode;->cc_mode_selftest()I

    move-result v0

    .local v0, "status":I
    if-eq v0, v3, :cond_0

    const-string v1, "CC_MODE"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CCModeService: Openssl Self-test failed!!! errorno="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "status":I
    :goto_0
    return-void

    .restart local v0    # "status":I
    :cond_0
    const-string v1, "CC_MODE"

    const-string v2, "CCModeService: Openssl Self-test successfully finished !!!!"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "CC_MODE"

    const-string v2, "CCModeService: BC Self-test Started!!!!"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/android/server/CCModeService;->bc_self_test()V

    const-string v1, "CC_MODE"

    const-string v2, "CCModeService:BC Self-test finished!!!!"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "status":I
    :cond_1
    const-string v1, "CC_MODE"

    const-string v2, "Self-test: device is in non cc_mode. BC & Openssl Self-test will be skipped~!!!\n"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private bc_self_test()V
    .locals 23

    .prologue
    new-instance v0, Lcom/android/org/bouncycastle/crypto/test/AESTest;

    invoke-direct {v0}, Lcom/android/org/bouncycastle/crypto/test/AESTest;-><init>()V

    .local v0, "aes":Lcom/android/org/bouncycastle/crypto/test/AESTest;
    invoke-virtual {v0}, Lcom/android/org/bouncycastle/crypto/test/AESTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v1

    .local v1, "aes_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v1}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_a

    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v1}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v1}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_0

    invoke-interface {v1}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    :goto_0
    new-instance v2, Lcom/android/org/bouncycastle/crypto/test/AESWrapTest;

    invoke-direct {v2}, Lcom/android/org/bouncycastle/crypto/test/AESWrapTest;-><init>()V

    .local v2, "aes_wrap":Lcom/android/org/bouncycastle/crypto/test/AESWrapTest;
    invoke-virtual {v2}, Lcom/android/org/bouncycastle/crypto/test/AESWrapTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v3

    .local v3, "aes_wrap_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v3}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_b

    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v3}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v3}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_1

    invoke-interface {v3}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    :goto_1
    new-instance v4, Lcom/android/org/bouncycastle/crypto/test/DESedeTest;

    invoke-direct {v4}, Lcom/android/org/bouncycastle/crypto/test/DESedeTest;-><init>()V

    .local v4, "des3":Lcom/android/org/bouncycastle/crypto/test/DESedeTest;
    invoke-virtual {v4}, Lcom/android/org/bouncycastle/crypto/test/DESedeTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v5

    .local v5, "des3_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v5}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_c

    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v5}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v5}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_2

    invoke-interface {v5}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    :goto_2
    new-instance v8, Lcom/android/org/bouncycastle/crypto/test/RSATest;

    invoke-direct {v8}, Lcom/android/org/bouncycastle/crypto/test/RSATest;-><init>()V

    .local v8, "rsa":Lcom/android/org/bouncycastle/crypto/test/RSATest;
    invoke-virtual {v8}, Lcom/android/org/bouncycastle/crypto/test/RSATest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v9

    .local v9, "rsa_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v9}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_d

    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v9}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v9}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_3

    invoke-interface {v9}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    :goto_3
    new-instance v10, Lcom/android/org/bouncycastle/crypto/test/RSADigestSignerTest;

    invoke-direct {v10}, Lcom/android/org/bouncycastle/crypto/test/RSADigestSignerTest;-><init>()V

    .local v10, "rsa_sign":Lcom/android/org/bouncycastle/crypto/test/RSADigestSignerTest;
    invoke-virtual {v10}, Lcom/android/org/bouncycastle/crypto/test/RSADigestSignerTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v11

    .local v11, "rsa_sign_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v11}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_e

    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v11}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v11}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_4

    invoke-interface {v11}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_4
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    :goto_4
    new-instance v12, Lcom/android/org/bouncycastle/crypto/test/SHA1HMacTest;

    invoke-direct {v12}, Lcom/android/org/bouncycastle/crypto/test/SHA1HMacTest;-><init>()V

    .local v12, "sha1":Lcom/android/org/bouncycastle/crypto/test/SHA1HMacTest;
    invoke-virtual {v12}, Lcom/android/org/bouncycastle/crypto/test/SHA1HMacTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v13

    .local v13, "sha1_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v13}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_f

    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v13}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v13}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_5

    invoke-interface {v13}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_5
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    :goto_5
    new-instance v14, Lcom/android/org/bouncycastle/crypto/test/SHA256HMacTest;

    invoke-direct {v14}, Lcom/android/org/bouncycastle/crypto/test/SHA256HMacTest;-><init>()V

    .local v14, "sha256":Lcom/android/org/bouncycastle/crypto/test/SHA256HMacTest;
    invoke-virtual {v14}, Lcom/android/org/bouncycastle/crypto/test/SHA256HMacTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v15

    .local v15, "sha256_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v15}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_10

    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v15}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v15}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_6

    invoke-interface {v13}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_6
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    :goto_6
    new-instance v16, Lcom/android/org/bouncycastle/crypto/test/SHA384HMacTest;

    invoke-direct/range {v16 .. v16}, Lcom/android/org/bouncycastle/crypto/test/SHA384HMacTest;-><init>()V

    .local v16, "sha384":Lcom/android/org/bouncycastle/crypto/test/SHA384HMacTest;
    invoke-virtual/range {v16 .. v16}, Lcom/android/org/bouncycastle/crypto/test/SHA384HMacTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v17

    .local v17, "sha384_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface/range {v17 .. v17}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_11

    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface/range {v17 .. v17}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface/range {v17 .. v17}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_7

    invoke-interface/range {v17 .. v17}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_7
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    :goto_7
    new-instance v18, Lcom/android/org/bouncycastle/crypto/test/SHA512HMacTest;

    invoke-direct/range {v18 .. v18}, Lcom/android/org/bouncycastle/crypto/test/SHA512HMacTest;-><init>()V

    .local v18, "sha512":Lcom/android/org/bouncycastle/crypto/test/SHA512HMacTest;
    invoke-virtual/range {v18 .. v18}, Lcom/android/org/bouncycastle/crypto/test/SHA512HMacTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v19

    .local v19, "sha512_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface/range {v19 .. v19}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_12

    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface/range {v19 .. v19}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface/range {v19 .. v19}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_8

    invoke-interface/range {v19 .. v19}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_8
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    :goto_8
    new-instance v6, Lcom/android/org/bouncycastle/crypto/test/MacTest;

    invoke-direct {v6}, Lcom/android/org/bouncycastle/crypto/test/MacTest;-><init>()V

    .local v6, "mac":Lcom/android/org/bouncycastle/crypto/test/MacTest;
    invoke-virtual {v6}, Lcom/android/org/bouncycastle/crypto/test/MacTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v7

    .local v7, "mac_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v7}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_13

    const-string v20, "BC Self-test: CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v7}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v7}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_9

    invoke-interface {v7}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_9
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    :goto_9
    return-void

    .end local v2    # "aes_wrap":Lcom/android/org/bouncycastle/crypto/test/AESWrapTest;
    .end local v3    # "aes_wrap_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    .end local v4    # "des3":Lcom/android/org/bouncycastle/crypto/test/DESedeTest;
    .end local v5    # "des3_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    .end local v6    # "mac":Lcom/android/org/bouncycastle/crypto/test/MacTest;
    .end local v7    # "mac_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    .end local v8    # "rsa":Lcom/android/org/bouncycastle/crypto/test/RSATest;
    .end local v9    # "rsa_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    .end local v10    # "rsa_sign":Lcom/android/org/bouncycastle/crypto/test/RSADigestSignerTest;
    .end local v11    # "rsa_sign_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    .end local v12    # "sha1":Lcom/android/org/bouncycastle/crypto/test/SHA1HMacTest;
    .end local v13    # "sha1_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    .end local v14    # "sha256":Lcom/android/org/bouncycastle/crypto/test/SHA256HMacTest;
    .end local v15    # "sha256_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    .end local v16    # "sha384":Lcom/android/org/bouncycastle/crypto/test/SHA384HMacTest;
    .end local v17    # "sha384_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    .end local v18    # "sha512":Lcom/android/org/bouncycastle/crypto/test/SHA512HMacTest;
    .end local v19    # "sha512_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    :cond_a
    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v1}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .restart local v2    # "aes_wrap":Lcom/android/org/bouncycastle/crypto/test/AESWrapTest;
    .restart local v3    # "aes_wrap_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    :cond_b
    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v3}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .restart local v4    # "des3":Lcom/android/org/bouncycastle/crypto/test/DESedeTest;
    .restart local v5    # "des3_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    :cond_c
    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v5}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_2

    .restart local v8    # "rsa":Lcom/android/org/bouncycastle/crypto/test/RSATest;
    .restart local v9    # "rsa_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    :cond_d
    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v9}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_3

    .restart local v10    # "rsa_sign":Lcom/android/org/bouncycastle/crypto/test/RSADigestSignerTest;
    .restart local v11    # "rsa_sign_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    :cond_e
    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v11}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_4

    .restart local v12    # "sha1":Lcom/android/org/bouncycastle/crypto/test/SHA1HMacTest;
    .restart local v13    # "sha1_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    :cond_f
    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v13}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_5

    .restart local v14    # "sha256":Lcom/android/org/bouncycastle/crypto/test/SHA256HMacTest;
    .restart local v15    # "sha256_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    :cond_10
    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v15}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_6

    .restart local v16    # "sha384":Lcom/android/org/bouncycastle/crypto/test/SHA384HMacTest;
    .restart local v17    # "sha384_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    :cond_11
    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface/range {v17 .. v17}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_7

    .restart local v18    # "sha512":Lcom/android/org/bouncycastle/crypto/test/SHA512HMacTest;
    .restart local v19    # "sha512_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    :cond_12
    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface/range {v19 .. v19}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_8

    .restart local v6    # "mac":Lcom/android/org/bouncycastle/crypto/test/MacTest;
    .restart local v7    # "mac_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    :cond_13
    const-string v20, "CC_MODE"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "BC Self-test: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-interface {v7}, Lcom/android/org/bouncycastle/util/test/TestResult;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "\n"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_9
.end method

.method private check_ccmode()I
    .locals 9

    .prologue
    const/4 v6, 0x1

    const/4 v0, -0x1

    .local v0, "cc_mode":I
    const/4 v3, 0x0

    .local v3, "in":Ljava/io/BufferedReader;
    :try_start_0
    new-instance v4, Ljava/io/BufferedReader;

    new-instance v7, Ljava/io/FileReader;

    const-string v8, "/proc/sys/crypto/cc_mode"

    invoke-direct {v7, v8}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v4, v7}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v3    # "in":Ljava/io/BufferedReader;
    .local v4, "in":Ljava/io/BufferedReader;
    :try_start_1
    invoke-virtual {v4}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v5

    .local v5, "s":Ljava/lang/String;
    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v0

    if-eqz v4, :cond_0

    :try_start_2
    invoke-virtual {v4}, Ljava/io/BufferedReader;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    :cond_0
    move-object v3, v4

    .end local v4    # "in":Ljava/io/BufferedReader;
    .end local v5    # "s":Ljava/lang/String;
    .restart local v3    # "in":Ljava/io/BufferedReader;
    :cond_1
    :goto_0
    if-ne v0, v6, :cond_3

    :goto_1
    return v6

    .end local v3    # "in":Ljava/io/BufferedReader;
    .restart local v4    # "in":Ljava/io/BufferedReader;
    .restart local v5    # "s":Ljava/lang/String;
    :catch_0
    move-exception v2

    .local v2, "ex":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    move-object v3, v4

    .end local v4    # "in":Ljava/io/BufferedReader;
    .restart local v3    # "in":Ljava/io/BufferedReader;
    goto :goto_0

    .end local v2    # "ex":Ljava/io/IOException;
    .end local v5    # "s":Ljava/lang/String;
    :catch_1
    move-exception v1

    .local v1, "e":Ljava/io/IOException;
    :goto_2
    :try_start_3
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-eqz v3, :cond_1

    :try_start_4
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_0

    :catch_2
    move-exception v2

    .restart local v2    # "ex":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .end local v1    # "e":Ljava/io/IOException;
    .end local v2    # "ex":Ljava/io/IOException;
    :catchall_0
    move-exception v6

    :goto_3
    if-eqz v3, :cond_2

    :try_start_5
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    :cond_2
    :goto_4
    throw v6

    :catch_3
    move-exception v2

    .restart local v2    # "ex":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_4

    .end local v2    # "ex":Ljava/io/IOException;
    :cond_3
    const/4 v6, 0x0

    goto :goto_1

    .end local v3    # "in":Ljava/io/BufferedReader;
    .restart local v4    # "in":Ljava/io/BufferedReader;
    :catchall_1
    move-exception v6

    move-object v3, v4

    .end local v4    # "in":Ljava/io/BufferedReader;
    .restart local v3    # "in":Ljava/io/BufferedReader;
    goto :goto_3

    .end local v3    # "in":Ljava/io/BufferedReader;
    .restart local v4    # "in":Ljava/io/BufferedReader;
    :catch_4
    move-exception v1

    move-object v3, v4

    .end local v4    # "in":Ljava/io/BufferedReader;
    .restart local v3    # "in":Ljava/io/BufferedReader;
    goto :goto_2
.end method

.method private set_selftest_result()V
    .locals 2

    .prologue
    const-string v0, "ro.sys.bc.selftest.status"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "failed"

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "ro.sys.bc.selftest.status"

    const-string v1, "failed"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "CC_MODE"

    const-string v1, "BC Self-test: Bouncy castle Self test is failed~!!!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method private set_sw_version_info()V
    .locals 5

    .prologue
    const/4 v3, 0x1

    const/4 v1, -0x1

    .local v1, "ret":I
    :try_start_0
    invoke-virtual {p0}, Lcom/android/server/CCModeService;->cc_mode_isSupported()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    if-ne v1, v3, :cond_0

    const-string v2, "ro.sys.sec.version.info"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "ro.sys.sec.version.info"

    const-string v3, "MDF v1.1 Release 1"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "CC_MODE"

    const-string v3, "version info set success~!!!"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-ne v1, v3, :cond_0

    const-string v2, "ro.sys.sec.version.info"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "ro.sys.sec.version.info"

    const-string v3, "MDF v1.1 Release 1"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "CC_MODE"

    const-string v3, "version info set success~!!!"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v2

    if-ne v1, v3, :cond_1

    const-string v3, "ro.sys.sec.version.info"

    invoke-static {v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_1

    const-string v3, "ro.sys.sec.version.info"

    const-string v4, "MDF v1.1 Release 1"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "CC_MODE"

    const-string v4, "version info set success~!!!"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    throw v2
.end method


# virtual methods
.method public cc_mode_disable()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v1, -0x1

    .local v1, "ret":I
    iget-object v2, p0, Lcom/android/server/CCModeService;->mContext:Landroid/content/Context;

    const-string v3, "com.lge.permission.ACCESS_CC_MODE"

    invoke-virtual {v2, v3}, Landroid/content/Context;->checkCallingOrSelfPermission(Ljava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Permission Denial: setSystemProperty() from pid="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/os/Binder;->getCallingPid()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", uid="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " requires com.lge.security.cc_mode_disable"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "msg":Ljava/lang/String;
    const-string v2, "CC_MODE"

    invoke-static {v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v2, Ljava/lang/SecurityException;

    invoke-direct {v2, v0}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v2

    .end local v0    # "msg":Ljava/lang/String;
    :cond_0
    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    invoke-virtual {v2}, Lcom/android/server/CCMode;->cc_mode_disable()I

    move-result v1

    const-string v2, "CC_MODE"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CCModeService: result of cc_mode_disable() = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    const-string v2, "CC_MODE"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CCModeService: cc_mode_disable== "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return v1
.end method

.method public cc_mode_enable()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v1, -0x1

    .local v1, "ret":I
    iget-object v2, p0, Lcom/android/server/CCModeService;->mContext:Landroid/content/Context;

    const-string v3, "com.lge.permission.ACCESS_CC_MODE"

    invoke-virtual {v2, v3}, Landroid/content/Context;->checkCallingOrSelfPermission(Ljava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Permission Denial: setSystemProperty() from pid="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/os/Binder;->getCallingPid()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", uid="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " requires com.lge.security.cc_mode_enable"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "msg":Ljava/lang/String;
    const-string v2, "CC_MODE"

    invoke-static {v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v2, Ljava/lang/SecurityException;

    invoke-direct {v2, v0}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v2

    .end local v0    # "msg":Ljava/lang/String;
    :cond_0
    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    invoke-virtual {v2}, Lcom/android/server/CCMode;->cc_mode_enable()I

    move-result v1

    const-string v2, "CC_MODE"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CCModeService: result of cc_mode_enable() = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    const-string v2, "CC_MODE"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CCModeService: cc_mode_enable = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return v1
.end method

.method public cc_mode_isSupported()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v1, -0x1

    .local v1, "ret":I
    iget-object v2, p0, Lcom/android/server/CCModeService;->mContext:Landroid/content/Context;

    const-string v3, "com.lge.permission.ACCESS_CC_MODE"

    invoke-virtual {v2, v3}, Landroid/content/Context;->checkCallingOrSelfPermission(Ljava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Permission Denial: setSystemProperty() from pid="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/os/Binder;->getCallingPid()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", uid="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " requires com.lge.security.cc_mode_isSupported"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "msg":Ljava/lang/String;
    const-string v2, "CC_MODE"

    invoke-static {v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v2, Ljava/lang/SecurityException;

    invoke-direct {v2, v0}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v2

    .end local v0    # "msg":Ljava/lang/String;
    :cond_0
    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    invoke-virtual {v2}, Lcom/android/server/CCMode;->cc_mode_isSupported()I

    move-result v1

    const-string v2, "CC_MODE"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CCModeService: result of cc_mode_isSupported() = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    const-string v2, "CC_MODE"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CCModeService: cc_mode_isSupported = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return v1
.end method
