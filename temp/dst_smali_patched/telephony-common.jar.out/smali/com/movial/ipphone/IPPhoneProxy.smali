.class public Lcom/movial/ipphone/IPPhoneProxy;
.super Lcom/android/internal/telephony/PhoneProxy;
.source "IPPhoneProxy.java"


# instance fields
.field private mActivePhone:Lcom/android/internal/telephony/Phone;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/PhoneProxy;-><init>()V

    return-void
.end method

.method public constructor <init>(Lcom/android/internal/telephony/Phone;)V
    .locals 0
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/PhoneProxy;-><init>()V

    return-void
.end method

.method public static getIPPhoneProfile()I
    .locals 1

    .prologue
    const/4 v0, -0x1

    return v0
.end method

.method public static getIPPhoneServiceState()Z
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method


# virtual methods
.method public getEmergencyCallPowerState()Z
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getEmergencyPreference()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getEmergencyState()Lcom/movial/ipphone/IPUtils$EmergencyState;
    .locals 1

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public getImsBackgroundCall()Lcom/android/internal/telephony/Call;
    .locals 1

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public getImsForegroundCall()Lcom/android/internal/telephony/Call;
    .locals 1

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public getImsRingingCall()Lcom/android/internal/telephony/Call;
    .locals 1

    .prologue
    const/4 v0, 0x0

    return-object v0
.end method

.method public hangupFakeCall(Z)V
    .locals 0
    .param p1, "dialed"    # Z

    .prologue
    return-void
.end method

.method public registerForOn(Landroid/os/Handler;ILjava/lang/Object;)V
    .locals 0
    .param p1, "h"    # Landroid/os/Handler;
    .param p2, "what"    # I
    .param p3, "obj"    # Ljava/lang/Object;

    .prologue
    return-void
.end method

.method public setEmergencyState(Lcom/movial/ipphone/IPUtils$EmergencyState;)V
    .locals 0
    .param p1, "state"    # Lcom/movial/ipphone/IPUtils$EmergencyState;

    .prologue
    return-void
.end method

.method public setForceEmergencyMode(Z)V
    .locals 0
    .param p1, "force"    # Z

    .prologue
    return-void
.end method

.method public setRadioPower(Z)V
    .locals 0
    .param p1, "power"    # Z

    .prologue
    return-void
.end method

.method public startImsEmergencyCall()V
    .locals 0

    .prologue
    return-void
.end method

.method public unregisterForOn(Landroid/os/Handler;)V
    .locals 0
    .param p1, "h"    # Landroid/os/Handler;

    .prologue
    return-void
.end method
