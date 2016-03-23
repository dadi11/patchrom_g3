.class public Lcom/lge/wifi/impl/WifiExtInfo;
.super Ljava/lang/Object;
.source "WifiExtInfo.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/wifi/impl/WifiExtInfo;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mCipher:Ljava/lang/String;

.field private mDevMode:Ljava/lang/String;

.field private mEAPMethod:Ljava/lang/String;

.field private mFreq:I

.field private mKeyMgmt:Ljava/lang/String;

.field private mSecurity:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/wifi/impl/WifiExtInfo$1;

    invoke-direct {v0}, Lcom/lge/wifi/impl/WifiExtInfo$1;-><init>()V

    sput-object v0, Lcom/lge/wifi/impl/WifiExtInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mFreq:I

    iput-object v1, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mDevMode:Ljava/lang/String;

    iput-object v1, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mKeyMgmt:Ljava/lang/String;

    iput-object v1, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mCipher:Ljava/lang/String;

    iput-object v1, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mSecurity:Ljava/lang/String;

    iput-object v1, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mEAPMethod:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Lcom/lge/wifi/impl/WifiExtInfo;)V
    .locals 1
    .param p1, "source"    # Lcom/lge/wifi/impl/WifiExtInfo;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    if-eqz p1, :cond_0

    iget v0, p1, Lcom/lge/wifi/impl/WifiExtInfo;->mFreq:I

    iput v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mFreq:I

    iget-object v0, p1, Lcom/lge/wifi/impl/WifiExtInfo;->mDevMode:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mDevMode:Ljava/lang/String;

    iget-object v0, p1, Lcom/lge/wifi/impl/WifiExtInfo;->mKeyMgmt:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mKeyMgmt:Ljava/lang/String;

    iget-object v0, p1, Lcom/lge/wifi/impl/WifiExtInfo;->mCipher:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mCipher:Ljava/lang/String;

    iget-object v0, p1, Lcom/lge/wifi/impl/WifiExtInfo;->mSecurity:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mSecurity:Ljava/lang/String;

    iget-object v0, p1, Lcom/lge/wifi/impl/WifiExtInfo;->mEAPMethod:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mEAPMethod:Ljava/lang/String;

    :cond_0
    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getCipher()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mCipher:Ljava/lang/String;

    return-object v0
.end method

.method public getDevMode()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mDevMode:Ljava/lang/String;

    return-object v0
.end method

.method public getEAPMETHOD()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mEAPMethod:Ljava/lang/String;

    return-object v0
.end method

.method public getFreq()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mFreq:I

    return v0
.end method

.method public getKeyMgmt()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mKeyMgmt:Ljava/lang/String;

    return-object v0
.end method

.method public getSECTYPE()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mSecurity:Ljava/lang/String;

    return-object v0
.end method

.method public setCipher(Ljava/lang/String;)V
    .locals 0
    .param p1, "cipher"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mCipher:Ljava/lang/String;

    return-void
.end method

.method public setDevMode(Ljava/lang/String;)V
    .locals 0
    .param p1, "devMode"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mDevMode:Ljava/lang/String;

    return-void
.end method

.method public setEAPMETHOD(Ljava/lang/String;)V
    .locals 0
    .param p1, "EAPMETHOD"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mEAPMethod:Ljava/lang/String;

    return-void
.end method

.method public setFreq(I)V
    .locals 0
    .param p1, "freq"    # I

    .prologue
    iput p1, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mFreq:I

    return-void
.end method

.method public setKeyMgmt(Ljava/lang/String;)V
    .locals 0
    .param p1, "key_mgmt"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mKeyMgmt:Ljava/lang/String;

    return-void
.end method

.method public setSECTYPE(Ljava/lang/String;)V
    .locals 0
    .param p1, "SECTYPE"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mSecurity:Ljava/lang/String;

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .prologue
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    .local v1, "sb":Ljava/lang/StringBuffer;
    const-string v0, "<none>"

    .local v0, "none":Ljava/lang/String;
    const-string v2, "Freq: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    iget v3, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mFreq:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    move-result-object v2

    const-string v3, ", DevMode: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    iget-object v2, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mDevMode:Ljava/lang/String;

    if-nez v2, :cond_0

    move-object v2, v0

    :goto_0
    invoke-virtual {v3, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    const-string v3, ", KeyMgmt: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    iget-object v2, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mKeyMgmt:Ljava/lang/String;

    if-nez v2, :cond_1

    move-object v2, v0

    :goto_1
    invoke-virtual {v3, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    const-string v3, ", Cipher: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    iget-object v2, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mCipher:Ljava/lang/String;

    if-nez v2, :cond_2

    move-object v2, v0

    :goto_2
    invoke-virtual {v3, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    const-string v3, ", EAPMETHOD: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    iget-object v2, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mEAPMethod:Ljava/lang/String;

    if-nez v2, :cond_3

    move-object v2, v0

    :goto_3
    invoke-virtual {v3, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    const-string v3, ", SECTYPE: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mSecurity:Ljava/lang/String;

    if-nez v3, :cond_4

    .end local v0    # "none":Ljava/lang/String;
    :goto_4
    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .restart local v0    # "none":Ljava/lang/String;
    :cond_0
    iget-object v2, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mDevMode:Ljava/lang/String;

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mKeyMgmt:Ljava/lang/String;

    goto :goto_1

    :cond_2
    iget-object v2, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mCipher:Ljava/lang/String;

    goto :goto_2

    :cond_3
    iget-object v2, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mEAPMethod:Ljava/lang/String;

    goto :goto_3

    :cond_4
    iget-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mSecurity:Ljava/lang/String;

    goto :goto_4
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mFreq:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mDevMode:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mKeyMgmt:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mCipher:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mSecurity:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/wifi/impl/WifiExtInfo;->mEAPMethod:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void
.end method
