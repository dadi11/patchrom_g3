.class public Lcom/lge/bnr/model/BNRFailItem;
.super Ljava/lang/Object;
.source "BNRFailItem.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/bnr/model/BNRFailItem;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private backupPath:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private failCode:I

.field private groupIndex:I

.field private index:I

.field private jobName:Ljava/lang/String;

.field private packageLabel:Ljava/lang/String;

.field private packageNm:Ljava/lang/String;

.field private versionCode:I

.field private versionName:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/bnr/model/BNRFailItem$1;

    invoke-direct {v0}, Lcom/lge/bnr/model/BNRFailItem$1;-><init>()V

    sput-object v0, Lcom/lge/bnr/model/BNRFailItem;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(III)V
    .locals 0
    .param p1, "groupIndex"    # I
    .param p2, "index"    # I
    .param p3, "failCode"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/lge/bnr/model/BNRFailItem;->groupIndex:I

    iput p2, p0, Lcom/lge/bnr/model/BNRFailItem;->index:I

    iput p3, p0, Lcom/lge/bnr/model/BNRFailItem;->failCode:I

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;Ljava/lang/String;I)V
    .locals 0
    .param p1, "groupIndex"    # I
    .param p2, "packageNm"    # Ljava/lang/String;
    .param p3, "packageLabel"    # Ljava/lang/String;
    .param p4, "failCode"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/lge/bnr/model/BNRFailItem;->groupIndex:I

    iput-object p2, p0, Lcom/lge/bnr/model/BNRFailItem;->packageNm:Ljava/lang/String;

    iput-object p3, p0, Lcom/lge/bnr/model/BNRFailItem;->packageLabel:Ljava/lang/String;

    iput p4, p0, Lcom/lge/bnr/model/BNRFailItem;->failCode:I

    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 0
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-direct {p0, p1}, Lcom/lge/bnr/model/BNRFailItem;->readFromParcel(Landroid/os/Parcel;)V

    return-void
.end method

.method private readFromParcel(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/bnr/model/BNRFailItem;->groupIndex:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/bnr/model/BNRFailItem;->index:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->jobName:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->packageNm:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->packageLabel:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->versionName:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/bnr/model/BNRFailItem;->versionCode:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/bnr/model/BNRFailItem;->failCode:I

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readArrayList(Ljava/lang/ClassLoader;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->backupPath:Ljava/util/ArrayList;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getBackupPath()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->backupPath:Ljava/util/ArrayList;

    return-object v0
.end method

.method public getFailCode()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/bnr/model/BNRFailItem;->failCode:I

    return v0
.end method

.method public getGroupIndex()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/bnr/model/BNRFailItem;->groupIndex:I

    return v0
.end method

.method public getIndex()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/bnr/model/BNRFailItem;->index:I

    return v0
.end method

.method public getJobName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->jobName:Ljava/lang/String;

    return-object v0
.end method

.method public getPackageLabel()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->packageLabel:Ljava/lang/String;

    return-object v0
.end method

.method public getPackageNm()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->packageNm:Ljava/lang/String;

    return-object v0
.end method

.method public getPackageVersion()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->versionName:Ljava/lang/String;

    return-object v0
.end method

.method public getPackageVersionCode()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/bnr/model/BNRFailItem;->versionCode:I

    return v0
.end method

.method public setBackupPath(Ljava/util/ArrayList;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "path":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/lge/bnr/model/BNRFailItem;->backupPath:Ljava/util/ArrayList;

    return-void
.end method

.method public setFailCode(I)V
    .locals 0
    .param p1, "failCode"    # I

    .prologue
    iput p1, p0, Lcom/lge/bnr/model/BNRFailItem;->failCode:I

    return-void
.end method

.method public setGroupIndex(I)V
    .locals 0
    .param p1, "groupIndex"    # I

    .prologue
    iput p1, p0, Lcom/lge/bnr/model/BNRFailItem;->groupIndex:I

    return-void
.end method

.method public setIndex(I)V
    .locals 0
    .param p1, "index"    # I

    .prologue
    iput p1, p0, Lcom/lge/bnr/model/BNRFailItem;->index:I

    return-void
.end method

.method public setJobName(Ljava/lang/String;)V
    .locals 0
    .param p1, "jobName"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/bnr/model/BNRFailItem;->jobName:Ljava/lang/String;

    return-void
.end method

.method public setPackageLabel(Ljava/lang/String;)V
    .locals 0
    .param p1, "packageLabel"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/bnr/model/BNRFailItem;->packageLabel:Ljava/lang/String;

    return-void
.end method

.method public setPackageNm(Ljava/lang/String;)V
    .locals 0
    .param p1, "packageNm"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/bnr/model/BNRFailItem;->packageNm:Ljava/lang/String;

    return-void
.end method

.method public setPackageVersion(Ljava/lang/String;)V
    .locals 0
    .param p1, "packageNm"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/bnr/model/BNRFailItem;->versionName:Ljava/lang/String;

    return-void
.end method

.method public setPackageVersionCode(I)V
    .locals 0
    .param p1, "versionCode"    # I

    .prologue
    iput p1, p0, Lcom/lge/bnr/model/BNRFailItem;->versionCode:I

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget v0, p0, Lcom/lge/bnr/model/BNRFailItem;->groupIndex:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/lge/bnr/model/BNRFailItem;->index:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->jobName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->packageNm:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->packageLabel:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->versionName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget v0, p0, Lcom/lge/bnr/model/BNRFailItem;->versionCode:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/lge/bnr/model/BNRFailItem;->failCode:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/bnr/model/BNRFailItem;->backupPath:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeList(Ljava/util/List;)V

    return-void
.end method
