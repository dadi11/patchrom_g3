.class public Lcom/android/server/CCMode;
.super Ljava/lang/Object;
.source "CCMode.java"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-string v0, "ccm"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public native cc_mode_disable()I
.end method

.method public native cc_mode_enable()I
.end method

.method public native cc_mode_isSupported()I
.end method

.method public native cc_mode_selftest()I
.end method
