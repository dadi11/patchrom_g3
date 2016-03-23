.class public Lcom/lge/telephony/msim/LGCallManager;
.super Ljava/lang/Object;
.source "LGCallManager.java"


# static fields
.field private static INSTANCE:Lcom/lge/telephony/msim/LGCallManager;

.field private static final VENDOR_CALLMANAGER_ADAPTORS:[Ljava/lang/String;

.field private static activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;


# instance fields
.field private CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "com.lge.telephony.msim.TargetCallManagerAdaptor"

    aput-object v3, v2, v4

    sput-object v2, Lcom/lge/telephony/msim/LGCallManager;->VENDOR_CALLMANAGER_ADAPTORS:[Ljava/lang/String;

    sget-object v2, Lcom/lge/telephony/msim/LGCallManager;->VENDOR_CALLMANAGER_ADAPTORS:[Ljava/lang/String;

    invoke-static {v2}, Lcom/lge/telephony/msim/RuntimeLoader;->getActiveDefaultConstructorFromClassList([Ljava/lang/String;)Ljava/lang/reflect/Constructor;

    move-result-object v0

    .local v0, "constructor":Ljava/lang/reflect/Constructor;, "Ljava/lang/reflect/Constructor<*>;"
    if-nez v0, :cond_0

    new-instance v2, Ljava/lang/RuntimeException;

    const-string v3, "Error!! don\'t load any class"

    invoke-direct {v2, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v2

    :cond_0
    const/4 v2, 0x0

    :try_start_0
    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v2}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lge/telephony/msim/LGCallManagerBase;

    sput-object v2, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;
    :try_end_0
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_3

    new-instance v2, Lcom/lge/telephony/msim/LGCallManager;

    invoke-direct {v2}, Lcom/lge/telephony/msim/LGCallManager;-><init>()V

    sput-object v2, Lcom/lge/telephony/msim/LGCallManager;->INSTANCE:Lcom/lge/telephony/msim/LGCallManager;

    return-void

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/InstantiationException;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2

    .end local v1    # "e":Ljava/lang/InstantiationException;
    :catch_1
    move-exception v1

    .local v1, "e":Ljava/lang/IllegalAccessException;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2

    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catch_2
    move-exception v1

    .local v1, "e":Ljava/lang/IllegalArgumentException;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2

    .end local v1    # "e":Ljava/lang/IllegalArgumentException;
    :catch_3
    move-exception v1

    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2
.end method

.method private constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {}, Lcom/android/internal/telephony/CallManager;->getInstance()Lcom/android/internal/telephony/CallManager;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    return-void
.end method

.method public static getInstance()Lcom/lge/telephony/msim/LGCallManager;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->INSTANCE:Lcom/lge/telephony/msim/LGCallManager;

    return-object v0
.end method


# virtual methods
.method public acceptCall(Lcom/android/internal/telephony/Call;)V
    .locals 1
    .param p1, "ringingCall"    # Lcom/android/internal/telephony/Call;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/CallStateException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->acceptCall(Lcom/android/internal/telephony/Call;)V

    return-void
.end method

.method public acceptCall(Lcom/android/internal/telephony/Call;I)V
    .locals 1
    .param p1, "ringingCall"    # Lcom/android/internal/telephony/Call;
    .param p2, "callType"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/CallStateException;
        }
    .end annotation

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1, p2}, Lcom/lge/telephony/msim/LGCallManagerBase;->acceptCall(Lcom/android/internal/telephony/Call;I)V

    return-void
.end method

.method public canConference(Lcom/android/internal/telephony/Call;)Z
    .locals 1
    .param p1, "heldCall"    # Lcom/android/internal/telephony/Call;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->canConference(Lcom/android/internal/telephony/Call;)Z

    move-result v0

    return v0
.end method

.method public canConference(Lcom/android/internal/telephony/Call;I)Z
    .locals 1
    .param p1, "heldCall"    # Lcom/android/internal/telephony/Call;
    .param p2, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1, p2}, Lcom/lge/telephony/msim/LGCallManagerBase;->canConference(Lcom/android/internal/telephony/Call;I)Z

    move-result v0

    return v0
.end method

.method public canTransfer(Lcom/android/internal/telephony/Call;)Z
    .locals 1
    .param p1, "heldCall"    # Lcom/android/internal/telephony/Call;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->canTransfer(Lcom/android/internal/telephony/Call;)Z

    move-result v0

    return v0
.end method

.method public clearDisconnected()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->clearDisconnected()V

    return-void
.end method

.method public clearDisconnected(I)V
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->clearDisconnected(I)V

    return-void
.end method

.method public conference(Lcom/android/internal/telephony/Call;)V
    .locals 1
    .param p1, "heldCall"    # Lcom/android/internal/telephony/Call;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/CallStateException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->conference(Lcom/android/internal/telephony/Call;)V

    return-void
.end method

.method public dial(Lcom/android/internal/telephony/Phone;Ljava/lang/String;I)Lcom/android/internal/telephony/Connection;
    .locals 1
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;
    .param p2, "dialString"    # Ljava/lang/String;
    .param p3, "videoState"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/CallStateException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->dial(Lcom/android/internal/telephony/Phone;Ljava/lang/String;I)Lcom/android/internal/telephony/Connection;

    move-result-object v0

    return-object v0
.end method

.method public dial(Lcom/android/internal/telephony/Phone;Ljava/lang/String;I[Ljava/lang/String;)Lcom/android/internal/telephony/Connection;
    .locals 1
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;
    .param p2, "dialString"    # Ljava/lang/String;
    .param p3, "callType"    # I
    .param p4, "extras"    # [Ljava/lang/String;

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/lge/telephony/msim/LGCallManagerBase;->dial(Lcom/android/internal/telephony/Phone;Ljava/lang/String;I[Ljava/lang/String;)Lcom/android/internal/telephony/Connection;

    move-result-object v0

    return-object v0
.end method

.method public dial(Lcom/android/internal/telephony/Phone;Ljava/lang/String;Lcom/android/internal/telephony/UUSInfo;I)Lcom/android/internal/telephony/Connection;
    .locals 1
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;
    .param p2, "dialString"    # Ljava/lang/String;
    .param p3, "uusInfo"    # Lcom/android/internal/telephony/UUSInfo;
    .param p4, "videoState"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/CallStateException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/android/internal/telephony/CallManager;->dial(Lcom/android/internal/telephony/Phone;Ljava/lang/String;Lcom/android/internal/telephony/UUSInfo;I)Lcom/android/internal/telephony/Connection;

    move-result-object v0

    return-object v0
.end method

.method public explicitCallTransfer(Lcom/android/internal/telephony/Call;)V
    .locals 1
    .param p1, "heldCall"    # Lcom/android/internal/telephony/Call;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/CallStateException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->explicitCallTransfer(Lcom/android/internal/telephony/Call;)V

    return-void
.end method

.method public getActiveFgCall()Lcom/android/internal/telephony/Call;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getActiveFgCall()Lcom/android/internal/telephony/Call;

    move-result-object v0

    return-object v0
.end method

.method public getActiveFgCall(I)Lcom/android/internal/telephony/Call;
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getActiveFgCall(I)Lcom/android/internal/telephony/Call;

    move-result-object v0

    return-object v0
.end method

.method public getActiveFgCallState()Lcom/android/internal/telephony/Call$State;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getActiveFgCallState()Lcom/android/internal/telephony/Call$State;

    move-result-object v0

    return-object v0
.end method

.method public getActiveFgCallState(I)Lcom/android/internal/telephony/Call$State;
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getActiveFgCallState(I)Lcom/android/internal/telephony/Call$State;

    move-result-object v0

    return-object v0
.end method

.method public getActiveSubscription()I
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0}, Lcom/lge/telephony/msim/LGCallManagerBase;->getActiveSubscription()I

    move-result v0

    return v0
.end method

.method public getAllPhones()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/Phone;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getAllPhones()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getBackgroundCalls()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/Call;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getBackgroundCalls()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getBgCallConnections()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/Connection;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getBgCallConnections()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getBgPhone()Lcom/android/internal/telephony/Phone;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getBgPhone()Lcom/android/internal/telephony/Phone;

    move-result-object v0

    return-object v0
.end method

.method public getBgPhone(I)Lcom/android/internal/telephony/Phone;
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getBgPhone(I)Lcom/android/internal/telephony/Phone;

    move-result-object v0

    return-object v0
.end method

.method public getDefaultPhone()Lcom/android/internal/telephony/Phone;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getDefaultPhone()Lcom/android/internal/telephony/Phone;

    move-result-object v0

    return-object v0
.end method

.method public getFgCallConnections()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/Connection;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getFgCallConnections()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getFgCallConnections(I)Ljava/util/List;
    .locals 1
    .param p1, "subscription"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/Connection;",
            ">;"
        }
    .end annotation

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getFgCallConnections(I)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getFgCallLatestConnection()Lcom/android/internal/telephony/Connection;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getFgCallLatestConnection()Lcom/android/internal/telephony/Connection;

    move-result-object v0

    return-object v0
.end method

.method public getFgCallLatestConnection(I)Lcom/android/internal/telephony/Connection;
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getFgCallLatestConnection(I)Lcom/android/internal/telephony/Connection;

    move-result-object v0

    return-object v0
.end method

.method public getFgPhone()Lcom/android/internal/telephony/Phone;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getFgPhone()Lcom/android/internal/telephony/Phone;

    move-result-object v0

    return-object v0
.end method

.method public getFgPhone(I)Lcom/android/internal/telephony/Phone;
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getFgPhone(I)Lcom/android/internal/telephony/Phone;

    move-result-object v0

    return-object v0
.end method

.method public getFirstActiveBgCall()Lcom/android/internal/telephony/Call;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getFirstActiveBgCall()Lcom/android/internal/telephony/Call;

    move-result-object v0

    return-object v0
.end method

.method public getFirstActiveBgCall(I)Lcom/android/internal/telephony/Call;
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getFirstActiveBgCall(I)Lcom/android/internal/telephony/Call;

    move-result-object v0

    return-object v0
.end method

.method public getFirstActiveRingingCall()Lcom/android/internal/telephony/Call;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getFirstActiveRingingCall()Lcom/android/internal/telephony/Call;

    move-result-object v0

    return-object v0
.end method

.method public getFirstActiveRingingCall(I)Lcom/android/internal/telephony/Call;
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getFirstActiveRingingCall(I)Lcom/android/internal/telephony/Call;

    move-result-object v0

    return-object v0
.end method

.method public getForegroundCalls()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/Call;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getForegroundCalls()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getIsIMSECCSetup()Z
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0}, Lcom/lge/telephony/msim/LGCallManagerBase;->getIsIMSECCSetup()Z

    move-result v0

    return v0
