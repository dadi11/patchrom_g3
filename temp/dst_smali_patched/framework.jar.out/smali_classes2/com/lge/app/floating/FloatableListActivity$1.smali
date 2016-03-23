.class Lcom/lge/app/floating/FloatableListActivity$1;
.super Ljava/lang/Object;
.source "FloatableListActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/app/floating/FloatableListActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/app/floating/FloatableListActivity;


# direct methods
.method constructor <init>(Lcom/lge/app/floating/FloatableListActivity;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/app/floating/FloatableListActivity$1;->this$0:Lcom/lge/app/floating/FloatableListActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FloatableListActivity$1;->this$0:Lcom/lge/app/floating/FloatableListActivity;

    iget-object v0, v0, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    iget-object v1, p0, Lcom/lge/app/floating/FloatableListActivity$1;->this$0:Lcom/lge/app/floating/FloatableListActivity;

    iget-object v1, v1, Lcom/lge/app/floating/FloatableListActivity;->mList:Landroid/widget/ListView;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->focusableViewAvailable(Landroid/view/View;)V

    return-void
.end method
