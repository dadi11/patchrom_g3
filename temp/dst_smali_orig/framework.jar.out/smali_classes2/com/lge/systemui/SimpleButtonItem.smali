.class public Lcom/lge/systemui/SimpleButtonItem;
.super Ljava/lang/Object;
.source "SimpleButtonItem.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Lcom/lge/systemui/SimpleButtonItem;",
            ">;"
        }
    .end annotation
.end field

.field public static final DEBUG:Z = true

.field private static final TAG:Ljava/lang/String; = "SimpleButtonItem"


# instance fields
.field public activityName:Ljava/lang/String;

.field public id:I

.field public sequence:I

.field public visible:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Lcom/lge/systemui/SimpleButtonItem$1;

    invoke-direct {v0}, Lcom/lge/systemui/SimpleButtonItem$1;-><init>()V

    sput-object v0, Lcom/lge/systemui/SimpleButtonItem;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;IZ)V
    .locals 0
    .param p1, "id"    # I
    .param p2, "activityName"    # Ljava/lang/String;
    .param p3, "sequence"    # I
    .param p4, "visible"    # Z

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/lge/systemui/SimpleButtonItem;->id:I

    iput-object p2, p0, Lcom/lge/systemui/SimpleButtonItem;->activityName:Ljava/lang/String;

    iput p3, p0, Lcom/lge/systemui/SimpleButtonItem;->sequence:I

    iput-boolean p4, p0, Lcom/lge/systemui/SimpleButtonItem;->visible:Z

    return-void
.end method

.method public static dump(Ljava/util/ArrayList;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/systemui/SimpleButtonItem;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p0, "itemList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/lge/systemui/SimpleButtonItem;>;"
    const-string v2, "SimpleButtonItem"

    const-string v3, "------------------"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "i$":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/systemui/SimpleButtonItem;

    .local v1, "item":Lcom/lge/systemui/SimpleButtonItem;
    const-string v2, "SimpleButtonItem"

    invoke-virtual {v1}, Lcom/lge/systemui/SimpleButtonItem;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v1    # "item":Lcom/lge/systemui/SimpleButtonItem;
    :cond_0
    const-string v2, "SimpleButtonItem"

    const-string v3, "------------------"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .prologue
    const/4 v2, 0x1

    if-eqz p1, :cond_2

    :try_start_0
    move-object v0, p1

    check-cast v0, Lcom/lge/systemui/SimpleButtonItem;

    move-object v1, v0

    .local v1, "other":Lcom/lge/systemui/SimpleButtonItem;
    iget v3, v1, Lcom/lge/systemui/SimpleButtonItem;->id:I

    iget v4, p0, Lcom/lge/systemui/SimpleButtonItem;->id:I

    if-ne v3, v4, :cond_2

    iget v3, v1, Lcom/lge/systemui/SimpleButtonItem;->sequence:I

    iget v4, p0, Lcom/lge/systemui/SimpleButtonItem;->sequence:I

    if-ne v3, v4, :cond_2

    iget-boolean v3, v1, Lcom/lge/systemui/SimpleButtonItem;->visible:Z

    iget-boolean v4, p0, Lcom/lge/systemui/SimpleButtonItem;->visible:Z

    if-ne v3, v4, :cond_2

    iget-object v3, v1, Lcom/lge/systemui/SimpleButtonItem;->activityName:Ljava/lang/String;

    if-nez v3, :cond_1

    iget-object v3, p0, Lcom/lge/systemui/SimpleButtonItem;->activityName:Ljava/lang/String;

    if-nez v3, :cond_1

    .end local v1    # "other":Lcom/lge/systemui/SimpleButtonItem;
    :cond_0
    :goto_0
    return v2

    .restart local v1    # "other":Lcom/lge/systemui/SimpleButtonItem;
    :cond_1
    iget-object v3, v1, Lcom/lge/systemui/SimpleButtonItem;->activityName:Ljava/lang/String;

    if-eqz v3, :cond_2

    iget-object v3, p0, Lcom/lge/systemui/SimpleButtonItem;->activityName:Ljava/lang/String;

    if-eqz v3, :cond_2

    iget-object v3, v1, Lcom/lge/systemui/SimpleButtonItem;->activityName:Ljava/lang/String;

    iget-object v4, p0, Lcom/lge/systemui/SimpleButtonItem;->activityName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    if-nez v3, :cond_0

    .end local v1    # "other":Lcom/lge/systemui/SimpleButtonItem;
    :cond_2
    :goto_1
    const/4 v2, 0x0

    goto :goto_0

    :catch_0
    move-exception v2

    goto :goto_1
.end method

.method public readFromParcel(Landroid/os/Parcel;)V
    .locals 2
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    const/4 v0, 0x1

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Lcom/lge/systemui/SimpleButtonItem;->id:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/systemui/SimpleButtonItem;->activityName:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    iput v1, p0, Lcom/lge/systemui/SimpleButtonItem;->sequence:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    if-ne v1, v0, :cond_0

    :goto_0
    iput-boolean v0, p0, Lcom/lge/systemui/SimpleButtonItem;->visible:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .prologue
    invoke-super {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "toString":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n\tid: ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/lge/systemui/SimpleButtonItem;->id:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]\n\tactivityName: ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/systemui/SimpleButtonItem;->activityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]\n\tsequence: ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/lge/systemui/SimpleButtonItem;->sequence:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]\n\tvisible: ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/systemui/SimpleButtonItem;->visible:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget v0, p0, Lcom/lge/systemui/SimpleButtonItem;->id:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/lge/systemui/SimpleButtonItem;->activityName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget v0, p0, Lcom/lge/systemui/SimpleButtonItem;->sequence:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-boolean v0, p0, Lcom/lge/systemui/SimpleButtonItem;->visible:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
