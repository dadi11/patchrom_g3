.class public Lcom/lge/telephony/LGServiceStateImpl;
.super Ljava/lang/Object;
.source "LGServiceStateImpl.java"


# static fields
.field static final LOG_TAG:Ljava/lang/String; = "LGServiceStateImpl"


# instance fields
.field private mCheck64QAM:I

.field private mDataNetworkName:Ljava/lang/String;

.field private mDataRoaming:Z

.field private mIsDataSearching:Z

.field private mIsRATDualCarrier:I

.field private mIsVoiceSearching:Z

.field private mVoiceNetworkName:Ljava/lang/String;

.field private mVoiceRoaming:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    iput-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    iput-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    iput-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    iput v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    iput v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    const-string v0, "LGServiceStateImpl"

    const-string v1, "[swmd] LG [LGServiceStateImpl ] LGServiceStateImpl()"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method


# virtual methods
.method public copyFrom(Lcom/lge/telephony/LGServiceStateImpl;)V
    .locals 1
    .param p1, "s"    # Lcom/lge/telephony/LGServiceStateImpl;

    .prologue
    iget-boolean v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    iget-boolean v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    iget-boolean v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    iget-boolean v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    iget-object v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    iget-object v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    iget v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    iget v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 6
    .param p1, "o"    # Ljava/lang/Object;

    .prologue
    const/4 v3, 0x0

    :try_start_0
    move-object v0, p1

    check-cast v0, Lcom/lge/telephony/LGServiceStateImpl;

    move-object v2, v0
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    .local v2, "s":Lcom/lge/telephony/LGServiceStateImpl;
    if-nez p1, :cond_1

    .end local v2    # "s":Lcom/lge/telephony/LGServiceStateImpl;
    :cond_0
    :goto_0
    return v3

    :catch_0
    move-exception v1

    .local v1, "ex":Ljava/lang/ClassCastException;
    goto :goto_0

    .end local v1    # "ex":Ljava/lang/ClassCastException;
    .restart local v2    # "s":Lcom/lge/telephony/LGServiceStateImpl;
    :cond_1
    iget-boolean v4, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    iget-boolean v5, v2, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    if-ne v4, v5, :cond_0

    iget-boolean v4, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    iget-boolean v5, v2, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    if-ne v4, v5, :cond_0

    iget v4, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    iget v5, v2, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    if-ne v4, v5, :cond_0

    iget v4, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    iget v5, v2, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    if-ne v4, v5, :cond_0

    const/4 v3, 0x1

    goto :goto_0
.end method

.method public getCheck64QAM()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    return v0
.end method

.method public getDataNetworkName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    return-object v0
.end method

.method public getDataRoaming()Z
    .locals 3

    .prologue
    const-string v0, "LGServiceStateImpl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getDataRoaming = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    return v0
.end method

.method public getRATDualCarrier()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    return v0
.end method

.method public getVoiceNetworkName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    return-object v0
.end method

.method public getVoiceRoaming()Z
    .locals 3

    .prologue
    const-string v0, "LGServiceStateImpl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getVoiceRoaming = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    return v0
.end method

.method public hashCode()I
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    iget-boolean v3, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    if-eqz v3, :cond_1

    :goto_1
    add-int/2addr v0, v1

    iget v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    mul-int/lit8 v1, v1, 0x29

    add-int/2addr v0, v1

    iget v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    mul-int/lit8 v1, v1, 0x2b

    add-int/2addr v0, v1

    return v0

    :cond_0
    move v0, v2

    goto :goto_0

    :cond_1
    move v1, v2

    goto :goto_1
.end method

.method public isDataSearching()Z
    .locals 3

    .prologue
    const-string v0, "LGServiceStateImpl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "isDataSearching = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    return v0
.end method

.method public isVoiceSearching()Z
    .locals 3

    .prologue
    const-string v0, "LGServiceStateImpl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "isVoiceSearching = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    return v0
