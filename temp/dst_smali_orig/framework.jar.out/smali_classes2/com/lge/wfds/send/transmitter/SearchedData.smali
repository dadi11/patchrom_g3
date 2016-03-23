.class public Lcom/lge/wfds/send/transmitter/SearchedData;
.super Ljava/lang/Object;
.source "SearchedData.java"


# instance fields
.field public device_name:Ljava/lang/String;

.field public device_status:I

.field public mac_addr:Ljava/lang/String;

.field public uuid:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "none"

    iput-object v0, p0, Lcom/lge/wfds/send/transmitter/SearchedData;->uuid:Ljava/lang/String;

    const-string v0, "none"

    iput-object v0, p0, Lcom/lge/wfds/send/transmitter/SearchedData;->mac_addr:Ljava/lang/String;

    const/4 v0, -0x1

    iput v0, p0, Lcom/lge/wfds/send/transmitter/SearchedData;->device_status:I

    const-string v0, "none"

    iput-object v0, p0, Lcom/lge/wfds/send/transmitter/SearchedData;->device_name:Ljava/lang/String;

    return-void
.end method