.end method

.method public getLocalCallHoldStatus(I)Z
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getLocalCallHoldStatus(I)Z

    move-result v0

    return v0
.end method

.method public getMute()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getMute()Z

    move-result v0

    return v0
.end method

.method public getPendingMmiCodes(Lcom/android/internal/telephony/Phone;)Ljava/util/List;
    .locals 1
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/android/internal/telephony/Phone;",
            ")",
            "Ljava/util/List",
            "<+",
            "Lcom/android/internal/telephony/MmiCode;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->getPendingMmiCodes(Lcom/android/internal/telephony/Phone;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getPhoneInCall()Lcom/android/internal/telephony/Phone;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0}, Lcom/lge/telephony/msim/LGCallManagerBase;->getPhoneInCall()Lcom/android/internal/telephony/Phone;

    move-result-object v0

    return-object v0
.end method

.method public getPhoneInCall(I)Lcom/android/internal/telephony/Phone;
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getPhoneInCall(I)Lcom/android/internal/telephony/Phone;

    move-result-object v0

    return-object v0
.end method

.method public getRingingCalls()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/android/internal/telephony/Call;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getRingingCalls()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getRingingPhone()Lcom/android/internal/telephony/Phone;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getRingingPhone()Lcom/android/internal/telephony/Phone;

    move-result-object v0

    return-object v0
