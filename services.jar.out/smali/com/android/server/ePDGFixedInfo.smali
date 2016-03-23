.class public Lcom/android/server/ePDGFixedInfo;
.super Ljava/lang/Object;
.source "ePDGFixedInfo.java"


# static fields
.field public static final ALL_BLOCK:I = 0x2

.field public static final LTE_BLOCK_CONNECTION_FAIL:I = 0x8

.field public static final LTE_BLOCK_REGFAIL:I = 0x1

.field public static final LTE_BLOCK_ROAMING:I = 0x2

.field public static final LTE_BLOCK_RTPFAIL:I = 0x4

.field public static final LTE_BLOCK_TEMP2:I = 0x10

.field public static final LTE_BLOCK_TEMP3:I = 0x20

.field public static final LTE_TYPE:I = 0x1

.field public static final NO_BLOCK:I = 0x3

.field public static final ePDG_BLOCK_BADSIGNAL:I = 0x2

.field public static final ePDG_BLOCK_IPSEC_FAIL:I = 0x8

.field public static final ePDG_BLOCK_REGFAIL:I = 0x1

.field public static final ePDG_BLOCK_RTPFAIL:I = 0x4

.field public static final ePDG_BLOCK_TEMP2:I = 0x10

.field public static final ePDG_BLOCK_TEMP3:I = 0x20

.field public static final ePDG_TYPE:I


# instance fields
.field mFid:I

.field mLTEFixedInfo:I

.field mePDGFixdInfo:I


# direct methods
.method public constructor <init>(I)V
    .locals 1
    .param p1, "Fid"    # I

    .prologue
    const/4 v0, 0x0

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    iput v0, p0, Lcom/android/server/ePDGFixedInfo;->mePDGFixdInfo:I

    .line 39
    iput v0, p0, Lcom/android/server/ePDGFixedInfo;->mLTEFixedInfo:I

    .line 40
    iput v0, p0, Lcom/android/server/ePDGFixedInfo;->mFid:I

    .line 45
    iput p1, p0, Lcom/android/server/ePDGFixedInfo;->mFid:I

    .line 46
    iput v0, p0, Lcom/android/server/ePDGFixedInfo;->mePDGFixdInfo:I

    .line 47
    iput v0, p0, Lcom/android/server/ePDGFixedInfo;->mLTEFixedInfo:I

    .line 48
    return-void
.end method


# virtual methods
.method public EventToString(I)Ljava/lang/String;
    .locals 1
    .param p1, "event"    # I

    .prologue
    .line 170
    packed-switch p1, :pswitch_data_0

    .line 174
    :pswitch_0
    const-string v0, "UnKnow"

    :goto_0
    return-object v0

    .line 171
    :pswitch_1
    const-string v0, "BLOCK_REGFAIL"

    goto :goto_0

    .line 172
    :pswitch_2
    const-string v0, "ePDG : BAD Sig, LTE : Roaming"

    goto :goto_0

    .line 173
    :pswitch_3
    const-string v0, "ePDG_BLOCK_RTPFAIL"

    goto :goto_0

    .line 170
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method

