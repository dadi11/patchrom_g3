.class Lcom/lge/database/QueryWrapper$QueryObject;
.super Ljava/lang/Object;
.source "QueryWrapper.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/database/QueryWrapper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "QueryObject"
.end annotation


# instance fields
.field private mChangeCount:J

.field private mMemTableName:Ljava/lang/String;

.field private mQueryStr:Ljava/lang/String;

.field private mSelectionArgs:[Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 2
    .param p1, "mQueryStr"    # Ljava/lang/String;

    .prologue
    .line 744
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 745
    iput-object p1, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mQueryStr:Ljava/lang/String;

    .line 746
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mSelectionArgs:[Ljava/lang/String;

    .line 747
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mChangeCount:J

    .line 748
    const-string v0, ""

    iput-object v0, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mMemTableName:Ljava/lang/String;

    .line 749
    return-void
.end method

.method constructor <init>(Ljava/lang/String;[Ljava/lang/String;)V
    .locals 2
    .param p1, "mQueryStr"    # Ljava/lang/String;
    .param p2, "mSelectionArgs"    # [Ljava/lang/String;

    .prologue
    .line 751
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 752
    iput-object p1, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mQueryStr:Ljava/lang/String;

    .line 753
    iput-object p2, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mSelectionArgs:[Ljava/lang/String;

    .line 754
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mChangeCount:J

    .line 755
    const-string v0, ""

    iput-object v0, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mMemTableName:Ljava/lang/String;

    .line 756
    return-void
.end method


# virtual methods
.method public getChangeCount()J
    .locals 2

    .prologue
    .line 782
    iget-wide v0, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mChangeCount:J

    return-wide v0
.end method

.method public getMemTableName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 773
    iget-object v0, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mMemTableName:Ljava/lang/String;

    return-object v0
.end method

.method public getQuery()Ljava/lang/String;
    .locals 1

    .prologue
    .line 764
    iget-object v0, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mQueryStr:Ljava/lang/String;

    return-object v0
.end method

.method public getSelectionArgs()[Ljava/lang/String;
    .locals 1

    .prologue
    .line 791
    iget-object v0, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mSelectionArgs:[Ljava/lang/String;

    return-object v0
.end method

.method public setChangeCount(J)V
    .locals 1
    .param p1, "count"    # J

    .prologue
    .line 818
    iput-wide p1, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mChangeCount:J

    .line 819
    return-void
.end method

.method public setMemTableName(Ljava/lang/String;)V
    .locals 0
    .param p1, "tableName"    # Ljava/lang/String;

    .prologue
    .line 809
    iput-object p1, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mMemTableName:Ljava/lang/String;

    .line 810
    return-void
.end method

.method public setQuery(Ljava/lang/String;)V
    .locals 0
    .param p1, "query"    # Ljava/lang/String;

    .prologue
    .line 800
    iput-object p1, p0, Lcom/lge/database/QueryWrapper$QueryObject;->mQueryStr:Ljava/lang/String;

    .line 801
    return-void
.end method
