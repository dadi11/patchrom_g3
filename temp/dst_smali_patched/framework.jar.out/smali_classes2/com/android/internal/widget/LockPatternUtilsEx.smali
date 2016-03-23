.class public Lcom/android/internal/widget/LockPatternUtilsEx;
.super Lcom/android/internal/widget/LockPatternUtils;
.source "LockPatternUtilsEx.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;
    }
.end annotation


# static fields
.field public static final BACKUPPIN_FOR_KNOCK_ON_EVER_CHOSEN_KEY:Ljava/lang/String; = "lockscreen.backuppinknockoneverchosen"

.field public static final BACKUPPIN_FOR_PATTERN_EVER_CHOSEN_KEY:Ljava/lang/String; = "lockscreen.backuppinpatterneverchosen"

.field public static final KNOCK_CODE_DUPULICATED:Ljava/lang/String; = "lockscreen.knockcode_dupulicated"

.field public static final KNOCK_ON_EVER_CHOSEN_KEY:Ljava/lang/String; = "lockscreen.knockoneverchosen"

.field public static final LOCKSCREEN_KNOCK_ON_ENABLED:Ljava/lang/String; = "lockscreen.knockon_enabled"

.field public static final LOCKSCREEN_KNOCK_ON_LENGTH:Ljava/lang/String; = "lockscreen.knockon_length"

.field public static final PASSWORD_EXPIRE_MODE:Ljava/lang/String; = "PASSWORD_EXPIRE"

.field private static PASSWORD_QUALITY_KNOCK_ON:I = 0x0

.field private static final TAG:Ljava/lang/String; = "LockPatternUtilsEx"

.field private static final carrier:Ljava/lang/String;


# instance fields
.field private mLockSettingsServiceEx:Lcom/android/internal/widget/ILockSettingsEx;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const-string v1, "ro.build.target_operator"

    const-string v2, "COM"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/android/internal/widget/LockPatternUtilsEx;->carrier:Ljava/lang/String;

    :try_start_0
    const-class v1, Landroid/app/admin/DevicePolicyManager;

    const-string v2, "PASSWORD_QUALITY_KNOCK_ON"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v1

    sput v1, Lcom/android/internal/widget/LockPatternUtilsEx;->PASSWORD_QUALITY_KNOCK_ON:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    return-void

    .end local v0    # "e":Ljava/lang/Exception;
    :catch_0
    move-exception v0

    .restart local v0    # "e":Ljava/lang/Exception;
    const-string v1, "LockPatternUtilsEx"

    const-string v2, "PASSWORD_QUALITY_KNOCK_ON does not exist"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const v1, 0x9000

    sput v1, Lcom/android/internal/widget/LockPatternUtilsEx;->PASSWORD_QUALITY_KNOCK_ON:I

    goto :goto_0
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/internal/widget/LockPatternUtils;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method public static computePasswordQuality(Ljava/lang/String;I)I
    .locals 5
    .param p0, "password"    # Ljava/lang/String;
    .param p1, "quality"    # I

    .prologue
    const/4 v0, 0x0

    .local v0, "hasDigit":Z
    const/4 v1, 0x0

    .local v1, "hasNonDigit":Z
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    .local v3, "len":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v3, :cond_1

    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/Character;->isDigit(C)Z

    move-result v4

    if-eqz v4, :cond_0

    const/4 v0, 0x1

    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x1

    goto :goto_1

    :cond_1
    sget v4, Lcom/android/internal/widget/LockPatternUtilsEx;->PASSWORD_QUALITY_KNOCK_ON:I

    if-ne p1, v4, :cond_2

    sget v4, Lcom/android/internal/widget/LockPatternUtilsEx;->PASSWORD_QUALITY_KNOCK_ON:I

    :goto_2
    return v4

    :cond_2
    if-eqz v1, :cond_3

    if-eqz v0, :cond_3

    const/high16 v4, 0x50000

    goto :goto_2

    :cond_3
    if-eqz v1, :cond_4

    const/high16 v4, 0x40000

    goto :goto_2

    :cond_4
    if-eqz v0, :cond_5

    const/high16 v4, 0x20000

    goto :goto_2

    :cond_5
    const/4 v4, 0x0

    goto :goto_2
.end method

.method private getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mLockSettingsServiceEx:Lcom/android/internal/widget/ILockSettingsEx;

    if-nez v0, :cond_0

    const-string v0, "lock_settings"

    invoke-static {v0}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/widget/ILockSettingsEx$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mLockSettingsServiceEx:Lcom/android/internal/widget/ILockSettingsEx;

    :cond_0
    iget-object v0, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mLockSettingsServiceEx:Lcom/android/internal/widget/ILockSettingsEx;

    return-object v0
.end method

