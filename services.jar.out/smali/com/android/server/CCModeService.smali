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

    .line 53
    invoke-direct {p0}, Landroid/security/ICCModeService$Stub;-><init>()V

    .line 54
    iput-object p1, p0, Lcom/android/server/CCModeService;->mContext:Landroid/content/Context;

    .line 55
    new-instance v1, Lcom/android/server/CCMode;

    invoke-direct {v1}, Lcom/android/server/CCMode;-><init>()V

    iput-object v1, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    .line 57
    invoke-direct {p0}, Lcom/android/server/CCModeService;->set_sw_version_info()V

    .line 59
    invoke-direct {p0}, Lcom/android/server/CCModeService;->check_ccmode()I

    move-result v1

    if-ne v1, v3, :cond_1

    .line 61
    const-string v1, "CC_MODE"

    const-string v2, "CCModeService: Openssl Self-test Started!!!!"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 62
    iget-object v1, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    invoke-virtual {v1}, Lcom/android/server/CCMode;->cc_mode_selftest()I

    move-result v0

    .line 63
    .local v0, "status":I
    if-eq v0, v3, :cond_0

    .line 65
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

    .line 79
    .end local v0    # "status":I
    :goto_0
    return-void

    .line 69
    .restart local v0    # "status":I
    :cond_0
    const-string v1, "CC_MODE"

    const-string v2, "CCModeService: Openssl Self-test successfully finished !!!!"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 70
    const-string v1, "CC_MODE"

    const-string v2, "CCModeService: BC Self-test Started!!!!"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 71
    invoke-direct {p0}, Lcom/android/server/CCModeService;->bc_self_test()V

    .line 72
    const-string v1, "CC_MODE"

    const-string v2, "CCModeService:BC Self-test finished!!!!"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 77
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
    .line 200
    new-instance v0, Lcom/android/org/bouncycastle/crypto/test/AESTest;

    invoke-direct {v0}, Lcom/android/org/bouncycastle/crypto/test/AESTest;-><init>()V

    .line 201
    .local v0, "aes":Lcom/android/org/bouncycastle/crypto/test/AESTest;
    invoke-virtual {v0}, Lcom/android/org/bouncycastle/crypto/test/AESTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v1

    .line 203
    .local v1, "aes_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v1}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_a

    .line 205
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

    .line 206
    invoke-interface {v1}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_0

    .line 208
    invoke-interface {v1}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    .line 210
    :cond_0
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    .line 217
    :goto_0
    new-instance v2, Lcom/android/org/bouncycastle/crypto/test/AESWrapTest;

    invoke-direct {v2}, Lcom/android/org/bouncycastle/crypto/test/AESWrapTest;-><init>()V

    .line 218
    .local v2, "aes_wrap":Lcom/android/org/bouncycastle/crypto/test/AESWrapTest;
    invoke-virtual {v2}, Lcom/android/org/bouncycastle/crypto/test/AESWrapTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v3

    .line 219
    .local v3, "aes_wrap_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v3}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_b

    .line 221
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

    .line 222
    invoke-interface {v3}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_1

    .line 224
    invoke-interface {v3}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    .line 226
    :cond_1
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    .line 233
    :goto_1
    new-instance v4, Lcom/android/org/bouncycastle/crypto/test/DESedeTest;

    invoke-direct {v4}, Lcom/android/org/bouncycastle/crypto/test/DESedeTest;-><init>()V

    .line 234
    .local v4, "des3":Lcom/android/org/bouncycastle/crypto/test/DESedeTest;
    invoke-virtual {v4}, Lcom/android/org/bouncycastle/crypto/test/DESedeTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v5

    .line 235
    .local v5, "des3_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v5}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_c

    .line 237
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

    .line 238
    invoke-interface {v5}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_2

    .line 240
    invoke-interface {v5}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    .line 242
    :cond_2
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    .line 249
    :goto_2
    new-instance v8, Lcom/android/org/bouncycastle/crypto/test/RSATest;

    invoke-direct {v8}, Lcom/android/org/bouncycastle/crypto/test/RSATest;-><init>()V

    .line 250
    .local v8, "rsa":Lcom/android/org/bouncycastle/crypto/test/RSATest;
    invoke-virtual {v8}, Lcom/android/org/bouncycastle/crypto/test/RSATest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v9

    .line 251
    .local v9, "rsa_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v9}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_d

    .line 253
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

    .line 254
    invoke-interface {v9}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_3

    .line 256
    invoke-interface {v9}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    .line 258
    :cond_3
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    .line 265
    :goto_3
    new-instance v10, Lcom/android/org/bouncycastle/crypto/test/RSADigestSignerTest;

    invoke-direct {v10}, Lcom/android/org/bouncycastle/crypto/test/RSADigestSignerTest;-><init>()V

    .line 266
    .local v10, "rsa_sign":Lcom/android/org/bouncycastle/crypto/test/RSADigestSignerTest;
    invoke-virtual {v10}, Lcom/android/org/bouncycastle/crypto/test/RSADigestSignerTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v11

    .line 267
    .local v11, "rsa_sign_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v11}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_e

    .line 269
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

    .line 270
    invoke-interface {v11}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_4

    .line 272
    invoke-interface {v11}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    .line 274
    :cond_4
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    .line 281
    :goto_4
    new-instance v12, Lcom/android/org/bouncycastle/crypto/test/SHA1HMacTest;

    invoke-direct {v12}, Lcom/android/org/bouncycastle/crypto/test/SHA1HMacTest;-><init>()V

    .line 282
    .local v12, "sha1":Lcom/android/org/bouncycastle/crypto/test/SHA1HMacTest;
    invoke-virtual {v12}, Lcom/android/org/bouncycastle/crypto/test/SHA1HMacTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v13

    .line 283
    .local v13, "sha1_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v13}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_f

    .line 285
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

    .line 286
    invoke-interface {v13}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_5

    .line 288
    invoke-interface {v13}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    .line 290
    :cond_5
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    .line 297
    :goto_5
    new-instance v14, Lcom/android/org/bouncycastle/crypto/test/SHA256HMacTest;

    invoke-direct {v14}, Lcom/android/org/bouncycastle/crypto/test/SHA256HMacTest;-><init>()V

    .line 298
    .local v14, "sha256":Lcom/android/org/bouncycastle/crypto/test/SHA256HMacTest;
    invoke-virtual {v14}, Lcom/android/org/bouncycastle/crypto/test/SHA256HMacTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v15

    .line 299
    .local v15, "sha256_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v15}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_10

    .line 301
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

    .line 302
    invoke-interface {v15}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_6

    .line 304
    invoke-interface {v13}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    .line 306
    :cond_6
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    .line 313
    :goto_6
    new-instance v16, Lcom/android/org/bouncycastle/crypto/test/SHA384HMacTest;

    invoke-direct/range {v16 .. v16}, Lcom/android/org/bouncycastle/crypto/test/SHA384HMacTest;-><init>()V

    .line 314
    .local v16, "sha384":Lcom/android/org/bouncycastle/crypto/test/SHA384HMacTest;
    invoke-virtual/range {v16 .. v16}, Lcom/android/org/bouncycastle/crypto/test/SHA384HMacTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v17

    .line 315
    .local v17, "sha384_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface/range {v17 .. v17}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_11

    .line 317
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

    .line 318
    invoke-interface/range {v17 .. v17}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_7

    .line 320
    invoke-interface/range {v17 .. v17}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    .line 322
    :cond_7
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    .line 329
    :goto_7
    new-instance v18, Lcom/android/org/bouncycastle/crypto/test/SHA512HMacTest;

    invoke-direct/range {v18 .. v18}, Lcom/android/org/bouncycastle/crypto/test/SHA512HMacTest;-><init>()V

    .line 330
    .local v18, "sha512":Lcom/android/org/bouncycastle/crypto/test/SHA512HMacTest;
    invoke-virtual/range {v18 .. v18}, Lcom/android/org/bouncycastle/crypto/test/SHA512HMacTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v19

    .line 331
    .local v19, "sha512_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface/range {v19 .. v19}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_12

    .line 333
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

    .line 334
    invoke-interface/range {v19 .. v19}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_8

    .line 336
    invoke-interface/range {v19 .. v19}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    .line 338
    :cond_8
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    .line 345
    :goto_8
    new-instance v6, Lcom/android/org/bouncycastle/crypto/test/MacTest;

    invoke-direct {v6}, Lcom/android/org/bouncycastle/crypto/test/MacTest;-><init>()V

    .line 346
    .local v6, "mac":Lcom/android/org/bouncycastle/crypto/test/MacTest;
    invoke-virtual {v6}, Lcom/android/org/bouncycastle/crypto/test/MacTest;->perform()Lcom/android/org/bouncycastle/util/test/TestResult;

    move-result-object v7

    .line 347
    .local v7, "mac_result":Lcom/android/org/bouncycastle/util/test/TestResult;
    invoke-interface {v7}, Lcom/android/org/bouncycastle/util/test/TestResult;->isSuccessful()Z

    move-result v20

    if-nez v20, :cond_13

    .line 349
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

    .line 350
    invoke-interface {v7}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    if-eqz v20, :cond_9

    .line 352
    invoke-interface {v7}, Lcom/android/org/bouncycastle/util/test/TestResult;->getException()Ljava/lang/Throwable;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/Throwable;->printStackTrace()V

    .line 354
    :cond_9
    invoke-direct/range {p0 .. p0}, Lcom/android/server/CCModeService;->set_selftest_result()V

    .line 361
    :goto_9
    return-void

    .line 214
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

    .line 230
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

    .line 246
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

    .line 262
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

    .line 278
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

    .line 294
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

    .line 310
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

    .line 326
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

    .line 342
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

    .line 358
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

    .line 173
    const/4 v0, -0x1

    .line 174
    .local v0, "cc_mode":I
    const/4 v3, 0x0

    .line 178
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

    .line 180
    .end local v3    # "in":Ljava/io/BufferedReader;
    .local v4, "in":Ljava/io/BufferedReader;
    :try_start_1
    invoke-virtual {v4}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v5

    .line 181
    .local v5, "s":Ljava/lang/String;
    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v0

    .line 186
    if-eqz v4, :cond_0

    :try_start_2
    invoke-virtual {v4}, Ljava/io/BufferedReader;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    :cond_0
    move-object v3, v4

    .line 192
    .end local v4    # "in":Ljava/io/BufferedReader;
    .end local v5    # "s":Ljava/lang/String;
    .restart local v3    # "in":Ljava/io/BufferedReader;
    :cond_1
    :goto_0
    if-ne v0, v6, :cond_3

    .line 195
    :goto_1
    return v6

    .line 187
    .end local v3    # "in":Ljava/io/BufferedReader;
    .restart local v4    # "in":Ljava/io/BufferedReader;
    .restart local v5    # "s":Ljava/lang/String;
    :catch_0
    move-exception v2

    .line 188
    .local v2, "ex":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    move-object v3, v4

    .line 190
    .end local v4    # "in":Ljava/io/BufferedReader;
    .restart local v3    # "in":Ljava/io/BufferedReader;
    goto :goto_0

    .line 182
    .end local v2    # "ex":Ljava/io/IOException;
    .end local v5    # "s":Ljava/lang/String;
    :catch_1
    move-exception v1

    .line 183
    .local v1, "e":Ljava/io/IOException;
    :goto_2
    :try_start_3
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 186
    if-eqz v3, :cond_1

    :try_start_4
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_0

    .line 187
    :catch_2
    move-exception v2

    .line 188
    .restart local v2    # "ex":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .line 185
    .end local v1    # "e":Ljava/io/IOException;
    .end local v2    # "ex":Ljava/io/IOException;
    :catchall_0
    move-exception v6

    .line 186
    :goto_3
    if-eqz v3, :cond_2

    :try_start_5
    invoke-virtual {v3}, Ljava/io/BufferedReader;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    .line 189
    :cond_2
    :goto_4
    throw v6

    .line 187
    :catch_3
    move-exception v2

    .line 188
    .restart local v2    # "ex":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_4

    .line 195
    .end local v2    # "ex":Ljava/io/IOException;
    :cond_3
    const/4 v6, 0x0

    goto :goto_1

    .line 185
    .end local v3    # "in":Ljava/io/BufferedReader;
    .restart local v4    # "in":Ljava/io/BufferedReader;
    :catchall_1
    move-exception v6

    move-object v3, v4

    .end local v4    # "in":Ljava/io/BufferedReader;
    .restart local v3    # "in":Ljava/io/BufferedReader;
    goto :goto_3

    .line 182
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
    .line 365
    const-string v0, "ro.sys.bc.selftest.status"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "failed"

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    .line 367
    const-string v0, "ro.sys.bc.selftest.status"

    const-string v1, "failed"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 368
    const-string v0, "CC_MODE"

    const-string v1, "BC Self-test: Bouncy castle Self test is failed~!!!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 370
    :cond_0
    return-void
