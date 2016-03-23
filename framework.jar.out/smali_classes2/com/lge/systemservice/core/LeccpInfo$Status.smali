.class public Lcom/lge/systemservice/core/LeccpInfo$Status;
.super Ljava/lang/Object;
.source "LeccpInfo.java"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/systemservice/core/LeccpInfo;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Status"
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/systemservice/core/LeccpInfo$Status;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public isDiscovering:Z

.field public isSupportedBle:Z

.field public isSupportedPhoneSpeaker:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 92
    new-instance v0, Lcom/lge/systemservice/core/LeccpInfo$Status$1;

    invoke-direct {v0}, Lcom/lge/systemservice/core/LeccpInfo$Status$1;-><init>()V

    sput-object v0, Lcom/lge/systemservice/core/LeccpInfo$Status;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isDiscovering:Z

    .line 49
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isSupportedBle:Z

    .line 55
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isSupportedPhoneSpeaker:Z

    .line 58
    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v0, 0x0

    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isDiscovering:Z

    .line 49
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isSupportedBle:Z

    .line 55
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isSupportedPhoneSpeaker:Z

    .line 61
    invoke-direct {p0, p1}, Lcom/lge/systemservice/core/LeccpInfo$Status;->readFromParcel(Landroid/os/Parcel;)V

    .line 62
    return-void
.end method

.method private readFromParcel(Landroid/os/Parcel;)V
    .locals 3
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 83
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-ne v0, v1, :cond_0

    move v0, v1

    :goto_0
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isDiscovering:Z

    .line 84
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-ne v0, v1, :cond_1

    move v0, v1

    :goto_1
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isSupportedBle:Z

    .line 85
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-ne v0, v1, :cond_2

    :goto_2
    iput-boolean v1, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isSupportedPhoneSpeaker:Z

    .line 86
    return-void

    :cond_0
    move v0, v2

    .line 83
    goto :goto_0

    :cond_1
    move v0, v2

    .line 84
    goto :goto_1

    :cond_2
    move v1, v2

    .line 85
    goto :goto_2
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 66
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 3
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 77
    iget-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isDiscovering:Z

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 78
    iget-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isSupportedBle:Z

    if-eqz v0, :cond_1

    move v0, v1

    :goto_1
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 79
    iget-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Status;->isSupportedPhoneSpeaker:Z

    if-eqz v0, :cond_2

    :goto_2
    invoke-virtual {p1, v1}, Landroid/os/Parcel;->writeInt(I)V

    .line 80
    return-void

    :cond_0
    move v0, v2

    .line 77
    goto :goto_0

    :cond_1
    move v0, v2

    .line 78
    goto :goto_1

    :cond_2
    move v1, v2

    .line 79
    goto :goto_2
.end method