.method private isLockPassword()Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;
    .locals 10

    .prologue
    const-wide/32 v8, 0x20000

    const-wide/16 v6, 0x0

    const-string v4, "lockscreen.password_type"

    invoke-virtual {p0, v4, v6, v7}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLong(Ljava/lang/String;J)J

    move-result-wide v2

    .local v2, "mode":J
    const-string v4, "lockscreen.password_type_alternate"

    invoke-virtual {p0, v4, v6, v7}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .local v0, "backupMode":J
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->savedPasswordExists()Z

    move-result v4

    if-eqz v4, :cond_1

    cmp-long v4, v2, v8

    if-eqz v4, :cond_0

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->usingBiometricWeak()Z

    move-result v4

    if-eqz v4, :cond_1

    cmp-long v4, v0, v8

    if-nez v4, :cond_1

    :cond_0
    sget-object v4, Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;->PIN:Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    :goto_0
    return-object v4

    :cond_1
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->savedPasswordExists()Z

    move-result v4

    if-eqz v4, :cond_3

    const-wide/32 v4, 0x40000

    cmp-long v4, v2, v4

    if-eqz v4, :cond_2

    const-wide/32 v4, 0x50000

    cmp-long v4, v2, v4

    if-eqz v4, :cond_2

    const-wide/32 v4, 0x60000

    cmp-long v4, v2, v4

    if-nez v4, :cond_3

    :cond_2
    sget-object v4, Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;->PASSWORD:Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    goto :goto_0

    :cond_3
    sget-object v4, Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;->NONE:Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    goto :goto_0
.end method

