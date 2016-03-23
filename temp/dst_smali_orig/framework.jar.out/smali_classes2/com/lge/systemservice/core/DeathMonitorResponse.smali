.class public Lcom/lge/systemservice/core/DeathMonitorResponse;
.super Ljava/lang/Object;
.source "DeathMonitorResponse.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/systemservice/core/DeathMonitorResponse;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field mIntent:Landroid/content/Intent;

.field mPackageName:Ljava/lang/String;

.field mPendingIntent:Landroid/app/PendingIntent;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/systemservice/core/DeathMonitorResponse$1;

    invoke-direct {v0}, Lcom/lge/systemservice/core/DeathMonitorResponse$1;-><init>()V

    sput-object v0, Lcom/lge/systemservice/core/DeathMonitorResponse;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPackageName:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPendingIntent:Landroid/app/PendingIntent;

    iput-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mIntent:Landroid/content/Intent;

    invoke-virtual {p0, p1}, Lcom/lge/systemservice/core/DeathMonitorResponse;->readFromParcel(Landroid/os/Parcel;)V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Landroid/app/PendingIntent;Landroid/content/Intent;)V
    .locals 1
    .param p1, "packageName"    # Ljava/lang/String;
    .param p2, "pendingIntent"    # Landroid/app/PendingIntent;
    .param p3, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPackageName:Ljava/lang/String;

    iput-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPendingIntent:Landroid/app/PendingIntent;

    iput-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mIntent:Landroid/content/Intent;

    iput-object p1, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPackageName:Ljava/lang/String;

    iput-object p2, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPendingIntent:Landroid/app/PendingIntent;

    iput-object p3, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mIntent:Landroid/content/Intent;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getIntent()Landroid/content/Intent;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mIntent:Landroid/content/Intent;

    return-object v0
.end method

.method public getPackageName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPackageName:Ljava/lang/String;

    return-object v0
.end method

.method public getPendingIntent()Landroid/app/PendingIntent;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPendingIntent:Landroid/app/PendingIntent;

    return-object v0
.end method

.method public readFromParcel(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v1, 0x0

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPackageName:Ljava/lang/String;

    invoke-virtual {p1, v1}, Landroid/os/Parcel;->readValue(Ljava/lang/ClassLoader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/PendingIntent;

    iput-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPendingIntent:Landroid/app/PendingIntent;

    invoke-virtual {p1, v1}, Landroid/os/Parcel;->readValue(Ljava/lang/ClassLoader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Intent;

    iput-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mIntent:Landroid/content/Intent;

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "parcel"    # Landroid/os/Parcel;
    .param p2, "arg1"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPackageName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mPendingIntent:Landroid/app/PendingIntent;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeValue(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/lge/systemservice/core/DeathMonitorResponse;->mIntent:Landroid/content/Intent;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeValue(Ljava/lang/Object;)V

    return-void
.end method
