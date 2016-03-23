.class public Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;
.super Ljava/lang/Object;
.source "WifiSapOperationModeP.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final mOpModeValue:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP$1;

    invoke-direct {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP$1;-><init>()V

    sput-object v0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;)V
    .locals 0
    .param p1, "opMode"    # Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;->mOpModeValue:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getOpMode()Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;->mOpModeValue:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    return-object v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;->mOpModeValue:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationModeP;->mOpModeValue:Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;

    invoke-virtual {v0}, Lcom/lge/wifi/impl/wifiSap/WifiSapOperationMode;->name()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
