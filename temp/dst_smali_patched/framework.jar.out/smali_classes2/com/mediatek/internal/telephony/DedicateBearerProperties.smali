.class public Lcom/mediatek/internal/telephony/DedicateBearerProperties;
.super Ljava/lang/Object;
.source "DedicateBearerProperties.java"

# interfaces
.implements Landroid/os/Parcelable;
.implements Ljava/lang/Cloneable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/mediatek/internal/telephony/DedicateBearerProperties;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public bearerId:I

.field public cid:I

.field public concatenateBearers:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mediatek/internal/telephony/DedicateBearerProperties;",
            ">;"
        }
    .end annotation
.end field

.field public defaultCid:I

.field public interfaceId:I

.field public pcscfInfo:Lcom/mediatek/internal/telephony/PcscfInfo;

.field public qosStatus:Lcom/mediatek/internal/telephony/QosStatus;

.field public signalingFlag:I

.field public tftStatus:Lcom/mediatek/internal/telephony/TftStatus;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/mediatek/internal/telephony/DedicateBearerProperties$1;

    invoke-direct {v0}, Lcom/mediatek/internal/telephony/DedicateBearerProperties$1;-><init>()V

    sput-object v0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->concatenateBearers:Ljava/util/ArrayList;

    invoke-virtual {p0}, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->clear()V

    return-void
.end method


# virtual methods
.method public clear()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, -0x1

    iput v1, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->interfaceId:I

    iput v1, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->cid:I

    iput v1, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->defaultCid:I

    const/4 v0, 0x0

    iput v0, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->signalingFlag:I

    iput v1, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->bearerId:I

    iput-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->qosStatus:Lcom/mediatek/internal/telephony/QosStatus;

    iput-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->tftStatus:Lcom/mediatek/internal/telephony/TftStatus;

    iput-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->pcscfInfo:Lcom/mediatek/internal/telephony/PcscfInfo;

    iget-object v0, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->concatenateBearers:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    return-void
.end method

