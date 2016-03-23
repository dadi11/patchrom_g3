.class public Lcom/lge/uicc/SimPhonebookBaseInfo;
.super Ljava/lang/Object;
.source "SimPhonebookBaseInfo.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/uicc/SimPhonebookBaseInfo;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public mAdnNameEncodingType:Ljava/lang/String;

.field public mAdnNameMaxbyteLength:I

.field public mAdnNumberMaxLength:I

.field public mAnrMaxLength:I

.field public mAssignableAnrCount:I

.field public mAssignableEmailount:I

.field public mAssignableGroupCount:I

.field public mEmailMaxByteLength:I

.field public mEmailencodingType:Ljava/lang/String;

.field public mExternalNumberMaxLength:I

.field public mFreeExternalNumberCount:I

.field public mGroupNameEncodingType:Ljava/lang/String;

.field public mGroupNameMaxByteLength:I

.field public mSliceCount:I

.field public mSlices:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray",
            "<",
            "Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;",
            ">;"
        }
    .end annotation
.end field

.field public mSlotOrder:I

.field public mSneMaxByteLength:I

.field public mSneencodingType:Ljava/lang/String;

.field public mTotalAdncount:I

.field public mTotalAnrcount:I

.field public mTotalEmailCount:I

.field public mTotalGroupCount:I

.field public mTotalSneCount:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/uicc/SimPhonebookBaseInfo$1;

    invoke-direct {v0}, Lcom/lge/uicc/SimPhonebookBaseInfo$1;-><init>()V

    sput-object v0, Lcom/lge/uicc/SimPhonebookBaseInfo;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNameEncodingType:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mEmailencodingType:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSneencodingType:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mGroupNameEncodingType:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "source"    # Landroid/os/Parcel;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNameEncodingType:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mEmailencodingType:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSneencodingType:Ljava/lang/String;

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mGroupNameEncodingType:Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/lge/uicc/SimPhonebookBaseInfo;->readFromParcel(Landroid/os/Parcel;)V

    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Lcom/lge/uicc/SimPhonebookBaseInfo$1;)V
    .locals 0
    .param p1, "x0"    # Landroid/os/Parcel;
    .param p2, "x1"    # Lcom/lge/uicc/SimPhonebookBaseInfo$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/uicc/SimPhonebookBaseInfo;-><init>(Landroid/os/Parcel;)V

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public readFromParcel(Landroid/os/Parcel;)V
    .locals 5
    .param p1, "source"    # Landroid/os/Parcel;

    .prologue
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSlotOrder:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalAdncount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableAnrCount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableEmailount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableGroupCount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalAnrcount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalEmailCount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalSneCount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalGroupCount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mFreeExternalNumberCount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNameMaxbyteLength:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNumberMaxLength:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAnrMaxLength:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mExternalNumberMaxLength:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mEmailMaxByteLength:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSneMaxByteLength:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mGroupNameMaxByteLength:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSliceCount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNameEncodingType:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mEmailencodingType:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSneencodingType:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mGroupNameEncodingType:Ljava/lang/String;

    new-instance v4, Landroid/util/SparseArray;

    invoke-direct {v4}, Landroid/util/SparseArray;-><init>()V

    iput-object v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSlices:Landroid/util/SparseArray;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .local v3, "size":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v3, :cond_0

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    .local v1, "key":I
    new-instance v2, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;

    invoke-direct {v2}, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;-><init>()V

    .local v2, "si":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, v2, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mAdnCount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, v2, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mAnrType:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, v2, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mAnrCount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, v2, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mEmailType:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, v2, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mEmailCount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, v2, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mSneType:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    iput v4, v2, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mSneCount:I

    invoke-virtual {p1}, Landroid/os/Parcel;->createIntArray()[I

    move-result-object v4

    iput-object v4, v2, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mUsedAnrCount:[I

    invoke-virtual {p1}, Landroid/os/Parcel;->createIntArray()[I

    move-result-object v4

    iput-object v4, v2, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mUsedEmailCount:[I

    invoke-virtual {p1}, Landroid/os/Parcel;->createIntArray()[I

    move-result-object v4

    iput-object v4, v2, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mUsedSneCount:[I

    iget-object v4, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSlices:Landroid/util/SparseArray;

    invoke-virtual {v4, v1, v2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .end local v1    # "key":I
    .end local v2    # "si":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    :cond_0
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " mSlotOrder:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSlotOrder:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mTotalAdncount:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalAdncount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mAssignableAnrCount:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableAnrCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mAssignableEmailount:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableEmailount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mAssignableGroupCount:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableGroupCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mTotalAnrcount:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalAnrcount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mTotalEmailCount:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalEmailCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mTotalSneCount:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalSneCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mTotalGroupCount:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalGroupCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mFreeExternalNumberCount:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mFreeExternalNumberCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mAdnNameMaxbyteLength:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNameMaxbyteLength:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mAdnNumberMaxLength:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNumberMaxLength:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mAnrMaxLength;:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAnrMaxLength:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mExternalNumberMaxLength:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mExternalNumberMaxLength:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mEmailMaxByteLength:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mEmailMaxByteLength:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mSneMaxByteLength:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSneMaxByteLength:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mGroupNameMaxByteLength:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mGroupNameMaxByteLength:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mSliceCount:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSliceCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mAdnNameEncodingType:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNameEncodingType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mEmailencodingType:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mEmailencodingType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mSneencodingType:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSneencodingType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mGroupNameEncodingType:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mGroupNameEncodingType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 4
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSlotOrder:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalAdncount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableAnrCount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableEmailount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAssignableGroupCount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalAnrcount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalEmailCount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalSneCount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mTotalGroupCount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mFreeExternalNumberCount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNameMaxbyteLength:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNumberMaxLength:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAnrMaxLength:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mExternalNumberMaxLength:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mEmailMaxByteLength:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSneMaxByteLength:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mGroupNameMaxByteLength:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSliceCount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mAdnNameEncodingType:Ljava/lang/String;

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mEmailencodingType:Ljava/lang/String;

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSneencodingType:Ljava/lang/String;

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mGroupNameEncodingType:Ljava/lang/String;

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSlices:Landroid/util/SparseArray;

    invoke-virtual {v3}, Landroid/util/SparseArray;->size()I

    move-result v2

    .local v2, "size":I
    invoke-virtual {p1, v2}, Landroid/os/Parcel;->writeInt(I)V

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSlices:Landroid/util/SparseArray;

    invoke-virtual {v3, v0}, Landroid/util/SparseArray;->keyAt(I)I

    move-result v3

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v3, p0, Lcom/lge/uicc/SimPhonebookBaseInfo;->mSlices:Landroid/util/SparseArray;

    invoke-virtual {v3, v0}, Landroid/util/SparseArray;->valueAt(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;

    .local v1, "si":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    iget v3, v1, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mAdnCount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, v1, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mAnrType:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, v1, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mAnrCount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, v1, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mEmailType:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, v1, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mEmailCount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, v1, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mSneType:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget v3, v1, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mSneCount:I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v3, v1, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mUsedAnrCount:[I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeIntArray([I)V

    iget-object v3, v1, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mUsedEmailCount:[I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeIntArray([I)V

    iget-object v3, v1, Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;->mUsedSneCount:[I

    invoke-virtual {p1, v3}, Landroid/os/Parcel;->writeIntArray([I)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .end local v1    # "si":Lcom/lge/uicc/SimPhonebookBaseInfo$SliceInfo;
    :cond_0
    return-void
.end method