.end method

.method public getRingingPhone(I)Lcom/android/internal/telephony/Phone;
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getRingingPhone(I)Lcom/android/internal/telephony/Phone;

    move-result-object v0

    return-object v0
.end method

.method public getServiceState()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getServiceState()I

    move-result v0

    return v0
.end method

.method public getServiceState(I)I
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getServiceState(I)I

    move-result v0

    return v0
.end method

.method public getState()Lcom/android/internal/telephony/PhoneConstants$State;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->getState()Lcom/android/internal/telephony/PhoneConstants$State;

    move-result-object v0

    return-object v0
.end method

.method public getState(I)Lcom/android/internal/telephony/PhoneConstants$State;
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->getState(I)Lcom/android/internal/telephony/PhoneConstants$State;

    move-result-object v0

    return-object v0
.end method

.method public hangupForegroundResumeBackground(Lcom/android/internal/telephony/Call;)V
    .locals 1
    .param p1, "heldCall"    # Lcom/android/internal/telephony/Call;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/CallStateException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->hangupForegroundResumeBackground(Lcom/android/internal/telephony/Call;)V

    return-void
.end method

.method public hasActiveBgCall()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->hasActiveBgCall()Z

    move-result v0

    return v0
.end method

.method public hasActiveBgCall(I)Z
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->hasActiveBgCall(I)Z

    move-result v0

    return v0
.end method

.method public hasActiveFgCall()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->hasActiveFgCall()Z

    move-result v0

    return v0
.end method

.method public hasActiveFgCall(I)Z
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->hasActiveFgCall(I)Z

    move-result v0

    return v0
.end method

.method public hasActiveFgCallAnyPhone()Z
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0}, Lcom/lge/telephony/msim/LGCallManagerBase;->hasActiveFgCallAnyPhone()Z

    move-result v0

    return v0
