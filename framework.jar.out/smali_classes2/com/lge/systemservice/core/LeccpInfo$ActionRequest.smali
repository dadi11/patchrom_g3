.class public Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;
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
    name = "ActionRequest"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;,
        Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;,
        Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;,
        Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;,
        Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public actionType:I

.field public connectRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

.field public onRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

.field public openRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

.field public playRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

.field public transferRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 1135
    new-instance v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$1;

    invoke-direct {v0}, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$1;-><init>()V

    sput-object v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v1, 0x0

    .line 1085
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1028
    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1034
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->connectRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    .line 1040
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->playRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    .line 1046
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->transferRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    .line 1052
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->openRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

    .line 1058
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->onRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

    .line 1086
    invoke-direct {p0, p1}, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->readFromParcel(Landroid/os/Parcel;)V

    .line 1087
    return-void
.end method

.method public constructor <init>(Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;)V
    .locals 2
    .param p1, "request"    # Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    .prologue
    const/4 v1, 0x0

    .line 1060
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1028
    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1034
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->connectRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    .line 1040
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->playRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    .line 1046
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->transferRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    .line 1052
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->openRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

    .line 1058
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->onRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

    .line 1061
    const/4 v0, 0x2

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1062
    iput-object p1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->connectRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    .line 1063
    return-void
.end method

.method public constructor <init>(Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;)V
    .locals 2
    .param p1, "request"    # Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

    .prologue
    const/4 v1, 0x0

    .line 1080
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1028
    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1034
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->connectRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    .line 1040
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->playRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    .line 1046
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->transferRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    .line 1052
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->openRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

    .line 1058
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->onRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

    .line 1081
    const/4 v0, 0x4

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1082
    iput-object p1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->onRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

    .line 1083
    return-void
.end method

.method public constructor <init>(Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;)V
    .locals 2
    .param p1, "request"    # Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

    .prologue
    const/4 v1, 0x0

    .line 1075
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1028
    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1034
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->connectRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    .line 1040
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->playRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    .line 1046
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->transferRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    .line 1052
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->openRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

    .line 1058
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->onRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

    .line 1076
    const/4 v0, 0x3

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1077
    iput-object p1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->openRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

    .line 1078
    return-void
.end method

.method public constructor <init>(Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;)V
    .locals 2
    .param p1, "request"    # Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 1065
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1028
    iput v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1034
    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->connectRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    .line 1040
    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->playRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    .line 1046
    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->transferRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    .line 1052
    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->openRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

    .line 1058
    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->onRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

    .line 1066
    iput v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1067
    iput-object p1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->playRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    .line 1068
    return-void
.end method

.method public constructor <init>(Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;)V
    .locals 2
    .param p1, "request"    # Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    .prologue
    const/4 v1, 0x0

    .line 1070
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1028
    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1034
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->connectRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    .line 1040
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->playRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    .line 1046
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->transferRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    .line 1052
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->openRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

    .line 1058
    iput-object v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->onRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

    .line 1071
    const/4 v0, 0x1

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1072
    iput-object p1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->transferRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    .line 1073
    return-void
.end method

.method private readFromParcel(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    .line 1117
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    .line 1118
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    .line 1119
    const-class v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->connectRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    .line 1129
    :cond_0
    :goto_0
    return-void

    .line 1120
    :cond_1
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    if-nez v0, :cond_2

    .line 1121
    const-class v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->playRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    goto :goto_0

    .line 1122
    :cond_2
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    .line 1123
    const-class v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->transferRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    goto :goto_0

    .line 1124
    :cond_3
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_4

    .line 1125
    const-class v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->openRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

    goto :goto_0

    .line 1126
    :cond_4
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    .line 1127
    const-class v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->onRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

    goto :goto_0
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    .line 1091
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 3
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    const/4 v2, 0x1

    .line 1102
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 1103
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    .line 1104
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->connectRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$ConnectRequest;

    invoke-virtual {p1, v0, v2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    .line 1114
    :cond_0
    :goto_0
    return-void

    .line 1105
    :cond_1
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    if-nez v0, :cond_2

    .line 1106
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->playRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;

    invoke-virtual {p1, v0, v2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    goto :goto_0

    .line 1107
    :cond_2
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    if-ne v0, v2, :cond_3

    .line 1108
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->transferRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$TransferRequest;

    invoke-virtual {p1, v0, v2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    goto :goto_0

    .line 1109
    :cond_3
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_4

    .line 1110
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->openRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OpenRequest;

    invoke-virtual {p1, v0, v2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    goto :goto_0

    .line 1111
    :cond_4
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->actionType:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    .line 1112
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;->onRequest:Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$OnRequest;

    invoke-virtual {p1, v0, v2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    goto :goto_0
.end method