.end method

.method public readFrom(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "m"    # Landroid/os/Bundle;

    .prologue
    const-string v0, "voiceRoaming"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    const-string v0, "dataRoaming"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    const-string v0, "voiceSearching"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    const-string v0, "dataSearching"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    const-string v0, "voiceNetworkName"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    const-string v0, "dataNetworkName"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    const-string v0, "Check64QAM"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    const-string v0, "RATDualCarrier"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    return-void
.end method

.method public readFrom(Landroid/os/Parcel;)V
    .locals 3
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_1

    move v0, v1

    :goto_1
    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_2

    move v0, v1

    :goto_2
    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_3

    :goto_3
    iput-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    return-void

    :cond_0
    move v0, v2

    goto :goto_0

    :cond_1
    move v0, v2

    goto :goto_1

    :cond_2
    move v0, v2

    goto :goto_2

    :cond_3
    move v1, v2

    goto :goto_3
.end method

.method public setCheck64QAM(I)V
    .locals 0
    .param p1, "Check64QAM"    # I

    .prologue
    iput p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    return-void
.end method

.method public setDataNetworkName(Ljava/lang/String;)V
    .locals 3
    .param p1, "dataNetworkName"    # Ljava/lang/String;

    .prologue
    const-string v0, "LGServiceStateImpl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setDataNetworkName = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-object p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    return-void
.end method

.method public setDataRoaming(Z)V
    .locals 3
    .param p1, "dataRoaming"    # Z

    .prologue
    const-string v0, "LGServiceStateImpl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setDataRoaming = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-boolean p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    return-void
.end method

.method public setDataSearching(Z)V
    .locals 0
    .param p1, "isDataSearching"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    return-void
.end method

.method public setNullState(I)V
    .locals 2
    .param p1, "state"    # I

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    iput-object v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    iput-object v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    return-void
.end method

.method public setRATDualCarrier(I)V
    .locals 0
    .param p1, "isRATDualCarrier"    # I

    .prologue
    iput p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    return-void
.end method

.method public setVoiceNetworkName(Ljava/lang/String;)V
    .locals 3
    .param p1, "voiceNetworkName"    # Ljava/lang/String;

    .prologue
    const-string v0, "LGServiceStateImpl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setVoiceNetworkName = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-object p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    return-void
.end method

.method public setVoiceRoaming(Z)V
    .locals 3
    .param p1, "voiceRomaing"    # Z

    .prologue
    const-string v0, "LGServiceStateImpl"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setVoiceRoaming = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    iput-boolean p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    return-void
.end method

.method public setVoiceSearching(Z)V
    .locals 0
    .param p1, "isVoiceSearching"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "voice roaming="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " Data Roaming="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mIsVoiceSearching="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mIsDataSearching="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mVoiceNetworkName="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mDataNetworkName="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " Check64QAM"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " Dual carrier"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeTo(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "m"    # Landroid/os/Bundle;

    .prologue
    const-string v0, "voiceRoaming"

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v0, "dataRoaming"

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v0, "voiceSearching"

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v0, "dataSearching"

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-string v0, "voiceNetworkName"

    iget-object v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "dataNetworkName"

    iget-object v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "Check64QAM"

    iget v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v0, "RATDualCarrier"

    iget v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    return-void
.end method

.method public writeTo(Landroid/os/Parcel;I)V
    .locals 3
    .param p1, "out"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    if-eqz v0, :cond_1

    move v0, v1

    :goto_1
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    if-eqz v0, :cond_2

    move v0, v1

    :goto_2
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    if-eqz v0, :cond_3

    :goto_3
    invoke-virtual {p1, v1}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    return-void

    :cond_0
    move v0, v2

    goto :goto_0

    :cond_1
    move v0, v2

    goto :goto_1

    :cond_2
    move v0, v2

    goto :goto_2

    :cond_3
    move v1, v2

    goto :goto_3
.end method
