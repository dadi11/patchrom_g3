.class public Lcom/lge/uicc/framework/RilHook;
.super Landroid/os/Handler;
.source "RilHook.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/uicc/framework/RilHook$HookIccPin;,
        Lcom/lge/uicc/framework/RilHook$Hook;
    }
.end annotation


# static fields
.field private static final HOOK_MSG:I = 0x1

.field private static final LOGHEAD:Ljava/lang/String; = "[RilHook] "

.field private static mInstances:[Lcom/lge/uicc/framework/RilHook;


# instance fields
.field final RESPONSE_GENERIC_FAILURE:Lcom/android/internal/telephony/CommandException;

.field private mSlotId:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/lge/uicc/framework/RilHook;->mInstances:[Lcom/lge/uicc/framework/RilHook;

    return-void
.end method

.method private constructor <init>(I)V
    .locals 2
    .param p1, "slot"    # I

    .prologue
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/uicc/framework/RilHook;->mSlotId:I

    new-instance v0, Lcom/android/internal/telephony/CommandException;

    sget-object v1, Lcom/android/internal/telephony/CommandException$Error;->GENERIC_FAILURE:Lcom/android/internal/telephony/CommandException$Error;

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/CommandException;-><init>(Lcom/android/internal/telephony/CommandException$Error;)V

    iput-object v0, p0, Lcom/lge/uicc/framework/RilHook;->RESPONSE_GENERIC_FAILURE:Lcom/android/internal/telephony/CommandException;

    iput p1, p0, Lcom/lge/uicc/framework/RilHook;->mSlotId:I

    return-void
.end method

.method static synthetic access$000(Lcom/lge/uicc/framework/RilHook;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/uicc/framework/RilHook;

    .prologue
    iget v0, p0, Lcom/lge/uicc/framework/RilHook;->mSlotId:I

    return v0
.end method

.method static synthetic access$100(Lcom/lge/uicc/framework/RilHook;Ljava/lang/String;ZI)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/uicc/framework/RilHook;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # Z
    .param p3, "x3"    # I

    .prologue
    invoke-direct {p0, p1, p2, p3}, Lcom/lge/uicc/framework/RilHook;->updateRemainingCount(Ljava/lang/String;ZI)V

    return-void
.end method

.method private discardRilCommand(Landroid/os/Message;)Landroid/os/Message;
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v1, 0x0

    iget-object v0, p0, Lcom/lge/uicc/framework/RilHook;->RESPONSE_GENERIC_FAILURE:Lcom/android/internal/telephony/CommandException;

    invoke-static {p1, v1, v0}, Landroid/os/AsyncResult;->forMessage(Landroid/os/Message;Ljava/lang/Object;Ljava/lang/Throwable;)Landroid/os/AsyncResult;

    invoke-virtual {p1}, Landroid/os/Message;->sendToTarget()V

    const/4 v0, 0x0

    invoke-static {v1, v0}, Landroid/os/Message;->obtain(Landroid/os/Handler;I)Landroid/os/Message;

    move-result-object v0

    return-object v0
.end method

.method public static getInstance(I)Lcom/lge/uicc/framework/RilHook;
    .locals 1
    .param p0, "slot"    # I

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/RilHook;->mInstances:[Lcom/lge/uicc/framework/RilHook;

    aget-object v0, v0, p0

    return-object v0
.end method

.method private isCaller(Ljava/lang/Class;)Z
    .locals 5
    .param p1, "target"    # Ljava/lang/Class;

    .prologue
    const/4 v3, 0x0

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Thread;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v2

    .local v2, "stack":[Ljava/lang/StackTraceElement;
    const/4 v1, 0x4

    .local v1, "s":I
    :goto_0
    array-length v4, v2

    if-ge v1, v4, :cond_0

    aget-object v4, v2, v1

    invoke-virtual {v4}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v0

    .local v0, "cls":Ljava/lang/String;
    const-string v4, "com.lge.uicc"

    invoke-virtual {v0, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_0

    const-string v4, "java.lang"

    invoke-virtual {v0, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    .end local v0    # "cls":Ljava/lang/String;
    :cond_0
    :goto_1
    return v3

    .restart local v0    # "cls":Ljava/lang/String;
    :cond_1
    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    const/4 v3, 0x1

    goto :goto_1

    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method public static isDiscarded(Landroid/os/Message;)Z
    .locals 1
    .param p0, "msg"    # Landroid/os/Message;

    .prologue
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/os/Message;->getTarget()Landroid/os/Handler;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected static setup()V
    .locals 4

    .prologue
    sget-object v2, Lcom/lge/uicc/framework/RilHook;->mInstances:[Lcom/lge/uicc/framework/RilHook;

    if-nez v2, :cond_0

    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->getSlots()I

    move-result v1

    .local v1, "slots":I
    new-array v2, v1, [Lcom/lge/uicc/framework/RilHook;

    sput-object v2, Lcom/lge/uicc/framework/RilHook;->mInstances:[Lcom/lge/uicc/framework/RilHook;

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v1, :cond_0

    sget-object v2, Lcom/lge/uicc/framework/RilHook;->mInstances:[Lcom/lge/uicc/framework/RilHook;

    new-instance v3, Lcom/lge/uicc/framework/RilHook;

    invoke-direct {v3, v0}, Lcom/lge/uicc/framework/RilHook;-><init>(I)V

    aput-object v3, v2, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method private updateRemainingCount(Ljava/lang/String;ZI)V
    .locals 11
    .param p1, "pin_type"    # Ljava/lang/String;
    .param p2, "blocked"    # Z
    .param p3, "remain"    # I

    .prologue
    invoke-static {p3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v7

    .local v7, "remainCount":Ljava/lang/String;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "updateRemainingCount : "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    if-eqz p2, :cond_0

    const-string v8, "PUK"

    :goto_0
    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " of "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " : remain="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    invoke-static {}, Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;->values()[Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;

    move-result-object v2

    .local v2, "arr$":[Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;
    array-length v5, v2

    .local v5, "len$":I
    const/4 v3, 0x0

    .local v3, "i$":I
    :goto_1
    if-ge v3, v5, :cond_3

    aget-object v1, v2, v3

    .local v1, "app_type":Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;
    invoke-virtual {v1}, Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;->toString()Ljava/lang/String;

    move-result-object v8

    const-string v9, "APPTYPE_"

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {v8, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    .local v0, "app":Ljava/lang/String;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "."

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .local v4, "key":Ljava/lang/String;
    iget v8, p0, Lcom/lge/uicc/framework/RilHook;->mSlotId:I

    invoke-static {v4, v8}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v8

    const-string v9, "/"

    invoke-virtual {v8, v9}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v6

    .local v6, "pinData":[Ljava/lang/String;
    array-length v8, v6

    const/4 v9, 0x3

    if-eq v8, v9, :cond_1

    :goto_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .end local v0    # "app":Ljava/lang/String;
    .end local v1    # "app_type":Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;
    .end local v2    # "arr$":[Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;
    .end local v3    # "i$":I
    .end local v4    # "key":Ljava/lang/String;
    .end local v5    # "len$":I
    .end local v6    # "pinData":[Ljava/lang/String;
    :cond_0
    const-string v8, "PIN"

    goto :goto_0

    .restart local v0    # "app":Ljava/lang/String;
    .restart local v1    # "app_type":Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;
    .restart local v2    # "arr$":[Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;
    .restart local v3    # "i$":I
    .restart local v4    # "key":Ljava/lang/String;
    .restart local v5    # "len$":I
    .restart local v6    # "pinData":[Ljava/lang/String;
    :cond_1
    if-eqz p2, :cond_2

    const/4 v8, 0x2

    aput-object v7, v6, v8

    :goto_3
    iget v8, p0, Lcom/lge/uicc/framework/RilHook;->mSlotId:I

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v10, 0x0

    aget-object v10, v6, v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "/"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const/4 v10, 0x1

    aget-object v10, v6, v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "/"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const/4 v10, 0x2

    aget-object v10, v6, v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v4, v8, v9}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;

    goto :goto_2

    :cond_2
    const/4 v8, 0x1

    aput-object v7, v6, v8

    goto :goto_3

    .end local v0    # "app":Ljava/lang/String;
    .end local v1    # "app_type":Lcom/android/internal/telephony/uicc/IccCardApplicationStatus$AppType;
    .end local v4    # "key":Ljava/lang/String;
    .end local v6    # "pinData":[Ljava/lang/String;
    :cond_3
    return-void
.end method


# virtual methods
.method public handleChangeIccPin2ForApp(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)Landroid/os/Message;
    .locals 7
    .param p1, "oldPin2"    # Ljava/lang/String;
    .param p2, "newPin2"    # Ljava/lang/String;
    .param p3, "aid"    # Ljava/lang/String;
    .param p4, "result"    # Landroid/os/Message;

    .prologue
    const-string v0, "handleChangeIccPin2ForApp"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    new-instance v0, Lcom/lge/uicc/framework/RilHook$HookIccPin;

    const-string v2, "pin2"

    const/4 v3, 0x0

    move-object v1, p0

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    invoke-direct/range {v0 .. v6}, Lcom/lge/uicc/framework/RilHook$HookIccPin;-><init>(Lcom/lge/uicc/framework/RilHook;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->obtainHookMessage(Lcom/lge/uicc/framework/RilHook$Hook;)Landroid/os/Message;

    move-result-object v0

    return-object v0
.end method

.method public handleChangeIccPinForApp(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)Landroid/os/Message;
    .locals 7
    .param p1, "oldPin"    # Ljava/lang/String;
    .param p2, "newPin"    # Ljava/lang/String;
    .param p3, "aid"    # Ljava/lang/String;
    .param p4, "result"    # Landroid/os/Message;

    .prologue
    const-string v0, "handleChangeIccPinForApp"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    new-instance v0, Lcom/lge/uicc/framework/RilHook$HookIccPin;

    const-string v2, "pin1"

    const/4 v3, 0x0

    move-object v1, p0

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    invoke-direct/range {v0 .. v6}, Lcom/lge/uicc/framework/RilHook$HookIccPin;-><init>(Lcom/lge/uicc/framework/RilHook;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->obtainHookMessage(Lcom/lge/uicc/framework/RilHook$Hook;)Landroid/os/Message;

    move-result-object v0

    return-object v0
.end method

.method public handleGetIMSIForApp(Ljava/lang/String;Landroid/os/Message;)Landroid/os/Message;
    .locals 1
    .param p1, "aid"    # Ljava/lang/String;
    .param p2, "result"    # Landroid/os/Message;

    .prologue
    invoke-static {}, Lcom/lge/uicc/framework/IccTools;->isMultiSimEnabled()Z

    move-result v0

    if-nez v0, :cond_0

    iget v0, p0, Lcom/lge/uicc/framework/RilHook;->mSlotId:I

    if-nez v0, :cond_0

    invoke-static {p1, p2}, Lcom/lge/uicc/framework/ImsiHandler;->handleGetImsiForApp(Ljava/lang/String;Landroid/os/Message;)Landroid/os/Message;

    move-result-object p2

    :cond_0
    return-object p2
.end method

.method public handleGetIccCardStatus(Landroid/os/Message;)Landroid/os/Message;
    .locals 1
    .param p1, "result"    # Landroid/os/Message;

    .prologue
    iget v0, p0, Lcom/lge/uicc/framework/RilHook;->mSlotId:I

    invoke-static {v0, p1}, Lcom/lge/uicc/framework/IccStateHandler;->handleGetIccCardStatus(ILandroid/os/Message;)Landroid/os/Message;

    move-result-object v0

    return-object v0
.end method

.method public handleIccIOForApp(IILjava/lang/String;IIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)Landroid/os/Message;
    .locals 8
    .param p1, "command"    # I
    .param p2, "fileid"    # I
    .param p3, "path"    # Ljava/lang/String;
    .param p4, "p1"    # I
    .param p5, "p2"    # I
    .param p6, "p3"    # I
    .param p7, "data"    # Ljava/lang/String;
    .param p8, "pin2"    # Ljava/lang/String;
    .param p9, "aid"    # Ljava/lang/String;
    .param p10, "result"    # Landroid/os/Message;

    .prologue
    const/16 v2, 0xb0

    .local v2, "COMMAND_READ_BINARY":I
    const/16 v1, 0xc0

    .local v1, "COMMAND_GET_RESPONSE":I
    if-eqz p10, :cond_0

    const/16 v3, 0xc0

    if-ne p1, v3, :cond_0

    sparse-switch p2, :sswitch_data_0

    :cond_0
    if-eqz p10, :cond_1

    const/16 v3, 0xb0

    if-ne p1, v3, :cond_1

    packed-switch p2, :pswitch_data_0

    .end local p10    # "result":Landroid/os/Message;
    :cond_1
    :goto_0
    return-object p10

    .restart local p10    # "result":Landroid/os/Message;
    :sswitch_0
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/String;

    const/4 v4, 0x0

    const-string v5, "SKT"

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const-string v5, "KT"

    aput-object v5, v3, v4

    invoke-static {v3}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    const-class v3, Lcom/android/internal/telephony/uicc/SIMRecords;

    invoke-direct {p0, v3}, Lcom/lge/uicc/framework/RilHook;->isCaller(Ljava/lang/Class;)Z

    move-result v3

    if-eqz v3, :cond_0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "discard command: ef="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "%x"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v5, v6

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    move-object/from16 v0, p10

    invoke-direct {p0, v0}, Lcom/lge/uicc/framework/RilHook;->discardRilCommand(Landroid/os/Message;)Landroid/os/Message;

    move-result-object p10

    goto :goto_0

    :sswitch_1
    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/String;

    const/4 v4, 0x0

    const-string v5, "SKT"

    aput-object v5, v3, v4

    invoke-static {v3}, Lcom/lge/uicc/framework/LGUICC;->targetOperator([Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    const-class v3, Lcom/android/internal/telephony/uicc/SIMRecords;

    invoke-direct {p0, v3}, Lcom/lge/uicc/framework/RilHook;->isCaller(Ljava/lang/Class;)Z

    move-result v3

    if-eqz v3, :cond_0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "discard command: ef="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "%x"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v5, v6

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    move-object/from16 v0, p10

    invoke-direct {p0, v0}, Lcom/lge/uicc/framework/RilHook;->discardRilCommand(Landroid/os/Message;)Landroid/os/Message;

    move-result-object p10

    goto/16 :goto_0

    :pswitch_0
    new-instance v3, Lcom/lge/uicc/framework/RilHook$1;

    move-object/from16 v0, p10

    invoke-direct {v3, p0, v0}, Lcom/lge/uicc/framework/RilHook$1;-><init>(Lcom/lge/uicc/framework/RilHook;Landroid/os/Message;)V

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/RilHook;->obtainHookMessage(Lcom/lge/uicc/framework/RilHook$Hook;)Landroid/os/Message;

    move-result-object p10

    goto/16 :goto_0

    :sswitch_data_0
    .sparse-switch
        0x6f11 -> :sswitch_0
        0x6fca -> :sswitch_0
        0x6fcb -> :sswitch_1
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x2fe2
        :pswitch_0
    .end packed-switch
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 6
    .param p1, "hookmsg"    # Landroid/os/Message;

    .prologue
    iget v4, p1, Landroid/os/Message;->what:I

    packed-switch v4, :pswitch_data_0

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    :try_start_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v2, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v2, Lcom/lge/uicc/framework/RilHook$Hook;

    .local v2, "h":Lcom/lge/uicc/framework/RilHook$Hook;
    if-nez v2, :cond_1

    const-string v4, "unknown message!!"

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/RilHook;->loge(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .end local v0    # "ar":Landroid/os/AsyncResult;
    .end local v2    # "h":Lcom/lge/uicc/framework/RilHook$Hook;
    :catch_0
    move-exception v1

    .local v1, "exc":Ljava/lang/RuntimeException;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Exception handling Result: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/RilHook;->loge(Ljava/lang/String;)V

    goto :goto_0

    .end local v1    # "exc":Ljava/lang/RuntimeException;
    .restart local v0    # "ar":Landroid/os/AsyncResult;
    .restart local v2    # "h":Lcom/lge/uicc/framework/RilHook$Hook;
    :cond_1
    :try_start_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ".handleResult()"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Lcom/lge/uicc/framework/RilHook$Hook;->handleResult(Landroid/os/AsyncResult;)Landroid/os/Message;

    move-result-object v3

    .local v3, "msg":Landroid/os/Message;
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Landroid/os/Message;->sendToTarget()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method

.method public handleSetFacilityLockForApp(Ljava/lang/String;ZLjava/lang/String;ILjava/lang/String;Landroid/os/Message;)Landroid/os/Message;
    .locals 7
    .param p1, "facility"    # Ljava/lang/String;
    .param p2, "lockState"    # Z
    .param p3, "password"    # Ljava/lang/String;
    .param p4, "serviceClass"    # I
    .param p5, "appId"    # Ljava/lang/String;
    .param p6, "response"    # Landroid/os/Message;

    .prologue
    const/4 v2, 0x0

    const-string v0, "handleSetFacilityLockForApp"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    const-string v0, "SC"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "usim.pin1"

    iget v1, p0, Lcom/lge/uicc/framework/RilHook;->mSlotId:I

    invoke-static {v0, v1}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    aget-object v0, v0, v2

    const-string v1, "ENABLED_BLOCKED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    .local v3, "blocked":Z
    new-instance v0, Lcom/lge/uicc/framework/RilHook$HookIccPin;

    const-string v2, "pin1"

    move-object v1, p0

    move-object v4, p3

    move-object v5, p5

    move-object v6, p6

    invoke-direct/range {v0 .. v6}, Lcom/lge/uicc/framework/RilHook$HookIccPin;-><init>(Lcom/lge/uicc/framework/RilHook;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->obtainHookMessage(Lcom/lge/uicc/framework/RilHook$Hook;)Landroid/os/Message;

    move-result-object p6

    .end local v3    # "blocked":Z
    .end local p6    # "response":Landroid/os/Message;
    :cond_0
    :goto_0
    return-object p6

    .restart local p6    # "response":Landroid/os/Message;
    :cond_1
    const-string v0, "FD"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "usim.pin2"

    iget v1, p0, Lcom/lge/uicc/framework/RilHook;->mSlotId:I

    invoke-static {v0, v1}, Lcom/lge/uicc/framework/LGUICC;->getConfig(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    aget-object v0, v0, v2

    const-string v1, "ENABLED_BLOCKED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    .restart local v3    # "blocked":Z
    new-instance v0, Lcom/lge/uicc/framework/RilHook$HookIccPin;

    const-string v2, "pin2"

    move-object v1, p0

    move-object v4, p3

    move-object v5, p5

    move-object v6, p6

    invoke-direct/range {v0 .. v6}, Lcom/lge/uicc/framework/RilHook$HookIccPin;-><init>(Lcom/lge/uicc/framework/RilHook;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->obtainHookMessage(Lcom/lge/uicc/framework/RilHook$Hook;)Landroid/os/Message;

    move-result-object p6

    goto :goto_0
.end method

.method public handleSupplyIccPin2ForApp(Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)Landroid/os/Message;
    .locals 7
    .param p1, "pin"    # Ljava/lang/String;
    .param p2, "aid"    # Ljava/lang/String;
    .param p3, "result"    # Landroid/os/Message;

    .prologue
    const-string v0, "handleSupplyIccPin2ForApp"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    new-instance v0, Lcom/lge/uicc/framework/RilHook$HookIccPin;

    const-string v2, "pin2"

    const/4 v3, 0x0

    move-object v1, p0

    move-object v4, p1

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v0 .. v6}, Lcom/lge/uicc/framework/RilHook$HookIccPin;-><init>(Lcom/lge/uicc/framework/RilHook;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->obtainHookMessage(Lcom/lge/uicc/framework/RilHook$Hook;)Landroid/os/Message;

    move-result-object v0

    return-object v0
.end method

.method public handleSupplyIccPinForApp(Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)Landroid/os/Message;
    .locals 7
    .param p1, "pin"    # Ljava/lang/String;
    .param p2, "aid"    # Ljava/lang/String;
    .param p3, "result"    # Landroid/os/Message;

    .prologue
    const-string v0, "handleSupplyIccPinForApp"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    new-instance v0, Lcom/lge/uicc/framework/RilHook$HookIccPin;

    const-string v2, "pin1"

    const/4 v3, 0x0

    move-object v1, p0

    move-object v4, p1

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v0 .. v6}, Lcom/lge/uicc/framework/RilHook$HookIccPin;-><init>(Lcom/lge/uicc/framework/RilHook;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->obtainHookMessage(Lcom/lge/uicc/framework/RilHook$Hook;)Landroid/os/Message;

    move-result-object v0

    return-object v0
.end method

.method public handleSupplyIccPuk2ForApp(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)Landroid/os/Message;
    .locals 7
    .param p1, "puk"    # Ljava/lang/String;
    .param p2, "newPin2"    # Ljava/lang/String;
    .param p3, "aid"    # Ljava/lang/String;
    .param p4, "result"    # Landroid/os/Message;

    .prologue
    const-string v0, "handleSupplyIccPuk2ForApp"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    new-instance v0, Lcom/lge/uicc/framework/RilHook$HookIccPin;

    const-string v2, "pin2"

    const/4 v3, 0x1

    move-object v1, p0

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    invoke-direct/range {v0 .. v6}, Lcom/lge/uicc/framework/RilHook$HookIccPin;-><init>(Lcom/lge/uicc/framework/RilHook;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->obtainHookMessage(Lcom/lge/uicc/framework/RilHook$Hook;)Landroid/os/Message;

    move-result-object v0

    return-object v0
.end method

.method public handleSupplyIccPukForApp(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)Landroid/os/Message;
    .locals 7
    .param p1, "puk"    # Ljava/lang/String;
    .param p2, "newPin"    # Ljava/lang/String;
    .param p3, "aid"    # Ljava/lang/String;
    .param p4, "result"    # Landroid/os/Message;

    .prologue
    const-string v0, "handleSupplyIccPukForApp"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->logd(Ljava/lang/String;)V

    new-instance v0, Lcom/lge/uicc/framework/RilHook$HookIccPin;

    const-string v2, "pin1"

    const/4 v3, 0x1

    move-object v1, p0

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    invoke-direct/range {v0 .. v6}, Lcom/lge/uicc/framework/RilHook$HookIccPin;-><init>(Lcom/lge/uicc/framework/RilHook;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/RilHook;->obtainHookMessage(Lcom/lge/uicc/framework/RilHook$Hook;)Landroid/os/Message;

    move-result-object v0

    return-object v0
.end method

.method protected logd(Ljava/lang/String;)V
    .locals 2
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[RilHook] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logd(Ljava/lang/String;)V

    return-void
.end method

.method protected loge(Ljava/lang/String;)V
    .locals 2
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[RilHook] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->loge(Ljava/lang/String;)V

    return-void
.end method

.method protected logp(Ljava/lang/String;)V
    .locals 2
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[RilHook] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/uicc/framework/LGUICC;->logp(Ljava/lang/String;)V

    return-void
.end method

.method protected obtainHookMessage(Lcom/lge/uicc/framework/RilHook$Hook;)Landroid/os/Message;
    .locals 1
    .param p1, "h"    # Lcom/lge/uicc/framework/RilHook$Hook;

    .prologue
    const/4 v0, 0x1

    invoke-virtual {p0, v0, p1}, Lcom/lge/uicc/framework/RilHook;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    return-object v0
.end method
