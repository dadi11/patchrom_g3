.class public Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;
.super Ljava/lang/Object;
.source "LeccpInfo.java"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/systemservice/core/LeccpInfo$Action;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "ConnectAction"
.end annotation


# static fields
.field public static final CONNECT_ACTION_TYPE_CONNECT:I = 0x0

.field public static final CONNECT_ACTION_TYPE_DISCONNECT:I = 0x1

.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public isConnected:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 584
    new-instance v0, Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction$1;

    invoke-direct {v0}, Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction$1;-><init>()V

    sput-object v0, Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 552
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 550
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;->isConnected:Z

    .line 554
    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    .line 556
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 550
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;->isConnected:Z

    .line 557
    invoke-direct {p0, p1}, Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;->readFromParcel(Landroid/os/Parcel;)V

    .line 558
    return-void
.end method

.method private readFromParcel(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v0, 0x1

    .line 577
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-ne v1, v0, :cond_0

    :goto_0
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;->isConnected:Z

    .line 578
    return-void

    .line 577
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 562
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 573
    iget-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$ConnectAction;->isConnected:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 574
    return-void

    .line 573
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method