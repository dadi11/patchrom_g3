.class public Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;
.super Ljava/lang/Object;
.source "RIL.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/RIL;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "IncomingExtendedCallstate"
.end annotation


# instance fields
.field public cnapCallingPartyNumber:Ljava/lang/String;

.field public cnapDisplay:Ljava/lang/String;

.field public cnapExtendedDisplay:Ljava/lang/String;

.field public isHDVoice:Z

.field public isVowifi:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->cnapDisplay:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->cnapCallingPartyNumber:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->cnapExtendedDisplay:Ljava/lang/String;

    iput-boolean v1, p0, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->isVowifi:Z

    iput-boolean v1, p0, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->isHDVoice:Z

    return-void
.end method


# virtual methods
.method public initializeIncomingExtendedCallstate()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->cnapDisplay:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->cnapCallingPartyNumber:Ljava/lang/String;

    iput-object v0, p0, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->cnapExtendedDisplay:Ljava/lang/String;

    iput-boolean v1, p0, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->isVowifi:Z

    iput-boolean v1, p0, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->isHDVoice:Z

    return-void
.end method

.method public isIncomingExtendedCallstate()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/RIL$IncomingExtendedCallstate;->cnapCallingPartyNumber:Ljava/lang/String;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method
