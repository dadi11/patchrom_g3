.class public Lcom/lge/uicc/framework/IccFileIO;
.super Lcom/lge/uicc/framework/IccHandler;
.source "IccFileIO.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/uicc/framework/IccFileIO$SMSPType;,
        Lcom/lge/uicc/framework/IccFileIO$CommonUpdated;,
        Lcom/lge/uicc/framework/IccFileIO$OcsglLoaded;,
        Lcom/lge/uicc/framework/IccFileIO$CommonLoaded;,
        Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;
    }
.end annotation


# static fields
.field private static final SIZE_OF_SMSP_NONE_ALPHA_ID:I = 0x1c

.field private static final SMSP_ADDRESS_SIZE:I = 0xc

.field protected static mEnvelopeMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;",
            ">;"
        }
    .end annotation
.end field

.field private static mInstance:Lcom/lge/uicc/framework/IccFileIO;


# instance fields
.field private mSMSPType:Lcom/lge/uicc/framework/IccFileIO$SMSPType;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Lcom/lge/uicc/framework/IccHandler;-><init>()V

    return-void
.end method

.method private SMSPtoString(Lcom/lge/uicc/framework/IccFileIO$SMSPType;)Ljava/lang/String;
    .locals 2
    .param p1, "smspData"    # Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "alphaID:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v0, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->alphaID:[B

    if-nez v0, :cond_0

    const-string v0, "NULL"

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ,ParamIndi:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-byte v1, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ParamIndicator:B

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ,Dest:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->DestAddr:[B

    invoke-static {v1}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ,Center:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    invoke-static {v1}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ,ProtoclID:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-byte v1, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ProtoclID:B

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ,Code:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-byte v1, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->CodeScheme:B

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ,Period:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-byte v1, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ValidPeriod:B

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    iget-object v0, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->alphaID:[B

    invoke-static {v0}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static synthetic access$000(Lcom/lge/uicc/framework/IccFileIO;I[B)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/lge/uicc/framework/IccFileIO;
    .param p1, "x1"    # I
    .param p2, "x2"    # [B

    .prologue
    invoke-direct {p0, p1, p2}, Lcom/lge/uicc/framework/IccFileIO;->decodeBytesToString(I[B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$100(Lcom/lge/uicc/framework/IccFileIO;Landroid/os/IRemoteCallback;Landroid/os/Bundle;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/uicc/framework/IccFileIO;
    .param p1, "x1"    # Landroid/os/IRemoteCallback;
    .param p2, "x2"    # Landroid/os/Bundle;

    .prologue
    invoke-direct {p0, p1, p2}, Lcom/lge/uicc/framework/IccFileIO;->sendResult(Landroid/os/IRemoteCallback;Landroid/os/Bundle;)V

    return-void
.end method

.method static synthetic access$200(Lcom/lge/uicc/framework/IccFileIO;II[BLjava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/uicc/framework/IccFileIO;
    .param p1, "x1"    # I
    .param p2, "x2"    # I
    .param p3, "x3"    # [B
    .param p4, "x4"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/lge/uicc/framework/IccFileIO;->processAfterUpdate(II[BLjava/lang/String;)V

    return-void
.end method

.method private analyzeSMSP([B)Lcom/lge/uicc/framework/IccFileIO$SMSPType;
    .locals 8
    .param p1, "SimData"    # [B

    .prologue
    const/16 v7, 0xc

    const/4 v6, 0x0

    if-nez p1, :cond_0

    const/4 v1, 0x0

    :goto_0
    return-object v1

    :cond_0
    new-instance v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    invoke-direct {v1, p0}, Lcom/lge/uicc/framework/IccFileIO$SMSPType;-><init>(Lcom/lge/uicc/framework/IccFileIO;)V

    .local v1, "TempSMSP":Lcom/lge/uicc/framework/IccFileIO$SMSPType;
    array-length v4, p1

    add-int/lit8 v0, v4, -0x1c

    .local v0, "NoneAlphaStartPoint":I
    const/4 v2, 0x0

    .local v2, "arrayPoint":I
    if-lez v0, :cond_1

    add-int/lit8 v4, v0, -0x1

    invoke-static {p1, v2, v4}, Lcom/lge/uicc/EfUtils;->subarray([BII)[B

    move-result-object v4

    iput-object v4, v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->alphaID:[B

    move v2, v0

    :cond_1
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "arrayPoint":I
    .local v3, "arrayPoint":I
    aget-byte v4, p1, v2

    iput-byte v4, v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ParamIndicator:B

    iget-object v4, v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->DestAddr:[B

    invoke-static {p1, v3, v4, v6, v7}, Ljava/lang/System;->arraycopy([BI[BII)V

    add-int/lit8 v2, v3, 0xc

    .end local v3    # "arrayPoint":I
    .restart local v2    # "arrayPoint":I
    iget-byte v4, v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ParamIndicator:B

    and-int/lit8 v4, v4, 0x2

    const/4 v5, 0x2

    if-eq v4, v5, :cond_2

    iget-object v4, v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    invoke-static {p1, v2, v4, v6, v7}, Ljava/lang/System;->arraycopy([BI[BII)V

    :cond_2
    add-int/lit8 v2, v2, 0xc

    iget-byte v4, v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ParamIndicator:B

    and-int/lit8 v4, v4, 0x4

    const/4 v5, 0x4

    if-eq v4, v5, :cond_3

    add-int/lit8 v3, v2, 0x1

    .end local v2    # "arrayPoint":I
    .restart local v3    # "arrayPoint":I
    aget-byte v4, p1, v2

    iput-byte v4, v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ProtoclID:B

    move v2, v3

    .end local v3    # "arrayPoint":I
    .restart local v2    # "arrayPoint":I
    :goto_1
    iget-byte v4, v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ParamIndicator:B

    and-int/lit8 v4, v4, 0x8

    const/16 v5, 0x8

    if-eq v4, v5, :cond_4

    add-int/lit8 v3, v2, 0x1

    .end local v2    # "arrayPoint":I
    .restart local v3    # "arrayPoint":I
    aget-byte v4, p1, v2

    iput-byte v4, v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->CodeScheme:B

    move v2, v3

    .end local v3    # "arrayPoint":I
    .restart local v2    # "arrayPoint":I
    :goto_2
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "arrayPoint":I
    .restart local v3    # "arrayPoint":I
    aget-byte v4, p1, v2

    iput-byte v4, v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ValidPeriod:B

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "SMSP: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-direct {p0, v1}, Lcom/lge/uicc/framework/IccFileIO;->SMSPtoString(Lcom/lge/uicc/framework/IccFileIO$SMSPType;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/lge/uicc/framework/IccFileIO;->logp(Ljava/lang/String;)V

    goto :goto_0

    .end local v3    # "arrayPoint":I
    .restart local v2    # "arrayPoint":I
    :cond_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_2
.end method

.method private cdmaMdnBytesToString([B)Ljava/lang/String;
    .locals 10
    .param p1, "mdnBytes"    # [B

    .prologue
    const/4 v7, 0x0

    const/16 v9, 0x9

    const/4 v8, 0x0

    aget-byte v8, p1, v8

    and-int/lit8 v5, v8, 0xf

    .local v5, "mdnDigitsNum":I
    if-nez v5, :cond_1

    :cond_0
    :goto_0
    return-object v7

    :cond_1
    const/4 v1, 0x0

    .local v1, "count":I
    new-array v4, v5, [C

    .local v4, "mdnChars":[C
    const/4 v3, 0x1

    .local v3, "i":I
    move v2, v1

    .end local v1    # "count":I
    .local v2, "count":I
    :goto_1
    if-ge v2, v5, :cond_5

    array-length v8, p1

    if-ge v3, v8, :cond_5

    aget-byte v0, p1, v3

    .local v0, "b":B
    and-int/lit8 v6, v0, 0xf

    .local v6, "v":I
    if-le v6, v9, :cond_2

    const/4 v6, 0x0

    :cond_2
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "count":I
    .restart local v1    # "count":I
    add-int/lit8 v8, v6, 0x30

    int-to-char v8, v8

    aput-char v8, v4, v2

    if-ne v1, v5, :cond_3

    .end local v0    # "b":B
    .end local v6    # "v":I
    :goto_2
    if-ne v1, v5, :cond_0

    new-instance v7, Ljava/lang/String;

    invoke-direct {v7, v4}, Ljava/lang/String;-><init>([C)V

    goto :goto_0

    .restart local v0    # "b":B
    .restart local v6    # "v":I
    :cond_3
    shr-int/lit8 v8, v0, 0x4

    and-int/lit8 v6, v8, 0xf

    if-le v6, v9, :cond_4

    const/4 v6, 0x0

    :cond_4
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "count":I
    .restart local v2    # "count":I
    add-int/lit8 v8, v6, 0x30

    int-to-char v8, v8

    aput-char v8, v4, v1

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .end local v0    # "b":B
    .end local v6    # "v":I
    :cond_5
    move v1, v2

    .end local v2    # "count":I
    .restart local v1    # "count":I
    goto :goto_2
.end method

.method private cdmaMdnStringToBytes(Ljava/lang/String;)[B
    .locals 12
    .param p1, "mdnStr"    # Ljava/lang/String;

    .prologue
    const/16 v11, 0xa

    const/4 v10, 0x0

    const/4 v7, 0x0

    const/16 v9, 0x9

    if-nez p1, :cond_0

    move-object v5, v7

    :goto_0
    return-object v5

    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v6

    .local v6, "sz":I
    if-eqz v6, :cond_1

    const/16 v8, 0xf

    if-le v6, v8, :cond_2

    :cond_1
    move-object v5, v7

    goto :goto_0

    :cond_2
    const/16 v8, 0xb

    new-array v5, v8, [B

    .local v5, "mdnBytes":[B
    and-int/lit8 v8, v6, 0xf

    int-to-byte v8, v8

    aput-byte v8, v5, v10

    const/4 v0, 0x0

    .local v0, "count":I
    const/4 v3, 0x1

    .local v3, "i":I
    move v1, v0

    .end local v0    # "count":I
    .local v1, "count":I
    :goto_1
    if-ge v3, v9, :cond_b

    if-ne v1, v6, :cond_3

    const/4 v8, -0x1

    aput-byte v8, v5, v3

    move v0, v1

    .end local v1    # "count":I
    .restart local v0    # "count":I
    :goto_2
    add-int/lit8 v3, v3, 0x1

    move v1, v0

    .end local v0    # "count":I
    .restart local v1    # "count":I
    goto :goto_1

    :cond_3
    add-int/lit8 v0, v1, 0x1

    .end local v1    # "count":I
    .restart local v0    # "count":I
    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v8

    add-int/lit8 v4, v8, -0x30

    .local v4, "lo":I
    if-ltz v4, :cond_4

    if-le v4, v9, :cond_5

    :cond_4
    move-object v5, v7

    goto :goto_0

    :cond_5
    if-nez v4, :cond_6

    const/16 v4, 0xa

    :cond_6
    if-ne v0, v6, :cond_7

    or-int/lit16 v8, v4, 0xf0

    int-to-byte v8, v8

    aput-byte v8, v5, v3

    goto :goto_2

    :cond_7
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "count":I
    .restart local v1    # "count":I
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v8

    add-int/lit8 v2, v8, -0x30

    .local v2, "hi":I
    if-ltz v2, :cond_8

    if-le v2, v9, :cond_9

    :cond_8
    move-object v5, v7

    goto :goto_0

    :cond_9
    if-nez v2, :cond_a

    const/16 v2, 0xa

    :cond_a
    shl-int/lit8 v8, v2, 0x4

    or-int/2addr v8, v4

    int-to-byte v8, v8

    aput-byte v8, v5, v3

    move v0, v1

    .end local v1    # "count":I
    .restart local v0    # "count":I
    goto :goto_2

    .end local v0    # "count":I
    .end local v2    # "hi":I
    .end local v4    # "lo":I
    .restart local v1    # "count":I
    :cond_b
    aput-byte v11, v5, v9

    aput-byte v10, v5, v11

    goto :goto_0
.end method

.method private composeSMSP(Lcom/lge/uicc/framework/IccFileIO$SMSPType;)[B
    .locals 6
    .param p1, "smspData"    # Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    .prologue
    const/4 v4, 0x0

    if-nez p1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "SMSP: "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-direct {p0, p1}, Lcom/lge/uicc/framework/IccFileIO;->SMSPtoString(Lcom/lge/uicc/framework/IccFileIO$SMSPType;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/IccFileIO;->logp(Ljava/lang/String;)V

    iget-object v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->alphaID:[B

    if-nez v3, :cond_3

    move v3, v4

    :goto_1
    iget-object v5, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->DestAddr:[B

    array-length v5, v5

    add-int/2addr v3, v5

    iget-object v5, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    array-length v5, v5

    add-int/2addr v3, v5

    add-int/lit8 v3, v3, 0x4

    new-array v0, v3, [B

    .local v0, "SimData":[B
    const/4 v1, 0x0

    .local v1, "arrayPoint":I
    iget-object v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->alphaID:[B

    if-eqz v3, :cond_1

    iget-object v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->alphaID:[B

    iget-object v5, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->alphaID:[B

    array-length v5, v5

    invoke-static {v3, v4, v0, v1, v5}, Ljava/lang/System;->arraycopy([BI[BII)V

    iget-object v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->alphaID:[B

    array-length v3, v3

    add-int/2addr v1, v3

    :cond_1
    iget-object v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    aget-byte v3, v3, v4

    const/4 v5, -0x1

    if-eq v3, v5, :cond_2

    iget-object v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    aget-byte v3, v3, v4

    if-nez v3, :cond_4

    :cond_2
    iget-byte v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ParamIndicator:B

    or-int/lit8 v3, v3, 0x2

    int-to-byte v3, v3

    iput-byte v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ParamIndicator:B

    :goto_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "SVCCenterAddr[0] : "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v5, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    aget-byte v5, v5, v4

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, " ParamIndicator: "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-byte v5, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ParamIndicator:B

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/IccFileIO;->logp(Ljava/lang/String;)V

    add-int/lit8 v2, v1, 0x1

    .end local v1    # "arrayPoint":I
    .local v2, "arrayPoint":I
    iget-byte v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ParamIndicator:B

    aput-byte v3, v0, v1

    iget-object v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->DestAddr:[B

    iget-object v5, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->DestAddr:[B

    array-length v5, v5

    invoke-static {v3, v4, v0, v2, v5}, Ljava/lang/System;->arraycopy([BI[BII)V

    iget-object v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->DestAddr:[B

    array-length v3, v3

    add-int v1, v2, v3

    .end local v2    # "arrayPoint":I
    .restart local v1    # "arrayPoint":I
    iget-object v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    iget-object v5, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    array-length v5, v5

    invoke-static {v3, v4, v0, v1, v5}, Ljava/lang/System;->arraycopy([BI[BII)V

    iget-object v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    array-length v3, v3

    add-int/2addr v1, v3

    add-int/lit8 v2, v1, 0x1

    .end local v1    # "arrayPoint":I
    .restart local v2    # "arrayPoint":I
    iget-byte v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ProtoclID:B

    aput-byte v3, v0, v1

    add-int/lit8 v1, v2, 0x1

    .end local v2    # "arrayPoint":I
    .restart local v1    # "arrayPoint":I
    iget-byte v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->CodeScheme:B

    aput-byte v3, v0, v2

    iget-byte v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ValidPeriod:B

    aput-byte v3, v0, v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SMSPData "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {v0}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/uicc/framework/IccFileIO;->logp(Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v0    # "SimData":[B
    .end local v1    # "arrayPoint":I
    :cond_3
    iget-object v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->alphaID:[B

    array-length v3, v3

    goto/16 :goto_1

    .restart local v0    # "SimData":[B
    .restart local v1    # "arrayPoint":I
    :cond_4
    iget-byte v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ParamIndicator:B

    and-int/lit16 v3, v3, 0xfd

    int-to-byte v3, v3

    iput-byte v3, p1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->ParamIndicator:B

    goto :goto_2
.end method

.method private decodeBytesToString(I[B)Ljava/lang/String;
    .locals 4
    .param p1, "efid"    # I
    .param p2, "dataBytes"    # [B

    .prologue
    const/4 v3, 0x3

    const/4 v0, 0x0

    .local v0, "dataString":Ljava/lang/String;
    sparse-switch p1, :sswitch_data_0

    :cond_0
    :goto_0
    return-object v0

    :sswitch_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EFRead "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {p2}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/lge/uicc/framework/IccFileIO;->logp(Ljava/lang/String;)V

    invoke-direct {p0, p2}, Lcom/lge/uicc/framework/IccFileIO;->analyzeSMSP([B)Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/uicc/framework/IccFileIO;->mSMSPType:Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SMSP-"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/uicc/framework/IccFileIO;->mSMSPType:Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    invoke-direct {p0, v3}, Lcom/lge/uicc/framework/IccFileIO;->SMSPtoString(Lcom/lge/uicc/framework/IccFileIO$SMSPType;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/lge/uicc/framework/IccFileIO;->logp(Ljava/lang/String;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SCaddr:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/uicc/framework/IccFileIO;->mSMSPType:Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    iget-object v3, v3, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    invoke-direct {p0, v3}, Lcom/lge/uicc/framework/IccFileIO;->decodeSCAddr([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/lge/uicc/framework/IccFileIO;->logp(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/lge/uicc/framework/IccFileIO;->mSMSPType:Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    iget-object v2, v2, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    invoke-direct {p0, v2}, Lcom/lge/uicc/framework/IccFileIO;->decodeSCAddr([B)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :sswitch_1
    invoke-direct {p0, p2}, Lcom/lge/uicc/framework/IccFileIO;->cdmaMdnBytesToString([B)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :sswitch_2
    invoke-static {p2}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :sswitch_3
    invoke-static {p2}, Lcom/lge/uicc/EfUtils;->bcdToString([B)Ljava/lang/String;

    move-result-object v1

    .local v1, "tmpString":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-le v2, v3, :cond_0

    invoke-virtual {v1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .end local v1    # "tmpString":Ljava/lang/String;
    :sswitch_4
    invoke-static {p2}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_5
    invoke-direct {p0, p2}, Lcom/lge/uicc/framework/IccFileIO;->decodeMultiImsiLGU([B)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_6
    invoke-direct {p0, p2}, Lcom/lge/uicc/framework/IccFileIO;->decodeOplmn([B)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_7
    invoke-direct {p0, p2}, Lcom/lge/uicc/framework/IccFileIO;->decodeUiccVersionLGU([B)Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    :sswitch_data_0
    .sparse-switch
        0x2f30 -> :sswitch_7
        0x2f40 -> :sswitch_5
        0x2f41 -> :sswitch_5
        0x2f50 -> :sswitch_2
        0x6f07 -> :sswitch_3
        0x6f31 -> :sswitch_4
        0x6f38 -> :sswitch_4
        0x6f42 -> :sswitch_0
        0x6f44 -> :sswitch_1
        0x6f61 -> :sswitch_6
    .end sparse-switch
.end method

.method private decodeMultiImsiLGU([B)Ljava/lang/String;
    .locals 7
    .param p1, "dataBytes"    # [B

    .prologue
    const/4 v5, 0x3

    const/4 v6, 0x1

    array-length v3, p1

    const/16 v4, 0x23f

    if-eq v3, v4, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v4, 0x0

    invoke-static {p1, v4, v6}, Lcom/lge/uicc/EfUtils;->bytesToHexString([BII)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "dataString":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x9

    invoke-static {p1, v6, v4}, Lcom/lge/uicc/EfUtils;->bcdToString([BII)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0xa

    .local v1, "offset":I
    :goto_1
    add-int/lit8 v3, v1, 0x5

    const/16 v4, 0x1ff

    if-ge v3, v4, :cond_1

    invoke-static {p1, v1, v5}, Lcom/lge/uicc/EfUtils;->bcdToString([BII)Ljava/lang/String;

    move-result-object v2

    .local v2, "plmn":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_2

    .end local v2    # "plmn":Ljava/lang/String;
    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x1fe

    const/16 v5, 0x2c

    invoke-static {p1, v4, v5}, Lcom/android/internal/telephony/uicc/IccUtils;->adnStringFieldToString([BII)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ",..."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x22a

    invoke-static {p1, v4, v6}, Lcom/lge/uicc/EfUtils;->bytesToHexString([BII)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "|"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x22b

    const/16 v5, 0x14

    invoke-static {p1, v4, v5}, Lcom/android/internal/telephony/uicc/IccUtils;->adnStringFieldToString([BII)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_0

    .restart local v2    # "plmn":Ljava/lang/String;
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ","

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    add-int/lit8 v1, v1, 0x5

    goto/16 :goto_1
.end method

.method private decodeOplmn([B)Ljava/lang/String;
    .locals 5
    .param p1, "dataBytes"    # [B

    .prologue
    const-string v0, ""

    .local v0, "dataString":Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "offset":I
    :goto_0
    add-int/lit8 v3, v1, 0x5

    array-length v4, p1

    if-ge v3, v4, :cond_0

    const/4 v3, 0x3

    invoke-static {p1, v1, v3}, Lcom/lge/uicc/EfUtils;->bcdToString([BII)Ljava/lang/String;

    move-result-object v2

    .local v2, "plmn":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_1

    .end local v2    # "plmn":Ljava/lang/String;
    :cond_0
    return-object v0

    .restart local v2    # "plmn":Ljava/lang/String;
    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ","

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    add-int/lit8 v1, v1, 0x5

    goto :goto_0
.end method

.method private decodeSCAddr([B)Ljava/lang/String;
    .locals 5
    .param p1, "scData"    # [B

    .prologue
    const/4 v4, 0x1

    if-nez p1, :cond_1

    const/4 v1, 0x0

    :cond_0
    :goto_0
    return-object v1

    :cond_1
    const-string v1, ""

    .local v1, "scAddrString":Ljava/lang/String;
    const/4 v2, 0x0

    aget-byte v0, p1, v2

    .local v0, "length":I
    if-lez v0, :cond_0

    const/4 v2, 0x2

    add-int/lit8 v3, v0, -0x1

    invoke-static {p1, v2, v3}, Lcom/lge/uicc/EfUtils;->bcdToString([BII)Ljava/lang/String;

    move-result-object v1

    aget-byte v2, p1, v4

    and-int/lit8 v2, v2, 0x70

    shr-int/lit8 v2, v2, 0x4

    if-ne v2, v4, :cond_0

    const-string v2, "+"

    invoke-virtual {v2, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0
.end method

.method private decodeUiccVersionLGU([B)Ljava/lang/String;
    .locals 8
    .param p1, "data"    # [B

    .prologue
    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    array-length v2, p1

    const/4 v3, 0x7

    if-ge v2, v3, :cond_0

    const/4 v2, 0x0

    :goto_0
    return-object v2

    :cond_0
    new-array v1, v7, [Ljava/lang/String;

    const-string v2, "??"

    aput-object v2, v1, v4

    const-string v2, "Contact-Only"

    aput-object v2, v1, v5

    const-string v2, "NFC"

    aput-object v2, v1, v6

    .local v1, "type":[Ljava/lang/String;
    aget-byte v2, p1, v4

    and-int/lit16 v0, v2, 0xff

    .local v0, "t":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    array-length v2, v1

    if-ge v0, v2, :cond_1

    aget-object v2, v1, v0

    :goto_1
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "|"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    aget-byte v3, p1, v5

    and-int/lit16 v3, v3, 0xff

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ","

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    aget-byte v3, p1, v6

    and-int/lit16 v3, v3, 0xff

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ","

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    aget-byte v3, p1, v7

    and-int/lit16 v3, v3, 0xff

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ","

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/4 v3, 0x4

    aget-byte v3, p1, v3

    and-int/lit16 v3, v3, 0xff

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "|"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/4 v3, 0x5

    const/4 v4, 0x6

    invoke-static {p1, v3, v4}, Lcom/lge/uicc/EfUtils;->subarray([BII)[B

    move-result-object v3

    invoke-static {v3}, Lcom/lge/uicc/EfUtils;->bytesToInt([B)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_1
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    goto :goto_1
.end method

.method private encodeSCAddr(Ljava/lang/String;[B)[B
    .locals 12
    .param p1, "newSCAddr"    # Ljava/lang/String;
    .param p2, "oldSCAddr"    # [B

    .prologue
    const/4 v11, 0x0

    const/4 v10, -0x1

    const/4 v9, 0x1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v7

    if-nez v7, :cond_0

    const/16 v7, 0xc

    new-array v4, v7, [B

    .local v4, "scData":[B
    invoke-static {v4, v10}, Ljava/util/Arrays;->fill([BB)V

    const-string v7, "SMSPData SCAddr is Null: "

    invoke-virtual {p0, v7}, Lcom/lge/uicc/framework/IccFileIO;->logd(Ljava/lang/String;)V

    .end local v4    # "scData":[B
    :goto_0
    return-object v4

    :cond_0
    const/16 v7, 0x2b

    invoke-virtual {p1, v11}, Ljava/lang/String;->charAt(I)C

    move-result v8

    if-ne v7, v8, :cond_1

    const/4 v0, 0x1

    .local v0, "InternationalIndicator":B
    :goto_1
    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    .local v6, "tempString":Ljava/lang/String;
    :try_start_0
    const-string v7, "UTF-8"

    invoke-virtual {v6, v7}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v5

    .local v5, "tempData":[B
    array-length v7, p2

    new-array v4, v7, [B

    .restart local v4    # "scData":[B
    invoke-static {v4, v10}, Ljava/util/Arrays;->fill([BB)V

    array-length v7, v5

    div-int/lit8 v7, v7, 0x2

    array-length v8, v5

    rem-int/lit8 v8, v8, 0x2

    add-int/2addr v7, v8

    add-int/lit8 v7, v7, 0x1

    int-to-byte v7, v7

    aput-byte v7, v4, v11

    aget-byte v7, p2, v9

    if-eq v7, v10, :cond_2

    aget-byte v7, p2, v9

    if-eqz v7, :cond_2

    shl-int/lit8 v7, v0, 0x4

    aget-byte v8, p2, v9

    and-int/lit16 v8, v8, 0x8f

    or-int/2addr v7, v8

    int-to-byte v7, v7

    aput-byte v7, v4, v9

    :goto_2
    const/4 v2, 0x0

    .local v2, "i":I
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_3
    add-int/lit8 v7, v2, 0x1

    array-length v8, v5

    if-ge v7, v8, :cond_3

    add-int/lit8 v7, v3, 0x2

    aget-byte v8, v5, v2

    and-int/lit8 v8, v8, 0xf

    add-int/lit8 v9, v2, 0x1

    aget-byte v9, v5, v9

    and-int/lit8 v9, v9, 0xf

    shl-int/lit8 v9, v9, 0x4

    or-int/2addr v8, v9

    int-to-byte v8, v8

    aput-byte v8, v4, v7

    add-int/lit8 v2, v2, 0x2

    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .end local v0    # "InternationalIndicator":B
    .end local v2    # "i":I
    .end local v3    # "j":I
    .end local v4    # "scData":[B
    .end local v5    # "tempData":[B
    .end local v6    # "tempString":Ljava/lang/String;
    :cond_1
    const/4 v0, 0x0

    .restart local v0    # "InternationalIndicator":B
    goto :goto_1

    .restart local v6    # "tempString":Ljava/lang/String;
    :catch_0
    move-exception v1

    .local v1, "e":Ljava/io/UnsupportedEncodingException;
    move-object v4, p2

    goto :goto_0

    .end local v1    # "e":Ljava/io/UnsupportedEncodingException;
    .restart local v4    # "scData":[B
    .restart local v5    # "tempData":[B
    :cond_2
    shl-int/lit8 v7, v0, 0x4

    or-int/lit16 v7, v7, 0x81

    int-to-byte v7, v7

    aput-byte v7, v4, v9

    goto :goto_2

    .restart local v2    # "i":I
    .restart local v3    # "j":I
    :cond_3
    array-length v7, v5

    rem-int/lit8 v7, v7, 0x2

    if-eqz v7, :cond_4

    add-int/lit8 v7, v3, 0x2

    aget-byte v8, v5, v2

    and-int/lit8 v8, v8, 0xf

    or-int/lit16 v8, v8, 0xf0

    int-to-byte v8, v8

    aput-byte v8, v4, v7

    :cond_4
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "scData"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-static {v4}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v7}, Lcom/lge/uicc/framework/IccFileIO;->logp(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method private encodeStringToBytes(ILjava/lang/String;)[B
    .locals 3
    .param p1, "efid"    # I
    .param p2, "dataString"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    .local v0, "dataBytes":[B
    sparse-switch p1, :sswitch_data_0

    :goto_0
    return-object v0

    :sswitch_0
    iget-object v1, p0, Lcom/lge/uicc/framework/IccFileIO;->mSMSPType:Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    if-nez v1, :cond_0

    const-string v1, "mSMSPType is null"

    invoke-virtual {p0, v1}, Lcom/lge/uicc/framework/IccFileIO;->logd(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/lge/uicc/framework/IccFileIO;->mSMSPType:Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    iget-object v2, p0, Lcom/lge/uicc/framework/IccFileIO;->mSMSPType:Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    iget-object v2, v2, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    invoke-direct {p0, p2, v2}, Lcom/lge/uicc/framework/IccFileIO;->encodeSCAddr(Ljava/lang/String;[B)[B

    move-result-object v2

    iput-object v2, v1, Lcom/lge/uicc/framework/IccFileIO$SMSPType;->SVCCenterAddr:[B

    iget-object v1, p0, Lcom/lge/uicc/framework/IccFileIO;->mSMSPType:Lcom/lge/uicc/framework/IccFileIO$SMSPType;

    invoke-direct {p0, v1}, Lcom/lge/uicc/framework/IccFileIO;->composeSMSP(Lcom/lge/uicc/framework/IccFileIO$SMSPType;)[B

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EFWrite "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/lge/uicc/framework/IccFileIO;->logp(Ljava/lang/String;)V

    goto :goto_0

    :sswitch_1
    invoke-direct {p0, p2}, Lcom/lge/uicc/framework/IccFileIO;->cdmaMdnStringToBytes(Ljava/lang/String;)[B

    move-result-object v0

    goto :goto_0

    :sswitch_2
    if-eqz p2, :cond_1

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_2

    :cond_1
    const-string p2, "00"

    :cond_2
    invoke-static {p2}, Lcom/lge/uicc/EfUtils;->hexStringToBytes(Ljava/lang/String;)[B

    move-result-object v0

    goto :goto_0

    :sswitch_data_0
    .sparse-switch
        0x2f50 -> :sswitch_2
        0x6f42 -> :sswitch_0
        0x6f44 -> :sswitch_1
    .end sparse-switch
.end method

.method protected static envelope(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)Z
    .locals 1
    .param p0, "in"    # Landroid/os/Bundle;
    .param p1, "reply"    # Landroid/os/IRemoteCallback;

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IccFileIO;->mInstance:Lcom/lge/uicc/framework/IccFileIO;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/uicc/framework/IccFileIO;->mInstance:Lcom/lge/uicc/framework/IccFileIO;

    invoke-direct {v0, p0, p1}, Lcom/lge/uicc/framework/IccFileIO;->sendEnvelope(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    const/4 v0, 0x1

    goto :goto_0
.end method

.method private processAfterUpdate(II[BLjava/lang/String;)V
    .locals 1
    .param p1, "slot"    # I
    .param p2, "efid"    # I
    .param p3, "dataBytes"    # [B
    .param p4, "dataString"    # Ljava/lang/String;

    .prologue
    packed-switch p2, :pswitch_data_0

    :cond_0
    :goto_0
    :pswitch_0
    return-void

    :pswitch_1
    if-eqz p4, :cond_0

    const-string v0, "scaddress"

    invoke-static {v0, p4}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_0

    :pswitch_2
    if-eqz p4, :cond_0

    const-string v0, "mdn"

    invoke-static {v0, p4}, Lcom/lge/uicc/framework/LGUICC;->setConfig(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_0

    :pswitch_data_0
    .packed-switch 0x6f42
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method protected static read(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)Z
    .locals 1
    .param p0, "in"    # Landroid/os/Bundle;
    .param p1, "reply"    # Landroid/os/IRemoteCallback;

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IccFileIO;->mInstance:Lcom/lge/uicc/framework/IccFileIO;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/uicc/framework/IccFileIO;->mInstance:Lcom/lge/uicc/framework/IccFileIO;

    invoke-direct {v0, p0, p1}, Lcom/lge/uicc/framework/IccFileIO;->readRecord(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    const/4 v0, 0x1

    goto :goto_0
.end method

.method private readRecord(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V
    .locals 10
    .param p1, "in"    # Landroid/os/Bundle;
    .param p2, "reply"    # Landroid/os/IRemoteCallback;

    .prologue
    const/4 v6, 0x2

    const/4 v8, 0x0

    const/4 v2, 0x1

    if-eqz p1, :cond_0

    if-nez p2, :cond_1

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "read: in="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ", reply="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccFileIO;->loge(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_1
    const-string v0, "int.slot"

    invoke-virtual {p1, v0, v8}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v1

    .local v1, "slot":I
    const-string v0, "int.efid"

    invoke-virtual {p1, v0, v8}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v3

    .local v3, "efid":I
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "read: slot="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, ", efid="

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "%x"

    new-array v5, v2, [Ljava/lang/Object;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v5, v8

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccFileIO;->logd(Ljava/lang/String;)V

    sparse-switch v3, :sswitch_data_0

    const-string v0, "Not supported efid"

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccFileIO;->loge(Ljava/lang/String;)V

    const/4 v0, 0x0

    invoke-direct {p0, p2, v0}, Lcom/lge/uicc/framework/IccFileIO;->sendResult(Landroid/os/IRemoteCallback;Landroid/os/Bundle;)V

    goto :goto_0

    :sswitch_0
    new-instance v0, Lcom/lge/uicc/framework/IccFileIO$CommonLoaded;

    invoke-direct {v0, p0, p1, p2}, Lcom/lge/uicc/framework/IccFileIO$CommonLoaded;-><init>(Lcom/lge/uicc/framework/IccFileIO;Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccFileIO;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordLoaded;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v1, v2, v3, v0}, Lcom/lge/uicc/framework/IccFileIO;->loadEFTransparent(IIILandroid/os/Message;)V

    goto :goto_0

    :sswitch_1
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v0

    const/16 v4, 0x7d0

    if-eq v0, v4, :cond_2

    const-string v0, "byte[].result"

    new-array v2, v2, [B

    aput-byte v8, v2, v8

    invoke-virtual {p1, v0, v2}, Landroid/os/Bundle;->putByteArray(Ljava/lang/String;[B)V

    invoke-direct {p0, p2, p1}, Lcom/lge/uicc/framework/IccFileIO;->sendResult(Landroid/os/IRemoteCallback;Landroid/os/Bundle;)V

    goto :goto_0

    :cond_2
    new-instance v0, Lcom/lge/uicc/framework/IccFileIO$CommonLoaded;

    invoke-direct {v0, p0, p1, p2}, Lcom/lge/uicc/framework/IccFileIO$CommonLoaded;-><init>(Lcom/lge/uicc/framework/IccFileIO;Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccFileIO;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordLoaded;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v1, v2, v3, v0}, Lcom/lge/uicc/framework/IccFileIO;->loadEFTransparent(IIILandroid/os/Message;)V

    goto :goto_0

    :sswitch_2
    new-instance v0, Lcom/lge/uicc/framework/IccFileIO$CommonLoaded;

    invoke-direct {v0, p0, p1, p2}, Lcom/lge/uicc/framework/IccFileIO$CommonLoaded;-><init>(Lcom/lge/uicc/framework/IccFileIO;Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccFileIO;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordLoaded;)Landroid/os/Message;

    move-result-object v5

    move-object v0, p0

    move v4, v2

    invoke-virtual/range {v0 .. v5}, Lcom/lge/uicc/framework/IccFileIO;->loadEFLinearFixed(IIIILandroid/os/Message;)V

    goto/16 :goto_0

    :sswitch_3
    new-instance v0, Lcom/lge/uicc/framework/IccFileIO$OcsglLoaded;

    invoke-direct {v0, p0, p1, p2}, Lcom/lge/uicc/framework/IccFileIO$OcsglLoaded;-><init>(Lcom/lge/uicc/framework/IccFileIO;Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccFileIO;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordLoaded;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v1, v2, v3, v0}, Lcom/lge/uicc/framework/IccFileIO;->loadEFLinearFixedAll(IIILandroid/os/Message;)V

    goto/16 :goto_0

    :sswitch_4
    new-instance v0, Lcom/lge/uicc/framework/IccFileIO$CommonLoaded;

    invoke-direct {v0, p0, p1, p2}, Lcom/lge/uicc/framework/IccFileIO$CommonLoaded;-><init>(Lcom/lge/uicc/framework/IccFileIO;Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccFileIO;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordLoaded;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v1, v6, v3, v0}, Lcom/lge/uicc/framework/IccFileIO;->loadEFTransparent(IIILandroid/os/Message;)V

    goto/16 :goto_0

    :sswitch_5
    new-instance v0, Lcom/lge/uicc/framework/IccFileIO$CommonLoaded;

    invoke-direct {v0, p0, p1, p2}, Lcom/lge/uicc/framework/IccFileIO$CommonLoaded;-><init>(Lcom/lge/uicc/framework/IccFileIO;Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    invoke-virtual {p0, v0}, Lcom/lge/uicc/framework/IccFileIO;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordLoaded;)Landroid/os/Message;

    move-result-object v9

    move-object v4, p0

    move v5, v1

    move v7, v3

    move v8, v2

    invoke-virtual/range {v4 .. v9}, Lcom/lge/uicc/framework/IccFileIO;->loadEFLinearFixed(IIIILandroid/os/Message;)V

    goto/16 :goto_0

    :sswitch_data_0
    .sparse-switch
        0x2f30 -> :sswitch_0
        0x2f39 -> :sswitch_0
        0x2f40 -> :sswitch_1
        0x2f41 -> :sswitch_1
        0x2f42 -> :sswitch_1
        0x2f43 -> :sswitch_1
        0x2f50 -> :sswitch_1
        0x2fe2 -> :sswitch_0
        0x2fe7 -> :sswitch_0
        0x2ff0 -> :sswitch_0
        0x4f1c -> :sswitch_0
        0x4f22 -> :sswitch_0
        0x4f55 -> :sswitch_0
        0x4f84 -> :sswitch_3
        0x6f07 -> :sswitch_0
        0x6f31 -> :sswitch_4
        0x6f38 -> :sswitch_4
        0x6f42 -> :sswitch_2
        0x6f44 -> :sswitch_5
        0x6f61 -> :sswitch_0
        0x6f73 -> :sswitch_0
        0x6f7b -> :sswitch_0
        0x6f7e -> :sswitch_0
    .end sparse-switch
.end method

.method protected static registerEnvelope(Ljava/lang/String;Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;)Z
    .locals 1
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "env"    # Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IccFileIO;->mEnvelopeMap:Ljava/util/HashMap;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/uicc/framework/IccFileIO;->mEnvelopeMap:Ljava/util/HashMap;

    invoke-virtual {v0, p0, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v0, 0x1

    goto :goto_0
.end method

.method private sendEnvelope(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V
    .locals 7
    .param p1, "in"    # Landroid/os/Bundle;
    .param p2, "reply"    # Landroid/os/IRemoteCallback;

    .prologue
    if-eqz p1, :cond_0

    if-nez p2, :cond_1

    :cond_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "envelope: in="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ", reply="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/lge/uicc/framework/IccFileIO;->loge(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_1
    const-string v5, "String.envName"

    invoke-virtual {p1, v5}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .local v1, "envName":Ljava/lang/String;
    const-string v5, "String.data"

    invoke-virtual {p1, v5}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "data":Ljava/lang/String;
    const/4 v2, 0x0

    .local v2, "envOp":Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;
    sget-object v5, Lcom/lge/uicc/framework/IccFileIO;->mEnvelopeMap:Ljava/util/HashMap;

    if-eqz v5, :cond_2

    sget-object v5, Lcom/lge/uicc/framework/IccFileIO;->mEnvelopeMap:Ljava/util/HashMap;

    invoke-virtual {v5, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .end local v2    # "envOp":Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;
    check-cast v2, Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;

    .restart local v2    # "envOp":Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;
    :cond_2
    const-string v4, "NOT_SUPPORT"

    .local v4, "result":Ljava/lang/String;
    if-eqz v2, :cond_3

    invoke-interface {v2, v0}, Lcom/lge/uicc/framework/IccFileIO$EnvelopeOperation;->send(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :cond_3
    move-object v3, p1

    .local v3, "out":Landroid/os/Bundle;
    const-string v5, "String.data"

    invoke-virtual {v3, v5}, Landroid/os/Bundle;->remove(Ljava/lang/String;)V

    const-string v5, "String.result"

    invoke-virtual {v3, v5, v4}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "envelope: send result "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/lge/uicc/framework/IccFileIO;->logd(Ljava/lang/String;)V

    invoke-direct {p0, p2, v3}, Lcom/lge/uicc/framework/IccFileIO;->sendResult(Landroid/os/IRemoteCallback;Landroid/os/Bundle;)V

    goto :goto_0
.end method

.method private sendResult(Landroid/os/IRemoteCallback;Landroid/os/Bundle;)V
    .locals 3
    .param p1, "reply"    # Landroid/os/IRemoteCallback;
    .param p2, "out"    # Landroid/os/Bundle;

    .prologue
    if-nez p1, :cond_0

    const-string v1, "reply is null"

    invoke-virtual {p0, v1}, Lcom/lge/uicc/framework/IccFileIO;->loge(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    :try_start_0
    invoke-interface {p1, p2}, Landroid/os/IRemoteCallback;->sendResult(Landroid/os/Bundle;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "re":Landroid/os/RemoteException;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "fail to reply: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/lge/uicc/framework/IccFileIO;->loge(Ljava/lang/String;)V

    goto :goto_0
.end method

.method protected static setup()V
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IccFileIO;->mInstance:Lcom/lge/uicc/framework/IccFileIO;

    if-nez v0, :cond_0

    new-instance v0, Lcom/lge/uicc/framework/IccFileIO;

    invoke-direct {v0}, Lcom/lge/uicc/framework/IccFileIO;-><init>()V

    sput-object v0, Lcom/lge/uicc/framework/IccFileIO;->mInstance:Lcom/lge/uicc/framework/IccFileIO;

    :cond_0
    sget-object v0, Lcom/lge/uicc/framework/IccFileIO;->mEnvelopeMap:Ljava/util/HashMap;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/lge/uicc/framework/IccFileIO;->mEnvelopeMap:Ljava/util/HashMap;

    :cond_1
    return-void
.end method

.method protected static update(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)Z
    .locals 1
    .param p0, "in"    # Landroid/os/Bundle;
    .param p1, "reply"    # Landroid/os/IRemoteCallback;

    .prologue
    sget-object v0, Lcom/lge/uicc/framework/IccFileIO;->mInstance:Lcom/lge/uicc/framework/IccFileIO;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    sget-object v0, Lcom/lge/uicc/framework/IccFileIO;->mInstance:Lcom/lge/uicc/framework/IccFileIO;

    invoke-direct {v0, p0, p1}, Lcom/lge/uicc/framework/IccFileIO;->updateRecord(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    const/4 v0, 0x1

    goto :goto_0
.end method

.method private updateRecord(Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V
    .locals 17
    .param p1, "in"    # Landroid/os/Bundle;
    .param p2, "reply"    # Landroid/os/IRemoteCallback;

    .prologue
    if-eqz p1, :cond_0

    if-nez p2, :cond_1

    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "update: in="

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p1

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, ", reply="

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p2

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/lge/uicc/framework/IccFileIO;->loge(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_1
    const-string v3, "int.slot"

    const/4 v5, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v3, v5}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v4

    .local v4, "slot":I
    const-string v3, "int.efid"

    const/4 v5, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v3, v5}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v6

    .local v6, "efid":I
    const-string v3, "byte[].data"

    move-object/from16 v0, p1

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getByteArray(Ljava/lang/String;)[B

    move-result-object v7

    .local v7, "dataBytes":[B
    const-string v3, "String.data"

    move-object/from16 v0, p1

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v16

    .local v16, "dataString":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "update: slot="

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, ", efid="

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "%x"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v5, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/lge/uicc/framework/IccFileIO;->logd(Ljava/lang/String;)V

    if-eqz v16, :cond_2

    move-object/from16 v0, p0

    move-object/from16 v1, v16

    invoke-direct {v0, v6, v1}, Lcom/lge/uicc/framework/IccFileIO;->encodeStringToBytes(ILjava/lang/String;)[B

    move-result-object v7

    :cond_2
    if-nez v7, :cond_3

    const-string v3, "invalid dataBytes"

    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/lge/uicc/framework/IccFileIO;->loge(Ljava/lang/String;)V

    const/4 v3, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-direct {v0, v1, v3}, Lcom/lge/uicc/framework/IccFileIO;->sendResult(Landroid/os/IRemoteCallback;Landroid/os/Bundle;)V

    goto :goto_0

    :cond_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "update: data="

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {v7}, Lcom/lge/uicc/EfUtils;->bytesToHexString([B)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/lge/uicc/framework/IccFileIO;->logp(Ljava/lang/String;)V

    sparse-switch v6, :sswitch_data_0

    const-string v3, "Not supported efid"

    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/lge/uicc/framework/IccFileIO;->loge(Ljava/lang/String;)V

    const/4 v3, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-direct {v0, v1, v3}, Lcom/lge/uicc/framework/IccFileIO;->sendResult(Landroid/os/IRemoteCallback;Landroid/os/Bundle;)V

    goto/16 :goto_0

    :sswitch_0
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v3

    const/16 v5, 0x7d0

    if-eq v3, v5, :cond_4

    const/4 v3, 0x0

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-direct {v0, v1, v3}, Lcom/lge/uicc/framework/IccFileIO;->sendResult(Landroid/os/IRemoteCallback;Landroid/os/Bundle;)V

    goto/16 :goto_0

    :cond_4
    const/4 v5, 0x1

    new-instance v3, Lcom/lge/uicc/framework/IccFileIO$CommonUpdated;

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    invoke-direct {v3, v0, v1, v2}, Lcom/lge/uicc/framework/IccFileIO$CommonUpdated;-><init>(Lcom/lge/uicc/framework/IccFileIO;Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/lge/uicc/framework/IccFileIO;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordUpdated;)Landroid/os/Message;

    move-result-object v8

    move-object/from16 v3, p0

    invoke-virtual/range {v3 .. v8}, Lcom/lge/uicc/framework/IccFileIO;->updateEFTransparent(III[BLandroid/os/Message;)V

    goto/16 :goto_0

    :sswitch_1
    const/4 v5, 0x1

    new-instance v3, Lcom/lge/uicc/framework/IccFileIO$CommonUpdated;

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    invoke-direct {v3, v0, v1, v2}, Lcom/lge/uicc/framework/IccFileIO$CommonUpdated;-><init>(Lcom/lge/uicc/framework/IccFileIO;Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/lge/uicc/framework/IccFileIO;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordUpdated;)Landroid/os/Message;

    move-result-object v8

    move-object/from16 v3, p0

    invoke-virtual/range {v3 .. v8}, Lcom/lge/uicc/framework/IccFileIO;->updateEFTransparent(III[BLandroid/os/Message;)V

    goto/16 :goto_0

    :sswitch_2
    const/4 v10, 0x1

    const/4 v12, 0x1

    const/4 v14, 0x0

    new-instance v3, Lcom/lge/uicc/framework/IccFileIO$CommonUpdated;

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    invoke-direct {v3, v0, v1, v2}, Lcom/lge/uicc/framework/IccFileIO$CommonUpdated;-><init>(Lcom/lge/uicc/framework/IccFileIO;Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/lge/uicc/framework/IccFileIO;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordUpdated;)Landroid/os/Message;

    move-result-object v15

    move-object/from16 v8, p0

    move v9, v4

    move v11, v6

    move-object v13, v7

    invoke-virtual/range {v8 .. v15}, Lcom/lge/uicc/framework/IccFileIO;->updateEFLinearFixed(IIII[BLjava/lang/String;Landroid/os/Message;)V

    goto/16 :goto_0

    :sswitch_3
    const/4 v10, 0x2

    const/4 v12, 0x1

    const/4 v14, 0x0

    new-instance v3, Lcom/lge/uicc/framework/IccFileIO$CommonUpdated;

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    invoke-direct {v3, v0, v1, v2}, Lcom/lge/uicc/framework/IccFileIO$CommonUpdated;-><init>(Lcom/lge/uicc/framework/IccFileIO;Landroid/os/Bundle;Landroid/os/IRemoteCallback;)V

    move-object/from16 v0, p0

    invoke-virtual {v0, v3}, Lcom/lge/uicc/framework/IccFileIO;->obtainMessage(Lcom/lge/uicc/framework/IccHandler$RecordUpdated;)Landroid/os/Message;

    move-result-object v15

    move-object/from16 v8, p0

    move v9, v4

    move v11, v6

    move-object v13, v7

    invoke-virtual/range {v8 .. v15}, Lcom/lge/uicc/framework/IccFileIO;->updateEFLinearFixed(IIII[BLjava/lang/String;Landroid/os/Message;)V

    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x2f39 -> :sswitch_1
        0x2f40 -> :sswitch_0
        0x2f41 -> :sswitch_0
        0x2f42 -> :sswitch_0
        0x2f43 -> :sswitch_0
        0x2f50 -> :sswitch_0
        0x6f42 -> :sswitch_2
        0x6f44 -> :sswitch_3
        0x6f73 -> :sswitch_1
        0x6f7b -> :sswitch_1
        0x6f7e -> :sswitch_1
    .end sparse-switch
.end method
