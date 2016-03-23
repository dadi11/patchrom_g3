.class public Lcom/lge/bnr/model/BNRZipByteData;
.super Ljava/lang/Object;
.source "BNRZipByteData.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/bnr/model/BNRZipByteData;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private _byte:[B

.field private fName:Ljava/lang/String;

.field private nReadByte:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/bnr/model/BNRZipByteData$1;

    invoke-direct {v0}, Lcom/lge/bnr/model/BNRZipByteData$1;-><init>()V

    sput-object v0, Lcom/lge/bnr/model/BNRZipByteData;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 0
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p0, p1}, Lcom/lge/bnr/model/BNRZipByteData;->readFromParcel(Landroid/os/Parcel;)V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "Name"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/bnr/model/BNRZipByteData;->fName:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public get_ReadByte()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/bnr/model/BNRZipByteData;->nReadByte:I

    return v0
.end method

.method public get_byte()[B
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/bnr/model/BNRZipByteData;->_byte:[B

    return-object v0
.end method

.method public get_fName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/bnr/model/BNRZipByteData;->fName:Ljava/lang/String;

    return-object v0
.end method

.method public readFromParcel(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/lge/bnr/model/BNRZipByteData;->_byte:[B

    iget-object v0, p0, Lcom/lge/bnr/model/BNRZipByteData;->_byte:[B

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readByteArray([B)V

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/bnr/model/BNRZipByteData;->nReadByte:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/bnr/model/BNRZipByteData;->fName:Ljava/lang/String;

    return-void
.end method

.method public set_ReadByte(I)V
    .locals 0
    .param p1, "nReadByte"    # I

    .prologue
    iput p1, p0, Lcom/lge/bnr/model/BNRZipByteData;->nReadByte:I

    return-void
.end method

.method public set_byte([B)V
    .locals 0
    .param p1, "_byte"    # [B

    .prologue
    iput-object p1, p0, Lcom/lge/bnr/model/BNRZipByteData;->_byte:[B

    return-void
.end method

.method public set_fName(Ljava/lang/String;)V
    .locals 0
    .param p1, "fName"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/bnr/model/BNRZipByteData;->fName:Ljava/lang/String;

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/bnr/model/BNRZipByteData;->_byte:[B

    array-length v0, v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/bnr/model/BNRZipByteData;->_byte:[B

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeByteArray([B)V

    iget v0, p0, Lcom/lge/bnr/model/BNRZipByteData;->nReadByte:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/bnr/model/BNRZipByteData;->fName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void
.end method