.method private isLockPassword(I)Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;
    .locals 10
    .param p1, "userId"    # I

    .prologue
    const-wide/32 v8, 0x20000

    const-wide/16 v6, 0x0

    const-string v3, "lockscreen.password_type"

    invoke-virtual {p0, v3, v6, v7, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLong(Ljava/lang/String;JI)J

    move-result-wide v4

    .local v4, "mode":J
    const-string v3, "lockscreen.password_type_alternate"

    invoke-virtual {p0, v3, v6, v7, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLong(Ljava/lang/String;JI)J

    move-result-wide v0

    .local v0, "backupMode":J
    sget-object v2, Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;->NONE:Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    .local v2, "lockType":Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;
    invoke-virtual {p0, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->savedPasswordExists(I)Z

    move-result v3

    if-eqz v3, :cond_2

    cmp-long v3, v4, v8

    if-eqz v3, :cond_0

    invoke-virtual {p0, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->usingBiometricWeak(I)Z

    move-result v3

    if-eqz v3, :cond_2

    cmp-long v3, v0, v8

    if-nez v3, :cond_2

    :cond_0
    sget-object v2, Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;->PIN:Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    :cond_1
    :goto_0
    return-object v2

    :cond_2
    invoke-virtual {p0, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->savedPasswordExists(I)Z

    move-result v3

    if-eqz v3, :cond_1

    const-wide/32 v6, 0x40000

    cmp-long v3, v4, v6

    if-eqz v3, :cond_3

    const-wide/32 v6, 0x50000

    cmp-long v3, v4, v6

    if-eqz v3, :cond_3

    const-wide/32 v6, 0x60000

    cmp-long v3, v4, v6

    if-nez v3, :cond_1

    :cond_3
    sget-object v2, Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;->PASSWORD:Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    goto :goto_0
.end method

.method private saveLockKnockOn(Ljava/lang/String;II)V
    .locals 25
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "quality"    # I
    .param p3, "userHandle"    # I

    .prologue
    :try_start_0
    invoke-direct/range {p0 .. p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v3

    move-object/from16 v0, p1

    move/from16 v1, p3

    invoke-interface {v3, v0, v1}, Lcom/android/internal/widget/ILockSettingsEx;->setLockKnockOn(Ljava/lang/String;I)V

    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getDevicePolicyManager()Landroid/app/admin/DevicePolicyManager;

    move-result-object v2

    .local v2, "dpm":Landroid/app/admin/DevicePolicyManager;
    if-eqz p1, :cond_5

    if-nez p3, :cond_0

    const/4 v3, 0x1

    const/4 v4, 0x0

    move-object/from16 v0, p0

    invoke-virtual {v0, v3, v4}, Lcom/android/internal/widget/LockPatternUtilsEx;->updateEncryptionPassword(ILjava/lang/String;)V

    :cond_0
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->deleteGallery()V

    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->clearKnockCodeDB()V

    sget v23, Lcom/android/internal/widget/LockPatternUtilsEx;->PASSWORD_QUALITY_KNOCK_ON:I

    .local v23, "knockCodeQuality":I
    const-string v3, "lockscreen.password_type"

    move/from16 v0, p2

    move/from16 v1, v23

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v4

    int-to-long v12, v4

    move-object/from16 v0, p0

    move/from16 v1, p3

    invoke-virtual {v0, v3, v12, v13, v1}, Lcom/android/internal/widget/LockPatternUtilsEx;->setLong(Ljava/lang/String;JI)V

    const/4 v5, 0x0

    .local v5, "letters":I
    const/4 v6, 0x0

    .local v6, "uppercase":I
    const/4 v7, 0x0

    .local v7, "lowercase":I
    const/4 v8, 0x0

    .local v8, "numbers":I
    const/4 v9, 0x0

    .local v9, "symbols":I
    const/4 v10, 0x0

    .local v10, "nonletter":I
    const/16 v22, 0x0

    .local v22, "i":I
    :goto_0
    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v3

    move/from16 v0, v22

    if-ge v0, v3, :cond_4

    move-object/from16 v0, p1

    move/from16 v1, v22

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v21

    .local v21, "c":C
    const/16 v3, 0x41

    move/from16 v0, v21

    if-lt v0, v3, :cond_1

    const/16 v3, 0x5a

    move/from16 v0, v21

    if-gt v0, v3, :cond_1

    add-int/lit8 v5, v5, 0x1

    add-int/lit8 v6, v6, 0x1

    :goto_1
    add-int/lit8 v22, v22, 0x1

    goto :goto_0

    :cond_1
    const/16 v3, 0x61

    move/from16 v0, v21

    if-lt v0, v3, :cond_2

    const/16 v3, 0x7a

    move/from16 v0, v21

    if-gt v0, v3, :cond_2

    add-int/lit8 v5, v5, 0x1

    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    :cond_2
    const/16 v3, 0x30

    move/from16 v0, v21

    if-lt v0, v3, :cond_3

    const/16 v3, 0x39

    move/from16 v0, v21

    if-gt v0, v3, :cond_3

    add-int/lit8 v8, v8, 0x1

    add-int/lit8 v10, v10, 0x1

    goto :goto_1

    :cond_3
    add-int/lit8 v9, v9, 0x1

    add-int/lit8 v10, v10, 0x1

    goto :goto_1

    .end local v21    # "c":C
    :cond_4
    move/from16 v0, p2

    move/from16 v1, v23

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-virtual/range {p1 .. p1}, Ljava/lang/String;->length()I

    move-result v4

    move/from16 v11, p3

    invoke-virtual/range {v2 .. v11}, Landroid/app/admin/DevicePolicyManager;->setActivePasswordState(IIIIIIIII)V

    .end local v2    # "dpm":Landroid/app/admin/DevicePolicyManager;
    .end local v5    # "letters":I
    .end local v6    # "uppercase":I
    .end local v7    # "lowercase":I
    .end local v8    # "numbers":I
    .end local v9    # "symbols":I
    .end local v10    # "nonletter":I
    .end local v22    # "i":I
    .end local v23    # "knockCodeQuality":I
    :goto_2
    return-void

    .restart local v2    # "dpm":Landroid/app/admin/DevicePolicyManager;
    :cond_5
    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    const/16 v17, 0x0

    const/16 v18, 0x0

    const/16 v19, 0x0

    move-object v11, v2

    move/from16 v20, p3

    invoke-virtual/range {v11 .. v20}, Landroid/app/admin/DevicePolicyManager;->setActivePasswordState(IIIIIIIII)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .end local v2    # "dpm":Landroid/app/admin/DevicePolicyManager;
    :catch_0
    move-exception v24

    .local v24, "re":Landroid/os/RemoteException;
    const-string v3, "LockPatternUtilsEx"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Unable to save lock password "

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, v24

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2
.end method


# virtual methods
.method public ResetLockoutAttemptDeadline()V
    .locals 6

    .prologue
    const-wide/16 v0, 0x0

    .local v0, "deadline":J
    const-string v2, "lockscreen.lockoutattemptdeadline"

    const-wide/16 v4, 0x0

    invoke-virtual {p0, v2, v4, v5}, Lcom/android/internal/widget/LockPatternUtilsEx;->setLong(Ljava/lang/String;J)V

    return-void
.end method

.method public changeLockSettingForKidsMode()V
    .locals 10

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    const/4 v7, -0x1

    const/4 v6, -0x2

    iget-object v4, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "Power_button_state"

    invoke-static {v4, v5, v7, v6}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v1

    .local v1, "previousButtonState":I
    if-ne v1, v7, :cond_1

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getPowerButtonInstantlyLocks()Z

    move-result v0

    .local v0, "powerButtonState":Z
    const/4 v3, 0x0

    .local v3, "val":I
    if-eqz v0, :cond_2

    const/4 v3, 0x1

    :goto_0
    iget-object v4, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "Power_button_state"

    invoke-static {v4, v5, v3, v6}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    if-eq v3, v9, :cond_0

    invoke-virtual {p0, v9}, Lcom/android/internal/widget/LockPatternUtilsEx;->setPowerButtonInstantlyLocks(Z)V

    :cond_0
    iget-object v4, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "lock_screen_lock_after_timeout"

    invoke-static {v4, v5, v8, v6}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v2

    .local v2, "previousLockTimeout":I
    iget-object v4, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "lock_screen_lock_after_timeout"

    invoke-static {v4, v5, v8, v6}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    iget-object v4, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "Lock_timeout_before_guest_mode"

    invoke-static {v4, v5, v2, v6}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    .end local v0    # "powerButtonState":Z
    .end local v2    # "previousLockTimeout":I
    .end local v3    # "val":I
    :cond_1
    return-void

    .restart local v0    # "powerButtonState":Z
    .restart local v3    # "val":I
    :cond_2
    const/4 v3, 0x0

    goto :goto_0
.end method

.method public checkBackupPin(Ljava/lang/String;)Z
    .locals 3
    .param p1, "password"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v1

    .local v1, "userId":I
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v2

    invoke-interface {v2, p1, v1}, Lcom/android/internal/widget/ILockSettingsEx;->checkBackupPin(Ljava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const/4 v2, 0x1

    goto :goto_0
.end method

.method public checkBackupPinFile()Z
    .locals 1

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->savedBackupPinExists()Z

    move-result v0

    return v0
.end method

.method public checkKnockOn(Ljava/lang/String;)Z
    .locals 3
    .param p1, "password"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v1

    .local v1, "userId":I
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v2

    invoke-interface {v2, p1, v1}, Lcom/android/internal/widget/ILockSettingsEx;->checkKnockOn(Ljava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const/4 v2, 0x1

    goto :goto_0
.end method

.method public checkPasswordKidsMode(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v1

    .local v1, "userId":I
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v2

    invoke-interface {v2, p1, v1, p2}, Lcom/android/internal/widget/ILockSettingsEx;->checkPasswordKidsMode(Ljava/lang/String;ILjava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const/4 v2, 0x1

    goto :goto_0
.end method

.method public checkPasswords(Ljava/lang/String;)Z
    .locals 3
    .param p1, "passwords"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v1

    .local v1, "userId":I
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v2

    invoke-interface {v2, p1, v1}, Lcom/android/internal/widget/ILockSettingsEx;->checkPasswords(Ljava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const/4 v2, 0x1

    goto :goto_0
.end method

.method public checkPasswordsGetUsers(Ljava/lang/String;)Ljava/util/List;
    .locals 3
    .param p1, "passwords"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Landroid/content/pm/UserInfo;",
            ">;"
        }
    .end annotation

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/android/internal/widget/ILockSettingsEx;->checkPasswordsGetUsers(Ljava/lang/String;)Ljava/util/List;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    new-instance v1, Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    goto :goto_0
.end method

.method public checkPasswordsKidsMode(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p1, "passwords"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v1

    .local v1, "userId":I
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v2

    invoke-interface {v2, p1, v1, p2}, Lcom/android/internal/widget/ILockSettingsEx;->checkPasswordsKidsMode(Ljava/lang/String;ILjava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const/4 v2, 0x1

    goto :goto_0
.end method

.method public checkPatternKidsMode(Ljava/util/List;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/widget/LockPatternView$Cell;",
            ">;)Z"
        }
    .end annotation

    .prologue
    .local p1, "pattern":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/widget/LockPatternView$Cell;>;"
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v1

    .local v1, "userId":I
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v2

    invoke-static {p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->patternToString(Ljava/util/List;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3, v1}, Lcom/android/internal/widget/ILockSettingsEx;->checkPatternKidsMode(Ljava/lang/String;I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    :goto_0
    return v2

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const/4 v2, 0x1

    goto :goto_0
.end method

.method clearKnockCodeDB()V
    .locals 4

    .prologue
    iget-object v0, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "KNOCKON_LOCK_SET"

    const/4 v2, 0x0

    const/4 v3, -0x2

    invoke-static {v0, v1, v2, v3}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    return-void
.end method

.method public clearLock(Z)V
    .locals 4
    .param p1, "isFallback"    # Z

    .prologue
    const/4 v3, -0x2

    const/4 v2, 0x0

    const-string v0, "LockPatternUtilsEx"

    const-string v1, "clearLock()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0, p1}, Lcom/android/internal/widget/LockPatternUtils;->clearLock(Z)V

    iget-object v0, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "KNOCKON_LOCK_SET"

    invoke-static {v0, v1, v2, v3}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    iget-object v0, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "user_knockon_length_change"

    invoke-static {v0, v1, v2, v3}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    iget-object v0, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "KNOCKON_LENGTH_KEY"

    invoke-static {v0, v1, v2, v3}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    invoke-virtual {p0, v2}, Lcom/android/internal/widget/LockPatternUtilsEx;->setDupulicatedKnockCode(Z)V

    return-void
.end method

.method protected finishBiometricWeak()V
    .locals 1

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->isOMADM()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-super {p0}, Lcom/android/internal/widget/LockPatternUtils;->finishBiometricWeak()V

    :cond_0
    return-void
.end method

.method public getCurrentFailedPasswordAttempts(I)I
    .locals 3
    .param p1, "userId"    # I

    .prologue
    const-string v2, "device_policy"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v2

    invoke-static {v2}, Landroid/app/admin/IDevicePolicyManager$Stub;->asInterface(Landroid/os/IBinder;)Landroid/app/admin/IDevicePolicyManager;

    move-result-object v1

    .local v1, "service":Landroid/app/admin/IDevicePolicyManager;
    const/4 v0, 0x0

    .local v0, "attempts":I
    if-eqz v1, :cond_0

    :try_start_0
    invoke-interface {v1, p1}, Landroid/app/admin/IDevicePolicyManager;->getCurrentFailedPasswordAttempts(I)I
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v0

    :cond_0
    :goto_0
    return v0

    :catch_0
    move-exception v2

    goto :goto_0

    :catch_1
    move-exception v2

    goto :goto_0
.end method

.method public getKeyguardStoredPasswordQuality(I)I
    .locals 6
    .param p1, "userId"    # I

    .prologue
    const-wide/32 v4, 0x10000

    const-string v1, "lockscreen.password_type"

    invoke-virtual {p0, v1, v4, v5, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLong(Ljava/lang/String;JI)J

    move-result-wide v2

    long-to-int v0, v2

    .local v0, "quality":I
    const v1, 0x8000

    if-ne v0, v1, :cond_0

    const-string v1, "lockscreen.password_type_alternate"

    invoke-virtual {p0, v1, v4, v5, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLong(Ljava/lang/String;JI)J

    move-result-wide v2

    long-to-int v0, v2

    :cond_0
    return v0
.end method

.method public getLockScreenType()Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;
    .locals 4

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->isLockPattern()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;->PATTERN:Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "KNOCKON_LOCK_SET"

    const/4 v2, 0x0

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentUser()I

    move-result v3

    invoke-static {v0, v1, v2, v3}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    sget-object v0, Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;->KNOCKCODE:Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->isLockPassword()Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    move-result-object v0

    goto :goto_0
.end method

.method public getLockScreenType(I)Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;
    .locals 4
    .param p1, "userId"    # I

    .prologue
    sget-object v0, Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;->NONE:Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    .local v0, "lockType":Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;
    invoke-virtual {p0, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->isLockPattern(I)Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v0, Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;->PATTERN:Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    :goto_0
    return-object v0

    :cond_0
    iget-object v1, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "KNOCKON_LOCK_SET"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3, p1}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_1

    sget-object v0, Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;->KNOCKCODE:Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    goto :goto_0

    :cond_1
    invoke-direct {p0, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->isLockPassword(I)Lcom/android/internal/widget/LockPatternUtilsEx$LockScreenType;

    move-result-object v0

    goto :goto_0
.end method

.method public getOMADMLockCode()Ljava/lang/String;
    .locals 2

    .prologue
    const-string v0, "LockPatternUtilsEx"

    const-string v1, "OMADM getOMADM LockCode"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "lg_omadm_lwmo_lock_code"

    invoke-static {v0, v1}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public isBackupPinforKnockOnEverChosen()Z
    .locals 2

    .prologue
    const-string v0, "lockscreen.backuppinknockoneverchosen"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method public isBackupPinforPatternOnEverChosen()Z
    .locals 2

    .prologue
    const-string v0, "lockscreen.backuppinpatterneverchosen"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method public isDupulicatedKnockCode()Z
    .locals 2

    .prologue
    const-string v0, "lockscreen.knockcode_dupulicated"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method public isDupulicatedKnockCode(I)Z
    .locals 2
    .param p1, "userId"    # I

    .prologue
    const-string v0, "lockscreen.knockcode_dupulicated"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getBoolean(Ljava/lang/String;ZI)Z

    move-result v0

    return v0
.end method

.method public isKnockOnEverChosen()Z
    .locals 2

    .prologue
    const-string v0, "lockscreen.knockoneverchosen"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method public isLockKnockOnEnabled()Z
    .locals 4

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->savedPasswordExists()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "lockscreen.password_type"

    sget v1, Lcom/android/internal/widget/LockPatternUtilsEx;->PASSWORD_QUALITY_KNOCK_ON:I

    int-to-long v2, v1

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    sget v2, Lcom/android/internal/widget/LockPatternUtilsEx;->PASSWORD_QUALITY_KNOCK_ON:I

    int-to-long v2, v2

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isLockPattern()Z
    .locals 8

    .prologue
    const/4 v0, 0x1

    const/4 v4, 0x0

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getKeyguardStoredPasswordQuality()I

    move-result v5

    int-to-long v2, v5

    .local v2, "mode":J
    const-wide/32 v6, 0x10000

    cmp-long v5, v2, v6

    if-nez v5, :cond_0

    move v1, v0

    .local v1, "isPatternMode":Z
    :goto_0
    if-eqz v1, :cond_1

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->isLockPatternEnabled()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->savedPatternExists()Z

    move-result v5

    if-eqz v5, :cond_1

    .local v0, "isPattern":Z
    :goto_1
    return v0

    .end local v0    # "isPattern":Z
    .end local v1    # "isPatternMode":Z
    :cond_0
    move v1, v4

    goto :goto_0

    .restart local v1    # "isPatternMode":Z
    :cond_1
    move v0, v4

    goto :goto_1
.end method

.method public isLockPattern(I)Z
    .locals 8
    .param p1, "userId"    # I

    .prologue
    const/4 v0, 0x1

    const/4 v4, 0x0

    invoke-virtual {p0, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getKeyguardStoredPasswordQuality(I)I

    move-result v5

    int-to-long v2, v5

    .local v2, "mode":J
    const-wide/32 v6, 0x10000

    cmp-long v5, v2, v6

    if-nez v5, :cond_0

    move v1, v0

    .local v1, "isPatternMode":Z
    :goto_0
    if-eqz v1, :cond_1

    invoke-virtual {p0, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->isLockPatternEnabled(I)Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-virtual {p0, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->savedPatternExists(I)Z

    move-result v5

    if-eqz v5, :cond_1

    .local v0, "isPattern":Z
    :goto_1
    return v0

    .end local v0    # "isPattern":Z
    .end local v1    # "isPatternMode":Z
    :cond_0
    move v1, v4

    goto :goto_0

    .restart local v1    # "isPatternMode":Z
    :cond_1
    move v0, v4

    goto :goto_1
.end method

.method protected isLockPatternEnabled(I)Z
    .locals 8
    .param p1, "userId"    # I

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    const-wide/32 v6, 0x10000

    const-string v3, "lockscreen.password_type_alternate"

    invoke-virtual {p0, v3, v6, v7, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLong(Ljava/lang/String;JI)J

    move-result-wide v4

    cmp-long v3, v4, v6

    if-nez v3, :cond_1

    move v0, v1

    .local v0, "backupEnabled":Z
    :goto_0
    const-string v3, "lock_pattern_autolock"

    invoke-virtual {p0, v3, v2, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getBoolean(Ljava/lang/String;ZI)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "lockscreen.password_type"

    invoke-virtual {p0, v3, v6, v7, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLong(Ljava/lang/String;JI)J

    move-result-wide v4

    cmp-long v3, v4, v6

    if-eqz v3, :cond_0

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->usingBiometricWeak()Z

    move-result v3

    if-eqz v3, :cond_2

    if-eqz v0, :cond_2

    :cond_0
    :goto_1
    return v1

    .end local v0    # "backupEnabled":Z
    :cond_1
    move v0, v2

    goto :goto_0

    .restart local v0    # "backupEnabled":Z
    :cond_2
    move v1, v2

    goto :goto_1
.end method

.method public isOMADM()Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    iget-object v2, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "lg_omadm_lwmo_lock_state"

    invoke-static {v2, v3, v1}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    if-ne v2, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method public isSecure()Z
    .locals 1

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->isOMADM()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-super {p0}, Lcom/android/internal/widget/LockPatternUtils;->isSecure()Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public readBackupPin(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "password"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->readBackupPinFile(Ljava/lang/String;)Z

    move-result v0

    .local v0, "check":Z
    if-eqz v0, :cond_0

    .end local p1    # "password":Ljava/lang/String;
    :goto_0
    return-object p1

    .restart local p1    # "password":Ljava/lang/String;
    :cond_0
    const/4 p1, 0x0

    goto :goto_0
.end method

.method public readBackupPinFile(Ljava/lang/String;)Z
    .locals 1
    .param p1, "password"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->checkBackupPin(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public reportFailedPasswordAttempt(I)V
    .locals 2
    .param p1, "userId"    # I

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getDevicePolicyManager()Landroid/app/admin/DevicePolicyManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/app/admin/DevicePolicyManager;->reportFailedPasswordAttempt(I)V

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getTrustManager()Landroid/app/trust/TrustManager;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p1}, Landroid/app/trust/TrustManager;->reportUnlockAttempt(ZI)V

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getTrustManager()Landroid/app/trust/TrustManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/app/trust/TrustManager;->reportRequireCredentialEntry(I)V

    return-void
.end method

.method public reportSuccessfulPasswordAttempt(I)V
    .locals 2
    .param p1, "userId"    # I

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getDevicePolicyManager()Landroid/app/admin/DevicePolicyManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/app/admin/DevicePolicyManager;->reportSuccessfulPasswordAttempt(I)V

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getTrustManager()Landroid/app/trust/TrustManager;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1, p1}, Landroid/app/trust/TrustManager;->reportUnlockAttempt(ZI)V

    return-void
.end method

.method public rollbackLockSettingForNormalMode()V
    .locals 8

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v7, -0x1

    const/4 v6, -0x2

    iget-object v4, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "Power_button_state"

    invoke-static {v4, v5, v7, v6}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v0

    .local v0, "previousButtonState":I
    if-eq v0, v7, :cond_0

    if-ne v0, v2, :cond_1

    :goto_0
    invoke-virtual {p0, v2}, Lcom/android/internal/widget/LockPatternUtilsEx;->setPowerButtonInstantlyLocks(Z)V

    iget-object v2, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v4, "Power_button_state"

    invoke-static {v2, v4, v7, v6}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    iget-object v2, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    new-instance v4, Landroid/content/Intent;

    const-string v5, "com.lge.intent.action.UPDATE_POWER_BUTTON_INSTANT_LOCK"

    invoke-direct {v4, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v4}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    iget-object v2, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v4, "Lock_timeout_before_guest_mode"

    invoke-static {v2, v4, v3, v6}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v1

    .local v1, "previousLockTimeout":I
    iget-object v2, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "lock_screen_lock_after_timeout"

    invoke-static {v2, v3, v1, v6}, Landroid/provider/Settings$Secure;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    .end local v1    # "previousLockTimeout":I
    :cond_0
    return-void

    :cond_1
    move v2, v3

    goto :goto_0
.end method

.method public saveBackupPin(Ljava/lang/String;)V
    .locals 1
    .param p1, "password"    # Ljava/lang/String;

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v0

    invoke-virtual {p0, p1, v0}, Lcom/android/internal/widget/LockPatternUtilsEx;->saveLockBackupPin(Ljava/lang/String;I)V

    return-void
.end method

.method public saveKnockOnPassword(Ljava/lang/String;I)V
    .locals 2
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "quality"    # I

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v0

    invoke-direct {p0, p1, p2, v0}, Lcom/android/internal/widget/LockPatternUtilsEx;->saveLockKnockOn(Ljava/lang/String;II)V

    if-eqz p1, :cond_0

    const-string v0, "lockscreen.knockoneverchosen"

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Lcom/android/internal/widget/LockPatternUtilsEx;->setBoolean(Ljava/lang/String;Z)V

    :cond_0
    return-void
.end method

.method public saveKnockOnPassword(Ljava/lang/String;IZ)V
    .locals 2
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "quality"    # I
    .param p3, "isFallback"    # Z

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v0

    invoke-direct {p0, p1, p2, v0}, Lcom/android/internal/widget/LockPatternUtilsEx;->saveLockKnockOn(Ljava/lang/String;II)V

    if-eqz p1, :cond_0

    const-string v0, "lockscreen.knockoneverchosen"

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Lcom/android/internal/widget/LockPatternUtilsEx;->setBoolean(Ljava/lang/String;Z)V

    :cond_0
    return-void
.end method

.method public saveLockBackupPin(Ljava/lang/String;I)V
    .locals 4
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "userHandle"    # I

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v1

    invoke-interface {v1, p1, p2}, Lcom/android/internal/widget/ILockSettingsEx;->setLockBackupPin(Ljava/lang/String;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const-string v1, "LockPatternUtilsEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to save lock password "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public saveLockPasswordKidsMode(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "password"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v2

    invoke-interface {v1, p1, v2, p2}, Lcom/android/internal/widget/ILockSettingsEx;->setLockPasswordKidsMode(Ljava/lang/String;ILjava/lang/String;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const-string v1, "LockPatternUtilsEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to save lock password "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public saveLockPatternKidsMode(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/widget/LockPatternView$Cell;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "pattern":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/widget/LockPatternView$Cell;>;"
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/android/internal/widget/LockPatternUtilsEx;->saveLockPatternKidsMode(Ljava/util/List;Z)V

    return-void
.end method

.method public saveLockPatternKidsMode(Ljava/util/List;Z)V
    .locals 4
    .param p2, "isFallback"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/widget/LockPatternView$Cell;",
            ">;Z)V"
        }
    .end annotation

    .prologue
    .local p1, "pattern":Ljava/util/List;, "Ljava/util/List<Lcom/android/internal/widget/LockPatternView$Cell;>;"
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v1

    invoke-static {p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->patternToString(Ljava/util/List;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v3

    invoke-interface {v1, v2, v3}, Lcom/android/internal/widget/ILockSettingsEx;->setLockPatternKidsMode(Ljava/lang/String;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const-string v1, "LockPatternUtilsEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Couldn\'t save lock pattern kids mode"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public savedBackupPinExists()Z
    .locals 3

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v2

    invoke-interface {v1, v2}, Lcom/android/internal/widget/ILockSettingsEx;->haveBackupPin(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public savedKidsModeFileExists(Ljava/lang/String;)Z
    .locals 3
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v2

    invoke-interface {v1, v2, p1}, Lcom/android/internal/widget/ILockSettingsEx;->havePasswordKidsMode(ILjava/lang/String;)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method protected savedPasswordExists(I)Z
    .locals 3
    .param p1, "userId"    # I

    .prologue
    const/4 v0, 0x0

    .local v0, "exists":Z
    :try_start_0
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettings()Lcom/android/internal/widget/ILockSettings;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/android/internal/widget/ILockSettings;->havePassword(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "exists":Z
    :goto_0
    return v0

    .restart local v0    # "exists":Z
    :catch_0
    move-exception v1

    .local v1, "re":Landroid/os/RemoteException;
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public savedPatternExists(I)Z
    .locals 3
    .param p1, "userId"    # I

    .prologue
    const/4 v0, 0x0

    .local v0, "exists":Z
    :try_start_0
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettings()Lcom/android/internal/widget/ILockSettings;

    move-result-object v2

    invoke-interface {v2, p1}, Lcom/android/internal/widget/ILockSettings;->havePattern(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .end local v0    # "exists":Z
    :goto_0
    return v0

    .restart local v0    # "exists":Z
    :catch_0
    move-exception v1

    .local v1, "re":Landroid/os/RemoteException;
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public savedPatternKidsModeExists()Z
    .locals 3

    .prologue
    :try_start_0
    invoke-direct {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLockSettingsEx()Lcom/android/internal/widget/ILockSettingsEx;

    move-result-object v1

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v2

    invoke-interface {v1, v2}, Lcom/android/internal/widget/ILockSettingsEx;->havePatternKidsMode(I)Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setBackupPinforKnockOnEverChosen(Z)V
    .locals 1
    .param p1, "enabled"    # Z

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v0

    invoke-virtual {p0, p1, v0}, Lcom/android/internal/widget/LockPatternUtilsEx;->setBackupPinforKnockOnEverChosen(ZI)V

    return-void
.end method

.method public setBackupPinforKnockOnEverChosen(ZI)V
    .locals 1
    .param p1, "enabled"    # Z
    .param p2, "userId"    # I

    .prologue
    const-string v0, "lockscreen.backuppinknockoneverchosen"

    invoke-virtual {p0, v0, p1, p2}, Lcom/android/internal/widget/LockPatternUtilsEx;->setBoolean(Ljava/lang/String;ZI)V

    return-void
.end method

.method public setBackupPinforPatternOnEverChosen(Z)V
    .locals 1
    .param p1, "enabled"    # Z

    .prologue
    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->getCurrentOrCallingUserId()I

    move-result v0

    invoke-virtual {p0, p1, v0}, Lcom/android/internal/widget/LockPatternUtilsEx;->setBackupPinforPatternOnEverChosen(ZI)V

    return-void
.end method

.method public setBackupPinforPatternOnEverChosen(ZI)V
    .locals 1
    .param p1, "enabled"    # Z
    .param p2, "userId"    # I

    .prologue
    const-string v0, "lockscreen.backuppinpatterneverchosen"

    invoke-virtual {p0, v0, p1, p2}, Lcom/android/internal/widget/LockPatternUtilsEx;->setBoolean(Ljava/lang/String;ZI)V

    return-void
.end method

.method public setDupulicatedKnockCode(Z)V
    .locals 1
    .param p1, "enabled"    # Z

    .prologue
    const-string v0, "lockscreen.knockcode_dupulicated"

    invoke-virtual {p0, v0, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->setBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method public setDupulicatedKnockCode(ZI)V
    .locals 1
    .param p1, "enabled"    # Z
    .param p2, "userId"    # I

    .prologue
    const-string v0, "lockscreen.knockcode_dupulicated"

    invoke-virtual {p0, v0, p1, p2}, Lcom/android/internal/widget/LockPatternUtilsEx;->setBoolean(Ljava/lang/String;ZI)V

    return-void
.end method

.method public setOMADMPolicy()V
    .locals 3

    .prologue
    const-string v0, "LockPatternUtilsEx"

    const-string v1, "OMADM setOMADMPolicy"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "lg_omadm_lwmo_lock_code"

    invoke-static {v0, v1}, Landroid/provider/Settings$System;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/high16 v1, 0x20000

    const/4 v2, 0x1

    invoke-virtual {p0, v0, v1, v2}, Lcom/android/internal/widget/LockPatternUtilsEx;->saveLockPassword(Ljava/lang/String;IZ)V

    return-void
.end method

.method public setPolicy()V
    .locals 4

    .prologue
    const-string v0, "LockPatternUtilsEx"

    const-string v1, "OMADM setPolicy"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "lockscreen.password_type"

    const-wide/16 v2, 0x0

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/internal/widget/LockPatternUtilsEx;->setLong(Ljava/lang/String;J)V

    return-void
.end method

.method public setTactileFeedbackEnabled(Z)V
    .locals 4
    .param p1, "enabled"    # Z

    .prologue
    iget-object v0, p0, Lcom/android/internal/widget/LockPatternUtilsEx;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "haptic_feedback_enabled"

    if-eqz p1, :cond_0

    const/4 v0, 0x1

    :goto_0
    const/4 v3, -0x2

    invoke-static {v1, v2, v0, v3}, Landroid/provider/Settings$System;->putIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public updateEmergencyCallButtonState(Landroid/widget/Button;ZII)V
    .locals 2
    .param p1, "button"    # Landroid/widget/Button;
    .param p2, "shown"    # Z
    .param p3, "textId"    # I
    .param p4, "iconId"    # I

    .prologue
    const/4 v1, 0x0

    invoke-virtual {p0}, Lcom/android/internal/widget/LockPatternUtilsEx;->isEmergencyCallCapable()Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p2, :cond_0

    invoke-virtual {p1, v1}, Landroid/widget/Button;->setVisibility(I)V

    invoke-virtual {p1, p4, v1, v1, v1}, Landroid/widget/Button;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    invoke-virtual {p1, p3}, Landroid/widget/Button;->setText(I)V

    :goto_0
    return-void

    :cond_0
    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    goto :goto_0
.end method

.method protected usingBiometricWeak(I)Z
    .locals 4
    .param p1, "userId"    # I

    .prologue
    const-string v1, "lockscreen.password_type"

    const-wide/32 v2, 0x10000

    invoke-virtual {p0, v1, v2, v3, p1}, Lcom/android/internal/widget/LockPatternUtilsEx;->getLong(Ljava/lang/String;JI)J

    move-result-wide v2

    long-to-int v0, v2

    .local v0, "quality":I
    const v1, 0x8000

    if-ne v0, v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method
