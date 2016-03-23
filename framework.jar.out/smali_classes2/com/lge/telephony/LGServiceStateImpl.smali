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

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    iput-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    .line 20
    iput-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    .line 23
    iput-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    .line 24
    iput-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    .line 27
    const-string v0, ""

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    .line 28
    const-string v0, ""

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    .line 31
    iput v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    .line 34
    iput v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    .line 38
    const-string v0, "LGServiceStateImpl"

    const-string v1, "[swmd] LG [LGServiceStateImpl ] LGServiceStateImpl()"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 39
    return-void
.end method


# virtual methods
.method public copyFrom(Lcom/lge/telephony/LGServiceStateImpl;)V
    .locals 1
    .param p1, "s"    # Lcom/lge/telephony/LGServiceStateImpl;

    .prologue
    .line 43
    iget-boolean v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    .line 44
    iget-boolean v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    .line 47
    iget-boolean v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    .line 48
    iget-boolean v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    .line 51
    iget-object v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    .line 52
    iget-object v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    .line 55
    iget v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    .line 58
    iget v0, p1, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    .line 60
    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 6
    .param p1, "o"    # Ljava/lang/Object;

    .prologue
    const/4 v3, 0x0

    .line 287
    :try_start_0
    move-object v0, p1

    check-cast v0, Lcom/lge/telephony/LGServiceStateImpl;

    move-object v2, v0
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    .line 292
    .local v2, "s":Lcom/lge/telephony/LGServiceStateImpl;
    if-nez p1, :cond_1

    .line 296
    .end local v2    # "s":Lcom/lge/telephony/LGServiceStateImpl;
    :cond_0
    :goto_0
    return v3

    .line 288
    :catch_0
    move-exception v1

    .line 289
    .local v1, "ex":Ljava/lang/ClassCastException;
    goto :goto_0

    .line 296
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
    .line 108
    iget v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    return v0
.end method

.method public getDataNetworkName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 230
    iget-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    return-object v0
.end method

.method public getDataRoaming()Z
    .locals 3

    .prologue
    .line 199
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

    .line 200
    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    return v0
.end method

.method public getRATDualCarrier()I
    .locals 1

    .prologue
    .line 248
    iget v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    return v0
.end method

.method public getVoiceNetworkName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 226
    iget-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    return-object v0
.end method

.method public getVoiceRoaming()Z
    .locals 3

    .prologue
    .line 194
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

    .line 195
    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    return v0
.end method

.method public hashCode()I
    .locals 4

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 312
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
    .line 219
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

    .line 220
    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    return v0
.end method

.method public isVoiceSearching()Z
    .locals 3

    .prologue
    .line 214
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

    .line 215
    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    return v0
.end method