.end method

.method public hasActiveRingingCall()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->hasActiveRingingCall()Z

    move-result v0

    return v0
.end method

.method public hasActiveRingingCall(I)Z
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->hasActiveRingingCall(I)Z

    move-result v0

    return v0
.end method

.method public hasDisconnectedBgCall()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->hasDisconnectedBgCall()Z

    move-result v0

    return v0
.end method

.method public hasDisconnectedBgCall(I)Z
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->hasDisconnectedBgCall(I)Z

    move-result v0

    return v0
.end method

.method public hasDisconnectedFgCall()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->hasDisconnectedFgCall()Z

    move-result v0

    return v0
.end method

.method public hasDisconnectedFgCall(I)Z
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->hasDisconnectedFgCall(I)Z

    move-result v0

    return v0
.end method

.method public isCallOnCsvtEnabled()Z
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0}, Lcom/lge/telephony/msim/LGCallManagerBase;->isCallOnCsvtEnabled()Z

    move-result v0

    return v0
.end method

.method public isCallOnImsEnabled()Z
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0}, Lcom/lge/telephony/msim/LGCallManagerBase;->isCallOnImsEnabled()Z

    move-result v0

    return v0
.end method

.method public isImsPhoneActive()Z
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0}, Lcom/lge/telephony/msim/LGCallManagerBase;->isImsPhoneActive()Z

    move-result v0

    return v0
.end method

.method public isImsPhoneIdle()Z
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0}, Lcom/lge/telephony/msim/LGCallManagerBase;->isImsPhoneIdle()Z

    move-result v0

    return v0
.end method

