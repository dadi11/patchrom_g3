.class Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;
.super Lcom/android/internal/util/State;
.source "LgeFDHandlerInterfaceImpl.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DchFachState"
.end annotation


# instance fields
.field mFDTriggered:Z

.field mIdleDuration:I

.field final synthetic this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;


# direct methods
.method private constructor <init>(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 1080
    iput-object p1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    .line 1082
    iput v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    .line 1083
    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mFDTriggered:Z

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;
    .param p2, "x1"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;

    .prologue
    .line 1080
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;-><init>(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)V

    return-void
.end method

.method static synthetic access$400(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;

    .prologue
    .line 1080
    invoke-direct {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->triggerGoDormant()Z

    move-result v0

    return v0
.end method

.method private getCommandByteArray(I)[B
    .locals 5
    .param p1, "cmd_id"    # I

    .prologue
    const/16 v4, 0x4d

    const/4 v3, 0x0

    .line 1087
    const/16 v0, 0x10

    new-array v0, v0, [B

    const/16 v1, 0x51

    aput-byte v1, v0, v3

    const/4 v1, 0x1

    const/16 v2, 0x55

    aput-byte v2, v0, v1

    const/4 v1, 0x2

    const/16 v2, 0x41

    aput-byte v2, v0, v1

    const/4 v1, 0x3

    const/16 v2, 0x4c

    aput-byte v2, v0, v1

    const/4 v1, 0x4

    const/16 v2, 0x43

    aput-byte v2, v0, v1

    const/4 v1, 0x5

    const/16 v2, 0x4f

    aput-byte v2, v0, v1

    const/4 v1, 0x6

    aput-byte v4, v0, v1

    const/4 v1, 0x7

    aput-byte v4, v0, v1

    const/16 v1, 0x8

    int-to-byte v2, p1

    aput-byte v2, v0, v1

    const/16 v1, 0x9

    ushr-int/lit8 v2, p1, 0x8

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    const/16 v1, 0xa

    ushr-int/lit8 v2, p1, 0x10

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    const/16 v1, 0xb

    ushr-int/lit8 v2, p1, 0x18

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    const/16 v1, 0xc

    aput-byte v3, v0, v1

    const/16 v1, 0xd

    aput-byte v3, v0, v1

    const/16 v1, 0xe

    aput-byte v3, v0, v1

    const/16 v1, 0xf

    aput-byte v3, v0, v1

    return-object v0
.end method

.method private triggerGoDormant()Z
    .locals 9

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x1

    .line 1105
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->isUMTS()Z

    move-result v5

    if-nez v5, :cond_0

    .line 1106
    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v5, "triggerGoDormant(): skip triggering since the attached network is non-3G"

    invoke-virtual {v4, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1133
    :goto_0
    return v3

    .line 1110
    :cond_0
    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v5, v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mQcRilHookObject:Ljava/lang/Object;

    if-eqz v5, :cond_1

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v5, v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mQcRilGoDormantFunc:Ljava/lang/reflect/Method;

    if-eqz v5, :cond_1

    .line 1112
    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v5, "triggerGoDormant() using qcRilGoDormant with GO_DORMANT_INTERFACE_ALL"

    invoke-virtual {v3, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1115
    :try_start_0
    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v3, v3, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mQcRilGoDormantFunc:Ljava/lang/reflect/Method;

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v5, v5, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mQcRilHookObject:Ljava/lang/Object;

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    const-string v8, ""

    aput-object v8, v6, v7

    invoke-virtual {v3, v5, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    .line 1116
    .local v2, "ret":Ljava/lang/Boolean;
    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    goto :goto_0

    .line 1117
    .end local v2    # "ret":Ljava/lang/Boolean;
    :catch_0
    move-exception v1

    .line 1118
    .local v1, "e":Ljava/lang/Exception;
    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "triggerGoDormant(): Failed to call qcRilGoDormant() : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->loge(Ljava/lang/String;)V

    move v3, v4

    .line 1133
    goto :goto_0

    .line 1121
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_1
    const v4, 0x80003

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->getCommandByteArray(I)[B

    move-result-object v0

    .line 1123
    .local v0, "cmd":[B
    :try_start_1
    new-instance v4, Ljava/lang/String;

    const-string v5, "UTF8"

    invoke-direct {v4, v0, v5}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_1

    .line 1127
    :goto_1
    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v5, "triggerGoDormant(): trigger Fast Dormancy"

    invoke-virtual {v4, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1130
    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v4, v4, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const v6, 0x18c4d

    invoke-virtual {v5, v6}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->obtainMessage(I)Landroid/os/Message;

    move-result-object v5

    invoke-interface {v4, v0, v5}, Lcom/android/internal/telephony/CommandsInterface;->invokeOemRilRequestRaw([BLandroid/os/Message;)V

    goto :goto_0

    .line 1124
    :catch_1
    move-exception v1

    .line 1125
    .local v1, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    goto :goto_1
.end method


# virtual methods
.method public enter()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 1162
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v1, "Enter to DCH or FACH State"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1164
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->isUMTS()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1165
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    # getter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUnknownState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;
    invoke-static {v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$800(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;

    move-result-object v1

    # invokes: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$1500(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/util/IState;)V

    .line 1168
    :cond_0
    iput v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    .line 1169
    iput-boolean v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mFDTriggered:Z

    .line 1170
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDRetryManager:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;->resetCount()V

    .line 1171
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->scheduleCheckNetStat()V

    .line 1172
    return-void
.end method

.method public exit()V
    .locals 2

    .prologue
    .line 1176
    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v1, "Exit from DCH or FACH State"

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1177
    return-void
.end method

.method isDial()Z
    .locals 2

    .prologue
    .line 1138
    const/4 v0, 0x0

    .line 1140
    .local v0, "fast_dorm_ok":Z
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    if-eqz v1, :cond_1

    .line 1141
    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getForegroundCall()Lcom/android/internal/telephony/Call;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call$State;->isDialing()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getBackgroundCall()Lcom/android/internal/telephony/Call;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call$State;->isDialing()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getRingingCall()Lcom/android/internal/telephony/Call;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call$State;->isDialing()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getForegroundCall()Lcom/android/internal/telephony/Call;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call$State;->isRinging()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getBackgroundCall()Lcom/android/internal/telephony/Call;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call$State;->isRinging()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mP:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getRingingCall()Lcom/android/internal/telephony/Call;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v1

    invoke-virtual {v1}, Lcom/android/internal/telephony/Call$State;->isRinging()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1148
    :cond_0
    const/4 v0, 0x1

    .line 1151
    :cond_1
    return v0
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 10
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const-wide/16 v8, 0x3e8

    const/4 v6, 0x0

    const/4 v5, 0x1

    .line 1183
    iget v2, p1, Landroid/os/Message;->what:I

    sparse-switch v2, :sswitch_data_0

    .line 1312
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Expected Event Received : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p1, Landroid/os/Message;->what:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1317
    :cond_0
    :goto_0
    return v5

    .line 1186
    :sswitch_0
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isPreventWhenLcdOn()Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isScreenOn()Z

    move-result v2

    if-nez v2, :cond_4

    :cond_1
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isPreventWhenCalling()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCallActivState:Z

    if-nez v2, :cond_4

    :cond_2
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isPreventInTethering()Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsTetheringOn:Z

    if-eq v2, v5, :cond_4

    :cond_3
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isPreventInBip()Z

    move-result v2

    if-eqz v2, :cond_7

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mBIPActivState:Z

    if-ne v2, v5, :cond_7

    .line 1190
    :cond_4
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "PREVENT_FD_WHEN_LCDON_OR_CALLING :isScreenOn="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v4, v4, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v4}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isScreenOn()Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mCallActivState="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v4, v4, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mCallActivState:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1192
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isPreventInTethering()Z

    move-result v2

    if-eqz v2, :cond_5

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsTetheringOn:Z

    if-ne v2, v5, :cond_5

    .line 1193
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "PREVENT_FD_WHEN_TETHERIONG_ON :mIsPreventInTethering="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v4, v4, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v4}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isPreventInTethering()Z

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mIsTetheringOn="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v4, v4, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsTetheringOn:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1195
    :cond_5
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isPreventInBip()Z

    move-result v2

    if-eqz v2, :cond_6

    .line 1196
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "PREVENT_FD_WHEN_BIP_ACTIVATED :"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v4, v4, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mBIPActivState:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1199
    :cond_6
    iput v6, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    .line 1200
    iput-boolean v6, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mFDTriggered:Z

    .line 1201
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDRetryManager:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;->resetCount()V

    .line 1202
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->scheduleCheckNetStat()V

    .line 1203
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v2}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1205
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v2}, Landroid/os/PowerManager$WakeLock;->release()V

    goto/16 :goto_0

    .line 1210
    :cond_7
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mNetStatMonitor:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$NetStatMonitor;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$NetStatMonitor;->checkNetStat()Z

    move-result v2

    if-ne v2, v5, :cond_9

    .line 1211
    iput v6, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    .line 1212
    iput-boolean v6, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mFDTriggered:Z

    .line 1213
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDRetryManager:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;->resetCount()V

    .line 1219
    :goto_1
    const-wide/16 v0, 0x0

    .line 1221
    .local v0, "treshToFDTrigger":J
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsFDValueChanged:Z

    if-eqz v2, :cond_a

    .line 1222
    const-wide/16 v0, 0xa

    .line 1227
    :goto_2
    iget-boolean v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mFDTriggered:Z

    if-eqz v2, :cond_8

    .line 1228
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->getFDRetryTimerValue()J

    move-result-wide v2

    div-long v0, v2, v8

    .line 1231
    :cond_8
    iget v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    int-to-long v2, v2

    cmp-long v2, v2, v0

    if-lez v2, :cond_e

    .line 1232
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDRetryManager:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;->isRetryNeeded()Z

    move-result v2

    if-ne v2, v5, :cond_d

    .line 1234
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isDelayInDialing()Z

    move-result v2

    if-eqz v2, :cond_b

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->isDial()Z

    move-result v2

    if-eqz v2, :cond_b

    .line 1235
    iget v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    add-int/lit8 v2, v2, -0x4

    iput v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    .line 1236
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iput-boolean v5, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mfastdormancy_dial:Z

    .line 1237
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "LGEDATA_FD : DELAY...5 sec  = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " / treshToFDTrigger : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1251
    :goto_3
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->scheduleCheckNetStat()V

    .line 1262
    :goto_4
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v2}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1264
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v2}, Landroid/os/PowerManager$WakeLock;->release()V

    goto/16 :goto_0

    .line 1215
    .end local v0    # "treshToFDTrigger":J
    :cond_9
    iget v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    goto/16 :goto_1

    .line 1224
    .restart local v0    # "treshToFDTrigger":J
    :cond_a
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->getFDTriggerTimerValue()J

    move-result-wide v2

    div-long v0, v2, v8

    goto/16 :goto_2

    .line 1238
    :cond_b
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->isDelayInDialing()Z

    move-result v2

    if-eqz v2, :cond_c

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mfastdormancy_dial:Z

    if-eqz v2, :cond_c

    .line 1241
    iget v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    add-int/lit8 v2, v2, -0x1

    iput v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    .line 1242
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iput-boolean v6, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mfastdormancy_dial:Z

    .line 1243
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "LGEDATA_FD : DELAY...1 sec  = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " / treshToFDTrigger : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    goto :goto_3

    .line 1246
    :cond_c
    invoke-direct {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->triggerGoDormant()Z

    .line 1247
    iput-boolean v5, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mFDTriggered:Z

    .line 1248
    iput v6, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    .line 1249
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDRetryManager:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyRetryManager;->increaseCount()V

    goto :goto_3

    .line 1253
    :cond_d
    invoke-direct {p0}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->triggerGoDormant()Z

    .line 1254
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v3, "Reached to MAXIMUM FD Retrires, so we cannot know the RRC state exactly"

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 1255
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    # getter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mUnknownState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;
    invoke-static {v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$800(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$UnknownState;

    move-result-object v3

    # invokes: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$1600(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Lcom/android/internal/util/IState;)V

    goto/16 :goto_4

    .line 1259
    :cond_e
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->scheduleCheckNetStat()V

    goto/16 :goto_4

    .line 1270
    .end local v0    # "treshToFDTrigger":J
    :sswitch_1
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v3, "ICC changed."

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1271
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->updateIccAvailability()V

    goto/16 :goto_0

    .line 1275
    :sswitch_2
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v3, "Records loaded."

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1277
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->onRecordsLoaded()V

    goto/16 :goto_0

    .line 1281
    :sswitch_3
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v3, "Radio Tech changed."

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1282
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->onRadioTechnologyChanged()V

    .line 1284
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v2}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1286
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, v2, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v2}, Landroid/os/PowerManager$WakeLock;->release()V

    goto/16 :goto_0

    .line 1291
    :sswitch_4
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v3, "Data call list changed."

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1293
    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Landroid/os/AsyncResult;

    invoke-virtual {v3, v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->onDataCallListChanged(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    .line 1297
    :sswitch_5
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v3, "Go dormant response received"

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1298
    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Landroid/os/AsyncResult;

    invoke-virtual {v3, v2}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->onGoDormantReponse(Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    .line 1302
    :sswitch_6
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v3, "Voice call is started"

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1303
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v2, v5}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->onCallActiveStateChanged(Z)V

    goto/16 :goto_0

    .line 1307
    :sswitch_7
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v3, "Voice call is ended"

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 1308
    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v2, v6}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->onCallActiveStateChanged(Z)V

    goto/16 :goto_0

    .line 1183
    :sswitch_data_0
    .sparse-switch
        0x18c4b -> :sswitch_0
        0x18c4c -> :sswitch_3
        0x18c4d -> :sswitch_5
        0x42002 -> :sswitch_2
        0x42004 -> :sswitch_4
        0x42007 -> :sswitch_6
        0x42008 -> :sswitch_7
        0x42021 -> :sswitch_1
    .end sparse-switch
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1157
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[DCH/FACH] FDCount : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->mIdleDuration:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
