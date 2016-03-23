.class public final Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;
.super Ljava/lang/Object;
.source "LGBluetoothHandsfreeClientCall.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CALL_STATE_ACTIVE:I = 0x0

.field public static final CALL_STATE_ALERTING:I = 0x3

.field public static final CALL_STATE_DIALING:I = 0x2

.field public static final CALL_STATE_HELD:I = 0x1

.field public static final CALL_STATE_HELD_BY_RESPONSE_AND_HOLD:I = 0x6

.field public static final CALL_STATE_INCOMING:I = 0x4

.field public static final CALL_STATE_TERMINATED:I = 0x7

.field public static final CALL_STATE_WAITING:I = 0x5

.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final mId:I

.field private mMultiParty:Z

.field private mNumber:Ljava/lang/String;

.field private final mOutgoing:Z

.field private mState:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall$1;

    invoke-direct {v0}, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall$1;-><init>()V

    sput-object v0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(IILjava/lang/String;ZZ)V
    .locals 0
    .param p1, "id"    # I
    .param p2, "state"    # I
    .param p3, "number"    # Ljava/lang/String;
    .param p4, "multiParty"    # Z
    .param p5, "outgoing"    # Z

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mId:I

    iput p2, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mState:I

    if-eqz p3, :cond_0

    .end local p3    # "number":Ljava/lang/String;
    :goto_0
    iput-object p3, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mNumber:Ljava/lang/String;

    iput-boolean p4, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mMultiParty:Z

    iput-boolean p5, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mOutgoing:Z

    return-void

    .restart local p3    # "number":Ljava/lang/String;
    :cond_0
    const-string p3, ""

    goto :goto_0
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getId()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mId:I

    return v0
.end method

.method public getNumber()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mNumber:Ljava/lang/String;

    return-object v0
.end method

.method public getState()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mState:I

    return v0
.end method

.method public isMultiParty()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mMultiParty:Z

    return v0
.end method

.method public isOutgoing()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mOutgoing:Z

    return v0
.end method

.method public setMultiParty(Z)V
    .locals 0
    .param p1, "multiParty"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mMultiParty:Z

    return-void
.end method

.method public setNumber(Ljava/lang/String;)V
    .locals 0
    .param p1, "number"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mNumber:Ljava/lang/String;

    return-void
.end method

.method public setState(I)V
    .locals 0
    .param p1, "state"    # I

    .prologue
    iput p1, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mState:I

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 3
    .param p1, "out"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    iget v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mId:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mState:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mNumber:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mMultiParty:Z

    if-eqz v0, :cond_0

    move v0, v1

    :goto_0
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-boolean v0, p0, Lcom/lge/bluetooth/hfpclient/LGBluetoothHandsfreeClientCall;->mOutgoing:Z

    if-eqz v0, :cond_1

    :goto_1
    invoke-virtual {p1, v1}, Landroid/os/Parcel;->writeInt(I)V

    return-void

    :cond_0
    move v0, v2

    goto :goto_0

    :cond_1
    move v1, v2

    goto :goto_1
.end method