.method public registerForCallModify(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1, p2, p3}, Lcom/lge/telephony/msim/LGCallManagerBase;->registerForCallModify(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForCallWaiting(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForCallWaiting(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForCdmaOtaStatusChange(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForCdmaOtaStatusChange(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForDisconnect(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForDisconnect(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForDisplayInfo(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForDisplayInfo(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForEcmTimerReset(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForEcmTimerReset(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForInCallVoicePrivacyOff(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForInCallVoicePrivacyOff(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForInCallVoicePrivacyOn(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForInCallVoicePrivacyOn(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForIncomingRing(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForIncomingRing(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForMmiComplete(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForMmiComplete(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForMmiInitiate(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForMmiInitiate(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForNewRingingConnection(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForNewRingingConnection(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForPostDialCharacter(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForPostDialCharacter(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForPreciseCallStateChanged(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForPreciseCallStateChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForRedirectedNumberInfo(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForRedirectedNumberInfo(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForResendIncallMute(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForResendIncallMute(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForRingbackTone(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForRingbackTone(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForServiceStateChanged(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForServiceStateChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForSignalInfo(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForSignalInfo(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForSubscriptionChange(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1, p2, p3}, Lcom/lge/telephony/msim/LGCallManagerBase;->registerForSubscriptionChange(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForSubscriptionInfoReady(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForSubscriptionInfoReady(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForSuppServiceFailed(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForSuppServiceFailed(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForSuppServiceNotification(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForSuppServiceNotification(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerForUnknownConnection(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/CallManager;->registerForUnknownConnection(Landroid/os/Handler;ILjava/lang/Object;)V

    return-void
.end method

.method public registerPhone(Lcom/android/internal/telephony/Phone;)Z
    .locals 1
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->registerPhone(Lcom/android/internal/telephony/Phone;)Z

    move-result v0

    return v0
.end method

.method public rejectCall(Lcom/android/internal/telephony/Call;)V
    .locals 1
    .param p1, "ringingCall"    # Lcom/android/internal/telephony/Call;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/CallStateException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->rejectCall(Lcom/android/internal/telephony/Call;)V

    return-void
.end method

.method public sendBurstDtmf(Ljava/lang/String;IILandroid/os/Message;)Z
    .locals 1
    .param p1, "dtmfString"    # Ljava/lang/String;
    .param p2, "on"    # I
    .param p3, "off"    # I
    .param p4, "onComplete"    # Landroid/os/Message;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/android/internal/telephony/CallManager;->sendBurstDtmf(Ljava/lang/String;IILandroid/os/Message;)Z

    move-result v0

    return v0
.end method

.method public sendDtmf(C)Z
    .locals 1
    .param p1, "c"    # C

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->sendDtmf(C)Z

    move-result v0

    return v0
.end method

.method public sendUssdResponse(Lcom/android/internal/telephony/Phone;Ljava/lang/String;)Z
    .locals 1
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;
    .param p2, "ussdMessge"    # Ljava/lang/String;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1, p2}, Lcom/android/internal/telephony/CallManager;->sendUssdResponse(Lcom/android/internal/telephony/Phone;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setActiveSubscription(I)V
    .locals 1
    .param p1, "subscription"    # I

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->setActiveSubscription(I)V

    return-void
.end method

.method public setAudioMode()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->setAudioMode()V

    return-void
.end method

.method public setAudioMode(Lcom/android/internal/telephony/PhoneConstants$State;)V
    .locals 1
    .param p1, "state"    # Lcom/android/internal/telephony/PhoneConstants$State;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->setAudioMode(Lcom/android/internal/telephony/PhoneConstants$State;)V

    return-void
.end method

.method public setCallAudioDrivers(ILcom/android/internal/telephony/Call$State;)V
    .locals 1
    .param p1, "phoneType"    # I
    .param p2, "state"    # Lcom/android/internal/telephony/Call$State;

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1, p2}, Lcom/lge/telephony/msim/LGCallManagerBase;->setCallAudioDrivers(ILcom/android/internal/telephony/Call$State;)V

    return-void
.end method

.method public setEchoSuppressionEnabled(Z)V
    .locals 1
    .param p1, "enabled"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->setEchoSuppressionEnabled()V

    return-void
.end method

.method public setIsIMSECCSetup(Z)V
    .locals 1
    .param p1, "sending"    # Z

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->setIsIMSECCSetup(Z)V

    return-void
.end method

.method public setMute(Z)V
    .locals 1
    .param p1, "muted"    # Z

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->setMute(Z)V

    return-void
.end method

.method public startDtmf(C)Z
    .locals 1
    .param p1, "c"    # C

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->startDtmf(C)Z

    move-result v0

    return v0
.end method

.method public stopDtmf()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/CallManager;->stopDtmf()V

    return-void
.end method

.method public switchHoldingAndActive(Lcom/android/internal/telephony/Call;)V
    .locals 1
    .param p1, "heldCall"    # Lcom/android/internal/telephony/Call;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/android/internal/telephony/CallStateException;
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->switchHoldingAndActive(Lcom/android/internal/telephony/Call;)V

    return-void
.end method

.method public switchToLocalHold(IZ)V
    .locals 1
    .param p1, "subscription"    # I
    .param p2, "switchTo"    # Z

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1, p2}, Lcom/lge/telephony/msim/LGCallManagerBase;->switchToLocalHold(IZ)V

    return-void
.end method

.method public unregisterForCallModify(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->unregisterForCallModify(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForCallWaiting(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForCallWaiting(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForCdmaOtaStatusChange(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForCdmaOtaStatusChange(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForDisconnect(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForDisconnect(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForDisplayInfo(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForDisplayInfo(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForEcmTimerReset(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForEcmTimerReset(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForInCallVoicePrivacyOff(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForInCallVoicePrivacyOff(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForInCallVoicePrivacyOn(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForInCallVoicePrivacyOn(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForIncomingRing(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForIncomingRing(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForMmiComplete(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForMmiComplete(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForMmiInitiate(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForMmiInitiate(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForNewRingingConnection(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForNewRingingConnection(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForPostDialCharacter(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForPostDialCharacter(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForPreciseCallStateChanged(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForPreciseCallStateChanged(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForRedirectedNumberInfo(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForRedirectedNumberInfo(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForResendIncallMute(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForResendIncallMute(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForRingbackTone(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForRingbackTone(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForServiceStateChanged(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForServiceStateChanged(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForSignalInfo(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForSignalInfo(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForSubscriptionChange(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    sget-object v0, Lcom/lge/telephony/msim/LGCallManager;->activeCallManager:Lcom/lge/telephony/msim/LGCallManagerBase;

    invoke-virtual {v0, p1}, Lcom/lge/telephony/msim/LGCallManagerBase;->unregisterForSubscriptionChange(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForSubscriptionInfoReady(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForSubscriptionInfoReady(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForSuppServiceFailed(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForSuppServiceFailed(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForSuppServiceNotification(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForSuppServiceNotification(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterForUnknownConnection(Landroid/os/Handler;)V
    .locals 1
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterForUnknownConnection(Landroid/os/Handler;)V

    return-void
.end method

.method public unregisterPhone(Lcom/android/internal/telephony/Phone;)V
    .locals 1
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/msim/LGCallManager;->CM_NATIVE_INSTANCE:Lcom/android/internal/telephony/CallManager;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/CallManager;->unregisterPhone(Lcom/android/internal/telephony/Phone;)V

    return-void
.end method
