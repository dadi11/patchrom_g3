.class final Lcom/lge/zdi/recommender/common/RankedApp$1;
.super Ljava/lang/Object;
.source "RankedApp.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/zdi/recommender/common/RankedApp;
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
        "Lcom/lge/zdi/recommender/common/RankedApp;",
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
.method public createFromParcel(Landroid/os/Parcel;)Lcom/lge/zdi/recommender/common/RankedApp;
    .locals 2
    .param p1, "source"    # Landroid/os/Parcel;

    .prologue
    new-instance v0, Lcom/lge/zdi/recommender/common/RankedApp;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/lge/zdi/recommender/common/RankedApp;-><init>(Landroid/os/Parcel;Lcom/lge/zdi/recommender/common/RankedApp$1;)V

    return-object v0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1
    .param p1, "x0"    # Landroid/os/Parcel;

    .prologue
    invoke-virtual {p0, p1}, Lcom/lge/zdi/recommender/common/RankedApp$1;->createFromParcel(Landroid/os/Parcel;)Lcom/lge/zdi/recommender/common/RankedApp;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Lcom/lge/zdi/recommender/common/RankedApp;
    .locals 1
    .param p1, "size"    # I

    .prologue
    new-array v0, p1, [Lcom/lge/zdi/recommender/common/RankedApp;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1
    .param p1, "x0"    # I

    .prologue
    invoke-virtual {p0, p1}, Lcom/lge/zdi/recommender/common/RankedApp$1;->newArray(I)[Lcom/lge/zdi/recommender/common/RankedApp;

    move-result-object v0

    return-object v0
.end method
