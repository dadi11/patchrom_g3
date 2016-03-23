.class public Lcom/mediatek/internal/telephony/DefaultBearerConfig;
.super Ljava/lang/Object;
.source "DefaultBearerConfig.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/mediatek/internal/telephony/DefaultBearerConfig;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public mEmergency_ind:I

.field public mIsValid:I

.field public mPcscf_discovery_flag:I

.field public mQos:Lcom/mediatek/internal/telephony/QosStatus;

.field public mSignaling_flag:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/mediatek/internal/telephony/DefaultBearerConfig$1;

    invoke-direct {v0}, Lcom/mediatek/internal/telephony/DefaultBearerConfig$1;-><init>()V

    sput-object v0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/mediatek/internal/telephony/QosStatus;

    invoke-direct {v0}, Lcom/mediatek/internal/telephony/QosStatus;-><init>()V

    iput-object v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mQos:Lcom/mediatek/internal/telephony/QosStatus;

    invoke-virtual {p0}, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->reset()V

    return-void
.end method

.method public constructor <init>(ILcom/mediatek/internal/telephony/QosStatus;III)V
    .locals 0
    .param p1, "isValid"    # I
    .param p2, "qos"    # Lcom/mediatek/internal/telephony/QosStatus;
    .param p3, "emergency_ind"    # I
    .param p4, "pcscf_discovery_flag"    # I
    .param p5, "signaling_flag"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mIsValid:I

    iput-object p2, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mQos:Lcom/mediatek/internal/telephony/QosStatus;

    iput p3, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mEmergency_ind:I

    iput p4, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mPcscf_discovery_flag:I

    iput p5, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mSignaling_flag:I

    return-void
.end method


# virtual methods
.method public copyFrom(Lcom/mediatek/internal/telephony/DefaultBearerConfig;)V
    .locals 1
    .param p1, "defaultBearerConfig"    # Lcom/mediatek/internal/telephony/DefaultBearerConfig;

    .prologue
    iget v0, p1, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mIsValid:I

    iput v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mIsValid:I

    iget-object v0, p1, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mQos:Lcom/mediatek/internal/telephony/QosStatus;

    iput-object v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mQos:Lcom/mediatek/internal/telephony/QosStatus;

    iget v0, p1, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mEmergency_ind:I

    iput v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mEmergency_ind:I

    iget v0, p1, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mPcscf_discovery_flag:I

    iput v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mPcscf_discovery_flag:I

    iget v0, p1, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mSignaling_flag:I

    iput v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mSignaling_flag:I

    return-void
.end method

.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public readFrom(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "p"    # Landroid/os/Parcel;

    .prologue
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mIsValid:I

    iget-object v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mQos:Lcom/mediatek/internal/telephony/QosStatus;

    invoke-virtual {v0, p1}, Lcom/mediatek/internal/telephony/QosStatus;->readFrom(Landroid/os/Parcel;)V

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mEmergency_ind:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mPcscf_discovery_flag:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mSignaling_flag:I

    return-void
.end method

.method public reset()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    iput v1, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mIsValid:I

    iget-object v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mQos:Lcom/mediatek/internal/telephony/QosStatus;

    invoke-virtual {v0}, Lcom/mediatek/internal/telephony/QosStatus;->reset()V

    iput v1, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mEmergency_ind:I

    iput v1, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mPcscf_discovery_flag:I

    iput v1, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mSignaling_flag:I

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[isValid="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mIsValid:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", qos="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mQos:Lcom/mediatek/internal/telephony/QosStatus;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", emergency_ind="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mEmergency_ind:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", pcscf_discovery_flag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mPcscf_discovery_flag:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", signaling_flag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mSignaling_flag:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeTo(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "p"    # Landroid/os/Parcel;

    .prologue
    iget v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mIsValid:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mQos:Lcom/mediatek/internal/telephony/QosStatus;

    invoke-virtual {v0, p1}, Lcom/mediatek/internal/telephony/QosStatus;->writeTo(Landroid/os/Parcel;)V

    iget v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mEmergency_ind:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mPcscf_discovery_flag:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->mSignaling_flag:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 0
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    invoke-virtual {p0, p1}, Lcom/mediatek/internal/telephony/DefaultBearerConfig;->writeTo(Landroid/os/Parcel;)V

    return-void
.end method