.method public readFrom(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "m"    # Landroid/os/Bundle;

    .prologue
    .line 142
    const-string/jumbo v0, "voiceRoaming"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    .line 143
    const-string v0, "dataRoaming"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    .line 146
    const-string/jumbo v0, "voiceSearching"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    .line 147
    const-string v0, "dataSearching"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    .line 150
    const-string/jumbo v0, "voiceNetworkName"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    .line 151
    const-string v0, "dataNetworkName"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    .line 154
    const-string v0, "Check64QAM"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    .line 157
    const-string v0, "RATDualCarrier"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    .line 159
    return-void
.end method

.method public readFrom(Landroid/os/Parcel;)V
    .locals 3
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 63
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    .line 64
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_1

    move v0, v1

    :goto_1
    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    .line 67
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_2

    move v0, v1

    :goto_2
    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    .line 68
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-eqz v0, :cond_3

    :goto_3
    iput-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    .line 71
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    .line 72
    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    .line 75
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    .line 78
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    .line 80
    return-void

    :cond_0
    move v0, v2

    .line 63
    goto :goto_0

    :cond_1
    move v0, v2

    .line 64
    goto :goto_1

    :cond_2
    move v0, v2

    .line 67
    goto :goto_2

    :cond_3
    move v1, v2

    .line 68
    goto :goto_3
.end method

.method public setCheck64QAM(I)V
    .locals 0
    .param p1, "Check64QAM"    # I

    .prologue
    .line 137
    iput p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    .line 138
    return-void
.end method

.method public setDataNetworkName(Ljava/lang/String;)V
    .locals 3
    .param p1, "dataNetworkName"    # Ljava/lang/String;

    .prologue
    .line 239
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

    .line 240
    iput-object p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    .line 241
    return-void
.end method

.method public setDataRoaming(Z)V
    .locals 3
    .param p1, "dataRoaming"    # Z

    .prologue
    .line 189
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

    .line 190
    iput-boolean p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    .line 191
    return-void
.end method

.method public setDataSearching(Z)V
    .locals 0
    .param p1, "isDataSearching"    # Z

    .prologue
    .line 210
    iput-boolean p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    .line 211
    return-void
.end method

.method public setNullState(I)V
    .locals 2
    .param p1, "state"    # I

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 114
    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    .line 115
    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    .line 118
    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    .line 119
    iput-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    .line 122
    iput-object v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    .line 123
    iput-object v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    .line 126
    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    .line 129
    iput v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    .line 131
    return-void
.end method

.method public setRATDualCarrier(I)V
    .locals 0
    .param p1, "isRATDualCarrier"    # I

    .prologue
    .line 254
    iput p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    .line 255
    return-void
.end method

.method public setVoiceNetworkName(Ljava/lang/String;)V
    .locals 3
    .param p1, "voiceNetworkName"    # Ljava/lang/String;

    .prologue
    .line 234
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

    .line 235
    iput-object p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    .line 236
    return-void
.end method

.method public setVoiceRoaming(Z)V
    .locals 3
    .param p1, "voiceRomaing"    # Z

    .prologue
    .line 184
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

    .line 185
    iput-boolean p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    .line 186
    return-void
.end method

.method public setVoiceSearching(Z)V
    .locals 0
    .param p1, "isVoiceSearching"    # Z

    .prologue
    .line 206
    iput-boolean p1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    .line 207
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 262
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "voice roaming="

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
    .line 162
    const-string/jumbo v0, "voiceRoaming"

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 163
    const-string v0, "dataRoaming"

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 166
    const-string/jumbo v0, "voiceSearching"

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 167
    const-string v0, "dataSearching"

    iget-boolean v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 170
    const-string/jumbo v0, "voiceNetworkName"

    iget-object v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 171
    const-string v0, "dataNetworkName"

    iget-object v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 174
    const-string v0, "Check64QAM"

    iget v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 177
    const-string v0, "RATDualCarrier"

    iget v1, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 179
    return-void
.end method

.method public writeTo(Landroid/os/Parcel;I)V
    .locals 3
    .param p1, "out"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 84
    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceRoaming:Z

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 85
    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataRoaming:Z

    if-eqz v0, :cond_1

    move v0, v1

    :goto_1
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 88
    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsVoiceSearching:Z

    if-eqz v0, :cond_2

    move v0, v1

    :goto_2
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 89
    iget-boolean v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsDataSearching:Z

    if-eqz v0, :cond_3

    :goto_3
    invoke-virtual {p1, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 92
    iget-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mVoiceNetworkName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 93
    iget-object v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mDataNetworkName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 96
    iget v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mCheck64QAM:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 99
    iget v0, p0, Lcom/lge/telephony/LGServiceStateImpl;->mIsRATDualCarrier:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 101
    return-void

    :cond_0
    move v0, v2

    .line 84
    goto :goto_0

    :cond_1
    move v0, v2

    .line 85
    goto :goto_1

    :cond_2
    move v0, v2

    .line 88
    goto :goto_2

    :cond_3
    move v1, v2

    .line 89
    goto :goto_3
.end method
