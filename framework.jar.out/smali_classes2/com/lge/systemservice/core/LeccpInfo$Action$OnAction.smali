.class public Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;
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
    name = "OnAction"
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;",
            ">;"
        }
    .end annotation
.end field

.field public static final ON_ACTION_KIND_CALL:I = 0x0

.field public static final ON_ACTION_KIND_MESSAGE:I = 0x1

.field public static final ON_ACTION_KIND_NOTIFICATION:I = 0x2

.field public static final ON_ACTION_TYPE_OFF:I = 0x1

.field public static final ON_ACTION_TYPE_ON:I


# instance fields
.field public actionKind:I

.field public isOn:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 1003
    new-instance v0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction$1;

    invoke-direct {v0}, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction$1;-><init>()V

    sput-object v0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 969
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 961
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;->isOn:Z

    .line 967
    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;->actionKind:I

    .line 971
    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v0, 0x0

    .line 973
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 961
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;->isOn:Z

    .line 967
    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;->actionKind:I

    .line 974
    invoke-direct {p0, p1}, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;->readFromParcel(Landroid/os/Parcel;)V

    .line 975
    return-void
.end method

.method private readFromParcel(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v0, 0x1

    .line 995
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-ne v1, v0, :cond_0

    :goto_0
    iput-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;->isOn:Z

    .line 996
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;->actionKind:I

    .line 997
    return-void

    .line 995
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 979
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    .line 990
    iget-boolean v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;->isOn:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 991
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$Action$OnAction;->actionKind:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 992
    return-void

    .line 990
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
