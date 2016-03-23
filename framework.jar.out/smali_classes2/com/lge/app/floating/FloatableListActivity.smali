.class public abstract Lcom/lge/app/floating/FloatableListActivity;
.super Lcom/lge/app/floating/FloatableActivity;
.source "FloatableListActivity.java"


# instance fields
.field private final idEmpty:I

.field private final idList:I

.field private final layoutListContentSimple:I

.field protected mAdapter:Landroid/widget/ListAdapter;

.field private mFinishedStart:Z

.field private final mHandler:Landroid/os/Handler;

.field protected mList:Landroid/widget/ListView;

.field private final mOnClickListener:Landroid/widget/AdapterView$OnItemClickListener;

.field private final mRequestFocus:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 4

    .prologue
    .line 170
    invoke-direct {p0}, Lcom/lge/app/floating/FloatableActivity;-><init>()V

    .line 28
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mHandler:Landroid/os/Handler;

    .line 29
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mFinishedStart:Z

    .line 31
    new-instance v0, Lcom/lge/app/floating/FloatableListActivity$1;

    invoke-direct {v0, p0}, Lcom/lge/app/floating/FloatableListActivity$1;-><init>(Lcom/lge/app/floating/FloatableListActivity;)V

    iput-object v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mRequestFocus:Ljava/lang/Runnable;

    .line 158
    new-instance v0, Lcom/lge/app/floating/FloatableListActivity$2;

    invoke-direct {v0, p0}, Lcom/lge/app/floating/FloatableListActivity$2;-><init>(Lcom/lge/app/floating/FloatableListActivity;)V

    iput-object v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mOnClickListener:Landroid/widget/AdapterView$OnItemClickListener;

    .line 171
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "empty"

    const-string v2, "id"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/app/floating/FloatableListActivity;->idEmpty:I

    .line 172
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "list"

    const-string v2, "id"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/app/floating/FloatableListActivity;->idList:I

    .line 173
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "list_content_simple"

    const-string v2, "layout"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/app/floating/FloatableListActivity;->layoutListContentSimple:I

    .line 174
    return-void
.end method

.method private ensureList()V
    .locals 1

    .prologue
    .line 151
    iget-object v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    if-eqz v0, :cond_0

    .line 156
    :goto_0
    return-void

    .line 154
    :cond_0
    iget v0, p0, Lcom/lge/app/floating/FloatableListActivity;->layoutListContentSimple:I

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatableListActivity;->setContentView(I)V

    goto :goto_0
.end method


# virtual methods
.method public getListAdapter()Landroid/widget/ListAdapter;
    .locals 1

    .prologue
    .line 147
    iget-object v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mAdapter:Landroid/widget/ListAdapter;

    return-object v0
.end method

.method public getListView()Landroid/widget/ListView;
    .locals 1

    .prologue
    .line 139
    invoke-direct {p0}, Lcom/lge/app/floating/FloatableListActivity;->ensureList()V

    .line 140
    iget-object v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    return-object v0
.end method

.method public getSelectedItemId()J
    .locals 2

    .prologue
    .line 132
    iget-object v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    invoke-virtual {v0}, Landroid/widget/ListView;->getSelectedItemId()J

    move-result-wide v0

    return-wide v0
.end method

.method public getSelectedItemPosition()I
    .locals 1

    .prologue
    .line 125
    iget-object v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    invoke-virtual {v0}, Landroid/widget/ListView;->getSelectedItemPosition()I

    move-result v0

    return v0
.end method

.method public onContentChanged()V
    .locals 3

    .prologue
    .line 81
    invoke-super {p0}, Lcom/lge/app/floating/FloatableActivity;->onContentChanged()V

    .line 82
    iget v1, p0, Lcom/lge/app/floating/FloatableListActivity;->idEmpty:I

    invoke-virtual {p0, v1}, Lcom/lge/app/floating/FloatableListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    .line 83
    .local v0, "emptyView":Landroid/view/View;
    iget v1, p0, Lcom/lge/app/floating/FloatableListActivity;->idList:I

    invoke-virtual {p0, v1}, Lcom/lge/app/floating/FloatableListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ListView;

    iput-object v1, p0, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    .line 84
    iget-object v1, p0, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    if-nez v1, :cond_0

    .line 85
    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "Your content must have a ListView whose id attribute is \'android.R.id.list\'"

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 89
    :cond_0
    if-eqz v0, :cond_1

    .line 90
    iget-object v1, p0, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->setEmptyView(Landroid/view/View;)V

    .line 92
    :cond_1
    iget-object v1, p0, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    iget-object v2, p0, Lcom/lge/app/floating/FloatableListActivity;->mOnClickListener:Landroid/widget/AdapterView$OnItemClickListener;

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    .line 93
    iget-boolean v1, p0, Lcom/lge/app/floating/FloatableListActivity;->mFinishedStart:Z

    if-eqz v1, :cond_2

    .line 94
    iget-object v1, p0, Lcom/lge/app/floating/FloatableListActivity;->mAdapter:Landroid/widget/ListAdapter;

    invoke-virtual {p0, v1}, Lcom/lge/app/floating/FloatableListActivity;->setListAdapter(Landroid/widget/ListAdapter;)V

    .line 96
    :cond_2
    iget-object v1, p0, Lcom/lge/app/floating/FloatableListActivity;->mHandler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/lge/app/floating/FloatableListActivity;->mRequestFocus:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 97
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatableListActivity;->mFinishedStart:Z

    .line 98
    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .prologue
    .line 69
    iget-object v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/lge/app/floating/FloatableListActivity;->mRequestFocus:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 70
    invoke-super {p0}, Lcom/lge/app/floating/FloatableActivity;->onDestroy()V

    .line 71
    return-void
.end method

.method protected onListItemClick(Landroid/widget/ListView;Landroid/view/View;IJ)V
    .locals 0
    .param p1, "l"    # Landroid/widget/ListView;
    .param p2, "v"    # Landroid/view/View;
    .param p3, "position"    # I
    .param p4, "id"    # J

    .prologue
    .line 50
    return-void
.end method

.method protected onRestoreInstanceState(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "state"    # Landroid/os/Bundle;

    .prologue
    .line 60
    invoke-direct {p0}, Lcom/lge/app/floating/FloatableListActivity;->ensureList()V

    .line 61
    invoke-super {p0, p1}, Lcom/lge/app/floating/FloatableActivity;->onRestoreInstanceState(Landroid/os/Bundle;)V

    .line 62
    return-void
.end method

.method public setListAdapter(Landroid/widget/ListAdapter;)V
    .locals 1
    .param p1, "adapter"    # Landroid/widget/ListAdapter;

    .prologue
    .line 104
    monitor-enter p0

    .line 105
    :try_start_0
    invoke-direct {p0}, Lcom/lge/app/floating/FloatableListActivity;->ensureList()V

    .line 106
    iput-object p1, p0, Lcom/lge/app/floating/FloatableListActivity;->mAdapter:Landroid/widget/ListAdapter;

    .line 107
    iget-object v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    invoke-virtual {v0, p1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    .line 108
    monitor-exit p0

    .line 109
    return-void

    .line 108
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public setSelection(I)V
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 118
    iget-object v0, p0, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    invoke-virtual {v0, p1}, Landroid/widget/ListView;->setSelection(I)V

    .line 119
    return-void
.end method
