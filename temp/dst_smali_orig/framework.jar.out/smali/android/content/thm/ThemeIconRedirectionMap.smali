.class public Landroid/content/thm/ThemeIconRedirectionMap;
.super Ljava/lang/Object;
.source "ThemeIconRedirectionMap.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Landroid/content/thm/ThemeIconRedirectionMap;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public backgroundMap:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field public redirectionMap:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field public targetPackageName:Ljava/lang/String;

.field public themePackageName:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Landroid/content/thm/ThemeIconRedirectionMap$1;

    invoke-direct {v0}, Landroid/content/thm/ThemeIconRedirectionMap$1;-><init>()V

    sput-object v0, Landroid/content/thm/ThemeIconRedirectionMap;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "source"    # Landroid/os/Parcel;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->redirectionMap:Landroid/util/SparseArray;

    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->backgroundMap:Landroid/util/SparseArray;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->themePackageName:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->targetPackageName:Ljava/lang/String;

    iget-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->redirectionMap:Landroid/util/SparseArray;

    invoke-direct {p0, p1, v0}, Landroid/content/thm/ThemeIconRedirectionMap;->readMap(Landroid/os/Parcel;Landroid/util/SparseArray;)V

    iget-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->backgroundMap:Landroid/util/SparseArray;

    invoke-direct {p0, p1, v0}, Landroid/content/thm/ThemeIconRedirectionMap;->readMap(Landroid/os/Parcel;Landroid/util/SparseArray;)V

    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Landroid/content/thm/ThemeIconRedirectionMap$1;)V
    .locals 0
    .param p1, "x0"    # Landroid/os/Parcel;
    .param p2, "x1"    # Landroid/content/thm/ThemeIconRedirectionMap$1;

    .prologue
    invoke-direct {p0, p1}, Landroid/content/thm/ThemeIconRedirectionMap;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "themePackageName"    # Ljava/lang/String;
    .param p2, "targetPackageName"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->redirectionMap:Landroid/util/SparseArray;

    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->backgroundMap:Landroid/util/SparseArray;

    iput-object p1, p0, Landroid/content/thm/ThemeIconRedirectionMap;->themePackageName:Ljava/lang/String;

    iput-object p2, p0, Landroid/content/thm/ThemeIconRedirectionMap;->targetPackageName:Ljava/lang/String;

    return-void
.end method

.method private readMap(Landroid/os/Parcel;Landroid/util/SparseArray;)V
    .locals 5
    .param p1, "source"    # Landroid/os/Parcel;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/os/Parcel;",
            "Landroid/util/SparseArray",
            "<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p2, "map":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/Integer;>;"
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    .local v0, "N":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_0

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v2

    .local v2, "key":I
    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v3

    .local v3, "value":I
    new-instance v4, Ljava/lang/Integer;

    invoke-direct {v4, v3}, Ljava/lang/Integer;-><init>(I)V

    invoke-virtual {p2, v2, v4}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .end local v2    # "key":I
    .end local v3    # "value":I
    :cond_0
    return-void
.end method

.method private writeMap(Landroid/os/Parcel;Landroid/util/SparseArray;)V
    .locals 5
    .param p1, "dest"    # Landroid/os/Parcel;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/os/Parcel;",
            "Landroid/util/SparseArray",
            "<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p2, "map":Landroid/util/SparseArray;, "Landroid/util/SparseArray<Ljava/lang/Integer;>;"
    invoke-virtual {p2}, Landroid/util/SparseArray;->size()I

    move-result v0

    .local v0, "N":I
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_0

    invoke-virtual {p2, v1}, Landroid/util/SparseArray;->keyAt(I)I

    move-result v2

    .local v2, "key":I
    invoke-virtual {p2, v2}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    .local v3, "value":Ljava/lang/Integer;
    invoke-virtual {p1, v2}, Landroid/os/Parcel;->writeInt(I)V

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v4

    invoke-virtual {p1, v4}, Landroid/os/Parcel;->writeInt(I)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .end local v2    # "key":I
    .end local v3    # "value":Ljava/lang/Integer;
    :cond_0
    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "dest"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    iget-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->themePackageName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->targetPackageName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->redirectionMap:Landroid/util/SparseArray;

    invoke-direct {p0, p1, v0}, Landroid/content/thm/ThemeIconRedirectionMap;->writeMap(Landroid/os/Parcel;Landroid/util/SparseArray;)V

    iget-object v0, p0, Landroid/content/thm/ThemeIconRedirectionMap;->backgroundMap:Landroid/util/SparseArray;

    invoke-direct {p0, p1, v0}, Landroid/content/thm/ThemeIconRedirectionMap;->writeMap(Landroid/os/Parcel;Landroid/util/SparseArray;)V

    return-void
.end method