.method public TypetoString(I)Ljava/lang/String;
    .locals 1
    .param p1, "type"    # I

    .prologue
    .line 156
    packed-switch p1, :pswitch_data_0

    .line 161
    const-string v0, "UnKnow"

    :goto_0
    return-object v0

    .line 157
    :pswitch_0
    const-string v0, "ePDG"

    goto :goto_0

    .line 158
    :pswitch_1
    const-string v0, "LTE"

    goto :goto_0

    .line 159
    :pswitch_2
    const-string v0, "ALL Block"

    goto :goto_0

    .line 160
    :pswitch_3
    const-string v0, "NO Block"

    goto :goto_0

    .line 156
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public isBlock()I
    .locals 3

    .prologue
    const/4 v0, 0x3

    .line 97
    iget v1, p0, Lcom/android/server/ePDGFixedInfo;->mePDGFixdInfo:I

    iget v2, p0, Lcom/android/server/ePDGFixedInfo;->mLTEFixedInfo:I

    or-int/2addr v1, v2

    if-nez v1, :cond_1

    .line 117
    :cond_0
    :goto_0
    return v0

    .line 102
    :cond_1
    iget v1, p0, Lcom/android/server/ePDGFixedInfo;->mePDGFixdInfo:I

    if-eqz v1, :cond_2

    iget v1, p0, Lcom/android/server/ePDGFixedInfo;->mLTEFixedInfo:I

    if-eqz v1, :cond_2

    .line 104
    const/4 v0, 0x2

    goto :goto_0

    .line 107
    :cond_2
    iget v1, p0, Lcom/android/server/ePDGFixedInfo;->mePDGFixdInfo:I

    if-eqz v1, :cond_3

    .line 109
    const/4 v0, 0x0

    goto :goto_0

    .line 112
    :cond_3
    iget v1, p0, Lcom/android/server/ePDGFixedInfo;->mLTEFixedInfo:I

    if-eqz v1, :cond_0

    .line 114
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public isLTEBlock()Z
    .locals 3

    .prologue
    const/4 v1, 0x1

    .line 123
    invoke-virtual {p0}, Lcom/android/server/ePDGFixedInfo;->isBlock()I

    move-result v0

    .line 125
    .local v0, "myblocktype":I
    const/4 v2, 0x2

    if-ne v0, v2, :cond_1

    .line 134
    :cond_0
    :goto_0
    return v1

    .line 129
    :cond_1
    if-eq v0, v1, :cond_0

    .line 134
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public isePDGBlock()Z
    .locals 3

    .prologue
    const/4 v1, 0x1

    .line 139
    invoke-virtual {p0}, Lcom/android/server/ePDGFixedInfo;->isBlock()I

    move-result v0

    .line 141
    .local v0, "myblocktype":I
    const/4 v2, 0x2

    if-ne v0, v2, :cond_1

    .line 150
    :cond_0
    :goto_0
    return v1

    .line 145
    :cond_1
    if-eqz v0, :cond_0

    .line 150
    const/4 v1, 0x0

    goto :goto_0
.end method

.method protected log(Ljava/lang/String;)V
    .locals 3
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    .line 181
    const-string v0, "ePDG"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ePDG Block info : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 182
    return-void
.end method

.method public releaseBlockinfo(II)V
    .locals 2
    .param p1, "type"    # I
    .param p2, "event"    # I

    .prologue
    .line 83
    if-nez p1, :cond_0

    .line 85
    iget v0, p0, Lcom/android/server/ePDGFixedInfo;->mePDGFixdInfo:I

    xor-int/lit8 v1, p2, -0x1

    and-int/2addr v0, v1

    iput v0, p0, Lcom/android/server/ePDGFixedInfo;->mePDGFixdInfo:I

    .line 88
    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    .line 90
    iget v0, p0, Lcom/android/server/ePDGFixedInfo;->mLTEFixedInfo:I

    xor-int/lit8 v1, p2, -0x1

    and-int/2addr v0, v1

    iput v0, p0, Lcom/android/server/ePDGFixedInfo;->mLTEFixedInfo:I

    .line 92
    :cond_1
    return-void
.end method

.method public resetLTENetworkBlock()V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 70
    invoke-virtual {p0, v1, v1}, Lcom/android/server/ePDGFixedInfo;->releaseBlockinfo(II)V

    .line 71
    const/4 v0, 0x4

    invoke-virtual {p0, v1, v0}, Lcom/android/server/ePDGFixedInfo;->releaseBlockinfo(II)V

    .line 72
    const/16 v0, 0x8

    invoke-virtual {p0, v1, v0}, Lcom/android/server/ePDGFixedInfo;->releaseBlockinfo(II)V

    .line 73
    return-void
.end method

.method public resetePDGBlock()V
    .locals 1

    .prologue
    .line 77
    const/4 v0, 0x0

    iput v0, p0, Lcom/android/server/ePDGFixedInfo;->mePDGFixdInfo:I

    .line 78
    return-void
.end method

.method public setBlockinfo(II)V
    .locals 2
    .param p1, "type"    # I
    .param p2, "event"    # I

    .prologue
    .line 54
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " set Blcok type="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/android/server/ePDGFixedInfo;->TypetoString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " setEvent="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0, p2}, Lcom/android/server/ePDGFixedInfo;->EventToString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/server/ePDGFixedInfo;->log(Ljava/lang/String;)V

    .line 55
    if-nez p1, :cond_0

    .line 57
    iget v0, p0, Lcom/android/server/ePDGFixedInfo;->mePDGFixdInfo:I

    or-int/2addr v0, p2

    iput v0, p0, Lcom/android/server/ePDGFixedInfo;->mePDGFixdInfo:I

    .line 60
    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    .line 62
    iget v0, p0, Lcom/android/server/ePDGFixedInfo;->mLTEFixedInfo:I

    or-int/2addr v0, p2

    iput v0, p0, Lcom/android/server/ePDGFixedInfo;->mLTEFixedInfo:I

    .line 65
    :cond_1
    return-void
.end method