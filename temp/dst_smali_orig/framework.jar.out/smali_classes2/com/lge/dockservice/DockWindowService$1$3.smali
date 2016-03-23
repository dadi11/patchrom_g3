.class Lcom/lge/dockservice/DockWindowService$1$3;
.super Ljava/lang/Object;
.source "DockWindowService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/dockservice/DockWindowService$1;->updateIconImage(Ljava/lang/String;Landroid/graphics/Bitmap;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/lge/dockservice/DockWindowService$1;

.field final synthetic val$icon:Landroid/graphics/Bitmap;

.field final synthetic val$packageName:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/lge/dockservice/DockWindowService$1;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/dockservice/DockWindowService$1$3;->this$1:Lcom/lge/dockservice/DockWindowService$1;

    iput-object p2, p0, Lcom/lge/dockservice/DockWindowService$1$3;->val$packageName:Ljava/lang/String;

    iput-object p3, p0, Lcom/lge/dockservice/DockWindowService$1$3;->val$icon:Landroid/graphics/Bitmap;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$1$3;->this$1:Lcom/lge/dockservice/DockWindowService$1;

    iget-object v1, v1, Lcom/lge/dockservice/DockWindowService$1;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mDockViewList:Ljava/util/Map;
    invoke-static {v1}, Lcom/lge/dockservice/DockWindowService;->access$100(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Map;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$1$3;->val$packageName:Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/dockservice/DockWindowService$DockView;

    .local v0, "targetView":Lcom/lge/dockservice/DockWindowService$DockView;
    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$1$3;->val$icon:Landroid/graphics/Bitmap;

    invoke-virtual {v0, v1}, Lcom/lge/dockservice/DockWindowService$DockView;->updateDockIconImage(Landroid/graphics/Bitmap;)V

    invoke-virtual {v0}, Lcom/lge/dockservice/DockWindowService$DockView;->postInvalidate()V

    return-void
.end method
