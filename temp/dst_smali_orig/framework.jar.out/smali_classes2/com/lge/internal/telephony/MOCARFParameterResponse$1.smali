.class final Lcom/lge/internal/telephony/MOCARFParameterResponse$1;
.super Ljava/lang/Object;
.source "MOCARFParameterResponse.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/internal/telephony/MOCARFParameterResponse;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator",
        "<",
        "Lcom/lge/internal/telephony/MOCARFParameterResponse;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public createFromParcel(Landroid/os/Parcel;)Lcom/lge/internal/telephony/MOCARFParameterResponse;
    .locals 5
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .local v2, "kind_of_data":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .local v3, "send_buf_num":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "data_len":I
    new-array v0, v1, [B

    .local v0, "data":[B
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readByteArray([B)V

    new-instance v4, Lcom/lge/internal/telephony/MOCARFParameterResponse;

    invoke-direct {v4, v2, v3, v1, v0}, Lcom/lge/internal/telephony/MOCARFParameterResponse;-><init>(III[B)V

    return-object v4
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1
    .param p1, "x0"    # Landroid/os/Parcel;

    .prologue
    invoke-virtual {p0, p1}, Lcom/lge/internal/telephony/MOCARFParameterResponse$1;->createFromParcel(Landroid/os/Parcel;)Lcom/lge/internal/telephony/MOCARFParameterResponse;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Lcom/lge/internal/telephony/MOCARFParameterResponse;
    .locals 1
    .param p1, "size"    # I

    .prologue
    new-array v0, p1, [Lcom/lge/internal/telephony/MOCARFParameterResponse;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1
    .param p1, "x0"    # I

    .prologue
    invoke-virtual {p0, p1}, Lcom/lge/internal/telephony/MOCARFParameterResponse$1;->newArray(I)[Lcom/lge/internal/telephony/MOCARFParameterResponse;

    move-result-object v0

    return-object v0
.end method
