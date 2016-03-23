.class public Lcom/android/internal/telephony/ImsCallInfoImpl;
.super Ljava/lang/Object;
.source "ImsCallInfoImpl.java"

# interfaces
.implements Lcom/android/internal/telephony/ImsCallInfo;


# static fields
.field private static final OIPTYPE_IDENTITY:I = 0x1

.field private static final OIPTYPE_NONE:I = 0x0

.field private static final OIPTYPE_RESTICTED:I = 0x2

.field private static final PARTTYPE_MO:I = 0x0

.field private static final PARTTYPE_MT:I = 0x1


# instance fields
.field private mConnectedName:Ljava/lang/String;

.field private mConnectedNumber:Ljava/lang/String;

.field private mConnectedNumberPresentation:I

.field private mIMSCallState:I

.field private mPartyType:I

.field private m_isConferenceCall:I


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, -0x1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedNumber:Ljava/lang/String;

    iput v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedNumberPresentation:I

    iput-object v1, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedName:Ljava/lang/String;

    iput v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->m_isConferenceCall:I

    iput v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mPartyType:I

    const/4 v0, 0x0

    iput v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mIMSCallState:I

    return-void
.end method


# virtual methods
.method public getConnectedName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedName:Ljava/lang/String;

    return-object v0
.end method

.method public getConnectedNumber()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedNumber:Ljava/lang/String;

    return-object v0
.end method

.method public getConnectedNumberPresentation()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedNumberPresentation:I

    return v0
.end method

.method public getIMSCallState()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mIMSCallState:I

    return v0
.end method

.method public isConferenceCall()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    iget v1, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->m_isConferenceCall:I

    if-ge v1, v0, :cond_0

    const/4 v0, 0x0

    :cond_0
    return v0
.end method

.method public isIncoming()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    iget v1, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mPartyType:I

    if-ne v1, v0, :cond_0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setConnectedName(Ljava/lang/String;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedName:Ljava/lang/String;

    return-void
.end method

.method public setConnectedNumber(Ljava/lang/String;)V
    .locals 0
    .param p1, "number"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedNumber:Ljava/lang/String;

    return-void
.end method

.method public setConnectedNumberPresentation(I)V
    .locals 1
    .param p1, "type"    # I

    .prologue
    const/4 v0, 0x3

    packed-switch p1, :pswitch_data_0

    iput v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedNumberPresentation:I

    :goto_0
    return-void

    :pswitch_0
    iput v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedNumberPresentation:I

    goto :goto_0

    :pswitch_1
    const/4 v0, 0x1

    iput v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedNumberPresentation:I

    goto :goto_0

    :pswitch_2
    const/4 v0, 0x2

    iput v0, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mConnectedNumberPresentation:I

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public setIMSCallState(I)V
    .locals 0
    .param p1, "callstate"    # I

    .prologue
    iput p1, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mIMSCallState:I

    return-void
.end method

.method public setIsConferenceCall(I)V
    .locals 0
    .param p1, "m_isConf"    # I

    .prologue
    iput p1, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->m_isConferenceCall:I

    return-void
.end method

.method public setPartyType(I)V
    .locals 0
    .param p1, "mPartyType"    # I

    .prologue
    iput p1, p0, Lcom/android/internal/telephony/ImsCallInfoImpl;->mPartyType:I

    return-void
.end method
