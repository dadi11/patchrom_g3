.class public Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;
.super Ljava/lang/Object;
.source "LeccpInfo.java"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "PlayRequest"
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private mContents:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mPlayActionType:I

.field private mPosition:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest$1;

    invoke-direct {v0}, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest$1;-><init>()V

    sput-object v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPlayActionType:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mContents:Ljava/util/List;

    iput v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPosition:I

    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPlayActionType:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mContents:Ljava/util/List;

    iput v1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPosition:I

    invoke-direct {p0, p1}, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->readFromParcel(Landroid/os/Parcel;)V

    return-void
.end method

.method private readFromParcel(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPlayActionType:I

    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mContents:Ljava/util/List;

    const-class v1, Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->readList(Ljava/util/List;Ljava/lang/ClassLoader;)V

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPosition:I

    return-void
.end method


# virtual methods
.method public addContentUri(Landroid/net/Uri;)V
    .locals 2
    .param p1, "uri"    # Landroid/net/Uri;

    .prologue
    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mContents:Ljava/util/List;

    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public getActionRequest()Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;

    invoke-direct {v0, p0}, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest;-><init>(Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;)V

    return-object v0
.end method

.method public getContentUris()Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Landroid/net/Uri;",
            ">;"
        }
    .end annotation

    .prologue
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .local v1, "result":Ljava/util/List;, "Ljava/util/List<Landroid/net/Uri;>;"
    iget-object v3, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mContents:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .local v2, "uri":Ljava/lang/String;
    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .end local v2    # "uri":Ljava/lang/String;
    :cond_0
    return-object v1
.end method

.method public getPlayActionType()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPlayActionType:I

    return v0
.end method

.method public getPosition()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPosition:I

    return v0
.end method

.method public setPlayActionType(I)V
    .locals 0
    .param p1, "playActionType"    # I

    .prologue
    iput p1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPlayActionType:I

    return-void
.end method

.method public setPosition(I)V
    .locals 0
    .param p1, "position"    # I

    .prologue
    iput p1, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPosition:I

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPlayActionType:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mContents:Ljava/util/List;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeList(Ljava/util/List;)V

    iget v0, p0, Lcom/lge/systemservice/core/LeccpInfo$ActionRequest$PlayRequest;->mPosition:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    return-void
.end method
