.class public Lcom/android/internal/policy/IKeyguardServiceEx$Stub;
.super Ljava/lang/Object;
.source "IKeyguardServiceEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/policy/IKeyguardServiceEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/policy/IKeyguardServiceEx$Stub$Proxy;
    }
.end annotation


# static fields
.field private static final DESCRIPTOR:Ljava/lang/String; = "com.android.internal.policy.IKeyguardService"

.field static final TRANSACTION_doKeyguardUnlockDisabled:I = 0x2711


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lcom/android/internal/policy/IKeyguardServiceEx;
    .locals 1
    .param p0, "obj"    # Landroid/os/IBinder;

    .prologue
    invoke-static {p0}, Lcom/android/internal/policy/IKeyguardService$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/policy/IKeyguardService;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/policy/IKeyguardServiceEx$Stub;->asInterface(Lcom/android/internal/policy/IKeyguardService;)Lcom/android/internal/policy/IKeyguardServiceEx;

    move-result-object v0

    return-object v0
.end method

.method public static asInterface(Lcom/android/internal/policy/IKeyguardService;)Lcom/android/internal/policy/IKeyguardServiceEx;
    .locals 1
    .param p0, "obj"    # Lcom/android/internal/policy/IKeyguardService;

    .prologue
    new-instance v0, Lcom/android/internal/policy/IKeyguardServiceEx$Stub$Proxy;

    invoke-direct {v0, p0}, Lcom/android/internal/policy/IKeyguardServiceEx$Stub$Proxy;-><init>(Lcom/android/internal/policy/IKeyguardService;)V

    return-object v0
.end method

.method public static onTransact(Lcom/android/internal/policy/IKeyguardServiceEx;ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .locals 6
    .param p0, "server"    # Lcom/android/internal/policy/IKeyguardServiceEx;
    .param p1, "code"    # I
    .param p2, "data"    # Landroid/os/Parcel;
    .param p3, "reply"    # Landroid/os/Parcel;
    .param p4, "flags"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x1

    const/4 v4, 0x0

    packed-switch p1, :pswitch_data_0

    move v3, v4

    :goto_0
    return v3

    :pswitch_0
    const-string v5, "com.android.internal.policy.IKeyguardService"

    invoke-virtual {p2, v5}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    new-array v2, v3, [Z

    .local v2, "bData":[Z
    invoke-virtual {p2, v2}, Landroid/os/Parcel;->readBooleanArray([Z)V

    aget-boolean v0, v2, v4

    .local v0, "_arg0":Z
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .local v1, "_arg1":Ljava/lang/String;
    invoke-interface {p0, v0, v1}, Lcom/android/internal/policy/IKeyguardServiceEx;->doKeyguardUnlockDisabled(ZLjava/lang/String;)V

    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x2711
        :pswitch_0
    .end packed-switch
.end method
