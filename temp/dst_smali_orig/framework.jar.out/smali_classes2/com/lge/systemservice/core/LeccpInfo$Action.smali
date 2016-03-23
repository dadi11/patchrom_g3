.class public Lcom/lge/systemservice/core/LeccpInfo$Action;
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
    name = "Action"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;,
        Lcom/lge/systemservice/core/LeccpInfo$Action$OpenAction;,
        Lcom/lge/systemservice/core/LeccpInfo$Action$TransferAction;,
        Lcom/lge/systemservice/core/LeccpInfo$Action$PlayAction;,
        Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;
    }
.end annotation


# static fields
.field public static final ACTION_TYPE_CONNECT:I = 0x2

.field public static final ACTION_TYPE_ON:I = 0x4

.field public static final ACTION_TYPE_OPEN:I = 0x3

.field public static final ACTION_TYPE_PLAY:I = 0x0

.field public static final ACTION_TYPE_TRANSFER:I = 0x1

.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/systemservice/core/LeccpInfo$Action;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public connectAction:Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;

.field public id:Ljava/lang/String;

.field public isEnabled:Z

.field public onAction:Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;

.field public openAction:Lcom/lge/systemservice/core/LeccpInfo$Action$OpenAction;

.field public playAction:Lcom/lge/systemservice/core/LeccpInfo$Action$PlayAction;

.field public transferAction:Lcom/lge/systemservice/core/LeccpInfo$Action$TransferAction;

.field public type:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/systemservice/core/LeccpInfo$Action$1;

    invoke-direct {v0}, Lcom/lge/systemservice/core/LeccpInfo$Action$1;-><init>()V

    sput-object v0, Lcom/lge/systemservice/core/LeccpInfo$Action;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->id:Ljava/lang/String;

    iput v2, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    iput-boolean v2, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->isEnabled:Z

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->connectAction:Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->playAction:Lcom/lge/systemservice/core/LeccpInfo$Action$PlayAction;

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->transferAction:Lcom/lge/systemservice/core/LeccpInfo$Action$TransferAction;

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->openAction:Lcom/lge/systemservice/core/LeccpInfo$Action$OpenAction;

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->onAction:Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;

    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 3
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->id:Ljava/lang/String;

    iput v2, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    iput-boolean v2, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->isEnabled:Z

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->connectAction:Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->playAction:Lcom/lge/systemservice/core/LeccpInfo$Action$PlayAction;

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->transferAction:Lcom/lge/systemservice/core/LeccpInfo$Action$TransferAction;

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->openAction:Lcom/lge/systemservice/core/LeccpInfo$Action$OpenAction;

    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->onAction:Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;

    invoke-direct {p0, p1}, Lcom/lge/systemservice/core/LeccpInfo$Action;->readFromParcel(Landroid/os/Parcel;)V

    return-void
.end method

.method private readFromParcel(Landroid/os/Parcel;)V
    .locals 3
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v1, 0x1

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->id:Ljava/lang/String;

    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->id:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    :goto_0
    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->id:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    if-ne v0, v1, :cond_2

    move v0, v1

    :goto_1
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->isEnabled:Z

    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    const/4 v2, 0x2

    if-ne v0, v2, :cond_3

    const-class v0, Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->connectAction:Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;

    :cond_0
    :goto_2
    return-void

    :cond_1
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->id:Ljava/lang/String;

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    goto :goto_1

    :cond_3
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    if-nez v0, :cond_4

    const-class v0, Lcom/lge/systemservice/core/LeccpInfo$Action$PlayAction;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$Action$PlayAction;

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->playAction:Lcom/lge/systemservice/core/LeccpInfo$Action$PlayAction;

    goto :goto_2

    :cond_4
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    if-ne v0, v1, :cond_5

    const-class v0, Lcom/lge/systemservice/core/LeccpInfo$Action$TransferAction;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$Action$TransferAction;

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->transferAction:Lcom/lge/systemservice/core/LeccpInfo$Action$TransferAction;

    goto :goto_2

    :cond_5
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_6

    const-class v0, Lcom/lge/systemservice/core/LeccpInfo$Action$OpenAction;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$Action$OpenAction;

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->openAction:Lcom/lge/systemservice/core/LeccpInfo$Action$OpenAction;

    goto :goto_2

    :cond_6
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const-class v0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->onAction:Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;

    goto :goto_2
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->id:Ljava/lang/String;

    return-object v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 3
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    const/4 v1, 0x1

    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->id:Ljava/lang/String;

    if-nez v0, :cond_1

    const-string v0, ""

    :goto_0
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->isEnabled:Z

    if-eqz v0, :cond_2

    move v0, v1

    :goto_1
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    const/4 v2, 0x2

    if-ne v0, v2, :cond_3

    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->connectAction:Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    :cond_0
    :goto_2
    return-void

    :cond_1
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->id:Ljava/lang/String;

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    goto :goto_1

    :cond_3
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    if-nez v0, :cond_4

    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->playAction:Lcom/lge/systemservice/core/LeccpInfo$Action$PlayAction;

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    goto :goto_2

    :cond_4
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    if-ne v0, v1, :cond_5

    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->transferAction:Lcom/lge/systemservice/core/LeccpInfo$Action$TransferAction;

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    goto :goto_2

    :cond_5
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    const/4 v2, 0x3

    if-ne v0, v2, :cond_6

    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->openAction:Lcom/lge/systemservice/core/LeccpInfo$Action$OpenAction;

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    goto :goto_2

    :cond_6
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->type:I

    const/4 v2, 0x4

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action;->onAction:Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    goto :goto_2
.end method