.method public clone()Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/CloneNotSupportedException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .local v0, "parcel":Landroid/os/Parcel;
    invoke-virtual {p0, v0, v1}, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->writeToParcel(Landroid/os/Parcel;I)V

    invoke-virtual {v0, v1}, Landroid/os/Parcel;->setDataPosition(I)V

    sget-object v1, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-interface {v1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v1

    return-object v1
.end method

.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public setProperties(Lcom/mediatek/internal/telephony/DedicateDataCallState;)Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;
    .locals 5
    .param p1, "dedicateCallState"    # Lcom/mediatek/internal/telephony/DedicateDataCallState;

    .prologue
    const/4 v4, 0x2

    sget-object v1, Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;->SUCCESS:Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;

    .local v1, "result":Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;
    invoke-virtual {p0}, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->clear()V

    iget v2, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->interfaceId:I

    iput v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->interfaceId:I

    iget v2, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->cid:I

    iput v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->cid:I

    iget v2, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->defaultCid:I

    iput v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->defaultCid:I

    iget v2, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->signalingFlag:I

    iput v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->signalingFlag:I

    iget v2, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->bearerId:I

    iput v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->bearerId:I

    iget-object v2, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->qosStatus:Lcom/mediatek/internal/telephony/QosStatus;

    if-eqz v2, :cond_0

    new-instance v2, Lcom/mediatek/internal/telephony/QosStatus;

    invoke-direct {v2}, Lcom/mediatek/internal/telephony/QosStatus;-><init>()V

    iput-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->qosStatus:Lcom/mediatek/internal/telephony/QosStatus;

    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->qosStatus:Lcom/mediatek/internal/telephony/QosStatus;

    iget-object v3, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->qosStatus:Lcom/mediatek/internal/telephony/QosStatus;

    invoke-virtual {v2, v3}, Lcom/mediatek/internal/telephony/QosStatus;->copyFrom(Lcom/mediatek/internal/telephony/QosStatus;)V

    :cond_0
    iget-object v2, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->tftStatus:Lcom/mediatek/internal/telephony/TftStatus;

    if-eqz v2, :cond_1

    new-instance v2, Lcom/mediatek/internal/telephony/TftStatus;

    invoke-direct {v2}, Lcom/mediatek/internal/telephony/TftStatus;-><init>()V

    iput-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->tftStatus:Lcom/mediatek/internal/telephony/TftStatus;

    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->tftStatus:Lcom/mediatek/internal/telephony/TftStatus;

    iget-object v3, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->tftStatus:Lcom/mediatek/internal/telephony/TftStatus;

    invoke-virtual {v2, v3}, Lcom/mediatek/internal/telephony/TftStatus;->copyFrom(Lcom/mediatek/internal/telephony/TftStatus;)V

    :cond_1
    iget-object v2, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->pcscfInfo:Lcom/mediatek/internal/telephony/PcscfInfo;

    if-eqz v2, :cond_2

    new-instance v2, Lcom/mediatek/internal/telephony/PcscfInfo;

    invoke-direct {v2}, Lcom/mediatek/internal/telephony/PcscfInfo;-><init>()V

    iput-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->pcscfInfo:Lcom/mediatek/internal/telephony/PcscfInfo;

    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->pcscfInfo:Lcom/mediatek/internal/telephony/PcscfInfo;

    iget-object v3, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->pcscfInfo:Lcom/mediatek/internal/telephony/PcscfInfo;

    invoke-virtual {v2, v3}, Lcom/mediatek/internal/telephony/PcscfInfo;->copyFrom(Lcom/mediatek/internal/telephony/PcscfInfo;)V

    :cond_2
    iget v0, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->failCause:I

    .local v0, "failCause":I
    if-nez v0, :cond_4

    iget v2, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->active:I

    if-eq v2, v4, :cond_4

    sget-object v1, Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;->FAIL:Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;

    const v2, 0x10002

    iput v2, v1, Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;->failCause:I

    :cond_3
    :goto_0
    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->concatenateBearers:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->trimToSize()V

    return-object v1

    :cond_4
    if-eqz v0, :cond_5

    iget v2, p1, Lcom/mediatek/internal/telephony/DedicateDataCallState;->active:I

    if-ne v2, v4, :cond_5

    iput v0, v1, Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;->failCause:I

    goto :goto_0

    :cond_5
    if-eqz v0, :cond_3

    sget-object v1, Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;->FAIL:Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;

    iput v0, v1, Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;->failCause:I

    goto :goto_0
.end method

.method public setProperties([Lcom/mediatek/internal/telephony/DedicateDataCallState;)Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;
    .locals 6
    .param p1, "dedicateCallStates"    # [Lcom/mediatek/internal/telephony/DedicateDataCallState;

    .prologue
    const/4 v5, 0x0

    aget-object v5, p1, v5

    invoke-virtual {p0, v5}, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->setProperties(Lcom/mediatek/internal/telephony/DedicateDataCallState;)Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;

    move-result-object v4

    .local v4, "result":Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;
    const/4 v1, 0x1

    .local v1, "i":I
    array-length v2, p1

    .local v2, "length":I
    :goto_0
    if-ge v1, v2, :cond_1

    new-instance v3, Lcom/mediatek/internal/telephony/DedicateBearerProperties;

    invoke-direct {v3}, Lcom/mediatek/internal/telephony/DedicateBearerProperties;-><init>()V

    .local v3, "properties":Lcom/mediatek/internal/telephony/DedicateBearerProperties;
    aget-object v5, p1, v1

    invoke-virtual {v3, v5}, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->setProperties(Lcom/mediatek/internal/telephony/DedicateDataCallState;)Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;

    move-result-object v0

    .local v0, "concatenateResult":Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;
    sget-object v5, Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;->SUCCESS:Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;

    if-ne v0, v5, :cond_0

    iget-object v5, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->concatenateBearers:Ljava/util/ArrayList;

    invoke-virtual {v5, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .end local v0    # "concatenateResult":Lcom/mediatek/internal/telephony/DedicateDataCallState$SetupResult;
    .end local v3    # "properties":Lcom/mediatek/internal/telephony/DedicateBearerProperties;
    :cond_1
    return-object v4
.end method

.method public toString()Ljava/lang/String;
    .locals 5

    .prologue
    new-instance v0, Ljava/lang/StringBuffer;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[interfaceId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->interfaceId:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", cid="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->cid:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", defaultCid="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->defaultCid:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", signalingFlag="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->signalingFlag:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", bearerId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->bearerId:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", PCSCF="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->pcscfInfo:Lcom/mediatek/internal/telephony/PcscfInfo;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", QOS="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->qosStatus:Lcom/mediatek/internal/telephony/QosStatus;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", TFT="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->tftStatus:Lcom/mediatek/internal/telephony/TftStatus;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .local v0, "buf":Ljava/lang/StringBuffer;
    iget-object v3, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->concatenateBearers:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mediatek/internal/telephony/DedicateBearerProperties;

    .local v2, "properties":Lcom/mediatek/internal/telephony/DedicateBearerProperties;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    goto :goto_0

    .end local v2    # "properties":Lcom/mediatek/internal/telephony/DedicateBearerProperties;
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 5
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    iget v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->interfaceId:I

    invoke-virtual {p1, v2}, Landroid/os/Parcel;->writeInt(I)V

    iget v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->cid:I

    invoke-virtual {p1, v2}, Landroid/os/Parcel;->writeInt(I)V

    iget v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->defaultCid:I

    invoke-virtual {p1, v2}, Landroid/os/Parcel;->writeInt(I)V

    iget v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->signalingFlag:I

    invoke-virtual {p1, v2}, Landroid/os/Parcel;->writeInt(I)V

    iget v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->bearerId:I

    invoke-virtual {p1, v2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->qosStatus:Lcom/mediatek/internal/telephony/QosStatus;

    if-nez v2, :cond_3

    move v2, v3

    :goto_0
    invoke-virtual {p1, v2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->qosStatus:Lcom/mediatek/internal/telephony/QosStatus;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->qosStatus:Lcom/mediatek/internal/telephony/QosStatus;

    invoke-virtual {v2, p1}, Lcom/mediatek/internal/telephony/QosStatus;->writeTo(Landroid/os/Parcel;)V

    :cond_0
    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->tftStatus:Lcom/mediatek/internal/telephony/TftStatus;

    if-nez v2, :cond_4

    move v2, v3

    :goto_1
    invoke-virtual {p1, v2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->tftStatus:Lcom/mediatek/internal/telephony/TftStatus;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->tftStatus:Lcom/mediatek/internal/telephony/TftStatus;

    invoke-virtual {v2, p1}, Lcom/mediatek/internal/telephony/TftStatus;->writeTo(Landroid/os/Parcel;)V

    :cond_1
    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->pcscfInfo:Lcom/mediatek/internal/telephony/PcscfInfo;

    if-nez v2, :cond_5

    :goto_2
    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->pcscfInfo:Lcom/mediatek/internal/telephony/PcscfInfo;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->pcscfInfo:Lcom/mediatek/internal/telephony/PcscfInfo;

    invoke-virtual {v2, p1}, Lcom/mediatek/internal/telephony/PcscfInfo;->writeTo(Landroid/os/Parcel;)V

    :cond_2
    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->concatenateBearers:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    invoke-virtual {p1, v2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v2, p0, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->concatenateBearers:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :goto_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mediatek/internal/telephony/DedicateBearerProperties;

    .local v1, "properties":Lcom/mediatek/internal/telephony/DedicateBearerProperties;
    invoke-virtual {v1, p1, p2}, Lcom/mediatek/internal/telephony/DedicateBearerProperties;->writeToParcel(Landroid/os/Parcel;I)V

    goto :goto_3

    .end local v0    # "i$":Ljava/util/Iterator;
    .end local v1    # "properties":Lcom/mediatek/internal/telephony/DedicateBearerProperties;
    :cond_3
    move v2, v4

    goto :goto_0

    :cond_4
    move v2, v4

    goto :goto_1

    :cond_5
    move v3, v4

    goto :goto_2

    .restart local v0    # "i$":Ljava/util/Iterator;
    :cond_6
    return-void
.end method