.end method

.method private set_sw_version_info()V
    .locals 5

    .prologue
    const/4 v3, 0x1

    .line 83
    const/4 v1, -0x1

    .line 87
    .local v1, "ret":I
    :try_start_0
    invoke-virtual {p0}, Lcom/android/server/CCModeService;->cc_mode_isSupported()I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    .line 95
    if-ne v1, v3, :cond_0

    .line 97
    const-string v2, "ro.sys.sec.version.info"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_0

    .line 99
    const-string v2, "ro.sys.sec.version.info"

    const-string v3, "MDF v1.1 Release 1"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 100
    const-string v2, "CC_MODE"

    const-string v3, "version info set success~!!!"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 104
    :cond_0
    :goto_0
    return-void

    .line 89
    :catch_0
    move-exception v0

    .line 91
    .local v0, "e":Landroid/os/RemoteException;
    :try_start_1
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 95
    if-ne v1, v3, :cond_0

    .line 97
    const-string v2, "ro.sys.sec.version.info"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_0

    .line 99
    const-string v2, "ro.sys.sec.version.info"

    const-string v3, "MDF v1.1 Release 1"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 100
    const-string v2, "CC_MODE"

    const-string v3, "version info set success~!!!"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 95
    .end local v0    # "e":Landroid/os/RemoteException;
    :catchall_0
    move-exception v2

    if-ne v1, v3, :cond_1

    .line 97
    const-string v3, "ro.sys.sec.version.info"

    invoke-static {v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_1

    .line 99
    const-string v3, "ro.sys.sec.version.info"

    const-string v4, "MDF v1.1 Release 1"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 100
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
    .line 128
    const/4 v1, -0x1

    .line 129
    .local v1, "ret":I
    iget-object v2, p0, Lcom/android/server/CCModeService;->mContext:Landroid/content/Context;

    const-string v3, "com.lge.permission.ACCESS_CC_MODE"

    invoke-virtual {v2, v3}, Landroid/content/Context;->checkCallingOrSelfPermission(Ljava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_0

    .line 131
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

    .line 135
    .local v0, "msg":Ljava/lang/String;
    const-string v2, "CC_MODE"

    invoke-static {v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 136
    new-instance v2, Ljava/lang/SecurityException;

    invoke-direct {v2, v0}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 139
    .end local v0    # "msg":Ljava/lang/String;
    :cond_0
    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    if-eqz v2, :cond_1

    .line 140
    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    invoke-virtual {v2}, Lcom/android/server/CCMode;->cc_mode_disable()I

    move-result v1

    .line 141
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

    .line 144
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

    .line 145
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
    .line 107
    const/4 v1, -0x1

    .line 108
    .local v1, "ret":I
    iget-object v2, p0, Lcom/android/server/CCModeService;->mContext:Landroid/content/Context;

    const-string v3, "com.lge.permission.ACCESS_CC_MODE"

    invoke-virtual {v2, v3}, Landroid/content/Context;->checkCallingOrSelfPermission(Ljava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_0

    .line 110
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

    .line 114
    .local v0, "msg":Ljava/lang/String;
    const-string v2, "CC_MODE"

    invoke-static {v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 115
    new-instance v2, Ljava/lang/SecurityException;

    invoke-direct {v2, v0}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 118
    .end local v0    # "msg":Ljava/lang/String;
    :cond_0
    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    if-eqz v2, :cond_1

    .line 119
    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    invoke-virtual {v2}, Lcom/android/server/CCMode;->cc_mode_enable()I

    move-result v1

    .line 120
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

    .line 123
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

    .line 124
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
    .line 150
    const/4 v1, -0x1

    .line 151
    .local v1, "ret":I
    iget-object v2, p0, Lcom/android/server/CCModeService;->mContext:Landroid/content/Context;

    const-string v3, "com.lge.permission.ACCESS_CC_MODE"

    invoke-virtual {v2, v3}, Landroid/content/Context;->checkCallingOrSelfPermission(Ljava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_0

    .line 153
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

    .line 157
    .local v0, "msg":Ljava/lang/String;
    const-string v2, "CC_MODE"

    invoke-static {v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 158
    new-instance v2, Ljava/lang/SecurityException;

    invoke-direct {v2, v0}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 161
    .end local v0    # "msg":Ljava/lang/String;
    :cond_0
    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    if-eqz v2, :cond_1

    .line 162
    iget-object v2, p0, Lcom/android/server/CCModeService;->cc_mode:Lcom/android/server/CCMode;

    invoke-virtual {v2}, Lcom/android/server/CCMode;->cc_mode_isSupported()I

    move-result v1

    .line 164
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

    .line 167
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

    .line 168
    return v1
.end method
